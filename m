From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCHv2] virtio: Introduce vringh wrappers in virtio_config
Date: Wed, 13 Mar 2013 11:12:28 +0100
Message-ID: <CAJK669avxo=jx1pL_cvLPOdS+19Y1hGS-VvOXEiT_diXOtzOqg@mail.gmail.com>
References: <1362737315-2894-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362737315-2894-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

SGkgT2hhZCwKCk9uIEZyaSwgTWFyIDgsIDIwMTMgYXQgMTE6MDggQU0sICA8c2p1ci5icmFuZGVs
YW5kQHN0ZXJpY3Nzb24uY29tPiB3cm90ZToKPiBGcm9tOiBTanVyIEJyw6ZuZGVsYW5kIDxzanVy
LmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4KPiBBZGQgd3JhcHBlcnMgZm9yIHRoZSBob3N0
IHZyaW5ncyB0byBzdXBwb3J0IGxvb3NlCj4gY291cGxpbmcgYmV0d2VlbiB0aGUgdmlydGlvIGRl
dmljZSBhbmQgZHJpdmVyLgo+Cj4gQSBuZXcgc3RydWN0IHZyaW5naF9jb25maWdfb3BzIHdpdGgg
dGhlIGZ1bmN0aW9ucwo+IGZpbmRfdnJocygpIGFuZCBkZWxfdnJocygpIGlzIGFkZGVkIHRvIHRo
ZSB2aXJ0aW9fZGV2aWNlCj4gc3RydWN0LiBUaGlzIGVuYWJsZXMgdmlydGlvIGRyaXZlcnMgdG8g
bWFuYWdlIHZpcnRpbwo+IGhvc3QgcmluZ3Mgd2l0aG91dCBkZXRhaWxlZCBrbm93bGVkZ2Ugb2Yg
aG93IHRoZQo+IHZyaW5ncyBhcmUgY3JlYXRlZCBhbmQgZGVsZXRlZC4KPgo+IFRoZSBmdW5jdGlv
biB2cmluZ2hfbm90aWZ5KCkgaXMgYWRkZWQgc28gdnJpbmdoIGNsaWVudHMKPiBjYW4gbm90aWZ5
IHRoZSBvdGhlciBzaWRlIHRoYXQgYnVmZmVycyBhcmUgYWRkZWQgdG8gdGhlCj4gdXNlZC1yaW5n
Lgo+Cj4gQ2M6IE9oYWQgQmVuLUNvaGVuIDxvaGFkQHdpemVyeS5jb20+Cj4gQ2M6IFJ1c3R5IFJ1
c3NlbGwgPHJ1c3R5QHJ1c3Rjb3JwLmNvbS5hdT4KPiBTaWduZWQtb2ZmLWJ5OiBTanVyIEJyw6Zu
ZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+CgpBcyB5b3UgaGF2ZSBiZWVu
IHB1c2hpbmcgZm9yIHRoaXMgd3JhcHBlciwgY291bGQgeW91IHBsZWFzZQphZGQgeW91ciBBY2sg
b3IgUmV2aWV3ZWQgdGFnIGlmIHlvdSBhcmUgaGFwcHkgd2l0aCB0aGlzIHBhdGNoPwoKVGhhbmtz
LApTanVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
