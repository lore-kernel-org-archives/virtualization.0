From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 70/75] x86/head/64: Don't call verify_cpu() on
 starting APs
Date: Wed, 15 Jul 2020 11:26:38 +0200
Message-ID: <20200715092638.GJ16200@suse.de>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-71-joro@8bytes.org>
 <202007141837.2B93BBD78@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <202007141837.2B93BBD78@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Kees,

thanks for your reviews!

On Tue, Jul 14, 2020 at 06:40:30PM -0700, Kees Cook wrote:
> Eek, no. MSR_IA32_MISC_ENABLE_XD_DISABLE needs to be cleared very early
> during CPU startup; this can't just be skipped.

That MSR is Intel-only, right? The boot-path installed here is only used
for SEV-ES guests, running on AMD systems, so this MSR is not even
accessed during boot on those VMs.

The alternative is to set up exception handling prior to calling
verify_cpu, including segments, stack and IDT. Given that verify_cpu()
does not add much value to SEV-ES guests, I'd like to avoid adding this
complexity.

> Also, is UNWIND_HINT_EMPTY needed for the new target?

Yes, I think it is, will add it in the next version.

Regards,

	Joerg
