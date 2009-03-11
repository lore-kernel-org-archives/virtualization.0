From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Process accounting in interrupt diabled cases
Date: Wed, 11 Mar 2009 09:47:19 +0100
Message-ID: <20090311094719.0fe3de82__13373.4409384944$1236761782$gmane$org@skybase>
References: <1236380615.4637.67.camel@alok-dev1> <49B1C1D1.4070603@goop.org>
	<1236387583.4558.22.camel@alok-dev1> <49B1CD54.8070805@goop.org>
	<1236416374.23222.52.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1236416374.23222.52.camel@alok-dev1>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akataria@vmware.com
Cc: LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 07 Mar 2009 00:59:33 -0800
Alok Kataria <akataria@vmware.com> wrote:

> Yes that's alright, all that time when vcpu was idle and scheduled out
> will anyways be accounted as idle time, as mentioned in my earlier mail
> ( and if my understanding is not wrong) this is handled by
> tick_nohz_restart_sched_tick.
> 
> But i was talking about a case, where we have this code
> 	local_irq_disable()
> 	some_work()
> 	local_irq_enable()
> 
> If this some_work() executed for say 2 ticks, shouldn't the process
> executing this be accounted 2 ticks of system time ? According to my
> understanding, we will account a single tick for this, right ? 

Don't know too much about x86 and Xen but on s390 the tick is just a
convenient way to transfer the accumulated cpu time to the process and
the cpustat fields. The cpu time that has been used is determined by
the cpu timer. This would still work without any ticks at all, although
then you'd have to wait for the next context switch until the
accumulated cpu time gets visible in the process and cpustat.
In short: the above example just works fine for us.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
