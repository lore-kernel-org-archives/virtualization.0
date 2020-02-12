From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 25/62] x86/head/64: Install boot GDT
Date: Wed, 12 Feb 2020 13:20:52 +0100
Message-ID: <20200212122052.GF20066@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-26-joro@8bytes.org>
 <CALCETrWryvrGoPD5zOVxVs3pk+WFfb287NV46Zw7Gz7FtNAHag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWryvrGoPD5zOVxVs3pk+WFfb287NV46Zw7Gz7FtNAHag@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 02:29:24PM -0800, Andy Lutomirski wrote:
> On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
> > +       /* GDT loaded - switch to __KERNEL_CS so IRET works reliably */
> > +       pushq   $__KERNEL_CS
> > +       leaq    .Lon_kernel_cs(%rip), %rax
> > +       pushq   %rax
> > +       lretq
> > +
> > +.Lon_kernel_cs:
> > +       UNWIND_HINT_EMPTY
> 
> I would suggest fixing at least SS as well.

You are right, that is cleaner. Initialized DS, ES, and SS to
__KERNEL_DS here too.

Regards,

	Joerg
