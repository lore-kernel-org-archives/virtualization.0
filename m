From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Stolen and degraded time and schedulers
Date: Wed, 14 Mar 2007 14:16:45 -0700
Message-ID: <45F8663D.5050102@goop.org>
References: <45F6D1D0.6080905@goop.org>	 <1173816769.22180.14.camel@localhost>  <45F70A71.9090205@goop.org>	 <1173821224.1416.24.camel@dwalker1>  <45F71EA5.2090203@goop.org>	 <1173837606.23595.32.camel@imap.mvista.com>  <45F79B9C.20609@goop.org>	 <1173888673.3101.12.camel@imap.mvista.com>  <45F824BE.1060708@goop.org>	 <1173891595.3101.17.camel@imap.mvista.com>  <45F82C01.3000704@goop.org>	 <1173895607.3101.58.camel@imap.mvista.com>  <45F841EE.6060703@goop.org>	 <1173898800.3101.81.camel@imap.mvista.com>  <45F8508F.3070109@goop.org> <1173904438.3101.92.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932127AbXCNVQs@vger.kernel.org>
In-Reply-To: <1173904438.3101.92.camel@imap.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Con Kolivas <kernel@kolivas.org>, Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk, Virtualization Mailing List <virtualization@lists.osdl.org>, Peter Chubb <peterc@gelato.unsw.edu.au>
List-Id: virtualization@lists.linuxfoundation.org

Daniel Walker wrote:
> For interactive tasks (basic scheduling) the execution time, and sleep
> time need to be measured.

Sleep time is interesting.  It doesn't make much sense to talk about
time that was stolen while a process was sleeping (it was either stolen
from another running process, or the VCPU was just plain idle).  Also,
the definition of sched_clock I'm talking about is inherently per-cpu,
and sleeping has nothing to do with any cpu by definition.

So something other than sched_clock should be used to measure sleep
time, but it needs to produce interval measurements which are in the
same units as sched_clock.

>  It's also used for some posix cpu timers
> (sched_ns) , and it used for migration thread initialization.

sched_ns doesn't use it directly except for the case where the process
is currently running.  Anyway, it's compatible with what I'm talking about.

>  I'm sure
> it's used for a variety of out-of-tree random timing as well..
>   

Yeah, well...

    J
