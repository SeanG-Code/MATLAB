classdef massSpringDamperSignalGenerator
    properties
        amplitude
        frequency
        y_offset
    end
    
    methods
        function self = massSpringDamperSignalGenerator(amplitude, frequency, y_offset)
            % Save properties
            self.amplitude = amplitude;

            % If frequency is given then save it.
            if nargin>1
                self.frequency = frequency;
            else % Otherwise default to 1 hz.
                self.frequency = 1;
            end

            % If y_offset is given then save it.
            if nargin>2
                self.y_offset = y_offset;
            else % Otherwise default to 0.
                self.y_offset = 0;
            end
        end

        function out = square(self, t)
            % Square wave. Alternate between positive and negative
            % amplitude around y offset. Changes occure every half a
            % period.
            if mod(t, 1/self.frequency)<=0.5/self.frequency
                out = self.amplitude + self.y_offset;
            else
                out = -self.amplitude + self.y_offset;
            end
        end

        function out = step(self, t)
            % Step to amplitude after t=0. y_offset shifts the whole thing
            % up and down.
            if t>=0
                out = self.amplitude + self.y_offset;
            else
                out = self.y_offset;
            end
        end
        
        function out = sawtooth(self, t)
            % Line that increases from -amplitude to +amplidtude over 1/2 a
            % period. It then resets to -amplitude and starts over. Y
            % offset shifts the center up and down.
            out = 4*self.amplitude*self.frequency * mod(t, 0.5/self.frequency)...
                - self.amplitude + self.y_offset;
        end

        function out = random(self, ~)
            % Normal distrobution random numbers with the amplitude being
            % the standard deviation and the y_offset being the mean.
            out = self.amplitude*randn + self.y_offset;
        end

        function out = sin(self, t)
            % Sine wave. Standard defintions apply.
            out = self.amplitude*sin(2*pi*self.frequency*t) + self.y_offset;
        end

        function out = cos(self, t)
            % Cosine wave. Standard defintions apply.
            out = self.amplitude*cos(2*pi*self.frequency*t) + self.y_offset;
        end
    end
end