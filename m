From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 42/75] x86/sev-es: Setup GHCB based boot #VC handler
Date: Thu, 4 Jun 2020 14:07:49 +0200
Message-ID: <20200604120749.GC30945@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-43-joro@8bytes.org>
 <20200520192230.GK1457@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200520192230.GK1457@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 20, 2020 at 09:22:30PM +0200, Borislav Petkov wrote:
> On Tue, Apr 28, 2020 at 05:16:52PM +0200, Joerg Roedel wrote:
> > diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
> > index b2cbcd40b52e..e1ed963a57ec 100644
> > --- a/arch/x86/include/asm/sev-es.h
> > +++ b/arch/x86/include/asm/sev-es.h
> > @@ -74,5 +74,6 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
> >  }
> >  
> >  extern void vc_no_ghcb(void);
> > +extern bool vc_boot_ghcb(struct pt_regs *regs);
> 
> Those function names need verbs:
> 
> 	handle_vc_no_ghcb
> 	handle_vc_boot_ghcb

This are IDT entry points and the names above follow the convention for
them, like e.g. 'page_fault', 'nmi' or 'general_protection'. Should I
still add the verbs or just add a comment explaining what those symbols
are?

> There's already another sev_es_setup_ghcb() in compressed/. All those
> functions with the same name are just confusion waiting to happen. Let's
> prepend the ones in compressed/ with "early_" or so, so that their names
> are at least different even if they're in two different files with the
> same name.
> 
> This way you know at least which function is used in which boot stages.

Okay, will see what can be changed. Some functions are part of the
interface for sev-es-shared.c and need to have the same names, but
sev_es_setup_ghcb() can be named differently.

> > +static void __init vc_early_vc_forward_exception(struct es_em_ctxt *ctxt)
> 
> That second "vc" looks redundant.

Heh, search and replace artifact :) Fixed now.


	Joerg
