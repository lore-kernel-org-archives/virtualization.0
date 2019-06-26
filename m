From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/9] x86/mm/tlb: Flush remote and local TLBs concurrently
Date: Tue, 25 Jun 2019 20:00:37 -0700
Message-ID: <88a76cb8-2484-818a-2be6-d06a4ffef107__22405.469480303$1561518058$gmane$org@intel.com>
References: <20190613064813.8102-1-namit@vmware.com>
	<20190613064813.8102-5-namit@vmware.com>
	<723d63ee-c8cb-14a1-0eb9-265e580360f4@intel.com>
	<1545B936-7CEC-4A1C-B776-74004F774218@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1545B936-7CEC-4A1C-B776-74004F774218@vmware.com>
Content-Language: en-US
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
Cc: Sasha Levin <sashal@kernel.org>, Juergen Gross <jgross@suse.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Hemminger <sthemmin@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Haiyang Zhang <haiyangz@microsoft.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gNi8yNS8xOSA3OjM1IFBNLCBOYWRhdiBBbWl0IHdyb3RlOgo+Pj4gCWNvbnN0IHN0cnVjdCBm
bHVzaF90bGJfaW5mbyAqZiA9IGluZm87Cj4+PiArCWVudW0gdGxiX2ZsdXNoX3JlYXNvbiByZWFz
b247Cj4+PiArCj4+PiArCXJlYXNvbiA9IChmLT5tbSA9PSBOVUxMKSA/IFRMQl9MT0NBTF9TSE9P
VERPV04gOiBUTEJfTE9DQUxfTU1fU0hPT1RET1dOOwo+Pgo+PiBTaG91bGQgd2UganVzdCBhZGQg
dGhlICJyZWFzb24iIHRvIGZsdXNoX3RsYl9pbmZvPyAgSXQncyBPSy1pc2ggdG8gaW1wbHkKPj4g
aXQgbGlrZSB0aGlzLCBidXQgc2VlbXMgbGlrZSBpdCB3b3VsZCBiZSBuaWNlciBhbmQgZWFzaWVy
IHRvIHRyYWNrIGRvd24KPj4gdGhlIG9yaWdpbnMgb2YgdGhlc2UgdGhpbmdzIGlmIHdlIGRpZCB0
aGlzIGF0IHRoZSBjYWxsZXIuCj4gCj4gSSBwcmVmZXIgbm90IHRvLiBJIHdhbnQgbGF0ZXIgdG8g
aW5saW5lIGZsdXNoX3RsYl9pbmZvIGludG8gdGhlIHNhbWUKPiBjYWNoZWxpbmUgdGhhdCBob2xk
cyBjYWxsX2Z1bmN0aW9uX2RhdGEuIEluY3JlYXNpbmcgdGhlIHNpemUgb2YKPiBmbHVzaF90bGJf
aW5mbyBmb3Igbm8gZ29vZCByZWFzb24gd2lsbCBub3QgaGVscOKApgoKV2VsbCwgZmx1c2hfdGxi
X2luZm8gaXMgYXQgNi84dGhzIG9mIGEgY2FjaGVsaW5lIGF0IHRoZSBtb21lbnQuCmNhbGxfZnVu
Y3Rpb25fZGF0YSBpcyAzLzh0aHMuICBUbyBtZSwgdGhhdCBtZWFucyB3ZSBoYXZlIHNvbWUgc2xh
Y2sgaW4KdGhlIHNpemUuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
