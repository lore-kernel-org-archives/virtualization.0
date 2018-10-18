From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [RFC] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Thu, 18 Oct 2018 18:19:21 +0900
Message-ID: <55f14915-744b-e11c-bc50-87a872218479@lab.ntt.co.jp>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
	<68582c17-27bf-43f4-cbe5-96ec712a704c@lab.ntt.co.jp>
	<a281371f-dd20-2036-d0a8-1081c2f6a452@redhat.com>
	<20181018084753.wefvsypdevbzoadg@linutronix.de>
	<4849237d-38f5-9840-4ab9-4419de31db85@lab.ntt.co.jp>
	<20181018090812.rry5qgnqxxrjxaii@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181018090812.rry5qgnqxxrjxaii@linutronix.de>
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gMjAxOC8xMC8xOCAxODowOCwgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciB3cm90ZToKPiBP
biAyMDE4LTEwLTE4IDE4OjAwOjA1IFsrMDkwMF0sIFRvc2hpYWtpIE1ha2l0YSB3cm90ZToKPj4g
T24gMjAxOC8xMC8xOCAxNzo0NywgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciB3cm90ZToKPj4+
IE9uIDIwMTgtMTAtMTcgMTQ6NDg6MDIgWyswODAwXSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pgo+
Pj4+IE9uIDIwMTgvMTAvMTcg5LiK5Y2IOToxMywgVG9zaGlha2kgTWFraXRhIHdyb3RlOgo+Pj4+
PiBJJ20gbm90IHN1cmUgd2hhdCBjb25kaXRpb24gdHJpZ2dlcmVkIHRoaXMgd2FybmluZy4KPj4+
Cj4+PiBJZiB0aGUgc2VxbG9jayBpcyBhY3F1aXJlZCBvbmNlIGluIHNvZnRpcnEgYW5kIHRoZW4g
aW4gcHJvY2VzcyBjb250ZXh0Cj4+PiBhZ2FpbiBpdCBpcyBlbm91Z2ggZXZpZGVuY2UgZm9yIGxv
Y2tkZXAgdG8gdHJpZ2dlciB0aGlzIHdhcm5pbmcuCj4+Cj4+IE5vLiBBcyBJIHNhaWQgdGhhdCBz
aG91bGQgbm90IGhhcHBlbiBiZWNhdXNlIG9mIE5BUEkgZ3VhcmQuCj4gQWdhaW46IGxvY2tkZXAg
c2F3IHRoZSBsb2NrIGluIHNvZnRpcnEgY29udGV4dCBvbmNlIGFuZCBpbiBwcm9jZXNzCj4gY29u
dGV4dCBvbmNlIGFuZCB0aGlzIGlzIHdoYXQgdHJpZ2dlcnMgdGhlIHdhcm5pbmcuIEl0IGRvZXMg
bm90IG1hdHRlcgo+IGlmIE5BUEkgaXMgZW5hYmxlZCBvciBub3QgZHVyaW5nIHRoZSBhY2Nlc3Mg
aW4gcHJvY2VzcyBjb250ZXh0LiBJZiB5b3UKPiB3YW50IHRvIGFsbG93IHRoaXMgeW91IG5lZWQg
ZnVydGhlciBsb2NrZGVwIGFubm90YXRpb27igKYKPiAKPiDigKYgYnV0OiByZWZpbGxfd29yaygp
IGRpc2FibGVzIE5BUEkgZm9yICZ2aS0+cnFbMV0gYW5kIHJlZmlsbHMgKyB1cGRhdGVzCj4gc3Rh
dHMgd2hpbGUgTkFQSSBpcyBlbmFibGVkIGZvciAmdmktPnJxWzBdLgoKRG8geW91IG1lYW4gdGhp
cyBpcyBmYWxzZSBwb3NpdGl2ZT8gcnFbMF0gYW5kIHJxWzFdIG5ldmVyIHJhY2Ugd2l0aCBlYWNo
Cm90aGVyLi4uCgotLSAKVG9zaGlha2kgTWFraXRhCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
