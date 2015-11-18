From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/3] x86/xen: Avoid fast syscall path for Xen PV guests
Date: Wed, 18 Nov 2015 21:47:52 +0100
Message-ID: <20151118204752.GF4451@pd.tnic>
References: <1447877179-2775-1-git-send-email-boris.ostrovsky@oracle.com>
	<1447877179-2775-2-git-send-email-boris.ostrovsky@oracle.com>
	<CALCETrVUpqQy_EZMe8T5iRkA0FzS0Oz1Kuicr9yz3SwtdF1=9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVUpqQy_EZMe8T5iRkA0FzS0Oz1Kuicr9yz3SwtdF1=9g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBOb3YgMTgsIDIwMTUgYXQgMTI6MjE6NTZQTSAtMDgwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOgo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUu
aCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUuaAo+ID4gaW5kZXggZTRmODAxMC4u
MGU0ZmU1YiAxMDA2NDQKPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUu
aAo+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZS5oCj4gPiBAQCAtMjE2
LDYgKzIxNiw3IEBACj4gPiAgI2RlZmluZSBYODZfRkVBVFVSRV9QQVVTRUZJTFRFUiAoIDgqMzIr
MTMpIC8qIEFNRCBmaWx0ZXJlZCBwYXVzZSBpbnRlcmNlcHQgKi8KPiA+ICAjZGVmaW5lIFg4Nl9G
RUFUVVJFX1BGVEhSRVNIT0xEICggOCozMisxNCkgLyogQU1EIHBhdXNlIGZpbHRlciB0aHJlc2hv
bGQgKi8KPiA+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX1ZNTUNBTEwgICAgICggOCozMisxNSkgLyog
UHJlZmVyIHZtbWNhbGwgdG8gdm1jYWxsICovCj4gPiArI2RlZmluZSBYODZfRkVBVFVSRV9YRU5Q
ViAgICAgICAoIDgqMzIrMTYpIC8qIFhlbiBwYXJhdmlydHVhbCBndWVzdCAqLwo+ID4KPiAKPiBU
aGlzIGJpdCBpcyBoaWdobHkgbWFnaWNhbCBhbmQgSSB0aGluayB3ZSBuZWVkIEJvcmlzbGF2J3Mg
YWNrLgoKWWVhaCwgdGhhdCBzaG91bGQgYmUKCiNkZWZpbmUgWDg2X0ZFQVRVUkVfWEVOUFYgICAg
ICAgKCA4KjMyKzE2KSAvKiAiIiBYZW4gcGFyYXZpcnR1YWwgZ3Vlc3QgKi8KCQkJCQkgICAgICBe
XgoKbm90ZSB0aGUgZW1wdHkgIiIuIFRoaXMgcHJldmVudHMgaXQgZnJvbSBhcHBlYXJpbmcgaW4g
L3Byb2MvY3B1aW5mby4KCi0tIApSZWdhcmRzL0dydXNzLAogICAgQm9yaXMuCgpTVVNFIExpbnV4
IEdtYkgsIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIsIEphbmUgU21pdGhhcmQsIEdyYWhhbSBOb3J0
b24sIEhSQiAyMTI4NCAoQUcgTsO8cm5iZXJnKQotLSAKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
