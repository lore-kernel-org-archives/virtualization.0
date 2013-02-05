From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] virtio: make config_ops const
Date: Tue, 5 Feb 2013 09:42:44 -0800
Message-ID: <20130205094244.2993245a@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It is just a table of function pointers, make it const for cleanliness and security
reasons.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

--- a/drivers/lguest/lguest_device.c	2013-02-02 20:03:23.285506053 +1100
+++ b/drivers/lguest/lguest_device.c	2013-02-02 20:06:15.253510658 +1100
@@ -396,7 +396,7 @@ static const char *lg_bus_name(struct vi
 }
 
 /* The ops structure which hooks everything together. */
-static struct virtio_config_ops lguest_config_ops = {
+static const struct virtio_config_ops lguest_config_ops = {
 	.get_features = lg_get_features,
 	.finalize_features = lg_finalize_features,
 	.get = lg_get,
--- a/drivers/remoteproc/remoteproc_virtio.c	2013-02-02 20:03:23.289506053 +1100
+++ b/drivers/remoteproc/remoteproc_virtio.c	2013-02-02 20:06:10.097510520 +1100
@@ -222,7 +222,7 @@ static void rproc_virtio_finalize_featur
 	rvdev->gfeatures = vdev->features[0];
 }
 
-static struct virtio_config_ops rproc_virtio_config_ops = {
+static const struct virtio_config_ops rproc_virtio_config_ops = {
 	.get_features	= rproc_virtio_get_features,
 	.finalize_features = rproc_virtio_finalize_features,
 	.find_vqs	= rproc_virtio_find_vqs,
--- a/drivers/s390/kvm/kvm_virtio.c	2013-01-17 16:06:04.691116116 +1100
+++ b/drivers/s390/kvm/kvm_virtio.c	2013-02-02 20:06:04.121510360 +1100
@@ -275,7 +275,7 @@ static const char *kvm_bus_name(struct v
 /*
  * The config ops structure as defined by virtio config
  */
-static struct virtio_config_ops kvm_vq_configspace_ops = {
+static const struct virtio_config_ops kvm_vq_configspace_ops = {
 	.get_features = kvm_get_features,
 	.finalize_features = kvm_finalize_features,
 	.get = kvm_get,
--- a/drivers/virtio/virtio_mmio.c	2013-01-09 04:04:12.010765226 +1100
+++ b/drivers/virtio/virtio_mmio.c	2013-02-02 20:05:50.937510007 +1100
@@ -423,7 +423,7 @@ static const char *vm_bus_name(struct vi
 	return vm_dev->pdev->name;
 }
 
-static struct virtio_config_ops virtio_mmio_config_ops = {
+static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.get		= vm_get,
 	.set		= vm_set,
 	.get_status	= vm_get_status,
--- a/drivers/virtio/virtio_pci.c	2013-01-09 04:04:12.010765226 +1100
+++ b/drivers/virtio/virtio_pci.c	2013-02-02 20:05:40.009509714 +1100
@@ -652,7 +652,7 @@ static int vp_set_vq_affinity(struct vir
 	return 0;
 }
 
-static struct virtio_config_ops virtio_pci_config_ops = {
+static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get		= vp_get,
 	.set		= vp_set,
 	.get_status	= vp_get_status,
--- a/include/linux/virtio.h	2013-01-09 04:04:12.122765257 +1100
+++ b/include/linux/virtio.h	2013-02-02 20:05:31.433509485 +1100
@@ -78,7 +78,7 @@ struct virtio_device {
 	int index;
 	struct device dev;
 	struct virtio_device_id id;
-	struct virtio_config_ops *config;
+	const struct virtio_config_ops *config;
 	struct list_head vqs;
 	/* Note that this is a Linux set_bit-style bitmap. */
 	unsigned long features[1];
