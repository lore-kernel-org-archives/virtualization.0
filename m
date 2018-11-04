From: tip-bot for Michael Kelley <tipbot@zytor.com>
Subject: [tip:x86/urgent] clockevents/drivers/i8253: Add support for PIT
	shutdown quirk
Date: Sun, 4 Nov 2018 02:09:55 -0800
Message-ID: <tip-35b69a420bfb56b7b74cb635ea903db05e357bec__29456.5058699392$1541327777$gmane$org@git.kernel.org>
References: <1541303219-11142-2-git-send-email-mikelley@microsoft.com>
Reply-To: devel@linuxdriverproject.org, olaf@aepfle.de, jgross@suse.com,
	mikelley@microsoft.com, marcelo.cerri@canonical.com,
	vkuznets@redhat.com, akataria@vmware.com,
	gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, apw@canonical.com, mingo@kernel.org,
	jasowang@redhat.com, hpa@zytor.com,
	virtualization@lists.linux-foundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1541303219-11142-2-git-send-email-mikelley@microsoft.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-tip-commits@vger.kernel.org
Cc: jgross@suse.com, olaf@aepfle.de, gregkh@linuxfoundation.org, daniel.lezcano@linaro.org, akataria@vmware.com, linux-kernel@vger.kernel.org, mikelley@microsoft.com, apw@canonical.com, hpa@zytor.com, marcelo.cerri@canonical.com, devel@linuxdriverproject.org, tglx@linutronix.de, virtualization@lists.linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Commit-ID:  35b69a420bfb56b7b74cb635ea903db05e357bec
Gitweb:     https://git.kernel.org/tip/35b69a420bfb56b7b74cb635ea903db05e357bec
Author:     Michael Kelley <mikelley@microsoft.com>
AuthorDate: Sun, 4 Nov 2018 03:48:54 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 4 Nov 2018 11:04:46 +0100

clockevents/drivers/i8253: Add support for PIT shutdown quirk

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

---
 drivers/clocksource/i8253.c | 14 ++++++++++++--
 include/linux/i8253.h       |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 9c38895542f4..d4350bb10b83 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,6 +20,13 @@
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
@@ -109,8 +116,11 @@ static int pit_shutdown(struct clock_event_device *evt)
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
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index e6bb36a97519..8336b2f6f834 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,6 +21,7 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
+extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
