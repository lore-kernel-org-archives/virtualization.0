From: rusty@rustcorp.com.au
Subject: [patch 11/43] lguest: lguest_devices belongs in lguest_bus.c: its
	not i386-specific.
Date: Wed, 26 Sep 2007 16:36:29 +1000
Message-ID: <20070926063646.881605533@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=move-lguest-devices.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest.c     |    1 -
 drivers/lguest/lguest_bus.c |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

===================================================================
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -87,7 +87,6 @@ struct lguest_data lguest_data = {
 	.noirq_end = (u32)lguest_noirq_end,
 	.blocked_interrupts = { 1 }, /* Block timer interrupts */
 };
-struct lguest_device_desc *lguest_devices;
 static cycle_t clock_base;
 
 /*G:035 Notice the lazy_hcall() above, rather than hcall().  This is our first
===================================================================
--- a/drivers/lguest/lguest_bus.c
+++ b/drivers/lguest/lguest_bus.c
@@ -6,6 +6,8 @@
 #include <linux/lguest_bus.h>
 #include <asm/io.h>
 #include <asm/paravirt.h>
+
+struct lguest_device_desc *lguest_devices;
 
 static ssize_t type_show(struct device *_dev,
                          struct device_attribute *attr, char *buf)

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
