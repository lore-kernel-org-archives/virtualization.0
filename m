From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 08/62] x86/boot/compressed/64: Add IDT Infrastructure
Date: Wed, 12 Feb 2020 12:19:24 +0100
Message-ID: <20200212111923.GA20066@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-9-joro@8bytes.org>
 <CALCETrWznWHQNfd80G95G_CB-yCw8Botqee8bsLz3OcC4-SS=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWznWHQNfd80G95G_CB-yCw8Botqee8bsLz3OcC4-SS=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andy,

thanks a lot for your valuable reviews!

On Tue, Feb 11, 2020 at 02:18:52PM -0800, Andy Lutomirski wrote:
> On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
> > +       entry.offset_low    = (u16)(address & 0xffff);
> > +       entry.segment       = __KERNEL_CS;
> > +       entry.bits.type     = GATE_TRAP;
> 
> ^^^
> 
> I realize we're not running a real kernel here, but GATE_TRAP is
> madness.  Please use GATE_INTERRUPT.

Changed that.

> > +       /* Build pt_regs */
> > +       .if \error_code == 0
> > +       pushq   $0
> > +       .endif
> 
> cld

Added.

> > +       popq    %rdi
> 
> if error_code?

The code above pushes a $0 for exceptions without an error code, so it
needs to be removed unconditionally.

> > +
> > +       /* Remove error code and return */
> > +       addq    $8, %rsp
> > +
> > +       /*
> > +        * Make sure we return to __KERNEL_CS - the CS selector on
> > +        * the IRET frame might still be from an old BIOS GDT
> > +        */
> > +       movq    $__KERNEL_CS, 8(%rsp)
> > +
> 
> If this actually happens, you have a major bug.  Please sanitize all
> the segment registers after installing the GDT rather than hacking
> around it here.

Okay, will change that. I thought I could safe some instructions in the
head_64.S code, but you are right that its better to setup a defined
environment first.


Thanks,

	Joerg
