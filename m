From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
	throughput
Date: Tue, 9 Apr 2019 16:36:22 +0800
Message-ID: <1484dbc0-0413-b21a-6a48-be58da9cb722__49903.0684631848$1554799012$gmane$org@redhat.com>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<a98d194d-e257-41ff-82e7-de2d16d2f4d4@redhat.com>
	<20190408094416.GQ15001@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190408094416.GQ15001@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Stefano Garzarella <sgarzare@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNC84IOS4i+WNiDU6NDQsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToKPiBPbiBNb24s
IEFwciAwOCwgMjAxOSBhdCAwMjo0MzoyOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBB
bm90aGVyIHRoaW5nIHRoYXQgbWF5IGhlbHAgaXMgdG8gaW1wbGVtZW50IHNlbmRwYWdlKCksIHdo
aWNoIHdpbGwgZ3JlYXRseQo+PiBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZS4KPiBJIGNhbid0IGZp
bmQgZG9jdW1lbnRhdGlvbiBmb3IgLT5zZW5kcGFnZSgpLiAgSXMgdGhlIGlkZWEgdGhhdCB5b3Ug
Z2V0IGEKPiBzdHJ1Y3QgcGFnZSBmb3IgdGhlIHBheWxvYWQgYW5kIGNhbiBkbyB6ZXJvLWNvcHkg
dHg/CgoKWWVzLgoKCj4gICAoQW5kIGNhbiB1c2Vyc3BhY2UKPiBzdGlsbCB3cml0ZSB0byB0aGUg
cGFnZSwgaW52YWxpZGF0aW5nIGNoZWNrc3VtcyBpbiB0aGUgaGVhZGVyPykKPgo+IFN0ZWZhbgoK
ClVzZXJzcGFjZSBjYW4gc3RpbGwgd3JpdGUgdG8gdGhlIHBhZ2UsIGJ1dCBmb3IgY29ycmVjdG5l
c3MgKGUuZyBpbiB0aGUgCmNhc2Ugb2YgU1BMSUNFX0ZfR0lGVCBkZXNjcmliZSBieSB2bXNwbGlj
ZSgyKSksIGl0IHNob3VsZCBub3QgZG8gdGhpcy4gCkZvciB2bXNwbGljZSwgaXQgbWF5IGhhcmQg
dG8gZGV0ZWN0IHRoZSB0aW1lIHRvIHJldXNlIHRoZSBwYWdlLiBNYXliZSB3ZSAKTVNHX1pFUk9D
T1BZWzFdIGlzIGJldHRlci4KCkFueXdheSwgc2VuZHBhZ2UoKSBjb3VsZCBiZSBzdGlsbCB1c2Vm
dWwgZm9yIHNlbmRmaWxlKCkgb3Igc3BsaWNlKCkuCgpUaGFua3MKClsxXSBodHRwczovL25ldGRl
dmNvbmYub3JnLzIuMS9wYXBlcnMvbmV0ZGV2LnBkZgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
