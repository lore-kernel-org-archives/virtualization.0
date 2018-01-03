From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 00/13] remove_conflicting_framebuffers() cleanup
Date: Wed, 03 Jan 2018 16:04:15 +0100
Message-ID: <1733339.3qeImzqeL4__17485.3512472056$1515606682$gmane$org@amdc3058>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
	<CGME20171127103053epcas2p1b42cdcd817182cf468eb96ec16de9370@epcas2p1.samsung.com>
	<20171127103044.faakzch7ehlkc3or@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <20171127103044.faakzch7ehlkc3or@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, libnux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Alex Deucher <alexander.deucher@amd.com>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jonathan Hunter <jonathanh@nvidia.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uZGF5LCBOb3ZlbWJlciAyNywgMjAxNyAxMTozMDo0NCBBTSBEYW5pZWwgVmV0dGVyIHdy
b3RlOgo+IE9uIEZyaSwgTm92IDI0LCAyMDE3IGF0IDA2OjUzOjI1UE0gKzAxMDAsIE1pY2hhxYIg
TWlyb3PFgmF3IHdyb3RlOgo+ID4gVGhpcyBzZXJpZXMgY2xlYW5zIHVwIGR1cGxpY2F0ZWQgY29k
ZSBmb3IgcmVwbGFjaW5nIGZpcm13YXJlIEZCCj4gPiBkcml2ZXIgd2l0aCBwcm9wZXIgRFJJIGRy
aXZlciBhbmQgYWRkcyBoYW5kb3ZlciBzdXBwb3J0IHRvCj4gPiBUZWdyYSBkcml2ZXIuCgpQbGVh
c2UgQ2M6IG1lIG9uIGFuZCBsaW51eC1mYmRldiBNTCBvbiBmYmRldiByZWxhdGVkIHBhdGNoZXMK
KEkgd2FzIENjOi1lZCBvbmx5IG9uIHRoZSBjb3ZlciBsZXR0ZXIgYW5kIHBhdGNoICMxMCwgbGlu
dXgtZmJkZXYKd2FzIG5vdCBDYzotZWQgYXQgYWxsKS4KCj4gPiBUaGUgbGFzdCBwYXRjaCBpcyBo
ZXJlIGJlY2F1c2UgaXQgdXNlcyBuZXcgc2VtYW50aWNzIG9mCj4gPiByZW1vdmVfY29uZmxpY3Rp
bmdfZnJhbWVidWZmZXJzKCkgZnJvbSB0aGlzIHNlcmllcy4gVGhpcwo+ID4gY2FuIGJlIGNvbnNp
ZGVyZWQgaW5kZXBlbmRlbnRseSwgdGhvdWdoLgo+IAo+IEV4Y2VwdCBmb3IgdGhhdCBwYXRjaGVz
IEkndmUgY29tbWVudGVkIG9uOgo+IAo+IEFja2VkLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwu
dmV0dGVyQGZmd2xsLmNoPgo+IAo+IFNpbmNlIHRoaXMgaXMgZm9yIHRlZ3JhIGFuZCBUaGllcnJ5
IGhhcyBkcm0tbWlzYyBjb21taXQgcmlnaHRzLCBpdCdzCj4gcHJvYmFibHkgc2ltcGxlc3Qgd2hl
biBUaGllcnJ5IHB1c2hlcyB0aGlzIGFsbCB0byBkcm0tbWlzYyBvbmNlIGRyaXZlcgo+IG1haW50
YWluZXJzIGhhZCBhIGNoYW5jZSB0byBsb29rIGF0IGl0LiBBbHNvIG5lZWRzIGFuZCBhY2sgZnJv
bSBCYXJ0IGZvcgo+IHRoZSBmYmRldiBzaWRlcy4KCkZvciBmYmRldiBjaGFuZ2VzOgoKQWNrZWQt
Ynk6IEJhcnRsb21pZWogWm9sbmllcmtpZXdpY3ogPGIuem9sbmllcmtpZUBzYW1zdW5nLmNvbT4K
CkJlc3QgcmVnYXJkcywKLS0KQmFydGxvbWllaiBab2xuaWVya2lld2ljegpTYW1zdW5nIFImRCBJ
bnN0aXR1dGUgUG9sYW5kClNhbXN1bmcgRWxlY3Ryb25pY3MKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
