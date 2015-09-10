From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 2/2] virtio-nvme(qemu): NVMe device using virtio
Date: Wed,  9 Sep 2015 22:48:32 -0700
Message-ID: <1441864112-12765-3-git-send-email-mlin@kernel.org>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1441864112-12765-1-git-send-email-mlin@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
Cc: Ming Lin <mlin@kernel.org>, Ming Lin <ming.l@ssi.samsung.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Play it with:
-drive file=disk.img,format=raw,if=none,id=D22 \
-device virtio-nvme-pci,drive=D22,serial=1234,num_queues=4

Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 hw/block/Makefile.objs                       |   2 +-
 hw/block/virtio-nvme.c                       | 449 +++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c                       |  42 +++
 hw/virtio/virtio-pci.h                       |  14 +
 include/hw/pci/pci.h                         |   1 +
 include/hw/virtio/virtio-nvme.h              |  60 ++++
 include/standard-headers/linux/virtio_ids.h  |   1 +
 include/standard-headers/linux/virtio_nvme.h |  16 +
 8 files changed, 584 insertions(+), 1 deletion(-)
 create mode 100644 hw/block/virtio-nvme.c
 create mode 100644 include/hw/virtio/virtio-nvme.h
 create mode 100644 include/standard-headers/linux/virtio_nvme.h

diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index d4c3ab7..a6e0b1c 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -11,5 +11,5 @@ common-obj-$(CONFIG_NVME_PCI) += nvme.o
 
 obj-$(CONFIG_SH4) += tc58128.o
 
-obj-$(CONFIG_VIRTIO) += virtio-blk.o
+obj-$(CONFIG_VIRTIO) += virtio-blk.o virtio-nvme.o
 obj-$(CONFIG_VIRTIO) += dataplane/
diff --git a/hw/block/virtio-nvme.c b/hw/block/virtio-nvme.c
new file mode 100644
index 0000000..14ecfbc
--- /dev/null
+++ b/hw/block/virtio-nvme.c
@@ -0,0 +1,449 @@
+#include <hw/pci/pci.h>
+#include "hw/virtio/virtio.h"
+#include "qemu-common.h"
+#include "qemu/iov.h"
+#include "qemu/error-report.h"
+#include "hw/block/block.h"
+#include "hw/virtio/virtio-access.h"
+
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_nvme.h"
+#include "nvme.h"
+#include "hw/virtio/virtio-nvme.h"
+
+#define VIRTIO_NVME_VQ_SIZE	128
+
+static void virtio_nvme_free_request(VirtIONVMEReq *req)
+{
+    if (req) {
+        g_slice_free(VirtIONVMEReq, req);
+    }
+}
+
+static uint16_t virtio_nvme_set_feature(VirtIONVME *n, VirtIONVMEReq *req)
+{
+    NvmeCmd *cmd = &req->cmd;
+    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
+
+    switch (dw10) {
+    case NVME_VOLATILE_WRITE_CACHE:
+        blk_set_enable_write_cache(n->conf.conf.blk, dw11 & 1);
+        break;
+    case NVME_NUMBER_OF_QUEUES:
+        req->resp->result =
+            cpu_to_le32((n->conf.num_queues - 1) | ((n->conf.num_queues - 1) << 16));
+        break;
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    return NVME_SUCCESS;
+}
+
+static uint16_t virtio_nvme_identify(VirtIONVME *n, VirtIONVMEReq *req)
+{
+    NvmeNamespace *ns;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint32_t cns  = le32_to_cpu(c->cns);
+    uint32_t nsid = le32_to_cpu(c->nsid);
+
+    if (cns) {
+        NvmeIdCtrl *id = &n->id_ctrl;
+
+        if (req->qiov.size != sizeof(NvmeIdCtrl))
+            return NVME_INVALID_FIELD;
+
+        strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU Virtio NVMe Ctrl", ' ');
+        qemu_iovec_from_buf(&req->qiov, 0, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl));
+        return 0;
+    }
+
+    if (nsid == 0 || nsid > n->num_namespaces)
+        return NVME_INVALID_NSID | NVME_DNR;
+
+    if (req->qiov.size != sizeof(NvmeIdNs))
+        return NVME_INVALID_FIELD;
+
+    ns = &n->namespaces[nsid - 1];
+    qemu_iovec_from_buf(&req->qiov, 0, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns));
+    return 0;
+}
+
+static void virtio_nvme_complete_req(void *opaque, int ret)
+{
+    VirtIONVMEReq *req = opaque;
+    VirtIONVME *s = req->dev;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    stw_p(&req->resp->status, ret);
+    virtqueue_push(req->vq, &req->elem, sizeof(*req->resp));
+    virtio_notify(vdev, req->vq);
+    virtio_nvme_free_request(req);
+}
+
+static uint16_t virtio_nvme_rw(VirtIONVMEReq *req)
+{
+    VirtIONVME *n = req->dev;
+    NvmeNamespace *ns;
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+    uint32_t nsid, nlb, slba;
+    uint8_t lba_index;
+    uint8_t data_shift;
+    uint64_t data_size;
+    uint64_t aio_slba;
+    int is_write;
+
+    nsid = le32_to_cpu(rw->nsid);
+    if (nsid == 0 || nsid > n->num_namespaces) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    ns = &n->namespaces[nsid - 1];
+    nlb = le32_to_cpu(rw->nlb) + 1;
+    slba = le64_to_cpu(rw->slba);
+    lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+    data_shift = ns->id_ns.lbaf[lba_index].ds;
+    data_size = (uint64_t)nlb << data_shift;
+    aio_slba  = slba << (data_shift - BDRV_SECTOR_BITS);
+    is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
+
+    if ((slba + nlb) > ns->id_ns.nsze) {
+        return NVME_LBA_RANGE | NVME_DNR;
+    }
+
+    if (is_write)
+        blk_aio_writev(n->conf.conf.blk, aio_slba, &req->qiov, data_size>>BDRV_SECTOR_BITS,
+                       virtio_nvme_complete_req, req);
+    else
+        blk_aio_readv(n->conf.conf.blk, aio_slba, &req->qiov, data_size>>BDRV_SECTOR_BITS,
+                       virtio_nvme_complete_req, req);
+
+    return NVME_NO_COMPLETE;
+}
+
+static void virtio_nvme_handle_req_common(VirtIONVME *s, VirtIONVMEReq *req)
+{
+    struct iovec *in_iov = req->elem.in_sg;
+    struct iovec *iov = req->elem.out_sg;
+    unsigned in_num = req->elem.in_num;
+    unsigned out_num = req->elem.out_num;
+    int ret;
+
+    if (req->elem.out_num < 1 || req->elem.in_num < 1) {
+        error_report("virtio-nvme missing headers");
+        exit(1);
+    }
+
+    /* get cmd */
+    if (unlikely(iov_to_buf(iov, out_num, 0, &req->cmd,
+                            sizeof(req->cmd)) != sizeof(req->cmd))) {
+        error_report("virtio-nvme request cmd too short");
+        exit(1);
+    }
+
+    iov_discard_front(&iov, &out_num, sizeof(req->cmd));
+
+    if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_nvme_resp)) {
+        error_report("virtio-nvme response too short");
+        exit(1);
+    }
+
+    /* get response */
+    req->resp = (void *)in_iov[in_num - 1].iov_base
+                + in_iov[in_num - 1].iov_len
+                - sizeof(struct virtio_nvme_resp);
+    iov_discard_back(in_iov, &in_num, sizeof(struct virtio_nvme_resp));
+
+    if (out_num)
+        qemu_iovec_init_external(&req->qiov, iov, out_num);
+    else if(in_num)
+        qemu_iovec_init_external(&req->qiov, in_iov, in_num);
+
+    switch (req->cmd.opcode) {
+    case NVME_ADM_CMD_IDENTIFY:
+        ret = virtio_nvme_identify(s, req);
+        break;
+    case NVME_ADM_CMD_SET_FEATURES:
+        ret = virtio_nvme_set_feature(s, req);
+        break;
+    case NVME_CMD_WRITE:
+    case NVME_CMD_READ:
+        ret = virtio_nvme_rw(req);
+        return;
+    default: /* TODO */
+        ret = NVME_INVALID_OPCODE | NVME_DNR;
+        break;
+    }
+
+    virtio_nvme_complete_req(req, ret);
+}
+
+static VirtIONVMEReq *virtio_nvme_alloc_request(VirtIONVME *s, VirtQueue *vq)
+{
+    VirtIONVMEReq *req = g_slice_new(VirtIONVMEReq);
+    req->dev = s;
+    req->vq = vq;
+    return req;
+}
+
+static VirtIONVMEReq *virtio_nvme_get_request(VirtIONVME *s, VirtQueue *vq)
+{
+    VirtIONVMEReq *req = virtio_nvme_alloc_request(s, vq);
+
+    if (!virtqueue_pop(vq, &req->elem)) {
+        virtio_nvme_free_request(req);
+        return NULL;
+    }
+
+    return req;
+}
+
+static void virtio_nvme_handle_req(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIONVME *s = VIRTIO_NVME(vdev);
+    VirtIONVMEReq *req;
+
+    while ((req = virtio_nvme_get_request(s, vq))) {
+        virtio_nvme_handle_req_common(s, req);
+    }
+}
+
+static void virtio_nvme_clear_ctrl(VirtIONVME *n)
+{
+    blk_flush(n->conf.conf.blk);
+    n->bar.cc = 0;
+}
+
+static int virtio_nvme_start_ctrl(VirtIONVME *n)
+{
+    uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
+    VirtIODevice *vdev = (VirtIODevice *)n;
+    int i;
+
+    n->page_bits = page_bits;
+    n->page_size = 1 << n->page_bits;
+    n->max_prp_ents = n->page_size / sizeof(uint64_t);
+    n->cqe_size = 1 << NVME_CC_IOCQES(n->bar.cc);
+    n->sqe_size = 1 << NVME_CC_IOSQES(n->bar.cc);
+
+    n->admin_vq = virtio_add_queue(vdev, VIRTIO_NVME_VQ_SIZE, virtio_nvme_handle_req);
+
+    n->io_vqs = g_new0(VirtQueue *, n->conf.num_queues);
+    for (i = 0; i < n->conf.num_queues; i++)
+        n->io_vqs[i] = virtio_add_queue(vdev, VIRTIO_NVME_VQ_SIZE, virtio_nvme_handle_req);
+
+    return 0;
+}
+
+static int virtio_nvme_init(VirtIONVME *n)
+{
+    NvmeIdCtrl *id = &n->id_ctrl;
+
+    int i;
+    int64_t bs_size;
+
+    if (!n->conf.conf.blk) {
+        return -1;
+    }
+
+    bs_size = blk_getlength(n->conf.conf.blk);
+    if (bs_size < 0) {
+        return -1;
+    }
+
+    blkconf_serial(&n->conf.conf, &n->serial);
+    if (!n->serial) {
+        return -1;
+    }
+    blkconf_blocksizes(&n->conf.conf);
+
+    n->num_namespaces = 1;
+    n->reg_size = 1 << qemu_fls(0x1004 + 2 * (n->conf.num_queues + 1) * 4);
+    n->ns_size = bs_size / (uint64_t)n->num_namespaces;
+
+    n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
+
+    strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
+    strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
+    strpadcpy((char *)id->sn, sizeof(id->sn), n->serial, ' ');
+    id->rab = 6;
+    id->ieee[0] = 0x00;
+    id->ieee[1] = 0x02;
+    id->ieee[2] = 0xb3;
+    id->oacs = cpu_to_le16(0);
+    id->frmw = 7 << 1;
+    id->lpa = 1 << 0;
+    id->sqes = (0x6 << 4) | 0x6;
+    id->cqes = (0x4 << 4) | 0x4;
+    id->nn = cpu_to_le32(n->num_namespaces);
+    id->psd[0].mp = cpu_to_le16(0x9c4);
+    id->psd[0].enlat = cpu_to_le32(0x10);
+    id->psd[0].exlat = cpu_to_le32(0x4);
+    if (blk_enable_write_cache(n->conf.conf.blk)) {
+        id->vwc = 1;
+    }
+
+    n->bar.cap = 0;
+    NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
+    NVME_CAP_SET_CQR(n->bar.cap, 1);
+    NVME_CAP_SET_AMS(n->bar.cap, 1);
+    NVME_CAP_SET_TO(n->bar.cap, 0xf);
+    NVME_CAP_SET_CSS(n->bar.cap, 1);
+    NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
+
+    n->bar.vs = 0x00010100;
+    n->bar.intmc = n->bar.intms = 0;
+
+    for (i = 0; i < n->num_namespaces; i++) {
+        NvmeNamespace *ns = &n->namespaces[i];
+        NvmeIdNs *id_ns = &ns->id_ns;
+        id_ns->nsfeat = 0;
+        id_ns->nlbaf = 0;
+        id_ns->flbas = 0;
+        id_ns->mc = 0;
+        id_ns->dpc = 0;
+        id_ns->dps = 0;
+        id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
+        id_ns->ncap  = id_ns->nuse = id_ns->nsze =
+            cpu_to_le64(n->ns_size >>
+                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
+    }
+    return 0;
+}
+
+static void virtio_nvme_exit(VirtIONVME *n)
+{
+    virtio_nvme_clear_ctrl(n);
+    g_free(n->namespaces);
+}
+
+static void virtio_nvme_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIONVME *n = VIRTIO_NVME(vdev);
+
+    virtio_init(vdev, "virtio-nvme", VIRTIO_ID_NVME,
+                sizeof(struct virtio_nvme_config));
+
+    n->blk = n->conf.conf.blk;
+
+    virtio_nvme_init(n);
+}
+
+static void virtio_nvme_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIONVME *n = VIRTIO_NVME(dev);
+
+    virtio_nvme_exit(n);
+    virtio_cleanup(vdev);
+}
+
+static uint64_t virtio_nvme_get_features(VirtIODevice *vdev, uint64_t features)
+{
+    virtio_add_feature(&features, VIRTIO_NVME_F_SEG_MAX);
+    virtio_add_feature(&features, VIRTIO_NVME_F_MQ);
+
+    return features;
+}
+
+static void virtio_nvme_ctrl_config(VirtIONVME *n, uint64_t data)
+{
+    if (NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc)) {
+        n->bar.cc = data;
+        if (virtio_nvme_start_ctrl(n)) {
+            n->bar.csts = NVME_CSTS_FAILED;
+        } else {
+            n->bar.csts = NVME_CSTS_READY;
+        }
+    } else if (!NVME_CC_EN(data) && NVME_CC_EN(n->bar.cc)) {
+        virtio_nvme_clear_ctrl(n);
+        n->bar.csts &= ~NVME_CSTS_READY;
+    }
+    if (NVME_CC_SHN(data) && !(NVME_CC_SHN(n->bar.cc))) {
+            virtio_nvme_clear_ctrl(n);
+            n->bar.cc = data;
+            n->bar.csts |= NVME_CSTS_SHST_COMPLETE;
+    } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(n->bar.cc)) {
+            n->bar.csts &= ~NVME_CSTS_SHST_COMPLETE;
+            n->bar.cc = data;
+    }
+}
+
+static void virtio_nvme_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VirtIONVME *s = VIRTIO_NVME(vdev);
+    struct virtio_nvme_config nvmecfg;
+
+    memset(&nvmecfg, 0, sizeof(nvmecfg));
+
+    virtio_stl_p(vdev, &nvmecfg.ctrl_config, s->bar.cc);
+    virtio_stl_p(vdev, &nvmecfg.csts, s->bar.csts);
+    virtio_stl_p(vdev, &nvmecfg.seg_max, 128 - 2);
+    virtio_stl_p(vdev, &nvmecfg.num_queues, s->conf.num_queues);
+
+    memcpy(config, &nvmecfg, sizeof(struct virtio_nvme_config));
+}
+
+static void virtio_nvme_set_config(VirtIODevice *vdev, const uint8_t *config)
+{
+    VirtIONVME *n = VIRTIO_NVME(vdev);
+    struct virtio_nvme_config nvmecfg;
+
+    memcpy(&nvmecfg, config, sizeof(nvmecfg));
+
+    virtio_nvme_ctrl_config(n, nvmecfg.ctrl_config);
+}
+
+static Property virtio_nvme_props[] = {
+    DEFINE_BLOCK_PROPERTIES(VirtIONVME, conf.conf),
+    DEFINE_PROP_STRING("serial", VirtIONVME, serial),
+    DEFINE_PROP_UINT32("num_queues", VirtIONVME, conf.num_queues, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription virtio_nvme_vmstate = {
+    .name = "virtio_nvme",
+    .unmigratable = 1,
+};
+
+static void virtio_nvme_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->desc = "Virtio NVMe";
+    dc->props = virtio_nvme_props;
+    dc->vmsd = &virtio_nvme_vmstate;
+
+    vdc->realize = virtio_nvme_device_realize;
+    vdc->unrealize = virtio_nvme_device_unrealize;
+    vdc->get_config = virtio_nvme_get_config;
+    vdc->set_config = virtio_nvme_set_config;
+    vdc->get_features = virtio_nvme_get_features;
+}
+
+static void virtio_nvme_instance_init(Object *obj)
+{
+    VirtIONVME *s = VIRTIO_NVME(obj);
+
+    device_add_bootindex_property(obj, &s->conf.conf.bootindex,
+                                  "bootindex", "/disk@0,0",
+                                  DEVICE(obj), NULL);
+}
+
+static const TypeInfo virtio_nvme_info = {
+    .name          = TYPE_VIRTIO_NVME,
+    .parent        = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIONVME),
+    .class_init    = virtio_nvme_class_init,
+    .instance_init = virtio_nvme_instance_init,
+};
+
+static void virtio_nvme_register_types(void)
+{
+    type_register_static(&virtio_nvme_info);
+}
+
+type_init(virtio_nvme_register_types)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 283401a..596dfa1 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1682,6 +1682,47 @@ static const TypeInfo virtio_blk_pci_info = {
     .class_init    = virtio_blk_pci_class_init,
 };
 
+/* virtio-nvme-pci */
+
+static void virtio_nvme_pci_instance_init(Object *obj)
+{
+    VirtIONVMEPCI *dev = VIRTIO_NVME_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_NVME);
+}
+
+static void virtio_nvme_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIONVMEPCI *dev = VIRTIO_NVME_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_nvme_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    k->realize = virtio_nvme_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_NVME;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_EXPRESS;
+}
+
+static const TypeInfo virtio_nvme_pci_info = {
+    .name          = TYPE_VIRTIO_NVME_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIONVMEPCI),
+    .instance_init = virtio_nvme_pci_instance_init,
+    .class_init    = virtio_nvme_pci_class_init,
+};
+
 /* virtio-scsi-pci */
 
 static Property virtio_scsi_pci_properties[] = {
@@ -2233,6 +2274,7 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VHOST_SCSI
     type_register_static(&vhost_scsi_pci_info);
 #endif
+    type_register_static(&virtio_nvme_pci_info);
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index b6c442f..ff681a6 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -32,10 +32,12 @@
 #ifdef CONFIG_VHOST_SCSI
 #include "hw/virtio/vhost-scsi.h"
 #endif
+#include "hw/virtio/virtio-nvme.h"
 
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
 typedef struct VirtIOBlkPCI VirtIOBlkPCI;
 typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
+typedef struct VirtIONVMEPCI VirtIONVMEPCI;
 typedef struct VirtIOBalloonPCI VirtIOBalloonPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
@@ -179,6 +181,18 @@ struct VirtIOBlkPCI {
 };
 
 /*
+ * virtio-nvme-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_NVME_PCI "virtio-nvme-pci"
+#define VIRTIO_NVME_PCI(obj) \
+        OBJECT_CHECK(VirtIONVMEPCI, (obj), TYPE_VIRTIO_NVME_PCI)
+
+struct VirtIONVMEPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIONVME vdev;
+};
+
+/*
  * virtio-balloon-pci: This extends VirtioPCIProxy.
  */
 #define TYPE_VIRTIO_BALLOON_PCI "virtio-balloon-pci"
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 551cb3d..3e8d501 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -81,6 +81,7 @@
 #define PCI_DEVICE_ID_VIRTIO_SCSI        0x1004
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
+#define PCI_DEVICE_ID_VIRTIO_NVME        0x100a
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
diff --git a/include/hw/virtio/virtio-nvme.h b/include/hw/virtio/virtio-nvme.h
new file mode 100644
index 0000000..4cafddb
--- /dev/null
+++ b/include/hw/virtio/virtio-nvme.h
@@ -0,0 +1,60 @@
+#ifndef _QEMU_VIRTIO_NVME_H
+#define _QEMU_VIRTIO_NVME_H
+
+#include "standard-headers/linux/virtio_blk.h"
+#include "hw/virtio/virtio.h"
+#include "hw/block/block.h"
+#include "sysemu/iothread.h"
+#include "sysemu/block-backend.h"
+#include "hw/block/block.h"
+#include "hw/block/nvme.h"
+
+#define TYPE_VIRTIO_NVME "virtio-nvme"
+#define VIRTIO_NVME(obj) \
+        OBJECT_CHECK(VirtIONVME, (obj), TYPE_VIRTIO_NVME)
+
+struct VirtIONVMEConf {
+    BlockConf conf;
+    uint32_t num_queues;
+};
+
+typedef struct VirtIONVME {
+    VirtIODevice parent_obj;
+    BlockBackend *blk;
+    struct VirtIONVMEConf conf;
+
+    NvmeBar      bar;
+    VirtQueue *admin_vq;
+    VirtQueue **io_vqs;
+
+    uint32_t    page_size;
+    uint16_t    page_bits;
+    uint16_t    max_prp_ents;
+    uint16_t    cqe_size;
+    uint16_t    sqe_size;
+    uint32_t    reg_size;
+    uint32_t    num_namespaces;
+    uint32_t    max_q_ents;
+    uint64_t    ns_size;
+
+    char            *serial;
+    NvmeNamespace   *namespaces;
+    NvmeIdCtrl      id_ctrl;
+} VirtIONVME;
+
+struct virtio_nvme_resp {
+    uint32_t    result;
+    uint16_t    cid;
+    uint16_t    status;
+};
+
+typedef struct VirtIONVMEReq {
+    VirtIONVME *dev;
+    VirtQueue *vq;
+    VirtQueueElement elem;
+    struct NvmeCmd cmd;
+    QEMUIOVector qiov;
+    struct virtio_nvme_resp *resp;
+} VirtIONVMEReq;
+
+#endif
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 77925f5..d59d323 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -41,5 +41,6 @@
 #define VIRTIO_ID_CAIF	       12 /* Virtio caif */
 #define VIRTIO_ID_GPU          16 /* virtio GPU */
 #define VIRTIO_ID_INPUT        18 /* virtio input */
+#define VIRTIO_ID_NVME         19 /* TBD: virtio NVMe, need Redhat's help to get this id */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/standard-headers/linux/virtio_nvme.h b/include/standard-headers/linux/virtio_nvme.h
new file mode 100644
index 0000000..8cc896c
--- /dev/null
+++ b/include/standard-headers/linux/virtio_nvme.h
@@ -0,0 +1,16 @@
+#ifndef _LINUX_VIRTIO_NVME_H
+#define _LINUX_VIRTIO_NVME_H
+
+/* Feature bits */
+#define VIRTIO_NVME_F_SEG_MAX   1       /* Indicates maximum # of segments */
+#define VIRTIO_NVME_F_MQ        2       /* support more than one vq */
+
+struct virtio_nvme_config {
+        uint64_t   cap;
+        uint32_t   ctrl_config;
+        uint32_t   csts;
+        uint32_t   seg_max;
+        uint32_t   num_queues;
+} QEMU_PACKED;
+
+#endif
-- 
1.9.1
