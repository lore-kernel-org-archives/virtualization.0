From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC v3 3/6] sched/idle: Add a generic poll before enter
	real idle path
Date: Wed, 15 Nov 2017 23:03:08 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711152240010.2146__38726.5803911307$1510783412$gmane$org@nanos>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-4-git-send-email-quan.xu0@gmail.com>
	<20171115121152.gqug5wzerlo3eimd@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171115121152.gqug5wzerlo3eimd@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Len Brown <len.brown@intel.com>, Quan Xu <quan.xu0@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Kyle Huey <me@kylehuey.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Quan Xu <quan.xu03@gmail.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, Tobias Klauser <tklauser@distanz.ch>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 15 Nov 2017, Peter Zijlstra wrote:

> On Mon, Nov 13, 2017 at 06:06:02PM +0800, Quan Xu wrote:
> > From: Yang Zhang <yang.zhang.wz@gmail.com>
> > 
> > Implement a generic idle poll which resembles the functionality
> > found in arch/. Provide weak arch_cpu_idle_poll function which
> > can be overridden by the architecture code if needed.
> 
> No, we want less of those magic hooks, not more.
> 
> > Interrupts arrive which may not cause a reschedule in idle loops.
> > In KVM guest, this costs several VM-exit/VM-entry cycles, VM-entry
> > for interrupts and VM-exit immediately. Also this becomes more
> > expensive than bare metal. Add a generic idle poll before enter
> > real idle path. When a reschedule event is pending, we can bypass
> > the real idle path.
> 
> Why not do a HV specific idle driver?

If I understand the problem correctly then he wants to avoid the heavy
lifting in tick_nohz_idle_enter() in the first place, but there is already
an interesting quirk there which makes it exit early.  See commit
3c5d92a0cfb5 ("nohz: Introduce arch_needs_cpu"). The reason for this commit
looks similar. But lets not proliferate that. I'd rather see that go away.

But the irq_timings stuff is heading into the same direction, with a more
complex prediction logic which should tell you pretty good how long that
idle period is going to be and in case of an interrupt heavy workload this
would skip the extra work of stopping and restarting the tick and provide a
very good input into a polling decision.

This can be handled either in a HV specific idle driver or even in the
generic core code. If the interrupt does not arrive then you can assume
within the predicted time then you can assume that the flood stopped and
invoke halt or whatever.

That avoids all of that 'tunable and tweakable' x86 specific hackery and
utilizes common functionality which is mostly there already.

Thanks,

	tglx
