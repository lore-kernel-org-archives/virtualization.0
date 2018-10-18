From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [RFC] virtio_net: add local_bh_disable() around
	u64_stats_update_begin
Date: Thu, 18 Oct 2018 18:00:05 +0900
Message-ID: <4849237d-38f5-9840-4ab9-4419de31db85@lab.ntt.co.jp>
References: <20181016165545.guksrl23ulcudxrk@linutronix.de>
	<68582c17-27bf-43f4-cbe5-96ec712a704c@lab.ntt.co.jp>
	<a281371f-dd20-2036-d0a8-1081c2f6a452@redhat.com>
	<20181018084753.wefvsypdevbzoadg@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181018084753.wefvsypdevbzoadg@linutronix.de>
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, tglx@linutronix.de, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gMjAxOC8xMC8xOCAxNzo0NywgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciB3cm90ZToKPiBP
biAyMDE4LTEwLTE3IDE0OjQ4OjAyIFsrMDgwMF0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9u
IDIwMTgvMTAvMTcg5LiK5Y2IOToxMywgVG9zaGlha2kgTWFraXRhIHdyb3RlOgo+Pj4gSSdtIG5v
dCBzdXJlIHdoYXQgY29uZGl0aW9uIHRyaWdnZXJlZCB0aGlzIHdhcm5pbmcuCj4gCj4gSWYgdGhl
IHNlcWxvY2sgaXMgYWNxdWlyZWQgb25jZSBpbiBzb2Z0aXJxIGFuZCB0aGVuIGluIHByb2Nlc3Mg
Y29udGV4dAo+IGFnYWluIGl0IGlzIGVub3VnaCBldmlkZW5jZSBmb3IgbG9ja2RlcCB0byB0cmln
Z2VyIHRoaXMgd2FybmluZy4KCk5vLiBBcyBJIHNhaWQgdGhhdCBzaG91bGQgbm90IGhhcHBlbiBi
ZWNhdXNlIG9mIE5BUEkgZ3VhcmQuCgotLSAKVG9zaGlha2kgTWFraXRhCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
