From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH vringh 2/2] caif_virtio: Introduce caif over virtio
Date: Tue, 19 Feb 2013 09:00:13 +1030
Message-ID: <87ppzxi7be.fsf__38995.6794483171$1361261014$gmane$org@rustcorp.com.au>
References: <1360494273-27889-1-git-send-email-sjur.brandeland@stericsson.com>
	<1360494273-27889-3-git-send-email-sjur.brandeland@stericsson.com>
	<87vc9zfic8.fsf@rustcorp.com.au>
	<81C3A93C17462B4BBD7E272753C105792458EDD161@EXDCVYMBSTM005.EQ1STM.local>
	<87ehgklds9.fsf@rustcorp.com.au>
	<CAJK669YQ+x5zXSZA1FQHkRrcCt+SgZP-M_ea-Ey8ziGLhq9cqQ@mail.gmail.com>
	<87bobmjish.fsf@rustcorp.com.au>
	<CAJK669ZATh8FojTGdFH_x7ovMvA2L7XFUratiptJmPFZPhv31g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJK669ZATh8FojTGdFH_x7ovMvA2L7XFUratiptJmPFZPhv31g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Cc: Vikram ARV <vikram.arv@stericsson.com>, Dmitry TARNYAGIN <dmitry.tarnyagin@stericsson.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, mst@redhat.com, Ido Yariv <ido@wizery.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Erwan YVIN <erwan.yvin@stericsson.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

U2p1ciBCcsOmbmRlbGFuZCA8c2p1cmJyZW5AZ21haWwuY29tPiB3cml0ZXM6Cgo+PiBTanVyIEJy
w6ZuZGVsYW5kIDxzanVyYnJlbkBnbWFpbC5jb20+IHdyaXRlczoKPj4+IEhvdyBhYm91dCBzdXBw
b3J0aW5nIHN0cnVjdCB2cmluZ2hfa2lvdiBhbmQgc3RydWN0IGt2ZWMgYXMgd2VsbD8KPj4+IEkg
Y3VycmVudGx5IGdldCB0aGUgZm9sbG93aW5nIGNvbXBsYWludHMgd2l0aCBteSBWMiBwYXRjaC1z
ZXQ6Cj4+Pgo+Pj4gZHJpdmVycy9uZXQvY2FpZi9jYWlmX3ZpcnRpby5jOjQ4NjoyOiB3YXJuaW5n
OiBwYXNzaW5nIGFyZ3VtZW50IDEgb2YKPj4+IOKAmHZyaW5naF9pb3ZfaW5pdOKAmSBmcm9tIGlu
Y29tcGF0aWJsZSBwb2ludGVyIHR5cGUgW2VuYWJsZWQgYnkgZGVmYXVsdF0KPj4KPj4gdnJpbmdo
X2tpb3ZfaW5pdCgpPyAgRGlkIEkgbWlzcyBzb21ldGhpbmcgZWxzZT8KPgo+IEkgZ2V0IGEgd2Fy
bmluZyBmb3IgbXkgdXNlb2YgdnJpbmdoX2lvdl9jbGVhbnVwKCkgaW4KPiBhZGRpdGlvbiB0byB0
aGUgb25lIGFib3ZlLgo+Cj4gSG93IGFib3V0IGFkZGluZyBraW92IHZhcmlhbnRzIG9mICB2cmlu
Z2hfaW92X2NsZWFudXAoKQo+IGFuZCB2cmluZ2hfaW92X3Jlc2V0KCkgYXMgd2VsbD8KCkhtbSwg
SSBoYXZlIHRob3NlIGhlcmUgdG9vIChpbiB0aGUgaGVhZGVyKToKCitzdGF0aWMgaW5saW5lIHZv
aWQgdnJpbmdoX2tpb3ZfcmVzZXQoc3RydWN0IHZyaW5naF9raW92ICpraW92KQoreworCWtpb3Yt
Pm9mZiA9IDA7CisJa2lvdi0+aSA9IDA7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCB2cmluZ2hf
a2lvdl9jbGVhbnVwKHN0cnVjdCB2cmluZ2hfa2lvdiAqa2lvdikKK3sKKwlpZiAoa2lvdi0+bWF4
X251bSAmIFZSSU5HSF9JT1ZfQUxMT0NBVEVEKQorCQlrZnJlZShraW92LT5pb3YpOworCWtpb3Yt
Pm1heF9udW0gPSBraW92LT51c2VkID0ga2lvdi0+aSA9IGtpb3YtPm9mZiA9IDA7CisJa2lvdi0+
aW92ID0gTlVMTDsKK30KCkkndmUgZm9sZGVkIHRoZSBwYXRjaGVzIGFuZCBwdXQgdGhlbSBpbnRv
IG15IHBlbmRpbmctcmViYXNlcyBicmFuY2gsCnJlYWR5IGZvciB2aXJ0aW8tbmV4dC4KCkknZCBy
ZWFsbHkgbGlrZSBNU1QncyBhY2sgb24gdGhpcywgdG9vLCBzbyBJJ2xsIHJlcG9zdCB0aGUgc2Vy
aWVzLgoKQ2hlZXJzLApSdXN0eS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
