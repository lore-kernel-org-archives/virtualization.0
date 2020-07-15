From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 70/75] x86/head/64: Don't call verify_cpu() on
 starting APs
Date: Wed, 15 Jul 2020 08:26:14 -0700
Message-ID: <202007150815.A81E879@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-71-joro@8bytes.org>
 <202007141837.2B93BBD78@keescook>
 <20200715092638.GJ16200@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200715092638.GJ16200@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2020 at 11:26:38AM +0200, Joerg Roedel wrote:
> Hi Kees,
> 
> thanks for your reviews!
> 
> On Tue, Jul 14, 2020 at 06:40:30PM -0700, Kees Cook wrote:
> > Eek, no. MSR_IA32_MISC_ENABLE_XD_DISABLE needs to be cleared very early
> > during CPU startup; this can't just be skipped.
> 
> That MSR is Intel-only, right? The boot-path installed here is only used
> for SEV-ES guests, running on AMD systems, so this MSR is not even
> accessed during boot on those VMs.

Oh, hrm, yes, that's true. If other x86 maintainers are comfortable with
this, then okay. My sense is that changing the early CPU startup paths
will cause trouble down the line.

> The alternative is to set up exception handling prior to calling
> verify_cpu, including segments, stack and IDT. Given that verify_cpu()
> does not add much value to SEV-ES guests, I'd like to avoid adding this
> complexity.

So, going back to the requirements here ... what things in verify_cpu()
can cause exceptions? AFAICT, cpuid is safely handled (i.e. it is
detected and only run in a way to avoid exceptions and the MSR
reads/writes are similarly bound by CPU family/id range checks). I must
be missing something. :)

> 
> > Also, is UNWIND_HINT_EMPTY needed for the new target?
> 
> Yes, I think it is, will add it in the next version.
> 
> Regards,
> 
> 	Joerg

-- 
Kees Cook
