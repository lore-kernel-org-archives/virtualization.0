From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 4/9] x86/mm/tlb: Flush remote and local TLBs concurrently
Date: Wed, 26 Jun 2019 03:32:25 +0000
Message-ID: <E4BD986D-F8A1-45D3-9DC1-AE0649D1F5C3@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
	<20190613064813.8102-5-namit@vmware.com>
	<723d63ee-c8cb-14a1-0eb9-265e580360f4@intel.com>
	<1545B936-7CEC-4A1C-B776-74004F774218@vmware.com>
	<88a76cb8-2484-818a-2be6-d06a4ffef107@intel.com>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <88a76cb8-2484-818a-2be6-d06a4ffef107@intel.com>
Content-Language: en-US
Content-ID: <4A93801C3C77B54FBCD984EC5F738BCA@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sasha Levin <sashal@kernel.org>, Juergen Gross <jgross@suse.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Hemminger <sthemmin@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Haiyang Zhang <haiyangz@microsoft.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

PiBPbiBKdW4gMjUsIDIwMTksIGF0IDg6MDAgUE0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBp
bnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gNi8yNS8xOSA3OjM1IFBNLCBOYWRhdiBBbWl0IHdy
b3RlOg0KPj4+PiBjb25zdCBzdHJ1Y3QgZmx1c2hfdGxiX2luZm8gKmYgPSBpbmZvOw0KPj4+PiAr
CWVudW0gdGxiX2ZsdXNoX3JlYXNvbiByZWFzb247DQo+Pj4+ICsNCj4+Pj4gKwlyZWFzb24gPSAo
Zi0+bW0gPT0gTlVMTCkgPyBUTEJfTE9DQUxfU0hPT1RET1dOIDogVExCX0xPQ0FMX01NX1NIT09U
RE9XTjsNCj4+PiANCj4+PiBTaG91bGQgd2UganVzdCBhZGQgdGhlICJyZWFzb24iIHRvIGZsdXNo
X3RsYl9pbmZvPyAgSXQncyBPSy1pc2ggdG8gaW1wbHkNCj4+PiBpdCBsaWtlIHRoaXMsIGJ1dCBz
ZWVtcyBsaWtlIGl0IHdvdWxkIGJlIG5pY2VyIGFuZCBlYXNpZXIgdG8gdHJhY2sgZG93bg0KPj4+
IHRoZSBvcmlnaW5zIG9mIHRoZXNlIHRoaW5ncyBpZiB3ZSBkaWQgdGhpcyBhdCB0aGUgY2FsbGVy
Lg0KPj4gDQo+PiBJIHByZWZlciBub3QgdG8uIEkgd2FudCBsYXRlciB0byBpbmxpbmUgZmx1c2hf
dGxiX2luZm8gaW50byB0aGUgc2FtZQ0KPj4gY2FjaGVsaW5lIHRoYXQgaG9sZHMgY2FsbF9mdW5j
dGlvbl9kYXRhLiBJbmNyZWFzaW5nIHRoZSBzaXplIG9mDQo+PiBmbHVzaF90bGJfaW5mbyBmb3Ig
bm8gZ29vZCByZWFzb24gd2lsbCBub3QgaGVscOKApg0KPiANCj4gV2VsbCwgZmx1c2hfdGxiX2lu
Zm8gaXMgYXQgNi84dGhzIG9mIGEgY2FjaGVsaW5lIGF0IHRoZSBtb21lbnQuDQo+IGNhbGxfZnVu
Y3Rpb25fZGF0YSBpcyAzLzh0aHMuICBUbyBtZSwgdGhhdCBtZWFucyB3ZSBoYXZlIHNvbWUgc2xh
Y2sgaW4NCj4gdGhlIHNpemUuDQoNCkkgZG8gbm90IHVuZGVyc3RhbmQgeW91ciBtYXRoLi4gOigN
Cg0KNiArIDMgPiA4IHNvIHB1dHRpbmcgYm90aCBmbHVzaF90bGJfaW5mbyBhbmQgY2FsbF9mdW5j
dGlvbl9kYXRhIGRvZXMgbm90DQpsZWF2ZSB1cyBhbnkgc2xhY2sgKHdlIGNhbiBzYXZlIG9uZSBx
d29yZCwgc28gd2UgY2FuIGFjdHVhbGx5IHB1dCB0aGVtDQphdCB0aGUgc2FtZSBjYWNoZWxpbmUp
Lg0KDQpZb3UgY2FuIHNlZSBteSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGhlcmU6DQoNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxOTA1MzEwNjM2NDUuNDY5Ny00LW5hbWl0QHZtd2Fy
ZS5jb20vVC8jbTBhYjVmZTA3OTliYTlmZjBkNDExOTdmMTA5NTY3OWZlMjZhZWJkNTcNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxOTA1MzEwNjM2NDUuNDY5Ny00LW5hbWl0QHZtd2Fy
ZS5jb20vVC8jbTdiMzVhOTNkZmZkMjNmYmI3Y2E4MTNjNzk1YTA3NzdkNGNkY2I1MWINCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
