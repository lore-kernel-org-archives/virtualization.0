From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 41/70] x86/sev-es: Add Runtime #VC Exception Handler
Date: Thu, 19 Mar 2020 17:24:39 +0100
Message-ID: <20200319162439.GE5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-42-joro@8bytes.org>
 <CALCETrW9EYi5dzCKNtKkxM18CC4n5BZxTp1=qQ5qZccwstXjzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrW9EYi5dzCKNtKkxM18CC4n5BZxTp1=qQ5qZccwstXjzg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 08:44:03AM -0700, Andy Lutomirski wrote:
> On Thu, Mar 19, 2020 at 2:14 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > From: Tom Lendacky <thomas.lendacky@amd.com>
> >
> > Add the handler for #VC exceptions invoked at runtime.
> 
> If I read this correctly, this does not use IST.  If that's true, I
> don't see how this can possibly work.  There at least two nasty cases
> that come to mind:
> 
> 1. SYSCALL followed by NMI.  The NMI IRET hack gets to #VC and we
> explode.  This is fixable by getting rid of the NMI EFLAGS.TF hack.

Not an issue in this patch-set, the confusion comes from the fact that I
left some parts of the single-step-over-iret code in the patch. But it
is not used. The NMI handling in this patch-set sends the NMI-complete
message before the IRET, when the kernel is still in a safe environment
(kernel stack, kernel cr3).

> 2. tools/testing/selftests/x86/mov_ss_trap_64.  User code does MOV
> (addr), SS; SYSCALL, where addr has a data breakpoint.  We get #DB
> promoted to #VC with no stack.

Also not an issue, as debugging is not supported at the moment in SEV-ES
guests (hardware has no way yet to save/restore the debug registers
across #VMEXITs). But this will change with future hardware. If you look
at the implementation for dr7 read/write events, you see that the dr7
value is cached and returned, but does not make it to the hardware dr7.

I though about using IST for the #VC handler, but the implications for
nesting #VC handlers made me decide against it. But for future hardware
that supports debugging inside SEV-ES guests it will be an issue. I'll
think about how to fix the problem, it probably has to be IST :(

Regards,

	Joerg
