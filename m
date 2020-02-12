From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 46/62] x86/sev-es: Handle INVD Events
Date: Wed, 12 Feb 2020 16:36:17 +0100
Message-ID: <20200212153617.GD22063@8bytes.org>
References: <20200211135256.24617-47-joro@8bytes.org>
 <EA510462-A43C-4F7E-BFE8-B212003B3627@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <EA510462-A43C-4F7E-BFE8-B212003B3627@amacapital.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Juergen Gross <JGross@suse.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCBGZWIgMTEsIDIwMjAgYXQgMDQ6MTI6MTlQTSAtMDgwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOgo+IAo+IAo+ID4gT24gRmViIDExLCAyMDIwLCBhdCA1OjUzIEFNLCBKb2VyZyBSb2Vk
ZWwgPGpvcm9AOGJ5dGVzLm9yZz4gd3JvdGU6Cj4gPiAKPiA+IO+7v0Zyb206IFRvbSBMZW5kYWNr
eSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+Cj4gPiAKPiA+IEltcGxlbWVudCBhIGhhbmRsZXIg
Zm9yICNWQyBleGNlcHRpb25zIGNhdXNlZCBieSBJTlZEIGluc3RydWN0aW9ucy4KPiAKPiBVaCwg
d2hhdD8gIFN1cmVseSB0aGUgI1ZDIGNvZGUgY2FuIGhhdmUgYSBjYXRjaC1hbGwgT09QUyBwYXRo
IGZvciB0aGluZ3MgbGlrZSB0aGlzLiBMaW51eCBzaG91bGQgbmV2ZXIgZXZlciBkbyBJTlZELgoK
UmlnaHQsIGl0cyBoYXJkIHRvIGNvbWUgdXAgd2l0aCBhIHZhbGlkIHVzZS1jYXNlIGZvciBJTlZE
IGluIHRoZSBMaW51eAprZXJuZWwuIEkgY2hhbmdlZCB0aGUgcGF0Y2ggdG8gbWFyayBJTlZEIGFz
IHVuc3VwcG9ydGVkIGFuZCBwcmludCBhbgplcnJvciBtZXNzYWdlLgoKUmVnYXJkcywKCglKb2Vy
ZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
