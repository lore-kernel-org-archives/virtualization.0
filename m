From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [RFC PATCH v2 04/12] x86/mm/tlb: Flush remote and local TLBs
	concurrently
Date: Fri, 31 May 2019 19:44:41 +0000
Message-ID: <1DEA29A7-D033-4816-876C-05E7D77F0437__14101.9104443089$1559331947$gmane$org@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
	<20190531063645.4697-5-namit@vmware.com>
	<a847ee9c-4faf-c8b4-43bb-cc30e0980796@suse.com>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a847ee9c-4faf-c8b4-43bb-cc30e0980796@suse.com>
Content-Language: en-US
Content-ID: <498DEB6111D0B64C9D5657F78CFDD0EF@namprd05.prod.outlook.com>
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
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Hemminger <sthemmin@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Haiyang Zhang <haiyangz@microsoft.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

> On May 31, 2019, at 4:48 AM, Juergen Gross <jgross@suse.com> wrote:
> 
> On 31/05/2019 08:36, Nadav Amit wrote:
>> 
>> --- a/arch/x86/include/asm/paravirt_types.h
>> +++ b/arch/x86/include/asm/paravirt_types.h
>> @@ -211,6 +211,12 @@ struct pv_mmu_ops {
>> 	void (*flush_tlb_user)(void);
>> 	void (*flush_tlb_kernel)(void);
>> 	void (*flush_tlb_one_user)(unsigned long addr);
>> +	/*
>> +	 * flush_tlb_multi() is the preferred interface. When it is used,
>> +	 * flush_tlb_others() should return false.
> 
> Didn't you want to remove/change this comment?

Yes! Sorry for that. Fixed now.
