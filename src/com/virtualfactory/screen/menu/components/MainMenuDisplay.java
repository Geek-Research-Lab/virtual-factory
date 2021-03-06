/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.virtualfactory.screen.menu.components;

import com.virtualfactory.utils.CommonBuilders;
import com.virtualfactory.utils.Params;
import de.lessvoid.nifty.Nifty;
import de.lessvoid.nifty.builder.ControlBuilder;
import de.lessvoid.nifty.builder.ControlDefinitionBuilder;
import de.lessvoid.nifty.builder.PanelBuilder;
import de.lessvoid.nifty.controls.button.builder.ButtonBuilder;
import de.lessvoid.nifty.controls.label.builder.LabelBuilder;
/**
 *
 * @author David
 */
public class MainMenuDisplay {
    public static final String NAME = "MainMenuDisplay";
    private static CommonBuilders builders = new CommonBuilders();
    
    public static void register(final Nifty nifty) {
        final String buttonsWidth = "25%";
        new ControlDefinitionBuilder(NAME) {{
            controller(new MainMenuController());
            control(new ControlBuilder(DialogPanelControlDefinition.NAME) {{
                
                panel(new PanelBuilder() {{
                    childLayoutHorizontal();
                    control(new LabelBuilder("mainMenu", "Main Menu"){{
                        alignCenter();
                        width("*");
                    }});
                }});
                panel(builders.vspacer());
                panel(new PanelBuilder() {{
                    childLayoutHorizontal();
                    control(new LabelBuilder("userName_MMD"){{
                        width("*");
                        alignCenter();
                        textVAlignCenter();
                        textHAlignCenter();
                    }});
                }});
                panel(builders.vspacer("6%"));
                //                panel(builders.vspacer());
                //                panel(new PanelBuilder() {{
                //                  childLayoutHorizontal();
                //                  control(new ButtonBuilder("saveGameButton_MMD", "Save Game"){{
                //                      width("*");
                //                  }});
                //                }});
                //                panel(builders.vspacer());
                //                panel(new PanelBuilder() {{
                //                  childLayoutHorizontal();
                //                  control(new ButtonBuilder("loadGameButton_MMD", "Load Game"){{
                //                      width("*");
                //                  }});
                //                }});
                panel(builders.vspacer());
                panel(new PanelBuilder() {{
                    childLayoutVertical();
                    width("100%");
                    control(new ButtonBuilder("newGameButton_MMD", "New Game"){{ width(buttonsWidth); alignCenter(); }});
                    panel(builders.vspacer());
                    control(new ButtonBuilder("returnToGameButton_MMD", "Return to Game"){{ width(buttonsWidth); alignCenter(); }});
                    panel(builders.vspacer());
                    control(new ButtonBuilder("controlsButton_MMD", "Controls"){{ width(buttonsWidth); alignCenter(); }});
                    panel(builders.vspacer());
                    //                  control(new ButtonBuilder("optionsButton_MMD", "Game Settings"){{ width(buttonsWidth); alignCenter(); }});
                    if (!Params.SKIP_LOGIN_SCREEN) {
                        control(new ButtonBuilder("editProfileButton_MMD", "Profile"){{ width(buttonsWidth); alignCenter(); }});
                        panel(builders.vspacer());
                    }
                    //                  control(new ButtonBuilder("tutorialButton_MMD", "Tutorial"){{ width(buttonsWidth); alignCenter(); }});
                    //                  panel(builders.vspacer());
                    control(new ButtonBuilder("userManualButton_MMD", "User Manual"){{ width(buttonsWidth); alignCenter(); }});
                    panel(builders.vspacer());
                    control(new ButtonBuilder("creditsButton_MMD", "Credits"){{ width(buttonsWidth); alignCenter(); }});
                    panel(builders.vspacer());
                    if (!Params.SKIP_LOGIN_SCREEN) {
                        control(new ButtonBuilder("switchUserButton_MMD", "Switch User"){{ width(buttonsWidth); alignCenter(); }});
                        panel(builders.vspacer());
                    }
                    control(new ButtonBuilder("quitButton_MMD", "Quit Game"){{ width(buttonsWidth); alignCenter(); }});
                }});
            }});
        }}.registerControlDefintion(nifty);
    }
}
