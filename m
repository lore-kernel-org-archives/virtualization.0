From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 7/8] vsock/virtio: increase RX buffer size to 64 KiB
Date: Mon, 13 May 2019 18:01:52 +0800
Message-ID: <bf0416f1-0e69-722d-75ce-3d101e6d7d71__20733.0698774726$1557741738$gmane$org@redhat.com>
References: <20190510125843.95587-1-sgarzare@redhat.com>
	<20190510125843.95587-8-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190510125843.95587-8-sgarzare@redhat.com>
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
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNS8xMCDkuIvljYg4OjU4LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gSW4g
b3JkZXIgdG8gaW5jcmVhc2UgaG9zdCAtPiBndWVzdCB0aHJvdWdocHV0IHdpdGggbGFyZ2UgcGFj
a2V0cywKPiB3ZSBjYW4gdXNlIDY0IEtpQiBSWCBidWZmZXJzLgo+Cj4gU2lnbmVkLW9mZi1ieTog
U3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaW5jbHVk
ZS9saW51eC92aXJ0aW9fdnNvY2suaCB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmly
dGlvX3Zzb2NrLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb192c29jay5oCj4gaW5kZXggODRiNzIw
MjZkMzI3Li41YTlkMjViZTcyZGYgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9f
dnNvY2suaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX3Zzb2NrLmgKPiBAQCAtMTAsNyAr
MTAsNyBAQAo+ICAgI2RlZmluZSBWSVJUSU9fVlNPQ0tfREVGQVVMVF9NSU5fQlVGX1NJWkUJMTI4
Cj4gICAjZGVmaW5lIFZJUlRJT19WU09DS19ERUZBVUxUX0JVRl9TSVpFCQkoMTAyNCAqIDI1NikK
PiAgICNkZWZpbmUgVklSVElPX1ZTT0NLX0RFRkFVTFRfTUFYX0JVRl9TSVpFCSgxMDI0ICogMjU2
KQo+IC0jZGVmaW5lIFZJUlRJT19WU09DS19ERUZBVUxUX1JYX0JVRl9TSVpFCSgxMDI0ICogNCkK
PiArI2RlZmluZSBWSVJUSU9fVlNPQ0tfREVGQVVMVF9SWF9CVUZfU0laRQkoMTAyNCAqIDY0KQo+
ICAgI2RlZmluZSBWSVJUSU9fVlNPQ0tfTUFYX0JVRl9TSVpFCQkweEZGRkZGRkZGVUwKPiAgICNk
ZWZpbmUgVklSVElPX1ZTT0NLX01BWF9QS1RfQlVGX1NJWkUJCSgxMDI0ICogNjQpCj4gICAKCgpX
ZSBwcm9iYWJseSBkb24ndCB3YW50IHN1Y2ggaGlnaCBvcmRlciBhbGxvY2F0aW9uLiBJdCdzIGJl
dHRlciB0byBzd2l0Y2ggCnRvIHVzZSBvcmRlciAwIHBhZ2VzIGluIHRoaXMgY2FzZS4gU2VlIGFk
ZF9yZWN2YnVmX2JpZygpIGZvciB2aXJ0aW8tbmV0LiAKSWYgd2UgZ2V0IGRhdGFwYXRoIHVuaWZp
ZWQsIHdlIHdpbGwgZ2V0IG1vcmUgc3R1ZmZzIHNldC4KClRoYW5rcwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
