From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 02/13] fbdev: add remove_conflicting_pci_framebuffers()
Date: Mon, 27 Nov 2017 20:52:19 +0000
Message-ID: <20171127205219.GA3537__37313.7507508092$1511815967$gmane$org@sudip-laptop>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
	<1738dbed0239bffc886f126fd3091daa39cd14c9.1511544782.git.mirq-linux@rere.qmqm.pl>
	<20171127102758.y7c6yzyey6wfntxh@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171127102758.y7c6yzyey6wfntxh@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBOb3YgMjcsIDIwMTcgYXQgMTE6Mjc6NTlBTSArMDEwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBGcmksIE5vdiAyNCwgMjAxNyBhdCAwNjo1MzozMVBNICswMTAwLCBNaWNoYcWC
IE1pcm9zxYJhdyB3cm90ZToKPiA+IEFsbW9zdCBhbGwgZHJpdmVycyB1c2luZyByZW1vdmVfY29u
ZmxpY3RpbmdfZnJhbWVidWZmZXJzKCkgd3JhcCBpdCB3aXRoCj4gPiB0aGUgc2FtZSBjb2RlLiBF
eHRyYWN0IGNvbW1vbiBwYXJ0IGZyb20gUENJIGRyaXZlcnMgaW50byBzZXBhcmF0ZQo+ID4gcmVt
b3ZlX2NvbmZsaWN0aW5nX3BjaV9mcmFtZWJ1ZmZlcnMoKS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1i
eTogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBsPgo+IAo+IFNpbmNl
IHRoZSBvbmx5IGRyaXZlciB0aGF0IHNlZW1zIHRvIHVzZSB0aGlzIGlzIHRoZSBzdGFnaW5nIG9u
ZSwgd2hpY2ggaW1vCj4gaXMgYSBET0EgcHJvamVjdCwgbm90IHN1cmUgaXQncyB3b3J0aCB0byBi
b3RoZXIgd2l0aCB0aGlzIGhlcmUuCgphZmFpaywgdGhpcyBkZXZpY2UgaXMgdXNlZCBpbiBwcm9k
dWN0aW9uIGJ5IGZldyBtYW51ZmFjdHVyZXJzIGFuZCBpdCBpcwp1c2VmdWxsIGZvciB0aGVtIHRv
IGhhdmUgaXQgaW4gdGhlIHRyZWUgYW5kIHRoZSBvbmx5IHJlYXNvbiBpdCBpcyBzdGlsbAppbiBz
dGFnaW5nIGlzIGJlY2F1c2UgVG9taSBhbm5vdW5jZWQgaGUgd2lsbCBub3QgdGFrZSBhbnkgbmV3
IGRyaXZlcnMgaW4KZmJkZXYuIEFuZCwgc28gSSBoYXZlIG5vdCB0YWtlbiB0aGUgaW5pdGlhdGl2
ZSB0byBwcm9wZXJseSBtb3ZlIGl0IG91dApvZiBzdGFnaW5nLiBJIHRoaW5rIEJhcnRsb21pZWog
d2lsbCBhbHNvIG5vdCBhY2NlcHQgbmV3IGRyaXZlcnMgaW4gZmJkZXYuCgoKLS0KUmVnYXJkcwpT
dWRpcCAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
