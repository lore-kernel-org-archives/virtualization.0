From: Bastian Blank <waldi@debian.org>
Subject: [PATCH 2/4] xen: Add module alias to autoload backend drivers
Date: Wed, 29 Jun 2011 14:40:08 +0200
Message-ID: <20110629124008.GB31038__15102.2142418244$1309356459$gmane$org@wavehammer.waldi.eu.org>
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

All the Xen backend drivers are assigned to a special bus type
xen-backend. This patch exports xen-backend:* names through modalias and
uevent to autoload them.

Signed-off-by: Bastian Blank <waldi@debian.org>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/xen/xenbus/xenbus_probe.c         |    3 ++-
 drivers/xen/xenbus/xenbus_probe_backend.c |    3 +++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 2ed0b04..bd2f90c 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -393,7 +393,8 @@ static ssize_t devtype_show(struct device *dev,
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "xen:%s\n", to_xenbus_device(dev)->devicetype);
+	return sprintf(buf, "%s:%s\n", dev->bus->name,
+		       to_xenbus_device(dev)->devicetype);
 }
 
 struct device_attribute xenbus_dev_attrs[] = {
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index ec510e5..60adf91 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -107,6 +107,9 @@ static int xenbus_uevent_backend(struct device *dev,
 	if (xdev == NULL)
 		return -ENODEV;
 
+	if (add_uevent_var(env, "MODALIAS=xen-backend:%s", xdev->devicetype))
+		return -ENOMEM;
+
 	/* stuff we want to pass to /sbin/hotplug */
 	if (add_uevent_var(env, "XENBUS_TYPE=%s", xdev->devicetype))
 		return -ENOMEM;
-- 
1.7.5.4
