From: Joe Perches <joe@perches.com>
Subject: [PATCH 1/2] xen: Add __attribute__((format(printf... where appropriate
Date: Sun, 12 Jun 2011 09:21:13 -0700
Message-ID: <17ffbd77627a21c05ab9e1a07b5207334291cf01.1307895293.git.joe__30676.2345172048$1307895740$gmane$org@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Use the compiler to verify printf formats and arguments.

Fix fallout.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/block/xen-blkback/xenbus.c |    2 +-
 include/xen/hvc-console.h          |    4 +++-
 include/xen/xenbus.h               |    2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 6cc0db1..3f129b4 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -684,7 +684,7 @@ again:
 
 	err = xenbus_switch_state(dev, XenbusStateConnected);
 	if (err)
-		xenbus_dev_fatal(dev, err, "switching to Connected state",
+		xenbus_dev_fatal(dev, err, "%s: switching to Connected state",
 				 dev->nodename);
 
 	return;
diff --git a/include/xen/hvc-console.h b/include/xen/hvc-console.h
index c3adde3..901724d 100644
--- a/include/xen/hvc-console.h
+++ b/include/xen/hvc-console.h
@@ -6,11 +6,13 @@ extern struct console xenboot_console;
 #ifdef CONFIG_HVC_XEN
 void xen_console_resume(void);
 void xen_raw_console_write(const char *str);
+__attribute__((format(printf, 1, 2)))
 void xen_raw_printk(const char *fmt, ...);
 #else
 static inline void xen_console_resume(void) { }
 static inline void xen_raw_console_write(const char *str) { }
-static inline void xen_raw_printk(const char *fmt, ...) { }
+static inline __attribute__((format(printf, 1, 2)))
+void xen_raw_printk(const char *fmt, ...) { }
 #endif
 
 #endif	/* XEN_HVC_CONSOLE_H */
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 5467369..aceeca7 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -223,7 +223,9 @@ int xenbus_free_evtchn(struct xenbus_device *dev, int port);
 
 enum xenbus_state xenbus_read_driver_state(const char *path);
 
+__attribute__((format(printf, 3, 4)))
 void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt, ...);
+__attribute__((format(printf, 3, 4)))
 void xenbus_dev_fatal(struct xenbus_device *dev, int err, const char *fmt, ...);
 
 const char *xenbus_strstate(enum xenbus_state state);
-- 
1.7.6.rc1
