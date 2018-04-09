From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RESEND v2] vhost-net: set packet weight of tx polling
	to 2 * vq size
Date: Mon, 09 Apr 2018 11:02:14 -0400 (EDT)
Message-ID: <20180409.110214.2099089634160123216.davem__8621.04022312469$1523286043$gmane$org@davemloft.net>
References: <88D661ADF6AFBF42B2AB88D8E7682B0901FC4A32@EXMBX-SZMAIL011.tencent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <88D661ADF6AFBF42B2AB88D8E7682B0901FC4A32@EXMBX-SZMAIL011.tencent.com>
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
YXRlOiBNb24sIDkgQXByIDIwMTggMDc6MjI6MTcgKzAwMDANCg0KPiBoYW5kbGVfdHggd2lsbCBk
ZWxheSByeCBmb3IgdGVucyBvciBldmVuIGh1bmRyZWRzIG9mIG1pbGxpc2Vjb25kcyB3aGVuIHR4
IGJ1c3kNCj4gcG9sbGluZyB1ZHAgcGFja2V0cyB3aXRoIHNtYWxsIGxlbmd0aChlLmcuIDFieXRl
IHVkcCBwYXlsb2FkKSwgYmVjYXVzZSBzZXR0aW5nDQo+IFZIT1NUX05FVF9XRUlHSFQgdGFrZXMg
aW50byBhY2NvdW50IG9ubHkgc2VudC1ieXRlcyBidXQgbm8gc2luZ2xlIHBhY2tldCBsZW5ndGgu
DQo+IA0KPiBQaW5nLUxhdGVuY2llcyBzaG93biBiZWxvdyB3ZXJlIHRlc3RlZCBiZXR3ZWVuIHR3
byBWaXJ0dWFsIE1hY2hpbmVzIHVzaW5nDQo+IG5ldHBlcmYgKFVEUF9TVFJFQU0sIGxlbj0xKSwg
YW5kIHRoZW4gYW5vdGhlciBtYWNoaW5lIHBpbmdlZCB0aGUgY2xpZW50Og0KIC4uLg0KPiBBY2tl
ZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogSGFpYmluIFpoYW5nIDxoYWliaW56aGFuZ0B0ZW5jZW50LmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogWXVuZmFuZyBUYWkgPHl1bmZhbmd0YWlAdGVuY2VudC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IExpZG9uZyBDaGVuIDxsaWRvbmdjaGVuQHRlbmNlbnQuY29tPg0KDQpBcHBsaWVkLCB0aGFuayB5
b3UuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
