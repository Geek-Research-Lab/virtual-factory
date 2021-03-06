/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.virtualfactory.threads;

import de.lessvoid.nifty.controls.Label;
import com.virtualfactory.data.D_Activity;
import com.virtualfactory.data.D_AssemblyDetails;
import com.virtualfactory.data.D_Bucket;
import com.virtualfactory.data.D_Catalog;
import com.virtualfactory.data.D_Game;
import com.virtualfactory.data.D_Machine;
import com.virtualfactory.data.D_Operation;
import com.virtualfactory.data.D_Operator;
import com.virtualfactory.data.D_Order;
import com.virtualfactory.data.D_Part;
import com.virtualfactory.data.D_Player;
import com.virtualfactory.data.D_Purchase;
import com.virtualfactory.data.D_Ship;
import com.virtualfactory.data.D_Skill;
import com.virtualfactory.data.D_Station;
import com.virtualfactory.data.D_Supplier;
import com.virtualfactory.data.D_Terrain;
import com.virtualfactory.data.D_TerrainReserved;
import com.virtualfactory.data.D_ToUpdate;
import com.virtualfactory.data.D_TransportStore;
import com.virtualfactory.entity.E_Game;
import com.virtualfactory.entity.E_ToUpdate;
import com.virtualfactory.screen.menu.components.InitialMenuController;
import com.virtualfactory.screen.other.ProgressBarController;
import com.virtualfactory.utils.GameType;
import com.virtualfactory.utils.Params;
import java.util.ArrayList;
import java.util.Map;

/**
 *
 * @author David
 */
public class DataLoading extends Thread {

    private ProgressBarController pbc;
    private Label updatingLabel;
    private InitialMenuController imc;

    public DataLoading() {
    }

    @Override
    public void run() {
        D_ToUpdate toUpdate = new D_ToUpdate();
        pbc.setProgress(0.0f);
        updatingLabel.setText("Validating data...");
        Map<Integer, E_ToUpdate> differenceData = toUpdate.getDifference(toUpdate.SelectSQLite(), toUpdate.Select());
        pbc.setProgress(0.1f);
        if (differenceData.size() > 0) { //requires Update
            Params.percentageQuote = 0.8f / (differenceData.size() * 1.0f);
            for (E_ToUpdate tempToUpdate : differenceData.values()) {
                updatingLabel.setText("Updating " + tempToUpdate.getGameTable().toString() + " data.");
                switch (tempToUpdate.getGameTable()) {
                    case ACTIVITY:
                        new D_Activity().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case ASSEMBLY_DETAILS:
                        new D_AssemblyDetails().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case BUCKET:
                        new D_Bucket().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case CATALOG:
                        new D_Catalog().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case GAME:
                        new D_Game().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case MACHINE:
                        new D_Machine().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case OPERATION:
                        new D_Operation().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case OPERATOR:
                        new D_Operator().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case ORDER:
                        new D_Order().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case PART:
                        new D_Part().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case PLAYER:
                        new D_Player().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case PLAYER_LOG:
                        new D_Player().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case PURCHASE:
                        new D_Purchase().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case SHIP:
                        new D_Ship().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case SKILL:
                        new D_Skill().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case SKILL_ACTIVITY:
                        new D_Skill().updateLocalDB_SkillActivity(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case SKILL_OPERATOR:
                        new D_Skill().updateLocalDB_SkillOperator(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case STATION:
                        new D_Station().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case SUPPLIER:
                        new D_Supplier().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case TERRAIN:
                        new D_Terrain().updateLocalDB(tempToUpdate.getGameTableKey(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case TERRAIN_RESERVED:
                        new D_TerrainReserved().updateLocalDB(tempToUpdate.getGameTableKey(), tempToUpdate.getActionToDo(), pbc);
                        break;
                    case TRANSPORT_STORE:
                        new D_TransportStore().updateLocalDB(tempToUpdate.getIdGame(), tempToUpdate.getActionToDo(), pbc);
                        break;
                }
                toUpdate.insertLocalDB(tempToUpdate);
            }
        } else {
            pbc.setProgress(0.9f);

        }
        //update CPU_Games
        D_Game dGame = new D_Game();
        ArrayList<E_Game> remoteGames = dGame.SelectGames_ByType(GameType.CPU);
        pbc.setProgress(0.925f);
        ArrayList<E_Game> localGames = dGame.SQLite_SelectGames_ByType(GameType.CPU);
        pbc.setProgress(0.95f);
        Params.percentageQuote = 0.05f;
        for (int i = 0; i < remoteGames.size(); i++) {
            if (remoteGames.get(i).getDateTime() > localGames.get(i).getDateTime()) {//update Local Database
                dGame.SQLite_Update(remoteGames.get(i));
            } else if (remoteGames.get(i).getDateTime() < localGames.get(i).getDateTime()) {//update Remote Database
                dGame.Update(localGames.get(i));
            }
            pbc.setProgress(Params.percentageLoading + (i + 1) * Params.percentageQuote / (remoteGames.size() * 1.0f));
        }
        pbc.setProgress(1f);
        //end updating CPU_Games
        if (Params.DEBUG_ON) {
            System.out.println("--------- DATA LOADED----------");
        } else {
            try {
                Thread.sleep(1000);

            } catch (InterruptedException ex) {
                System.out.println("ERROR:" + ex.getMessage());
            }
        }
        imc.closePopupLoading(true);
    }

    public InitialMenuController getImc() {
        return imc;
    }

    public void setImc(InitialMenuController imc) {
        this.imc = imc;
    }

    public Label getUpdatingLabel() {
        return updatingLabel;
    }

    public void setUpdatingLabel(Label updatingLabel) {
        this.updatingLabel = updatingLabel;
    }

    public ProgressBarController getPbc() {
        return pbc;
    }

    public void setPbc(ProgressBarController pbc) {
        this.pbc = pbc;
    }
}
