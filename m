From: hare@suse.de (Hannes Reinecke)
Subject: [PATCH 2/4] megasas: LSI MegaRAID SAS HBA emulation
Date: Tue, 27 Oct 2009 16:28:49 +0100
Message-ID: <20091027152849.F37C439742__28807.6435252608$1256657794$gmane$org@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


This patch add an emulation for the LSI MegaRAID SAS HBA. It is
using SG_IO to forward / pass through SCSI commands to the
underlying block driver, so no emulation is done currently.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 Makefile.hw  |    2 +-
 hw/megasas.c | 1134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/pci_ids.h |    2 +
 3 files changed, 1137 insertions(+), 1 deletions(-)
 create mode 100644 hw/megasas.c

diff --git a/Makefile.hw b/Makefile.hw
index de1db31..cae35f9 100644
--- a/Makefile.hw
+++ b/Makefile.hw
@@ -33,7 +33,7 @@ obj-y += wdt_i6300esb.o
 obj-y += ne2000.o
 
 # SCSI layer
-obj-y += lsi53c895a.o
+obj-y += lsi53c895a.o megasas.o
 obj-$(CONFIG_ESP) += esp.o
 
 obj-y += dma-helpers.o sysbus.o isa-bus.o
diff --git a/hw/megasas.c b/hw/megasas.c
new file mode 100644
index 0000000..a57e8e0
--- /dev/null
+++ b/hw/megasas.c
@@ -0,0 +1,1134 @@
+/*
+ * QEMU MegaRAID SAS 8708EM2 Host Bus Adapter emulation
+ *
+ * Copyright (c) 2009 Hannes Reinecke, SUSE Linux Products GmbH
+ *
+ * This code is licenced under the LGPL.
+ */
+
+
+#include <assert.h>
+
+#include "hw.h"
+#include "pci.h"
+#include "scsi.h"
+#include "scsi-disk.h"
+#include "block_int.h"
+#ifdef __linux__
+# include <scsi/sg.h>
+#endif
+
+#undef DEBUG_MEGASAS
+#undef DEBUG_MEGASAS_REG
+#undef DEBUG_MEGASAS_QUEUE
+#undef DEBUG_MEGASAS_MFI
+
+#ifdef DEBUG_MEGASAS
+#define DPRINTF(fmt, ...) \
+do { printf("megasas: " fmt , ## __VA_ARGS__); } while (0)
+#define BADF(fmt, ...) \
+do { fprintf(stderr, "megasas: error: " fmt , ## __VA_ARGS__); exit(1);} while (0)
+#else
+#define DPRINTF(fmt, ...) do {} while(0)
+#define BADF(fmt, ...) \
+do { fprintf(stderr, "megasas: error: " fmt , ## __VA_ARGS__);} while (0)
+#endif
+
+/* Static definitions */
+#define MEGASAS_MAX_FRAMES 64
+#define MEGASAS_MAX_SGE 8
+
+/* SCSI definitions */
+#define SAM_STAT_GOOD            0x00
+#define SAM_STAT_CHECK_CONDITION 0x02
+#define SAM_STAT_CONDITION_MET   0x04
+#define SAM_STAT_BUSY            0x08
+#define SAM_STAT_TASK_ABORTED    0x40
+
+/* Register definitions */
+#define	MEGASAS_INBOUND_MSG_0			0x0010
+#define	MEGASAS_INBOUND_MSG_1			0x0014
+#define	MEGASAS_OUTBOUND_MSG_0			0x0018
+#define	MEGASAS_OUTBOUND_MSG_1			0x001C
+#define	MEGASAS_INBOUND_DOORBELL		0x0020
+#define	MEGASAS_INBOUND_INTR_STATUS		0x0024
+#define	MEGASAS_INBOUND_INTR_MASK		0x0028
+#define	MEGASAS_OUTBOUND_DOORBELL		0x002C
+#define	MEGASAS_OUTBOUND_INTR_STATUS		0x0030
+#define	MEGASAS_OUTBOUND_INTR_MASK		0x0034
+#define	MEGASAS_INBOUND_QUEUE_PORT		0x0040
+#define	MEGASAS_OUTBOUND_QUEUE_PORT		0x0044
+#define	MEGASAS_OUTBOUND_DOORBELL_CLEAR		0x00A0
+#define	MEGASAS_OUTBOUND_SCRATCH_PAD		0x00B0
+#define	MEGASAS_INBOUND_LOW_QUEUE_PORT		0x00C0
+#define	MEGASAS_INBOUND_HIGH_QUEUE_PORT		0x00C4
+
+/* FW commands */
+#define MFI_INIT_ABORT				0x00000001
+#define MFI_INIT_READY				0x00000002
+#define MFI_INIT_MFIMODE			0x00000004
+#define MFI_INIT_CLEAR_HANDSHAKE		0x00000008
+#define MFI_INIT_HOTPLUG			0x00000010
+#define MFI_STOP_ADP				0x00000020
+
+/* MFI states */
+#define MFI_STATE_UNDEFINED			0x0
+#define MFI_STATE_BB_INIT			0x1
+#define MFI_STATE_FW_INIT			0x4
+#define MFI_STATE_WAIT_HANDSHAKE		0x6
+#define MFI_STATE_FW_INIT_2			0x7
+#define MFI_STATE_DEVICE_SCAN			0x8
+#define MFI_STATE_BOOT_MESSAGE_PENDING		0x9
+#define MFI_STATE_FLUSH_CACHE			0xA
+#define MFI_STATE_READY				0xB
+#define MFI_STATE_OPERATIONAL			0xC
+#define MFI_STATE_FAULT				0xF
+
+/*
+ * MFI command opcodes
+ */
+#define MFI_CMD_INIT				0x00
+#define MFI_CMD_LD_READ				0x01
+#define MFI_CMD_LD_WRITE			0x02
+#define MFI_CMD_LD_SCSI_IO			0x03
+#define MFI_CMD_PD_SCSI_IO			0x04
+#define MFI_CMD_DCMD				0x05
+#define MFI_CMD_ABORT				0x06
+#define MFI_CMD_SMP				0x07
+#define MFI_CMD_STP				0x08
+
+#define MR_DCMD_CTRL_GET_INFO			0x01010000
+
+#define MR_DCMD_CTRL_CACHE_FLUSH		0x01101000
+#define MR_FLUSH_CTRL_CACHE			0x01
+#define MR_FLUSH_DISK_CACHE			0x02
+
+#define MR_DCMD_CTRL_SHUTDOWN			0x01050000
+#define MR_DCMD_HIBERNATE_SHUTDOWN		0x01060000
+#define MR_ENABLE_DRIVE_SPINDOWN		0x01
+
+#define MR_DCMD_CTRL_EVENT_GET_INFO		0x01040100
+#define MR_DCMD_CTRL_EVENT_GET			0x01040300
+#define MR_DCMD_CTRL_EVENT_WAIT			0x01040500
+#define MR_DCMD_LD_GET_PROPERTIES		0x03030000
+
+#define MR_DCMD_CLUSTER				0x08000000
+#define MR_DCMD_CLUSTER_RESET_ALL		0x08010100
+#define MR_DCMD_CLUSTER_RESET_LD		0x08010200
+#define MR_DCMD_PD_LIST_QUERY			0x02010100
+
+/*
+ * MFI frame flags
+ */
+#define MFI_FRAME_POST_IN_REPLY_QUEUE		0x0000
+#define MFI_FRAME_DONT_POST_IN_REPLY_QUEUE	0x0001
+#define MFI_FRAME_SGL32				0x0000
+#define MFI_FRAME_SGL64				0x0002
+#define MFI_FRAME_SENSE32			0x0000
+#define MFI_FRAME_SENSE64			0x0004
+#define MFI_FRAME_DIR_NONE			0x0000
+#define MFI_FRAME_DIR_WRITE			0x0008
+#define MFI_FRAME_DIR_READ			0x0010
+#define MFI_FRAME_DIR_BOTH			0x0018
+#define MFI_REPLY_1078_MESSAGE_INTERRUPT	0x80000000
+
+/*
+ * MFI command completion codes
+ */
+enum MFI_STAT {
+	MFI_STAT_OK = 0x00,
+	MFI_STAT_INVALID_CMD = 0x01,
+	MFI_STAT_INVALID_DCMD = 0x02,
+	MFI_STAT_INVALID_PARAMETER = 0x03,
+	MFI_STAT_INVALID_SEQUENCE_NUMBER = 0x04,
+	MFI_STAT_ABORT_NOT_POSSIBLE = 0x05,
+	MFI_STAT_APP_HOST_CODE_NOT_FOUND = 0x06,
+	MFI_STAT_APP_IN_USE = 0x07,
+	MFI_STAT_APP_NOT_INITIALIZED = 0x08,
+	MFI_STAT_ARRAY_INDEX_INVALID = 0x09,
+	MFI_STAT_ARRAY_ROW_NOT_EMPTY = 0x0a,
+	MFI_STAT_CONFIG_RESOURCE_CONFLICT = 0x0b,
+	MFI_STAT_DEVICE_NOT_FOUND = 0x0c,
+	MFI_STAT_DRIVE_TOO_SMALL = 0x0d,
+	MFI_STAT_FLASH_ALLOC_FAIL = 0x0e,
+	MFI_STAT_FLASH_BUSY = 0x0f,
+	MFI_STAT_FLASH_ERROR = 0x10,
+	MFI_STAT_FLASH_IMAGE_BAD = 0x11,
+	MFI_STAT_FLASH_IMAGE_INCOMPLETE = 0x12,
+	MFI_STAT_FLASH_NOT_OPEN = 0x13,
+	MFI_STAT_FLASH_NOT_STARTED = 0x14,
+	MFI_STAT_FLUSH_FAILED = 0x15,
+	MFI_STAT_HOST_CODE_NOT_FOUNT = 0x16,
+	MFI_STAT_LD_CC_IN_PROGRESS = 0x17,
+	MFI_STAT_LD_INIT_IN_PROGRESS = 0x18,
+	MFI_STAT_LD_LBA_OUT_OF_RANGE = 0x19,
+	MFI_STAT_LD_MAX_CONFIGURED = 0x1a,
+	MFI_STAT_LD_NOT_OPTIMAL = 0x1b,
+	MFI_STAT_LD_RBLD_IN_PROGRESS = 0x1c,
+	MFI_STAT_LD_RECON_IN_PROGRESS = 0x1d,
+	MFI_STAT_LD_WRONG_RAID_LEVEL = 0x1e,
+	MFI_STAT_MAX_SPARES_EXCEEDED = 0x1f,
+	MFI_STAT_MEMORY_NOT_AVAILABLE = 0x20,
+	MFI_STAT_MFC_HW_ERROR = 0x21,
+	MFI_STAT_NO_HW_PRESENT = 0x22,
+	MFI_STAT_NOT_FOUND = 0x23,
+	MFI_STAT_NOT_IN_ENCL = 0x24,
+	MFI_STAT_PD_CLEAR_IN_PROGRESS = 0x25,
+	MFI_STAT_PD_TYPE_WRONG = 0x26,
+	MFI_STAT_PR_DISABLED = 0x27,
+	MFI_STAT_ROW_INDEX_INVALID = 0x28,
+	MFI_STAT_SAS_CONFIG_INVALID_ACTION = 0x29,
+	MFI_STAT_SAS_CONFIG_INVALID_DATA = 0x2a,
+	MFI_STAT_SAS_CONFIG_INVALID_PAGE = 0x2b,
+	MFI_STAT_SAS_CONFIG_INVALID_TYPE = 0x2c,
+	MFI_STAT_SCSI_DONE_WITH_ERROR = 0x2d,
+	MFI_STAT_SCSI_IO_FAILED = 0x2e,
+	MFI_STAT_SCSI_RESERVATION_CONFLICT = 0x2f,
+	MFI_STAT_SHUTDOWN_FAILED = 0x30,
+	MFI_STAT_TIME_NOT_SET = 0x31,
+	MFI_STAT_WRONG_STATE = 0x32,
+	MFI_STAT_LD_OFFLINE = 0x33,
+	MFI_STAT_PEER_NOTIFICATION_REJECTED = 0x34,
+	MFI_STAT_PEER_NOTIFICATION_FAILED = 0x35,
+	MFI_STAT_RESERVATION_IN_PROGRESS = 0x36,
+	MFI_STAT_I2C_ERRORS_DETECTED = 0x37,
+	MFI_STAT_PCI_ERRORS_DETECTED = 0x38,
+
+	MFI_STAT_INVALID_STATUS = 0xFF
+};
+
+#define MEGASAS_FRAME_CMD_OFFSET		0x00
+#define MEGASAS_FRAME_SENSE_LEN_OFFSET		0x01
+#define MEGASAS_FRAME_CMD_STATUS_OFFSET		0x02
+#define MEGASAS_FRAME_SCSI_STATUS_OFFSET	0x03
+#define MEGASAS_FRAME_TARGET_ID_OFFSET		0x04
+#define MEGASAS_FRAME_LUN_ID_OFFSET		0x05
+#define MEGASAS_FRAME_CDB_LEN_OFFSET		0x06
+#define MEGASAS_FRAME_SGE_COUNT_OFFSET		0x07
+#define MEGASAS_FRAME_CONTEXT_OFFSET		0x08
+#define MEGASAS_FRAME_FLAGS_OFFSET		0x10
+#define MEGASAS_FRAME_XFER_LEN_OFFSET		0x14
+
+#define MEGASAS_INIT_NEW_PHYS_ADDR_LO_OFFSET	0x18
+#define MEGASAS_INIT_NEW_PHYS_ADDR_HI_OFFSET	0x1C
+
+#define MEGASAS_INITQ_REPLY_Q_LEN_OFFSET	0x04
+#define MEGASAS_INITQ_REPLY_Q_ADDR_LO_OFFSET	0x08
+#define MEGASAS_INITQ_REPLY_Q_ADDR_HI_OFFSET	0x0C
+#define MEGASAS_INITQ_PRODUCER_ADDR_LO_OFFSET	0x10
+#define MEGASAS_INITQ_PRODUCER_ADDR_HI_OFFSET	0x14
+#define MEGASAS_INITQ_CONSUMER_ADDR_LO_OFFSET	0x18
+#define MEGASAS_INITQ_CONSUMER_ADDR_HI_OFFSET	0x1C
+
+#define MEGASAS_DCMD_OPCODE_OFFSET		0x18
+
+#define MEGASAS_PTHRU_SENSE_ADDR_LO_OFFSET	0x18
+#define MEGASAS_PTHRU_SENSE_ADDR_HI_OFFSET	0x1C
+#define MEGASAS_PTHRU_CDB_OFFSET		0x20
+#define MEGASAS_PTHRU_SGL_OFFSET		0x30
+
+#define MEGASAS_IO_TIMEOUT_OFFSET		0x12
+#define MEGASAS_IO_LBA_COUNT_OFFSET		0x14
+#define MEGASAS_IO_SENSE_BUFF_ADDR_LO_OFFSET	0x18
+#define MEGASAS_IO_SENSE_BUFF_ADDR_HI_OFFSET	0x1C
+#define MEGASAS_IO_START_LBA_LO_OFFSET		0x20
+#define MEGASAS_IO_START_LBA_HI_OFFSET		0x24
+#define MEGASAS_IO_SGL_OFFSET			0x28
+
+struct megasas_lun_t {
+    SCSIDevice *sdev;
+    BlockDriverState *bdrv;
+    BlockDriverAIOCB *aiocb;
+};
+
+struct megasas_cmd_t {
+    int index;
+
+    uint32_t context;
+    target_phys_addr_t pa;
+    uint16_t flags;
+    uint8_t sge_count;
+    uint32_t sge_size;
+    uint8_t *sense;
+    uint8_t sense_len;
+    struct iovec iov[MEGASAS_MAX_SGE];
+    QEMUIOVector qiov;
+    struct sg_io_hdr hdr;
+
+    struct megasas_state_t *state;
+    struct megasas_lun_t *lun;
+};
+
+typedef struct megasas_state_t {
+    PCIDevice dev;
+    int mmio_io_addr;
+
+    int fw_state;
+    int fw_sge;
+    int fw_cmds;
+    int intr_mask;
+    int doorbell;
+
+    target_phys_addr_t reply_queue_pa;
+    void *reply_queue;
+    int reply_queue_len;
+    target_phys_addr_t consumer_pa;
+    target_phys_addr_t producer_pa;
+
+    struct megasas_cmd_t frames[MEGASAS_MAX_FRAMES];
+    struct megasas_cmd_t *next_fw_cmd;
+
+    struct megasas_lun_t luns[MAX_RAID_DEVS];
+
+    SCSIBus bus;
+} MPTState;
+
+#define MEGASAS_INTR_DISABLED_MASK 0xFFFFFFFF
+
+#define MEGASAS_INTR_ENABLED(s) (((s)->intr_mask & MEGASAS_INTR_DISABLED_MASK ) != MEGASAS_INTR_DISABLED_MASK)
+
+#define megasas_frame_get(f,o)			\
+    ldub_phys((f) + MEGASAS_FRAME_ ## o ## _OFFSET);
+
+#define megasas_frame_get_cmd_status(f)		\
+    ldub_phys((f) + MEGASAS_FRAME_CMD_STATUS_OFFSET);
+
+#define megasas_frame_set_cmd_status(f,v)		\
+    stb_phys((f) + MEGASAS_FRAME_CMD_STATUS_OFFSET, v);
+
+#define megasas_frame_get_sense_len(f)		\
+    ldub_phys((f) + MEGASAS_FRAME_SENSE_LEN_OFFSET);
+
+#define megasas_frame_set_sense_len(f,v)		\
+    stb_phys((f) + MEGASAS_FRAME_SENSE_LEN_OFFSET, v);
+
+#define megasas_frame_set_scsi_status(f,v)		\
+    stb_phys((f) + MEGASAS_FRAME_SCSI_STATUS_OFFSET, v);
+
+#define megasas_frame_get_flags(f)			\
+    lduw_phys((f) + MEGASAS_FRAME_FLAGS_OFFSET);
+
+#define megasas_frame_get_sgecount(f)			\
+    lduw_phys((f) + MEGASAS_FRAME_SGE_COUNT_OFFSET);
+
+static void megasas_soft_reset(MPTState *s);
+
+static void megasas_map_sgl(struct megasas_cmd_t *cmd, int offset, int dir)
+{
+    int i;
+    int is_sgl64 = (cmd->flags & MFI_FRAME_SGL64) ? 1 : 0;
+    int sgl_addr_size = is_sgl64 ? sizeof(uint64_t) : sizeof(uint32_t);
+
+    for (i = 0; i < cmd->sge_count; i++) {
+	target_phys_addr_t pa, iov_pa;
+
+	pa = cmd->pa + offset;
+	if (is_sgl64)
+	    iov_pa = ldq_phys(pa);
+	else
+	    iov_pa = ldl_phys(pa);
+	cmd->iov[i].iov_len = ldl_phys(pa + sgl_addr_size);
+	cmd->iov[i].iov_base = cpu_physical_memory_map(iov_pa,
+						       &cmd->iov[i].iov_len,
+						       dir);
+	offset += sgl_addr_size + sizeof(uint32_t);
+    }
+}
+
+static void megasas_unmap_sgl(struct megasas_cmd_t *cmd)
+{
+    int dir = (cmd->flags & MFI_FRAME_DIR_WRITE) ? 1 : 0;
+    int i, offset = 0;
+
+    for (i = 0; i < cmd->sge_count; i++) {
+	size_t size = MIN(cmd->sge_size - offset, cmd->iov[i].iov_len);
+
+	cpu_physical_memory_unmap(cmd->iov[i].iov_base, cmd->iov[i].iov_len,
+				  dir, size);
+	offset += cmd->iov[i].iov_len;
+	cmd->iov[i].iov_len = 0;
+	cmd->iov[i].iov_base = NULL;
+    }
+}
+
+static void megasas_map_sense(struct megasas_cmd_t *cmd)
+{
+    target_phys_addr_t pa_lo, pa_hi;
+
+    pa_lo = ldl_phys(cmd->pa + MEGASAS_PTHRU_SENSE_ADDR_LO_OFFSET);
+    pa_hi = ldl_phys(cmd->pa + MEGASAS_PTHRU_SENSE_ADDR_HI_OFFSET);
+    cmd->sense_len = megasas_frame_get_sense_len(cmd->pa);
+    cmd->sense = cpu_physical_memory_map((pa_hi << 32) | pa_lo,
+					 (target_phys_addr_t *)&cmd->sense_len, 1);
+}
+
+static void megasas_unmap_sense(struct megasas_cmd_t *cmd, int sense_len)
+{
+    if (cmd->sense) {
+	cpu_physical_memory_unmap(cmd->sense, cmd->sense_len, 1, sense_len);
+	megasas_frame_set_sense_len(cmd->pa, sense_len);
+    }
+}
+
+/*
+ * Frame handling
+ */
+
+static inline struct megasas_cmd_t *
+megasas_get_next_frame(MPTState *s, int index)
+{
+    struct megasas_cmd_t *cmd;
+
+    if (index == (s->fw_cmds - 1))
+	cmd = &s->frames[0];
+    else
+	cmd = s->next_fw_cmd + 1;
+
+    return cmd;
+}
+
+/*
+ * megasas_check_queue_full
+ *
+ * Check if the host frame queue is full.
+ * We always have an empty frame between
+ * the 'next' frame (as indicated by s->next_fw_cmd)
+ * and the tail of the reply queue.
+ * This enables us to always terminate a command
+ * with the proper SAM_STAT_BUSY status.
+ */
+static inline int
+megasas_check_queue_full(MPTState *s)
+{
+    int tail;
+    struct megasas_cmd_t *cmd;
+
+    tail = ldl_phys(s->consumer_pa);
+    cmd = megasas_get_next_frame(s, s->next_fw_cmd->index);
+
+    return (cmd->index == tail);
+}
+
+static struct megasas_cmd_t *
+megasas_enqueue_frame(MPTState *s, target_phys_addr_t frame)
+{
+#ifdef DEBUG_MEGASAS_QUEUE
+    int head = 0, tail = 0;
+#endif
+    struct megasas_cmd_t *cmd = s->next_fw_cmd;
+
+    /* Classical 'this shouldn't happen' check */
+    if (cmd->pa)
+	BADF("Frame %d still active\n", cmd->index);
+
+    cmd->pa = frame;
+    cmd->context = ldl_phys(cmd->pa + MEGASAS_FRAME_CONTEXT_OFFSET);
+    s->next_fw_cmd = megasas_get_next_frame(s, cmd->index);
+
+#ifdef DEBUG_MEGASAS_QUEUE
+    tail = ldl_phys(s->consumer_pa);
+    head = ldl_phys(s->producer_pa);
+
+    DPRINTF("Enqueue frame %d to reply queue, head %d tail %d next %d\n",
+	    cmd->index, head, tail, s->next_fw_cmd->index);
+#endif
+
+    return cmd;
+}
+
+static void megasas_dequeue_frame(MPTState *s, struct megasas_cmd_t *cmd)
+{
+    int head, tail, index, cmds_active = 0, cmds_deferred = 0, num = 0;
+#ifdef DEBUG_MEGASAS_QUEUE
+    uint8_t status;
+#endif
+
+    if (!cmd) {
+#ifdef DEBUG_MEGASAS_QUEUE
+	DPRINTF("No frame to complete\n");
+#endif
+	return;
+    }
+    tail = index = ldl_phys(s->producer_pa);
+    head = s->next_fw_cmd->index;
+    /* check outstanding cmds */
+    while (index != head && num < MEGASAS_MAX_FRAMES) {
+	if (index == cmd->index) {
+	    cmds_deferred = cmds_active;
+	    cmds_active = 0;
+	} else if(s->frames[index].pa)
+	    cmds_active++;
+
+	index++;
+	if (index == s->fw_cmds)
+	    index = 0;
+	num++;
+    }
+
+#ifdef DEBUG_MEGASAS_QUEUE
+    status = megasas_frame_get_cmd_status(cmd->pa);
+    DPRINTF("Complete frame %d: context %x status %x deferred %d active %d\n",
+	    cmd->index, cmd->context, status, cmds_deferred,
+	    cmds_active);
+#endif
+    stl_phys(s->reply_queue_pa + cmd->index * sizeof(uint32_t), cmd->context);
+
+    /* Free up command */
+    if (cmd->sge_count) {
+	megasas_unmap_sgl(cmd);
+	cmd->sge_count = 0;
+	cmd->sge_size = 0;
+    }
+    cmd->context = 0;
+    cmd->pa = 0;
+    cmd->lun = NULL;
+
+    /*
+     * If there are outstanding deferred commands
+     * (ie commands with a lower index that ours)
+     * do now acknowledge this.
+     */
+    if (cmds_deferred)
+	return;
+
+    /* Update reply queue pointer and notify HBA */
+    if (MEGASAS_INTR_ENABLED(s)) {
+	/* Do not acknowledge outstanding commands */
+	if (cmds_active)
+	    head = (cmd->index + 1) & 0x3F;
+#ifdef DEBUG_MEGASAS_QUEUE
+	DPRINTF("Update reply queue head %d this %d tail %d\n",
+		head, cmd->index, tail);
+#endif
+	stl_phys(s->producer_pa, head);
+	s->doorbell++;
+	qemu_irq_raise(s->dev.irq[0]);
+    } else {
+	/* Reset fw command pointer */
+	s->next_fw_cmd = cmd;
+    }
+}
+
+static void megasas_abort_command(struct megasas_cmd_t *cmd)
+{
+    if (cmd->lun && cmd->lun->aiocb) {
+	bdrv_aio_cancel(cmd->lun->aiocb);
+	cmd->lun->aiocb = NULL;
+    }
+}
+
+static int megasas_init_firmware(MPTState *s, target_phys_addr_t frame_addr)
+{
+    target_phys_addr_t iq_pa, iq_pl, pa_hi, pa_lo;
+
+    iq_pl = ldl_phys(frame_addr + MEGASAS_FRAME_XFER_LEN_OFFSET);
+    pa_lo = frame_addr + MEGASAS_INIT_NEW_PHYS_ADDR_LO_OFFSET;
+    pa_hi = frame_addr + MEGASAS_INIT_NEW_PHYS_ADDR_HI_OFFSET;
+    iq_pa = ((uint64_t)ldl_phys(pa_hi) << 32) | ldl_phys(pa_lo);
+#ifdef DEBUG_MEGASAS_MFI
+    DPRINTF("MFI init firmware: xfer len %d pa %lx\n", (int)iq_pl,
+	    (unsigned long)iq_pa);
+#endif
+    s->reply_queue_len = ldl_phys(iq_pa + MEGASAS_INITQ_REPLY_Q_LEN_OFFSET);
+    pa_lo = iq_pa + MEGASAS_INITQ_REPLY_Q_ADDR_LO_OFFSET;
+    pa_hi = iq_pa + MEGASAS_INITQ_REPLY_Q_ADDR_HI_OFFSET;
+    s->reply_queue_pa = ((uint64_t)ldl_phys(pa_hi) << 32) | ldl_phys(pa_lo);
+    pa_lo = iq_pa + MEGASAS_INITQ_CONSUMER_ADDR_LO_OFFSET;
+    pa_hi = iq_pa + MEGASAS_INITQ_CONSUMER_ADDR_HI_OFFSET;
+    s->consumer_pa = ((uint64_t)ldl_phys(pa_hi) << 32) | ldl_phys(pa_lo);
+    pa_lo = iq_pa + MEGASAS_INITQ_PRODUCER_ADDR_LO_OFFSET;
+    pa_hi = iq_pa + MEGASAS_INITQ_PRODUCER_ADDR_HI_OFFSET;
+    s->producer_pa = ((uint64_t)ldl_phys(pa_hi) << 32) | ldl_phys(pa_lo);
+#ifdef DEBUG_MEGASAS_MFI
+    DPRINTF("MFI init firmware: queue at %lx len %d head %lx tail %lx\n",
+	    (unsigned long)s->reply_queue_pa, s->reply_queue_len,
+	    (unsigned long)s->producer_pa, (unsigned long)s->consumer_pa);
+#endif
+    s->fw_state = MFI_STATE_OPERATIONAL;
+    return 0;
+}
+
+static int megasas_handle_doorcmd(MPTState *s, target_phys_addr_t frame_addr)
+{
+    int opcode;
+    uint8_t sg_count;
+    int retval = 0;
+
+    opcode = ldl_phys(frame_addr + MEGASAS_DCMD_OPCODE_OFFSET);
+    sg_count = ldub_phys(frame_addr + MEGASAS_FRAME_SGE_COUNT_OFFSET);
+#ifdef DEBUG_MEGASAS_MFI
+    DPRINTF("MFI DCMD opcode %x sg_count %d\n", opcode, sg_count);
+#endif
+    switch (opcode) {
+	case MR_DCMD_PD_LIST_QUERY:
+#ifdef DEBUG_MEGASAS_MFI
+	    DPRINTF("MFI DCMD query physical devices\n");
+#endif
+	    retval = MFI_STAT_INVALID_DCMD;
+	    break;
+	case MR_DCMD_CTRL_CACHE_FLUSH:
+#ifdef DEBUG_MEGASAS_MFI
+	    DPRINTF("MFI DCMD Cache flush\n");
+#endif
+	    qemu_aio_flush();
+	    retval = MFI_STAT_OK;
+	    break;
+	case MR_DCMD_CTRL_SHUTDOWN:
+#ifdef DEBUG_MEGASAS_MFI
+	    DPRINTF("MFI DCMD Controller shutdown\n");
+#endif
+	    s->fw_state = MFI_STATE_READY;
+	    retval = MFI_STAT_OK;
+	    break;
+	default:
+	    retval = MFI_STAT_INVALID_DCMD;
+	    break;
+    }
+    return retval;
+}
+
+static int megasas_handle_scsi(MPTState *s, uint8_t fcmd,
+			       struct megasas_cmd_t *cmd)
+{
+    uint8_t target, lun, cdb_len, sense_len;
+    uint8_t cdb[16], cmd_status = MFI_STAT_INVALID_STATUS;
+    uint8_t scsi_status = SAM_STAT_GOOD;
+    int n, dir, ret;
+
+    target = megasas_frame_get(cmd->pa, TARGET_ID);
+    lun = megasas_frame_get(cmd->pa, LUN_ID);
+    cmd->flags = megasas_frame_get_flags(cmd->pa);
+    cmd->sge_count = megasas_frame_get_sgecount(cmd->pa);
+    cdb_len = megasas_frame_get(cmd->pa, CDB_LEN);
+    megasas_map_sense(cmd);
+
+    if (cdb_len > 16) {
+	DPRINTF("SCSI %s dev %x/%x invalid cdb len %d\n",
+		(fcmd == MFI_CMD_PD_SCSI_IO) ? "PD" : "LD",
+		target, lun, cdb_len);
+	sense_len = scsi_build_sense(cmd->sense, SENSE_INVALID_OPCODE);
+	megasas_unmap_sense(cmd, sense_len);
+	megasas_frame_set_scsi_status(cmd->pa, SAM_STAT_CHECK_CONDITION);
+	return MFI_STAT_SCSI_DONE_WITH_ERROR;
+    }
+
+    cpu_physical_memory_read(cmd->pa + 0x20, (uint8_t *)cdb, 16);
+
+    /* The current Qemu infrastructure allows only for LUN 0 */
+    if (lun == 0 && target < MAX_RAID_DEVS)
+	cmd->lun = &s->luns[target];
+
+    DPRINTF("SCSI %s dev %x lun %x sdev %p\n",
+	    (fcmd == MFI_CMD_PD_SCSI_IO) ? "PD" : "LD",
+	    target, lun, cmd->lun);
+    DPRINTF("SCSI %s len %d cdb %02x %02x %02x %02x %02x %02x\n",
+	    (fcmd == MFI_CMD_PD_SCSI_IO) ? "PD" : "LD",
+	    cdb_len, cdb[0], cdb[1], cdb[2], cdb[3], cdb[4], cdb[5]);
+
+    if (!cmd->lun || !cmd->lun->sdev) {
+	megasas_unmap_sense(cmd, 0);
+	return MFI_STAT_DEVICE_NOT_FOUND;
+    }
+
+    dir = (cmd->flags & MFI_FRAME_DIR_WRITE) ? 1 : 0;
+    megasas_map_sgl(cmd, MEGASAS_PTHRU_SGL_OFFSET, dir);
+
+    /* Internally emulated commands */
+    switch (cdb[0]) {
+    case 0x35:
+        DPRINTF("Synchronise cache\n");
+        bdrv_flush(cmd->lun->bdrv);
+	sense_len = 0;
+	goto out;
+        break;
+    case 0xa0:
+    {
+	uint8_t *outbuf;
+
+	DPRINTF("Report LUNs (len %d)\n", (int)cmd->iov[0].iov_len);
+	if (cmd->iov[0].iov_len < 16) {
+	    sense_len = scsi_build_sense(cmd->sense, SENSE_INVALID_FIELD);
+	    scsi_status = SAM_STAT_CHECK_CONDITION;
+            goto out;
+	}
+	outbuf = cmd->iov[0].iov_base;
+        memset(outbuf, 0, 16);
+        outbuf[3] = 8;
+        cmd->iov[0].iov_len = 16;
+	sense_len = 0;
+	goto out;
+        break;
+    }
+    }
+
+    memset(&cmd->hdr, 0, sizeof(struct sg_io_hdr));
+    cmd->hdr.interface_id = 'S';
+    cmd->hdr.cmd_len = cdb_len;
+    cmd->hdr.cmdp = cdb;
+    cmd->hdr.iovec_count = cmd->sge_count;
+    cmd->hdr.dxferp = cmd->iov;
+    for (n = 0; n < cmd->sge_count; n++)
+	cmd->hdr.dxfer_len += cmd->iov[n].iov_len;
+    if (cmd->sge_count) {
+	if (dir)
+	    cmd->hdr.dxfer_direction = SG_DXFER_TO_DEV;
+	else
+	    cmd->hdr.dxfer_direction = SG_DXFER_FROM_DEV;
+    } else {
+	cmd->hdr.dxfer_direction = SG_DXFER_NONE;
+    }
+    cmd->hdr.sbp = cmd->sense;
+    cmd->hdr.mx_sb_len = cmd->sense_len;
+
+    ret = bdrv_ioctl(cmd->lun->bdrv, SG_IO, &cmd->hdr);
+    if (ret) {
+	DPRINTF("SCSI pthru dev %x lun %x failed with %d\n",
+		target, lun, errno);
+	sense_len = scsi_build_sense(cmd->sense, SENSE_IO_ERROR);
+	cmd->sge_size = 0;
+	scsi_status = SAM_STAT_CHECK_CONDITION;
+    } else if (cmd->hdr.status) {
+	sense_len = cmd->hdr.sb_len_wr;
+	scsi_status = cmd->hdr.status;
+	cmd->sge_size = cmd->hdr.dxfer_len;
+	scsi_status = SAM_STAT_CHECK_CONDITION;
+    } else {
+	sense_len = 0;
+	cmd->sge_size = cmd->hdr.dxfer_len;
+    }
+out:
+    megasas_unmap_sense(cmd, sense_len);
+    if (scsi_status != SAM_STAT_GOOD) {
+	megasas_frame_set_scsi_status(cmd->pa, scsi_status);
+	cmd_status = MFI_STAT_SCSI_DONE_WITH_ERROR;
+    } else {
+	megasas_frame_set_scsi_status(cmd->pa, SAM_STAT_GOOD);
+	cmd_status = MFI_STAT_OK;
+    }
+    return cmd_status;
+}
+
+static void megasas_read_complete(void * opaque, int ret)
+{
+    struct megasas_cmd_t *cmd = opaque;
+    uint8_t cmd_status, scsi_status;
+
+    if (ret) {
+	DPRINTF("SCSI LD read error %x\n", ret);
+	cmd->sense_len = scsi_build_sense(cmd->sense, 0x040006);
+	cmd_status = MFI_STAT_SCSI_DONE_WITH_ERROR;
+	scsi_status = SAM_STAT_CHECK_CONDITION;
+    } else {
+	DPRINTF("SCSI LD read finished, len %ld\n",
+		(unsigned long)cmd->qiov.size);
+	cmd_status = MFI_STAT_OK;
+	scsi_status = SAM_STAT_GOOD;
+    }
+
+    cmd->sge_size = cmd->qiov.size;
+
+    megasas_frame_set_scsi_status(cmd->pa, scsi_status);
+    megasas_frame_set_cmd_status(cmd->pa, cmd_status);
+    megasas_dequeue_frame(cmd->state, cmd);
+}
+
+static void megasas_write_complete(void * opaque, int ret)
+{
+    struct megasas_cmd_t *cmd = opaque;
+    uint8_t cmd_status, scsi_status;
+
+    if (ret) {
+	DPRINTF("SCSI LD write error %x\n", ret);
+	cmd_status = MFI_STAT_SCSI_DONE_WITH_ERROR;
+	scsi_status = SAM_STAT_CHECK_CONDITION;
+    } else {
+	DPRINTF("SCSI LD write finished, len %ld\n",
+		(unsigned long)cmd->qiov.size);
+	cmd_status = MFI_STAT_OK;
+	scsi_status = SAM_STAT_GOOD;
+    }
+
+    cmd->sge_size = cmd->qiov.size;
+
+    megasas_frame_set_scsi_status(cmd->pa, scsi_status);
+    megasas_frame_set_cmd_status(cmd->pa, cmd_status);
+    megasas_dequeue_frame(cmd->state, cmd);
+}
+
+static int megasas_handle_io(MPTState *s, struct megasas_cmd_t *cmd, int write)
+{
+    uint32_t lba_count, lba_start_hi, lba_start_lo;
+    uint64_t lba_start;
+    int target, lun;
+
+    target = megasas_frame_get(cmd->pa, TARGET_ID);
+    lun = megasas_frame_get(cmd->pa, LUN_ID);
+    cmd->flags = megasas_frame_get_flags(cmd->pa);
+    cmd->sge_count = megasas_frame_get_sgecount(cmd->pa);
+
+    lba_count = ldl_phys(cmd->pa + MEGASAS_IO_LBA_COUNT_OFFSET);
+    lba_start_lo = ldl_phys(cmd->pa + MEGASAS_IO_START_LBA_LO_OFFSET);
+    lba_start_hi = ldl_phys(cmd->pa + MEGASAS_IO_START_LBA_HI_OFFSET);
+    lba_start = ((uint64_t)lba_start_hi << 32) | lba_start_lo;
+
+    if (lun == 0)
+	cmd->lun = &s->luns[target];
+
+    DPRINTF("SCSI %s dev %x lun %x lba %lx count %lx\n",
+	    write?"write":"read", target, lun,
+	    (unsigned long)lba_start, (unsigned long)lba_count);
+
+    if (!cmd->lun || !cmd->lun->sdev)
+	return MFI_STAT_DEVICE_NOT_FOUND;
+
+    megasas_map_sgl(cmd, MEGASAS_IO_SGL_OFFSET, write);
+    megasas_map_sense(cmd);
+
+    qemu_iovec_init_external(&cmd->qiov, cmd->iov, cmd->sge_count);
+    if (write)
+	cmd->lun->aiocb = bdrv_aio_writev(cmd->lun->bdrv, lba_start,
+					  &cmd->qiov, lba_count,
+					  megasas_write_complete, cmd);
+    else
+	cmd->lun->aiocb = bdrv_aio_readv(cmd->lun->bdrv, lba_start,
+					 &cmd->qiov, lba_count,
+					 megasas_read_complete, cmd);
+
+    if (!cmd->lun->aiocb) {
+	DPRINTF("SCSI %s dev %x lun %x aio failed\n",
+		write?"write":"read", target, lun);
+	megasas_unmap_sense(cmd, 0);
+	megasas_frame_set_scsi_status(cmd->pa, SAM_STAT_TASK_ABORTED);
+	cmd->sge_size = 0;
+	return MFI_STAT_SCSI_IO_FAILED;
+    }
+    return MFI_STAT_INVALID_STATUS;
+}
+
+static void megasas_handle_frame(MPTState *s, target_phys_addr_t frame_addr,
+				 uint32_t frame_count)
+{
+    uint8_t frame_cmd;
+    uint8_t frame_status = MFI_STAT_INVALID_CMD;
+    struct megasas_cmd_t *cmd;
+
+    frame_cmd = ldub_phys(frame_addr);
+    frame_status = ldub_phys(frame_addr + 2);
+
+#ifdef DEBUG_MEGASAS_MFI
+    DPRINTF("MFI cmd %x count %d status %x\n",
+	    frame_cmd, frame_count, frame_status);
+#endif
+    if (s->fw_state != MFI_STATE_OPERATIONAL) {
+	/* Firmware not initialized, only polled commands */
+	if (frame_cmd != MFI_CMD_INIT) {
+	    frame_status = MFI_STAT_APP_NOT_INITIALIZED;
+	} else {
+	    megasas_init_firmware(s, frame_addr);
+	    frame_status = MFI_STAT_OK;
+	}
+	megasas_frame_set_cmd_status(frame_addr, frame_status);
+	return;
+    }
+
+    cmd = megasas_enqueue_frame(s, frame_addr);
+    if (megasas_check_queue_full(s)) {
+	/* reply queue full */
+	megasas_frame_set_scsi_status(frame_addr, SAM_STAT_BUSY);
+	frame_status = MFI_STAT_SCSI_DONE_WITH_ERROR;
+	goto frame_done;
+    }
+    switch (frame_cmd) {
+	case MFI_CMD_DCMD:
+	    frame_status = megasas_handle_doorcmd(s, frame_addr);
+	    break;
+	case MFI_CMD_PD_SCSI_IO:
+	case MFI_CMD_LD_SCSI_IO:
+	    frame_status = megasas_handle_scsi(s, frame_cmd, cmd);
+	    break;
+	case MFI_CMD_LD_READ:
+	    frame_status = megasas_handle_io(s, cmd, 0);
+	    break;
+	case MFI_CMD_LD_WRITE:
+	    frame_status = megasas_handle_io(s, cmd, 1);
+	    break;
+	default:
+	    DPRINTF("Unhandled MFI cmd %x\n", frame_cmd);
+	    break;
+    }
+    frame_done:
+    if (frame_status != MFI_STAT_INVALID_STATUS) {
+	megasas_frame_set_cmd_status(frame_addr, frame_status);
+	megasas_dequeue_frame(s, cmd);
+    }
+}
+
+static uint32_t megasas_mmio_readl(void *opaque, target_phys_addr_t addr)
+{
+    MPTState *s = opaque;
+
+#ifdef DEBUG_MEGASAS_REG
+    DPRINTF("Read reg 0x%lx\n", (unsigned long)addr);
+#endif
+    switch (addr) {
+	case MEGASAS_INBOUND_DOORBELL:
+	    return 0;
+	case MEGASAS_OUTBOUND_MSG_0:
+	case MEGASAS_OUTBOUND_SCRATCH_PAD:
+	    return (s->fw_state) << 28 | (s->fw_sge << 16) | (s->fw_cmds & 0xFFFF);
+	case MEGASAS_OUTBOUND_INTR_STATUS:
+	    if (MEGASAS_INTR_ENABLED(s) && s->doorbell)
+		return MFI_REPLY_1078_MESSAGE_INTERRUPT | s->doorbell;
+	    break;
+	case MEGASAS_OUTBOUND_INTR_MASK:
+	    return s->intr_mask;
+	case MEGASAS_OUTBOUND_DOORBELL_CLEAR:
+	    return s->doorbell;
+	default:
+	    BADF("readb 0x%lx\n", (unsigned long)addr);
+	    break;
+    }
+    return 0;
+}
+
+static void megasas_mmio_writel(void *opaque, target_phys_addr_t addr,
+				uint32_t val)
+{
+    MPTState *s = opaque;
+    target_phys_addr_t frame_addr;
+    uint32_t frame_count;
+    int i;
+
+#ifdef DEBUG_MEGASAS_REG
+    DPRINTF("Write reg %lx: %x\n", (unsigned long)addr, val);
+#endif
+
+    switch (addr) {
+	case MEGASAS_INBOUND_DOORBELL:
+	    if (val & MFI_INIT_ABORT) {
+		/* Abort all pending cmds */
+		for (i = 0; i <= s->fw_cmds; i++)
+		    megasas_abort_command(&s->frames[i]);
+	    }
+	    if (val & MFI_INIT_READY) {
+		/* move to FW READY */
+		megasas_soft_reset(s);
+	    }
+	    if (val & MFI_INIT_MFIMODE) {
+		/* discard MFIs */
+	    }
+	    break;
+	case MEGASAS_OUTBOUND_INTR_MASK:
+	    s->intr_mask = val;
+	    if (!MEGASAS_INTR_ENABLED(s)) {
+		DPRINTF("Disable interrupts\n");
+		qemu_irq_lower(s->dev.irq[0]);
+	    } else {
+		DPRINTF("Enable interrupts\n");
+	    }
+	    break;
+	case MEGASAS_OUTBOUND_DOORBELL_CLEAR:
+	    s->doorbell = 0;
+	    qemu_irq_lower(s->dev.irq[0]);
+	    break;
+	case MEGASAS_INBOUND_QUEUE_PORT:
+	    /* Received MFI frames; up to 8 contiguous frames */
+	    frame_addr = (val & ~0xF);
+	    frame_count = (val >> 1) & 0x7;
+#ifdef DEBUG_MEGASAS_MFI
+	    DPRINTF("Received frame addr %lx count %d\n",
+		    (unsigned long)frame_addr, frame_count);
+#endif
+	    megasas_handle_frame(s, frame_addr, frame_count);
+	    break;
+	default:
+	    BADF("writel 0x%lx: %x\n", (unsigned long)addr, val);
+	    break;
+    }
+}
+
+static CPUReadMemoryFunc * const megasas_mmio_readfn[3] = {
+    NULL,
+    NULL,
+    megasas_mmio_readl,
+};
+
+static CPUWriteMemoryFunc * const megasas_mmio_writefn[3] = {
+    NULL,
+    NULL,
+    megasas_mmio_writel,
+};
+
+static void megasas_soft_reset(MPTState *s)
+{
+    DPRINTF("Reset\n");
+
+    s->reply_queue_len = 0;
+    s->reply_queue_pa = 0;
+    s->consumer_pa = 0;
+    s->producer_pa = 0;
+    s->fw_state = MFI_STATE_READY;
+    s->doorbell = 0;
+    s->intr_mask = MEGASAS_INTR_DISABLED_MASK;
+}
+
+static void megasas_mmio_mapfunc(PCIDevice *pci_dev, int region_num,
+				 uint32_t addr, uint32_t size, int type)
+{
+    MPTState *s = DO_UPCAST(MPTState, dev, pci_dev);
+
+    DPRINTF("Mapping MMIO region %d at %08x\n", region_num, addr);
+    cpu_register_physical_memory(addr, size, s->mmio_io_addr);
+}
+
+static void megasas_io_mapfunc(PCIDevice *pci_dev, int region_num,
+				 uint32_t addr, uint32_t size, int type)
+{
+    DPRINTF("Mapping IO region %d at %08x\n", region_num, addr);
+}
+
+static void megasas_scsi_save(QEMUFile *f, void *opaque)
+{
+    MPTState *s = opaque;
+
+    pci_device_save(&s->dev, f);
+
+    qemu_put_sbe32s(f, &s->fw_state);
+    qemu_put_sbe32s(f, &s->intr_mask);
+    qemu_put_sbe32s(f, &s->doorbell);
+    qemu_put_be64s(f, &s->reply_queue_pa);
+    qemu_put_be64s(f, &s->consumer_pa);
+    qemu_put_be64s(f, &s->producer_pa);
+}
+
+static int megasas_scsi_load(QEMUFile *f, void *opaque, int version_id)
+{
+    MPTState *s = opaque;
+    int ret;
+
+    if (version_id > 0)
+	return -EINVAL;
+
+    if ((ret = pci_device_load(&s->dev, f)) < 0)
+	return ret;
+
+    qemu_get_sbe32s(f, &s->fw_state);
+    qemu_get_sbe32s(f, &s->intr_mask);
+    qemu_get_sbe32s(f, &s->doorbell);
+    qemu_get_be64s(f, &s->reply_queue_pa);
+    qemu_get_be64s(f, &s->consumer_pa);
+    qemu_get_be64s(f, &s->producer_pa);
+
+    return 0;
+}
+
+static int megasas_scsi_uninit(PCIDevice *d)
+{
+    MPTState *s = DO_UPCAST(MPTState, dev, d);
+
+    cpu_unregister_io_memory(s->mmio_io_addr);
+
+    return 0;
+}
+
+static int megasas_scsi_init(PCIDevice *dev)
+{
+    MPTState *s = DO_UPCAST(MPTState, dev, dev);
+    uint8_t *pci_conf;
+    int unit, i, ret;
+    struct sg_io_hdr hdr;
+    uint8_t tur_cdb[6];
+
+    /* Format sg_IO hdr */
+    memset(tur_cdb, 0, 6);
+    memset(&hdr, 0, sizeof(struct sg_io_hdr));
+    hdr.interface_id = 'S';
+    hdr.cmd_len = 6;
+    hdr.cmdp = tur_cdb;
+    hdr.dxfer_direction = SG_DXFER_NONE;
+
+    pci_conf = s->dev.config;
+
+    /* PCI Vendor ID (word) */
+    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_LSI_LOGIC);
+    /* PCI device ID (word) */
+    pci_config_set_device_id(pci_conf,  PCI_DEVICE_ID_LSI_SAS1078);
+    /* PCI subsystem ID */
+    pci_set_word(&pci_conf[PCI_SUBSYSTEM_VENDOR_ID], 0x1000);
+    pci_set_word(&pci_conf[PCI_SUBDEVICE_ID], 0x1013);
+    /* PCI base class code */
+    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_RAID);
+
+    /* PCI latency timer = 0 */
+    pci_conf[0x0d] = 0;
+    /* Interrupt pin 1 */
+    pci_conf[0x3d] = 0x01;
+
+    s->mmio_io_addr = cpu_register_io_memory(megasas_mmio_readfn,
+                                             megasas_mmio_writefn, s);
+
+    pci_register_bar((struct PCIDevice *)s, 0, 0x40000,
+                           PCI_ADDRESS_SPACE_MEM, megasas_mmio_mapfunc);
+    pci_register_bar((struct PCIDevice *)s, 2, 256,
+                           PCI_ADDRESS_SPACE_IO, megasas_io_mapfunc);
+    pci_register_bar((struct PCIDevice *)s, 3, 0x40000,
+                           PCI_ADDRESS_SPACE_MEM, megasas_mmio_mapfunc);
+    s->fw_sge = MEGASAS_MAX_SGE;
+    s->fw_cmds = MEGASAS_MAX_FRAMES;
+    s->producer_pa = 0;
+    s->consumer_pa = 0;
+    for (i = 0; i < s->fw_cmds; i++) {
+	s->frames[i].index = i;
+	s->frames[i].context = 0;
+	s->frames[i].pa = 0;
+	memset(s->frames[i].iov, 0, sizeof(struct iovec) * MEGASAS_MAX_SGE);
+	s->frames[i].state = s;
+    }
+    s->next_fw_cmd = &s->frames[0];
+
+    megasas_soft_reset(s);
+
+    scsi_bus_new(&s->bus, &dev->qdev, 1, MAX_RAID_DEVS, NULL);
+    memset(s->luns, 0, sizeof(struct megasas_lun_t) * MAX_RAID_DEVS);
+    for (unit = 0; unit < MAX_RAID_DEVS; unit++) {
+	struct megasas_lun_t *lun = &s->luns[unit];
+	SCSIBus *bus = &s->bus;
+	DriveInfo *dinfo;
+
+	dinfo = drive_get(IF_RAID, bus->busnr, unit);
+	if (dinfo == NULL)
+	    continue;
+	lun->bdrv = dinfo->bdrv;
+	lun->sdev = scsi_bus_legacy_add_drive(bus, dinfo, unit);
+	if (!lun->sdev) {
+	    DPRINTF("Cannot allocate drive %d\n", unit);
+	    lun->bdrv = NULL;
+	    continue;
+	}
+	/* check if we can use SG_IO */
+	ret = bdrv_ioctl(lun->bdrv, SG_IO, &hdr);
+	if (ret) {
+	    DPRINTF("SCSI cmd passthrough not available on dev %d (error %d)\n",
+		    unit, ret);
+	    lun->sdev = NULL;
+	    lun->bdrv = NULL;
+	}
+    }
+    register_savevm("megasas", -1, 0, megasas_scsi_save, megasas_scsi_load, s);
+    return 0;
+}
+
+static PCIDeviceInfo megasas_info = {
+    .qdev.name  = "LSI MegaRAID SAS 1078",
+    .qdev.alias = "megasas",
+    .qdev.size  = sizeof(MPTState),
+    .init       = megasas_scsi_init,
+    .exit       = megasas_scsi_uninit,
+};
+
+static void megaraid1078_register_devices(void)
+{
+    pci_qdev_register(&megasas_info);
+}
+
+device_init(megaraid1078_register_devices);
diff --git a/hw/pci_ids.h b/hw/pci_ids.h
index 3afe674..104f3a3 100644
--- a/hw/pci_ids.h
+++ b/hw/pci_ids.h
@@ -15,6 +15,7 @@
 
 #define PCI_CLASS_STORAGE_SCSI           0x0100
 #define PCI_CLASS_STORAGE_IDE            0x0101
+#define PCI_CLASS_STORAGE_RAID           0x0104
 #define PCI_CLASS_STORAGE_OTHER          0x0180
 
 #define PCI_CLASS_NETWORK_ETHERNET       0x0200
@@ -46,6 +47,7 @@
 
 #define PCI_VENDOR_ID_LSI_LOGIC          0x1000
 #define PCI_DEVICE_ID_LSI_53C895A        0x0012
+#define PCI_DEVICE_ID_LSI_SAS1078        0x0060
 
 #define PCI_VENDOR_ID_DEC                0x1011
 #define PCI_DEVICE_ID_DEC_21154          0x0026
-- 
1.6.0.2
