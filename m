From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Thu, 18 Oct 2018 11:08:12 +0200
Message-ID: <20181018090812.rry5qgnqxxrjxaii__45025.4081785262$1539853578$gmane$org@linutronix.de>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
	<68582c17-27bf-43f4-cbe5-96ec712a704c@lab.ntt.co.jp>
	<a281371f-dd20-2036-d0a8-1081c2f6a452@redhat.com>
	<20181018084753.wefvsypdevbzoadg@linutronix.de>
	<4849237d-38f5-9840-4ab9-4419de31db85@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4849237d-38f5-9840-4ab9-4419de31db85@lab.ntt.co.jp>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gMjAxOC0xMC0xOCAxODowMDowNSBbKzA5MDBdLCBUb3NoaWFraSBNYWtpdGEgd3JvdGU6Cj4g
T24gMjAxOC8xMC8xOCAxNzo0NywgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciB3cm90ZToKPiA+
IE9uIDIwMTgtMTAtMTcgMTQ6NDg6MDIgWyswODAwXSwgSmFzb24gV2FuZyB3cm90ZToKPiA+Pgo+
ID4+IE9uIDIwMTgvMTAvMTcg5LiK5Y2IOToxMywgVG9zaGlha2kgTWFraXRhIHdyb3RlOgo+ID4+
PiBJJ20gbm90IHN1cmUgd2hhdCBjb25kaXRpb24gdHJpZ2dlcmVkIHRoaXMgd2FybmluZy4KPiA+
IAo+ID4gSWYgdGhlIHNlcWxvY2sgaXMgYWNxdWlyZWQgb25jZSBpbiBzb2Z0aXJxIGFuZCB0aGVu
IGluIHByb2Nlc3MgY29udGV4dAo+ID4gYWdhaW4gaXQgaXMgZW5vdWdoIGV2aWRlbmNlIGZvciBs
b2NrZGVwIHRvIHRyaWdnZXIgdGhpcyB3YXJuaW5nLgo+IAo+IE5vLiBBcyBJIHNhaWQgdGhhdCBz
aG91bGQgbm90IGhhcHBlbiBiZWNhdXNlIG9mIE5BUEkgZ3VhcmQuCkFnYWluOiBsb2NrZGVwIHNh
dyB0aGUgbG9jayBpbiBzb2Z0aXJxIGNvbnRleHQgb25jZSBhbmQgaW4gcHJvY2Vzcwpjb250ZXh0
IG9uY2UgYW5kIHRoaXMgaXMgd2hhdCB0cmlnZ2VycyB0aGUgd2FybmluZy4gSXQgZG9lcyBub3Qg
bWF0dGVyCmlmIE5BUEkgaXMgZW5hYmxlZCBvciBub3QgZHVyaW5nIHRoZSBhY2Nlc3MgaW4gcHJv
Y2VzcyBjb250ZXh0LiBJZiB5b3UKd2FudCB0byBhbGxvdyB0aGlzIHlvdSBuZWVkIGZ1cnRoZXIg
bG9ja2RlcCBhbm5vdGF0aW9u4oCmCgrigKYgYnV0OiByZWZpbGxfd29yaygpIGRpc2FibGVzIE5B
UEkgZm9yICZ2aS0+cnFbMV0gYW5kIHJlZmlsbHMgKyB1cGRhdGVzCnN0YXRzIHdoaWxlIE5BUEkg
aXMgZW5hYmxlZCBmb3IgJnZpLT5ycVswXS4KClNlYmFzdGlhbgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
