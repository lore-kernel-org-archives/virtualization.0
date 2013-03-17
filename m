From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2] Revert "virtio_console: Initialize guest_connected=true
	for rproc_serial"
Date: Mon, 18 Mar 2013 10:21:15 +1030
Message-ID: <874ng9twjw.fsf@rustcorp.com.au>
References: <1363014900-6425-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130312073446.GB6786@amit.redhat.com>
	<CANHm3PgQuT=98dM2gU8mkN=RxzD9ruQ+cqa_NGKv2kZwS46c=Q@mail.gmail.com>
	<20130313100322.GB16740@amit.redhat.com>
	<1363173048-8247-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363173048-8247-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: amit.shah@redhat.com
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, Sjur =?utf-8?B?QnLDg8Km?= =?utf-8?B?bmRlbGFuZA==?= <sjur.brandeland@stericsson.com>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tIHdyaXRlczoKPiBGcm9tOiBTanVyIEJyw4PC
pm5kZWxhbmQgPHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNzc29uLmNvbT4KPgo+Cj4gVGhpcyByZXZl
cnRzIGNvbW1pdCA4MDc4ZGI3ODlhOTJiMTBmZjZlMmQ3MTMyMzFiNTM2N2UwMTRjNTNiLCBhbmQK
PiBhZGRzIGEgbGVuZ3RoeSBjb21tZW50IGV4cGxhaW5pbmcgdGhlIHByb2JsZW0gYXJlYS4KPgo+
IFRoZSByZXZlcnRlZCBwYXRjaCBjYXVzZWQgb3BlbmluZyBvZiBwb3J0cyB0byBmYWlsIGZvciBy
cHJvY19zZXJpYWwuCj4gSW4gcHJvYmUgZ3Vlc3RfY29ubmVjdGVkIHdhcyBzZXQgdG8gdHJ1ZSwg
YnV0IHBvcnRfZm9wc19vcGVuKCkKPiBmYWlscyB3aXRoIC1FTUZJTEUgaWYgZ3Vlc3RfY29ubmVj
dGVkIGFscmVhZHkgaXMgdHJ1ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFNqdXIgQnLDpm5kZWxhbmQg
PHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNzc29uLmNvbT4KCk5lZWRzIEFtaXQncyBBY2suCgpUaGFu
a3MsClJ1c3R5LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
