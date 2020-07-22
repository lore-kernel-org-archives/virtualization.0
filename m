From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 51/75] x86/sev-es: Handle MMIO events
Date: Wed, 22 Jul 2020 09:55:46 +0200
Message-ID: <20200722075546.GG6132@suse.de>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-52-joro@8bytes.org>
 <40D5C698-1ED2-4CCE-9C1D-07620A021A6A@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <40D5C698-1ED2-4CCE-9C1D-07620A021A6A@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Stunes <mstunes@vmware.com>
Cc: Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, virtualization@
List-Id: virtualization@lists.linuxfoundation.org

Hi Mike,

On Tue, Jul 21, 2020 at 09:01:44PM +0000, Mike Stunes wrote:
> I’m running into an MMIO-related bug when I try testing this on our hypervisor.
> 
> During boot, probe_roms (arch/x86/kernel/probe_roms.c) uses
> romchecksum over the video ROM and extension ROM regions. In my test
> VM, the video ROM romchecksum starts at virtual address
> 0xffff8880000c0000 and has length 65536. But, at address
> 0xffff8880000c4000, we switch from being video-ROM-backed to being
> unbacked by anything.
> 
> With SEV-ES enabled, our platform handles reads and writes to unbacked
> memory by treating them as MMIO. So, the read from 0xffff8880000c4000
> causes a #VC, which is handled by do_early_exception.
> 
> In handling the #VC, vc_slow_virt_to_phys fails for that address. My
> understanding is that the #VC handler should then add an entry to the
> page tables and retry the faulting access. Somehow, that isn’t
> happening. From the hypervisor side, it looks like the guest is
> looping somehow. (I think the VCPU is mostly unhalted and making
> progress, but the guest never gets past that romchecksum.) The guest
> never actually makes an MMIO vmgexit for that address.

That sounds like your guest is in a page-fault loop, but I can't yet
explain why. Can you please find out the instruction which is causing
the #VC exception?

If a page-fault happens during #VC emulation it is forwared to the
page-fault handler, so this should work. But somehow this isn't
happening or the page-fault handler can't map the faulting address.


Regards,

	Joerg
