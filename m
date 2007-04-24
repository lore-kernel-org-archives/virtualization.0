From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 1/4] Ignore stolen time in the softlockup watchdog
Date: Tue, 24 Apr 2007 13:46:47 -0700
Message-ID: <462E6CB7.9070403@goop.org>
References: <20070327214919.800272641@goop.org>	<20070327215827.871954359@goop.org>	<20070423234910.50149faf.akpm@linux-foundation.org>	<462E43A7.1050001@goop.org>	<20070424105738.e0ce36a9.akpm@linux-foundation.org>	<462E4969.6070802@goop.org>	<20070424113222.ed2e1314.akpm@linux-foundation.org>	<462E61F1.7060403@goop.org> <20070424131427.940d461e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754652AbXDXUql@vger.kernel.org>
In-Reply-To: <20070424131427.940d461e.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Prarit Bhargava <prarit@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Dan Hecht <dhecht@vmware.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Chris Lalancette <clalance@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>, Andi Kleen <ak@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Tue, 24 Apr 2007 13:00:49 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> Andrew Morton wrote:
>>     
>>> Well, it _is_ mysterious.
>>>
>>> Did you try to locate the code which failed?  I got lost in macros and
>>> include files, and gave up very very easily.  Stop hiding, Ingo.
>>>   
>>>       
>> OK, I've managed to reproduce it.  Removing the local_irq_save/restore
>> from sched_clock() makes it go away, as I'd expect (otherwise it would
>> really be magic).
>>     
>
> erm, why do you expect that?  A local_irq_save()/local_irq_restore() pair
> shouldn't be affecting anything?
>   

Well, yes.  I have no idea why it causes a problem.  But other than
that, sched_clock does absolutely nothing which would affect lockdep state.

>>  But given that it never seems to touch the softlockup
>> during testing, I have no idea what difference it makes...
>>     
>
> To what softlockup are you referring, and what does that have to do with
> anything?

You dropped this patch, "Ignore stolen time in the softlockup watchdog"
because its presence triggers the lock tester errors.  The only thing
this patch does is use sched_clock() rather than jiffies to measure
lockup time.  It therefore appears, for some reason, that using
sched_clock() in the softlockup code is making the lock-test fail. 
Since the lock test doesn't explicitly do any softlockup stuff, the
connection must be implicit via sched_lock - but how, I can't imagine.

Since sched_clock() itself looks perfectly OK, and the softlockup
watchdog seems fine too, I can only conclude its a bug in the lock
testing stuff.  But I don't know what.

    J
