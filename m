From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv7 1/4] virtio_console: Free buffer if splice fails
Date: Tue, 23 Oct 2012 10:42:00 +1030
Message-ID: <87k3uihwrz.fsf@rustcorp.com.au>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
	<1350287856-5284-2-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350287856-5284-2-git-send-email-sjur.brandeland@stericsson.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tIHdyaXRlczoKPiBGcm9tOiBTanVyIEJyw6Zu
ZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4KPiBGcmVlIHRoZSBhbGxv
Y2F0ZWQgc2NhdHRlciBsaXN0IGlmIHNlbmRfcGFnZXMgZmFpbHMgaW4gZnVuY3Rpb24KPiBwb3J0
X3NwbGljZV93cml0ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFNqdXIgQnLDpm5kZWxhbmQgPHNqdXIu
YnJhbmRlbGFuZEBzdGVyaWNzc29uLmNvbT4KCkRpZG4ndCBzZWUgQW1pdCBhY2sgdGhpcywgYnV0
IGFwcGxpZWQgYW55d2F5LgoKVGhhbmtzLApSdXN0eS4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
