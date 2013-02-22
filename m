From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 09:31:27 -0800
Message-ID: <5127AB6F.3060806@zytor.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
	<CA+55aFy=tW2X4O-qKLh_YQjSFX7aBaBme4uy8kxawn1koKdt-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFy=tW2X4O-qKLh_YQjSFX7aBaBme4uy8kxawn1koKdt-g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mips <linux-mips@linux-mips.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "H. J. Lu" <hjl.tools@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Joe Millenbach <jmillenbach@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>, Gokul Caushik <caushik1@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>, "Xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King <linux@arm.linux.org.uk>, Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Hugh
List-Id: virtualization@lists.linuxfoundation.org

On 02/22/2013 08:22 AM, Linus Torvalds wrote:
>
> Ugh. So I've tried to walk through this, and it's painful. If this
> results in problems, we're going to be *so* screwed. Is it bisectable?
>

I can't tell you for sure that it is bisectable at every point.  There 
are definite bisection points in there, though, as this is several 
pieces of work from two kernel cycles that were independently tested.

> I also don't understand how "early_idt_handler" could *possibly* work.
> In particular, it seems to rely on the trap number being set up in the
> stack frame:
>
>          cmpl $14,72(%rsp)       # Page fault?
>
> but that's not even *true*. Why? Because we export both the
> early_idt_handlers[] array (that sets up the trap number and makes the
> stack frame be reliable) and the single early_idt_handler function
> (that relies on the trap number and the reliable stack frame), AND
> AFAIK WE USE THE LATTER!
>
> See x86_64_start_kernel():
>
>          for (i = 0; i < NUM_EXCEPTION_VECTORS; i++) {
> #ifdef CONFIG_EARLY_PRINTK
>                  set_intr_gate(i, &early_idt_handlers[i]);
> #else
>                  set_intr_gate(i, early_idt_handler);
> #endif
>          }
>
> so unless you have CONFIG_EARLY_PRINTK, the interrupt gate will point
> to that raw early_idt_handler function that doesn't *work* on its own,
> afaik.
>

This is a (pre-existing!) bug that absolutely needs to be fixed, which 
ought to break other things too (early use of *msr_safe for example, or 
anything else that relies on an early exception entry, which there 
aren't a lot of so far).  The fix is simple and obvious.
But you're right... what the heck is going on here?

My own testing would probably not have caught this, as I consider 
EARLY_PRINTK a must have, but Ingo's test machines definitely would have.

> Btw, it's not just the page fault index testing that is wrong. The whole
>
>          cmpl $__KERNEL_CS,96(%rsp)
>          jne 11f
>
> also relies on the stack frame being set up the same way for all
> exceptions - which again is only true if we ran through the
> early_idt_handlers[] prologue that added the extra stack entry.
>
> How does this even work for me? I don't have EARLY_PRINTK enabled.
>
> What am I missing?

I just ran a simulation without EARLY_PRINTK, presumably based on the 
memory layout, we can apparently go through the entire bootup sequence 
without actually ever taking an early trap.  It is a bug, though, and it 
is a bug even without this patchset.  I will submit a fix.  However, the 
Xen "we tested this, this worked, now it doesn't" worries me a lot.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
