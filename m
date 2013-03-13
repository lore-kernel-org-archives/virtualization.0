From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Revert "virtio_console: Initialize guest_connected=true
	for rproc_serial"
Date: Wed, 13 Mar 2013 10:47:22 +1030
Message-ID: <87boaoup9p.fsf@rustcorp.com.au>
References: <1363014900-6425-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130312073446.GB6786@amit.redhat.com>
	<CANHm3PgQuT=98dM2gU8mkN=RxzD9ruQ+cqa_NGKv2kZwS46c=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANHm3PgQuT=98dM2gU8mkN=RxzD9ruQ+cqa_NGKv2kZwS46c=Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjurbr@gmail.com>, Amit Shah <amit.shah@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

U2p1ciBCcsOmbmRlbGFuZCA8c2p1cmJyQGdtYWlsLmNvbT4gd3JpdGVzOgo+IE9uIFR1ZSwgTWFy
IDEyLCAyMDEzIGF0IDg6MzQgQU0sIEFtaXQgU2hhaCA8YW1pdC5zaGFoQHJlZGhhdC5jb20+IHdy
b3RlOgo+PiBPbiAoTW9uKSAxMSBNYXIgMjAxMyBbMTY6MTU6MDBdLCBzanVyLmJyYW5kZWxhbmRA
c3Rlcmljc3Nvbi5jb20gd3JvdGU6Cj4+PiBGcm9tOiBTanVyIEJyxIduZGVsYW5kIDxzanVyLmJy
YW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4+Pgo+Pj4gVGhpcyByZXZlcnRzIGNvbW1pdCA4MDc4
ZGI3ODlhOTJiMTBmZjZlMmQ3MTMyMzFiNTM2N2UwMTRjNTNiLgo+Pj4KPj4+IFRoZSByZXZlcnRl
ZCBwYXRjaCBjYXVzZWQgb3BlbmluZyBvZiBwb3J0cyB0byBmYWlsIGZvciBycHJvY19zZXJpYWwu
Cj4+PiBJbiBwcm9iZSBndWVzdF9jb25uZWN0ZWQgd2FzIHNldCB0byB0cnVlLCBidXQgcG9ydF9m
b3BzX29wZW4oKQo+Pj4gZmFpbHMgd2l0aCAtRU1GSUxFIGlmIGd1ZXN0X2Nvbm5lY3RlZCBhbHJl
YWR5IGlzIHRydWUuCj4+Cj4+IE9LLCBJIG1pc3NlZCB0aGF0LiAgQ2FuIHlvdSBhZGQgYSBjb21t
ZW50IG5lYXIgdGhlIDJuZCBodW5rIG1lbnRpb25pbmcKPj4gdGhpcz8KPgo+IE9rLCBJIGVuZGVk
IHVwIHJld3JpdGluZyB0aGUgd2hvbGUgY29tbWVudCBoZXJlIGluIG15IGF0dGVtcHQKPiB0byAi
bWVudGlvbiB0aGlzIi4gUGVyaGFwcyBpdCdzIGEgYml0IG92ZXIgdGhlIHRvcCB0byB3cml0ZSBh
IHNob3J0IGVzc2F5IHRvCj4gZXhwbGFpbiB0d28gY29kZSBsaW5lcywgYnV0IGFueXdheSBoZXJl
IGl0IGlzLiBMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluazoKCk9LLCBJJ2xsIGhvbGQgb250byB0
aGlzIHJldmVydCBmb3IgYSBiaXQgbG9uZ2VyIHRoZW4uICBQbGVhc2UgcmVzdWJtaXQKb25jZSB5
b3UncmUgaGFwcHkuCgpUaGFua3MsClJ1c3R5LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
