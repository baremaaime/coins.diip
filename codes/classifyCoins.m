function labels = classifyCoins(allDiameters, allHue, allSatDiff)
    % Define reference diameters for different coin classes
    reference_coins = [
        25.75;   % 2 euros
        23.25;   % 1 euro
        24.25;   % 50 cents
        22.25;   % 20 cents
        19.75;   % 10 cents
        21.25;   % 5 cent
    ];

    % Define corresponding coin classes
    coin_classes = {'2e','1e','50c','20c','10c','5c'};
    
    % Initialize cell array to store classified coins
    classified_coins = cell(1, numel(allDiameters));

    % Loop over each measured diameter
    for i = 1:numel(allDiameters)
        % Get the current diameter
        current_diameter = allDiameters(i);
    
        % Calculate the differences between the current diameter and reference diameters
        differences = abs(reference_coins - current_diameter);
        
        % Find the index of the minimum difference
        minIndex = find(differences == min(differences));
    
        % Assign the corresponding coin class to the current diameter
        classified_coins{i} = coin_classes{minIndex};
    end

    % Convert the cell array to a character array
    labels = classified_coins;
end
