From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_net: enable tx after resuming from suspend
Date: Thu, 11 Oct 2018 17:44:01 +0800
Message-ID: <dd530053-efab-b661-3423-1faaab8fb12f__45044.1501023763$1539250927$gmane$org@redhat.com>
References: <20181011075127.2608-1-ake@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181011075127.2608-1-ake@igel.co.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ake Koomsin <ake@igel.co.jp>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MTDmnIgxMeaXpSAxNTo1MSwgQWtlIEtvb21zaW4gd3JvdGU6Cj4gY29tbWl0
IDcxM2E5OGQ5MGM1ZSAoInZpcnRpby1uZXQ6IHNlcmlhbGl6ZSB0eCByb3V0aW5lIGR1cmluZyBy
ZXNldCIpCj4gZGlzYWJsZWQgdGhlIHZpcnRpbyB0eCBiZWZvcmUgZ29pbmcgdG8gc3VzcGVuZCB0
byBhdm9pZCBhIHVzZSBhZnRlciBmcmVlLgo+IEhvd2V2ZXIsIGFmdGVyIHJlc3VtaW5nLCBpdCBj
YXVzZXMgdGhlIHZpcnRpb19uZXQgZGV2aWNlIHRvIGxvc2UgaXRzCj4gbmV0d29yayBjb25uZWN0
aXZpdHkuCj4KPiBUbyBzb2x2ZSB0aGUgaXNzdWUsIHdlIG5lZWQgdG8gZW5hYmxlIHR4IGFmdGVy
IHJlc3VtaW5nLgo+Cj4gRml4ZXMgY29tbWl0IDcxM2E5OGQ5MGM1ZSAoInZpcnRpby1uZXQ6IHNl
cmlhbGl6ZSB0eCByb3V0aW5lIGR1cmluZyByZXNldCIpCj4gU2lnbmVkLW9mZi1ieTogQWtlIEtv
b21zaW4gPGFrZUBpZ2VsLmNvLmpwPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBp
bmRleCBkYWI1MDRlYzVlNTAuLjM0NTNkODBmNWY4MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMjI1
Niw2ICsyMjU2LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Jlc3RvcmVfdXAoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYpCj4gICAJfQo+ICAgCj4gICAJbmV0aWZfZGV2aWNlX2F0dGFjaCh2aS0+
ZGV2KTsKPiArCW5ldGlmX3N0YXJ0X3F1ZXVlKHZpLT5kZXYpOwoKSSBiZWxpZXZlIHRoaXMgaXMg
ZHVwbGljYXRlZCB3aXRoIG5ldGlmX3R4X3dha2VfYWxsX3F1ZXVlcygpIGluIApuZXRpZl9kZXZp
Y2VfYXR0YWNoKCkgYWJvdmU/CgpUaGFua3MKCj4gICAJcmV0dXJuIGVycjsKPiAgIH0KPiAgIAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
