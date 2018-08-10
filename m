From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH 04/10] x86/paravirt: use a single ops structure
Date: Fri, 10 Aug 2018 14:30:19 +0200
Message-ID: <5048a84a-3d66-e6a6-002a-09602fc9a478@suse.com>
References: =?UTF-8?Q?<20180810115252.18213=ef=bf=bd1=ef=bf=bdjgross@suse.co?=
	=?UTF-8?Q?m>_<20180810115252.18213-5-jgross@suse.com>_<5B6D7FB402000078001D?=
	=?UTF-8?Q?CF30@suse.com>?=
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5B6D7FB402000078001D?= =?UTF-8?Q?CF30@suse.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>
Cc: rusty@rustcorp.com.au, the arch/x86 maintainers <x86@kernel.org>, Alok Kataria <akataria@vmware.com>, lkml <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, xen-devel <xen-devel@lists.xenproject.org>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/08/18 14:06, Jan Beulich wrote:
>>>> On 10.08.18 at 13:52, <jgross@suse.com> wrote:
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -228,9 +228,9 @@ void hyperv_setup_mmu_ops(void)
>>  
>>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED)) {
>>  		pr_info("Using hypercall for remote TLB flush\n");
>> -		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
>> +		pv_ops.pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
> 
> Taking just this as example, why not
> 
> 		pv_ops.mmu.flush_tlb_others = hyperv_flush_tlb_others;
> 
> ? Both pv_ and _ops are redundant on the field names.

Good idea.


Juergen
