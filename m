From: Ming Lin <mlin@kernel.org>
Subject: [PATCH -kernel] nvme: improve performance for virtual NVMe devices
Date: Tue, 17 Nov 2015 21:47:03 -0800
Message-ID: <1447825624-17011-2-git-send-email-mlin@kernel.org>
References: <1447825624-17011-1-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447825624-17011-1-git-send-email-mlin@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-nvme@lists.infradead.org, qemu-devel@nongnu.org
Cc: fes@google.com, keith.busch@intel.com, tytso@mit.edu, virtualization@lists.linux-foundation.org, axboe@fb.com, Rob Nelson <rlnelson@google.com>, Christoph Hellwig <hch@lst.de>, Mihai Rusu <dizzy@google.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Rob Nelson <rlnelson@google.com>

This change provides a mechanism to reduce the number of MMIO doorbell
writes for the NVMe driver. When running in a virtualized environment
like QEMU, the cost of an MMIO is quite hefy here. The main idea for
the patch is provide the device two memory location locations:
 1) to store the doorbell values so they can be lookup without the doorbell
    MMIO write
 2) to store an event index.
I believe the doorbell value is obvious, the event index not so much.
Similar to the virtio specificaiton, the virtual device can tell the
driver (guest OS) not to write MMIO unless you are writing past this
value.

FYI: doorbell values are written by the nvme driver (guest OS) and the
event index is written by the virtual device (host OS).

The patch implements a new admin command that will communicate where
these two memory locations reside. If the command fails, the nvme
driver will work as before without any optimizations.

Contributions:
  Eric Northup <digitaleric@google.com>
  Frank Swiderski <fes@google.com>
  Ted Tso <tytso@mit.edu>
  Keith Busch <keith.busch@intel.com>

Just to give an idea on the performance boost with the vendor
extension: Running fio [1], a stock NVMe driver I get about 200K read
IOPs with my vendor patch I get about 1000K read IOPs. This was
running with a null device i.e. the backing device simply returned
success on every read IO request.

[1] Running on a 4 core machine:
  fio --time_based --name=benchmark --runtime=30
  --filename=/dev/nvme0n1 --nrfiles=1 --ioengine=libaio --iodepth=32
  --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 --numjobs=4
  --rw=randread --blocksize=4k --randrepeat=false

Signed-off-by: Rob Nelson <rlnelson@google.com>
[mlin: port for upstream]
Signed-off-by: Ming Lin <mlin@kernel.org>
---
 drivers/nvme/host/Kconfig |   7 +++
 drivers/nvme/host/core.c  |   1 +
 drivers/nvme/host/pci.c   | 147 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h      |  21 +++++++
 4 files changed, 176 insertions(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 002a94a..93f9438 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -8,3 +8,10 @@ config BLK_DEV_NVME
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvme.
+
+config NVME_VENDOR_EXT_GOOGLE
+	tristate "NVMe Vendor Extension for Improved Virtualization"
+	depends on BLK_DEV_NVME
+	---help---
+	  Google extension to reduce the number of MMIO doorbell
+	  writes for the NVMe driver
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 400b1ea..78ac8bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -160,6 +160,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 {
 	return __nvme_submit_sync_cmd(q, cmd, buffer, bufflen, NULL, 0);
 }
+EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
 int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void __user *ubuffer, unsigned bufflen,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 91522bb..93f1f36 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -49,6 +49,9 @@
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 
+/* Google Vendor ID is not in include/linux/pci_ids.h */
+#define PCI_VENDOR_ID_GOOGLE 0x1AE0
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -106,6 +109,13 @@ struct nvme_dev {
 	unsigned long flags;
 #define NVME_CTRL_RESETTING	0
 
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	u32 *db_mem;
+	dma_addr_t doorbell;
+	u32 *ei_mem;
+	dma_addr_t eventidx;
+#endif
+
 	struct nvme_ctrl ctrl;
 };
 
@@ -139,6 +149,12 @@ struct nvme_queue {
 	u8 cq_phase;
 	u8 cqe_seen;
 	struct async_cmd_info cmdinfo;
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	u32 *sq_doorbell_addr;
+	u32 *sq_eventidx_addr;
+	u32 *cq_doorbell_addr;
+	u32 *cq_eventidx_addr;
+#endif
 };
 
 /*
@@ -176,6 +192,9 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	BUILD_BUG_ON(sizeof(struct nvme_doorbell_memory) != 64);
+#endif
 }
 
 /*
@@ -289,6 +308,51 @@ static void nvme_finish_aen_cmd(struct nvme_dev *dev, struct nvme_completion *cq
 	}
 }
 
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+static int nvme_vendor_memory_size(struct nvme_dev *dev)
+{
+	return ((num_possible_cpus() + 1) * 8 * dev->db_stride);
+}
+
+static int nvme_set_doorbell_memory(struct nvme_dev *dev)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.doorbell_memory.opcode = nvme_admin_doorbell_memory;
+	c.doorbell_memory.prp1 = cpu_to_le64(dev->doorbell);
+	c.doorbell_memory.prp2 = cpu_to_le64(dev->eventidx);
+
+	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
+}
+
+static inline int nvme_ext_need_event(u16 event_idx, u16 new_idx, u16 old)
+{
+	/* Borrowed from vring_need_event */
+	return (u16)(new_idx - event_idx - 1) < (u16)(new_idx - old);
+}
+
+static void nvme_ext_write_doorbell(u16 value, u32 __iomem* q_db,
+			   u32* db_addr, volatile u32* event_idx)
+{
+	u16 old_value;
+	if (!db_addr)
+		goto ring_doorbell;
+
+	old_value = *db_addr;
+	*db_addr = value;
+
+	rmb();
+	if (!nvme_ext_need_event(*event_idx, value, old_value))
+		goto no_doorbell;
+
+ring_doorbell:
+	writel(value, q_db);
+no_doorbell:
+	return;
+}
+#endif
+
 /**
  * __nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -306,9 +370,19 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 	else
 		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
 
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	if (nvmeq->sq_doorbell_addr)
+		wmb();
+#endif
+
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	nvme_ext_write_doorbell(tail, nvmeq->q_db,
+		nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
+#else
 	writel(tail, nvmeq->q_db);
+#endif
 	nvmeq->sq_tail = tail;
 }
 
@@ -719,6 +793,11 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 		u16 status = le16_to_cpu(cqe.status);
 		struct request *req;
 
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+		if (to_pci_dev(nvmeq->dev->dev)->vendor == PCI_VENDOR_ID_GOOGLE)
+			rmb();
+#endif
+
 		if ((status & 1) != phase)
 			break;
 		nvmeq->sq_head = le16_to_cpu(cqe.sq_head);
@@ -764,7 +843,12 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return 0;
 
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	nvme_ext_write_doorbell(head, nvmeq->q_db + nvmeq->dev->db_stride,
+		nvmeq->cq_doorbell_addr, nvmeq->cq_eventidx_addr);
+#else
 	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+#endif
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
@@ -1111,6 +1195,17 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->cq_vector = -1;
 	dev->queues[qid] = nvmeq;
 
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	if (dev->db_mem && dev->ei_mem && qid != 0) {
+		nvmeq->sq_doorbell_addr = &dev->db_mem[qid * 2 * dev->db_stride];
+		nvmeq->cq_doorbell_addr =
+			&dev->db_mem[(qid * 2 + 1) * dev->db_stride];
+		nvmeq->sq_eventidx_addr = &dev->ei_mem[qid * 2 * dev->db_stride];
+		nvmeq->cq_eventidx_addr =
+			&dev->ei_mem[(qid * 2 + 1) * dev->db_stride];
+	}
+#endif
+
 	/* make sure queue descriptor is set before queue count, for kthread */
 	mb();
 	dev->queue_count++;
@@ -1145,6 +1240,16 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	if (to_pci_dev(dev->dev)->vendor == PCI_VENDOR_ID_GOOGLE && qid != 0) {
+		nvmeq->sq_doorbell_addr = &dev->db_mem[qid * 2 * dev->db_stride];
+		nvmeq->cq_doorbell_addr =
+			&dev->db_mem[(qid * 2 + 1) * dev->db_stride];
+		nvmeq->sq_eventidx_addr = &dev->ei_mem[qid * 2 * dev->db_stride];
+		nvmeq->cq_eventidx_addr =
+			&dev->ei_mem[(qid * 2 + 1) * dev->db_stride];
+	}
+#endif
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	dev->online_queues++;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1565,6 +1670,19 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (blk_mq_alloc_tag_set(&dev->tagset))
 			return 0;
 		dev->ctrl.tagset = &dev->tagset;
+
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+		if (to_pci_dev(dev->dev)->vendor == PCI_VENDOR_ID_GOOGLE) {
+			int res = nvme_set_doorbell_memory(dev);
+			if (res) {
+				// Free memory and continue on.
+				dma_free_coherent(dev->dev, 8192, dev->db_mem, dev->doorbell);
+				dma_free_coherent(dev->dev, 8192, dev->ei_mem, dev->doorbell);
+				dev->db_mem = 0;
+				dev->ei_mem = 0;
+			}
+		}
+#endif
 	}
 	queue_work(nvme_workq, &dev->scan_work);
 	return 0;
@@ -1618,7 +1736,28 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2))
 		dev->cmb = nvme_map_cmb(dev);
 
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	if (pdev->vendor == PCI_VENDOR_ID_GOOGLE) {
+		int mem_size = nvme_vendor_memory_size(dev);
+		dev->db_mem = dma_alloc_coherent(&pdev->dev, mem_size, &dev->doorbell, GFP_KERNEL);
+		if (!dev->db_mem) {
+			result = -ENOMEM;
+			goto unmap;
+		}
+		dev->ei_mem = dma_alloc_coherent(&pdev->dev, mem_size, &dev->eventidx, GFP_KERNEL);
+		if (!dev->ei_mem) {
+			result = -ENOMEM;
+			goto dma_free;
+		}
+	}
+
+	return 0;
+
+ dma_free:
+	dma_free_coherent(&pdev->dev, nvme_vendor_memory_size(dev), dev->db_mem, dev->doorbell);
+	dev->db_mem = 0;
 	return 0;
+#endif
 
  unmap:
 	iounmap(dev->bar);
@@ -1633,6 +1772,14 @@ static int nvme_dev_map(struct nvme_dev *dev)
 static void nvme_dev_unmap(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	int mem_size = nvme_vendor_memory_size(dev);
+
+	if (dev->db_mem)
+		dma_free_coherent(&pdev->dev, mem_size, dev->db_mem, dev->doorbell);
+	if (dev->ei_mem)
+		dma_free_coherent(&pdev->dev, mem_size, dev->ei_mem, dev->eventidx);
+#endif
 
 	if (pdev->msi_enabled)
 		pci_disable_msi(pdev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index a55986f..d3a8289 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -387,6 +387,9 @@ enum nvme_admin_opcode {
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	nvme_admin_doorbell_memory	= 0xC0,
+#endif
 };
 
 enum {
@@ -516,6 +519,18 @@ struct nvme_format_cmd {
 	__u32			rsvd11[5];
 };
 
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+struct nvme_doorbell_memory {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	__le64			prp1;
+	__le64			prp2;
+	__u32			rsvd12[6];
+};
+#endif
+
 struct nvme_command {
 	union {
 		struct nvme_common_command common;
@@ -529,6 +544,9 @@ struct nvme_command {
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
 		struct nvme_abort_cmd abort;
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+		struct nvme_doorbell_memory doorbell_memory;
+#endif
 	};
 };
 
@@ -575,6 +593,9 @@ enum {
 	NVME_SC_BAD_ATTRIBUTES		= 0x180,
 	NVME_SC_INVALID_PI		= 0x181,
 	NVME_SC_READ_ONLY		= 0x182,
+#ifdef CONFIG_NVME_VENDOR_EXT_GOOGLE
+	NVME_SC_DOORBELL_MEMORY_INVALID	= 0x1C0,
+#endif
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,
-- 
1.9.1
