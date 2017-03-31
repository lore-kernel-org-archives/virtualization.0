From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/6] virtio: wrap find_vqs
Date: Fri, 31 Mar 2017 19:21:12 +0300
Message-ID: <20170331191905-mutt-send-email-mst__2301.57459523088$1490977291$gmane$org@kernel.org>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
	<1490820507-8005-2-git-send-email-mst@redhat.com>
	<72f533a2-482d-1956-b0fe-254e273e1818@redhat.com>
	<20170330173146-mutt-send-email-mst@kernel.org>
	<c388e4fd-2956-8894-31ec-31fe8b01e49f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c388e4fd-2956-8894-31ec-31fe8b01e49f@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBNYXIgMzEsIDIwMTcgYXQgMTI6MDQ6NTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiAKPiBPbiAyMDE35bm0MDPmnIgzMOaXpSAyMjozMiwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+ID4gT24gVGh1LCBNYXIgMzAsIDIwMTcgYXQgMDI6MDA6MDhQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIDIwMTflubQwM+aciDMw5pelIDA0OjQ4LCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gV2UgYXJlIGdvaW5nIHRvIGFkZCBtb3Jl
IHBhcmFtZXRlcnMgdG8gZmluZF92cXMsIGxldCdzIHdyYXAgdGhlIGNhbGwgc28KPiA+ID4gPiB3
ZSBkb24ndCBuZWVkIHRvIHR3ZWFrIGFsbCBkcml2ZXJzIGV2ZXJ5IHRpbWUuCj4gPiA+ID4gCj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luPG1zdEByZWRoYXQuY29tPgo+
ID4gPiA+IC0tLQo+ID4gPiBBIHF1aWNrIGdsYW5jZSBhbmQgaXQgbG9va3Mgb2ssIGJ1dCB3aGF0
IHRoZSBiZW5lZml0IG9mIHRoaXMgc2VyaWVzLCBpcyBpdAo+ID4gPiByZXF1aXJlZCBieSBvdGhl
ciBjaGFuZ2VzPwo+ID4gPiAKPiA+ID4gVGhhbmtzCj4gPiBZZXMgLSB0byBhdm9pZCB0b3VjaGlu
ZyBhbGwgZGV2aWNlcyB3aGVuIGRvaW5nIHRoZSByZXN0IG9mCj4gPiB0aGUgcGF0Y2hzZXQuCj4g
Cj4gTWF5YmUgSSdtIG5vdCBjbGVhci4gSSBtZWFuIHRoZSBiZW5lZml0IG9mIHRoaXMgc2VyaWVz
IG5vdCB0aGlzIHNpbmdsZQo+IHBhdGNoLiBJIGd1ZXNzIGl0IG1heSBiZSB1c2VkIGJ5IHlvdSBw
cm9wb3NhbCB0aGF0IGF2b2lkIHJlc2V0IHdoZW4gc2V0IFhEUD8KCkluIHBhcnRpY3VsYXIsIHll
cy4gSXQgZ2VuZXJhbGx5IHNpbXBsaWZpZXMgdGhpbmdzIHNpZ25pZmljYW50bHkgaWYKd2UgY2Fu
IGdldCB0aGUgdHJ1ZSBidWZmZXIgc2l6ZSBiYWNrLgoKPiBJZiB5ZXMsIGRvIHdlIHJlYWxseSB3
YW50IHRvIGRyb3Agc29tZSBwYWNrZXRzIGFmdGVyIFhEUCBpcyBzZXQ/Cj4gCj4gVGhhbmtzCgpX
ZSB3b3VsZCByYXRoZXIgbm90IGRyb3AgcGFja2V0cy4gV2UgY291bGQgZGV0ZWN0IGFuZCBjb3B5
IHRoZW0gdG8gbWFrZQpYRFAgd29yay4KCi0tIApNU1QKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
