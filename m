From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv5 2/3] virtio_console: Add support for remoteproc serial
Date: Thu, 27 Sep 2012 09:22:24 +0930
Message-ID: <87haqk4a13.fsf@rustcorp.com.au>
References: <1348580837-10919-1-git-send-email-sjur.brandeland@stericsson.com>
	<1348580837-10919-3-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1348580837-10919-3-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, sjurbren@stericsson.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Linus Walleij <linus.walleij@linaro.org>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tIHdyaXRlczoKPiBGcm9tOiBTanVyIEJyw6Zu
ZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4KPiBBZGQgYSBzaW1wbGUg
c2VyaWFsIGNvbm5lY3Rpb24gZHJpdmVyIGNhbGxlZAo+IFZJUlRJT19JRF9SUFJPQ19TRVJJQUwg
KDExKSBmb3IgY29tbXVuaWNhdGluZyB3aXRoIGEKPiByZW1vdGUgcHJvY2Vzc29yIGluIGFuIGFz
eW1tZXRyaWMgbXVsdGktcHJvY2Vzc2luZwo+IGNvbmZpZ3VyYXRpb24uCj4KLi4uCj4gIHN0YXRp
YyBzdHJ1Y3QgcG9ydF9idWZmZXIgKmFsbG9jX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgc2l6
ZV90IGJ1Zl9zaXplLAo+ICAJCQkJICAgICBpbnQgbnJidWZzKQo+ICB7Cj4gIAlzdHJ1Y3QgcG9y
dF9idWZmZXIgKmJ1ZjsKPiAgCXNpemVfdCBhbGxvY19zaXplOwo+ICAKPiArCWlmIChpc19ycHJv
Y19zZXJpYWwodnEtPnZkZXYpICYmICFpcnFzX2Rpc2FibGVkKCkpCj4gKwkJcmVjbGFpbV9kbWFf
YnVmcygpOwoKSG1tLCB5b3UgbmVlZCBhIGdmcF90IGFyZyBpbnRvIGFsbG9jX2J1ZjsgeW91ciBs
YXN0IHBhdGNoIHNpbXBseSBjaGFuZ2VkCnRoZW0gYWxsIHRvIEdGUF9BVE9NSUMsIHdoaWNoIG1h
a2VzIHRoZSBjb25zb2xlIGZhciBsZXNzIG1lbW9yeQpmcmllbmRseS4KCllvdSBjaGVjayAhaXJx
c19kaXNhYmxlZCgpIGluIGEgY291cGxlIG9mIHBsYWNlczsgSSB0aGluayB0aGUgY2FsbGVyCm5l
ZWRzIHRvIGluZGljYXRlIChwb3NzaWJseSBieSBjaGVja2luZyBmb3IgZ2ZwID09IEdGUF9LRVJO
RUwpIHdoZXRoZXIKaXQncyBzYWZlIHRvIGNhbGwgcmVjbGFpbV9kbWFfYnVmcygpLgoKPiBAQCAt
ODM4LDYgKzkyNywxMCBAQCBzdGF0aWMgc3NpemVfdCBwb3J0X2ZvcHNfc3BsaWNlX3dyaXRlKHN0
cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUsCj4gIAkJLnUuZGF0YSA9ICZzZ2wsCj4gIAl9Owo+
ICAKPiArCS8qIHJwcm9jX3NlcmlhbCBkb2VzIG5vdCBzdXBwb3J0IHNwbGljZSAqLwo+ICsJaWYg
KGlzX3Jwcm9jX3NlcmlhbChwb3J0LT5vdXRfdnEtPnZkZXYpKQo+ICsJCXJldHVybiAtRUlOVkFM
OwoKV2h5IG5vdD8gOykKClRoYW5rcywKUnVzdHkuCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
