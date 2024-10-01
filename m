Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAABA33
	for <virtualization@lists.linux.dev>; Tue,  1 Oct 2024 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745216; cv=none; b=lWVEiDTxUCFqCUETd/cwsQFV7vgsAb2Dzq+S4IgmaWnnXYd9lH7cx0kzRFVAxoQnXtkDbBQr37KsvCf8C12u1a0DaUhD52Oreb86nMVNG/gU/HCqpQ3qIEP6qUn4JTKlbCR1DgkYbeiKlK4afnvxrYIdBPu0JFU8FWu0kok/gjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745216; c=relaxed/simple;
	bh=fvET4WimVCRU7VHsRopd2wnF5QZnsQcg74THf2nhuEA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sh1oEMn0VqvScPK1hzk2MjvYgWI0O+VJj7ksV8T7Gh6HABXUqg/S4azabdi2MUFpn6FYt5/PfTy9S1yIGvYwLCjJpio60FqFmtKU8WhfsV4Z1HeyeGM8Mx9b+/4UVL7CNcEK2fLgtcVz0msuCJfRsxPIolaA/NULtoGhbLoHwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlEsRy3w; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlEsRy3w"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e25a6fddb0so34220407b3.0
        for <virtualization@lists.linux.dev>; Mon, 30 Sep 2024 18:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727745213; x=1728350013; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SHVt1ELgoOHLUBfp3mdrcV7h7la/S1dW6RjaMaF0PH8=;
        b=hlEsRy3wP10BI5e5kfIN1GbD8up5lK+RHsQDAYJgRczbYSnGWUigjzBRt+w/sIYxzv
         fDQ8dvQnZiVlN6oJApMy8uFuexm8RdJj+hQHpWRhYK+oDqUBlxG1z7zrNoCuw7knKnAK
         h7p/SXBZfOUqy1AePquyLViGlmtpTPgiDMRZAEIUtpJEcoh7aLEcPF8/fLbpnCWee5gZ
         rzMD0v0HjPF/w8jveABvlEz6LGFUIy9rPzE28jmZqflOlKvwjsHKAId2cXMkj+hhEgjm
         7wxMxIievWJh81udIK4glsv7+6j1ZsoKsyv/+9BpRXbbuKBpzTTtYKE/2OYMX0HcegMO
         wJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727745213; x=1728350013;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHVt1ELgoOHLUBfp3mdrcV7h7la/S1dW6RjaMaF0PH8=;
        b=tI+kj9/wyZ63IhCrQ9dnh8Zm7sn8cd2tDeaAjspDNXnR6N2dyTGGZClwgFK8/tbgsm
         e2TAeJBIQfHoJ06kB1iemwy9byPnmoQoAhhYIs0S58s+iMIQC4XeZEIbinsLDqiWWSuI
         M9j1WF9IKnufYbkgs3UYfMdIibZtWXfysQrN2VDIZacyDfAUBbKIiG70XVNyOWLvgKDj
         INDXrMqdAkpEK7/NxwXhVbHX44hjIs3IpJUo4CgdoGfrlQILWybjYrjsQV78+R6nu6Wy
         BLLnFqqa2E4//2tE5scOtB1EkJCU5eEdMT+uHUq7aC/9RjawuQrYjNfCP3V12G/ftJPm
         6mVw==
X-Forwarded-Encrypted: i=1; AJvYcCWIRu7D7Gnt4vSneQiQSq06I+UfLw6KtqgtH32cggz/mEjMyCoBrR6tGeqZFTsPW/Tg+UlX5Rv3iLfu9tCl5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFhU8SA0veqsIK9iImQym3IhT3Y6wTGuq/WONYo9+/4tigWocc
	uF+zMxTIPnuVvkJ1Nnkv7tZwgsk5oO4qeUsB2OyWPLZKnLp1NucL8Lzsu2eA7+uruT39TXZXsa6
	nXQLYkA==
X-Google-Smtp-Source: AGHT+IEwIyVC1+03fF5Mo5gH5DzXLpH+LfWsM3ucekTDSvQF9rXEI8W898xmX68VBhejIijLirowH1HX2BK4
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4ba])
 (user=yuanchu job=sendgmr) by 2002:a25:2e4d:0:b0:e16:4d66:982e with SMTP id
 3f1490d57ef6-e2604b436d5mr61892276.5.1727745212563; Mon, 30 Sep 2024 18:13:32
 -0700 (PDT)
Date: Tue,  1 Oct 2024 01:13:26 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001011328.2806686-1-yuanchu@google.com>
Subject: [PATCH v2 1/2] virt: pvmemcontrol: control guest physical memory properties
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

Pvmemcontrol provides a way for the guest to control its physical memory
properties, and enables optimizations and security features. For
example, the guest can provide information to the host where parts of a
hugepage may be unbacked, or sensitive data may not be swapped out, etc.

Pvmemcontrol allows guests to manipulate its gPTE entries in the SLAT,
and also some other properties of the memory map the back's host memory.
This is achieved by using the KVM_CAP_SYNC_MMU capability. When this
capability is available, the changes in the backing of the memory region
on the host are automatically reflected into the guest. For example, an
mmap() or madvise() that affects the region will be made visible
immediately.

There are two components of the implementation: the guest Linux driver
and Virtual Machine Monitor (VMM) device. A guest-allocated shared
buffer is negotiated per-cpu through a few PCI MMIO registers, the VMM
device assigns a unique command for each per-cpu buffer. The guest
writes its pvmemcontrol request in the per-cpu buffer, then writes the
corresponding command into the command register, calling into the VMM
device to perform the pvmemcontrol request.

The synchronous per-cpu shared buffer approach avoids the kick and busy
waiting that the guest would have to do with virtio virtqueue transport.

User API
From the userland, the pvmemcontrol guest driver is controlled via
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

-
Changelog
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

Change-Id: Ib9e4026df815a8ffd8d8b29ce13dd12ce3714e21

Add MADV_MERGEABLE to pvmemcontrol

Align pvmemcontrol comments

This change aligns the pvmemcontrol operation IDs and comments in the pvmemcontrol header file

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/pvmemcontrol/Kconfig             |  10 +
 drivers/virt/pvmemcontrol/Makefile            |   2 +
 drivers/virt/pvmemcontrol/pvmemcontrol.c      | 459 ++++++++++++++++++
 include/uapi/linux/pvmemcontrol.h             |  76 +++
 7 files changed, 552 insertions(+)
 create mode 100644 drivers/virt/pvmemcontrol/Kconfig
 create mode 100644 drivers/virt/pvmemcontrol/Makefile
 create mode 100644 drivers/virt/pvmemcontrol/pvmemcontrol.c
 create mode 100644 include/uapi/linux/pvmemcontrol.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d..34a9954cafc7 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -372,6 +372,8 @@ Code  Seq#    Include File                                           Comments
 0xCD  01     linux/reiserfs_fs.h
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
index 000000000000..f8a07114fad8
--- /dev/null
+++ b/drivers/virt/pvmemcontrol/pvmemcontrol.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Control guest physical memory properties by sending
+ * madvise-esque requests to the host VMM.
+ *
+ * Author: Yuanchu Xie <yuanchu@google.com>
+ * Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
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
+	void __iomem *base_addr;
+	struct device *device;
+	/* cache the info call */
+	struct pvmemcontrol_vmm_ret pvmemcontrol_vmm_info;
+	struct pvmemcontrol_percpu_channel __percpu *pcpu_channels;
+};
+
+static DEFINE_RWLOCK(pvmemcontrol_lock);
+static struct pvmemcontrol *pvmemcontrol __read_mostly;
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
+static int __pvmemcontrol_vmm_call(struct pvmemcontrol_buf *buf)
+{
+	int err = 0;
+
+	if (!pvmemcontrol)
+		return -EINVAL;
+
+	read_lock(&pvmemcontrol_lock);
+	if (!pvmemcontrol) {
+		err = -EINVAL;
+		goto unlock;
+	}
+	if (buf->call.func_code == PVMEMCONTROL_INFO) {
+		memcpy(&buf->ret, &pvmemcontrol->pvmemcontrol_vmm_info,
+		       sizeof(buf->ret));
+		goto unlock;
+	}
+
+	pvmemcontrol_send_request(pvmemcontrol, buf);
+
+unlock:
+	read_unlock(&pvmemcontrol_lock);
+	return err;
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
+	dev_info(dev->device,
+		 "pvmemcontrol_vmm_info.ret_errno = %u\n"
+		 "pvmemcontrol_vmm_info.ret_code = %u\n"
+		 "pvmemcontrol_vmm_info.major_version = %llu\n"
+		 "pvmemcontrol_vmm_info.minor_version = %llu\n"
+		 "pvmemcontrol_vmm_info.page_size = %llu\n",
+		 dev->pvmemcontrol_vmm_info.ret_errno,
+		 dev->pvmemcontrol_vmm_info.ret_code,
+		 dev->pvmemcontrol_vmm_info.arg0,
+		 dev->pvmemcontrol_vmm_info.arg1,
+		 dev->pvmemcontrol_vmm_info.ret_value);
+
+	return 0;
+}
+
+static int pvmemcontrol_open(struct inode *inode, struct file *filp)
+{
+	struct pvmemcontrol_buf *buf = NULL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	/* Do not allow exclusive open */
+	if (filp->f_flags & O_EXCL)
+		return -EINVAL;
+
+	buf = kzalloc(sizeof(struct pvmemcontrol_buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Overwrite the misc device set by misc_register */
+	filp->private_data = buf;
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
+	struct pvmemcontrol_buf *buf = filp->private_data;
+	int err;
+
+	if (cmd != PVMEMCONTROL_IOCTL_VMM)
+		return -EINVAL;
+
+	if (copy_from_user(&buf->call, (void __user *)ioctl_param,
+			   sizeof(struct pvmemcontrol_buf)))
+		return -EFAULT;
+
+	err = __pvmemcontrol_vmm_call(buf);
+	if (err)
+		return err;
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
+static struct miscdevice pvmemcontrol_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = KBUILD_MODNAME,
+	.fops = &pvmemcontrol_fops,
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
+		dev_err(pvmemcontrol->device,
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
+			dev_err(pvmemcontrol->device,
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
+		dev_err(pvmemcontrol->device,
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
+		dev_err(pvmemcontrol->device,
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
+static int pvmemcontrol_init(struct device *device, void __iomem *base_addr)
+{
+	struct pvmemcontrol_buf *buf = NULL;
+	struct pvmemcontrol *dev = NULL;
+	int err = 0;
+
+	err = misc_register(&pvmemcontrol_dev);
+	if (err)
+		return err;
+
+	/* We take a spinlock for a long time, but this is only during init. */
+	write_lock(&pvmemcontrol_lock);
+	if (READ_ONCE(pvmemcontrol)) {
+		dev_warn(device, "multiple pvmemcontrol devices present\n");
+		err = -EEXIST;
+		goto fail_free;
+	}
+
+	dev = kzalloc(sizeof(struct pvmemcontrol), GFP_ATOMIC);
+	buf = kzalloc(sizeof(struct pvmemcontrol_buf), GFP_ATOMIC);
+	if (!dev || !buf) {
+		err = -ENOMEM;
+		goto fail_free;
+	}
+
+	dev->base_addr = base_addr;
+	dev->device = device;
+
+	err = pvmemcontrol_alloc_percpu_channels(dev);
+	if (err)
+		goto fail_free;
+
+	err = pvmemcontrol_connect(dev);
+	if (err)
+		goto fail_free;
+
+	err = pvmemcontrol_init_info(dev, buf);
+	if (err)
+		goto fail_free;
+
+	WRITE_ONCE(pvmemcontrol, dev);
+	write_unlock(&pvmemcontrol_lock);
+	return 0;
+
+fail_free:
+	write_unlock(&pvmemcontrol_lock);
+	kfree(dev);
+	kfree(buf);
+	misc_deregister(&pvmemcontrol_dev);
+	return err;
+}
+
+static int pvmemcontrol_pci_probe(struct pci_dev *dev,
+				  const struct pci_device_id *id)
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
+	err = pvmemcontrol_init(&dev->dev, base_addr);
+	if (err)
+		pci_disable_device(dev);
+
+	return err;
+}
+
+static void pvmemcontrol_pci_remove(struct pci_dev *pci_dev)
+{
+	int err;
+	struct pvmemcontrol *dev;
+
+	write_lock(&pvmemcontrol_lock);
+	dev = READ_ONCE(pvmemcontrol);
+	if (!dev) {
+		err = -EINVAL;
+		dev_err(&pci_dev->dev, "cleanup called when uninitialized\n");
+		write_unlock(&pvmemcontrol_lock);
+		return;
+	}
+
+	/* disconnect */
+	err = pvmemcontrol_disconnect(dev);
+	if (err)
+		dev_err(&pci_dev->dev, "device did not ack disconnect\n");
+	/* free percpu channels */
+	free_percpu(dev->pcpu_channels);
+
+	kfree(dev);
+	WRITE_ONCE(pvmemcontrol, NULL);
+	write_unlock(&pvmemcontrol_lock);
+	misc_deregister(&pvmemcontrol_dev);
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
+module_pci_driver(pvmemcontrol_pci_driver);
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
-- 
2.46.1.824.gd892dcdcdd-goog

