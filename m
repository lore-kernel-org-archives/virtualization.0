From: Miche Baker-Harvey <miche@google.com>
Subject: [PATCH v2 2/3] hvc_init():  Enforce one-time initialization.
Date: Tue, 08 Nov 2011 11:29:59 -0800
Message-ID: <20111108192959.30618.93231.stgit@miche.sea.corp.google.com>
References: <20111108192949.30618.3953.stgit@miche.sea.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111108192949.30618.3953.stgit@miche.sea.corp.google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

hvc_init() must only be called once, and no thread should continue with hvc_alloc()
until after initialization is complete.  The original code does not enforce either
of these requirements.  A new mutex limits entry to hvc_init() to a single thread,
and blocks all later comers until it has completed.

This patch fixes multiple crash symptoms.

Signed-off-by: Miche Baker-Harvey <miche@google.com>
---
 drivers/tty/hvc/hvc_console.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index b6b2d18..09a6159 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -29,8 +29,9 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
-#include <linux/module.h>
 #include <linux/major.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -84,6 +85,10 @@ static LIST_HEAD(hvc_structs);
  * list traversal.
  */
 static DEFINE_SPINLOCK(hvc_structs_lock);
+/*
+ * only one task does allocation at a time.
+ */
+static DEFINE_MUTEX(hvc_ports_mutex);
 
 /*
  * This value is used to assign a tty->index value to a hvc_struct based
@@ -825,11 +830,15 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	int i;
 
 	/* We wait until a driver actually comes along */
+	mutex_lock(&hvc_ports_mutex);
 	if (!hvc_driver) {
 		int err = hvc_init();
-		if (err)
+		if (err) {
+			mutex_unlock(&hvc_ports_mutex);
 			return ERR_PTR(err);
+		}
 	}
+	mutex_unlock(&hvc_ports_mutex);
 
 	hp = kzalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
 			GFP_KERNEL);
