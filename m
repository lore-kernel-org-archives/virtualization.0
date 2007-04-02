From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 17/17] Add a sched_clock paravirt_op
Date: Mon, 2 Apr 2007 08:09:42 +0200
Message-ID: <200704020809.42373.ak@suse.de>
References: <20070402055652.610711908@goop.org>
	<20070402055705.606126251@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070402055705.606126251@goop.org>
Content-Disposition: inline
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
Cc: virtualization@lists.osdl.org, john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 02 April 2007 07:57, Jeremy Fitzhardinge wrote:
> The tsc-based get_scheduled_cycles interface is not a good match for
> Xen's runstate accounting, which reports everything in nanoseconds.
> =

> This patch replaces this interface with a sched_clock interface, which
> matches both Xen and VMI's requirements.
> =

> In order to do this, we:
>    1. replace get_scheduled_cycles with sched_clock
>    2. hoist cycles_2_ns into a common header
>    3. update vmi accordingly
> =

> One thing to note: because sched_clock is implemented as a weak
> function in kernel/sched.c, we must define a real function in order to
> override this weak binding.  This means the usual paravirt_ops
> technique of using an inline function won't work in this case.

I think it would be much cleaner if you didn't implement your own sched_clo=
ck,
but you adjust ns_base/last_tsc to account for your lost cycles.
This could be done cleanly by adding a new function to sched-clock.c
Possibly such a function could be used by other parts of the kernel
in the future too.

-Andi
