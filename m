From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Stolen and degraded time and schedulers
Date: Wed, 14 Mar 2007 11:06:47 -0700
Message-ID: <1173895607.3101.58.camel@imap.mvista.com>
References: <45F6D1D0.6080905@goop.org>
	 <1173816769.22180.14.camel@localhost>  <45F70A71.9090205@goop.org>
	 <1173821224.1416.24.camel@dwalker1>  <45F71EA5.2090203@goop.org>
	 <1173837606.23595.32.camel@imap.mvista.com>  <45F79B9C.20609@goop.org>
	 <1173888673.3101.12.camel@imap.mvista.com>  <45F824BE.1060708@goop.org>
	 <1173891595.3101.17.camel@imap.mvista.com>  <45F82C01.3000704@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752710AbXCNSGz@vger.kernel.org>
In-Reply-To: <45F82C01.3000704@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Con Kolivas <kernel@kolivas.org>, Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-03-14 at 10:08 -0700, Jeremy Fitzhardinge wrote:

> The actual length of the timeslices is an orthogonal issue.  It may be
> that you want to give processes more cpu time by making their quanta
> longer to compensate for lost cpu time, but that would affect their
> real-time characteristics.  Or you could keep the quanta small, and give
> those processes more of them.
> 
> But all this is getting deep into scheduler design, which is not what I
> want to get into; I'm just proposing a better metric for a scheduler to
> use in whatever way it wants.

From prior emails I think your suggesting that 1ms (or 5 or 10) of time
should actually be a variable X that is changed inside sched_clock().
That's not the purpose of that API call, sched_clock() measure real time
period.

After reading your emails it sounds like what you really want is similar
to accurate state accounting which is used for scheduling purposes. Part
of that has already been implemented at least twice that I know of.
Accounting real time against specific states was done in two version of
microstate accounting. Those are fine starting points for the changes
you are wanting.

Daniel
