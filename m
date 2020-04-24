From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Fri, 24 Apr 2020 15:53:09 -0700
Message-ID: <4d2ac222-a896-a60e-9b3c-b35aa7e81a97@intel.com>
References: <20200319091407.1481-56-joro@8bytes.org>
 <20200424210316.848878-1-mstunes@vmware.com>
 <2c49061d-eb84-032e-8dcb-dd36a891ce90@intel.com>
 <ead88d04-1756-1190-2b37-b24f86422595@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ead88d04-1756-1190-2b37-b24f86422595@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Lendacky <thomas.lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, joro@8bytes.org
Cc: dan.j.williams@intel.com, dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com, jroedel@suse.de, jslaby@suse.cz, keescook@chromium.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, thellstrom@vmware.com, virtualization@lists.linux-foundation.org, x86@kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 4/24/20 2:27 PM, Tom Lendacky wrote:
> On 4/24/20 4:24 PM, Dave Hansen wrote:
>> On 4/24/20 2:03 PM, Mike Stunes wrote:
>>> I needed to allow RDTSC(P) from userspace and in early boot in order to
>>> get userspace started properly. Patch below.
>>>
>>> ---
>>> SEV-ES guests will need to execute rdtsc and rdtscp from userspace and
>>> during early boot. Move the rdtsc(p) #VC handler into common code and
>>> extend the #VC handlers.
>>
>> Do SEV-ES guests _always_ #VC on rdtsc(p)?
> 
> Only if the hypervisor is intercepting those instructions.

Ahh, so any instruction that can have an instruction intercept set
potentially needs to be able to tolerate a #VC?  Those instruction
intercepts are under the control of the (untrusted relative to the
guest) hypervisor, right?

From the main sev-es series:

+#ifdef CONFIG_AMD_MEM_ENCRYPT
+idtentry vmm_communication     do_vmm_communication    has_error_code=1
+#endif

Since this is set as non-paranoid, that both limits the instructions
that can be used in entry paths *and* limits the future architecture
from being able add instructions that a current SEV-ES guest doesn't
know about.  Does SEV-ES have versioning so guests can tell if they
might be subject to new interrupt intercepts for which they are not
prepared?  I didn't see anything obvious in section 15.35 of the manual.

There's also a nugget in the manual that says:

> Similarly, the hypervisor should avoid setting intercept bits for
> events that would occur in the #VC handler (such as IRET).

That's a fun point because it means that the (untrusted) hypervisor can
cause endless faults.  I *guess* we have mitigation for this with our
stack guard pages, but it's still a bit nasty that the hypervisor can
arbitrarily land a guest in the double-fault handler.

It just all seems a bit weak for the hypervisor to be considered
untrusted.  But, it's _certainly_ a steep in the right direction from SEV.
