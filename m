From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 40/75] x86/sev-es: Compile early handler code into
 kernel image
Date: Thu, 4 Jun 2020 13:54:13 +0200
Message-ID: <20200604115413.GB30945@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-41-joro@8bytes.org>
 <20200520091415.GC1457@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200520091415.GC1457@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 20, 2020 at 11:14:15AM +0200, Borislav Petkov wrote:
> On Tue, Apr 28, 2020 at 05:16:50PM +0200, Joerg Roedel wrote:
> > +static inline u64 sev_es_rd_ghcb_msr(void)
> > +{
> > +	return native_read_msr(MSR_AMD64_SEV_ES_GHCB);
> > +}
> > +
> > +static inline void sev_es_wr_ghcb_msr(u64 val)
> > +{
> > +	u32 low, high;
> > +
> > +	low  = (u32)(val);
> > +	high = (u32)(val >> 32);
> > +
> > +	native_write_msr(MSR_AMD64_SEV_ES_GHCB, low, high);
> > +}
> 
> Instead of duplicating those two, you can lift the ones in the
> compressed image into sev-es.h and use them here. I don't care one bit
> about the MSR tracepoints in native_*_msr().

It is not only the trace-point, this would also eliminate exception
handling in case the MSR access triggers a #GP. The "Unhandled MSR
read/write" messages would turn into a "General Protection Fault"
message.


	Joerg
