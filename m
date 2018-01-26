From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 12/12] tools/virtio: fix smp_mb on x86
Date: Fri, 26 Jan 2018 15:45:33 +0200
Message-ID: <20180126154441-mutt-send-email-mst__37577.8463473127$1516974261$gmane$org@kernel.org>
References: <1516923320-16959-1-git-send-email-mst@redhat.com>
	<1516923320-16959-16-git-send-email-mst@redhat.com>
	<f2581b9f-9e0d-4db5-ee9d-a235bb0a1842@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f2581b9f-9e0d-4db5-ee9d-a235bb0a1842@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBKYW4gMjYsIDIwMTggYXQgMTE6NTY6MTRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiAKPiBPbiAyMDE45bm0MDHmnIgyNuaXpSAwNzozNiwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+ID4gT2Zmc2V0IDEyOCBvdmVybGFwcyB0aGUgbGFzdCB3b3JkIG9mIHRoZSByZWR6
b25lLgo+ID4gVXNlIDEzMiB3aGljaCBpcyBhbHdheXMgYmV5b25kIHRoYXQuCj4gPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gPiAtLS0K
PiA+ICAgdG9vbHMvdmlydGlvL3Jpbmd0ZXN0L21haW4uaCB8IDIgKy0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQg
YS90b29scy92aXJ0aW8vcmluZ3Rlc3QvbWFpbi5oIGIvdG9vbHMvdmlydGlvL3Jpbmd0ZXN0L21h
aW4uaAo+ID4gaW5kZXggNTkzYTMyOC4uMzAxZDU5YiAxMDA2NDQKPiA+IC0tLSBhL3Rvb2xzL3Zp
cnRpby9yaW5ndGVzdC9tYWluLmgKPiA+ICsrKyBiL3Rvb2xzL3ZpcnRpby9yaW5ndGVzdC9tYWlu
LmgKPiA+IEBAIC0xMTEsNyArMTExLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGJ1c3lfd2FpdCh2
b2lkKQo+ID4gICB9Cj4gPiAgICNpZiBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQoX19p
Mzg2X18pCj4gPiAtI2RlZmluZSBzbXBfbWIoKSAgICAgYXNtIHZvbGF0aWxlKCJsb2NrOyBhZGRs
ICQwLC0xMjgoJSVyc3ApIiA6OjogIm1lbW9yeSIsICJjYyIpCj4gCj4gSnVzdCB3b25kZXIgZGlk
ICJyc3AiIHdvcmsgZm9yIF9faTM4Nl9fID8KPiAKPiBUaGFua3MKCk9oIHlvdSBhcmUgcmlnaHQg
b2YgY291cnNlLiBQcm9iYWJseSBubyBvbmUgZXZlciBydW4gdGhpcyBvbmUgb24gaTM4NiA6KQpJ
J2xsIGFkZCBhIHBhdGNoIG9uIHRvcCBhcyB0aGlzIGlzIG5vdCBhIG5ldyBidWcuCgo+ID4gKyNk
ZWZpbmUgc21wX21iKCkgICAgIGFzbSB2b2xhdGlsZSgibG9jazsgYWRkbCAkMCwtMTMyKCUlcnNw
KSIgOjo6ICJtZW1vcnkiLCAiY2MiKQo+ID4gICAjZWxzZQo+ID4gICAvKgo+ID4gICAgKiBOb3Qg
dXNpbmcgX19BVE9NSUNfU0VRX0NTVCBzaW5jZSBnY2MgZG9jcyBzYXkgdGhleSBhcmUgb25seSBz
eW5jaHJvbml6ZWQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
