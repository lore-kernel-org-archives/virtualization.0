From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 46/62] x86/sev-es: Handle INVD Events
Date: Tue, 11 Feb 2020 16:12:19 -0800
Message-ID: <EA510462-A43C-4F7E-BFE8-B212003B3627@amacapital.net>
References: <20200211135256.24617-47-joro@8bytes.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200211135256.24617-47-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <JGross@suse.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

Cgo+IE9uIEZlYiAxMSwgMjAyMCwgYXQgNTo1MyBBTSwgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRl
cy5vcmc+IHdyb3RlOgo+IAo+IO+7v0Zyb206IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5
QGFtZC5jb20+Cj4gCj4gSW1wbGVtZW50IGEgaGFuZGxlciBmb3IgI1ZDIGV4Y2VwdGlvbnMgY2F1
c2VkIGJ5IElOVkQgaW5zdHJ1Y3Rpb25zLgoKVWgsIHdoYXQ/ICBTdXJlbHkgdGhlICNWQyBjb2Rl
IGNhbiBoYXZlIGEgY2F0Y2gtYWxsIE9PUFMgcGF0aCBmb3IgdGhpbmdzIGxpa2UgdGhpcy4gTGlu
dXggc2hvdWxkIG5ldmVyIGV2ZXIgZG8gSU5WRC4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
