From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 23/62] x86/idt: Move IDT to data segment
Date: Wed, 12 Feb 2020 12:55:16 +0100
Message-ID: <20200212115516.GE20066@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-24-joro@8bytes.org>
 <CALCETrXswGgGoNaZigboUn3-amTyCY2Ft_JaMMvXchLDDkhJfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXswGgGoNaZigboUn3-amTyCY2Ft_JaMMvXchLDDkhJfw@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 02:41:25PM -0800, Andy Lutomirski wrote:
> On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > From: Joerg Roedel <jroedel@suse.de>
> >
> > With SEV-ES, exception handling is needed very early, even before the
> > kernel has cleared the bss segment. In order to prevent clearing the
> > currently used IDT, move the IDT to the data segment.
> 
> Ugh.  At the very least this needs a comment in the code.

Yes, right, added a comment for that.

> I had a patch to fix the kernel ELF loader to clear BSS, which would
> fix this problem once and for all, but it didn't work due to the messy
> way that the decompressor handles memory.  I never got around to
> fixing this, sadly.

Aren't there other ways of booting (Xen-PV?) which don't use the kernel
ELF loader?

Regards,

	Joerg
