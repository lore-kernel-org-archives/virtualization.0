From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH 2/3] virtio: use dev_to_virtio wrapper in virtio
Date: Wed, 5 Dec 2012 15:03:28 +0800
Message-ID: <1354691009-25966-2-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1354691009-25966-1-git-send-email-gaowanlong@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1354691009-25966-1-git-send-email-gaowanlong@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Use dev_to_virtio wrapper in virtio to make code clearly.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/virtio/virtio.c | 19 +++++++++----------
 include/linux/virtio.h  |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 1e8659c..1346ae8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -10,33 +10,32 @@ static DEFINE_IDA(virtio_index_ida);
 static ssize_t device_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
-	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	struct virtio_device *dev = dev_to_virtio(_d);
 	return sprintf(buf, "0x%04x\n", dev->id.device);
 }
 static ssize_t vendor_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
-	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	struct virtio_device *dev = dev_to_virtio(_d);
 	return sprintf(buf, "0x%04x\n", dev->id.vendor);
 }
 static ssize_t status_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
-	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	struct virtio_device *dev = dev_to_virtio(_d);
 	return sprintf(buf, "0x%08x\n", dev->config->get_status(dev));
 }
 static ssize_t modalias_show(struct device *_d,
 			     struct device_attribute *attr, char *buf)
 {
-	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
-
+	struct virtio_device *dev = dev_to_virtio(_d);
 	return sprintf(buf, "virtio:d%08Xv%08X\n",
 		       dev->id.device, dev->id.vendor);
 }
 static ssize_t features_show(struct device *_d,
 			     struct device_attribute *attr, char *buf)
 {
-	struct virtio_device *dev = container_of(_d, struct virtio_device, dev);
+	struct virtio_device *dev = dev_to_virtio(_d);
 	unsigned int i;
 	ssize_t len = 0;
 
@@ -71,7 +70,7 @@ static inline int virtio_id_match(const struct virtio_device *dev,
 static int virtio_dev_match(struct device *_dv, struct device_driver *_dr)
 {
 	unsigned int i;
-	struct virtio_device *dev = container_of(_dv,struct virtio_device,dev);
+	struct virtio_device *dev = dev_to_virtio(_dv);
 	const struct virtio_device_id *ids;
 
 	ids = container_of(_dr, struct virtio_driver, driver)->id_table;
@@ -83,7 +82,7 @@ static int virtio_dev_match(struct device *_dv, struct device_driver *_dr)
 
 static int virtio_uevent(struct device *_dv, struct kobj_uevent_env *env)
 {
-	struct virtio_device *dev = container_of(_dv,struct virtio_device,dev);
+	struct virtio_device *dev = dev_to_virtio(_dv);
 
 	return add_uevent_var(env, "MODALIAS=virtio:d%08Xv%08X",
 			      dev->id.device, dev->id.vendor);
@@ -111,7 +110,7 @@ EXPORT_SYMBOL_GPL(virtio_check_driver_offered_feature);
 static int virtio_dev_probe(struct device *_d)
 {
 	int err, i;
-	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = container_of(dev->dev.driver,
 						 struct virtio_driver, driver);
 	u32 device_features;
@@ -152,7 +151,7 @@ static int virtio_dev_probe(struct device *_d)
 
 static int virtio_dev_remove(struct device *_d)
 {
-	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = container_of(dev->dev.driver,
 						 struct virtio_driver, driver);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 25fa1a6..30fc3c9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -79,7 +79,7 @@ struct virtio_device {
 	void *priv;
 };
 
-#define dev_to_virtio(dev) container_of(dev, struct virtio_device, dev)
+#define dev_to_virtio(_dev) container_of(_dev, struct virtio_device, dev)
 int register_virtio_device(struct virtio_device *dev);
 void unregister_virtio_device(struct virtio_device *dev);
 
-- 
1.8.0
