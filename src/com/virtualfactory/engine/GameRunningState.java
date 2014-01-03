package com.virtualfactory.engine;

import com.virtualfactory.utils.Sensor;
import com.jme3.app.Application;
import com.jme3.app.SimpleApplication;
import com.jme3.app.state.AbstractAppState;
import com.jme3.app.state.AppStateManager;
import com.jme3.asset.AssetManager;
import com.jme3.audio.AudioNode;
import com.jme3.bullet.BulletAppState;
import com.jme3.bullet.collision.shapes.CapsuleCollisionShape;
import com.jme3.bullet.control.CharacterControl;
import com.jme3.bullet.control.RigidBodyControl;
import com.jme3.input.FlyByCamera;
import com.jme3.input.InputManager;
import com.jme3.input.KeyInput;
import com.jme3.input.controls.ActionListener;
import com.jme3.input.controls.KeyTrigger;
import com.jme3.light.AmbientLight;
import com.jme3.light.PointLight;
import com.jme3.post.filters.PosterizationFilter;
import com.jme3.math.ColorRGBA;
import com.jme3.math.Matrix3f;
import com.jme3.math.Quaternion;
import com.jme3.math.Vector3f;
import com.jme3.post.FilterPostProcessor;
import com.jme3.post.filters.FadeFilter;
import com.jme3.renderer.Camera;
import com.jme3.renderer.ViewPort;
import com.jme3.scene.Geometry;
import com.jme3.scene.Node;
import com.jme3.scene.Spatial;
import com.jme3.texture.Texture;
import com.jme3.util.SkyFactory;
import com.virtualfactory.narrator.Narrator;
import com.virtualfactory.utils.InvisibleWall;
import com.virtualfactory.utils.Params;
import java.util.HashMap;


/**
 * This is an app state (http://hub.jmonkeyengine.org/wiki/doku.php/jme3:advanced:application_states).
 * 
 * When this state is attached by the game engine (see the loadElementsToDisplay() method), initialize() will 
 * create and animate the factory , and update() keeps track of player movement.
 * 
 * @author Abner Coimbre
 */
public class GameRunningState extends AbstractAppState
{
    private SimpleApplication app;
    private AssetManager assetManager;
    private InputManager inputManager;
    private Node rootNode;
    private Camera cam;
    private FlyByCamera flyCam;  
    
    private boolean moveForward;
    private boolean moveBackward;
    private boolean moveLeft;
    private boolean moveRight;
    private boolean lookUp;
    private boolean lookDown;
    private boolean lookLeft;
    private boolean lookRight;
    
    private boolean isDebugCamEnabled;
    private boolean isTopViewEnabled;
    private boolean isLightingEnabled;
    
    private boolean isPlayerUpstairs = true;       
    private float playerSpeed = 1.3f;
    
    private Vector3f camDir;
    private Vector3f camLeft;
    private Vector3f walkDirection = new Vector3f(0, 0, 0);
    
    private FilterPostProcessor fpp;
    private FadeFilter fadeFilter;
    private ViewPort viewPort;
    private Node factory;
    
    private final BulletAppState bulletAppState;
    private CharacterControl player;
    
    private PointLight lamp1;
    private PointLight lamp2;
    private int viewNumber;
    
    private Narrator gameNarrator;
    
    private HashMap<String, Sensor> factorySensors;
    private AmbientLight ambient;
    
    public GameRunningState(BulletAppState bulletAppState)
    {
        this.bulletAppState = bulletAppState;
    }

    @Override
    public void initialize(AppStateManager stateManager, Application app)
    {
        super.initialize(stateManager, app);
        
        this.app = (SimpleApplication) app;
        this.assetManager = this.app.getAssetManager();
        this.inputManager = this.app.getInputManager();
        this.viewPort = this.app.getViewPort();
        this.rootNode = this.app.getRootNode();
        this.flyCam = this.app.getFlyByCamera();
        this.cam = this.app.getCamera();
        
        createFactory();
        
        loadPlayerKeyControls();
        
        gameNarrator = new Narrator(stateManager, assetManager, this.app.getGuiNode());
    }
    
    private void createFactory() 
    {
        fpp = new FilterPostProcessor(assetManager);
        fadeFilter = new FadeFilter(1.5f);
        fpp.addFilter(fadeFilter);
        viewPort.addProcessor(fpp);

        flyCam.setMoveSpeed(100);

        /* Factory */
        // ----------
        factory = (Node) assetManager.loadModel("Models/factory.j3o");
        factory.setLocalScale(250.0f, 250.0f, 250.0f);
        factory.setLocalTranslation(-9.0f, 0.0f, 82.0f);
        rootNode.attachChild(factory);
        RigidBodyControl rigidBody = new RigidBodyControl(0);
        factory.addControl(rigidBody);
        bulletAppState.getPhysicsSpace().add(rigidBody);
        // ----------
        
        Node grass = (Node) assetManager.loadModel("Models/grass.j3o");
        grass.setLocalScale(250.0f, 250.0f, 250.0f);
        grass.setLocalTranslation(-9.0f, 0.0f, 82.0f);
        rootNode.attachChild(grass);
        
        createSkyBox();
        
        createLighting();
        
        createInvisibleWalls();
        
        createSensors();
        
        /* First-person Player */
        // ----------
        player = new CharacterControl(new CapsuleCollisionShape(0.4f, 24.5f, 1), 0.05f);
        player.setJumpSpeed(45);
        player.setFallSpeed(120);
        player.setGravity(Params.playerGravity);
        player.setPhysicsLocation(new Vector3f(51.68367f, 59.064148f, -292.67755f));
        cam.setRotation(new Quaternion(0.07086334f, -0.01954512f, 0.0019515193f, 0.99729264f));
        flyCam.setRotationSpeed(1.9499999f);
        player.setViewDirection(new Vector3f(0, 0, 1));
        bulletAppState.getPhysicsSpace().add(player);
        // ----------
    }

    private void loadPlayerKeyControls()
    {
        String[] mappings = {"move forward", "move backward",
                             "move left", "move right",
                             "look up", "look down",
                             "look left", "look right",
                             "toggle top view", "debug cam",
                             "debug position"};

        KeyTrigger[] triggers = {new KeyTrigger(KeyInput.KEY_W), new KeyTrigger(KeyInput.KEY_S),
                                 new KeyTrigger(KeyInput.KEY_A), new KeyTrigger(KeyInput.KEY_D),
                                 new KeyTrigger(KeyInput.KEY_UP), new KeyTrigger(KeyInput.KEY_DOWN),
                                 new KeyTrigger(KeyInput.KEY_LEFT), new KeyTrigger(KeyInput.KEY_RIGHT),
                                 new KeyTrigger(KeyInput.KEY_T), new KeyTrigger(KeyInput.KEY_0),
                                 new KeyTrigger(KeyInput.KEY_P)};

        for (int i = 0; i < mappings.length; i++)
        {
            inputManager.addMapping(mappings[i], triggers[i]);
            inputManager.addListener(actionListener, mappings[i]);
        }

    }

    private ActionListener actionListener = new ActionListener() {
        @Override
        public void onAction(String name, boolean isKeyPressed, float tpf)
        {
            switch (name)
            {
                case "move forward":
                    moveForward = isKeyPressed;
                    break;

                case "move backward":
                    moveBackward = isKeyPressed;
                    break;

                case "move left":
                    moveLeft = isKeyPressed;
                    break;

                case "move right":
                    moveRight = isKeyPressed;
                    break;

                case "look up":
                    lookUp = isKeyPressed;
                    break;

                case "look down":
                    lookDown = isKeyPressed;
                    break;

                case "look left":
                    lookLeft = isKeyPressed;
                    break;

                case "look right":
                    lookRight = isKeyPressed;
                    break;
                    
                case "toggle top view":
                    if (!isKeyPressed && isPlayerUpstairs)
                        toggleTopView();
                    break;

                case "debug cam":
                    if (!isKeyPressed)
                        isDebugCamEnabled = !isDebugCamEnabled;
                    break;
                    
                case "debug position":
                    if (!isKeyPressed)
                        System.out.println(""
                                + "\n\nlocation: " + cam.getLocation()
                                + "\nleft: " + cam.getLeft()
                                + "\nup: " + cam.getUp()
                                + "\ndirection: " + cam.getDirection());
                    break;

                default:
                    break;
            }
        }
    };
    
    @Override
    public void update(float tpf) {
        updatePlayerPosition();
    }
    
    public void updatePlayerPosition() {
        /*
        if (!isLevelStarted)
            return; */

        if (factorySensors.get("top stairs").isPlayerInRange() || factorySensors.get("bottom stairs").isPlayerInRange())
            handleTransition();

        if (lookUp)
            rotateCamera(-Params.rotationSpeed, cam.getLeft());

        if (lookDown)
            rotateCamera(Params.rotationSpeed, cam.getLeft());

        if (lookLeft)
            rotateCamera(Params.rotationSpeed, new Vector3f(0,1,0));

        if (lookRight)
            rotateCamera(-Params.rotationSpeed, new Vector3f(0,1,0));

        if (isTopViewEnabled || isDebugCamEnabled) {
            if (fadeFilter.getValue() <= 0) {
                fadeFilter.fadeIn();
                // TODO: Change the ambient color
            }
            return;
        }

        camDir = cam.getDirection().clone().multLocal(playerSpeed);
        camLeft = cam.getLeft().clone().multLocal(playerSpeed);

        walkDirection.set(0, 0, 0); // reset walkDirection vector

        if (moveForward)
            walkDirection.addLocal(camDir);

        if (moveBackward)
            walkDirection.addLocal(camDir.negate());

        if (moveLeft)
            walkDirection.addLocal(camLeft);

        if (moveRight)
            walkDirection.addLocal(camLeft.negate());

        player.setWalkDirection(walkDirection); // walk!
        cam.setLocation(player.getPhysicsLocation());
        
        if (isPlayerUpstairs && player.getPhysicsLocation().getY() < 58.0f)
            player.warp(new Vector3f(player.getPhysicsLocation().getX(), 58.0f, player.getPhysicsLocation().getZ()));
        else if (player.getPhysicsLocation().getY() < 12.65f)
            player.warp(new Vector3f(player.getPhysicsLocation().getX(), 12.65f, player.getPhysicsLocation().getZ()));
    }
    
    private void handleTransition() {
        if (fadeFilter.getDuration() < 1.5f)
            fadeFilter.setDuration(1.5f);
        
        isPlayerUpstairs = factorySensors.get("top stairs").isPlayerInRange();
        
        boolean isFadeEffectStarted = fadeFilter.getValue() < 1;

        if (!isFadeEffectStarted) {
            playerSpeed = 0;
            fadeFilter.fadeOut();

            AudioNode footsteps;
            footsteps = new AudioNode(assetManager, isPlayerUpstairs ? "Sounds/footsteps1.wav" : "Sounds/footsteps2.wav", false);
            footsteps.setPositional(false);
            footsteps.play();
        }

        boolean isFadeEffectFinished = fadeFilter.getValue() <= 0;

        if (isFadeEffectFinished) {
            if (isPlayerUpstairs) {
                player.warp(new Vector3f(121.2937f, 12.65f, -309.41315f));
                cam.setRotation(new Quaternion(0.04508071f, -0.4710204f, 0.02474963f, 0.8806219f));
                isPlayerUpstairs = false;
            }
            else {
                player.setPhysicsLocation(new Vector3f(51.68367f, 59.064148f, -292.67755f));
                cam.setRotation(new Quaternion(0.07086334f, -0.01954512f, 0.0019515193f, 0.99729264f));
                gameNarrator.talk("Second Floor.\nPress 'T' for a top view of the factory.", "Sounds/Narrator/instructions.wav");
                isPlayerUpstairs = true;
            }
            fadeFilter.fadeIn();
            playerSpeed = 1.3f;
        }
    }

    private void createSkyBox() {
        String path = "Textures/Skybox/";
        
        Texture west = assetManager.loadTexture(path + "skyLeft.jpg");
        Texture east = assetManager.loadTexture(path + "skyRight.jpg");
        Texture north = assetManager.loadTexture(path + "skyFront.jpg");
        Texture south = assetManager.loadTexture(path + "skyBack.jpg");
        Texture top = assetManager.loadTexture(path + "skyTop.jpg");
        Texture bottom = assetManager.loadTexture(path + "skyDown.jpg");
        
        Spatial skyBox = SkyFactory.createSky(assetManager, west, east, north, 
                                                            south, top, bottom);
        
        rootNode.attachChild(skyBox);
    }

    private void createLighting() {
        if (isLightingEnabled)
            return;
        
        isLightingEnabled = true;
        ColorRGBA color = ColorRGBA.White;
        lamp1 = new PointLight();
        lamp1.setPosition(new Vector3f(40, 200, 150));
        lamp1.setColor(color);
        lamp1.setRadius(lamp1.getRadius()/20);
        rootNode.addLight(lamp1);

        lamp2 = new PointLight();
        lamp2.setPosition(new Vector3f(43.50383f, 80.081642f, -310.90753f));
        lamp2.setColor(color);
        lamp2.setRadius(lamp1.getRadius());
        rootNode.addLight(lamp2);
        
        /* Atmosphere */
        ambient = new AmbientLight();
        ambient.setColor(ColorRGBA.DarkGray.mult(1.8f));
        rootNode.addLight(ambient);
    }

    private void createInvisibleWalls() {
        String[] wallNames = {"bottom right wall", 
                              "bottom left wall", 
                              "bottom front wall",
                              "bottom back wall", 
                              "upper right wall", 
                              "upper left wall",
                              "upper front wall", 
                              "upper back wall"};
        
        Vector3f[] sizes = {new Vector3f(0.6f, 0.6f, 23.600018f),
                            new Vector3f(1.4000001f, 0.6f, 23.600018f),
                            new Vector3f(9.399996f, 1.0f, 1.0f),
                            new Vector3f(9.399996f, 1.0f, 0.6f),
                            new Vector3f(0.40000004f, 1.0f, 3.4000006f),
                            new Vector3f(0.40000004f, 1.0f, 3.0000005f),
                            new Vector3f(7.599997f, 1.0f, 0.20000003f),
                            new Vector3f(9.599996f, 1.0f, 0.40000004f)};
        
        Vector3f[] locations = {new Vector3f(-37.600044f, 5.850006f, -117.43932f),
                                new Vector3f(137.1993f, 5.850006f, -117.43932f),
                                new Vector3f(50.80012f, 9.999995f, 106.9995f),
                                new Vector3f(50.60012f, 9.999995f, -346.80283f),
                                new Vector3f(-40.543167f, 56.8007f, -318.2905f),
                                new Vector3f(140.85591f, 56.8007f, -322.69077f),
                                new Vector3f(31.656963f, 56.8007f, -289.88876f),
                                new Vector3f(50.433777f, 56.38947f, -350.81924f)};
        
        for (int i = 0; i < wallNames.length; i++)
        {
            Geometry invisibleWall = new InvisibleWall(bulletAppState, sizes[i], locations[i]);
            invisibleWall.setName(wallNames[i]);
            rootNode.attachChild(invisibleWall);
        }
    }
    
    private void createSensors()
    {
        String[] sensorNames = {"top stairs", "bottom stairs"};
        
        Vector3f[] sensorSizes = {new Vector3f(15, 10, 5), new Vector3f(15, 10, 5)};
        
        Vector3f[] sensorLocations = {new Vector3f(134.05f, 59.06f, -285.02f), new Vector3f(107.42f, 12.67f, -284.9f)};
        
        factorySensors = new HashMap<>();
        
        for (int i = 0; i < sensorNames.length; i++)
            factorySensors.put(sensorNames[i], new Sensor(sensorSizes[i], sensorLocations[i], bulletAppState));
    }

    private void rotateCamera(float value, Vector3f axis) 
    {
        Matrix3f mat = new Matrix3f();

        if (isTopViewEnabled)
            value = value * 0.3f;

        mat.fromAngleNormalAxis(flyCam.getRotationSpeed() * value, axis);

        Vector3f tempUp = cam.getUp();
        Vector3f tempLeft = cam.getLeft();
        Vector3f tempDir = cam.getDirection();

        mat.mult(tempUp, tempUp);
        mat.mult(tempLeft, tempLeft);
        mat.mult(tempDir, tempDir);

        if (tempDir.getX() > Params.camMaxX || tempDir.getX() < Params.camMinX
                || tempDir.getY() > Params.camMaxY || tempDir.getY() < Params.camMinY
                || tempDir.getZ() > Params.camMaxZ || tempDir.getZ() < Params.camMinZ)
            return;

        Quaternion q = new Quaternion();
        q.fromAxes(tempLeft, tempUp, tempDir);
        q.normalizeLocal();

        cam.setAxes(q);
    }
    
    private void toggleTopView() 
    {
        if (Params.topViewAvailable && viewNumber != 5) {
            isTopViewEnabled = true;
            
            if (fadeFilter.getDuration() > 0.25f)
                fadeFilter.setDuration(0.25f);
            
            if (viewNumber != 0)
                fadeFilter.fadeOut();  
            
            AudioNode camera;
            camera = new AudioNode(assetManager, "Sounds/camera.wav", false);
            camera.setPositional(false);
            camera.setPitch(1.3f);
            camera.play();
            
            switch(viewNumber) {
                case 0:
                    changeOutsideWorldColor(ColorRGBA.Brown);
                    changeLampColor(ColorRGBA.Brown);
                    Params.camAxesLeft = cam.getLeft();
                    Params.camAxesUp = cam.getUp();
                    Params.camAxesDir = cam.getDirection();
                    Params.flyCamRotationSpeed = flyCam.getRotationSpeed();

                    cam.setLocation(new Vector3f(210.75597f, 191.22467f, -111.45984f));
                    cam.setAxes(new Vector3f(0.006238699f, 0.0011283755f, 0.9999799f),
                            new Vector3f(-0.7573153f, 0.6530373f, 0.0039878786f),
                            new Vector3f(-0.6530197f, -0.75732493f, 0.004928589f));
                    break;

                case 1:
                    changeOutsideWorldColor(ColorRGBA.DarkGray);
                    changeLampColor(ColorRGBA.DarkGray);
                    
                    Params.camMaxY = Params.securityCamsMaxY;
                    Params.camMinY = Params.securityCamsMinY;
                    Params.camMaxX = Params.cam1MaxX;
                    Params.camMinX = Params.cam1MinX;
//                    Params.camMaxZ = Params.cam1MaxX;
//                    Params.camMinZ = Params.cam1MinX;
                    cam.setLocation(new Vector3f(138.94714f, 74.204185f, -118.346085f));
                    cam.setAxes(new Vector3f(-0.004745364f, 0.0011234581f, 0.99998814f),
                            new Vector3f(-0.69315696f, 0.720775f, -0.0040991306f),
                            new Vector3f(-0.720771f, -0.69316816f, -0.0026416779f));
                    break;

                case 2:
                    changeOutsideWorldColor(ColorRGBA.Magenta);
                    changeLampColor(ColorRGBA.Magenta);
                    
                    Params.camMaxX = Params.playerMaxX;
                    Params.camMinX = Params.playerMinX;
                    Params.camMaxZ = 0;
                    Params.camMinZ = -100;
                    cam.setLocation(new Vector3f(50.173473f, 78.43454f, 112.47995f));
                    cam.setAxes(new Vector3f(-0.9999976f, 0.0011224343f, 0.0018219932f),
                            new Vector3f(0f, 0.8618528f, -0.5071584f),
                            new Vector3f(-0.002139542f, -0.5071572f, -0.86185086f));
                    break;

                case 3:
                    changeOutsideWorldColor(ColorRGBA.Orange);
                    changeLampColor(ColorRGBA.Orange);
                    
                    Params.camMaxX = 100f;
                    Params.camMinX = 0f;
                    Params.camMaxZ = Params.playerMaxZ;
                    Params.camMinZ = Params.playerMinZ;
                    cam.setLocation(new Vector3f(-37.94872f, 71.8763f, -118.55907f));
                    cam.setAxes(new Vector3f(-0.0045000315f, 0.0011213869f, -0.9999892f),
                            new Vector3f(0.4902432f, 0.8715848f, -0.0012287796f),
                            new Vector3f(0.871574f, -0.49024346f, -0.004471898f));
                    break;

                case 4:
                    changeOutsideWorldColor(ColorRGBA.Pink);
                    changeLampColor(ColorRGBA.Pink);
                    
                    Params.camMaxX = Params.playerMaxX;
                    Params.camMinX = Params.playerMinX;
                    Params.camMaxZ = 100f;
                    Params.camMinZ = 0f;
                    cam.setLocation(new Vector3f(54.01033f, 79.31754f, -347.24677f));
                    cam.setAxes(new Vector3f(0.99922884f, 0.0011243783f, 0.039248988f),
                            new Vector3f(-0.019561216f, 0.8809709f, 0.47276595f),
                            new Vector3f(-0.034045644f, -0.47316912f, 0.8803135f));
                    break;
            }

            viewNumber = (viewNumber + 1) % 6;
            flyCam.setMoveSpeed(0);
//            flyCam.setRotationSpeed(0);
            factory.getChild("Beams-Metal").setCullHint(Spatial.CullHint.Always);

        }
        else if (Params.topViewAvailable && isTopViewEnabled) {
            changeOutsideWorldColor(ColorRGBA.DarkGray);
            lamp1.setColor(ColorRGBA.White);
            lamp2.setColor(ColorRGBA.White);
            isTopViewEnabled = false;
            cam.setAxes(Params.camAxesLeft, Params.camAxesUp, Params.camAxesDir);
            flyCam.setMoveSpeed(100);
            flyCam.setRotationSpeed(Params.flyCamRotationSpeed);
            factory.getChild("Beams-Metal").setCullHint(Spatial.CullHint.Never);
            viewNumber = (viewNumber + 1)%6;
            Params.camMaxX = Params.playerMaxX;
            Params.camMinX = Params.playerMinX;
            Params.camMaxY = Params.playerMaxY;
            Params.camMinY = Params.playerMinY;
            Params.camMaxZ = Params.playerMaxZ;
            Params.camMinZ = Params.playerMinZ;
        }
    }
    
    public void changeOutsideWorldColor(ColorRGBA color) 
    {
        ambient.setColor(color.mult(3f));
    }
    
    public void changeLampColor(ColorRGBA color)
    {
        lamp1.setColor(color);
        lamp2.setColor(color);
    }
    
    public boolean isTopViewEnabled()
    {
        return isTopViewEnabled;
    }
    
    public void setTopViewEnabled(boolean enabled)
    {
        isTopViewEnabled = enabled;
    }
    
    public int getViewNumber() 
    {
        return viewNumber;
    }
    
    public void setViewNumber(int number)
    {
        viewNumber = number;
    }
}