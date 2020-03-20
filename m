From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 23/70] x86/sev-es: Add support for handling IOIO
 exceptions
Date: Fri, 20 Mar 2020 23:24:27 +0100
Message-ID: <20200320222427.GG611@suse.de>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-24-joro@8bytes.org>
 <alpine.DEB.2.21.2003201402100.205664@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003201402100.205664@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 20, 2020 at 02:03:17PM -0700, David Rientjes wrote:
> On Thu, 19 Mar 2020, Joerg Roedel wrote:
> > +	if (exit_info_1 & IOIO_TYPE_STR) {
> > +		int df = (regs->flags & X86_EFLAGS_DF) ? -1 : 1;
> >		[ ... ]
> > +		if (!(exit_info_1 & IOIO_TYPE_IN)) {
> > +			ret = vc_insn_string_read(ctxt,
> > +					       (void *)(es_base + regs->si),
> > +					       ghcb->shared_buffer, io_bytes,
> > +					       exit_info_2, df);
> 
> The last argument to vc_insn_string_read() is "bool backwards" which in 
> this case it appears will always be true?

Right, thanks, good catch, I'll fix this. Seems to be a leftover from a
previous version.

Regards,

	Joerg
