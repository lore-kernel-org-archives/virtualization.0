From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/3] Split paravirt ops by functionality
Date: Thu, 19 Nov 2009 16:21:28 +0100
Message-ID: <4B056278.2030306__41065.7125212767$1258644148$gmane$org@suse.de>
References: <1258503192-14246-1-git-send-email-agraf@suse.de>
	<1258503192-14246-2-git-send-email-agraf@suse.de>
	<4B055D65.2000201@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B055D65.2000201@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Nick Piggin <npiggin@suse.de>, Glauber Costa <glommer@redhat.com>, Avi Kivity <avi@redhat.com>, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> On 11/18/09 08:13, Alexander Graf wrote:
>   
>> Currently when using paravirt ops it's an all-or-nothing option. We can either
>> use pv-ops for CPU, MMU, timing, etc. or not at all.
>>
>> Now there are some use cases where we don't need the full feature set, but only
>> a small chunk of it. KVM is a pretty prominent example for this.
>>
>> So let's make everything a bit more fine-grained. We already have a splitting
>> by function groups, namely "cpu", "mmu", "time", "irq", "apic" and "spinlock".
>>
>> Taking that existing splitting and extending it to only compile in the PV
>> capable bits sounded like a natural fit. That way we don't get performance hits
>> in MMU code from using the KVM PV clock which only needs the TIME parts of
>> pv-ops.
>>
>> We define a new CONFIG_PARAVIRT_ALL option that basically does the same thing
>> the CONFIG_PARAVIRT did before this splitting. We move all users of
>> CONFIG_PARAVIRT to CONFIG_PARAVIRT_ALL, so they behave the same way they did
>> before.
>>
>> So here it is - the splitting! I would have made the patch smaller, but this
>> was the closest I could get to atomic (for bisect) while staying sane.
>>   
>>     
>
> The basic idea seems pretty sane.  I'm wondering how much compile test
> coverage you've given all these extra config options; there are now a
> lot more combinations, and your use of select is particularly worrying
> because they don't propagate dependencies properly.
>   

Uh - I don't see where there should be any dependencies.

> For example, does this actually work?
>   
>>  config XEN
>>  	bool "Xen guest support"
>> -	select PARAVIRT
>> +	select PARAVIRT_ALL
>>  	select PARAVIRT_CLOCK
>>  	depends on X86_64 || (X86_32 && X86_PAE && !X86_VISWS)
>>  	depends on X86_CMPXCHG && X86_TSC
>>   
>>     
> Does selecting PARAVIRT_ALL end up selecting all the other PARAVIRT_*?
>
> Can you reassure me?
>   

> +config PARAVIRT_ALL
> +	bool
> +	select PARAVIRT_CPU
> +	select PARAVIRT_TIME
> +	select PARAVIRT_IRQ
> +	select PARAVIRT_APIC
> +	select PARAVIRT_MMU
> +	default n
> +


So selecting PARAVIRT_ALL selects all the other split PARAVIRT parts
that in turn select PARAVIRT. I tested a compile on x86_64 with Xen DomU
support enabled and it compiled fine :-).

> Also, I think VMI is the only serious user of PARAVIRT_APIC, so we can
> mark that to go when VMI does.
>   

Sounds good :-). So the patch even serves as a helper for anyone who'll
remove that support later.

> What ends up using plain CONFIG_PARAVIRT?  Do we still need it?
>   

It's used for an info field that says which hypervisor we're running on
and as config option to know if we need to include the binary patch
magic. As soon as a single sub-paravirt option is selected, we need that
to make sure we have the framework in place.


Alex
