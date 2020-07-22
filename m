From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
Date: Wed, 22 Jul 2020 11:04:42 +0200
Message-ID: <20200722090442.GI6132@suse.de>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200715092456.GE10769@hirez.programming.kicks-ass.net>
 <20200715093426.GK16200@suse.de>
 <20200715095556.GI10769@hirez.programming.kicks-ass.net>
 <20200715101034.GM16200@suse.de>
 <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
 <20200721124957.GD6132@suse.de>
 <CAAYXXYwVV_g8pGL52W9vxkgdNxg1dNKq_OBsXKZ_QizdXiTx2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAYXXYwVV_g8pGL52W9vxkgdNxg1dNKq_OBsXKZ_QizdXiTx2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erdem Aktas <erdemaktas@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Erdem,

On Tue, Jul 21, 2020 at 09:48:51AM -0700, Erdem Aktas wrote:
> Yes, I am using OVMF with SEV-ES (sev-es-v12 patches applied). I am
> running Ubuntu 18.04 distro. My grub target is x86_64-efi. I also
> tried installing the grub-efi-amd64 package. In all cases, the grub is
> running in 64bit but enters the startup_32 in 32 bit mode. I think
> there should be a 32bit #VC handler just something very similar in the
> OVMF patches to handle the cpuid when the CPU is still in 32bit mode.
> As it is now, it will be a huge problem to support different distro images.
> I wonder if I am the only one having this problem.

I havn't heard from anyone else that the startup_32 boot-path is being
used for SEV-ES. What OVMF binary do you use for your guest?

In general it is not that difficult to support that boot-path too, but
I'd like to keep that as a future addition, as the patch-set is already
quite large. In the startup_32 path there is already a GDT set up, so
whats needed is an IDT and a 32-bit #VC handler using the MRS-based
protocol (and hoping that there will only be CPUID intercepts until it
reaches long-mode).

Regards,

	Joerg
