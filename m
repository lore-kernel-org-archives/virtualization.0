From: Bastian Blank <waldi@debian.org>
Subject: [PATCH 1/4] xen: Populate xenbus device attributes
Date: Wed, 29 Jun 2011 14:39:26 +0200
Message-ID: <20110629123926.GA31038__13169.9987724007$1309356345$gmane$org@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The xenbus bus type uses device_create_file to assign all used device
attributes. However it does not remove them when the device goes away.

This patch uses the dev_attrs field of the bus type to specify default
attributes for all devices.

Signed-off-by: Bastian Blank <waldi@debian.org>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/xen/xenbus/xenbus_probe.c          |   41 +++++++++------------------
 drivers/xen/xenbus/xenbus_probe.h          |    2 +
 drivers/xen/xenbus/xenbus_probe_backend.c  |    6 +---
 drivers/xen/xenbus/xenbus_probe_frontend.c |    6 +---
 4 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 7397695..2ed0b04 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -378,26 +378,31 @@ static void xenbus_dev_release(struct device *dev)
 		kfree(to_xenbus_device(dev));
 }
 
-static ssize_t xendev_show_nodename(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t nodename_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", to_xenbus_device(dev)->nodename);
 }
-static DEVICE_ATTR(nodename, S_IRUSR | S_IRGRP | S_IROTH, xendev_show_nodename, NULL);
 
-static ssize_t xendev_show_devtype(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t devtype_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", to_xenbus_device(dev)->devicetype);
 }
-static DEVICE_ATTR(devtype, S_IRUSR | S_IRGRP | S_IROTH, xendev_show_devtype, NULL);
 
-static ssize_t xendev_show_modalias(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t modalias_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "xen:%s\n", to_xenbus_device(dev)->devicetype);
 }
-static DEVICE_ATTR(modalias, S_IRUSR | S_IRGRP | S_IROTH, xendev_show_modalias, NULL);
+
+struct device_attribute xenbus_dev_attrs[] = {
+	__ATTR_RO(nodename),
+	__ATTR_RO(devtype),
+	__ATTR_RO(modalias),
+	__ATTR_NULL
+};
+EXPORT_SYMBOL_GPL(xenbus_dev_attrs);
 
 int xenbus_probe_node(struct xen_bus_type *bus,
 		      const char *type,
@@ -449,25 +454,7 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 	if (err)
 		goto fail;
 
-	err = device_create_file(&xendev->dev, &dev_attr_nodename);
-	if (err)
-		goto fail_unregister;
-
-	err = device_create_file(&xendev->dev, &dev_attr_devtype);
-	if (err)
-		goto fail_remove_nodename;
-
-	err = device_create_file(&xendev->dev, &dev_attr_modalias);
-	if (err)
-		goto fail_remove_devtype;
-
 	return 0;
-fail_remove_devtype:
-	device_remove_file(&xendev->dev, &dev_attr_devtype);
-fail_remove_nodename:
-	device_remove_file(&xendev->dev, &dev_attr_nodename);
-fail_unregister:
-	device_unregister(&xendev->dev);
 fail:
 	kfree(xendev);
 	return err;
diff --git a/drivers/xen/xenbus/xenbus_probe.h b/drivers/xen/xenbus/xenbus_probe.h
index 888b990..b814935 100644
--- a/drivers/xen/xenbus/xenbus_probe.h
+++ b/drivers/xen/xenbus/xenbus_probe.h
@@ -48,6 +48,8 @@ struct xen_bus_type
 	struct bus_type bus;
 };
 
+extern struct device_attribute xenbus_dev_attrs[];
+
 extern int xenbus_match(struct device *_dev, struct device_driver *_drv);
 extern int xenbus_dev_probe(struct device *_dev);
 extern int xenbus_dev_remove(struct device *_dev);
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index 6cf467b..ec510e5 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -183,10 +183,6 @@ static void frontend_changed(struct xenbus_watch *watch,
 	xenbus_otherend_changed(watch, vec, len, 0);
 }
 
-static struct device_attribute xenbus_backend_dev_attrs[] = {
-	__ATTR_NULL
-};
-
 static struct xen_bus_type xenbus_backend = {
 	.root = "backend",
 	.levels = 3,		/* backend/type/<frontend>/<id> */
@@ -200,7 +196,7 @@ static struct xen_bus_type xenbus_backend = {
 		.probe		= xenbus_dev_probe,
 		.remove		= xenbus_dev_remove,
 		.shutdown	= xenbus_dev_shutdown,
-		.dev_attrs	= xenbus_backend_dev_attrs,
+		.dev_attrs	= xenbus_dev_attrs,
 	},
 };
 
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index b6a2690..ed2ba47 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -81,10 +81,6 @@ static void backend_changed(struct xenbus_watch *watch,
 	xenbus_otherend_changed(watch, vec, len, 1);
 }
 
-static struct device_attribute xenbus_frontend_dev_attrs[] = {
-	__ATTR_NULL
-};
-
 static const struct dev_pm_ops xenbus_pm_ops = {
 	.suspend	= xenbus_dev_suspend,
 	.resume		= xenbus_dev_resume,
@@ -106,7 +102,7 @@ static struct xen_bus_type xenbus_frontend = {
 		.probe		= xenbus_dev_probe,
 		.remove		= xenbus_dev_remove,
 		.shutdown	= xenbus_dev_shutdown,
-		.dev_attrs	= xenbus_frontend_dev_attrs,
+		.dev_attrs	= xenbus_dev_attrs,
 
 		.pm		= &xenbus_pm_ops,
 	},
-- 
1.7.5.4
