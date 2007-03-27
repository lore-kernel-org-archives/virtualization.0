From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [patch 1/2] Ignore stolen time in the softlockup watchdog
Date: Tue, 27 Mar 2007 10:39:23 -0400
Message-ID: <46092C9B.4030700@redhat.com>
References: <20070327053816.881735237@goop.org>
	<20070327054106.664262413@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070327054106.664262413@goop.org>
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
>
> ---
>  kernel/softlockup.c |   28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/kernel/softlockup.c
> +++ b/kernel/softlockup.c
> @@ -17,8 +17,8 @@
>  =

>  static DEFINE_SPINLOCK(print_lock);
>  =

> -static DEFINE_PER_CPU(unsigned long, touch_timestamp);
> -static DEFINE_PER_CPU(unsigned long, print_timestamp);
> +static DEFINE_PER_CPU(unsigned long long, touch_timestamp);
> +static DEFINE_PER_CPU(unsigned long long, print_timestamp);
>  static DEFINE_PER_CPU(struct task_struct *, watchdog_task);
>  =

>  static int did_panic =3D 0;
> @@ -37,7 +37,7 @@ static struct notifier_block panic_block
>  =

>  void touch_softlockup_watchdog(void)
>  {
> -	__raw_get_cpu_var(touch_timestamp) =3D jiffies;
> +	__raw_get_cpu_var(touch_timestamp) =3D sched_clock();
>  }
>   =


I'd like to see this patch implement/fix touch_cpu_softlockup_watchdog =

and touch_softlockup_watchdog to mimic touch_nmi_watchdog's behaviour.

See this now obsolete patch: http://lkml.org/lkml/2007/3/15/131

P.
