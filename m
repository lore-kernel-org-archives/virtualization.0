From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 32/46] Staging: hv: util: Adjust guest time in a process
	context
Date: Sat, 27 Aug 2011 11:31:31 -0700
Message-ID: <1314469905-7058-32-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314469905-7058-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The current code was adjusting guest time in interrupt context; do this
in process context since we may have to initiate cross-processor
interrupts as part of setting time.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_util.c |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
index 876d44a..e29a2a2 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -107,6 +107,24 @@ static inline void do_adj_guesttime(u64 hosttime)
 }
 
 /*
+ * Set the host time in a process context.
+ */
+
+struct adj_time_work {
+	struct work_struct work;
+	u64	host_time;
+};
+
+static void hv_set_host_time(struct work_struct *work)
+{
+	struct adj_time_work	*wrk;
+
+	wrk = container_of(work, struct adj_time_work, work);
+	do_adj_guesttime(wrk->host_time);
+	kfree(wrk);
+}
+
+/*
  * Synchronize time with host after reboot, restore, etc.
  *
  * ICTIMESYNCFLAG_SYNC flag bit indicates reboot, restore events of the VM.
@@ -119,17 +137,26 @@ static inline void do_adj_guesttime(u64 hosttime)
  */
 static inline void adj_guesttime(u64 hosttime, u8 flags)
 {
+	struct adj_time_work    *wrk;
 	static s32 scnt = 50;
 
+	wrk = kmalloc(sizeof(struct adj_time_work), GFP_ATOMIC);
+	if (wrk == NULL)
+		return;
+
+	wrk->host_time = hosttime;
 	if ((flags & ICTIMESYNCFLAG_SYNC) != 0) {
-		do_adj_guesttime(hosttime);
+		INIT_WORK(&wrk->work, hv_set_host_time);
+		schedule_work(&wrk->work);
 		return;
 	}
 
 	if ((flags & ICTIMESYNCFLAG_SAMPLE) != 0 && scnt > 0) {
 		scnt--;
-		do_adj_guesttime(hosttime);
-	}
+		INIT_WORK(&wrk->work, hv_set_host_time);
+		schedule_work(&wrk->work);
+	} else
+		kfree(wrk);
 }
 
 /*
-- 
1.7.4.1
