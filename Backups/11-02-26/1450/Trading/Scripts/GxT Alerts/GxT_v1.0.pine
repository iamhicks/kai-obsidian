//@version=6
indicator("Fractal Model Alert System", shorttitle="FM Alert", overlay=true, max_bars_back=500)

// ══════════════════════════════════════════════════════════════════════════════
// FRACTAL MODEL ALERT SYSTEM
// Based on TTrades Fractal Model + GxT Universal Model
// Alerts for C2/C3 closures to prepare for CISD entries
// ══════════════════════════════════════════════════════════════════════════════

// ══════════════════════════════════════════════════════════════════════════════
// INPUTS
// ══════════════════════════════════════════════════════════════════════════════

// Timeframe Selection
group_timeframe = "Timeframe Settings"
show_1h_c2 = input.bool(true, "Show 1H C2 Alerts", group=group_timeframe)
show_30m_c2 = input.bool(true, "Show 30M C2 Alerts", group=group_timeframe)
show_1h_c3 = input.bool(true, "Show 1H C3 Alerts", group=group_timeframe)
show_30m_c3 = input.bool(true, "Show 30M C3 Alerts", group=group_timeframe)

// Candle Analysis Settings
group_candles = "Candle Analysis"
min_wick_ratio = input.float(0.3, "Min Wick Ratio for C2/C3", minval=0.1, maxval=0.8, step=0.1, group=group_candles)
min_body_ratio = input.float(0.4, "Min Body Ratio for C2/C3", minval=0.2, maxval=0.8, step=0.1, group=group_candles)
lookback_swing = input.int(5, "Swing Lookback Period", minval=3, maxval=20, group=group_candles)

// Kill Zone Alerts
group_killzone = "Kill Zone Alerts"
show_killzone = input.bool(true, "Show Kill Zone Alerts", group=group_killzone)
london_start = input.time(timestamp("1970-01-01T08:00:00+0000"), "London Open", group=group_killzone)
ny_start = input.time(timestamp("1970-01-01T13:30:00+0000"), "NY Open", group=group_killzone)

// Visual Settings
group_visual = "Visual Settings"
c2_color = input.color(color.new(color.yellow, 0), "C2 Candle Color", group=group_visual)
c3_color = input.color(color.new(color.orange, 0), "C3 Candle Color", group=group_visual)
label_size = input.string(size.small, "Label Size", options=[size.tiny, size.small, size.normal], group=group_visual)

// ══════════════════════════════════════════════════════════════════════════════
// FUNCTIONS
// ══════════════════════════════════════════════════════════════════════════════

// Function to get higher timeframe candle data
getHTFData(tf) =>
    htf_open = request.security(syminfo.tickerid, tf, open, lookahead=barmerge.lookahead_off)
    htf_high = request.security(syminfo.tickerid, tf, high, lookahead=barmerge.lookahead_off)
    htf_low = request.security(syminfo.tickerid, tf, low, lookahead=barmerge.lookahead_off)
    htf_close = request.security(syminfo.tickerid, tf, close, lookahead=barmerge.lookahead_off)
    [htf_open, htf_high, htf_low, htf_close]

// Function to detect C2 (Candle 2 - Continuation Setup)
// C2 characteristics:
// - Closes in the direction of the trend
// - Has a wick that takes liquidity/stops
// - Body shows continuation intent
isC2(open_price, high_price, low_price, close_price, direction) =>
    body_size = math.abs(close_price - open_price)
    total_range = high_price - low_price
    upper_wick = high_price - math.max(open_price, close_price)
    lower_wick = math.min(open_price, close_price) - low_price
    
    // Bullish C2
    bull_c2 = direction == 1 and 
              close_price > open_price and 
              lower_wick >= body_size * min_wick_ratio and
              body_size >= total_range * min_body_ratio
    
    // Bearish C2
    bear_c2 = direction == -1 and 
              close_price < open_price and 
              upper_wick >= body_size * min_wick_ratio and
              body_size >= total_range * min_body_ratio
    
    bull_c2 ? 1 : bear_c2 ? -1 : 0

// Function to detect C3 (Candle 3 - Confirmation/Entry Setup)
// C3 characteristics:
// - Strong closure in direction
// - Minimal opposing wick
// - Closes near high/low of candle
isC3(open_price, high_price, low_price, close_price, direction) =>
    body_size = math.abs(close_price - open_price)
    total_range = high_price - low_price
    upper_wick = high_price - math.max(open_price, close_price)
    lower_wick = math.min(open_price, close_price) - low_price
    
    // Bullish C3 - closes near high, minimal lower wick
    bull_c3 = direction == 1 and 
              close_price > open_price and 
              upper_wick <= body_size * 0.2 and
              body_size >= total_range * 0.6 and
              close_price >= high_price - (total_range * 0.1)
    
    // Bearish C3 - closes near low, minimal upper wick
    bear_c3 = direction == -1 and 
              close_price < open_price and 
              lower_wick <= body_size * 0.2 and
              body_size >= total_range * 0.6 and
              close_price <= low_price + (total_range * 0.1)
    
    bull_c3 ? 1 : bear_c3 ? -1 : 0

// Function to detect Swing High/Low
isSwingHigh(n) =>
    high >= ta.highest(high, n * 2 + 1)[1]
    
isSwingLow(n) =>
    low <= ta.lowest(low, n * 2 + 1)[1]

// Function to detect Fair Value Gap (FVG)
// Bullish FVG: Low of current candle > High of 2 candles ago
// Bearish FVG: High of current candle < Low of 2 candles ago
detectFVG() =>
    bull_fvg = low > high[2] and close[1] > open[1] and close[2] > open[2]
    bear_fvg = high < low[2] and close[1] < open[1] and close[2] < open[2]
    bull_fvg ? 1 : bear_fvg ? -1 : 0

// ══════════════════════════════════════════════════════════════════════════════
// HIGHER TIMEFRAME DATA
// ══════════════════════════════════════════════════════════════════════════════

// Get 1H data
[htf_1h_open, htf_1h_high, htf_1h_low, htf_1h_close] = getHTFData("60")

// Get 30M data  
[htf_30m_open, htf_30m_high, htf_30m_low, htf_30m_close] = getHTFData("30")

// ══════════════════════════════════════════════════════════════════════════════
// TREND DIRECTION (based on recent price action)
// ══════════════════════════════════════════════════════════════════════════════

// Use 10-period EMA for trend direction
ema_fast = ta.ema(close, 10)
ema_slow = ta.ema(close, 50)
trend_direction = close > ema_fast ? 1 : close < ema_fast ? -1 : 0

// ══════════════════════════════════════════════════════════════════════════════
// C2/C3 DETECTION
// ══════════════════════════════════════════════════════════════════════════════

// Current timeframe C2/C3
c2_current = isC2(open, high, low, close, trend_direction)
c3_current = isC3(open, high, low, close, trend_direction)

// 1H C2/C3 detection
var int c2_1h_dir = 0
var int c3_1h_dir = 0

if barstate.isconfirmed
    c2_1h_dir := isC2(htf_1h_open, htf_1h_high, htf_1h_low, htf_1h_close, trend_direction)
    c3_1h_dir := isC3(htf_1h_open, htf_1h_high, htf_1h_low, htf_1h_close, trend_direction)

// 30M C2/C3 detection
var int c2_30m_dir = 0
var int c3_30m_dir = 0

if barstate.isconfirmed
    c2_30m_dir := isC2(htf_30m_open, htf_30m_high, htf_30m_low, htf_30m_close, trend_direction)
    c3_30m_dir := isC3(htf_30m_open, htf_30m_high, htf_30m_low, htf_30m_close, trend_direction)

// ══════════════════════════════════════════════════════════════════════════════
// SWING DETECTION (Protected Swings)
// ══════════════════════════════════════════════════════════════════════════════

swing_high = isSwingHigh(lookback_swing)
swing_low = isSwingLow(lookback_swing)

// ══════════════════════════════════════════════════════════════════════════════
// FVG DETECTION
// ══════════════════════════════════════════════════════════════════════════════

fvg_detected = detectFVG()

// ══════════════════════════════════════════════════════════════════════════════
// KILL ZONE DETECTION
// ══════════════════════════════════════════════════════════════════════════════

// Get current time
hour_utc = hour(time, "UTC")
minute_utc = minute(time, "UTC")

// London Kill Zone: 08:00 - 10:00 UTC
london_killzone = hour_utc >= 8 and hour_utc < 10

// NY Kill Zone: 13:30 - 16:00 UTC
ny_killzone = (hour_utc == 13 and minute_utc >= 30) or (hour_utc >= 14 and hour_utc < 16)

// NY Open (specific 13:30 moment)
ny_open = hour_utc == 13 and minute_utc == 30

// ══════════════════════════════════════════════════════════════════════════════
// PLOTTING
// ══════════════════════════════════════════════════════════════════════════════

// Background color for Kill Zones
bgcolor(show_killzone and london_killzone ? color.new(color.blue, 90) : na, title="London Kill Zone")
bgcolor(show_killzone and ny_killzone ? color.new(color.red, 90) : na, title="NY Kill Zone")

// C2/C3 Labels on chart
if show_1h_c2 and c2_1h_dir != 0 and not c2_1h_dir[1]
    label.new(bar_index, high, "1H C2 " + (c2_1h_dir == 1 ? "Bull" : "Bear"), 
             color=c2_color, textcolor=color.white, style=label.style_label_down, 
             size=label_size, yloc=yloc.abovebar)

if show_30m_c2 and c2_30m_dir != 0 and not c2_30m_dir[1]
    label.new(bar_index, high, "30M C2 " + (c2_30m_dir == 1 ? "Bull" : "Bear"), 
             color=c2_color, textcolor=color.white, style=label.style_label_down, 
             size=label_size, yloc=yloc.abovebar)

if show_1h_c3 and c3_1h_dir != 0 and not c3_1h_dir[1]
    label.new(bar_index, high, "1H C3 " + (c3_1h_dir == 1 ? "Bull" : "Bear"), 
             color=c3_color, textcolor=color.white, style=label.style_label_down, 
             size=label_size, yloc=yloc.abovebar)

if show_30m_c3 and c3_30m_dir != 0 and not c3_30m_dir[1]
    label.new(bar_index, high, "30M C3 " + (c3_30m_dir == 1 ? "Bull" : "Bear"), 
             color=c3_color, textcolor=color.white, style=label.style_label_down, 
             size=label_size, yloc=yloc.abovebar)

// Swing markers
plotshape(swing_high, title="Swing High", location=location.abovebar, color=color.red, 
         style=shape.triangledown, size=size.tiny)
plotshape(swing_low, title="Swing Low", location=location.belowbar, color=color.green, 
         style=shape.triangleup, size=size.tiny)

// FVG markers
plotshape(fvg_detected == 1, title="Bullish FVG", location=location.belowbar, 
         color=color.new(color.green, 50), style=shape.labelup, size=size.tiny, text="FVG")
plotshape(fvg_detected == -1, title="Bearish FVG", location=location.abovebar, 
         color=color.new(color.red, 50), style=shape.labeldown, size=size.tiny, text="FVG")

// ══════════════════════════════════════════════════════════════════════════════
// ALERTS
// ══════════════════════════════════════════════════════════════════════════════

// C2 Alerts - PREPARE FOR CISD
alertcondition(show_1h_c2 and c2_1h_dir == 1 and not (c2_1h_dir == 1)[1], 
              title="1H Bullish C2", 
              message="🟢 1H Bullish C2 Detected! Prepare for CISD on 5M/3M C3 candle. Watch for long entry setup.")

alertcondition(show_1h_c2 and c2_1h_dir == -1 and not (c2_1h_dir == -1)[1], 
              title="1H Bearish C2", 
              message="🔴 1H Bearish C2 Detected! Prepare for CISD on 5M/3M C3 candle. Watch for short entry setup.")

alertcondition(show_30m_c2 and c2_30m_dir == 1 and not (c2_30m_dir == 1)[1], 
              title="30M Bullish C2", 
              message="🟢 30M Bullish C2 Detected! Prepare for CISD on 5M/3M C3 candle. Watch for long entry setup.")

alertcondition(show_30m_c2 and c2_30m_dir == -1 and not (c2_30m_dir == -1)[1], 
              title="30M Bearish C2", 
              message="🔴 30M Bearish C2 Detected! Prepare for CISD on 5M/3M C3 candle. Watch for short entry setup.")

// C3 Alerts - CISD CONFIRMATION (Alternative entry)
alertcondition(show_1h_c3 and c3_1h_dir == 1 and not (c3_1h_dir == 1)[1], 
              title="1H Bullish C3 - CISD Confirmed", 
              message="🟢🚀 1H Bullish C3 (CISD)! Confirmed long entry on higher TF. Check 5M/3M for precision entry.")

alertcondition(show_1h_c3 and c3_1h_dir == -1 and not (c3_1h_dir == -1)[1], 
              title="1H Bearish C3 - CISD Confirmed", 
              message="🔴🚀 1H Bearish C3 (CISD)! Confirmed short entry on higher TF. Check 5M/3M for precision entry.")

alertcondition(show_30m_c3 and c3_30m_dir == 1 and not (c3_30m_dir == 1)[1], 
              title="30M Bullish C3 - CISD Confirmed", 
              message="🟢🚀 30M Bullish C3 (CISD)! Confirmed long entry on higher TF. Check 5M/3M for precision entry.")

alertcondition(show_30m_c3 and c3_30m_dir == -1 and not (c3_30m_dir == -1)[1], 
              title="30M Bearish C3 - CISD Confirmed", 
              message="🔴🚀 30M Bearish C3 (CISD)! Confirmed short entry on higher TF. Check 5M/3M for precision entry.")

// Kill Zone Alerts
alertcondition(show_killzone and ny_open, 
              title="NY Open", 
              message="🇺🇸 NY OPEN - High probability window starting. Check 1H/30M for C2 setups.")

alertcondition(show_killzone and london_killzone and not london_killzone[1], 
              title="London Kill Zone", 
              message="🇬🇧 LONDON KILL ZONE - High volatility period. Watch for C2/C3 setups.")

// Swing Alerts - Protected Level Monitoring
alertcondition(swing_high, 
              title="Protected Swing High", 
              message="📊 Protected Swing High formed. Watch for ERL sweep + reversal.")

alertcondition(swing_low, 
              title="Protected Swing Low", 
              message="📊 Protected Swing Low formed. Watch for ERL sweep + reversal.")

// FVG Alerts - Premium/Discount Zones
alertcondition(fvg_detected == 1, 
              title="Bullish FVG", 
              message="📈 Bullish FVG detected. Potential support zone for longs.")

alertcondition(fvg_detected == -1, 
              title="Bearish FVG", 
              message="📉 Bearish FVG detected. Potential resistance zone for shorts.")

// ══════════════════════════════════════════════════════════════════════════════
// TABLE SUMMARY (For visual confirmation)
// ══════════════════════════════════════════════════════════════════════════════

var table info_table = table.new(position.top_right, 2, 6, bgcolor=color.new(color.black, 80), 
                                 border_width=1, border_color=color.gray)

if barstate.islast
    table.cell(info_table, 0, 0, "Timeframe", text_color=color.white, text_size=size.small)
    table.cell(info_table, 1, 0, "Status", text_color=color.white, text_size=size.small)
    
    table.cell(info_table, 0, 1, "1H C2", text_color=c2_1h_dir == 1 ? color.green : c2_1h_dir == -1 ? color.red : color.gray, text_size=size.small)
    table.cell(info_table, 1, 1, c2_1h_dir == 1 ? "BULLISH" : c2_1h_dir == -1 ? "BEARISH" : "NONE", 
              text_color=c2_1h_dir == 1 ? color.green : c2_1h_dir == -1 ? color.red : color.gray, text_size=size.small)
    
    table.cell(info_table, 0, 2, "1H C3", text_color=c3_1h_dir == 1 ? color.green : c3_1h_dir == -1 ? color.red : color.gray, text_size=size.small)
    table.cell(info_table, 1, 2, c3_1h_dir == 1 ? "BULLISH" : c3_1h_dir == -1 ? "BEARISH" : "NONE", 
              text_color=c3_1h_dir == 1 ? color.green : c3_1h_dir == -1 ? color.red : color.gray, text_size=size.small)
    
    table.cell(info_table, 0, 3, "30M C2", text_color=c2_30m_dir == 1 ? color.green : c2_30m_dir == -1 ? color.red : color.gray, text_size=size.small)
    table.cell(info_table, 1, 3, c2_30m_dir == 1 ? "BULLISH" : c2_30m_dir == -1 ? "BEARISH" : "NONE", 
              text_color=c2_30m_dir == 1 ? color.green : c2_30m_dir == -1 ? color.red : color.gray, text_size=size.small)
    
    table.cell(info_table, 0, 4, "30M C3", text_color=c3_30m_dir == 1 ? color.green : c3_30m_dir == -1 ? color.red : color.gray, text_size=size.small)
    table.cell(info_table, 1, 4, c3_30m_dir == 1 ? "BULLISH" : c3_30m_dir == -1 ? "BEARISH" : "NONE", 
              text_color=c3_30m_dir == 1 ? color.green : c3_30m_dir == -1 ? color.red : color.gray, text_size=size.small)
    
    table.cell(info_table, 0, 5, "Trend", text_color=color.white, text_size=size.small)
    table.cell(info_table, 1, 5, trend_direction == 1 ? "BULLISH" : trend_direction == -1 ? "BEARISH" : "NEUTRAL", 
              text_color=trend_direction == 1 ? color.green : trend_direction == -1 ? color.red : color.gray, text_size=size.small)
