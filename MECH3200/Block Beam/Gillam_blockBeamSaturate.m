function input = Gillam_blockBeamSaturate(input, lower_limit, upper_limit)
    % HW2 SECTION START --------------------------------------------------
    % Write code to saturate the variable input. You may assume that all
    % variables are scalars.
    
    input(input<lower_limit)=lower_limit;
    input(input>upper_limit)=upper_limit;

    % HW2 SECTION END ----------------------------------------------------
end