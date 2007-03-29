From: James Morris <jmorris@namei.org>
Subject: Re: [LGUEST] updated nohz/hrtimer WIP patches (v04)
Date: Thu, 29 Mar 2007 15:15:27 -0400 (EDT)
Message-ID: <Line.LNX.4.64.0703291509470.14851@d.namei>
References: <Line.LNX.4.64.0703261148040.13138@d.namei>
	<Line.LNX.4.64.0703291151270.12641@d.namei> <460BED15.9040301@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <460BED15.9040301@goop.org>
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
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 29 Mar 2007, Jeremy Fitzhardinge wrote:

> Two things:
> =

>    1. It's probably better to make this interface specified in absolute
>       rather than relative time.  Asking for a timeout "X ns from _now_"
>       is a bit vague if the guest can be preempted and _now_ can be
>       arbitrarily deferred.  The tricky part about using an absolute
>       time is that the guest needs to work out how to convert from a
>       guest time into hypervisor time...

Thanks for the review!

Yep, it's as simple as possible now, and absolute time something to =

investigate along with time synchronization between the host and the =

guest (which we effectively avoid at this point).

>    2. Rather than kicking the timer immediately for too-short (or
>       negative) timeouts, it should have the option to return -ETIME, to
>       match the clockevents set_next_event API.

Ok.

> +static int lguest_clockevent_set_next_event(unsigned long delta,
> +					    struct clock_event_device *evt)
> +{
> +	ktime_t kdelta =3D ktime_sub(evt->next_event, ktime_get());
> +	hcall(LHCALL_CLOCKEVENT, __pa(&kdelta), 0, 0);
> +	return 0;
> +}
> =

> =

> Why compute kdelta?  Why not just use "delta"?

'delta' is limited to 2^32 nanoseconds on 32-bit, which is not enough to =

be useful (I really don't understand why the API is like this).  So, =

instead, the 64-bit ktime_t delta is derived.



- James
-- =

James Morris
<jmorris@namei.org>
