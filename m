From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 42/75] x86/sev-es: Setup GHCB based boot #VC handler
Date: Thu, 11 Jun 2020 12:14:09 +0200
Message-ID: <20200611101409.GC32093@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-43-joro@8bytes.org>
 <20200520192230.GK1457@zn.tnic>
 <20200604120749.GC30945@8bytes.org>
 <20200604153021.GC2246@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200604153021.GC2246@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 04, 2020 at 05:30:27PM +0200, Borislav Petkov wrote:
> Hmmkay, I see vc_no_ghcb doing
> 
> call    do_vc_no_ghcb
> 
> and that's setup in early_idt_setup().
> 
> vc_boot_ghcb(), OTOH, is called by do_early_exception() only so that one
> could be called handle_vc_boot_ghcb(), no? I.e., I don't see it being an
> IDT entry point.

Right, I renamed it to handle_vc_boot_ghcb().


	Joerg
