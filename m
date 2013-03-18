From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2] Revert "virtio_console: Initialize guest_connected=true
	for rproc_serial"
Date: Mon, 18 Mar 2013 19:21:28 +1030
Message-ID: <878v5lrsz3.fsf@rustcorp.com.au>
References: <1363014900-6425-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130312073446.GB6786@amit.redhat.com>
	<CANHm3PgQuT=98dM2gU8mkN=RxzD9ruQ+cqa_NGKv2kZwS46c=Q@mail.gmail.com>
	<20130313100322.GB16740@amit.redhat.com>
	<1363173048-8247-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130318052700.GA18030@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130318052700.GA18030@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, sjur.brandeland@stericsson.com
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

QW1pdCBTaGFoIDxhbWl0LnNoYWhAcmVkaGF0LmNvbT4gd3JpdGVzOgo+IE9uIChXZWQpIDEzIE1h
ciAyMDEzIFsxMjoxMDo0OF0sIHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNzc29uLmNvbSB3cm90ZToK
Pj4gRnJvbTogU2p1ciBCcsODwqZuZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5j
b20+Cj4+IAo+PiAKPj4gVGhpcyByZXZlcnRzIGNvbW1pdCA4MDc4ZGI3ODlhOTJiMTBmZjZlMmQ3
MTMyMzFiNTM2N2UwMTRjNTNiLCBhbmQKPj4gYWRkcyBhIGxlbmd0aHkgY29tbWVudCBleHBsYWlu
aW5nIHRoZSBwcm9ibGVtIGFyZWEuCj4+IAo+PiBUaGUgcmV2ZXJ0ZWQgcGF0Y2ggY2F1c2VkIG9w
ZW5pbmcgb2YgcG9ydHMgdG8gZmFpbCBmb3IgcnByb2Nfc2VyaWFsLgo+PiBJbiBwcm9iZSBndWVz
dF9jb25uZWN0ZWQgd2FzIHNldCB0byB0cnVlLCBidXQgcG9ydF9mb3BzX29wZW4oKQo+PiBmYWls
cyB3aXRoIC1FTUZJTEUgaWYgZ3Vlc3RfY29ubmVjdGVkIGFscmVhZHkgaXMgdHJ1ZS4KPj4gCj4+
IFNpZ25lZC1vZmYtYnk6IFNqdXIgQnLDpm5kZWxhbmQgPHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNz
c29uLmNvbT4KPgo+IEFja2VkLWJ5OiBBbWl0IFNoYWggPGFtaXQuc2hhaEByZWRoYXQuY29tPgo+
Cj4gCQlBbWl0CgpBcHBsaWVkIHRvIG15IGZpeGVzIGJyYW5jaC4KClRoYW5rcywKUnVzdHkuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
