<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />

        <title>Flow overview</title>


        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-2.2.0.min.js"></script>

        <link href='http://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous" />

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous" />

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>


        <!-- Booststrap Notify plugin-->
        <script src="/assets/bootstrap-notify.min.js"></script>

        <!-- DateTime formatter-->
        <script src="/assets/DateTimeFormat.js"></script>

        <!-- d3 -->
        <script src="//d3js.org/d3.v3.min.js" charset="utf-8"></script>

        <script src="/assets/Connection.js"></script>
        <script src="/assets/Layer.js"></script>
        <script src="/assets/Layers.js"></script>

        <script src="/assets/common.js"></script>

        <script src="/assets/renderFlow.js"></script>
        <style>
            body {
            font-family: 'Roboto', sans-serif;
            color: #333;
            font-weight: 300;
            font-size: 16px;
            }
            .hd {
            background-color: #000000;
            font-size: 18px;
            color: #FFFFFF;
            }
            .block {
            width: 250px;
            height: 350px;
            display: inline-block;
            border: 1px solid #DEDEDE;
            margin-right: 64px;
            }
            .hd-small {
            background-color: #000000;
            font-size: 14px;
            color: #FFFFFF;
            }
            .charts, .chart {
            font-size: 10px;
            font-color: #000000;
            }
            .tooltip {
                position: absolute;
                top: 140px;
                left: 0px;
                right: 0;
                width: 220px;
                padding: 2px 0;
                background-color: #000;
                background-color: rgba(0, 0, 0, 0.65);
                color: #fff;
                opacity: 0;
                transition: opacity .5s ease-in-out;
                text-align: center;
                font-family: Arial;
                font-size: 14px;
                z-index: 100;
            }
            .viewpanel {
                position: absolute;
                background-color: #FFF;
                top: 60px;
                bottom: 0px;
            }

            .perftd {
                padding-right: 10px;
                padding-bottom: 1px;
                font-family: Arial;
                font-size: 14px;
            }

            .bar rect {
                fill: steelblue;
                shape-rendering: crispEdges;
            }

    .bar text {
        fill: #EFEFEF;
    }

    .area {
        fill: steelblue;
    }

    .axis path, .axis line {
        fill: none;
        stroke: #000;
        stroke-width: 1.5;
        shape-rendering: crispEdges;
    }

    .tick line {
        opacity: 0.2;
        stroke-width: 1.5;
        shape-rendering: crispEdges;
    }

    .tick {
        font-size: 9px;
    }

    path {
        stroke: steelblue;
        stroke-width: 1.5;
        fill: none;
    }

    .legend {
        font-size: 12px;
        text-anchor: middle;
    }

    .layerDesc {
        font-family: Arial;
        font-size: 12px;
    }

    .brush .extent {
        stroke: #fff;
        stroke-width: 1.5;
        fill-opacity: .125;
        shape-rendering: crispEdges;
    }
        </style>
    </head>
    <body>
        <table style="width: 100%; padding: 5px;" class="hd">
            <tbody>
                <tr>
                    <td style="width: 48px;"><a href="/"><img src="/assets/deeplearning4j.img" border="0"/></a></td>
                    <td>DeepLearning4j UI</td>
                    <td style="width: 512px; text-align: right;" class="hd-small">&nbsp; Available sessions: <select class="selectpicker" id="sessionSelector" onchange="window.location.href = 'flow?sid='+ this.options[this.selectedIndex].value ;" style="color: #000000; display: inline-block; width: 256px;">
                        <option value="0" selected="selected">Pick a session to track</option>
                    </select>&nbsp;&nbsp;
                        <script>
                            buildSessionSelector("FLOW");
                        </script>
                    </td>
                    <td style="width: 256px;" class="hd-small">&nbsp;Updated at: <b><span id="updatetime">No updates so far</span></b>&nbsp;</td>
                </tr>
            </tbody>
        </table>
        <br /> <br />
        <div style="width: 100%; text-align: center;">
            <div id="display" style="display: inline-block; width: 900px;">
                <!-- NN rendering pane -->
            </div>
        </div>
        <div id="tooltip" class="tooltip">
            &nbsp;
        </div>

        <!-- Left view panel -->
        <div style="left: 10px; width: 400px;" class="viewpanel">
            <center>
                <table style="margin: 10px; width: 200px;">
                    <tr>
                        <td><b>Score vs iteration:</b></td>
                    </tr>
                </table>
            </center>
            <div id="scoreChart" style="background-color: #FFF; height: 250px;">
                &nbsp;
            </div>
            <br/>
            <div style="width: 100%; background-color: #FFF; text-align:center; display: block; ">
                <center>
                    <table style="margin: 10px; width: 200px;">
                        <thead style="width: 200px;">
                        <td colspan="2"><b>Model training status:</b></td>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="perftd">Current score:</td>
                            <td class="perftd" id="ss">0.0</td>
                        </tr>
                        <tr>
                            <td class="perftd">Time spent so far:</td>
                            <td class="perftd" id="st">00:00:00</td>
                        </tr>
                        </tbody>
                    </table>
                </center>
            </div>
            <br/>
            <div style="width: 100%; background-color: #FFF; text-align:center; display: block; ">
                <center>
                <table style="margin: 10px; width: 200px;">
                    <thead style="width: 200px;">
                        <td colspan="2"><b>Performance status:</b></td>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="perftd">Sampes per sec:</td>
                            <td class="perftd" id="ps">0.0/sec</td>
                        </tr>
                        <tr>
                            <td class="perftd">Batches per sec:</td>
                            <td class="perftd" id="pb">0.0/sec</td>
                        </tr>
                        <tr>
                            <td class="perftd">Iteration time:</td>
                            <td class="perftd" id="pt">0 ms</td>
                        </tr>
                    </tbody>
                </table>
                </center>
            </div>
        </div>

        <!-- Right view panel -->
        <div style="right: 10px; width: 400px; position: absolute;" class="viewpanel" id="viewport">
            <div style='position: relative; top: 45%; height: 40px; margin: 0 auto;' id='hint'><b>&lt; Click on any node for detailed report</b></div>
        </div>
    </body>
</html>