From: Cong Meng <mc@linux.vnet.ibm.com>
Subject: [PATCH 1/2 v2] scsi bus: introduce hotplug() and hot_unplug()
	interfaces for SCSI bus
Date: Thu, 21 Jun 2012 15:54:26 +0800
Message-ID: <ad3714e594248d5a8d558b6983db3fb2da65ae9a.1340264611.git.mc__40901.6011203223$1340300270$gmane$org@linux.vnet.ibm.com>
References: <cover.1340264611.git.mc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1340264611.git.mc@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanha@linux.vnet.ibm.com, qemu-devel@nongnu.org, zwanp@cn.ibm.com, linuxram@us.ibm.com, senwang@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Add two interfaces hotplug() and hot_unplug() to scsi bus info.
The embody scsi bus can implement these two interfaces to signal the HBA driver
of guest kernel to add/remove the scsi device in question.

Signed-off-by: Cong Meng <mc@linux.vnet.ibm.com>
Signed-off-by: Sen Wang <senwang@linux.vnet.ibm.com>
---
 hw/scsi-bus.c |   16 +++++++++++++++-
 hw/scsi.h     |    2 ++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/hw/scsi-bus.c b/hw/scsi-bus.c
index dbdb99c..f08900e 100644
--- a/hw/scsi-bus.c
+++ b/hw/scsi-bus.c
@@ -177,6 +177,10 @@ static int scsi_qdev_init(DeviceState *qdev)
                                                          dev);
     }
 
+    if (bus->info->hotplug) {
+        bus->info->hotplug(bus, dev);
+    }
+
 err:
     return rc;
 }
@@ -1539,6 +1543,16 @@ static int get_scsi_requests(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
+static int scsi_qdev_unplug(DeviceState *qdev)
+{
+    SCSIDevice *dev = SCSI_DEVICE(qdev);
+    SCSIBus *bus = scsi_bus_from_device(dev);
+
+    if (bus->info->hot_unplug)
+        bus->info->hot_unplug(bus, dev);
+    return qdev_simple_unplug_cb(qdev);
+}
+
 const VMStateInfo vmstate_info_scsi_requests = {
     .name = "scsi-requests",
     .get  = get_scsi_requests,
@@ -1575,7 +1589,7 @@ static void scsi_device_class_init(ObjectClass *klass, void *data)
     DeviceClass *k = DEVICE_CLASS(klass);
     k->bus_info = &scsi_bus_info;
     k->init     = scsi_qdev_init;
-    k->unplug   = qdev_simple_unplug_cb;
+    k->unplug   = scsi_qdev_unplug;
     k->exit     = scsi_qdev_exit;
 }
 
diff --git a/hw/scsi.h b/hw/scsi.h
index 2eb66f7..5768071 100644
--- a/hw/scsi.h
+++ b/hw/scsi.h
@@ -130,6 +130,8 @@ struct SCSIBusInfo {
     void (*transfer_data)(SCSIRequest *req, uint32_t arg);
     void (*complete)(SCSIRequest *req, uint32_t arg, size_t resid);
     void (*cancel)(SCSIRequest *req);
+    void (*hotplug)(SCSIBus *bus, SCSIDevice *dev);
+    void (*hot_unplug)(SCSIBus *bus, SCSIDevice *dev);
     QEMUSGList *(*get_sg_list)(SCSIRequest *req);
 
     void (*save_request)(QEMUFile *f, SCSIRequest *req);
-- 
1.7.7.6
