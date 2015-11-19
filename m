From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/3] x86/xen: Avoid fast syscall path for Xen PV guests
Date: Thu, 19 Nov 2015 13:08:09 +0100
Message-ID: <20151119120809.GC5953@pd.tnic>
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
IHdyb3RlOgo+IENvdWxkIHdlIG1ha2UgdGhpcyBhIGxpdHRsZSBsZXNzIHN1YnRsZToKPiAKPiBB
TFRFUk5BVElWRSAidGVzdGwgJWVheCwgJWVheDsgbHogLkxzeXNjYWxsXzMyX2RvbmUiLCAiam1w
Cj4gLkxzeXNjYXNsbF8zMl9kb25lIiwgWDg2X0ZFQVRVUkVfWEVOUFYKPiAKPiBCb3Jpc2xhdiwg
d2hhdCBkbyB5b3UgdGhpbms/CgpJIGRvbid0IG1pbmQgZWl0aGVyLgoKSSB3b3VsZCd2ZSBzYWlk
IHlvdXIgdmVyc2lvbiBkb2Vzbid0IHRvdWNoICVlYXggc28gdGhlIHJlc3VsdCBpbiB0aGVyZQpt
aWdodCBiZSB1c2VmdWwgZm9yIGNhbGxlcnMgYnV0IGFsbCBwYXRocyBkbyBvdmVyd3JpdGUgaXQs
IEFGQUlDVC4KCi0tIApSZWdhcmRzL0dydXNzLAogICAgQm9yaXMuCgpTVVNFIExpbnV4IEdtYkgs
IEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIsIEphbmUgU21pdGhhcmQsIEdyYWhhbSBOb3J0b24sIEhS
QiAyMTI4NCAoQUcgTsO8cm5iZXJnKQotLSAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
