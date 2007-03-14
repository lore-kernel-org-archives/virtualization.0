From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Stolen and degraded time and schedulers
Date: Wed, 14 Mar 2007 09:37:18 -0700
Message-ID: <45F824BE.1060708@goop.org>
References: <45F6D1D0.6080905@goop.org>	 <1173816769.22180.14.camel@localhost>  <45F70A71.9090205@goop.org>	 <1173821224.1416.24.camel@dwalker1>  <45F71EA5.2090203@goop.org>	 <1173837606.23595.32.camel@imap.mvista.com>  <45F79B9C.20609@goop.org> <1173888673.3101.12.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932238AbXCNQhV@vger.kernel.org>
In-Reply-To: <1173888673.3101.12.camel@imap.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Con Kolivas <kernel@kolivas.org>, Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Daniel Walker wrote:
> Then your direction is wrong, sched_clock() should be constant ideally
> (1millisecond should really be 1millisecond). 

Rather than repeating myself, I suggest you read my original post
again.  But my point is that "I was runnable on a cpu for 1ms of real
time" is a meaningless measurement: you want to measure "I ran for 1
cpu-ms", which is a unit which depends on how work a particular CPU does
in relationship to other CPUs on the system, or even itself at some
previous time.

> Like I said in the last
> email, change the scheduler to make it aware of the variable quantum
> values.

I suppose you could, but that seems more complex.  I think you could
encode the same information in the measurement of how much work a cpu
actually got done while a process was scheduled on it.

    J
