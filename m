From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Sat, 25 Apr 2020 11:15:35 -0700
Message-ID: <CALCETrWCiMkA37yf972h+fqsz1_dbfye8AbrkJxDPJzC+1PBEw@mail.gmail.com>
References: <20200319091407.1481-56-joro@8bytes.org> <20200424210316.848878-1-mstunes@vmware.com>
 <2c49061d-eb84-032e-8dcb-dd36a891ce90@intel.com> <ead88d04-1756-1190-2b37-b24f86422595@amd.com>
 <4d2ac222-a896-a60e-9b3c-b35aa7e81a97@intel.com> <20200425124909.GO30814@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200425124909.GO30814@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <joro@8bytes.org>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 25, 2020 at 5:49 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> Hi Dave,
>
> On Fri, Apr 24, 2020 at 03:53:09PM -0700, Dave Hansen wrote:
> > Ahh, so any instruction that can have an instruction intercept set
> > potentially needs to be able to tolerate a #VC?  Those instruction
> > intercepts are under the control of the (untrusted relative to the
> > guest) hypervisor, right?
> >
> > >From the main sev-es series:
> >
> > +#ifdef CONFIG_AMD_MEM_ENCRYPT
> > +idtentry vmm_communication     do_vmm_communication    has_error_code=1
> > +#endif
>
> The next version of the patch-set (which I will hopefully have ready
> next week) will have this changed. The #VC exception handler uses an IST
> stack and is set to paranoid=1 and shift_ist. The IST stacks for the #VC
> handler are only allocated when SEV-ES is active.

shift_ist is gross.  What's it for?  If it's not needed, I'd rather
not use it, and I eventually want to get rid of it for #DB as well.

--Andy
