From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 08:22:30 -0800
Message-ID: <CA+55aFy=tW2X4O-qKLh_YQjSFX7aBaBme4uy8kxawn1koKdt-g@mail.gmail.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: linux-mips <linux-mips@linux-mips.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "H. J. Lu" <hjl.tools@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Joe Millenbach <jmillenbach@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>, Gokul Caushik <caushik1@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>, "Xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King <linux@arm.linux.org.uk>, Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, Stefano Stabellini <stefano.stab>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2013 at 4:34 PM, H. Peter Anvin <hpa@linux.intel.com> wrote:
>
> This is a huge set of several partly interrelated (and concurrently
> developed) changes, which is why the branch history is messier than
> one would like.
>
> The *really* big items are two humonguous patchsets mostly developed
> by Yinghai Lu at my request, which completely revamps the way we
> create initial page tables.

Ugh. So I've tried to walk through this, and it's painful. If this
results in problems, we're going to be *so* screwed. Is it bisectable?

I also don't understand how "early_idt_handler" could *possibly* work.
In particular, it seems to rely on the trap number being set up in the
stack frame:

        cmpl $14,72(%rsp)       # Page fault?

but that's not even *true*. Why? Because we export both the
early_idt_handlers[] array (that sets up the trap number and makes the
stack frame be reliable) and the single early_idt_handler function
(that relies on the trap number and the reliable stack frame), AND
AFAIK WE USE THE LATTER!

See x86_64_start_kernel():

        for (i = 0; i < NUM_EXCEPTION_VECTORS; i++) {
#ifdef CONFIG_EARLY_PRINTK
                set_intr_gate(i, &early_idt_handlers[i]);
#else
                set_intr_gate(i, early_idt_handler);
#endif
        }

so unless you have CONFIG_EARLY_PRINTK, the interrupt gate will point
to that raw early_idt_handler function that doesn't *work* on its own,
afaik.

Btw, it's not just the page fault index testing that is wrong. The whole

        cmpl $__KERNEL_CS,96(%rsp)
        jne 11f

also relies on the stack frame being set up the same way for all
exceptions - which again is only true if we ran through the
early_idt_handlers[] prologue that added the extra stack entry.

How does this even work for me? I don't have EARLY_PRINTK enabled.

What am I missing?

                Linus
