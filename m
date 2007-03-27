From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 3/4] Locally disable the softlockup watchdog rather than
	touching it
Date: Tue, 27 Mar 2007 14:49:22 -0700
Message-ID: <20070327215828.085422178@goop.org>
References: <20070327214919.800272641@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=softlockup-disable-rather-than-touch.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Prarit Bhargava <prarit@redhat.com>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, John Hawkes <hawkes@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>
List-Id: virtualization@lists.linuxfoundation.org

If we're about to enter a prolonged period in which we know we're
going to hold off scheduler ticks, then disable the CPU's softlockup
watchdog for the duration.  This avoids having to repeatedly touch the
timestamp, or conversely, risk having the watchdog timeout in the
middle of your long operation.

A question about each of these changes is whether they expect just the
current CPU to be locked up, or the whole machine.
touch_softlockup_watchdog updates the per-cpu timestamp, so I assumed
that its per-cpu for all these cases.

One semantic change this makes is that softlockup_disable/enable does
a preempt_disable/enable.  I don't think this is a problem, since if
you're worried about triggering the softlockup watchdog, you're not
scheduling.

I haven't really worked out how this should interact with the nmi
watchdog; touch_nmi_watchdog() still ends up calling
touch_softlockup_watchdog(), so there's still some redundancy here.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Chris Lalancette <clalance@redhat.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>
Cc: John Hawkes <hawkes@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

---
 arch/ia64/kernel/uncached.c  |    8 ++++++--
 drivers/ide/ide-iops.c       |   25 +++++++++++++++++++------
 drivers/ide/ide-taskfile.c   |    8 +++++++-
 drivers/mtd/nand/nand_base.c |    8 +++++++-
 4 files changed, 39 insertions(+), 10 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -253,13 +253,17 @@ static int __init uncached_build_memmap(
 	int nid =3D paddr_to_nid(uc_start - __IA64_UNCACHED_OFFSET);
 	struct gen_pool *pool =3D uncached_pools[nid].pool;
 	size_t size =3D uc_end - uc_start;
-
-	touch_softlockup_watchdog();
+	int sl_state;
+
+	sl_state =3D softlockup_disable();
 =

 	if (pool !=3D NULL) {
 		memset((char *)uc_start, 0, size);
 		(void) gen_pool_add(pool, uc_start, size, nid);
 	}
+
+	softlockup_enable(sl_state);
+
 	return 0;
 }
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -1215,6 +1215,12 @@ int ide_wait_not_busy(ide_hwif_t *hwif, =

 int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
 {
 	u8 stat =3D 0;
+	int ret =3D -EBUSY;
+	int sl_state;
+
+	/* Tell softlockup this might take a while.
+	   XXX should this be global or per-cpu? */
+	sl_state =3D softlockup_disable();
 =

 	while(timeout--) {
 		/*
@@ -1223,19 +1229,26 @@ int ide_wait_not_busy(ide_hwif_t *hwif, =

 		 */
 		mdelay(1);
 		stat =3D hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
-		if ((stat & BUSY_STAT) =3D=3D 0)
-			return 0;
+		if ((stat & BUSY_STAT) =3D=3D 0) {
+			ret =3D 0;
+			break;
+		}
+
 		/*
 		 * Assume a value of 0xff means nothing is connected to
 		 * the interface and it doesn't implement the pull-down
 		 * resistor on D7.
 		 */
-		if (stat =3D=3D 0xff)
-			return -ENODEV;
-		touch_softlockup_watchdog();
+		if (stat =3D=3D 0xff) {
+			ret =3D -ENODEV;
+			break;
+		}
 		touch_nmi_watchdog();
 	}
-	return -EBUSY;
+
+	softlockup_enable(sl_state);
+
+	return ret;
 }
 =

 EXPORT_SYMBOL_GPL(ide_wait_not_busy);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -310,10 +310,14 @@ static void ide_pio_datablock(ide_drive_
 static void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
 				     unsigned int write)
 {
+	int sl_state;
+
 	if (rq->bio)	/* fs request */
 		rq->errors =3D 0;
 =

-	touch_softlockup_watchdog();
+	/* Tell softlockup this might take a while.
+	   XXX should this be global or per-cpu? */
+	sl_state =3D softlockup_disable();
 =

 	switch (drive->hwif->data_phase) {
 	case TASKFILE_MULTI_IN:
@@ -324,6 +328,8 @@ static void ide_pio_datablock(ide_drive_
 		ide_pio_sector(drive, write);
 		break;
 	}
+
+	softlockup_enable(sl_state);
 }
 =

 static ide_startstop_t task_error(ide_drive_t *drive, struct request *rq,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -419,15 +419,21 @@ void nand_wait_ready(struct mtd_info *mt
 {
 	struct nand_chip *chip =3D mtd->priv;
 	unsigned long timeo =3D jiffies + 2;
+	int sl_state;
+
+	/* Tell softlockup this might take a while.
+	   XXX should this be global or per-cpu? */
+	sl_state =3D softlockup_disable();
 =

 	led_trigger_event(nand_led_trigger, LED_FULL);
 	/* wait until command is processed or timeout occures */
 	do {
 		if (chip->dev_ready(mtd))
 			break;
-		touch_softlockup_watchdog();
 	} while (time_before(jiffies, timeo));
 	led_trigger_event(nand_led_trigger, LED_OFF);
+
+	softlockup_enable(sl_state);
 }
 EXPORT_SYMBOL_GPL(nand_wait_ready);
 =


-- =
