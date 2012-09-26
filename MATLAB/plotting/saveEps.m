% Save figure as eps
function saveEps(filename, width, height) 
    prepfig;

    if nargin < 3
        height = 8;
        width = 12;
    end

    exportfig(gcf,filename, 'Height', height, 'Width', width, ...
        'FontMode', 'fixed', 'FontSize', 8, 'Color', 'cmyk','LockAxes',0)
end
