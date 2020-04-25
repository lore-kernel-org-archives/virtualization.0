From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Sat, 25 Apr 2020 14:49:09 +0200
Message-ID: <20200425124909.GO30814@suse.de>
References: <20200319091407.1481-56-joro@8bytes.org>
 <20200424210316.848878-1-mstunes@vmware.com>
 <2c49061d-eb84-032e-8dcb-dd36a891ce90@intel.com>
 <ead88d04-1756-1190-2b37-b24f86422595@amd.com>
 <4d2ac222-a896-a60e-9b3c-b35aa7e81a97@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4d2ac222-a896-a60e-9b3c-b35aa7e81a97@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, joro@8bytes.org, dan.j.williams@intel.com, dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com, jslaby@suse.cz, keescook@chromium.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, thellstrom@vmware.com, virtualization@lists.linux-foundation.org, x86@kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Dave,

On Fri, Apr 24, 2020 at 03:53:09PM -0700, Dave Hansen wrote:
> Ahh, so any instruction that can have an instruction intercept set
> potentially needs to be able to tolerate a #VC?  Those instruction
> intercepts are under the control of the (untrusted relative to the
> guest) hypervisor, right?
> 
> >From the main sev-es series:
> 
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +idtentry vmm_communication     do_vmm_communication    has_error_code=1
> +#endif

The next version of the patch-set (which I will hopefully have ready
next week) will have this changed. The #VC exception handler uses an IST
stack and is set to paranoid=1 and shift_ist. The IST stacks for the #VC
handler are only allocated when SEV-ES is active.

> That's a fun point because it means that the (untrusted) hypervisor can
> cause endless faults.  I *guess* we have mitigation for this with our
> stack guard pages, but it's still a bit nasty that the hypervisor can
> arbitrarily land a guest in the double-fault handler.
> 
> It just all seems a bit weak for the hypervisor to be considered
> untrusted.  But, it's _certainly_ a steep in the right direction from SEV.

Yeah, a malicious hypervisor can do bad things to an SEV-ES VM, but it
can't easily steal its secrets from memory or registers. The #VC handler
does its best to just crash the VM if unexpected hypervisor behavior is
detected.


Regards,

	Joerg
