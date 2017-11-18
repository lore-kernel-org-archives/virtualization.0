From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 03/13] x86/paravirt: Convert native patch assembly code
	strings to macros
Date: Sat, 18 Nov 2017 07:17:00 -0600
Message-ID: <20171118131700.y4iv3iepni6jwfc4@treble>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<e4cea2b8aa8ca23122d9c807784ca62ee6cbbff8.1507128293.git.jpoimboe@redhat.com>
	<20171117180713.e4up3dwrszpatka6@pd.tnic>
	<a9531df0-0a48-e695-a05a-56e654f9dfbb@suse.com>
	<20171117194231.576qqr3wnkgowdln@treble>
	<4022805e-38b2-869c-a766-b7e5026a263e@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4022805e-38b2-869c-a766-b7e5026a263e@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

T24gU2F0LCBOb3YgMTgsIDIwMTcgYXQgMTE6MjA6MDZBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3
cm90ZToKPiA+Pj4+ICsjZGVmaW5lIE5BVElWRV9aRVJPCQkJInhvciAiIF9SRUdfQVJHMSAiLCAi
IF9SRUdfQVJHMQo+ID4+Pgo+ID4+PiBOQVRJVkVfWkVST19PVVQKPiA+Pj4KPiA+Pj4gSSBndWVz
cy4gTkFUSVZFX1pFUk8gcmVhZHMgbGlrZSB0aGUgbmF0aXZlIHJlcHJlc2VudGF0aW9uIG9mIDAg
Oi0pCj4gPj4KPiA+PiBOQVRJVkVfWkVST19BUkcxPwo+ID4gCj4gPiBPbiBhIHNsaWdodCB0YW5n
ZW50LCBkb2VzIGFueWJvZHkga25vdyB3aHkgaXQgemVyb3MgdGhlIGFyZz8KPiAKPiBXaHkgYXJl
IF95b3VfIGFza2luZz8gWW91J3ZlIGludHJvZHVjZWQgaXQuCgpTbyBJIGRpZC4gIFRvdWNow6kh
Cgo+ID4gVGhlIG9ubHkgcGxhY2UgaXQncyB1c2VkIGlzIGhlcmU6Cj4gPiAKPiA+ICNpZiBkZWZp
bmVkKENPTkZJR19QQVJBVklSVF9TUElOTE9DS1MpCj4gPiBERUZfTkFUSVZFKHB2X2xvY2tfb3Bz
LAlxdWV1ZWRfc3Bpbl91bmxvY2ssCU5BVElWRV9RVUVVRURfU1BJTl9VTkxPQ0spOwo+ID4gREVG
X05BVElWRShwdl9sb2NrX29wcywJdmNwdV9pc19wcmVlbXB0ZWQsCU5BVElWRV9aRVJPKTsKPiA+
ICNlbmRpZgo+ID4gCj4gPiBJc24ndCB0aGF0IGEgYnVnPyAgU2VlbXMgbGlrZSBpdCBzaG91bGQg
X3JldHVybl8gemVyby4gIFplcm9pbmcgdGhlIGFyZwo+ID4gc2hvdWxkbid0IGhhdmUgYW55IGVm
ZmVjdC4KPiAKPiBSaWdodC4gQmVmb3JlIHRoYXQgcGF0Y2ggaXQgX2RpZF8gcmV0dXJuIHplcm8g
aW5zdGVhZCBvZiB6ZXJvaW5nIGFyZzEuCgpPb3BzIQoKPiA+IElmIEknbSByaWdodCwgd2UgY291
bGQgY2FsbCBpdCBOQVRJVkVfRkFMU0UuCj4gCj4gSSdkIHByZWZlciBOQVRJVkVfWkVSTywgYXMg
aXQgd2lsbCBiZSB1c2FibGUgZm9yIG5vbi1ib29sZWFuIGNhc2VzLCB0b28uCgpOQVRJVkVfWkVS
TyB3b3JrcyBmb3IgbWUuCgotLSAKSm9zaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
