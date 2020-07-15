From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 70/75] x86/head/64: Don't call verify_cpu() on
 starting APs
Date: Wed, 15 Jul 2020 12:49:23 -0700
Message-ID: <202007151244.315DCBAE@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-71-joro@8bytes.org>
 <202007141837.2B93BBD78@keescook>
 <20200715092638.GJ16200@suse.de>
 <202007150815.A81E879@keescook>
 <20200715154856.GA24822@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200715154856.GA24822@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2020 at 05:48:56PM +0200, Joerg Roedel wrote:
> It is actually the CPUID instructions that cause #VC exceptions. The
> MSRs that are accessed on AMD processors are not intercepted in the
> hypervisors this code has been tested on, so these will not cause #VC
> exceptions.

Aaah. I see. Thanks for the details there. So ... can you add a bunch
more comments about why/when the new entry path is being used? I really
don't want to accidentally discover some unrelated refactoring down
the road (in months, years, unrelated to SEV, etc) starts to also skip
verify_cpu() on Intel systems. There had been a lot of BIOSes that set
this MSR to disable NX, and I don't want to repeat that pain: Linux must
never start an Intel CPU with that MSR set. :P

-- 
Kees Cook
