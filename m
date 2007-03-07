From: Dan Hecht <dhecht@vmware.com>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Tue, 06 Mar 2007 16:35:52 -0800
Message-ID: <45EE08E8.2020008@vmware.com>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	 <45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	 <20070306084647.GA16280@elte.hu>  <45ED2C82.3080008@vmware.com>	 <1173178774.24738.311.camel@localhost.localdomain>	 <45EDD82F.90204@vmware.com> <1173225182.24738.507.camel@localhost.localdomain> <45EE0628.1080108@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161023AbXCGAfv@vger.kernel.org>
In-Reply-To: <45EE0628.1080108@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: tglx@linutronix.de, Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, ak@suse.de, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/06/2007 04:24 PM, Jeremy Fitzhardinge wrote:
> Thomas Gleixner wrote:
>>> 3) clockevent set_next_event interface is suboptimal for paravirt (and 
>>> probably realtime-ish uses).  The problem is that the expiry is passed 
>>> as a relative time.  On paravirt, an arbitrary amount of (stolen) time 
>>> may have passed since the delta was computed and when the timer device 
>>> is programmed, causing that next interrupt to be too far out in the 
>>> future.  It seems a better interface for set_next_event would be to pass 
>>> the current time and the absolute expiry.  Actually, I sent email to 
>>> Thomas and Ingo about this (and some other clockevents/hrtimer feedback) 
>>> in July 2006, but never heard back.  Thoughts?
>>>     
>> There is no problem for realtime uses, as the reprogramming path is
>> running with local interrupts disabled. I can see the point for paravirt
>> and I'm not opposed to change / expand the interface for that. It might
>> be done by an extra clockevents feature flag, which requests absolute
>> time instead of relative time.
>>   
> 
> I'm not sure how much different it makes overall.  It's true that
> absolute time would be a more useful interface, but because the guest
> vcpu can be preempted at any time, we could miss the timeout
> regardless.  In Xen if you set a timeout for the past you get an
> immediate interrupt; I presume the clockevent code can deal with that?
> 

That's the problem though, you won't know to set it for the past since 
the expiry is relative.  When the vcpu starts running again, it will set 
the timer to expire X ns from now, not Xns from when the timer was 
requested.
