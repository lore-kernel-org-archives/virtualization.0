From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] vfio error recovery: kernel support
Date: Sun, 22 Jan 2017 07:25:49 +0200
Message-ID: <1485062615-21367-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: caoj.fnst@cn.fujitsu.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a design and an initial patch for kernel side for AER
support in VFIO.

0. What happens now (PCIE AER only)
   Fatal errors cause a link reset.
   Non fatal errors don't.
   All errors stop the VM eventually, but not immediately
   because it's detected and reported asynchronously.
   Interrupts are forwarded as usual.
   Correctable errors are not reported to guest at all.
   Note: PPC EEH is different. This focuses on AER.

1. Correctable errors
   I don't see a need to report these to guest. So let's not.

2. Fatal errors
   It's not easy to handle them gracefully since link reset
   is needed. As a first step, let's use the existing mechanism
   in that case.

2. Non-fatal errors
   Here we could make progress by reporting them to guest
   and have guest handle them.
   Issues:
    a. this behaviour should only be enabled with new userspace
       old userspace should work without changes
    Suggestion: One way to address this would be to add a new eventfd
    non_fatal_err_trigger. If not set, invoke err_trigger.

    b. drivers are supposed to stop MMIO when error is reported
    if vm keeps going, we will keep doing MMIO/config
    Suggestion 1: ignore this. vm stop happens much later when
    userspace runs anyway, so we are not making things much worse
    Suggestion 2: try to stop MMIO/config, resume on resume call

    Patch below implements Suggestion 1.

Note that although this is really against the documentation, which states
error_detected() is the point at which the driver should quiesce the
device and not touch it further (until diagnostic poking at
mmio_enabled or full access at resume callback).
Fixing this won't be easy.
However, this is not a regression.

Also note this does nothing about interrupts, documentation
suggests returning IRQ_NONE until reset.
Again, not a regression.

c. PF driver might detect that function is completely broken,
if vm keeps going, we will keep doing MMIO/config
Suggestion 1: ignore this. vm stop happens much later when
userspace runs anyway, so we are not making things much worse
Suggestion 2: detect this and invoke err_trigger to stop VM

Patch below implements Suggestion 2.

Aside: what should we return if driver is e.g. being unbound?
For slot_reset, this implements Alex's suggestion to
return PCI_ERS_RESULT_NONE. It's worth considering whether
same should happen in error_report.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
	- more detailed commit log
	- fixed a couple of bugs

Alex, pls review but don't apply until we get
	- userspace updated to use the new interface
	- testing reports


 drivers/vfio/pci/vfio_pci.c         | 35 ++++++++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_intrs.c   | 19 +++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |  1 +
 include/linux/virtio_config.h       | 12 +++++++++++-
 include/uapi/linux/vfio.h           |  1 +
 5 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0e33278..5d489b5 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1296,7 +1296,9 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
 
 	mutex_lock(&vdev->igate);
 
-	if (vdev->err_trigger)
+	if (state == pci_channel_io_normal && vdev->non_fatal_err_trigger)
+		eventfd_signal(vdev->non_fatal_err_trigger, 1);
+	else if (vdev->err_trigger)
 		eventfd_signal(vdev->err_trigger, 1);
 
 	mutex_unlock(&vdev->igate);
@@ -1306,8 +1308,39 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 
+static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev,
+						pci_channel_state_t state)
+{
+	struct vfio_pci_device *vdev;
+	struct vfio_device *device;
+	static pci_ers_result_t err = PCI_ERS_RESULT_NONE;
+
+	device = vfio_device_get_from_dev(&pdev->dev);
+	if (!device)
+		goto err_dev;
+
+	vdev = vfio_device_data(device);
+	if (!vdev)
+		goto err_data;
+
+	mutex_lock(&vdev->igate);
+
+	if (vdev->err_trigger)
+		eventfd_signal(vdev->err_trigger, 1);
+
+	mutex_unlock(&vdev->igate);
+
+	err = PCI_ERS_RESULT_RECOVERED;
+
+err_data:
+	vfio_device_put(device);
+err_dev:
+	return err;
+}
+
 static const struct pci_error_handlers vfio_err_handlers = {
 	.error_detected = vfio_pci_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 
 static struct pci_driver vfio_pci_driver = {
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 1c46045..e883db5 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -611,6 +611,17 @@ static int vfio_pci_set_err_trigger(struct vfio_pci_device *vdev,
 					       count, flags, data);
 }
 
+static int vfio_pci_set_non_fatal_err_trigger(struct vfio_pci_device *vdev,
+				    unsigned index, unsigned start,
+				    unsigned count, uint32_t flags, void *data)
+{
+	if (index != VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX || start != 0 || count > 1)
+		return -EINVAL;
+
+	return vfio_pci_set_ctx_trigger_single(&vdev->non_fatal_err_trigger,
+					       count, flags, data);
+}
+
 static int vfio_pci_set_req_trigger(struct vfio_pci_device *vdev,
 				    unsigned index, unsigned start,
 				    unsigned count, uint32_t flags, void *data)
@@ -664,6 +675,14 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
 			break;
 		}
 		break;
+	case VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX:
+		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
+		case VFIO_IRQ_SET_ACTION_TRIGGER:
+			if (pci_is_pcie(vdev->pdev))
+				func = vfio_pci_set_err_trigger;
+			break;
+		}
+		break;
 	case VFIO_PCI_REQ_IRQ_INDEX:
 		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 		case VFIO_IRQ_SET_ACTION_TRIGGER:
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index f37c73b..c27a507 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -93,6 +93,7 @@ struct vfio_pci_device {
 	struct pci_saved_state	*pci_saved_state;
 	int			refcnt;
 	struct eventfd_ctx	*err_trigger;
+	struct eventfd_ctx	*non_fatal_err_trigger;
 	struct eventfd_ctx	*req_trigger;
 	struct list_head	dummy_resources_list;
 };
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 26c155b..6b0f416 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -159,7 +159,17 @@ static inline bool virtio_has_iommu_quirk(const struct virtio_device *vdev)
 	 * Note the reverse polarity of the quirk feature (compared to most
 	 * other features), this is for compatibility with legacy systems.
 	 */
-	return !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
+	if (virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
+		return false;
+
+	/*
+	 * fastboot emulator for ARM puts virtio devices behind an SMMU
+	 * and never bypasses it for legacy devices.
+	 */
+	if (IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
+		return virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
+
+	return true;
 }
 
 static inline
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 519eff3..affa973 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -443,6 +443,7 @@ enum {
 	VFIO_PCI_MSIX_IRQ_INDEX,
 	VFIO_PCI_ERR_IRQ_INDEX,
 	VFIO_PCI_REQ_IRQ_INDEX,
+	VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX,
 	VFIO_PCI_NUM_IRQS
 };
 
-- 
MST
