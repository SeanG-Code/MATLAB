classdef uavDataPlotter < handle
    properties
        % System properties
        d

        % History variables to store data
        time_history
        state_history
        estim_history
        refer_history
        model_history
        input_history

        % Flags to indicate what is to be plotted
        plot_state
        plot_input
        plot_reference
        plot_estimate
        plot_model

        % Handle to plots for fast updating
        handles 
        figure_handles

        % Index for the current timestep in the history variables (vectors)
        index
    end
    methods
        function self = uavDataPlotter(Param)
            % System properties
            self.d = Param.d;

            % Save Settings
            self.plot_state            = Param.plot_state;
            self.plot_input            = Param.plot_input;
            self.plot_reference        = Param.plot_reference;
            self.plot_estimate         = Param.plot_estimate;
            self.plot_model            = Param.plot_model;

            % Initilize the history vectors
            self.time_history  = NaN(1,  ceil((Param.t_end-Param.t_start)/Param.t_plot));
            self.state_history = NaN(6,  ceil((Param.t_end-Param.t_start)/Param.t_plot));
            self.estim_history = NaN(6,  ceil((Param.t_end-Param.t_start)/Param.t_plot));
            self.refer_history = NaN(6,  ceil((Param.t_end-Param.t_start)/Param.t_plot));
            self.model_history = NaN(6,  ceil((Param.t_end-Param.t_start)/Param.t_plot));
            self.input_history = NaN(4,  ceil((Param.t_end-Param.t_start)/Param.t_plot));
            self.index = 1;

            % State
            if self.plot_state
                self.figure_handles(1) = figure('Windowstyle','docked','name','State');
                    clf;
                    sgtitle('State')
                    subplot(6,1,1)
                        hold on;
                        grid on;
                        if self.plot_reference; self.handles(1) = plot(self.time_history, self.refer_history(1,:), '-g', "DisplayName", "Reference",'LineWidth',Param.line_width); end
                        if self.plot_model;     self.handles(2) = plot(self.time_history, self.model_history(1,:), '-b', "DisplayName", "Model",    'LineWidth',Param.line_width); end
                        if self.plot_estimate;  self.handles(3) = plot(self.time_history, self.estim_history(1,:), '-r', "DisplayName", "Estimate", 'LineWidth',Param.line_width); end
                                                self.handles(4) = plot(self.time_history, self.state_history(1,:), '-k', "DisplayName", "State",    'LineWidth',Param.line_width);
                        ylabel("$h$ (m)","Interpreter","latex")
                    subplot(6,1,2)
                        hold on;
                        grid on;
                        if self.plot_reference; self.handles(5) = plot(self.time_history, self.refer_history(2,:), '-g', "DisplayName", "Reference",'LineWidth',Param.line_width); end
                        if self.plot_model;     self.handles(6) = plot(self.time_history, self.model_history(2,:), '-b', "DisplayName", "Model",    'LineWidth',Param.line_width); end
                        if self.plot_estimate;  self.handles(7) = plot(self.time_history, self.estim_history(2,:), '-r', "DisplayName", "Estimate", 'LineWidth',Param.line_width); end
                                                self.handles(8) = plot(self.time_history, self.state_history(2,:), '-k', "DisplayName", "State",    'LineWidth',Param.line_width);
                        ylabel("$z$ (m)","Interpreter","latex")
                    subplot(6,1,3)
                        hold on;
                        grid on;
                        if self.plot_reference; self.handles(9)  = plot(self.time_history, self.refer_history(3,:), '-g', "DisplayName", "Reference",'LineWidth',Param.line_width); end
                        if self.plot_model;     self.handles(10) = plot(self.time_history, self.model_history(3,:), '-b', "DisplayName", "Model",    'LineWidth',Param.line_width); end
                        if self.plot_estimate;  self.handles(11) = plot(self.time_history, self.estim_history(3,:), '-r', "DisplayName", "Estimate", 'LineWidth',Param.line_width); end
                                                self.handles(12) = plot(self.time_history, self.state_history(3,:), '-k', "DisplayName", "State",    'LineWidth',Param.line_width);
                        ylabel("$\theta$ (deg)","Interpreter","latex")
                    subplot(6,1,4)
                        hold on;
                        grid on;
                        if self.plot_reference; self.handles(13) = plot(self.time_history, self.refer_history(4,:), '-g', "DisplayName", "Reference",'LineWidth',Param.line_width); end
                        if self.plot_model;     self.handles(14) = plot(self.time_history, self.model_history(4,:), '-b', "DisplayName", "Model",    'LineWidth',Param.line_width); end
                        if self.plot_estimate;  self.handles(15) = plot(self.time_history, self.estim_history(4,:), '-r', "DisplayName", "Estimate", 'LineWidth',Param.line_width); end
                                                self.handles(16) = plot(self.time_history, self.state_history(4,:), '-k', "DisplayName", "State",    'LineWidth',Param.line_width);
                        ylabel("$\dot{h}$ (m/s)","Interpreter","latex")
                    subplot(6,1,5)
                        hold on;
                        grid on;
                        if self.plot_reference; self.handles(17) = plot(self.time_history, self.refer_history(5,:), '-g', "DisplayName", "Reference",'LineWidth',Param.line_width); end
                        if self.plot_model;     self.handles(18) = plot(self.time_history, self.model_history(5,:), '-b', "DisplayName", "Model",    'LineWidth',Param.line_width); end
                        if self.plot_estimate;  self.handles(19) = plot(self.time_history, self.estim_history(5,:), '-r', "DisplayName", "Estimate", 'LineWidth',Param.line_width); end
                                                self.handles(20) = plot(self.time_history, self.state_history(5,:), '-k', "DisplayName", "State",    'LineWidth',Param.line_width);
                        ylabel("$\dot{z}$ (m/s)","Interpreter","latex")
                    ax = subplot(6,1,6);
                        hold on;
                        grid on;
                        if self.plot_reference; self.handles(21) = plot(self.time_history, self.refer_history(6,:), '-g', "DisplayName", "Reference",'LineWidth',Param.line_width); end
                        if self.plot_model;     self.handles(22) = plot(self.time_history, self.model_history(6,:), '-b', "DisplayName", "Model",    'LineWidth',Param.line_width); end
                        if self.plot_estimate;  self.handles(23) = plot(self.time_history, self.estim_history(6,:), '-r', "DisplayName", "Estimate", 'LineWidth',Param.line_width); end
                                                self.handles(24) = plot(self.time_history, self.state_history(6,:), '-k', "DisplayName", "State",    'LineWidth',Param.line_width);
                        ylabel("$\dot{\theta}$ (deg/s)","Interpreter","latex")
                    xlabel("t - time (s)")
                    % Create legend
                    legend_lines = self.handles(1:4);
                    legend_handle = legend(legend_lines([self.plot_reference,self.plot_model,self.plot_estimate,true]),"Orientation","horizontal","FontSize",10);
                    legend_handle.Position(1:2) = ax.Position(1:2)+[0.15,-0.1];
            end

            %% Inputs
            if self.plot_input
                self.figure_handles(2) = figure('Windowstyle','docked','name','Inputs');
                    clf;
                    sgtitle('Inputs')
                    subplot(4,1,1)
                        hold on;
                        grid on;
                        self.handles(25) = plot(self.time_history, self.input_history(1,:), '-k','LineWidth',Param.line_width);
                        ylabel("$f_r$ (N)","Interpreter","latex")
                    subplot(4,1,2)
                        hold on;
                        grid on;
                        self.handles(26) = plot(self.time_history, self.input_history(2,:), '-k','LineWidth',Param.line_width);
                        ylabel("$f_l$ (N)","Interpreter","latex")
                    subplot(4,1,3)
                        hold on;
                        grid on;
                        self.handles(27) = plot(self.time_history, self.input_history(3,:), '-k','LineWidth',Param.line_width);
                        ylabel("$F$ (N)","Interpreter","latex")
                    subplot(4,1,4)
                        hold on;
                        grid on;
                        self.handles(28) = plot(self.time_history, self.input_history(4,:), '-k','LineWidth',Param.line_width);
                        ylabel("$\tau$ (Nm)","Interpreter","latex")
                    xlabel("t - time (s)")
            end
        end
        function update(self, t, state, estimate, reference, model, input)
                % Unit Conversions ---------------------------------------
                state([3,6])     = rad2deg(state([3,6]));
                estimate([3,6])  = rad2deg(estimate([3,6]));
                reference([3,6]) = rad2deg(reference([3,6]));
                model([3,6])     = rad2deg(model([3,6]));
                input([3,4])     = [1, 1; -self.d, self.d]*input;

                % Save the data for ploting ------------------------------
                self.time_history(self.index)    = t;
                self.state_history(:,self.index) = state;
                self.estim_history(:,self.index) = estimate;
                self.refer_history(:,self.index) = reference;
                self.model_history(:,self.index) = model;
                self.input_history(:,self.index) = input;
                self.index = self.index + 1;

                % Update the plots ---------------------------------------
                if self.plot_state
                    if self.plot_reference; set(self.handles(1),  XData = self.time_history, YData = self.refer_history(1,:)); end
                    if self.plot_model;     set(self.handles(2),  XData = self.time_history, YData = self.model_history(1,:)); end
                    if self.plot_estimate;  set(self.handles(3),  XData = self.time_history, YData = self.estim_history(1,:)); end
                                            set(self.handles(4),  XData = self.time_history, YData = self.state_history(1,:));
                    if self.plot_reference; set(self.handles(5),  XData = self.time_history, YData = self.refer_history(2,:)); end
                    if self.plot_model;     set(self.handles(6),  XData = self.time_history, YData = self.model_history(2,:)); end
                    if self.plot_estimate;  set(self.handles(7),  XData = self.time_history, YData = self.estim_history(2,:)); end
                                            set(self.handles(8),  XData = self.time_history, YData = self.state_history(2,:));
                    if self.plot_reference; set(self.handles(9),  XData = self.time_history, YData = self.refer_history(3,:)); end
                    if self.plot_model;     set(self.handles(10), XData = self.time_history, YData = self.model_history(3,:)); end
                    if self.plot_estimate;  set(self.handles(11), XData = self.time_history, YData = self.estim_history(3,:)); end
                                            set(self.handles(12), XData = self.time_history, YData = self.state_history(3,:));
                    if self.plot_reference; set(self.handles(13), XData = self.time_history, YData = self.refer_history(4,:)); end
                    if self.plot_model;     set(self.handles(14), XData = self.time_history, YData = self.model_history(4,:)); end
                    if self.plot_estimate;  set(self.handles(15), XData = self.time_history, YData = self.estim_history(4,:)); end
                                            set(self.handles(16), XData = self.time_history, YData = self.state_history(4,:));
                    if self.plot_reference; set(self.handles(17), XData = self.time_history, YData = self.refer_history(5,:)); end
                    if self.plot_model;     set(self.handles(18), XData = self.time_history, YData = self.model_history(5,:)); end
                    if self.plot_estimate;  set(self.handles(19), XData = self.time_history, YData = self.estim_history(5,:)); end
                                            set(self.handles(20), XData = self.time_history, YData = self.state_history(5,:));
                    if self.plot_reference; set(self.handles(21), XData = self.time_history, YData = self.refer_history(6,:)); end
                    if self.plot_model;     set(self.handles(22), XData = self.time_history, YData = self.model_history(6,:)); end
                    if self.plot_estimate;  set(self.handles(23), XData = self.time_history, YData = self.estim_history(6,:)); end
                                            set(self.handles(24), XData = self.time_history, YData = self.state_history(6,:));
                end
                if self.plot_input
                    set(self.handles(25), XData = self.time_history, YData = self.input_history(1,:));
                    set(self.handles(26), XData = self.time_history, YData = self.input_history(2,:));
                    set(self.handles(27), XData = self.time_history, YData = self.input_history(3,:));
                    set(self.handles(28), XData = self.time_history, YData = self.input_history(4,:));
                end
        end
        function export_png(self,filename)
            saveas(self.figure_handles(1),filename+"states.png");
            saveas(self.figure_handles(2),filename+"inputs.png");
        end
    end
end