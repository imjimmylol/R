(function(){/*

 Copyright The Closure Library Authors.
 SPDX-License-Identifier: Apache-2.0
*/
'use strict';var g,aa="function"==typeof Object.create?Object.create:function(a){function b(){}
b.prototype=a;return new b},l;
if("function"==typeof Object.setPrototypeOf)l=Object.setPrototypeOf;else{var m;a:{var ba={a:!0},n={};try{n.__proto__=ba;m=n.a;break a}catch(a){}m=!1}l=m?function(a,b){a.__proto__=b;if(a.__proto__!==b)throw new TypeError(a+" is not extensible");return a}:null}var p=l;
function q(a,b){a.prototype=aa(b.prototype);a.prototype.constructor=a;if(p)p(a,b);else for(var c in b)if("prototype"!=c)if(Object.defineProperties){var d=Object.getOwnPropertyDescriptor(b,c);d&&Object.defineProperty(a,c,d)}else a[c]=b[c];a.X=b.prototype}
var t=this||self;function u(a){a=a.split(".");for(var b=t,c=0;c<a.length;c++)if(b=b[a[c]],null==b)return null;return b}
function ca(a,b,c){return a.call.apply(a.bind,arguments)}
function da(a,b,c){if(!a)throw Error();if(2<arguments.length){var d=Array.prototype.slice.call(arguments,2);return function(){var e=Array.prototype.slice.call(arguments);Array.prototype.unshift.apply(e,d);return a.apply(b,e)}}return function(){return a.apply(b,arguments)}}
function v(a,b,c){Function.prototype.bind&&-1!=Function.prototype.bind.toString().indexOf("native code")?v=ca:v=da;return v.apply(null,arguments)}
function w(a,b){a=a.split(".");var c=t;a[0]in c||"undefined"==typeof c.execScript||c.execScript("var "+a[0]);for(var d;a.length&&(d=a.shift());)a.length||void 0===b?c[d]&&c[d]!==Object.prototype[d]?c=c[d]:c=c[d]={}:c[d]=b}
;var x={},y=null;var ea="function"===typeof Uint8Array;var z="function"===typeof Symbol&&"symbol"===typeof Symbol()?Symbol(void 0):void 0;function B(a){Object.isFrozen(a)||(z?a[z]|=1:void 0!==a.g?a.g|=1:Object.defineProperties(a,{g:{value:1,configurable:!0,writable:!0,enumerable:!1}}));return a}
;function C(a){return null!==a&&"object"===typeof a&&!Array.isArray(a)&&a.constructor===Object}
;function D(a,b){if(null!=a)return Array.isArray(a)||C(a)?E(a,b):b(a)}
function E(a,b){if(Array.isArray(a)){for(var c=Array(a.length),d=0;d<a.length;d++)c[d]=D(a[d],b);if(b=Array.isArray(a)){var e;z?e=a[z]:e=a.g;b=(null==e?0:e)&1}b&&B(c);return c}e={};for(c in a)e[c]=D(a[c],b);return e}
function F(a){if(a&&"object"==typeof a&&a.toJSON)return a.toJSON();a:switch(typeof a){case "number":a=isFinite(a)?a:String(a);break a;case "object":if(a&&!Array.isArray(a)&&ea&&null!=a&&a instanceof Uint8Array){var b;void 0===b&&(b=0);if(!y){y={};for(var c="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".split(""),d=["+/=","+/","-_=","-_.","-_"],e=0;5>e;e++){var f=c.concat(d[e].split(""));x[e]=f;for(var h=0;h<f.length;h++){var k=f[h];void 0===y[k]&&(y[k]=h)}}}b=x[b];c=Array(Math.floor(a.length/
3));d=b[64]||"";for(e=f=0;f<a.length-2;f+=3){var r=a[f],A=a[f+1];k=a[f+2];h=b[r>>2];r=b[(r&3)<<4|A>>4];A=b[(A&15)<<2|k>>6];k=b[k&63];c[e++]=""+h+r+A+k}h=0;k=d;switch(a.length-f){case 2:h=a[f+1],k=b[(h&15)<<2]||d;case 1:a=a[f],c[e]=""+b[a>>2]+b[(a&3)<<4|h>>4]+k+d}a=c.join("")}}return Array.isArray(a)?E(a,F):a}
;var fa;function G(a,b,c){var d=fa;fa=null;a||(a=d);d=this.constructor.W;a||(a=d?[d]:[]);this.h=(d?0:-1)-(this.constructor.V||0);this.g=null;this.l=a;a:{d=this.l.length;a=d-1;if(d&&(d=this.l[a],C(d))){this.j=a-this.h;this.i=d;break a}void 0!==b&&-1<b?(this.j=Math.max(b,a+1-this.h),this.i=null):this.j=Number.MAX_VALUE}if(c)for(b=0;b<c.length;b++)a=c[b],a<this.j?(a+=this.h,(d=this.l[a])?Array.isArray(d)&&B(d):this.l[a]=H):(ha(this),(d=this.i[a])?Array.isArray(d)&&B(d):this.i[a]=H)}
var H=Object.freeze(B([]));function ha(a){var b=a.j+a.h;a.l[b]||(a.i=a.l[b]={})}
function ia(a,b,c,d){(void 0===d?0:d)||b>=a.j?(ha(a),a.i[b]=c):a.l[b+a.h]=c;return a}
G.prototype.toJSON=function(){return E(this.l,F)};
G.prototype.toString=function(){return this.l.toString()};function ja(a,b){var c=this.g;if(this.h){var d=!0;d=void 0===d?!1:d;if(b){var e=B([]);for(var f=0;f<b.length;f++)e[f]=b[f].l;a.g||(a.g={});a.g[c]=b}else a.g&&(a.g[c]=void 0),e=H;a=ia(a,c,e,d)}else d=!0,a.g||(a.g={}),e=b?b.l:b,a.g[c]=b,a=ia(a,c,e,void 0===d?!1:d);return a}
;function I(){this.u=this.u;this.C=this.C}
I.prototype.u=!1;I.prototype.dispose=function(){this.u||(this.u=!0,this.H())};
I.prototype.H=function(){if(this.C)for(;this.C.length;)this.C.shift()()};function J(a){G.call(this,a,1)}
q(J,G);function K(a){G.call(this,a)}
q(K,G);var ka=new function(a,b,c){this.g=a;this.h=c;this.i=ja}(406606992,K,0);function la(){K.apply(this,arguments)}
q(la,K);var L,M,N,O=t.window,P=(null===(L=null===O||void 0===O?void 0:O.yt)||void 0===L?void 0:L.config_)||(null===(M=null===O||void 0===O?void 0:O.ytcfg)||void 0===M?void 0:M.data_)||{},ma=(null===(N=null===O||void 0===O?void 0:O.ytcfg)||void 0===N?void 0:N.obfuscatedData_)||[];function na(){J.apply(this,arguments)}
q(na,J);var oa=new na(ma),pa=P.EXPERIMENT_FLAGS;if(!pa||!pa.jspb_i18n_extension){var qa=new la;ka.i(oa,qa)}w("yt.config_",P);w("yt.configJspb_",ma);function Q(a,b){return a in P?P[a]:b}
;function ra(a,b){a=sa(a);return void 0===a&&void 0!==b?b:Number(a||0)}
function sa(a){var b=Q("EXPERIMENTS_FORCED_FLAGS",{});return void 0!==b[a]?b[a]:Q("EXPERIMENT_FLAGS",{})[a]}
;var ta=ra("web_emulated_idle_callback_delay",300),ua=1E3/60-3;
function R(a){a=void 0===a?{}:a;I.call(this);this.g=[];this.g[8]=[];this.g[4]=[];this.g[3]=[];this.g[2]=[];this.g[1]=[];this.g[0]=[];this.j=0;this.O=a.timeout||1;this.i={};this.s=ua;this.D=this.h=this.o=0;this.F=this.m=!1;this.v=[];this.I=v(this.S,this);this.N=v(this.U,this);this.K=v(this.P,this);this.L=v(this.R,this);this.M=v(this.T,this);this.B=this.G=!1;var b;if(b=!!window.requestIdleCallback)b=sa("disable_scheduler_requestIdleCallback"),b=!("string"===typeof b&&"false"===b?0:b);this.J=b;(this.A=
!!a.useRaf&&!!window.requestAnimationFrame)&&document.addEventListener("visibilitychange",this.I)}
q(R,I);function va(a,b){var c=Date.now();S(b);b=Date.now()-c;a.m||(a.s-=b)}
function wa(a,b,c,d){++a.D;if(10==c)return va(a,b),a.D;var e=a.D;a.i[e]=b;a.m&&!d?a.v.push({id:e,priority:c}):(a.g[c].push(e),a.F||a.m||(0!=a.h&&T(a)!=a.o&&U(a),a.start()));return e}
function xa(a){a.v.length=0;for(var b=4;0<=b;b--)a.g[b].length=0;a.g[8].length=0;a.i={};U(a)}
function T(a){if(a.g[8].length){if(a.B)return 4;if(!document.hidden&&a.A)return 3}for(var b=4;b>=a.j;b--)if(0<a.g[b].length)return 0<b?!document.hidden&&a.A?3:2:1;return 0}
function S(a){try{a()}catch(b){(a=u("yt.logging.errors.log"))&&a(b)}}
function ya(a){if(a.g[8].length)return!0;for(var b=3;0<=b;b--)if(a.g[b].length)return!0;return!1}
g=R.prototype;g.R=function(a){var b=void 0;a&&(b=a.timeRemaining());this.G=!0;V(this,b);this.G=!1};
g.U=function(){V(this)};
g.P=function(){za(this)};
g.T=function(){this.B=!0;var a=T(this);4==a&&a!=this.o&&(U(this),this.start());V(this);this.B=!1};
g.S=function(){document.hidden||za(this);this.h&&(U(this),this.start())};
function za(a){U(a);a.m=!0;for(var b=Date.now(),c=a.g[8];c.length;){var d=c.shift(),e=a.i[d];delete a.i[d];e&&S(e)}Aa(a);a.m=!1;ya(a)&&a.start();a.s-=Date.now()-b}
function Aa(a){for(var b=0,c=a.v.length;b<c;b++){var d=a.v[b];a.g[d.priority].push(d.id)}a.v.length=0}
function V(a,b){a.B&&4==a.o&&a.h||U(a);a.m=!0;b=Date.now()+(b||a.s);for(var c=a.g[4];c.length;){var d=c.shift(),e=a.i[d];delete a.i[d];e&&S(e)}c=a.G?0:1;c=a.j>c?a.j:c;if(!(Date.now()>=b)){do{a:{d=a;e=c;for(var f=3;f>=e;f--)for(var h=d.g[f];h.length;){var k=h.shift(),r=d.i[k];delete d.i[k];if(r){d=r;break a}}d=null}d&&S(d)}while(d&&Date.now()<b)}a.m=!1;Aa(a);a.s=ua;ya(a)&&a.start()}
g.start=function(){this.F=!1;if(0==this.h)switch(this.o=T(this),this.o){case 1:var a=this.L;this.h=this.J?window.requestIdleCallback(a,{timeout:3E3}):window.setTimeout(a,ta);break;case 2:this.h=window.setTimeout(this.N,this.O);break;case 3:this.h=window.requestAnimationFrame(this.M);break;case 4:this.h=window.setTimeout(this.K,0)}};
function U(a){if(a.h){switch(a.o){case 1:var b=a.h;a.J?window.cancelIdleCallback(b):window.clearTimeout(b);break;case 2:case 4:window.clearTimeout(a.h);break;case 3:window.cancelAnimationFrame(a.h)}a.h=0}}
g.H=function(){xa(this);U(this);this.A&&document.removeEventListener("visibilitychange",this.I);I.prototype.H.call(this)};var W=u("yt.scheduler.instance.timerIdMap_")||{},Ba=ra("kevlar_tuner_scheduler_soft_state_timer_ms",800),X=0,Y=0;function Z(){var a=u("ytglobal.schedulerInstanceInstance_");if(!a||a.u)a=new R(Q("scheduler",void 0)||{}),w("ytglobal.schedulerInstanceInstance_",a);return a}
function Ca(){var a=u("ytglobal.schedulerInstanceInstance_");a&&(a&&"function"==typeof a.dispose&&a.dispose(),w("ytglobal.schedulerInstanceInstance_",null))}
function Da(){xa(Z())}
function Ea(a,b,c){if(0==c||void 0===c)return c=void 0===c,-wa(Z(),a,b,c);var d=window.setTimeout(function(){var e=wa(Z(),a,b);W[d]=e},c);
return d}
function Fa(a){var b=Z();va(b,a)}
function Ga(a){var b=Z();if(0>a)delete b.i[-a];else{var c=W[a];c?(delete b.i[c],delete W[a]):window.clearTimeout(a)}}
function Ha(a){var b=u("ytcsi.tick");b&&b(a)}
function Ia(){Ha("jse");Ja()}
function Ja(){window.clearTimeout(X);Z().start()}
function Ka(){var a=Z();U(a);a.F=!0;window.clearTimeout(X);X=window.setTimeout(Ia,Ba)}
function La(){window.clearTimeout(Y);Y=window.setTimeout(function(){Ha("jset");Ma(0)},Ba)}
function Ma(a){La();var b=Z();b.j=a;b.start()}
function Na(a){La();var b=Z();b.j>a&&(b.j=a,b.start())}
function Oa(){window.clearTimeout(Y);var a=Z();a.j=0;a.start()}
;u("yt.scheduler.initialized")||(w("yt.scheduler.instance.dispose",Ca),w("yt.scheduler.instance.addJob",Ea),w("yt.scheduler.instance.addImmediateJob",Fa),w("yt.scheduler.instance.cancelJob",Ga),w("yt.scheduler.instance.cancelAllJobs",Da),w("yt.scheduler.instance.start",Ja),w("yt.scheduler.instance.pause",Ka),w("yt.scheduler.instance.setPriorityThreshold",Ma),w("yt.scheduler.instance.enablePriorityThreshold",Na),w("yt.scheduler.instance.clearPriorityThreshold",Oa),w("yt.scheduler.initialized",!0));}).call(this);
