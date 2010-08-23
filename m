From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 2/2] S390: Add virtio hotplug add support
Date: Mon, 23 Aug 2010 23:31:17 +0200
Message-ID: <1282599077-29857-2-git-send-email-agraf__38968.8998614021$1282599149$gmane$org@suse.de>
References: <1282599077-29857-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1282599077-29857-1-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The one big missing feature in s390-virtio was hotplugging. This is no more.
This patch implements hotplug add support, so you can on the fly add new devices
in the guest.

Keep in mind that this needs a patch for qemu to actually leverage the
functionality.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 drivers/s390/kvm/kvm_virtio.c |   48 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index ada7e2c..35383a3 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -30,11 +30,13 @@
 #define VIRTIO_PARAM_MASK		0xff
 #define VIRTIO_PARAM_VRING_INTERRUPT	0x0
 #define VIRTIO_PARAM_CONFIG_CHANGED	0x1
+#define VIRTIO_PARAM_DEV_ADD		0x2
 
 /*
  * The pointer to our (page) of device descriptions.
  */
 static void *kvm_devices;
+struct work_struct hotplug_work;
 
 struct kvm_device {
 	struct virtio_device vdev;
@@ -331,6 +333,47 @@ static void scan_devices(void)
 }
 
 /*
+ * match for a kvm device with a specific desc pointer
+ */
+static int match_desc(struct device *dev, void *data)
+{
+	if ((ulong)to_kvmdev(dev_to_virtio(dev))->desc == (ulong)data)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * hotplug_device tries to find changes in the device page.
+ */
+static void hotplug_devices(struct work_struct *dummy)
+{
+	unsigned int i;
+	struct kvm_device_desc *d;
+	struct device *dev;
+
+	for (i = 0; i < PAGE_SIZE; i += desc_size(d)) {
+		d = kvm_devices + i;
+
+		/* end of list */
+		if (d->type == 0)
+			break;
+
+		/* device already exists */
+		dev = device_find_child(kvm_root, d, match_desc);
+		if (dev) {
+			/* XXX check for hotplug remove */
+			put_device(dev);
+			continue;
+		}
+
+		/* new device */
+		printk(KERN_INFO "Adding new virtio device %p\n", d);
+		add_kvm_device(d, i);
+	}
+}
+
+/*
  * we emulate the request_irq behaviour on top of s390 extints
  */
 static void kvm_extint_handler(u16 code)
@@ -360,6 +403,9 @@ static void kvm_extint_handler(u16 code)
 
 		break;
 	}
+	case VIRTIO_PARAM_DEV_ADD:
+		schedule_work(&hotplug_work);
+		break;
 	case VIRTIO_PARAM_VRING_INTERRUPT:
 	default:
 		vring_interrupt(0, vq);
@@ -393,6 +439,8 @@ static int __init kvm_devices_init(void)
 
 	kvm_devices = (void *) real_memory_size;
 
+	INIT_WORK(&hotplug_work, hotplug_devices);
+
 	ctl_set_bit(0, 9);
 	register_external_interrupt(0x2603, kvm_extint_handler);
 
-- 
1.6.0.2
