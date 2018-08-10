From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 04/10] x86/paravirt: use a single ops structure
Date: Fri, 10 Aug 2018 06:06:12 -0600
Message-ID: <5B6D7FB402000078001DCF30__48300.6922797815$1533902764$gmane$org@prv1-mh.provo.novell.com>
References: <20180810115252.18213-1-jgross@suse.com>
	<20180810115252.18213-5-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180810115252.18213-5-jgross@suse.com>
Content-Disposition: inline
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
Cc: rusty@rustcorp.com.au, the arch/x86 maintainers <x86@kernel.org>, Alok Kataria <akataria@vmware.com>, linux-kernel@vger.kernel.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, mingo@redhat.com, hpa@zytor.com, xen-devel <xen-devel@lists.xenproject.org>, tglx@linutronix.de, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

>>> On 10.08.18 at 13:52, <jgross@suse.com> wrote:
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -228,9 +228,9 @@ void hyperv_setup_mmu_ops(void)
>  
>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED)) {
>  		pr_info("Using hypercall for remote TLB flush\n");
> -		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
> +		pv_ops.pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;

Taking just this as example, why not

		pv_ops.mmu.flush_tlb_others = hyperv_flush_tlb_others;

? Both pv_ and _ops are redundant on the field names.

Jan
