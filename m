From: Dan Hecht <dhecht@vmware.com>
Subject: Re: Stolen and degraded time and schedulers
Date: Wed, 14 Mar 2007 13:26:10 -0700
Message-ID: <45F85A62.8050001@vmware.com>
References: <45F6D1D0.6080905@goop.org>	 <1173816769.22180.14.camel@localhost>	<45F70A71.9090205@goop.org> <1173821224.1416.24.camel@dwalker1> <45F71EA5.2090203@goop.org> <45F74515.7010808@vmware.com> <45F77C27.8090604@goop.org> <45F846AB.6060200@vmware.com> <45F84E39.7030507@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030869AbXCNU0P@vger.kernel.org>
In-Reply-To: <45F84E39.7030507@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: dwalker@mvista.com, cpufreq@lists.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, paulus@au.ibm.com, schwidefsky@de.ibm.com, Rik van Riel <riel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


>>> How is cpustat->steal used?  How does it get out to usermode?
>>>
>> Via /proc/stat, used by modern 'top', maybe other utilities.  It is
>> useful to users who want to see where the time is really going from
>> inside a guest when running on a (para)virtual machine.
>>
>> I believe previous set of xen paravirt-ops patches already handled
>> cases #2 and #3 (but no longer do since switching to clockevents), and
>> the old vmitime code did also.  Obviously, we need revamp this stuff
>> to make it fit in with the new clockevents/hrtimer way of doing things.
> 
> I added stolen time accounting to xen-pv_ops last night.  For Xen, at
> least, it wasn't hard to fit into the clockevent infrastructure.  I just
> update the stolen time accounting for each cpu when it gets a timer
> tick; they seem to get a tick every couple of seconds even when idle.
> 

Sounds good.  I don't see this in your patchset you sent yesterday 
though; did you add it after sending out those patches?  if so, could 
you forward the new patch?  does it explicitly prevent stolen time from 
getting accounted as  user/system time or does it just rely on NO_HZ 
mode sort of happening to work that way (since the one shot timer is 
skipped ahead for missed ticks)?

thanks,
Dan
