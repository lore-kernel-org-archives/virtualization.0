From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 23/75] x86/boot/compressed/64: Setup GHCB Based VC
 Exception handler
Date: Wed, 3 Jun 2020 12:08:57 +0200
Message-ID: <20200603100857.GA20099@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-24-joro@8bytes.org>
 <20200511200709.GE25861@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200511200709.GE25861@zn.tnic>
Sender: kvm-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 11, 2020 at 10:07:09PM +0200, Borislav Petkov wrote:
> On Tue, Apr 28, 2020 at 05:16:33PM +0200, Joerg Roedel wrote:
> > @@ -63,3 +175,45 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
> >  	while (true)
> >  		asm volatile("hlt\n");
> >  }
> > +
> > +static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
> > +					  void *src, char *buf,
> > +					  unsigned int data_size,
> > +					  unsigned int count,
> > +					  bool backwards)
> > +{
> > +	int i, b = backwards ? -1 : 1;
> > +	enum es_result ret = ES_OK;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		void *s = src + (i * data_size * b);
> > +		char *d = buf + (i * data_size);
> 
> >From a previous review:
> 
> Where are we checking whether that count is not exceeding @buf or
> similar discrepancies?

These two functions are only called from vc_handle_ioio() and buf always
points to ghcb->shared_buffer.

In general, the caller has to make sure that sizeof(*buf) is at least
data_size*count, and handle_ioio() calculates count based on the size of
*buf.


	Joerg
