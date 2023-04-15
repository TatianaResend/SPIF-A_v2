classdef app1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        TabGroup                   matlab.ui.container.TabGroup
        ModoManualTab              matlab.ui.container.Tab
        GOButton                   matlab.ui.control.StateButton
        ZcoordinateEditField       matlab.ui.control.NumericEditField
        ZcoordinateEditFieldLabel  matlab.ui.control.Label
        mmLabel_3                  matlab.ui.control.Label
        YcoordinateEditField       matlab.ui.control.NumericEditField
        YcoordinateEditFieldLabel  matlab.ui.control.Label
        mmLabel_2                  matlab.ui.control.Label
        mmLabel                    matlab.ui.control.Label
        XcoordinateEditField       matlab.ui.control.NumericEditField
        XcoordinateEditFieldLabel  matlab.ui.control.Label
        SelectCOMDropDown          matlab.ui.control.DropDown
        SelectCOMDropDownLabel     matlab.ui.control.Label
        ModoAutmticoTab            matlab.ui.container.Tab
        ContextMenu                matlab.ui.container.ContextMenu
        Menu                       matlab.ui.container.Menu
        Menu2                      matlab.ui.container.Menu
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
           disp('App ok')
           return Start = 1;
        end

        % Clicked callback: SelectCOMDropDown
        function SelectCOMDropDownClicked(app, event)
            PortaCOM = event.InteractionInformation.Item;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 640 422];

            % Create ModoManualTab
            app.ModoManualTab = uitab(app.TabGroup);
            app.ModoManualTab.Title = 'Modo Manual';

            % Create SelectCOMDropDownLabel
            app.SelectCOMDropDownLabel = uilabel(app.ModoManualTab);
            app.SelectCOMDropDownLabel.HorizontalAlignment = 'right';
            app.SelectCOMDropDownLabel.Position = [29 345 70 22];
            app.SelectCOMDropDownLabel.Text = 'Select COM';

            % Create SelectCOMDropDown
            app.SelectCOMDropDown = uidropdown(app.ModoManualTab);
            app.SelectCOMDropDown.Items = {'COM1', 'COM2', 'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9'};
            app.SelectCOMDropDown.ClickedFcn = createCallbackFcn(app, @SelectCOMDropDownClicked, true);
            app.SelectCOMDropDown.Position = [114 345 100 22];
            app.SelectCOMDropDown.Value = 'COM1';

            % Create XcoordinateEditFieldLabel
            app.XcoordinateEditFieldLabel = uilabel(app.ModoManualTab);
            app.XcoordinateEditFieldLabel.HorizontalAlignment = 'right';
            app.XcoordinateEditFieldLabel.Position = [46 278 72 22];
            app.XcoordinateEditFieldLabel.Text = 'X coordinate';

            % Create XcoordinateEditField
            app.XcoordinateEditField = uieditfield(app.ModoManualTab, 'numeric');
            app.XcoordinateEditField.Position = [132 278 93 22];

            % Create mmLabel
            app.mmLabel = uilabel(app.ModoManualTab);
            app.mmLabel.Position = [241 278 25 22];
            app.mmLabel.Text = 'mm';

            % Create mmLabel_2
            app.mmLabel_2 = uilabel(app.ModoManualTab);
            app.mmLabel_2.Position = [241 251 25 22];
            app.mmLabel_2.Text = 'mm';

            % Create YcoordinateEditFieldLabel
            app.YcoordinateEditFieldLabel = uilabel(app.ModoManualTab);
            app.YcoordinateEditFieldLabel.HorizontalAlignment = 'right';
            app.YcoordinateEditFieldLabel.Position = [46 251 72 22];
            app.YcoordinateEditFieldLabel.Text = 'Y coordinate';

            % Create YcoordinateEditField
            app.YcoordinateEditField = uieditfield(app.ModoManualTab, 'numeric');
            app.YcoordinateEditField.Position = [132 251 93 22];

            % Create mmLabel_3
            app.mmLabel_3 = uilabel(app.ModoManualTab);
            app.mmLabel_3.Position = [241 223 25 22];
            app.mmLabel_3.Text = 'mm';

            % Create ZcoordinateEditFieldLabel
            app.ZcoordinateEditFieldLabel = uilabel(app.ModoManualTab);
            app.ZcoordinateEditFieldLabel.HorizontalAlignment = 'right';
            app.ZcoordinateEditFieldLabel.Position = [46 223 72 22];
            app.ZcoordinateEditFieldLabel.Text = 'Z coordinate';

            % Create ZcoordinateEditField
            app.ZcoordinateEditField = uieditfield(app.ModoManualTab, 'numeric');
            app.ZcoordinateEditField.Position = [132 223 93 22];

            % Create GOButton
            app.GOButton = uibutton(app.ModoManualTab, 'state');
            app.GOButton.Text = 'GO';
            app.GOButton.Position = [129 175 100 23];

            % Create ModoAutmticoTab
            app.ModoAutmticoTab = uitab(app.TabGroup);
            app.ModoAutmticoTab.Title = 'Modo Autmático';

            % Create ContextMenu
            app.ContextMenu = uicontextmenu(app.UIFigure);

            % Create Menu
            app.Menu = uimenu(app.ContextMenu);
            app.Menu.Text = 'Menu';

            % Create Menu2
            app.Menu2 = uimenu(app.ContextMenu);
            app.Menu2.Text = 'Menu2';
            
            % Assign app.ContextMenu
            app.UIFigure.ContextMenu = app.ContextMenu;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end