From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 29/75] x86/idt: Move two function from k/idt.c to
 i/a/desc.h
Date: Tue, 14 Jul 2020 18:29:27 -0700
Message-ID: <202007141827.5A5D64454@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-30-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-30-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 14, 2020 at 02:08:31PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>

I'm not a huge fan of the Subject. :) Maybe:

x86/idt: Make IDT init functions static inlines

> 
> Move these two functions from kernel/idt.c to include/asm/desc.h:
> 
> 	* init_idt_data()
> 	* idt_init_desc()
> 
> These functions are needed to setup IDT entries very early and need to
> be called from head64.c. To be usable this early these functions need to
> be compiled without instrumentation and the stack-protector feature.
> These features need to be kept enabled for kernel/idt.c, so head64.c
> must use its own versions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

But regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
