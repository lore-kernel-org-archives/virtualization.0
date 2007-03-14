From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Stolen and degraded time and schedulers
Date: Wed, 14 Mar 2007 13:33:58 -0700
Message-ID: <1173904438.3101.92.camel@imap.mvista.com>
References: <45F6D1D0.6080905@goop.org>
	 <1173816769.22180.14.camel@localhost>  <45F70A71.9090205@goop.org>
	 <1173821224.1416.24.camel@dwalker1>  <45F71EA5.2090203@goop.org>
	 <1173837606.23595.32.camel@imap.mvista.com>  <45F79B9C.20609@goop.org>
	 <1173888673.3101.12.camel@imap.mvista.com>  <45F824BE.1060708@goop.org>
	 <1173891595.3101.17.camel@imap.mvista.com>  <45F82C01.3000704@goop.org>
	 <1173895607.3101.58.camel@imap.mvista.com>  <45F841EE.6060703@goop.org>
	 <1173898800.3101.81.camel@imap.mvista.com>  <45F8508F.3070109@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030882AbXCNUeG@vger.kernel.org>
In-Reply-To: <45F8508F.3070109@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Con Kolivas <kernel@kolivas.org>, Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk, Virtualization Mailing List <virtualization@lists.osdl.org>, Peter Chubb <peterc@gelato.unsw.edu.au>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-03-14 at 12:44 -0700, Jeremy Fitzhardinge wrote:
> Daniel Walker wrote:
> > sched_clock is used to bank real time against some specific states
> > inside the scheduler, and no it doesn't _just_ measure a processes
> > executing time.
> >   
> 
> Could you point these places out?  All uses of sched_clock() that I
> could see in kernel/sched.c seemed to be related to working out how
> long
> something spent executing, either in the scheduler proper, or
> benchmarking cache characteristics. 

For interactive tasks (basic scheduling) the execution time, and sleep
time need to be measured. It's also used for some posix cpu timers
(sched_ns) , and it used for migration thread initialization. I'm sure
it's used for a variety of out-of-tree random timing as well..

Daniel
