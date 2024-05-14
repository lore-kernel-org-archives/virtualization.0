Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B071C36
	for <virtualization@lists.linux.dev>; Tue, 14 May 2024 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715652192; cv=none; b=qmZ8jy/o9PDGGJJK0j/0gF/BZSC5GZzsx5bsF0h4qzeIpMMIx0joiI8Vh+9ODMdBcIeU9NK5lEtkq8W5VlAWecx/F48AfIz8sexl4ZUGXEehc4Bl0JV7h/ro19hQbp5Jqetq3O/rQOk17ng53yuMLucIau7DvnOlT9uANr9q1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715652192; c=relaxed/simple;
	bh=ztQztVEAsLYY0jkIeXwRsOI3ugtrw2zLixrbiHOJZe8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WhamRegFGSnMGMyH9ionPYwLHM5Am5NgnTOeVNC8Ozc7bfoAsPKn8F0gKJuncPMf3wsUxYSencADNyd/46zHOm3rym3WSSiwbzGM/2vN8iZR74nwOIgy0Ekd5KHK4lBJFhwaNEHlixeRIIu5EI660G2vWEmmKTfc+LTYYF9mBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNp3c3oS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNp3c3oS"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be325413eso66082887b3.1
        for <virtualization@lists.linux.dev>; Mon, 13 May 2024 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715652189; x=1716256989; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2CILSZ0uaH9NdCYkm3r9ynyezJGNQ4maM6CJOkgWuPY=;
        b=pNp3c3oSUat4ggWExBn6L5Gi50utdfod7mP4fOP7xKYlFkXjF+cv2uIzEw73EJJQeE
         MzHDwvI7ZpsQ9Zqe4qVNzQMIO4FlamMAx/MjARFlAGuhV+w9CSIkMw+Y+wvJY39BOOaL
         NDpKh/gIpsvAjZj5Sf5vhdC2Fy3XTrVzxcwtgXrUNAKmPB6la5+KGH7GTV8B0Mn/J90V
         Mz4rkmWL4vYP5TJvxt/KRgabz7pvErlRgjuG5CZeH93xlzXlfL0IzgajibGBsKp/Dhvr
         RSeQN5OEkTryT2v87qQAwIdV9g57HI5DqrpHPnjv8KLIJRHlinDhsUsW05F6YMOeVB4m
         yzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715652189; x=1716256989;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CILSZ0uaH9NdCYkm3r9ynyezJGNQ4maM6CJOkgWuPY=;
        b=UIWg3l2UABnB1Tu5NO0RrP8/Wz19Wbva+35duKBLdGQ96GCxvs8n2uQJ7CDY6B62kd
         rHHk/BKTbR3q/nu5PIXTThz541vWk3Konw91Ly4kSdsSOvxLEaWA5fCv7hxZfaCNgzGB
         ZftuazSDN8fM1WJj40MbMTW/sK85qqoTxSjN37kpZc/2Z+50O4SA9aWF7TKEo3LsXLtZ
         DBR8qnFBmzEMZ5Ug0pmkzlv99F3Ndt5HTbA5fT3aQArTa+f7ltbupaqRSFZv+a9WGjLm
         YBBcZCD7uBsDtSSaMU8MeG0OqLAvi1Yl5EeXDE5uGOEPJEDt92WKtfNMTXM51fJYxzMQ
         lBLA==
X-Forwarded-Encrypted: i=1; AJvYcCW7inC340RRLFJSJYpfo3Z6guXbrFT3UxLnQUeeN2lXD7iwp3DjioD2ohiOqqQlWq85QHfJp/HqTJ2wM1keVsC3a4qlPLD77yCeOnnZsjQ=
X-Gm-Message-State: AOJu0YzhRTjmNdHKS2TACyLLz8SjagDq0y83RHC5a+W6AnWY34UHraWu
	stCNsG/94MBZV0Qcvj1GXKupbSL2rjEzaaBroA1ojX6ocnTEoO5zCWj2Lzp1Wj9Yny80gi4SSvV
	wXvLkxA==
X-Google-Smtp-Source: AGHT+IEWtB+4/73l6vSM8tCV6D8XBpUnv0LMYl0bKkmcEoYg6wuA/fBaNuJBg4Q9guALsrY4eXPZh4P4kz4V
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:c98c:5a45:8674:49c2])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:3804:b0:61b:32dc:881d with SMTP
 id 00721157ae682-622af8c8494mr31409317b3.3.1715652189206; Mon, 13 May 2024
 19:03:09 -0700 (PDT)
Date: Mon, 13 May 2024 19:03:00 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514020301.1835794-1-yuanchu@google.com>
Subject: [RFC PATCH v1 1/2] virt: memctl: control guest physical memory properties
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dan Williams <dan.j.williams@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

Memctl provides a way for the guest to control its physical memory
properties, and enables optimizations and security features. For
example, the guest can provide information to the host where parts of a
hugepage may be unbacked, or sensitive data may not be swapped out, etc.

Memctl allows guests to manipulate its gPTE entries in the SLAT, and
also some other properties of the memory map the back's host memory.
This is achieved by using the KVM_CAP_SYNC_MMU capability. When this
capability is available, the changes in the backing of the memory region
on the host are automatically reflected into the guest. For example, an
mmap() or madvise() that affects the region will be made visible
immediately.

There are two components of the implementation: the guest Linux driver
and Virtual Machine Monitor (VMM) device. A guest-allocated shared
buffer is negotiated per-cpu through a few PCI MMIO registers, the VMM
device assigns a unique command for each per-cpu buffer. The guest
writes its memctl request in the per-cpu buffer, then writes the
corresponding command into the command register, calling into the VMM
device to perform the memctl request.

The synchronous per-cpu shared buffer approach avoids the kick and busy
waiting that the guest would have to do with virtio virtqueue transport.

We provide both kernel and userspace APIs
Kernel API
long memctl_vmm_call(__u64 func_code, __u64 addr, __u64 length, __u64 arg,
		     struct memctl_buf *buf);

Kernel drivers can take advantage of the memctl calls to provide
paravirtualization of kernel stacks or page zeroing.

User API
From the userland, the memctl guest driver is controlled via ioctl(2)
call. It requires CAP_SYS_ADMIN.

ioctl(fd, MEMCTL_IOCTL, union memctl_vmm *memctl_vmm);

Guest userland applications can tag VMAs and guest hugepages, or advise
the host on how to handle sensitive guest pages.

Supported function codes and their use cases:
MEMCTL_FREE/REMOVE/DONTNEED/PAGEOUT. For the guest. One can reduce the
struct page and page table lookup overhead by using hugepages backed by
smaller pages on the host. These memctl commands can allow for partial
freeing of private guest hugepages to save memory. They also allow
kernel memory, such as kernel stacks and task_structs to be
paravirtualized.

MEMCTL_UNMERGEABLE is useful for security, when the VM does not want to
share its backing pages.
The same with MADV_DONTDUMP, so sensitive pages are not included in a
dump.
MLOCK/UNLOCK can advise the host that sensitive information is not
swapped out on the host.

MEMCTL_MPROTECT_NONE/R/W/RW. For guest stacks backed by hugepages, stack
guard pages can be handled in the host and memory can be saved in the
hugepage.

MEMCTL_SET_VMA_ANON_NAME is useful for observability and debugging how
guest memory is being mapped on the host.

Sample program making use of MEMCTL_SET_VMA_ANON_NAME and
MEMCTL_DONTNEED:
https://github.com/Dummyc0m/memctl-set-anon-vma-name/tree/main
https://github.com/Dummyc0m/memctl-set-anon-vma-name/tree/dontneed

The VMM implementation is being proposed for Cloud Hypervisor:
https://github.com/Dummyc0m/cloud-hypervisor/

Cloud Hypervisor issue:
https://github.com/cloud-hypervisor/cloud-hypervisor/issues/6318

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/memctl/Kconfig                   |  10 +
 drivers/virt/memctl/Makefile                  |   2 +
 drivers/virt/memctl/memctl.c                  | 425 ++++++++++++++++++
 include/linux/memctl.h                        |  27 ++
 include/uapi/linux/memctl.h                   |  81 ++++
 8 files changed, 550 insertions(+)
 create mode 100644 drivers/virt/memctl/Kconfig
 create mode 100644 drivers/virt/memctl/Makefile
 create mode 100644 drivers/virt/memctl/memctl.c
 create mode 100644 include/linux/memctl.h
 create mode 100644 include/uapi/linux/memctl.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 457e16f06e04..789d1251c0be 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -368,6 +368,8 @@ Code  Seq#    Include File                                           Comments
 0xCD  01     linux/reiserfs_fs.h
 0xCE  01-02  uapi/linux/cxl_mem.h                                    Compute Express Link Memory Devices
 0xCF  02     fs/smb/client/cifs_ioctl.h
+0xDA  00     linux/memctl.h                                          Memctl Device
+                                                                     <mailto:yuanchu@google.com>
 0xDB  00-0F  drivers/char/mwave/mwavepub.h
 0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
                                                                      <mailto:aherrman@de.ibm.com>
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 40129b6f0eca..419496558cfc 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -50,4 +50,6 @@ source "drivers/virt/acrn/Kconfig"
 
 source "drivers/virt/coco/Kconfig"
 
+source "drivers/virt/memctl/Kconfig"
+
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f29901bd7820..68e152e7cef1 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -10,3 +10,4 @@ obj-y				+= vboxguest/
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-y				+= coco/
+obj-$(CONFIG_MEMCTL)		+= memctl/
diff --git a/drivers/virt/memctl/Kconfig b/drivers/virt/memctl/Kconfig
new file mode 100644
index 000000000000..981ed9b76f97
--- /dev/null
+++ b/drivers/virt/memctl/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+config MEMCTL
+	tristate "memctl Guest Service Module"
+	depends on KVM_GUEST && 64BIT
+	help
+	  memctl is a guest kernel module that allows to communicate
+	  with hypervisor / VMM and control the guest memory backing.
+
+	  To compile as a module, choose M, the module will be called
+	  memctl. If unsure, say N.
diff --git a/drivers/virt/memctl/Makefile b/drivers/virt/memctl/Makefile
new file mode 100644
index 000000000000..410829a3c297
--- /dev/null
+++ b/drivers/virt/memctl/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MEMCTL)	:= memctl.o
diff --git a/drivers/virt/memctl/memctl.c b/drivers/virt/memctl/memctl.c
new file mode 100644
index 000000000000..661a552f98d8
--- /dev/null
+++ b/drivers/virt/memctl/memctl.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Control guest memory mappings
+ *
+ * Author: Yuanchu Xie <yuanchu@google.com>
+ * Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#define pr_fmt(fmt) "memctl %s: " fmt, __func__
+
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
+#include <linux/memctl.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+
+#define PCI_VENDOR_ID_GOOGLE		0x1ae0
+#define PCI_DEVICE_ID_GOOGLE_MEMCTL	0x0087
+
+#define MEMCTL_VERSION "0.01"
+
+enum memctl_transport_command {
+	MEMCTL_TRANSPORT_RESET = 0x060FE6D2,
+	MEMCTL_TRANSPORT_REGISTER = 0x0E359539,
+	MEMCTL_TRANSPORT_READY = 0x0CA8D227,
+	MEMCTL_TRANSPORT_DISCONNECT = 0x030F5DA0,
+	MEMCTL_TRANSPORT_ACK = 0x03CF5196,
+	MEMCTL_TRANSPORT_ERROR = 0x01FBA249,
+};
+
+struct memctl_transport {
+	union {
+		struct {
+			u64 buf_phys_addr;
+		} reg;
+		struct {
+			u32 command;
+			u32 _padding;
+		} resp;
+	};
+	u32 command;
+};
+
+struct memctl_percpu_channel {
+	struct memctl_buf buf;
+	u64 buf_phys_addr;
+	u32 command;
+};
+
+struct memctl {
+	void __iomem *base_addr;
+	/* cache the info call */
+	struct memctl_vmm_info memctl_vmm_info;
+	struct memctl_percpu_channel __percpu *pcpu_channels;
+};
+
+static DEFINE_RWLOCK(memctl_lock);
+static struct memctl *memctl __read_mostly;
+
+static void memctl_write_command(void __iomem *base_addr, u32 command)
+{
+	iowrite32(command,
+		  base_addr + offsetof(struct memctl_transport, command));
+}
+
+static u32 memctl_read_command(void __iomem *base_addr)
+{
+	return ioread32(base_addr + offsetof(struct memctl_transport, command));
+}
+
+static void memctl_write_reg(void __iomem *base_addr, u64 buf_phys_addr)
+{
+	iowrite64_lo_hi(buf_phys_addr,
+			base_addr + offsetof(struct memctl_transport,
+					     reg.buf_phys_addr));
+}
+
+static u32 memctl_read_resp(void __iomem *base_addr)
+{
+	return ioread32(base_addr +
+			offsetof(struct memctl_transport, resp.command));
+}
+
+static void memctl_send_request(struct memctl *memctl, struct memctl_buf *buf)
+{
+	struct memctl_percpu_channel *channel;
+
+	preempt_disable();
+	channel = this_cpu_ptr(memctl->pcpu_channels);
+	memcpy(&channel->buf, buf, sizeof(channel->buf));
+	memctl_write_command(memctl->base_addr, channel->command);
+	memcpy(buf, &channel->buf, sizeof(*buf));
+	preempt_enable();
+}
+
+static int __memctl_vmm_call(struct memctl_buf *buf)
+{
+	int err = 0;
+
+	if (!memctl)
+		return -EINVAL;
+
+	read_lock(&memctl_lock);
+	if (!memctl) {
+		err = -EINVAL;
+		goto unlock;
+	}
+	if (buf->call.func_code == MEMCTL_INFO) {
+		memcpy(&buf->info, &memctl->memctl_vmm_info, sizeof(buf->info));
+		goto unlock;
+	}
+
+	memctl_send_request(memctl, buf);
+
+unlock:
+	read_unlock(&memctl_lock);
+	return err;
+}
+
+/*
+ * Used for internal kernel memctl calls, i.e. to better support kernel stacks,
+ * or to efficiently zero hugetlb pages.
+ */
+long memctl_vmm_call(__u64 func_code, __u64 addr, __u64 length, __u64 arg,
+		     struct memctl_buf *buf)
+{
+	buf->call.func_code = func_code;
+	buf->call.addr = addr;
+	buf->call.length = length;
+	buf->call.arg = arg;
+
+	return __memctl_vmm_call(buf);
+}
+EXPORT_SYMBOL(memctl_vmm_call);
+
+static int memctl_init_info(struct memctl *dev, struct memctl_buf *buf)
+{
+	buf->call.func_code = MEMCTL_INFO;
+
+	memctl_send_request(dev, buf);
+	if (buf->ret.ret_code)
+		return buf->ret.ret_code;
+
+	/* Initialize global memctl_vmm_info */
+	memcpy(&dev->memctl_vmm_info, &buf->info, sizeof(dev->memctl_vmm_info));
+	pr_debug("memctl_vmm_info:\n"
+		 "memctl_vmm_info.ret_errno = %u\n"
+		 "memctl_vmm_info.ret_code = %u\n"
+		 "memctl_vmm_info.big_endian = %llu\n"
+		 "memctl_vmm_info.major_version = %u\n"
+		 "memctl_vmm_info.minor_version = %u\n"
+		 "memctl_vmm_info.page_size = %llu\n",
+		 dev->memctl_vmm_info.ret_errno, dev->memctl_vmm_info.ret_code,
+		 dev->memctl_vmm_info.big_endian,
+		 dev->memctl_vmm_info.major_version,
+		 dev->memctl_vmm_info.minor_version,
+		 dev->memctl_vmm_info.page_size);
+
+	return 0;
+}
+
+static int memctl_open(struct inode *inode, struct file *filp)
+{
+	struct memctl_buf *buf = NULL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	/* Do not allow exclusive open */
+	if (filp->f_flags & O_EXCL)
+		return -EINVAL;
+
+	buf = kzalloc(sizeof(struct memctl_buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Overwrite the misc device set by misc_register */
+	filp->private_data = buf;
+	return 0;
+}
+
+static int memctl_release(struct inode *inode, struct file *filp)
+{
+	kfree(filp->private_data);
+	filp->private_data = NULL;
+	return 0;
+}
+
+static long memctl_ioctl(struct file *filp, unsigned int cmd,
+			 unsigned long ioctl_param)
+{
+	struct memctl_buf *buf = filp->private_data;
+	int err;
+
+	if (cmd != MEMCTL_IOCTL_VMM)
+		return -EINVAL;
+
+	if (copy_from_user(&buf->call, (void __user *)ioctl_param,
+			   sizeof(struct memctl_buf)))
+		return -EFAULT;
+
+	err = __memctl_vmm_call(buf);
+	if (err)
+		return err;
+
+	if (copy_to_user((void __user *)ioctl_param, &buf->ret,
+			 sizeof(struct memctl_buf)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static const struct file_operations memctl_fops = {
+	.owner = THIS_MODULE,
+	.open = memctl_open,
+	.release = memctl_release,
+	.unlocked_ioctl = memctl_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+static struct miscdevice memctl_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = KBUILD_MODNAME,
+	.fops = &memctl_fops,
+};
+
+static int memctl_connect(struct memctl *memctl)
+{
+	int cpu;
+	u32 cmd;
+
+	memctl_write_command(memctl->base_addr, MEMCTL_TRANSPORT_RESET);
+	cmd = memctl_read_command(memctl->base_addr);
+	if (cmd != MEMCTL_TRANSPORT_ACK) {
+		pr_err("failed to reset device, cmd 0x%x\n", cmd);
+		return -EINVAL;
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct memctl_percpu_channel *channel =
+			per_cpu_ptr(memctl->pcpu_channels, cpu);
+
+		memctl_write_reg(memctl->base_addr, channel->buf_phys_addr);
+		memctl_write_command(memctl->base_addr,
+				     MEMCTL_TRANSPORT_REGISTER);
+
+		cmd = memctl_read_command(memctl->base_addr);
+		if (cmd != MEMCTL_TRANSPORT_ACK) {
+			pr_err("failed to register pcpu buf, cmd 0x%x\n", cmd);
+			return -EINVAL;
+		}
+		channel->command = memctl_read_resp(memctl->base_addr);
+	}
+
+	memctl_write_command(memctl->base_addr, MEMCTL_TRANSPORT_READY);
+	cmd = memctl_read_command(memctl->base_addr);
+	if (cmd != MEMCTL_TRANSPORT_ACK) {
+		pr_err("failed to ready device, cmd 0x%x\n", cmd);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int memctl_disconnect(struct memctl *memctl)
+{
+	u32 cmd;
+
+	memctl_write_command(memctl->base_addr, MEMCTL_TRANSPORT_DISCONNECT);
+
+	cmd = memctl_read_command(memctl->base_addr);
+	if (cmd != MEMCTL_TRANSPORT_ERROR) {
+		pr_err("failed to disconnect device, cmd 0x%x\n", cmd);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int memctl_alloc_percpu_channels(struct memctl *memctl)
+{
+	int cpu;
+
+	memctl->pcpu_channels = alloc_percpu_gfp(struct memctl_percpu_channel,
+						 GFP_ATOMIC | __GFP_ZERO);
+	if (!memctl->pcpu_channels)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct memctl_percpu_channel *channel =
+			per_cpu_ptr(memctl->pcpu_channels, cpu);
+		phys_addr_t buf_phys = per_cpu_ptr_to_phys(&channel->buf);
+
+		channel->buf_phys_addr = buf_phys;
+	}
+	return 0;
+}
+
+static int memctl_init(void __iomem *base_addr)
+{
+	struct memctl_buf *buf = NULL;
+	struct memctl *dev = NULL;
+	int err = 0;
+
+	err = misc_register(&memctl_dev);
+	if (err)
+		return err;
+
+	/* We take a spinlock for a long time, but this is only during init. */
+	write_lock(&memctl_lock);
+	if (WARN(READ_ONCE(memctl), "multiple memctl devices present")) {
+		err = -EEXIST;
+		goto fail_free;
+	}
+
+	dev = kzalloc(sizeof(struct memctl), GFP_ATOMIC);
+	buf = kzalloc(sizeof(struct memctl_buf), GFP_ATOMIC);
+	if (!dev || !buf) {
+		err = -ENOMEM;
+		goto fail_free;
+	}
+
+	dev->base_addr = base_addr;
+
+	err = memctl_alloc_percpu_channels(dev);
+	if (err)
+		goto fail_free;
+
+	err = memctl_connect(dev);
+	if (err)
+		goto fail_free;
+
+	err = memctl_init_info(dev, buf);
+	if (err)
+		goto fail_free;
+
+	WRITE_ONCE(memctl, dev);
+	write_unlock(&memctl_lock);
+	return 0;
+
+fail_free:
+	write_unlock(&memctl_lock);
+	kfree(dev);
+	kfree(buf);
+	misc_deregister(&memctl_dev);
+	return err;
+}
+
+static int memctl_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	void __iomem *base_addr;
+	int err;
+
+	err = pcim_enable_device(dev);
+	if (err < 0)
+		return err;
+
+	base_addr = pcim_iomap(dev, 0, 0);
+	if (!base_addr)
+		return -ENOMEM;
+
+	err = memctl_init(base_addr);
+	if (err)
+		pci_disable_device(dev);
+
+	return err;
+}
+
+static void __exit memctl_pci_remove(struct pci_dev *_dev)
+{
+	int err;
+	struct memctl *dev;
+
+	write_lock(&memctl_lock);
+	dev = READ_ONCE(memctl);
+	if (!dev) {
+		err = -EINVAL;
+		pr_err("cleanup called when uninitialized\n");
+		write_unlock(&memctl_lock);
+		return;
+	}
+
+	/* disconnect */
+	err = memctl_disconnect(dev);
+	if (err)
+		pr_err("device did not ack disconnect");
+	/* free percpu channels */
+	free_percpu(dev->pcpu_channels);
+
+	kfree(dev);
+	WRITE_ONCE(memctl, NULL);
+	write_unlock(&memctl_lock);
+	misc_deregister(&memctl_dev);
+}
+
+static const struct pci_device_id memctl_pci_id_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_GOOGLE, PCI_DEVICE_ID_GOOGLE_MEMCTL) },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, memctl_pci_id_tbl);
+
+static struct pci_driver memctl_pci_driver = {
+	.name = "memctl",
+	.id_table = memctl_pci_id_tbl,
+	.probe = memctl_pci_probe,
+	.remove = memctl_pci_remove,
+};
+module_pci_driver(memctl_pci_driver);
+
+MODULE_AUTHOR("Yuanchu Xie <yuanchu@google.com>");
+MODULE_DESCRIPTION("memctl Guest Service Module");
+MODULE_VERSION(MEMCTL_VERSION);
+MODULE_LICENSE("GPL");
diff --git a/include/linux/memctl.h b/include/linux/memctl.h
new file mode 100644
index 000000000000..5e1073134692
--- /dev/null
+++ b/include/linux/memctl.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Kernel interface for /dev/memctl - memctl Guest Memory Service Module
+ *
+ * Copyright (c) 2021, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _MEMCTL_H
+#define _MEMCTL_H
+
+#include <uapi/linux/memctl.h>
+#include <linux/errno.h>
+
+#ifdef CONFIG_MEMCTL
+/* buf must be kzalloc'd */
+long memctl_vmm_call(__u64 func_code, __u64 addr, __u64 length, __u64 arg,
+		     struct memctl_buf *buf);
+#else
+static inline long memctl_vmm_call(__u64 func_code, __u64 addr, __u64 length,
+				   __u64 arg, struct memctl_buf *buf)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_MEMCTL */
+
+#endif /* _MEMCTL_H */
diff --git a/include/uapi/linux/memctl.h b/include/uapi/linux/memctl.h
new file mode 100644
index 000000000000..a7b9a4e65e51
--- /dev/null
+++ b/include/uapi/linux/memctl.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for /dev/memctl - memctl Guest Memory Service Module
+ *
+ * Copyright (c) 2021, Google LLC.
+ * Yuanchu Xie <yuanchu@google.com>
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _UAPI_MEMCTL_H
+#define _UAPI_MEMCTL_H
+
+#include <linux/wait.h>
+#include <linux/types.h>
+#include <asm/param.h>
+
+/* Contains the function code and arguments for specific function */
+struct memctl_vmm_call {
+	__u64 func_code;	/* memctl set function code */
+	__u64 addr;		/* hyper. page size aligned guest phys. addr */
+	__u64 length;		/* hyper. page size aligned length */
+	__u64 arg;		/* function code specific argument */
+};
+
+/* Is filled on return to guest from VMM from most function calls */
+struct memctl_vmm_ret {
+	__u32 ret_errno;	/* on error, value of errno */
+	__u32 ret_code;		/* memctl internal error code, on success 0 */
+	__u64 ret_value;	/* return value from the function call */
+	__u64 arg0;		/* currently unused */
+	__u64 arg1;		/* currently unused */
+};
+
+/* Is filled on return to guest from VMM from MEMCTL_INFO function call */
+struct memctl_vmm_info {
+	__u32 ret_errno;	/* on error, value of errno */
+	__u32 ret_code;		/* memctl internal error code, on success 0 */
+	__u64 big_endian;	/* non-zero when hypervisor is big endian */
+	__u32 major_version;	/* VMM memctl backend major version */
+	__u32 minor_version;	/* VMM memctl backend minor version */
+	__u64 page_size;	/* hypervisor page size */
+};
+
+struct memctl_buf {
+	union {
+		struct memctl_vmm_call call;
+		struct memctl_vmm_ret ret;
+		struct memctl_vmm_info info;
+	};
+};
+
+/* The ioctl type, documented in ioctl-number.rst */
+#define MEMCTL_IOCTL_TYPE		0xDA
+
+#define MEMCTL_IOCTL_VMM _IOWR(MEMCTL_IOCTL_TYPE, 0x00, struct memctl_buf)
+
+/* Get memctl_vmm_info, addr, length, and arg are ignored */
+#define MEMCTL_INFO		0
+
+/* Memctl calls, memctl_vmm_return is returned */
+#define MEMCTL_DONTNEED		1 /* madvise(addr, len, MADV_DONTNEED); */
+#define MEMCTL_REMOVE		2 /* madvise(addr, len, MADV_MADV_REMOVE); */
+#define MEMCTL_FREE		3 /* madvise(addr, len, MADV_FREE); */
+#define MEMCTL_PAGEOUT		4 /* madvise(addr, len, MADV_PAGEOUT); */
+
+#define MEMCTL_UNMERGEABLE	5 /* madvise(addr, len, MADV_UNMERGEABLE); */
+#define MEMCTL_DONTDUMP		6 /* madvise(addr, len, MADV_DONTDUMP); */
+
+#define MEMCTL_MLOCK		7 /* mlock2(addr, len, 0) */
+#define MEMCTL_MUNLOCK		8 /* munlock(addr, len) */
+
+#define MEMCTL_MPROTECT_NONE	9 /* mprotect(addr, len, PROT_NONE) */
+#define MEMCTL_MPROTECT_R	10 /* mprotect(addr, len, PROT_READ) */
+#define MEMCTL_MPROTECT_W	11 /* mprotect(addr, len, PROT_WRITE) */
+/* mprotect(addr, len, PROT_READ | PROT_WRITE) */
+#define MEMCTL_MPROTECT_RW	12
+
+/* prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, addr, len, arg) */
+#define MEMCTL_SET_VMA_ANON_NAME 13
+
+#endif /* _UAPI_MEMCTL_H */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

