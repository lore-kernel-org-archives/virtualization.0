From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 34/75] x86/head/64: Build k/head64.c with
 -fno-stack-protector
Date: Wed, 15 Jul 2020 18:34:47 +0200
Message-ID: <20200715163446.GB24822@suse.de>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-35-joro@8bytes.org>
 <202007141831.F3165F22@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <202007141831.F3165F22@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 14, 2020 at 06:34:24PM -0700, Kees Cook wrote:
> On Tue, Jul 14, 2020 at 02:08:36PM +0200, Joerg Roedel wrote:
> > +# make sure head64.c is built without stack protector
> > +nostackp := $(call cc-option, -fno-stack-protector)
> > +CFLAGS_head64.o		:= $(nostackp)
> 
> Recent refactoring[1] for stack protector suggests this should just
> unconditionally be:
> 
> CFLAGS_head64.o			+= -fno-stack-protector
> 
> But otherwise, yeah, this should be fine here -- it's all early init
> stuff.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks, I am not sure this patch will be needed in the next version, as
I am currently rebasing to tip/master, which also made idt_descr static
in kernel/idt.c.

So with that I think I have to move the early IDT init functions to
kernel/idt.c too and setup %gs earlier in head_64.S to make
stack-protector happy.

The %gs setup actually needs to happen two times, one time when the
kernel still runs identity mapped and then again when it switched to
virtual addresses.

Regards,

	Joerg
