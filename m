From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Stolen and degraded time and schedulers
Date: Wed, 14 Mar 2007 09:11:13 -0700
Message-ID: <1173888673.3101.12.camel@imap.mvista.com>
References: <45F6D1D0.6080905@goop.org>
	<1173816769.22180.14.camel@localhost>  <45F70A71.9090205@goop.org>
	<1173821224.1416.24.camel@dwalker1>  <45F71EA5.2090203@goop.org>
	<1173837606.23595.32.camel@imap.mvista.com> <45F79B9C.20609@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F79B9C.20609@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: cpufreq@lists.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-03-13 at 23:52 -0700, Jeremy Fitzhardinge wrote:

> >
> > That's true, but given a constant clock (like what sched_clock should
> > have) then the accounting is similarly inaccurate. Any connection
> > between the scheduler and the TSC frequency changes aren't part of the
> > design AFAIK ..
> >   =

> =

> Well, my whole argument is that sched_clock /should not/ be a constant
> clock.  And I'm not quite sure why you keep bringing up the tsc, because
> it has no relevance.

Then your direction is wrong, sched_clock() should be constant ideally
(1millisecond should really be 1millisecond). Like I said in the last
email, change the scheduler to make it aware of the variable quantum
values.

Daniel
