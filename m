From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Lguest launcher, child starving parent
Date: Fri, 06 Apr 2007 13:17:56 +1000
Message-ID: <1175829476.12230.677.camel@localhost.localdomain>
References: <1175805620.24675.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1767513AbXDFDSX@vger.kernel.org>
In-Reply-To: <1175805620.24675.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: virtualization@lists.osdl.org, Glauber de Oliveira Costa <glommer@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-04-05 at 16:40 -0400, Steven Rostedt wrote:
> Glauber noticed long delays between hitting a key, and seeing data come
> up on the virtual console.  Looking into this, I found that the
> wake_parent routine that reads from all devices was actually starving
> out the parent after sending the parent a signal to wake up.
> 
> The thing is, the child which takes the console input is recognized by
> the scheduler as an interactive process.  The parent, doesn't do so
> much, so it is recognized more as a CPU hog. So the child easily gets a
> higher priority than the parent.

Hmm, I changed the prio of the waker from "nice(19)" to "nice(5)" after
Andi complained (he still isn't happy tho).  I'll change it back for the
moment.

Unfortunately we need to keep sending signals to the parent, in order to
avoid the race between unblocking SIGUSR1 and the read() on /dev/lguest.
This is the nature of Unix signals, unfortunately.

I've been pondering restoring the original /dev/lguest interface, which
handed an fd directly into the kernel.  Then the child would just use
this fd and not send signals.  It could well improve performance, too...

Thanks for the bug report,
Rusty.
