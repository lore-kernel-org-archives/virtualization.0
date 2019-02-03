From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.16 139/305] clockevents/drivers/i8253: Add support for
	PIT shutdown quirk
Date: Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.388753594__7574.22094918496$1549341472$gmane$org@decadent.org.uk>
References: <lsq.1549201507.384106140@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "jgross@suse.com" <jgross@suse.com>, "olaf@aepfle.de" <olaf@aepfle.de>, Michael Kelley <mikelley@microsoft.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Denis Kirjanov <kda@linux-powerpc.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "apw@canonical.com" <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, akpm@linux-foundation.org, "akataria@vmware.com" <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
Link: https://lkml.kernel.org/r/1541303219-11142-2-git-send-email-mikelley@microsoft.com
[bwh: Backported to 3.16:
 - Don't use __ro_after_init
 - Adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/clocksource/i8253.c | 14 ++++++++++++--
 include/linux/i8253.h       |  1 +
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
+bool i8253_clear_counter_on_shutdown = true;
+
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -123,8 +130,11 @@ static void init_pit_timer(enum clock_ev
 		if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
 		    evt->mode == CLOCK_EVT_MODE_ONESHOT) {
 			outb_p(0x30, PIT_MODE);
-			outb_p(0, PIT_CH0);
-			outb_p(0, PIT_CH0);
+
+			if (i8253_clear_counter_on_shutdown) {
+				outb_p(0, PIT_CH0);
+				outb_p(0, PIT_CH0);
+			}
 		}
 		break;
 
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,6 +21,7 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
+extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
