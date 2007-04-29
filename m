From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 24/32] xen: use xenbus_watch_pathfmt rather than watch_path2
Date: Sun, 29 Apr 2007 10:28:59 -0700
Message-ID: <20070429172915.388957000@goop.org>
References: <20070429172835.284784000@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030241AbXD2Rcd@vger.kernel.org>
Content-Disposition: inline; filename=xenbus-watch_pathfmt.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Keir Fraser <keir@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

xenbus_watch_path2 is not very general.  Passing a printf-style format
string is no more complex and more general.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Keir Fraser <keir@xensource.com>

---
 drivers/xen/xenbus/xenbus_client.c |   44 ++++++++++++++++++++----------------
 drivers/xen/xenbus/xenbus_probe.c  |    4 +--
 include/xen/xenbus.h               |   10 ++++----
 3 files changed, 33 insertions(+), 25 deletions(-)

===================================================================
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -92,14 +92,13 @@ EXPORT_SYMBOL_GPL(xenbus_watch_path);
 
 
 /**
- * xenbus_watch_path2 - register a watch on path/path2
- * @dev: xenbus device
- * @path: first half of path to watch
- * @path2: second half of path to watch
+ * xenbus_watch_pathfmt - register a watch on a sprintf-formatted path
+ * @dev: xenbus device
  * @watch: watch to register
  * @callback: callback to register
- *
- * Register a watch on the given @path/@path2, using the given xenbus_watch
+ * @pathfmt: format of path to watch
+ *
+ * Register a watch on the given @path, using the given xenbus_watch
  * structure for storage, and the given @callback function as the callback.
  * Return 0 on success, or -errno on error.  On success, the watched path
  * (@path/@path2) will be saved as @watch->node, and becomes the caller's to
@@ -107,24 +106,31 @@ EXPORT_SYMBOL_GPL(xenbus_watch_path);
  * free, the device will switch to %XenbusStateClosing, and the error will be
  * saved in the store.
  */
-int xenbus_watch_path2(struct xenbus_device *dev, const char *path,
-		       const char *path2, struct xenbus_watch *watch,
-		       void (*callback)(struct xenbus_watch *,
-					const char **, unsigned int))
-{
-	int err;
-	char *state = kasprintf(GFP_KERNEL, "%s/%s", path, path2);
-	if (!state) {
+int xenbus_watch_pathfmt(struct xenbus_device *dev,
+			 struct xenbus_watch *watch,
+			 void (*callback)(struct xenbus_watch *,
+					const char **, unsigned int),
+			 const char *pathfmt, ...)
+{
+	int err;
+	va_list ap;
+	char *path;
+
+	va_start(ap, pathfmt);
+	path = kvasprintf(GFP_KERNEL, pathfmt, ap);
+	va_end(ap);
+
+	if (!path) {
 		xenbus_dev_fatal(dev, -ENOMEM, "allocating path for watch");
 		return -ENOMEM;
 	}
-	err = xenbus_watch_path(dev, state, watch, callback);
+	err = xenbus_watch_path(dev, path, watch, callback);
 
 	if (err)
-		kfree(state);
-	return err;
-}
-EXPORT_SYMBOL_GPL(xenbus_watch_path2);
+		kfree(path);
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_watch_pathfmt);
 
 
 /**
===================================================================
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -227,8 +227,8 @@ static int talk_to_otherend(struct xenbu
 
 static int watch_otherend(struct xenbus_device *dev)
 {
-	return xenbus_watch_path2(dev, dev->otherend, "state",
-				  &dev->otherend_watch, otherend_changed);
+	return xenbus_watch_pathfmt(dev, &dev->otherend_watch, otherend_changed,
+				    "%s/%s", dev->otherend, "state");
 }
 
 
===================================================================
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -180,10 +180,12 @@ int xenbus_watch_path(struct xenbus_devi
 		      struct xenbus_watch *watch,
 		      void (*callback)(struct xenbus_watch *,
 				       const char **, unsigned int));
-int xenbus_watch_path2(struct xenbus_device *dev, const char *path,
-		       const char *path2, struct xenbus_watch *watch,
-		       void (*callback)(struct xenbus_watch *,
-					const char **, unsigned int));
+int xenbus_watch_pathfmt(struct xenbus_device *dev, struct xenbus_watch *watch,
+			 void (*callback)(struct xenbus_watch *,
+					  const char **, unsigned int),
+			 const char *pathfmt, ...)
+	__attribute__ ((format (printf, 4, 5)));
+
 int xenbus_switch_state(struct xenbus_device *dev, enum xenbus_state new_state);
 int xenbus_grant_ring(struct xenbus_device *dev, unsigned long ring_mfn);
 int xenbus_map_ring_valloc(struct xenbus_device *dev,

-- 
