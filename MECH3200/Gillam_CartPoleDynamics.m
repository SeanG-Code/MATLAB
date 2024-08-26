classdef Gillam_CartPoleDynamics
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % System properties
        m_1
        m_2
        ell
        g
        b

        % Time Step
        Ts

        %System State
        states
    end

    methods
        function self = Gillam_CartPoleDynamics(Param)
            % System
            self.m_1 = Param.m_1
        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end