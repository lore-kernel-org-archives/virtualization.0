From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v2 2/6] drm/fb-helper: Map DRM client buffer only when
	required
Date: Sun, 7 Jul 2019 16:25:32 +0200
Message-ID: <f437366d-9dc2-c160-3b52-ae3650a5e1a2__5569.42893178842$1562510099$gmane$org@tronnes.org>
References: <20190705092613.7621-1-tzimmermann@suse.de>
	<20190705092613.7621-3-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190705092613.7621-3-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com, sean@poorly.run, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpEZW4gMDUuMDcuMjAxOSAxMS4yNiwgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gVGhpcyBw
YXRjaCBjaGFuZ2VzIERSTSBjbGllbnRzIHRvIG5vdCBtYXAgdGhlIGJ1ZmZlciBieSBkZWZhdWx0
LiBUaGUKPiBidWZmZXIsIGxpa2UgYW55IGJ1ZmZlciBvYmplY3QsIHNob3VsZCBiZSBtYXBwZWQg
YW5kIHVubWFwcGVkIHdoZW4KPiBuZWVkZWQuCj4gCj4gQW4gdW5tYXBwZWQgYnVmZmVyIG9iamVj
dCBjYW4gYmUgZXZpY3RlZCB0byBzeXN0ZW0gbWVtb3J5IGFuZCBkb2VzCj4gbm90IGNvbnN1bWUg
dmlkZW8gcmFtIHVudGlsIGRpc3BsYXllZC4gVGhpcyBhbGxvd3MgdG8gdXNlIGdlbmVyaWMgZmJk
ZXYKPiBlbXVsYXRpb24gd2l0aCBkcml2ZXJzIGZvciBsb3ctbWVtb3J5IGRldmljZXMsIHN1Y2gg
YXMgYXN0IGFuZCBtZ2FnMjAwLgo+IAo+IFRoaXMgY2hhbmdlIGFmZmVjdHMgdGhlIGdlbmVyaWMg
ZnJhbWVidWZmZXIgY29uc29sZS4gSFctYmFzZWQgY29uc29sZXMKPiBtYXAgdGhlaXIgY29uc29s
ZSBidWZmZXIgb25jZSBhbmQga2VlcCBpdCBtYXBwZWQuIFVzZXJzcGFjZSBjYW4gbW1hcCB0aGlz
Cj4gYnVmZmVyIGludG8gaXRzIGFkZHJlc3Mgc3BhY2UuIFRoZSBzaGFkb3ctYnVmZmVyZWQgZnJh
bWVidWZmZXIgY29uc29sZQo+IG9ubHkgbmVlZHMgdGhlIGJ1ZmZlciBvYmplY3QgdG8gYmUgbWFw
cGVkIGR1cmluZyB1cGRhdGVzLiBXaGlsZSBub3QgYmVpbmcKPiB1cGRhdGVkIGZyb20gdGhlIHNo
YWRvdyBidWZmZXIsIHRoZSBidWZmZXIgb2JqZWN0IGNhbiByZW1haW4gdW5tYXBwZWQuCj4gVXNl
cnNwYWNlIHdpbGwgYWx3YXlzIG1tYXAgdGhlIHNoYWRvdyBidWZmZXIuCj4gCj4gdjI6Cj4gCSog
Y2hhbmdlIERSTSBjbGllbnQgdG8gbm90IG1hcCBidWZmZXIgYnkgZGVmYXVsdAo+IAkqIG1hbnVh
bGx5IG1hcCBjbGllbnQgYnVmZmVyIGZvciBmYmRldiB3aXRoIEhXIGZyYW1lYnVmZmVyCj4gCj4g
U2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+Cj4g
LS0tCgpSZXZpZXdlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
