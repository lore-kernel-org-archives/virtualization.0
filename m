From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
 ops
Date: Sun, 06 Aug 2006 22:43:49 -0700
Message-ID: <44D6D315.2030907@goop.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070730.17813.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751080AbWHGFnn@vger.kernel.org>
In-Reply-To: <200608070730.17813.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> +/* Stop speculative execution */
>> +static inline void sync_core(void)
>> +{
>> +	unsigned int eax = 1, ebx, ecx, edx;
>> +	__cpuid(&eax, &ebx, &ecx, &edx);
>> +}
>>     
>
> Actually I don't think this one should be para virtualized at all.
> I don't see any reason at all why a hypervisor should trap it and it
> is very time critical. I would recommend you move it back into the 
> normal files without hooks.
>   

When VT/AMDV is enabled, cpuid could cause a vm exit, so it would be 
nice to use one of the other serializing instructions in this case.  For 
the default implementation, it should probably be an explicit 
asm("cpuid") to make it clear that we don't want any paravirtualized cpuid.

    J
