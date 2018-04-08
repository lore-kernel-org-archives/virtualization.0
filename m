From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost-net: set packet weight of tx polling to 2 * vq size
Date: Sun, 08 Apr 2018 12:52:30 -0400 (EDT)
Message-ID: <20180408.125230.1777996328363149390.davem__37956.747323233$1523206243$gmane$org@davemloft.net>
References: <88D661ADF6AFBF42B2AB88D8E7682B0901FC47D3@EXMBX-SZMAIL011.tencent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <88D661ADF6AFBF42B2AB88D8E7682B0901FC47D3@EXMBX-SZMAIL011.tencent.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haibinzhang@tencent.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, yunfangtai@tencent.com, lidongchen@tencent.com
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogaGFpYmluemhhbmco5byg5rW35paMKSA8aGFpYmluemhhbmdAdGVuY2VudC5jb20+DQpE
YXRlOiBGcmksIDYgQXByIDIwMTggMDg6MjI6MzcgKzAwMDANCg0KPiBoYW5kbGVfdHggd2lsbCBk
ZWxheSByeCBmb3IgdGVucyBvciBldmVuIGh1bmRyZWRzIG9mIG1pbGxpc2Vjb25kcyB3aGVuIHR4
IGJ1c3kNCj4gcG9sbGluZyB1ZHAgcGFja2V0cyB3aXRoIHNtYWxsIGxlbmd0aChlLmcuIDFieXRl
IHVkcCBwYXlsb2FkKSwgYmVjYXVzZSBzZXR0aW5nDQo+IFZIT1NUX05FVF9XRUlHSFQgdGFrZXMg
aW50byBhY2NvdW50IG9ubHkgc2VudC1ieXRlcyBidXQgbm8gc2luZ2xlIHBhY2tldCBsZW5ndGgu
DQo+IA0KPiBQaW5nLUxhdGVuY2llcyBzaG93biBiZWxvdyB3ZXJlIHRlc3RlZCBiZXR3ZWVuIHR3
byBWaXJ0dWFsIE1hY2hpbmVzIHVzaW5nDQo+IG5ldHBlcmYgKFVEUF9TVFJFQU0sIGxlbj0xKSwg
YW5kIHRoZW4gYW5vdGhlciBtYWNoaW5lIHBpbmdlZCB0aGUgY2xpZW50Og0KLi4uDQo+IFNpZ25l
ZC1vZmYtYnk6IEhhaWJpbiBaaGFuZyA8aGFpYmluemhhbmdAdGVuY2VudC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IFl1bmZhbmcgVGFpIDx5dW5mYW5ndGFpQHRlbmNlbnQuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBMaWRvbmcgQ2hlbiA8bGlkb25nY2hlbkB0ZW5jZW50LmNvbT4NCg0KTWljaGFlbCBh
bmQgSmFzb24sIHBsZWFzZSByZXZpZXcuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
