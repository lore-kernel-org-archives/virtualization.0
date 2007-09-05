From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Wed, 05 Sep 2007 21:10:44 +0100
Message-ID: <46DF0D44.2010201@goop.org>
References: <46CE70C8.2030005@vmware.com> <46CE8069.9070404@goop.org>	 <46CE81DC.90103@vmware.com>  <46D9D517.6010201@goop.org>	 <1188850468.10802.66.camel@localhost.localdomain>	 <46DD60A9.8080203@goop.org> <1189010022.10802.161.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757921AbXIEULj@vger.kernel.org>
In-Reply-To: <1189010022.10802.161.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Andi Kleen <ak@suse.de>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tue, 2007-09-04 at 14:42 +0100, Jeremy Fitzhardinge wrote:
>   
>> Rusty Russell wrote:
>>     
>>>  static inline void arch_flush_lazy_mmu_mode(void)
>>>  {
>>> -	PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_FLUSH);
>>> +	if (unlikely(__get_cpu_var(paravirt_lazy_mode) == PARAVIRT_LAZY_MMU))
>>> +		arch_leave_lazy_mmu_mode();
>>>  }
>>>   
>>>       
>> This changes the semantics a bit; previously "flush" would flush
>> anything pending but leave us in lazy mode.  This just drops lazymode
>> altogether?
>>
>> I guess if we assume that flushing is a rare event then its OK, but I
>> think the name's a bit misleading.  How does it differ from plain
>> arch_leave_lazy_mmu_mode()?
>>     
>
> Whether it's likely or unlikely to be in lazy mode, basically.  But
> you're right, this should be folded, since we don't want to "leave" lazy
> mode twice.
>   

Hm, I think there's still a problem here.  In the current code, you can
legitimately flush lazy mode with preemption enabled (ie, there's no
lazy mode currently active), but it's always a bug to enable/disable
lazy mode with preemption enabled.   Certainly enabling lazy mode with
preemption enabled is always a bug, but you could make disable
preempt-safe (and the bug checking should be in the common code).

    J
