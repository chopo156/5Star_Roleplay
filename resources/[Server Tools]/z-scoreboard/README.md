# Clean Scoreboard *Fully Configurable*
**z-scoreboard** is a resource by *Zua* that allows users to __easily__ configure the playerlist or scoreboard

![alt-text](https://github.com/ThatZiv/z-scoreboard/blob/master/screenshots/ss5.png?raw=true)

## __Installation__
1. Download [Here](https://github.com/ThatZiv/z-scoreboard).
2. Put the **z-scoreboard** folder into your **resources** folder 
3. Add `start z-scoreboard` into your **server.cfg**

## __Configuration__
| Value | Type | Description|
|-----|-----|---|
| `--main-bg-color` | `rgba` | Main Background Color |
|`--main-heading-bg-color` | `rgba` | Header Background Color |
| `--main-font` | `font-family` | Master Font |
| `--main-text-color` | `rgba`  | Master Font Color |
| `--main-font-size` | `px` | Master Font Size |
| `--main-window-width` | `px` | Playerlist Window Width |
| `-main-window-height` | `px` | Playerlist Window Height|
| `--main-text-align` | `direction` | Master Text Align |
| `--main-heading-height` | `px` | Header hight |
| `--main-padding` | `px` | Master Padding - *Try not to mess w/ this  (forgot what I made it assigned to)* |
| `--main-border` | `px` and `rgb` | Scoreboard Border Intensity and Color |
| `--main-border-radius` | `px` | The 'roundness' of The Scoreboard's Border' |
| `--ext-title-font-size` | `px` | Title Header Font Size |
| `--ext-title-font-align` | `direction` | Title Header Alignment |
| `--ext-title-font-color` | `rgba` | Title Header Text Color |
| `--ext-footer-font-align` | `direction` | Footer Alignment |
| `--ext-footer-font-color` | `rgba` | Footer Text Color |

---
`config.css`
```css
:root /* Edit this for config */ {
	--main-bg-color: rgba(12, 44, 95, 0.548);
	--main-heading-bg-color: rgba(0, 0, 0, 0.568);
	--main-border: 3px solid rgba(0, 0, 0, 0.363); 
	--main-border-radius: 6px; 
	--main-font: 'Roboto Condensed', sans-serif; 
	--main-text-color: rgba(255, 255, 255, 0.9);
	--main-font-size: 39px;
	--main-window-width: 370px;
	--main-window-height: 185px;
	--main-text-align: left;
	--main-heading-height: 23px;
	--main-padding: 7px;
	--main-font-weight: 500; 
/* 'Config.js' styling */
	--ext-title-font-size: 25px;
	--ext-title-font-align: center;
	--ext-title-font-color: rgb(223, 223, 223);
	--ext-footer-font-align: right;
	--ext-footer-font-color: rgba(190, 215, 255, 0.329);
}
```
`config.js`
```js
var title = 'Test Server';
var footer = 'discord.gg/xyz';
/* ------------------------------- */
document.getElementById('title').innerHTML = title;
document.getElementById('footer').innerHTML = footer;
```
Change the variable's strings in `config.js` to match to your liking.
To change keypress value to open scoreboard -> go to `client.lua` | Default Key: **Z**

## __Support__
If you need any help/support, join my [discord](https://discordapp.com/invite/yWddFpQ) and ask in **#support**

## __Screenshots__
![alt-text](https://raw.githubusercontent.com/ThatZiv/z-scoreboard/master/screenshots/ss1.png)
![alt-text](https://raw.githubusercontent.com/ThatZiv/z-scoreboard/master/screenshots/ss2.png)
![alt-text](https://raw.githubusercontent.com/ThatZiv/z-scoreboard/master/screenshots/ss3.png)
![alt-text](https://raw.githubusercontent.com/ThatZiv/z-scoreboard/master/screenshots/ss4.png)
![alt-text](https://raw.githubusercontent.com/ThatZiv/z-scoreboard/master/screenshots/ss5.png)

-------
