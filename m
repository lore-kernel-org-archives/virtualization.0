From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 18/20] clean up tsc-based sched_clock
Date: Wed, 04 Apr 2007 12:12:09 -0700
Message-ID: <20070404191206.476822257@goop.org>
References: <20070404191151.009821039@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=cleanup-tsc-sched-clock.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Three cleanups:
 - change "instable" -> "unstable"
 - its better to use get_cpu_var for getting this cpu's variables
 - change cycles_2_ns to do the full computation rather than just the
   tsc->ns scaling.  Its a simpler interface, and it makes the function
   more generally useful.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/sched-clock.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/sched-clock.c
+++ b/arch/i386/kernel/sched-clock.c
@@ -39,17 +39,23 @@
 =

 struct sc_data {
 	unsigned int cyc2ns_scale;
-	unsigned char instable;
+	unsigned char unstable;
 	unsigned long long last_tsc;
 	unsigned long long ns_base;
 };
 =

 static DEFINE_PER_CPU(struct sc_data, sc_data);
 =

-static inline unsigned long long cycles_2_ns(int cpu, unsigned long long c=
yc)
+static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 {
-	struct sc_data *sc =3D &per_cpu(sc_data, cpu);
-	return (cyc * sc->cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+	const struct sc_data *sc =3D &__get_cpu_var(sc_data);
+	unsigned long long ns;
+
+	cyc -=3D sc->last_tsc;
+	ns =3D (cyc * sc->cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+	ns +=3D sc->ns_base;
+
+	return ns;
 }
 =

 /*
@@ -62,18 +68,19 @@ static inline unsigned long long cycles_
  */
 unsigned long long sched_clock(void)
 {
-	int cpu =3D get_cpu();
-	struct sc_data *sc =3D &per_cpu(sc_data, cpu);
 	unsigned long long r;
+	const struct sc_data *sc =3D &get_cpu_var(sc_data);
 =

-	if (sc->instable) {
+	if (sc->unstable) {
 		/* TBD find a cheaper fallback timer than this */
 		r =3D ktime_to_ns(ktime_get());
 	} else {
 		get_scheduled_cycles(r);
-		r =3D ((u64)sc->ns_base) + cycles_2_ns(cpu, r - sc->last_tsc);
+		r =3D cycles_2_ns(r);
 	}
-	put_cpu();
+
+	put_cpu_var(sc_data);
+
 	return r;
 }
 =

@@ -81,7 +88,7 @@ static void resync_sc_freq(struct sc_dat
 static void resync_sc_freq(struct sc_data *sc, unsigned int newfreq)
 {
 	if (!cpu_has_tsc) {
-		sc->instable =3D 1;
+		sc->unstable =3D 1;
 		return;
 	}
 	/* RED-PEN protect with seqlock? I hope that's not needed
@@ -90,7 +97,7 @@ static void resync_sc_freq(struct sc_dat
 	sc->ns_base =3D ktime_to_ns(ktime_get());
 	get_scheduled_cycles(sc->last_tsc);
 	sc->cyc2ns_scale =3D (1000000 << CYC2NS_SCALE_FACTOR) / newfreq;
-	sc->instable =3D 0;
+	sc->unstable =3D 0;
 }
 =

 static void call_r_s_f(void *arg)
@@ -119,9 +126,9 @@ static int sc_freq_event(struct notifier
 	switch (event) {
 	case CPUFREQ_RESUMECHANGE:  /* needed? */
 	case CPUFREQ_PRECHANGE:
-		/* Mark TSC as instable until cpu frequency change is done
+		/* Mark TSC as unstable until cpu frequency change is done
 		   because we don't know when exactly it will change */
-		sc->instable =3D 1;
+		sc->unstable =3D 1;
 		break;
 	case CPUFREQ_SUSPENDCHANGE:
 	case CPUFREQ_POSTCHANGE:
@@ -163,7 +170,7 @@ static __init int init_sched_clock(void)
 	int i;
 	struct cpufreq_freqs f =3D { .cpu =3D get_cpu(), .new =3D 0 };
 	for_each_possible_cpu (i)
-		per_cpu(sc_data, i).instable =3D 1;
+		per_cpu(sc_data, i).unstable =3D 1;
 	WARN_ON(num_online_cpus() > 1);
 	call_r_s_f(&f);
 	put_cpu();

-- =
