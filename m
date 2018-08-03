From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH net-next v7 3/4] net: vhost: factor out busy polling logic
	to vhost_net_busy_poll()
Date: Fri, 3 Aug 2018 12:32:22 +0900
Message-ID: <74edb26a-e715-cb49-4e52-62e4b45638d1@lab.ntt.co.jp>
References: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1533092454-37196-4-git-send-email-xiangxia.m.yue@gmail.com>
	<30e62749-3cbd-ae88-6582-c20087884b20@redhat.com>
	<CAMDZJNWX7L4P0yO+-PeDFu_tmtLSntihO7rcLPB2GK4eN9zbwQ@mail.gmail.com>
	<b4ffd376-6fa8-4d0c-5c3a-82d1b6e924d6@redhat.com>
	<ca040549-5eda-4a03-4295-17e6d7d44dd5@lab.ntt.co.jp>
	<3272c3b4-a44c-8554-329e-8a5e1a59aafd@redhat.com>
	<90c0deec-6a7b-9787-b62f-7ea76a5cbd7c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <90c0deec-6a7b-9787-b62f-7ea76a5cbd7c@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

T24gMjAxOC8wOC8wMyAxMjowNywgSmFzb24gV2FuZyB3cm90ZToKPiBPbiAyMDE45bm0MDjmnIgw
MuaXpSAxNzoyMywgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pgo+Pj4+Pj4gTm8gbmVlZCB0byBl
bmFibGUgcnggdmlydHF1ZXVlLCBpZiB3ZSBhcmUgc3VyZSBoYW5kbGVfcngoKSB3aWxsIGJlCj4+
Pj4+PiBjYWxsZWQgc29vbi4KPj4+Pj4gSWYgd2UgZGlzYWJsZSByeCB2aXJ0cXVldWUgaW4gaGFu
ZGxlX3R4IGFuZCBkb24ndCBzZW5kIHBhY2tldHMgZnJvbQo+Pj4+PiBndWVzdCBhbnltb3JlKGhh
bmRsZV90eCBpcyBub3QgY2FsbGVkKSwgc28gd2UgY2FuIHdha2UgdXAgZm9yIHNvY2sgcnguCj4+
Pj4+IHNvIHRoZSBuZXR3b3JrIGlzIGJyb2tlbi4KPj4+PiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQg
aGVyZS4gSSBtZWFuIGlzIHdlIHNjaGVkdWxlIHdvcmsgZm9yIGhhbmRsZV9yeCgpLAo+Pj4+IHRo
ZXJlJ3Mgbm8gbmVlZCB0byBlbmFibGUgaXQgc2luY2UgaGFuZGxlX3J4KCkgd2lsbCBkbyB0aGlz
IGZvciB1cy4KPj4+IExvb2tzIGxpa2UgaW4gdGhlIGxhc3QgImVsc2UiIGJsb2NrIGluIHZob3N0
X25ldF9idXN5X3BvbGxfY2hlY2soKSB3ZQo+Pj4gbmVlZCB0byBlbmFibGUgdnEgc2luY2UgaW4g
dGhhdCBjYXNlIHdlIGhhdmUgbm8gcnggZGF0YSBhbmQgaGFuZGxlX3J4KCkKPj4+IGlzIG5vdCBz
Y2hlZHVsZWQuCj4+Pgo+IFJldGhpbmsgYWJvdXQgdGhpcywgbG9va3Mgbm90LiBXZSBlbmFibGUg
cnggd2FrZXVwcyBpbiB0aGlzIGNhc2UsIHNvIGlmCj4gdGhlcmUncyBwZW5kaW5nIGRhdGEsIGhh
bmRsZV9yeCgpIHdpbGwgYmUgc2NoZWR1bGUgYWZ0ZXIKPiB2aG9zdF9uZXRfZW5hYmxlX3ZxKCku
CgpZb3UgYXJlIHJpZ2h0LCBidXQgd2hhdCBJIHdhbnRlZCB0byBzYXkgaXMgdmhvc3RfbmV0X2Vu
YWJsZV92cSgpIHNob3VsZApiZSBuZWVkZWQgKEkgd2FzIHRhbGtpbmcgYWJvdXQgd2hhdCB3b3Vs
ZCBoYXBwZW4gaWYKdmhvc3RfbmV0X2VuYWJsZV92cSgpIHdlcmUgcmVtb3ZlZCkuIEFsc28sIEkg
dGhpbmsgd2Ugc2hvdWxkIG1vdmUKdmhvc3RfbmV0X2VuYWJsZV92cSgpIGZyb20gdmhvc3RfbmV0
X2J1c3lfcG9sbCgpIHRvIHRoaXMgbGFzdCAiZWxzZSIKYmxvY2sgYmVjYXVzZSB0aGlzIGlzIHRo
ZSBjYXNlIHdoZXJlIHJ4IHdha2V1cHMgaXMgcmVxdWlyZWQuCkFueXdheSB0aGlzIHBhcnQgd2ls
bCBiZSByZWZhY3RvcmVkIHNvIGxldCdzIHNlZSB3aGF0IHRoaXMgY29kZSB3aWxsCmxvb2sgbGlr
ZSBpbiBuZXh0IHZlcnNpb24uCgotLSAKVG9zaGlha2kgTWFraXRhCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
