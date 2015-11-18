From: Ming Lin <mlin@kernel.org>
Subject: [PATCH -qemu] nvme: support Google vendor extension
Date: Tue, 17 Nov 2015 21:47:04 -0800
Message-ID: <1447825624-17011-3-git-send-email-mlin@kernel.org>
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

From: Mihai Rusu <dizzy@google.com>

This implements the device side for an NVMe vendor extension that
reduces the number of MMIO writes which can result in a very large
performance benefit in virtualized environments.

See the following link for a description of the mechanism and the
kernel NVMe driver changes to support this vendor extension:
http://lists.infradead.org/pipermail/linux-nvme/2014-July/001076.html

On my workstation (3.2Ghz Xeon E5-1650), running QEMU:
$ bin/opt/native/x86_64-softmmu/qemu-system-x86_64 \
    -enable-kvm -m 2048 -smp 4 \
    -drive if=virtio,file=debian.raw,cache=none \
    -drive file=nvme.raw,if=none,id=nvme-dev \
    -device nvme,drive=nvme-dev,serial=nvme-serial

Using "fio":
vm # fio -time_based --name=benchmark --ioengine=libaio --iodepth=32 \
    --numjobs=1 --runtime=30 --blocksize=4k --filename=/dev/nvme0n1 \
    --nrfiles=1 --invalidate=1 --verify=0 --direct=1 --rw=randread

I get about 20k IOPs with the original code and about 85k IOPs with
the vendor extension changes applied (and running a vendor extension
supporting 3.14 based guest kernel).

Signed-off-by: Mihai Rusu <dizzy@google.com>
[fixed for a merging into different tree; added VID/DID params]
Signed-off-by: Keith Busch <keith.busch@intel.com>
[mlin: port for upstream]
Signed-off-by: Ming Lin <mlin@kernel.org>
---
 hw/block/nvme.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/block/nvme.h | 18 +++++++++++
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 169e4fa..3e1c38d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -20,6 +20,7 @@
  *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>
  */
 
+#include <exec/memory.h>
 #include <hw/block/block.h>
 #include <hw/hw.h>
 #include <hw/pci/msix.h>
@@ -158,6 +159,14 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     return NVME_SUCCESS;
 }
 
+static void nvme_update_cq_head(NvmeCQueue *cq)
+{
+    if (cq->db_addr) {
+        pci_dma_read(&cq->ctrl->parent_obj, cq->db_addr,
+                     &cq->head, sizeof(cq->head));
+    }
+}
+
 static void nvme_post_cqes(void *opaque)
 {
     NvmeCQueue *cq = opaque;
@@ -168,6 +177,8 @@ static void nvme_post_cqes(void *opaque)
         NvmeSQueue *sq;
         hwaddr addr;
 
+        nvme_update_cq_head(cq);
+
         if (nvme_cq_full(cq)) {
             break;
         }
@@ -350,6 +361,8 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
         QTAILQ_INSERT_TAIL(&(sq->req_list), &sq->io_req[i], entry);
     }
     sq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_sq, sq);
+    sq->db_addr = 0;
+    sq->eventidx_addr = 0;
 
     assert(n->cq[cqid]);
     cq = n->cq[cqid];
@@ -430,6 +443,8 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
     cq->head = cq->tail = 0;
     QTAILQ_INIT(&cq->req_list);
     QTAILQ_INIT(&cq->sq_list);
+    cq->db_addr = 0;
+    cq->eventidx_addr = 0;
     msix_vector_use(&n->parent_obj, cq->vector);
     n->cq[cqid] = cq;
     cq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
@@ -528,6 +543,40 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_set_db_memory(NvmeCtrl *n, const NvmeCmd *cmd)
+{
+    uint64_t db_addr = le64_to_cpu(cmd->prp1);
+    uint64_t eventidx_addr = le64_to_cpu(cmd->prp2);
+    int i;
+
+    /* Addresses should not be NULL and should be page aligned. */
+    if (db_addr == 0 || db_addr & (n->page_size - 1) ||
+        eventidx_addr == 0 || eventidx_addr & (n->page_size - 1)) {
+        return NVME_INVALID_MEMORY_ADDRESS | NVME_DNR;
+    }
+
+    /* This assumes all I/O queues are created before this command is handled.
+     * We skip the admin queues. */
+    for (i = 1; i < n->num_queues; i++) {
+        NvmeSQueue *sq = n->sq[i];
+        NvmeCQueue *cq = n->cq[i];
+
+        if (sq != NULL) {
+            /* Submission queue tail pointer location, 2 * QID * stride. */
+            sq->db_addr = db_addr + 2 * i * 4;
+            sq->eventidx_addr = eventidx_addr + 2 * i * 4;
+        }
+
+        if (cq != NULL) {
+            /* Completion queue head pointer location, (2 * QID + 1) * stride.
+             */
+            cq->db_addr = db_addr + (2 * i + 1) * 4;
+            cq->eventidx_addr = eventidx_addr + (2 * i + 1) * 4;
+        }
+    }
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     switch (cmd->opcode) {
@@ -545,11 +594,29 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_SET_DB_MEMORY:
+        return nvme_set_db_memory(n, cmd);
     default:
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
 
+static void nvme_update_sq_eventidx(const NvmeSQueue *sq)
+{
+    if (sq->eventidx_addr) {
+        pci_dma_write(&sq->ctrl->parent_obj, sq->eventidx_addr,
+                      &sq->tail, sizeof(sq->tail));
+    }
+}
+
+static void nvme_update_sq_tail(NvmeSQueue *sq)
+{
+    if (sq->db_addr) {
+        pci_dma_read(&sq->ctrl->parent_obj, sq->db_addr,
+                     &sq->tail, sizeof(sq->tail));
+    }
+}
+
 static void nvme_process_sq(void *opaque)
 {
     NvmeSQueue *sq = opaque;
@@ -561,6 +628,8 @@ static void nvme_process_sq(void *opaque)
     NvmeCmd cmd;
     NvmeRequest *req;
 
+    nvme_update_sq_tail(sq);
+
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
         addr = sq->dma_addr + sq->head * n->sqe_size;
         pci_dma_read(&n->parent_obj, addr, (void *)&cmd, sizeof(cmd));
@@ -578,6 +647,9 @@ static void nvme_process_sq(void *opaque)
             req->status = status;
             nvme_enqueue_req_completion(cq, req);
         }
+
+        nvme_update_sq_eventidx(sq);
+        nvme_update_sq_tail(sq);
     }
 }
 
@@ -726,7 +798,11 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         }
 
         start_sqs = nvme_cq_full(cq) ? 1 : 0;
-        cq->head = new_head;
+        /* When the mapped pointer memory area is setup, we don't rely on
+         * the MMIO written values to update the head pointer. */
+        if (!cq->db_addr) {
+            cq->head = new_head;
+        }
         if (start_sqs) {
             NvmeSQueue *sq;
             QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
@@ -752,7 +828,11 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             return;
         }
 
-        sq->tail = new_tail;
+        /* When the mapped pointer memory area is setup, we don't rely on
+         * the MMIO written values to update the tail pointer. */
+        if (!sq->db_addr) {
+            sq->tail = new_tail;
+        }
         timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
     }
 }
@@ -805,6 +885,8 @@ static int nvme_init(PCIDevice *pci_dev)
     pci_conf = pci_dev->config;
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_dev->config, 0x2);
+    pci_config_set_vendor_id(pci_dev->config, n->vid);
+    pci_config_set_device_id(pci_dev->config, n->did);
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(&n->parent_obj, 0x80);
 
@@ -885,9 +967,13 @@ static void nvme_exit(PCIDevice *pci_dev)
     msix_uninit_exclusive_bar(pci_dev);
 }
 
+#define PCI_VENDOR_ID_GOOGLE 0x1AE0
+
 static Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
     DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
+    DEFINE_PROP_UINT16("vid", NvmeCtrl, vid, PCI_VENDOR_ID_GOOGLE),
+    DEFINE_PROP_UINT16("did", NvmeCtrl, did, 0x5845),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -905,8 +991,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
-    pc->device_id = 0x5845;
-    pc->revision = 1;
     pc->is_express = 1;
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index bf3a3cc..82aeab4 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -170,6 +170,7 @@ enum NvmeAdminCommands {
     NVME_ADM_CMD_FORMAT_NVM     = 0x80,
     NVME_ADM_CMD_SECURITY_SEND  = 0x81,
     NVME_ADM_CMD_SECURITY_RECV  = 0x82,
+    NVME_ADM_CMD_SET_DB_MEMORY  = 0xC0,  /* Vendor specific. */
 };
 
 enum NvmeIoCommands {
@@ -381,6 +382,7 @@ enum NvmeStatusCodes {
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
+    NVME_INVALID_MEMORY_ADDRESS = 0x01C0,  /* Vendor extension. */
     NVME_WRITE_FAULT            = 0x0280,
     NVME_UNRECOVERED_READ       = 0x0281,
     NVME_E2E_GUARD_ERROR        = 0x0282,
@@ -658,6 +660,13 @@ typedef struct NvmeSQueue {
     QTAILQ_HEAD(sq_req_list, NvmeRequest) req_list;
     QTAILQ_HEAD(out_req_list, NvmeRequest) out_req_list;
     QTAILQ_ENTRY(NvmeSQueue) entry;
+    /* Mapped memory location where the tail pointer is stored by the guest
+     * without triggering MMIO exits. */
+    uint64_t    db_addr;
+    /* virtio-like eventidx pointer, guest updates to the tail pointer that
+     * do not go over this value will not result in MMIO writes (but will
+     * still write the tail pointer to the "db_addr" location above). */
+    uint64_t    eventidx_addr;
 } NvmeSQueue;
 
 typedef struct NvmeCQueue {
@@ -673,6 +682,13 @@ typedef struct NvmeCQueue {
     QEMUTimer   *timer;
     QTAILQ_HEAD(sq_list, NvmeSQueue) sq_list;
     QTAILQ_HEAD(cq_req_list, NvmeRequest) req_list;
+    /* Mapped memory location where the head pointer is stored by the guest
+     * without triggering MMIO exits. */
+    uint64_t    db_addr;
+    /* virtio-like eventidx pointer, guest updates to the head pointer that
+     * do not go over this value will not result in MMIO writes (but will
+     * still write the head pointer to the "db_addr" location above). */
+    uint64_t    eventidx_addr;
 } NvmeCQueue;
 
 typedef struct NvmeNamespace {
@@ -699,6 +715,8 @@ typedef struct NvmeCtrl {
     uint32_t    num_queues;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
+    uint16_t    vid;
+    uint16_t    did;
 
     char            *serial;
     NvmeNamespace   *namespaces;
-- 
1.9.1
