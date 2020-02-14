From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 41/62] x86/sev-es: Handle MSR events
Date: Fri, 14 Feb 2020 08:23:24 +0100
Message-ID: <20200214072324.GE22063@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-42-joro@8bytes.org>
 <b688b4ad-5a64-d2df-6dd8-e23fac75a6b9@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b688b4ad-5a64-d2df-6dd8-e23fac75a6b9@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 13, 2020 at 07:45:00AM -0800, Dave Hansen wrote:
> On 2/11/20 5:52 AM, Joerg Roedel wrote:
> > Implement a handler for #VC exceptions caused by RDMSR/WRMSR
> > instructions.
> 
> As a general comment on all of these event handlers: Why do we bother
> having the hypercalls in the interrupt handler as opposed to just
> calling them directly.  What you have is:
> 
> 	wrmsr()
> 	-> #VC exception
> 	   hcall()
> 
> But we could make our rd/wrmsr() wrappers just do:
> 
> 	if (running_on_sev_es())
> 		hcall(HCALL_MSR_WHATEVER...)
> 	else
> 		wrmsr()
> 
> and then we don't have any of the nastiness of exception handling.

Yes, investigating this is on the list for future optimizations (besides
caching CPUID results). My idea is to use alternatives patching for
this. But the exception handling is needed anyway because #VC
exceptions happen very early already, basically the first thing after
setting up a stack is calling verify_cpu(), which uses CPUID.
The other reason is that things like MMIO and IOIO instructions can't be
easily patched by alternatives. Those would work with the runtime
checking you showed above, though.

Regards,

	Joerg
