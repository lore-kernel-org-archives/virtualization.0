From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vhost: remove the possible fruitless search on iotlb
	prefetch
Date: Mon, 21 Aug 2017 11:09:00 +0800
Message-ID: <3e8361c3-8a1b-6f30-80a1-1d45dabfdc39__33336.7446939976$1503284950$gmane$org@redhat.com>
References: <20170819064114.27219-1-den@klaipeden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170819064114.27219-1-den@klaipeden.com>
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
To: Koichiro Den <den@klaipeden.com>, mst@redhat.com
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE35bm0MDjmnIgxOeaXpSAxNDo0MSwgS29pY2hpcm8gRGVuIHdyb3RlOgo+IFNpZ25l
ZC1vZmYtYnk6IEtvaWNoaXJvIERlbiA8ZGVuQGtsYWlwZWRlbi5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL3Zob3N0L3Zob3N0LmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMg
Yi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBpbmRleCBlNDYxM2EzYzM2MmQuLjkzZTkwOWFmYzFj
MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysgYi9kcml2ZXJzL3Zo
b3N0L3Zob3N0LmMKPiBAQCAtMTE4NCw3ICsxMTg0LDcgQEAgc3RhdGljIGludCBpb3RsYl9hY2Nl
c3Nfb2soc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEsCj4gICAJd2hpbGUgKGxlbiA+IHMpIHsK
PiAgIAkJbm9kZSA9IHZob3N0X3VtZW1faW50ZXJ2YWxfdHJlZV9pdGVyX2ZpcnN0KCZ1bWVtLT51
bWVtX3RyZWUsCj4gICAJCQkJCQkJICAgYWRkciwKPiAtCQkJCQkJCSAgIGFkZHIgKyBsZW4gLSAx
KTsKPiArCQkJCQkJCSAgIGFkZHIgKyBsZW4gLSBzIC0gMSk7Cj4gICAJCWlmIChub2RlID09IE5V
TEwgfHwgbm9kZS0+c3RhcnQgPiBhZGRyKSB7Cj4gICAJCQl2aG9zdF9pb3RsYl9taXNzKHZxLCBh
ZGRyLCBhY2Nlc3MpOwo+ICAgCQkJcmV0dXJuIGZhbHNlOwoKQWNrZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
