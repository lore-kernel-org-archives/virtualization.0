From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 11/13] x86/paravirt: Add paravirt alternatives
	infrastructure
Date: Thu, 5 Oct 2017 16:35:03 -0400
Message-ID: <3b9fd404-6912-3b58-db29-36202631b438@oracle.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<39743c79546ede3073586403d0836a4f93519b0a.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <39743c79546ede3073586403d0836a4f93519b0a.1507128293.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


>  #ifdef CONFIG_PARAVIRT
> +/*
> + * Paravirt alternatives are applied much earlier than normal alternatives.
> + * They are only applied when running on a hypervisor.  They replace some
> + * native instructions with calls to pv ops.
> + */
> +void __init apply_pv_alternatives(void)
> +{
> +	setup_force_cpu_cap(X86_FEATURE_PV_OPS);

Not for Xen HVM guests.

> +	apply_alternatives(__pv_alt_instructions, __pv_alt_instructions_end);
> +}


This is a problem (at least for Xen PV guests):
apply_alternatives()->text_poke_early()->local_irq_save()->...'cli'->death.

It might be possible not to turn off/on the interrupts in this
particular case since the guest probably won't be able to handle an
interrupt at this point anyway.


> +
>  void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
>  				     struct paravirt_patch_site *end)
>  {
> diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
> index 4fa90006ac68..17243fe0f5ce 100644
> --- a/arch/x86/kernel/cpu/hypervisor.c
> +++ b/arch/x86/kernel/cpu/hypervisor.c
> @@ -71,6 +71,8 @@ void __init init_hypervisor_platform(void)
>  	if (!x86_hyper)
>  		return;
>  
> +	apply_pv_alternatives();

Not for Xen PV guests who have already done this.

-boris


> +
>  	if (x86_hyper->init_platform)
>  		x86_hyper->init_platform();
>  }
>
