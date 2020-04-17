From: "Derrick, Jonathan" <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core
 code
Date: Fri, 17 Apr 2020 01:14:30 +0000
Message-ID: <aafed865c0254934986528b3ce9c4d34ff2fccad.camel@intel.com>
References: <20200414131542.25608-1-joro@8bytes.org>
         <20200417010335.31739-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200417010335.31739-1-drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Content-ID: <B8851D46B4E5F2468CD8AA858DAC2199-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org" <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: "heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org" <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

SGkgRGFuaWVsLA0KDQpPbiBGcmksIDIwMjAtMDQtMTcgYXQgMDk6MDMgKzA4MDAsIERhbmllbCBE
cmFrZSB3cm90ZToNCj4gSGkgSm9lcmcsDQo+IA0KPiA+IEhpLA0KPiA+IA0KPiA+IGhlcmUgaXMg
dGhlIHNlY29uZCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2gtc2V0LiBUaGUgZmlyc3QgdmVyc2lvbiB3
aXRoDQo+ID4gc29tZSBtb3JlIGludHJvZHVjdG9yeSB0ZXh0IGNhbiBiZSBmb3VuZCBoZXJlOg0K
PiA+IA0KPiA+IAlodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjAwNDA3MTgzNzQyLjQz
NDQtMS1qb3JvQDhieXRlcy5vcmcvDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBjb250aW51ZWQgaW1w
cm92ZW1lbnRzIGluIHRoaXMgYXJlYSENCj4gDQo+IEkgbWF5IGhhdmUgc3BvdHRlZCBhIHByb2Js
ZW0gd2l0aCBzZXR1cHMgbGlrZSBWTUQuDQo+IA0KPiBUaGUgY29yZSBQQ0kgYnVzIGlzIHNldCB1
cCBkdXJpbmcgZWFybHkgYm9vdC4NCj4gVGhlbiwgZm9yIHRoZSBQQ0kgYnVzLCB3ZSByZWFjaCBp
b21tdV9idXNfaW5pdCgpIC0+IGJ1c19pb21tdV9wcm9iZSgpLg0KPiBJbiB0aGVyZSwgd2UgY2Fs
bCBwcm9iZV9pb21tdV9ncm91cCgpIC0+IGRldl9pb21tdV9nZXQoKSBmb3IgZWFjaCBQQ0kNCj4g
ZGV2aWNlLCB3aGljaCBhbGxvY2F0ZXMgZGV2LT5pb21tdSBpbiBlYWNoIGNhc2UuIFNvIGZhciBz
byBnb29kLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGlzIGlzIHRoZSBsYXN0IHRpbWUg
dGhhdCB3ZSdsbCBjYWxsIGRldl9pb21tdV9nZXQoKS4NCj4gSWYgYW55IFBDSSBidXMgZGV2aWNl
cyBnZXQgYWRkZWQgYWZ0ZXIgdGhpcyBwb2ludCwgdGhleSBkbyBub3QgZ2V0IHBhc3NlZA0KPiB0
byBkZXZfaW9tbXVfZ2V0KCkuDQo+IA0KPiBTbyB3aGVuIHRoZSB2bWQgbW9kdWxlIGdldHMgbG9h
ZGVkIGxhdGVyLCBhbmQgY3JlYXRlcyBtb3JlIFBDSSBkZXZpY2VzLA0KPiB3ZSBlbmQgdXAgaW4g
aW9tbXVfYnVzX25vdGlmaWVyKCkgLT4gaW9tbXVfcHJvYmVfZGV2aWNlKCkNCj4gLT4gX19pb21t
dV9wcm9iZV9kZXZpY2UoKSB3aGljaCBkb2VzOg0KPiANCj4gCWRldi0+aW9tbXUtPmlvbW11X2Rl
diA9IGlvbW11X2RldjsNCj4gDQo+IGRldi0+aW9tbXUtPiBpcyBhIE5VTEwgZGVyZWZlcmVuY2Ug
YmVjYXVzZSBkZXZfaW9tbXVfZ2V0KCkgd2FzIG5ldmVyDQo+IGNhbGxlZCBmb3IgdGhpcyBuZXcg
ZGV2aWNlLg0KPiANCj4gRGFuaWVsDQo+IA0KDQpJIHNob3VsZCBoYXZlIENDZWQgeW91IG9uIHRo
aXMsIGJ1dCBpdCBzaG91bGQgdGVtcG9yYXJpbHkgcmVzb2x2ZSB0aGF0DQppc3N1ZToNCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9waXBlcm1haWwvaW9tbXUvMjAyMC1BcHJpbC8w
NDMyNTMuaHRtbA0KDQo=
