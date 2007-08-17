From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH/RFC 3/4]Introduce "account modifiers" mechanism
Date: Fri, 17 Aug 2007 18:30:50 +1000
Message-ID: <1187339450.6449.115.camel__37773.0510234416$1187339648$gmane$org@localhost.localdomain>
References: <46C4719A.2060308@bull.net> <46C4720F.7030304@bull.net>
	<46C4725A.4070607@bull.net>  <46C4740F.2050701@bull.net>
	<1187303955.6449.7.camel@localhost.localdomain>
	<46C54FB8.7050504@bull.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C54FB8.7050504@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-08-17 at 09:35 +0200, Laurent Vivier wrote:
> Rusty Russell wrote:
> > Hi Laurent,
> 
> Hi Rusty,
> how are your puppies ?

They're getting a little fat, actually.  Too many features ...

> - remove PATCH 3, and add in task_struct a "ktime vtime" where we accumulate
> guest time (by calling something like guest_enter() and guest_exit() from the
> virtualization engine), and when in account_system_time() we have cputime >
> vtime we substrate vtime from cputime and add vtime to user time and guest time.
> But doing like this we freeze in kernel/sched.c the link between system time,
> user time and guest time (i.e. system time = system time - vtime, user time =
> user time + vtime and guest time = guest time + vtime).

Actually, I think we can set a per-cpu "in_guest" flag for the scheduler
code, which then knows to add the tick to the guest time.  That seems
the simplest possible solution.

lguest or kvm would set the flag before running the guest (which is done
with preempt disabled or using preemption hooks), and reset it
afterwards.

Thoughts?
Rusty.
