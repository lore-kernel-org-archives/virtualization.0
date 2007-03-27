From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 1/2] Ignore stolen time in the softlockup watchdog
Date: Tue, 27 Mar 2007 09:50:57 +0200
Message-ID: <20070327095057.f4df0abc.dada1@cosmosbay.com>
References: <20070327053816.881735237@goop.org>
	<20070327054106.664262413@goop.org>
	<4608C121.4050309@cosmosbay.com> <4608C3F5.1030106@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4608C3F5.1030106@goop.org>
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
Cc: Prarit Bhargava <prarit@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 27 Mar 2007 00:12:53 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Eric Dumazet wrote:
> > Jeremy Fitzhardinge a =E9crit :
> >
> >> +static DEFINE_PER_CPU(unsigned long long, touch_timestamp);
> >
> > ...
> >
> >>  void touch_softlockup_watchdog(void)
> >>  {
> >> -    __raw_get_cpu_var(touch_timestamp) =3D jiffies;
> >> +    __raw_get_cpu_var(touch_timestamp) =3D sched_clock();
> >>  }
> >
> > Not very clear if this is safe on 32bit, since this is not anymore
> > atomic.
> =

> Hm, good point.  Don't think it matters very much.  These values are
> per-cpu, and if an interrupt happens between the word updates and the
> intermediate values causes a timeout, then it was pretty marginal
> anyway.  I guess the worst case is if the low-word gets written first,
> and it goes from a high value to low, then it could be sampled as if
> time had gone back by up to ~4 seconds.
> =

> I'll give it another look.

OK thanks. I noticed another 'not clear' bit in your second patch :

void softlockup_enable(void)
{
	touch_softlockup_watchdog();
	wmb();			/* update timestamp before enable */
	__get_cpu_var(enabled) =3D 1;
}


Are you sure wmb() is needed here ?

I think a barrier() (compiler barrier) should be enough. If not, a nice com=
ment would help too :)
