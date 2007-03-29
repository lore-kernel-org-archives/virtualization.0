From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [LGUEST] updated nohz/hrtimer WIP patches (v04)
Date: Thu, 29 Mar 2007 09:45:09 -0700
Message-ID: <460BED15.9040301@goop.org>
References: <Line.LNX.4.64.0703261148040.13138@d.namei>
	<Line.LNX.4.64.0703291151270.12641@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Line.LNX.4.64.0703291151270.12641@d.namei>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Morris <jmorris@namei.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

James Morris wrote:
> At http://namei.org/misc/lguest/patches/time/v04/
>
> Just a resync to the latest upstream lguest patch queue, after some fun =

> with bare metal bugs and assorted churn.
>
>
>
> - James
>   =


+void guest_clockevent(struct lguest *lg, const ktime_t __user *u)
+{
+	ktime_t kdelta;
+
+	lgread(lg, &kdelta, (u32)u, sizeof(kdelta));
+
+	if (ktime_to_ns(kdelta) < LG_CLOCK_MIN_DELTA) {
+		if (printk_ratelimit())
+			printk(KERN_DEBUG "%s: guest %u small delta %Ld ns\n",
+			       __FUNCTION__, lg->guestid, ktime_to_ns(kdelta));
+
+		/* kick guest timer immediately */
+		set_bit(0, lg->irqs_pending);
+	} else
+		hrtimer_start(&lg->hrt, kdelta, HRTIMER_MODE_REL);
+}


Two things:

   1. It's probably better to make this interface specified in absolute
      rather than relative time.  Asking for a timeout "X ns from _now_"
      is a bit vague if the guest can be preempted and _now_ can be
      arbitrarily deferred.  The tricky part about using an absolute
      time is that the guest needs to work out how to convert from a
      guest time into hypervisor time...
   2. Rather than kicking the timer immediately for too-short (or
      negative) timeouts, it should have the option to return -ETIME, to
      match the clockevents set_next_event API.


+static int lguest_clockevent_set_next_event(unsigned long delta,
+					    struct clock_event_device *evt)
+{
+	ktime_t kdelta =3D ktime_sub(evt->next_event, ktime_get());
+	hcall(LHCALL_CLOCKEVENT, __pa(&kdelta), 0, 0);
+	return 0;
+}


Why compute kdelta?  Why not just use "delta"?

    J
