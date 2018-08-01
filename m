From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: correctly update XDP_TX counters
Date: Wed, 1 Aug 2018 09:31:48 +0800
Message-ID: <ffbfa3ba-3019-5324-4ecb-eb7a2699a4e8@redhat.com>
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
	<2cdb8081-90a8-3a87-b6a6-4395825594a1@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2cdb8081-90a8-3a87-b6a6-4395825594a1@lab.ntt.co.jp>
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
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDfmnIgzMeaXpSAxNzo1NywgVG9zaGlha2kgTWFraXRhIHdyb3RlOgo+IE9u
IDIwMTgvMDcvMzEgMTg6NDMsIEphc29uIFdhbmcgd3JvdGU6Cj4+IENvbW1pdCA1YjhmM2M4ZDMw
YTYgKCJ2aXJ0aW9fbmV0OiBBZGQgWERQIHJlbGF0ZWQgc3RhdHMiKSB0cmllcyB0bwo+PiBjb3Vu
dCBUWCBYRFAgc3RhdHMgaW4gdmlydG5ldF9yZWNlaXZlKCkuIFRoaXMgd2lsbCBjYXVzZSBzZXZl
cmFsCj4+IGlzc3VlczoKPj4KPj4gLSB2aXJ0bmV0X3hkcF9zcSgpIHdhcyBjYWxsZWQgd2l0aG91
dCBjaGVja2luZyB3aGV0aGVyIG9yIG5vdCBYRFAgaXMKPj4gICAgc2V0LiBUaGlzIG1heSBjYXVz
ZSBvdXQgb2YgYm91bmQgYWNjZXNzIHdoZW4gdGhlcmUncyBubyBlbm91Z2ggdHhxCj4+ICAgIGZv
ciBYRFAuCj4+IC0gU3RhdHMgd2VyZSB1cGRhdGVkIGV2ZW4gaWYgdGhlcmUncyBubyBYRFAvWERQ
X1RYLj4KPj4gRml4aW5nIHRoaXMgYnkgcmV1c2luZyB2aXJ0bmV0X3hkcF94bWl0KCkgZm9yIFhE
UF9UWCB3aGljaCBjYW4gY291bnRzCj4+IFRYIFhEUCBjb3VudGVyIGl0c2VsZiBhbmQgcmVtb3Zl
IHRoZSB1bm5lY2Vzc2FyeSB0eCBzdGF0cyBlbWJlZGRlZCBpbgo+PiByeCBzdGF0cy4KPiBUaGFu
a3MgZm9yIGZpeGluZyB0aGlzLgo+IEkgd2FudGVkIHRvIGF2b2lkIGNhbGxpbmcgdTY0X3N0YXRz
X3VwZGF0ZV9iZWdpbigpIChpLmUuIHNtcF93bWIoKSBpbiAzMgo+IGJpdCBzeXN0ZW1zKSBmb3Ig
ZXZlcnkgcGFja2V0LiBTbyBJJ2QgbGlrZSB0byBrZWVwIHNxIHN0YXRzIGluCj4gdmlydG5ldF9y
eF9zdGF0cy4KPgoKV2UgY2FuIG9wdGltaXplIHRoaXMgYnkgYWRkaW5nIGJhdGNoaW5nIG9uIHRv
cC4gKHZpcnRuZXRfeGRwX3htaXQoKSAKYWNjZXB0cyBhbiBhcnJheSBvZiB4ZHAgZnJhbWVzKS4g
SWYgeW91IGxpa2UsIHBsZWFzZSBzZW5kIGEgcGF0Y2ggZm9yIHRoaXMuCgpUaGFua3MKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
