Add-Type -AssemblyName System.Drawing
$root = Split-Path -Parent $PSScriptRoot
$targets = @(
    @{ Size = 180; Name = 'apple-touch-icon.png' },
    @{ Size = 32;  Name = 'favicon-32.png' }
)
$bg   = [System.Drawing.ColorTranslator]::FromHtml('#0b0b0d')
$mark = [System.Drawing.ColorTranslator]::FromHtml('#d4f04a')
foreach ($t in $targets) {
    $s   = [int]$t.Size
    $bmp = New-Object System.Drawing.Bitmap($s, $s)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $brush = New-Object System.Drawing.SolidBrush($bg)
    $g.FillRectangle($brush, 0, 0, $s, $s)
    $pen = New-Object System.Drawing.Pen($mark, [single]($s * 0.115))
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap   = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
    $p1 = New-Object System.Drawing.PointF([single]($s*0.255), [single]($s*0.520))
    $p2 = New-Object System.Drawing.PointF([single]($s*0.430), [single]($s*0.700))
    $p3 = New-Object System.Drawing.PointF([single]($s*0.755), [single]($s*0.320))
    $g.DrawLines($pen, @($p1, $p2, $p3))
    $out = Join-Path $root $t.Name
    $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
    $pen.Dispose(); $brush.Dispose(); $g.Dispose(); $bmp.Dispose()
    Write-Host ("wrote {0} ({1}x{1})" -f $out, $s)
}
