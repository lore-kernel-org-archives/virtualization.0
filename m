From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Revert "virtio_console: Initialize guest_connected=true
	for rproc_serial"
Date: Tue, 12 Mar 2013 15:24:57 +1030
Message-ID: <87k3pdusim.fsf@rustcorp.com.au>
References: <1363014900-6425-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363014900-6425-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tIHdyaXRlczoKCj4gRnJvbTogU2p1ciBCcsOm
bmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgo+Cj4gVGhpcyByZXZlcnRz
IGNvbW1pdCA4MDc4ZGI3ODlhOTJiMTBmZjZlMmQ3MTMyMzFiNTM2N2UwMTRjNTNiLgo+Cj4gVGhl
IHJldmVydGVkIHBhdGNoIGNhdXNlZCBvcGVuaW5nIG9mIHBvcnRzIHRvIGZhaWwgZm9yIHJwcm9j
X3NlcmlhbC4KPiBJbiBwcm9iZSBndWVzdF9jb25uZWN0ZWQgd2FzIHNldCB0byB0cnVlLCBidXQg
cG9ydF9mb3BzX29wZW4oKQo+IGZhaWxzIHdpdGggLUVNRklMRSBpZiBndWVzdF9jb25uZWN0ZWQg
YWxyZWFkeSBpcyB0cnVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogU2p1ciBCcsOmbmRlbGFuZCA8c2p1
ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgo+IC0tLQo+IEhpIFJ1c3R5LAo+Cj4gSGVyZSBp
cyBhIGZpeCBpbnRlbmRlZCBmb3IgMy45Lgo+IFNvcnJ5IGZvciB0aGUgY2h1cm4gaGVyZSA6LSgK
CkFwcGxpZWQsClJ1c3R5LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
