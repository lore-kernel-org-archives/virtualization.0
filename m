From: <gregkh@linuxfoundation.org>
Subject: Patch "clockevents/drivers/i8253: Add support for PIT shutdown quirk"
	has been added to the 4.4-stable tree
Date: Mon, 19 Nov 2018 14:00:22 +0100
Message-ID: <1542632422120180__23114.6419108429$1542632647$gmane$org@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 1541303219-11142-2-git-send-email-mikelley@microsoft.com, akataria@vmware.com, apw@canonical.com, daniel.lezcano@linaro.org, devel@linuxdriverproject.org, gregkh@linuxfoundation.org, jasowang@redhat.com, jgross@suse.com, kys@microsoft.com, marcelo.cerri@canonical.commikelley@microsoft.com, olaf@aepfle.de, tglx@linutronix.de, virtualization@lists.linux-foundation.org, vkuznets@redhat.com
Cc: stable-commits@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


This is a note to let you know that I've just added the patch titled

    clockevents/drivers/i8253: Add support for PIT shutdown quirk

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     clockevents-drivers-i8253-add-support-for-pit-shutdown-quirk.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 35b69a420bfb56b7b74cb635ea903db05e357bec Mon Sep 17 00:00:00 2001
From: Michael Kelley <mikelley@microsoft.com>
Date: Sun, 4 Nov 2018 03:48:54 +0000
Subject: clockevents/drivers/i8253: Add support for PIT shutdown quirk

From: Michael Kelley <mikelley@microsoft.com>

commit 35b69a420bfb56b7b74cb635ea903db05e357bec upstream.

Add support for platforms where pit_shutdown() doesn't work because of a
quirk in the PIT emulation. On these platforms setting the counter register
to zero causes the PIT to start running again, negating the shutdown.

Provide a global variable that controls whether the counter register is
zero'ed, which platform specific code can override.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "jgross@suse.com" <jgross@suse.com>
Cc: "akataria@vmware.com" <akataria@vmware.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>
Cc: "apw@canonical.com" <apw@canonical.com>
Cc: vkuznets <vkuznets@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Cc: KY Srinivasan <kys@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1541303219-11142-2-git-send-email-mikelley@microsoft.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/i8253.c |   14 ++++++++++++--
 include/linux/i8253.h       |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -19,6 +19,13 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
+/*
+ * Handle PIT quirk in pit_shutdown() where zeroing the counter register
+ * restarts the PIT, negating the shutdown. On platforms with the quirk,
+ * platform specific code can set this to false.
+ */
+bool i8253_clear_counter_on_shutdown __ro_after_init = true;
+
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -108,8 +115,11 @@ static int pit_shutdown(struct clock_eve
 	raw_spin_lock(&i8253_lock);
 
 	outb_p(0x30, PIT_MODE);
-	outb_p(0, PIT_CH0);
-	outb_p(0, PIT_CH0);
+
+	if (i8253_clear_counter_on_shutdown) {
+		outb_p(0, PIT_CH0);
+		outb_p(0, PIT_CH0);
+	}
 
 	raw_spin_unlock(&i8253_lock);
 	return 0;
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,6 +21,7 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
+extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 


Patches currently in stable-queue which might be from mikelley@microsoft.com are

queue-4.4/clockevents-drivers-i8253-add-support-for-pit-shutdown-quirk.patch
