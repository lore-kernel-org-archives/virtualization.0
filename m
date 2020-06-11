From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 47/75] x86/sev-es: Add Runtime #VC Exception Handler
Date: Thu, 11 Jun 2020 13:48:31 +0200
Message-ID: <20200611114831.GA11924@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-48-joro@8bytes.org>
 <20200523075924.GB27431@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200523075924.GB27431@zn.tnic>
Sender: kvm-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 23, 2020 at 09:59:24AM +0200, Borislav Petkov wrote:
> On Tue, Apr 28, 2020 at 05:16:57PM +0200, Joerg Roedel wrote:
> > +	/*
> > +	 * Mark the per-cpu GHCBs as in-use to detect nested #VC exceptions.
> > +	 * There is no need for it to be atomic, because nothing is written to
> > +	 * the GHCB between the read and the write of ghcb_active. So it is safe
> > +	 * to use it when a nested #VC exception happens before the write.
> > +	 */
> 
> Looks liks that is that text... support for nested #VC exceptions.
> I'm sure this has come up already but why do we even want to support
> nested #VCs? IOW, can we do without them first or are they absolutely
> necessary?
> 
> I'm guessing VC exceptions inside the VC handler but what are the
> sensible use cases?

The most important use-case is #VC->NMI->#VC. When an NMI hits while the
#VC handler uses the GHCB and the NMI handler causes another #VC, then
the contents of the GHCB needs to be backed up, so that it doesn't
destroy the GHCB contents of the first #VC handling path.


Regards,

	Joerg
