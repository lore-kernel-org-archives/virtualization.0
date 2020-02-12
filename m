From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 39/62] x86/sev-es: Harden runtime #VC handler for
 exceptions from user-space
Date: Wed, 12 Feb 2020 14:16:53 +0100
Message-ID: <20200212131652.GH20066@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-40-joro@8bytes.org>
 <CALCETrXnFr47OEDk8OYrHHW=1XNAQMUB=wPevhLM6ROnO6_Rog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXnFr47OEDk8OYrHHW=1XNAQMUB=wPevhLM6ROnO6_Rog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 02:47:05PM -0800, Andy Lutomirski wrote:
> On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > From: Joerg Roedel <jroedel@suse.de>
> >
> > Send SIGBUS to the user-space process that caused the #VC exception
> > instead of killing the machine. Also ratelimit the error messages so
> > that user-space can't flood the kernel log.
> 
> What would cause this?  CPUID?  Something else?

Yes, CPUID, RDTSC(P) and, most importantly, user-space mapping some IO
space an accessing it, causing MMIO #VC exceptions.

Especially the MMIO case has so many implications that it will not be
supported at the moment. Imagine for example MMIO accesses by 32bit
user-space with non-standard, non-zero based code and data segments. Or
user-space changing the instruction bytes between when the #VC exception
is raised and when the handler parses the instruction. Lots of checks
are needed to make this work securely, and the complexity of this is not
worth it at this time.


Regards,

	Joerg
