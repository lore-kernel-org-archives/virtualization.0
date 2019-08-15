From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] virtio-net: lower min ring num_free for efficiency
Date: Thu, 15 Aug 2019 17:55:17 +0800
Message-ID: <f26c808a-180a-6c85-637c-17629f2906e4__47407.2011232906$1565862939$gmane$org@redhat.com>
References: <BYAPR14MB32058F4B2AD162F5421BB9B4A6AC0@BYAPR14MB3205.namprd14.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <BYAPR14MB32058F4B2AD162F5421BB9B4A6AC0@BYAPR14MB3205.namprd14.prod.outlook.com>
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
To: ? jiang <jiangkidd@hotmail.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>, "songliubraving@fb.com" <songliubraving@fb.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "hawk@kernel.org" <hawk@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "jiangran.jr@alibaba-inc.com" <jiangran.jr@alibaba-inc.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "ast@kernel.org" <ast@kernel.org>, "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOC8xNSDkuIvljYg1OjQyLCA/IGppYW5nIHdyb3RlOgo+IFRoaXMgY2hhbmdlIGxv
d2VycyByaW5nIGJ1ZmZlciByZWNsYWltIHRocmVzaG9sZCBmcm9tIDEvMipxdWV1ZSB0byBidWRn
ZXQKPiBmb3IgYmV0dGVyIHBlcmZvcm1hbmNlLiBBY2NvcmRpbmcgdG8gb3VyIHRlc3Qgd2l0aCBx
ZW11ICsgZHBkaywgcGFja2V0Cj4gZHJvcHBpbmcgaGFwcGVucyB3aGVuIHRoZSBndWVzdCBpcyBu
b3QgYWJsZSB0byBwcm92aWRlIGZyZWUgYnVmZmVyIGluCj4gYXZhaWwgcmluZyB0aW1lbHkgd2l0
aCBkZWZhdWx0IDEvMipxdWV1ZS4gVGhlIHZhbHVlIGluIHRoZSBwYXRjaCBoYXMgYmVlbgo+IHRl
c3RlZCBhbmQgZG9lcyBzaG93IGJldHRlciBwZXJmb3JtYW5jZS4KPgo+IFRlc3Qgc2V0dXA6IGlw
ZXJmMyB0byBnZW5lcmF0ZSBwYWNrZXRzIHRvIGd1ZXN0ICh0b3RhbCAzMG1pbnMsIHBwcyA0MDBr
LCBVRFApCj4gYXZnIHBhY2tldHMgZHJvcCBiZWZvcmU6IDI4NDIKPiBhdmcgcGFja2V0cyBkcm9w
IGFmdGVyOiAzNjAoLTg3LjMlKQo+Cj4gU2lnbmVkLW9mZi1ieTogamlhbmdraWRkIDxqaWFuZ2tp
ZGRAaG90bWFpbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyICst
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPiBpbmRleCAwZDQxMTVjOWUyMGIuLmJjMDhiZTc5MjVlYiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiBAQCAtMTMzMSw3ICsxMzMxLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3JlY2VpdmUoc3RydWN0
IHJlY2VpdmVfcXVldWUgKnJxLCBpbnQgYnVkZ2V0LAo+ICAgCQl9Cj4gICAJfQo+ICAgCj4gLQlp
ZiAocnEtPnZxLT5udW1fZnJlZSA+IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZShycS0+dnEpIC8g
Mikgewo+ICsJaWYgKHJxLT52cS0+bnVtX2ZyZWUgPiBtaW4oKHVuc2lnbmVkIGludClidWRnZXQs
IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZShycS0+dnEpKSAvIDIpIHsKPiAgIAkJaWYgKCF0cnlf
ZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0FUT01JQykpCj4gICAJCQlzY2hlZHVsZV9kZWxheWVkX3dv
cmsoJnZpLT5yZWZpbGwsIDApOwo+ICAgCX0KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
