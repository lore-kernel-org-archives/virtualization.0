Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEEB1FDA
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185443; cv=none; b=hHOY/FsobhPWMn5v38s1xsVALoU/32FfoYuRe3bWV+PQEBw/Qfb71TyuI4Yz3ItmrNA3SxdyeANcu35LtrFEuJ6SMHg2aTVJBhawic1+lo1BY3iLLcYlsm+/xdRUWCmuswJCW8XAKV6aNzMedR/yz+EG2wrPXvE7JZqMHBbsyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185443; c=relaxed/simple;
	bh=e7LzkJNNd2JQicXQhs3pZF38j5qnKNG4ZZm4m3KpSew=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FI7S9ucqcWe7dxKH8Hk66Ty6r585MwVUjRXHZS83rxSy37rbR/bRTby7WdWBpHJzPbudLMXjyFe4xYvTKMl8l2ePrzHirejvW7iJeEmj4vquozZOSLzvoipw53DiBDo7ZNOWrrYgrk/5rUH1nr2+RWPR4prvRBj2D6BB38gdq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxXiauBD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxXiauBD"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee4b1a1057so5061862a91.1
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 16:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733185440; x=1733790240; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3dEkRIysLWaL9ITQw+zsEeXtl+7ibVr1QzCbZ81J1U8=;
        b=JxXiauBD/Zd0bt3W2fRpV9n1ZjHyXksp92vF9/yTGLvQDgfzx+91OVlMmfYdvb232f
         3vwaCTIOg2e2Z8+dE7OuLftpImFAYYh3qxrrMdBYElvr+Wb+NZ3TqhSIE68T2BtVsURo
         HQSozBzMuzPkFQ/7czb8w14kJhNW6rfX3b+bLn12HkdFvPg+4hQvWIeSnLhFLSV3XkpP
         S09o96o/82S/o5dcFHdm7swz8AI9Ok9HwDf3VL1WTEJmktgSSTUB/+8Ss88tl3OruCtx
         GA2e/7FJxNySepoE3MvUolnv8Q7nn0nduyA4bfIrWN71CZg9ssWyBviNcXiMYvtimDUC
         eNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185440; x=1733790240;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dEkRIysLWaL9ITQw+zsEeXtl+7ibVr1QzCbZ81J1U8=;
        b=ulgYeGetsi2wlrjLJOFek0BLnlxX5hAPh9aq2YwtVP1Wca4ggtmVA7dGBVqY3x+4qB
         MRB4D3QmNwOZRICsRdQCDS5kY7YupaI58u/+PYK0cQbtvnMIbXLa0pWHTWqPgCG0d+FO
         8FMq5GkRcZYkbhkgFFPAxGPfZxcvPNs1KXOJH4pNMqxIWUwf5ggzZKFExvutLw7adAVt
         /In5pjXizbkdfR65HLam9rW3cjWIsSnFS4aF3Eurt4cj2p1wiHf6XWXGCvIxYhbjuvE7
         JnurF0WnuzCQgJk1OCZ1NsmmhhQDL5Zq1fZCBeL1Ok5+zweZJ51dACKCBiIpbuZuY0q+
         PPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLX/a/XfZQEOzqAhoUOJraehDe1W0UC3ivOI844hxC5f5ORpyqH3henEfXAmyztTjTGimfdW7GT7Cd2MAbAg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx07Cl7CEasGlx9C1Pzwc+iu7tYoBQQP3lYhRUcyQt2tgSfRF/X
	4e0oCPZaZtuVW0hwp6f2FUroUixLchrPX8iisiVvCQ0YupmFQnO8vu0No9f6Ainv/NwYIjZFcQG
	mOWTSfQ==
X-Google-Smtp-Source: AGHT+IF4PCWpM3k+PFEDD7TgfuNJuV7QWB2xQO7QIlH4mkHyH358LOPJeBKZaCKKEmSLKH5Jo69CY6MsvgRF
X-Received: from pjbnc15.prod.google.com ([2002:a17:90b:37cf:b0:2ea:5469:76c2])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc1:b0:2ee:ab11:fab2
 with SMTP id 98e67ed59e1d1-2ef01211725mr734840a91.22.1733185440563; Mon, 02
 Dec 2024 16:24:00 -0800 (PST)
Date: Mon,  2 Dec 2024 16:23:27 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0
Message-ID: <20241203002328.694071-1-yuanchu@google.com>
Subject: [PATCH v5 1/2] virt: pvmemcontrol: control guest physical memory properties
From: Yuanchu Xie <yuanchu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

Pvmemcontrol provides a way for the guest to control its physical memory
properties and enables optimizations and security features. For example,
the guest can provide information to the host where parts of a hugepage
may be unbacked, or sensitive data may not be swapped out, etc.

Pvmemcontrol allows guests to manipulate its gPTE entries in the SLAT,
and also some other properties of the memory mapping on the host.
This is achieved by using the KVM_CAP_SYNC_MMU capability. When this
capability is available, the changes in the backing of the memory region
on the host are automatically reflected into the guest. For example, an
mmap() or madvise() that affects the region will be made visible
immediately.

There are two components of the implementation: the guest Linux driver
and Virtual Machine Monitor (VMM) device. A guest-allocated shared
buffer is negotiated per-cpu through a few PCI MMIO registers; the VMM
device assigns a unique command for each per-cpu buffer. The guest
writes its pvmemcontrol request in the per-cpu buffer, then writes the
corresponding command into the command register, calling into the VMM
device to perform the pvmemcontrol request.

The synchronous per-cpu shared buffer approach avoids the kick and busy
waiting that the guest would have to do with virtio virtqueue transport.

User API
From the userland, the pvmemcontrol guest driver is controlled via the
ioctl(2) call. It requires CAP_SYS_ADMIN.

ioctl(fd, PVMEMCONTROL_IOCTL, struct pvmemcontrol_buf *buf);

Guest userland applications can tag VMAs and guest hugepages, or advise
the host on how to handle sensitive guest pages.

Supported function codes and their use cases:
PVMEMCONTROL_FREE/REMOVE/DONTNEED/PAGEOUT. For the guest. One can reduce
the struct page and page table lookup overhead by using hugepages backed
by smaller pages on the host. These pvmemcontrol commands can allow for
partial freeing of private guest hugepages to save memory. They also
allow kernel memory, such as kernel stacks and task_structs to be
paravirtualized if we expose kernel APIs.

PVMEMCONTROL_MERGEABLE can inform the host KSM to deduplicate VM pages.

PVMEMCONTROL_UNMERGEABLE is useful for security, when the VM does not
want to share its backing pages.
The same with PVMEMCONTROL_DONTDUMP, so sensitive pages are not included
in a dump.
MLOCK/UNLOCK can advise the host that sensitive information is not
swapped out on the host.

PVMEMCONTROL_MPROTECT_NONE/R/W/RW. For guest stacks backed by hugepages,
stack guard pages can be handled in the host and memory can be saved in
the hugepage.

PVMEMCONTROL_SET_VMA_ANON_NAME is useful for observability and debugging
how guest memory is being mapped on the host.

Sample program making use of PVMEMCONTROL_DONTNEED:
https://github.com/Dummyc0m/pvmemcontrol-user

The VMM implementation is part of Cloud Hypervisor, the feature
pvmemcontrol can be enabled and the VMM can then provide the device to a
supporting guest.
https://github.com/cloud-hypervisor/cloud-hypervisor

Signed-off-by: Yuanchu Xie <yuanchu@google.com>

---
PATCH v4 -> v5
- use drvdata and friends to enable multiple devices

PATCH v3 -> v4
- changed dev_info to dev_dbg so the driver is quiet when it works
  properly.
- Edited the changelog section to be included in the diffstat.

PATCH v2 -> v3
- added PVMEMCONTROL_MERGEABLE for memory dedupe.
- updated link to the upstream Cloud Hypervisor repo, and specify the
  feature required to enable the device.

PATCH v1 -> v2
- fixed byte order sparse warning. ioread/write already does
  little-endian.
- add include for linux/percpu.h

RFC v1 -> PATCH v1
- renamed memctl to pvmemcontrol
- defined device endianness as little endian

v1:
https://lore.kernel.org/linux-mm/20240518072422.771698-1-yuanchu@google.com/
v2:
https://lore.kernel.org/linux-mm/20240612021207.3314369-1-yuanchu@google.com/
v3:
https://lore.kernel.org/linux-mm/20241016193947.48534-1-yuanchu@google.com/
v4:
https://lore.kernel.org/linux-mm/20241021204849.1580384-1-yuanchu@google.com/

 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/pvmemcontrol/Kconfig             |  10 +
 drivers/virt/pvmemcontrol/Makefile            |   2 +
 drivers/virt/pvmemcontrol/pvmemcontrol.c      | 499 ++++++++++++++++++
 include/uapi/linux/pvmemcontrol.h             |  76 +++
 mm/percpu.c                                   |   1 +
 8 files changed, 593 insertions(+)
 create mode 100644 drivers/virt/pvmemcontrol/Kconfig
 create mode 100644 drivers/virt/pvmemcontrol/Makefile
 create mode 100644 drivers/virt/pvmemcontrol/pvmemcontrol.c
 create mode 100644 include/uapi/linux/pvmemcontrol.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 243f1f1b554a..09788e8e4f9f 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -378,6 +378,8 @@ Code  Seq#    Include File                                           Comments
 0xCD  01     linux/reiserfs_fs.h                                     Dead since 6.13
 0xCE  01-02  uapi/linux/cxl_mem.h                                    Compute Express Link Memory Devices
 0xCF  02     fs/smb/client/cifs_ioctl.h
+0xDA  00     uapi/linux/pvmemcontrol.h                               Pvmemcontrol Device
+                                                                     <mailto:yuanchu@google.com>
 0xDB  00-0F  drivers/char/mwave/mwavepub.h
 0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
                                                                      <mailto:aherrman@de.ibm.com>
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index d8c848cf09a6..454e347a90cf 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -49,4 +49,6 @@ source "drivers/virt/acrn/Kconfig"
 
 source "drivers/virt/coco/Kconfig"
 
+source "drivers/virt/pvmemcontrol/Kconfig"
+
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f29901bd7820..3a1fd6e076ad 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -10,3 +10,4 @@ obj-y				+= vboxguest/
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-y				+= coco/
+obj-$(CONFIG_PVMEMCONTROL)	+= pvmemcontrol/
diff --git a/drivers/virt/pvmemcontrol/Kconfig b/drivers/virt/pvmemcontrol/Kconfig
new file mode 100644
index 000000000000..9fe16da23bd8
--- /dev/null
+++ b/drivers/virt/pvmemcontrol/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+config PVMEMCONTROL
+	tristate "pvmemcontrol Guest Service Module"
+	depends on KVM_GUEST
+	help
+	  pvmemcontrol is a guest kernel module that allows to communicate
+	  with hypervisor / VMM and control the guest memory backing.
+
+	  To compile as a module, choose M, the module will be called
+	  pvmemcontrol. If unsure, say N.
diff --git a/drivers/virt/pvmemcontrol/Makefile b/drivers/virt/pvmemcontrol/Makefile
new file mode 100644
index 000000000000..2fc087ef3ef5
--- /dev/null
+++ b/drivers/virt/pvmemcontrol/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PVMEMCONTROL)	:= pvmemcontrol.o
diff --git a/drivers/virt/pvmemcontrol/pvmemcontrol.c b/drivers/virt/pvmemcontrol/pvmemcontrol.c
new file mode 100644
index 000000000000..28df8f77c3a7
--- /dev/null
+++ b/drivers/virt/pvmemcontrol/pvmemcontrol.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Control guest physical memory properties by sending
+ * madvise-esque requests to the host VMM.
+ *
+ * Author: Yuanchu Xie <yuanchu@google.com>
+ * Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/spinlock.h>
+#include <linux/cpumask.h>
+#include <linux/percpu-defs.h>
+#include <linux/percpu.h>
+#include <linux/types.h>
+#include <linux/gfp.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/sched/clock.h>
+#include <linux/wait.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/resource_ext.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/percpu.h>
+#include <linux/byteorder/generic.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <uapi/linux/pvmemcontrol.h>
+
+#define PCI_VENDOR_ID_GOOGLE 0x1ae0
+#define PCI_DEVICE_ID_GOOGLE_PVMEMCONTROL 0x0087
+
+#define PVMEMCONTROL_COMMAND_OFFSET 0x08
+#define PVMEMCONTROL_REQUEST_OFFSET 0x00
+#define PVMEMCONTROL_RESPONSE_OFFSET 0x00
+
+static DEFINE_IDA(pvmemcontrol_minors_ida);
+
+static unsigned int major_num __read_mostly;
+
+struct pvmemcontrol;
+
+struct pvmemcontrol_file_private {
+	struct pvmemcontrol *dev;
+	struct pvmemcontrol_buf buf;
+};
+
+/*
+ * Magic values that perform the action specified when written to
+ * the command register.
+ */
+enum pvmemcontrol_transport_command {
+	PVMEMCONTROL_TRANSPORT_RESET = 0x060FE6D2,
+	PVMEMCONTROL_TRANSPORT_REGISTER = 0x0E359539,
+	PVMEMCONTROL_TRANSPORT_READY = 0x0CA8D227,
+	PVMEMCONTROL_TRANSPORT_DISCONNECT = 0x030F5DA0,
+	PVMEMCONTROL_TRANSPORT_ACK = 0x03CF5196,
+	PVMEMCONTROL_TRANSPORT_ERROR = 0x01FBA249,
+};
+
+/* Contains the function code and arguments for specific function */
+struct pvmemcontrol_vmm_call_le {
+	__le64 func_code; /* pvmemcontrol set function code */
+	__le64 addr; /* hyper. page size aligned guest phys. addr */
+	__le64 length; /* hyper. page size aligned length */
+	__le64 arg; /* function code specific argument */
+};
+
+/* Is filled on return to guest from VMM from most function calls */
+struct pvmemcontrol_vmm_ret_le {
+	__le32 ret_errno; /* on error, value of errno */
+	__le32 ret_code; /* pvmemcontrol internal error code, on success 0 */
+	__le64 ret_value; /* return value from the function call */
+	__le64 arg0; /* currently unused */
+	__le64 arg1; /* currently unused */
+};
+
+struct pvmemcontrol_buf_le {
+	union {
+		struct pvmemcontrol_vmm_call_le call;
+		struct pvmemcontrol_vmm_ret_le ret;
+	};
+};
+
+struct pvmemcontrol_percpu_channel {
+	struct pvmemcontrol_buf_le buf;
+	u64 buf_phys_addr;
+	u32 command;
+};
+
+struct pvmemcontrol {
+	int minor_number;
+	void __iomem *base_addr;
+	struct pci_dev *pci_dev;
+	struct cdev cdev;
+	struct device *cdev_device;
+	/* cache the info call */
+	struct pvmemcontrol_vmm_ret pvmemcontrol_vmm_info;
+	struct pvmemcontrol_percpu_channel __percpu *pcpu_channels;
+};
+
+static void pvmemcontrol_write_command(void __iomem *base_addr, u32 command)
+{
+	iowrite32(command, base_addr + PVMEMCONTROL_COMMAND_OFFSET);
+}
+
+static u32 pvmemcontrol_read_command(void __iomem *base_addr)
+{
+	return ioread32(base_addr + PVMEMCONTROL_COMMAND_OFFSET);
+}
+
+static void pvmemcontrol_write_reg(void __iomem *base_addr, u64 buf_phys_addr)
+{
+	iowrite64_lo_hi(buf_phys_addr, base_addr + PVMEMCONTROL_REQUEST_OFFSET);
+}
+
+static u32 pvmemcontrol_read_resp(void __iomem *base_addr)
+{
+	return ioread32(base_addr + PVMEMCONTROL_RESPONSE_OFFSET);
+}
+
+static void pvmemcontrol_buf_call_to_le(struct pvmemcontrol_buf_le *le,
+					const struct pvmemcontrol_buf *buf)
+{
+	le->call.func_code = cpu_to_le64(buf->call.func_code);
+	le->call.addr = cpu_to_le64(buf->call.addr);
+	le->call.length = cpu_to_le64(buf->call.length);
+	le->call.arg = cpu_to_le64(buf->call.arg);
+}
+
+static void pvmemcontrol_buf_ret_from_le(struct pvmemcontrol_buf *buf,
+					 const struct pvmemcontrol_buf_le *le)
+{
+	buf->ret.ret_errno = le32_to_cpu(le->ret.ret_errno);
+	buf->ret.ret_code = le32_to_cpu(le->ret.ret_code);
+	buf->ret.ret_value = le64_to_cpu(le->ret.ret_value);
+	buf->ret.arg0 = le64_to_cpu(le->ret.arg0);
+	buf->ret.arg1 = le64_to_cpu(le->ret.arg1);
+}
+
+static void pvmemcontrol_send_request(struct pvmemcontrol *pvmemcontrol,
+				      struct pvmemcontrol_buf *buf)
+{
+	struct pvmemcontrol_percpu_channel *channel;
+
+	preempt_disable();
+	channel = this_cpu_ptr(pvmemcontrol->pcpu_channels);
+
+	pvmemcontrol_buf_call_to_le(&channel->buf, buf);
+	pvmemcontrol_write_command(pvmemcontrol->base_addr, channel->command);
+	pvmemcontrol_buf_ret_from_le(buf, &channel->buf);
+
+	preempt_enable();
+}
+
+static void pvmemcontrol_vmm_call(struct pvmemcontrol *pvmemcontrol,
+				  struct pvmemcontrol_buf *buf)
+{
+	if (buf->call.func_code == PVMEMCONTROL_INFO) {
+		memcpy(&buf->ret, &pvmemcontrol->pvmemcontrol_vmm_info,
+		       sizeof(buf->ret));
+		return;
+	}
+
+	pvmemcontrol_send_request(pvmemcontrol, buf);
+}
+
+static int pvmemcontrol_init_info(struct pvmemcontrol *dev,
+				  struct pvmemcontrol_buf *buf)
+{
+	buf->call.func_code = PVMEMCONTROL_INFO;
+
+	pvmemcontrol_send_request(dev, buf);
+	if (buf->ret.ret_code)
+		return buf->ret.ret_code;
+
+	/* Initialize global pvmemcontrol_vmm_info */
+	memcpy(&dev->pvmemcontrol_vmm_info, &buf->ret,
+	       sizeof(dev->pvmemcontrol_vmm_info));
+	dev_dbg(&dev->pci_dev->dev,
+		"pvmemcontrol_vmm_info.ret_errno = %u\n"
+		"pvmemcontrol_vmm_info.ret_code = %u\n"
+		"pvmemcontrol_vmm_info.major_version = %llu\n"
+		"pvmemcontrol_vmm_info.minor_version = %llu\n"
+		"pvmemcontrol_vmm_info.page_size = %llu\n",
+		dev->pvmemcontrol_vmm_info.ret_errno,
+		dev->pvmemcontrol_vmm_info.ret_code,
+		dev->pvmemcontrol_vmm_info.arg0,
+		dev->pvmemcontrol_vmm_info.arg1,
+		dev->pvmemcontrol_vmm_info.ret_value);
+
+	return 0;
+}
+
+static int pvmemcontrol_open(struct inode *inode, struct file *filp)
+{
+	struct pvmemcontrol_file_private *priv = NULL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	/* Do not allow exclusive open */
+	if (filp->f_flags & O_EXCL)
+		return -EINVAL;
+
+	priv = kzalloc(sizeof(struct pvmemcontrol_file_private), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = container_of(inode->i_cdev, struct pvmemcontrol, cdev);
+	filp->private_data = priv;
+	return 0;
+}
+
+static int pvmemcontrol_release(struct inode *inode, struct file *filp)
+{
+	kfree(filp->private_data);
+	filp->private_data = NULL;
+	return 0;
+}
+
+static long pvmemcontrol_ioctl(struct file *filp, unsigned int cmd,
+			       unsigned long ioctl_param)
+{
+	struct pvmemcontrol_file_private *priv = filp->private_data;
+	struct pvmemcontrol *p = priv->dev;
+	struct pvmemcontrol_buf *buf = &priv->buf;
+
+	if (cmd != PVMEMCONTROL_IOCTL_VMM)
+		return -EINVAL;
+
+	if (copy_from_user(&buf->call, (void __user *)ioctl_param,
+			   sizeof(struct pvmemcontrol_buf)))
+		return -EFAULT;
+
+	pvmemcontrol_vmm_call(p, buf);
+
+	if (copy_to_user((void __user *)ioctl_param, &buf->ret,
+			 sizeof(struct pvmemcontrol_buf)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static const struct file_operations pvmemcontrol_fops = {
+	.owner = THIS_MODULE,
+	.open = pvmemcontrol_open,
+	.release = pvmemcontrol_release,
+	.unlocked_ioctl = pvmemcontrol_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+static int pvmemcontrol_connect(struct pvmemcontrol *pvmemcontrol)
+{
+	int cpu;
+	u32 cmd;
+
+	pvmemcontrol_write_command(pvmemcontrol->base_addr,
+				   PVMEMCONTROL_TRANSPORT_RESET);
+	cmd = pvmemcontrol_read_command(pvmemcontrol->base_addr);
+	if (cmd != PVMEMCONTROL_TRANSPORT_ACK) {
+		dev_err(&pvmemcontrol->pci_dev->dev,
+			"failed to reset device, cmd 0x%x\n", cmd);
+		return -EINVAL;
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct pvmemcontrol_percpu_channel *channel =
+			per_cpu_ptr(pvmemcontrol->pcpu_channels, cpu);
+
+		pvmemcontrol_write_reg(pvmemcontrol->base_addr,
+				       channel->buf_phys_addr);
+		pvmemcontrol_write_command(pvmemcontrol->base_addr,
+					   PVMEMCONTROL_TRANSPORT_REGISTER);
+
+		cmd = pvmemcontrol_read_command(pvmemcontrol->base_addr);
+		if (cmd != PVMEMCONTROL_TRANSPORT_ACK) {
+			dev_err(&pvmemcontrol->pci_dev->dev,
+				"failed to register pcpu buf, cmd 0x%x\n", cmd);
+			return -EINVAL;
+		}
+		channel->command =
+			pvmemcontrol_read_resp(pvmemcontrol->base_addr);
+	}
+
+	pvmemcontrol_write_command(pvmemcontrol->base_addr,
+				   PVMEMCONTROL_TRANSPORT_READY);
+	cmd = pvmemcontrol_read_command(pvmemcontrol->base_addr);
+	if (cmd != PVMEMCONTROL_TRANSPORT_ACK) {
+		dev_err(&pvmemcontrol->pci_dev->dev,
+			"failed to ready device, cmd 0x%x\n", cmd);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int pvmemcontrol_disconnect(struct pvmemcontrol *pvmemcontrol)
+{
+	u32 cmd;
+
+	pvmemcontrol_write_command(pvmemcontrol->base_addr,
+				   PVMEMCONTROL_TRANSPORT_DISCONNECT);
+
+	cmd = pvmemcontrol_read_command(pvmemcontrol->base_addr);
+	if (cmd != PVMEMCONTROL_TRANSPORT_ERROR) {
+		dev_err(&pvmemcontrol->pci_dev->dev,
+			"failed to disconnect device, cmd 0x%x\n", cmd);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int pvmemcontrol_alloc_percpu_channels(struct pvmemcontrol *pvmemcontrol)
+{
+	int cpu;
+
+	pvmemcontrol->pcpu_channels = alloc_percpu_gfp(
+		struct pvmemcontrol_percpu_channel, GFP_ATOMIC | __GFP_ZERO);
+	if (!pvmemcontrol->pcpu_channels)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct pvmemcontrol_percpu_channel *channel =
+			per_cpu_ptr(pvmemcontrol->pcpu_channels, cpu);
+		phys_addr_t buf_phys = per_cpu_ptr_to_phys(&channel->buf);
+
+		channel->buf_phys_addr = buf_phys;
+	}
+	return 0;
+}
+
+static const struct class pvmemcontrol_class = {
+	.name = "pvmemcontrol",
+};
+
+static int pvmemcontrol_init(struct pci_dev *pci_dev, void __iomem *base_addr)
+{
+	struct pvmemcontrol_buf *buf = NULL;
+	struct pvmemcontrol *pvmemcontrol = NULL;
+	int err = 0;
+	dev_t dev;
+	int minor;
+
+	pvmemcontrol = kzalloc(sizeof(struct pvmemcontrol), GFP_ATOMIC);
+	buf = kzalloc(sizeof(struct pvmemcontrol_buf), GFP_ATOMIC);
+	if (!pvmemcontrol || !buf) {
+		err = -ENOMEM;
+		goto fail_free;
+	}
+
+	minor = ida_alloc_max(&pvmemcontrol_minors_ida, MINORMASK, GFP_KERNEL);
+	if (minor < 0) {
+		err = minor;
+		goto fail_free;
+	}
+	pvmemcontrol->minor_number = minor;
+	pvmemcontrol->base_addr = base_addr;
+	pvmemcontrol->pci_dev = pci_dev;
+
+	cdev_init(&pvmemcontrol->cdev, &pvmemcontrol_fops);
+	dev = MKDEV(major_num, minor);
+	err = cdev_add(&pvmemcontrol->cdev, dev, 1);
+	if (err)
+		goto fail_minor;
+
+	pvmemcontrol->cdev_device = device_create(
+		&pvmemcontrol_class, NULL, dev, NULL, "pvmemcontrol%u", minor);
+	if (IS_ERR(pvmemcontrol->cdev_device))
+		goto fail_cdev;
+
+	err = pvmemcontrol_alloc_percpu_channels(pvmemcontrol);
+	if (err)
+		goto fail_dev_create;
+
+	err = pvmemcontrol_connect(pvmemcontrol);
+	if (err)
+		goto fail_free_percpu;
+
+	err = pvmemcontrol_init_info(pvmemcontrol, buf);
+	if (err)
+		goto fail_disconnect;
+
+	pci_set_drvdata(pci_dev, pvmemcontrol);
+	kfree(buf);
+	return 0;
+
+fail_disconnect:
+	pvmemcontrol_disconnect(pvmemcontrol);
+fail_free_percpu:
+	free_percpu(pvmemcontrol->pcpu_channels);
+fail_dev_create:
+	device_destroy(&pvmemcontrol_class, dev);
+fail_cdev:
+	cdev_del(&pvmemcontrol->cdev);
+fail_minor:
+	ida_free(&pvmemcontrol_minors_ida, minor);
+fail_free:
+	kfree(pvmemcontrol);
+	kfree(buf);
+	return err;
+}
+
+static int pvmemcontrol_pci_probe(struct pci_dev *pci_dev,
+				  const struct pci_device_id *id)
+{
+	void __iomem *base_addr;
+	int err;
+
+	err = pcim_enable_device(pci_dev);
+	if (err < 0)
+		return err;
+
+	base_addr = pcim_iomap(pci_dev, 0, 0);
+	if (!base_addr)
+		return -ENOMEM;
+
+	err = pvmemcontrol_init(pci_dev, base_addr);
+	return err;
+}
+
+static void pvmemcontrol_pci_remove(struct pci_dev *pci_dev)
+{
+	int err;
+	struct pvmemcontrol *dev;
+
+	dev = (struct pvmemcontrol *)pci_get_drvdata(pci_dev);
+	if (!dev) {
+		pci_err(pci_dev, "cleanup with no drvdata");
+		return;
+	}
+
+	err = pvmemcontrol_disconnect(dev);
+	if (err)
+		dev_err(&pci_dev->dev, "device did not ack disconnect\n");
+	/* free percpu channels */
+	free_percpu(dev->pcpu_channels);
+	device_destroy(&pvmemcontrol_class, dev->cdev.dev);
+	cdev_del(&dev->cdev);
+	ida_free(&pvmemcontrol_minors_ida, dev->minor_number);
+	kfree(dev);
+}
+
+static const struct pci_device_id pvmemcontrol_pci_id_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_GOOGLE, PCI_DEVICE_ID_GOOGLE_PVMEMCONTROL) },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, pvmemcontrol_pci_id_tbl);
+
+static struct pci_driver pvmemcontrol_pci_driver = {
+	.name = "pvmemcontrol",
+	.id_table = pvmemcontrol_pci_id_tbl,
+	.probe = pvmemcontrol_pci_probe,
+	.remove = pvmemcontrol_pci_remove,
+};
+
+static int __init pvmemcontrol_driver_init(void)
+{
+	int err;
+	dev_t dev;
+
+	err = class_register(&pvmemcontrol_class);
+	if (err)
+		return err;
+
+	err = alloc_chrdev_region(&dev, 0, MINORMASK, "pvmemcontrol");
+	if (err)
+		goto fail_class;
+	WRITE_ONCE(major_num, MAJOR(dev));
+
+	err = pci_register_driver(&pvmemcontrol_pci_driver);
+	if (err)
+		goto fail_chrdev;
+
+	return 0;
+fail_chrdev:
+	unregister_chrdev_region(major_num, MINORMASK);
+fail_class:
+	class_unregister(&pvmemcontrol_class);
+	return err;
+}
+
+static void __exit pvmemcontrol_driver_exit(void)
+{
+	pci_unregister_driver(&pvmemcontrol_pci_driver);
+	unregister_chrdev_region(major_num, MINORMASK);
+	class_unregister(&pvmemcontrol_class);
+}
+
+module_init(pvmemcontrol_driver_init);
+module_exit(pvmemcontrol_driver_exit);
+
+MODULE_AUTHOR("Yuanchu Xie <yuanchu@google.com>");
+MODULE_DESCRIPTION("pvmemcontrol Guest Service Module");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/pvmemcontrol.h b/include/uapi/linux/pvmemcontrol.h
new file mode 100644
index 000000000000..31b366dee796
--- /dev/null
+++ b/include/uapi/linux/pvmemcontrol.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for /dev/pvmemcontrol
+ * pvmemcontrol Guest Memory Service Module
+ *
+ * Copyright (c) 2024, Google LLC.
+ * Yuanchu Xie <yuanchu@google.com>
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _UAPI_PVMEMCONTROL_H
+#define _UAPI_PVMEMCONTROL_H
+
+#include <linux/wait.h>
+#include <linux/types.h>
+#include <asm/param.h>
+
+/* Contains the function code and arguments for specific function */
+struct pvmemcontrol_vmm_call {
+	__u64 func_code;	/* pvmemcontrol set function code */
+	__u64 addr;		/* hyper. page size aligned guest phys. addr */
+	__u64 length;		/* hyper. page size aligned length */
+	__u64 arg;		/* function code specific argument */
+};
+
+/* Is filled on return to guest from VMM from most function calls */
+struct pvmemcontrol_vmm_ret {
+	__u32 ret_errno;	/* on error, value of errno */
+	__u32 ret_code;		/* pvmemcontrol internal error code, on success 0 */
+	__u64 ret_value;	/* return value from the function call */
+	__u64 arg0;		/* major version for func_code INFO */
+	__u64 arg1;		/* minor version for func_code INFO */
+};
+
+struct pvmemcontrol_buf {
+	union {
+		struct pvmemcontrol_vmm_call call;
+		struct pvmemcontrol_vmm_ret ret;
+	};
+};
+
+/* The ioctl type, documented in ioctl-number.rst */
+#define PVMEMCONTROL_IOCTL_TYPE		0xDA
+
+#define PVMEMCONTROL_IOCTL_VMM _IOWR(PVMEMCONTROL_IOCTL_TYPE, 0x00, struct pvmemcontrol_buf)
+
+/*
+ * Returns the host page size in ret_value.
+ * major version in arg0.
+ * minor version in arg1.
+ */
+#define PVMEMCONTROL_INFO		0
+
+/* Pvmemcontrol calls, pvmemcontrol_vmm_return is returned */
+#define PVMEMCONTROL_DONTNEED		1 /* madvise(addr, len, MADV_DONTNEED); */
+#define PVMEMCONTROL_REMOVE		2 /* madvise(addr, len, MADV_MADV_REMOVE); */
+#define PVMEMCONTROL_FREE		3 /* madvise(addr, len, MADV_FREE); */
+#define PVMEMCONTROL_PAGEOUT		4 /* madvise(addr, len, MADV_PAGEOUT); */
+#define PVMEMCONTROL_DONTDUMP		5 /* madvise(addr, len, MADV_DONTDUMP); */
+
+/* prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, addr, len, arg) */
+#define PVMEMCONTROL_SET_VMA_ANON_NAME  6
+
+#define PVMEMCONTROL_MLOCK		7 /* mlock2(addr, len, 0) */
+#define PVMEMCONTROL_MUNLOCK		8 /* munlock(addr, len) */
+
+#define PVMEMCONTROL_MPROTECT_NONE	9 /* mprotect(addr, len, PROT_NONE) */
+#define PVMEMCONTROL_MPROTECT_R	       10 /* mprotect(addr, len, PROT_READ) */
+#define PVMEMCONTROL_MPROTECT_W	       11 /* mprotect(addr, len, PROT_WRITE) */
+/* mprotect(addr, len, PROT_READ | PROT_WRITE) */
+#define PVMEMCONTROL_MPROTECT_RW       12
+
+#define PVMEMCONTROL_MERGEABLE         13 /* madvise(addr, len, MADV_MERGEABLE); */
+#define PVMEMCONTROL_UNMERGEABLE       14 /* madvise(addr, len, MADV_UNMERGEABLE); */
+
+#endif /* _UAPI_PVMEMCONTROL_H */
diff --git a/mm/percpu.c b/mm/percpu.c
index d8dd31a2e407..87d69b17d979 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2384,6 +2384,7 @@ phys_addr_t per_cpu_ptr_to_phys(void *addr)
 		return page_to_phys(pcpu_addr_to_page(addr)) +
 		       offset_in_page(addr);
 }
+EXPORT_SYMBOL_GPL(per_cpu_ptr_to_phys);
 
 /**
  * pcpu_alloc_alloc_info - allocate percpu allocation info
-- 
2.46.0

