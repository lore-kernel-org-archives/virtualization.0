From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 25/32] xen: rename dev_changed to xenbus_dev_changed
Date: Sun, 29 Apr 2007 10:29:00 -0700
Message-ID: <20070429172915.601786000@goop.org>
References: <20070429172835.284784000@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030882AbXD2RhO@vger.kernel.org>
Content-Disposition: inline; filename=xenbus-fix-dev_changed.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

"dev_changed" is too generic to be global.  Put "xenbus_" on the
front.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 drivers/xen/xenbus/xenbus_probe.c         |    4 ++--
 drivers/xen/xenbus/xenbus_probe.h         |    2 +-
 drivers/xen/xenbus/xenbus_probe_backend.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

===================================================================
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -567,7 +567,7 @@ static int strsep_len(const char *str, c
 	return (len == 0) ? i : -ERANGE;
 }
 
-void dev_changed(const char *node, struct xen_bus_type *bus)
+void xenbus_dev_changed(const char *node, struct xen_bus_type *bus)
 {
 	int exists, rootlen;
 	struct xenbus_device *dev;
@@ -609,7 +609,7 @@ static void frontend_changed(struct xenb
 {
 	DPRINTK(NULL, "");
 
-	dev_changed(vec[XS_WATCH_PATH], &xenbus_frontend);
+	xenbus_dev_changed(vec[XS_WATCH_PATH], &xenbus_frontend);
 }
 
 /* We watch for devices appearing and vanishing. */
===================================================================
--- a/drivers/xen/xenbus/xenbus_probe.h
+++ b/drivers/xen/xenbus/xenbus_probe.h
@@ -67,6 +67,6 @@ extern int xenbus_probe_node(struct xen_
 			     const char *nodename);
 extern int xenbus_probe_devices(struct xen_bus_type *bus);
 
-extern void dev_changed(const char *node, struct xen_bus_type *bus);
+extern void xenbus_dev_changed(const char *node, struct xen_bus_type *bus);
 
 #endif
===================================================================
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -228,7 +228,7 @@ static void backend_changed(struct xenbu
 {
 	DPRINTK("");
 
-	dev_changed(vec[XS_WATCH_PATH], &xenbus_backend);
+	xenbus_dev_changed(vec[XS_WATCH_PATH], &xenbus_backend);
 }
 
 static struct xenbus_watch be_watch = {

-- 
