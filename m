From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 70/70] x86/sev-es: Add NMI state tracking
Date: Thu, 19 Mar 2020 08:35:59 -0700
Message-ID: <CALCETrUOQneBHjoZkP-7T5PDijb=WOyv7xF7TD0GLR2Aw77vyA@mail.gmail.com>
References: <20200319091407.1481-1-joro@8bytes.org> <20200319091407.1481-71-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-71-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 2:14 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Keep NMI state in SEV-ES code so the kernel can re-enable NMIs for the
> vCPU when it reaches IRET.

IIRC I suggested just re-enabling NMI in C from do_nmi().  What was
wrong with that approach?

> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +SYM_CODE_START(sev_es_iret_user)
> +       UNWIND_HINT_IRET_REGS offset=8
> +       /*
> +        * The kernel jumps here directly from
> +        * swapgs_restore_regs_and_return_to_usermode. %rsp points already to
> +        * trampoline stack, but %cr3 is still from kernel. User-regs are live
> +        * except %rdi. Switch to user CR3, restore user %rdi and user gs_base
> +        * and single-step over IRET
> +        */
> +       SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
> +       popq    %rdi
> +       SWAPGS
> +       /*
> +        * Enable single-stepping and execute IRET. When IRET is
> +        * finished the resulting #DB exception will cause a #VC
> +        * exception to be raised. The #VC exception handler will send a
> +        * NMI-complete message to the hypervisor to re-open the NMI
> +        * window.

This is distressing to say the least.  The sequence if events is, roughly:

1. We're here with NMI masking in an unknown state because do_nmi()
and any nested faults could have done IRET, at least architecturally.
NMI could occur or it could not.  I suppose that, on SEV-ES, as least
on current CPUs, NMI is definitely masked.  What about on newer CPUs?
What if we migrate?

> +        */
> +sev_es_iret_kernel:
> +       pushf
> +       btsq $X86_EFLAGS_TF_BIT, (%rsp)
> +       popf

Now we have TF on, NMIs (architecturally) in unknown state.

> +       iretq

This causes us to pop the NMI frame off the stack.  Assuming the NMI
restart logic is invoked (which is maybe impossible?), we get #DB,
which presumably is actually delivered.  And we end up on the #DB
stack, which might already have been in use, so we have a potential
increase in nesting.  Also, #DB may be called from an unexpected
context.

Now somehow #DB is supposed to invoke #VC, which is supposed to do the
magic hypercall, and all of this is supposed to be safe?  Or is #DB
unconditionally redirected to #VC?  What happens if we had no stack
(e.g. we interrupted SYSCALL) or we were already in #VC to begin with?

I think there are two credible ways to approach this:

1. Just put the NMI unmask in do_nmi().  The kernel *already* knows
how to handle running do_nmi() with NMIs unmasked.  This is much, much
simpler than your code.

2. Have an entirely separate NMI path for the
SEV-ES-on-misdesigned-CPU case.  And have very clear documentation for
what prevents this code from being executed on future CPUs (Zen3?)
that have this issue fixed for real?

This hybrid code is no good.

--Andy
