From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [patch 1/2] Ignore stolen time in the softlockup watchdog
Date: Tue, 27 Mar 2007 12:53:22 -0400
Message-ID: <46094C02.9050702@redhat.com>
References: <20070327053816.881735237@goop.org>
	<20070327054106.664262413@goop.org>
	<46092C9B.4030700@redhat.com> <46094861.7080400@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46094861.7080400@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Rick Lindsley <ricklind@us.ibm.com>, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



Jeremy Fitzhardinge wrote:
> Prarit Bhargava wrote:
>   =

>> I'd like to see this patch implement/fix touch_cpu_softlockup_watchdog
>> and touch_softlockup_watchdog to mimic touch_nmi_watchdog's behaviour.
>>     =

>
> Why?  Is that more correct?  It seems to me that you're interested in
> whether a specific CPU has gone and locked up.  If touching the watchdog
>   =

> makes it update all CPU timestamps, then you'll hide the fact that other
> CPUs have locked up, won't it?
>
>   =

In case of misuse, yes.  But there are cases where we know that all CPUs =

will have softlockup issues, such as when doing a "big" sysrq-t dump.  =

When doing the sysrq-t we take the tasklist_lock which prevents all =

other CPUs from scheduling -- this leads to bogus softlockup messages, =

so we need to reset everyone's watchdog just before releasing the =

tasklist_lock.

Another question -- are you going to expose disable/enable_watchdog to =

other subsystems?  Or are you going to expose touch_softlockup_watchdog?

>     J
>   =
