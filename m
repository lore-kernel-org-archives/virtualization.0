From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 0/5] Paravirt: fix export of paravirt-ops to	binary
 modules
Date: Mon, 23 Apr 2007 14:18:51 -0700
Message-ID: <462D22BB.3080909@vmware.com>
References: <20070420015214.6834BBFC@zach-dev2.vmware.com>	
	<200704230149.44137.ak@suse.de>	
	<1177287845.17026.27.camel@localhost.localdomain>	
	<200704230249.29473.ak@suse.de>
	<1177290274.17026.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177290274.17026.42.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Chaz Masden <zamsden@gmail.com>, Petr Vandrovec <petr@vmware.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Mon, 2007-04-23 at 02:49 +0200, Andi Kleen wrote:
>   
>> On Monday 23 April 2007 02:24:05 Rusty Russell wrote:
>>     
>>> On Mon, 2007-04-23 at 01:49 +0200, Andi Kleen wrote:
>>>       
>>>>> Less exports good.  Consistency with all config options isn't a hard
>>>>> requirement: I'd be tempted not to export the pte functions.
>>>>>           
>>>> Yes paravirt_ops should be probably split into two for internal and external
>>>> available functions. Any takers? 
>>>>         
>>> Hi Andi!
>>>
>>> 	I'm a little uncomfortable with cutting the struct this way: I always
>>> thought it'd be a function split if we did one.
>>>       
>> It's a functional split, isn't it? arch/mm internal and "exported" to other
>> users
>>     
>
> Hi,
>
> 	When I said functional I was thinking "page table ops" vs "apic ops"
> etc.  There's little logic to what needs exporting.
>
> 	Most modules only need the interrupt operations.  A small handful want
> more, and then some (kvm, lguest) need a whole range of crap (these
> should use the native_ versions directly, since nested paravirt is not
> supported).
>
> I did the work before; I'll drag it back out and see what the symbols
> are again...
>   

Interrupt control is needed in general.  CPUID is also widely used.
FPU control (clts, read / write cr0) is required for certain software 
operations.

There are non-obvious exports that are required for some modules; in 
particular, MSRs may be used in video drivers, and wbinvd must be 
available to hardware drivers.  We may wish to simply trap / emulate 
these instructions and remove the paravirt-ops altogether.  They are not 
performance critical in 32-bit, and will complicate loading non-GPL 
drivers for a wide range of hardware - hardware that is not exposed in a 
virtualized environment to begin with.

Some rather more interesting modules map kernel page tables to read the 
physical frame numbers from ptes; this is
safe to do if you get_pages or get_user_pages and keep the pages 
locked.  This requires kmap_atomic_pte to be available.  Similarly, 
pte_val and make_pte need to be available.  Mostly only modules that 
require a native environment (virtualization modules) need them, but we 
need some way to either resolve the symbol as load time or make the 
requirement for the symbol go away.  No matter how you look at it, 
failing to load a module because of an unresolved paravirt-op that is 
actually going to be reduced to a nop is a very silly situation to be in.

Zach
