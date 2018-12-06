// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"


// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
import base from "./base"
import socket from "./socket"
// import {Socket, Presence} from "phoenix"

// let socket = new Socket("/socket", {
//   params: {token: window.userToken},
//   logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data) }
// })

// let channel = socket.channel("room:lobby", {})
// let presence = new Presence(channel)

// function renderOnlineUsers(presence) {
//   let response = ""

//   presence.list((id, {metas: [first, ...rest]}) => {
//     let count = rest.length + 1
//     response += `<br>${id} (count: ${count})</br>`
//   })

//   document.querySelector("main[role=main]").innerHTML = response
// }

// socket.connect()

// presence.onSync(() => renderOnlineUsers(presence))

// channel.join()


