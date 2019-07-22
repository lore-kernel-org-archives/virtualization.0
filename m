From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/9] x86/mm/tlb: Flush remote and local TLBs
	concurrently
Date: Mon, 22 Jul 2019 21:32:51 +0200
Message-ID: <20190722193251.GF6698@worktop.programming.kicks-ass.net>
References: <20190719005837.4150-1-namit@vmware.com>
	<20190719005837.4150-5-namit@vmware.com>
	<20190722191433.GD6698@worktop.programming.kicks-ass.net>
	<58DA0841-33C2-4D16-A671-08064A15001C@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <58DA0841-33C2-4D16-A671-08064A15001C@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Sasha Levin <sashal@kernel.org>, Juergen Gross <jgross@suse.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBKdWwgMjIsIDIwMTkgYXQgMDc6Mjc6MDlQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90
ZToKPiA+IE9uIEp1bCAyMiwgMjAxOSwgYXQgMTI6MTQgUE0sIFBldGVyIFppamxzdHJhIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cgo+ID4gQnV0IHRoZW4gd2UgY2FuIHN0aWxsIGRvIHNv
bWV0aGluZyBsaWtlIHRoZSBiZWxvdywgd2hpY2ggZG9lc24ndCBjaGFuZ2UKPiA+IHRoaW5ncyBh
bmQgc3RpbGwgZ2V0cyByaWQgb2YgdGhhdCBkdWFsIGZ1bmN0aW9uIGNydWQsIHNpbXBsaWZ5aW5n
Cj4gPiBzbXBfY2FsbF9mdW5jdGlvbl9tYW55IGFnYWluLgoKPiBOaWNlISBJIHdpbGwgYWRkIGl0
IG9uIHRvcCwgaWYgeW91IGRvbuKAmXQgbWluZCAoaW5zdGVhZCBzcXVhc2hpbmcgaXQpLgoKTm90
IGF0IGFsbC4KCj4gVGhlIG9yaWdpbmFsIGRlY2lzaW9uIHRvIGhhdmUgbG9jYWwvcmVtb3RlIGZ1
bmN0aW9ucyB3YXMgbW9zdGx5IHRvIHByb3ZpZGUKPiB0aGUgZ2VuZXJhbGl0eS4KPiAKPiBJIHdv
dWxkIGNoYW5nZSB0aGUgbGFzdCBhcmd1bWVudCBvZiBfX3NtcF9jYWxsX2Z1bmN0aW9uX21hbnko
KSBmcm9tIOKAnHdhaXTigJ0KPiB0byDigJxmbGFnc+KAnSB0aGF0IHdvdWxkIGluZGljYXRlIHdo
ZXRoZXIgdG8gcnVuIHRoZSBmdW5jdGlvbiBsb2NhbGx5LCBzaW5jZSBJCj4gZG9u4oCZdCB3YW50
IHRvIGNoYW5nZSB0aGUgc2VtYW50aWNzIG9mIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoKSBhbmQg
ZGVjaWRlCj4gd2hldGhlciB0byBydW4gdGhlIGZ1bmN0aW9uIGxvY2FsbHkgcHVyZWx5IGJhc2Vk
IG9uIHRoZSBtYXNrLiBMZXQgbWUga25vdyBpZgo+IHlvdSBkaXNhZ3JlZS4KCkFncmVlZC4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
