From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 64/75] x86/sev-es: Cache CPUID results for improved
 performance
Date: Wed, 27 May 2020 12:49:06 -0500
Message-ID: <cab5e409-be9e-f2c7-424f-6b7d031324dc@amd.com>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-65-joro@8bytes.org>
 <20200520051637.GA16599@linux.intel.com> <20200526091909.GB28228@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200526091909.GB28228@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 5/26/20 4:19 AM, Borislav Petkov wrote:
> On Tue, May 19, 2020 at 10:16:37PM -0700, Sean Christopherson wrote:
>> The whole cache on-demand approach seems like overkill.  The number of CPUID
>> leaves that are invoked after boot with any regularity can probably be counted
>> on one hand.   IIRC glibc invokes CPUID to gather TLB/cache info, XCR0-based
>> features, and one or two other leafs.  A statically sized global array that's
>> arbitrarily index a la x86_capability would be just as simple and more
>> performant.  It would also allow fancier things like emulating CPUID 0xD in
>> the guest if you want to go down that road.
> 
> And before we do any of that "caching" or whatnot, I'd like to see
> numbers justifying its existence. Because if it is only a couple of
> CPUID invocations and the boot delay is immeasurable, then it's not
> worth the effort.

I added some rudimentary stats code to see how many times there was a 
CPUID cache hit on a 64-vCPU guest during a kernel build (make clean 
followed by make with -j 64):

   SEV-ES CPUID cache statistics
     0x00000000/0x00000000: 220,384
     0x00000007/0x00000000: 213,306
     0x80000000/0x00000000: 1,054,642
     0x80000001/0x00000000: 213,306
     0x80000005/0x00000000: 210,334
     0x80000006/0x00000000: 420,668
     0x80000007/0x00000000: 210,334
     0x80000008/0x00000000: 420,684

     2,963,658 cache hits

So it is significant in quantity, but I'm not sure what the overall 
performance difference is. If I can find some more time I'll try to 
compare the kernel builds with and without the caching to see if it is 
noticeable.

Thanks,
Tom

> 
