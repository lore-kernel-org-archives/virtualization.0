From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 18/70] x86/boot/compressed/64: Add stage1 #VC handler
Date: Fri, 20 Mar 2020 23:19:23 +0100
Message-ID: <20200320221923.GL5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-19-joro@8bytes.org>
 <alpine.DEB.2.21.2003201413010.205664@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003201413010.205664@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: erdemaktas@google.com, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 20, 2020 at 02:16:39PM -0700, David Rientjes wrote:
> On Thu, 19 Mar 2020, Joerg Roedel wrote:
> > +#define	GHCB_SEV_GHCB_RESP_CODE(v)	((v) & 0xfff)
> > +#define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
> 
> Since preemption and irqs should be disabled before updating the GHCB and 
> its MSR and until the contents have been accessed following VMGEXIT, 
> should there be checks in place to ensure that's always the case?

Good point, some checking is certainly helpful. Currently it is the
case, because the GHCB is accessed and used only:

	1) At boot when only the boot CPU is running

	2) In the #VC handler, which does not enable interrupts

	3) In the NMI handler, which is also not preemptible

I can also add code to sev_es_get/put_ghcb to make sure these conditions
are met. All this does not prevent the preemption by NMIs, which could
cause another nested #VC exception, but that is handled separatly.


Regards,

	Joerg
