From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFCv2 1/2] virtio_console: Add support for DMA memory allocation
Date: Mon, 10 Sep 2012 17:23:52 +0930
Message-ID: <87zk4ye2jz.fsf@rustcorp.com.au>
References: <1347001066-13521-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1347001066-13521-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjurbren@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tIHdyaXRlczoKCj4gRnJvbTogU2p1ciBCcsOm
bmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgo+Cj4gQWRkIGZlYXR1cmUg
VklSVElPX0NPTlNPTEVfRl9ETUFfTUVNLiBJZiB0aGUgYXJjaGl0ZWN0dXJlIGhhcwo+IERNQSBz
dXBwb3J0IGFuZCB0aGlzIGZlYXR1cmUgYml0IGlzIHNldCwgdGhlIHZpcnRpbyBkYXRhIGJ1ZmZl
cnMKPiB3aWxsIGJlIGFsbG9jYXRlZCBmcm9tIERNQSBtZW1vcnkuIElmIHRoZSBkZXZpY2UgcmVx
dWVzdHMKPiB0aGUgZmVhdHVyZSBWSVJUSU9fQ09OU09MRV9GX0RNQV9NRU0sIGJ1dCB0aGUgYXJj
aGl0ZWN0dXJlCj4gZG9uJ3Qgc3VwcG9ydCBETUEgdGhlIGRyaXZlcidzIHByb2JlIGZ1bmN0aW9u
IHdpbGwgZmFpbC4KPgo+IFRoaXMgaXMgbmVlZGVkIGZvciB1c2luZyB2aXJ0aW9fY29uc29sZSBm
cm9tIHRoZSByZW1vdGVwcm9jCj4gZnJhbWV3b3JrLgoKU29ycnkgZm9yIHRoZSBiYWNrIGFuZCBm
b3J0aCwgSSd2ZSBiZWVuIHBvbmRlcmluZyBNU1QncyBwb2ludHMuCgpJZiB3ZSBtYWtlIGEgbmV3
IGRtYS1tdWx0aXBvcnQgZGV2aWNlIChlZy4gSUQgMTEpLCBob3cgdWdseSBpcyB0aGUgY29kZT8K
Ckl0IHdvdWxkIGJlIGEgdmlydGlvIGNvbnNvbGUgd2l0aCBETUEgYnVmZmVycyBhbmQgbm8gY29u
c29sZSwganVzdCB0aGUKbXVsdGlwb3J0IHN0dWZmLiAgVGhpcyB3b3VsZCBoYXZlIG5vIGltcGFj
dCBvbiB0aGUgY3VycmVudCBzcGVjIGZvcgp2aXJ0aW8gY29uc29sZS4KClRoYW5rcywKUnVzdHku
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
