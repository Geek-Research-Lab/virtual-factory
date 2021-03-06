package com.virtualfactory.screen.menu.components;

import com.virtualfactory.screen.menu.MenuScreenController;
import de.lessvoid.nifty.Nifty;
import de.lessvoid.nifty.NiftyEventSubscriber;
import de.lessvoid.nifty.controls.Button;
import de.lessvoid.nifty.controls.ButtonClickedEvent;
import de.lessvoid.nifty.controls.Controller;
import de.lessvoid.nifty.effects.EffectEventId;
import de.lessvoid.nifty.elements.Element;
import de.lessvoid.nifty.input.NiftyInputEvent;
import de.lessvoid.nifty.screen.Screen;
import de.lessvoid.xml.xpp3.Attributes;
import com.virtualfactory.engine.GameEngine;
import java.util.Properties;
/**
 *
 * @author Pepe
 */
public class ControlsController implements Controller {
    private Screen screen;
    private GameEngine gameEngine;
    private Nifty nifty;
    private Button returnToMenuButton;

    
    @Override
    public void bind(
        final Nifty nifty,
        final Screen screen,
        final Element element,
        final Properties parameter,
        final Attributes controlDefinitionAttributes) {
        this.screen = screen;
        this.nifty = nifty;
        this.returnToMenuButton = this.screen.findNiftyControl("returnToMenu_FYP", Button.class);
        this.gameEngine = ((MenuScreenController)this.screen.getScreenController()).getGameEngine();
    }
    
    @Override
    public void init(final Properties parameter, final Attributes controlDefinitionAttributes) {
        updateControls();
    }

    @Override
    public void onStartScreen() {
    }

    @Override
    public void onFocus(final boolean getFocus) {
    }

    @Override
    public boolean inputEvent(final NiftyInputEvent inputEvent) {
        return false;
    }
    
    protected void updateControls(){
        this.returnToMenuButton.enable();
    }
    
    @NiftyEventSubscriber(id="returnToMenu_FYP")
    public void onReturnToMenuFYPClicked(final String id, final ButtonClickedEvent event) {
        switchToMainMenu(); 
    }
    
    private void switchToMainMenu(){
        Element nextElement = screen.findElementByName("dialogMainMenu");
        MainMenuController mainMenu = nextElement.getControl(MainMenuController.class);
        mainMenu.updateControls();
        nextElement.show();
        Element currentElement = screen.findElementByName("dialogControlsMenu");
        currentElement.hide();
        screen.findElementByName("dialogControlsMenu").stopEffect(EffectEventId.onCustom);
        screen.findElementByName("dialogMainMenu").startEffect(EffectEventId.onCustom, null, "selected");
    }
}
