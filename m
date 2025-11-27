Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA462BF3D7
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 03:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213879; cv=none; b=QfXrk80zbD5EIrE+IbzO4v9INnVqyIClyfDg8MuyPC5oLzbBA7nRpleOpJQnaYqrgi1+5WytWEqeRVSkwtNIascgKgLcMtF18VM5JbjcQ13+xHB7fxrLuEKToppDan+weXPemc1+znmVWC+n8H4Tu173XYyG31iCCg2lrpSiaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213879; c=relaxed/simple;
	bh=m6TZtQxOwNI7zDTc5Dffz0AeArXfjeHSX0Ftd3iPHp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOLGmxvMhL7890jxPAhzpiv6jJ/Wk9hJngkjPW75SoNr42shTPPUgJ2pL2rrLcwUSH1I5GExW06s6uJ1o00e1O2xnXq+A/xpIi+vxMsqNddjBr5BUxibQj4KWK3wLgKcpyJDRIjnwV8xvU/W7xyjXTCozkgIzxaYzHj1u5Hfd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fXt8xPbX; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fXt8xPbX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hF
	1YPEn9rzOyxNXZsWYoHD03FGU5Fu5aljxP1kSNnzw=; b=fXt8xPbXfyt0yVc8Dc
	hyY+NoUjp/AY91Jgo/NU9FrKLIxdpRXhmTl6HzXV+m/xrunJT4tjsuVukkyRwNgF
	lvcqNpYCC8RMpuG6TktiUceRVXo70UXeJR/81Zf8GxpsjNW6AE8O6SFKpBKI23/k
	eaXHfMAA1zuov/6AxDRYgttDY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX4NVfxCdptnYQFg--.3639S3;
	Thu, 27 Nov 2025 11:24:21 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH v1 1/7] tools/virtio/virtnet_mon: create misc driver for virtnet_mon
Date: Thu, 27 Nov 2025 11:24:01 +0800
Message-Id: <20251127032407.33475-2-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251127032407.33475-1-lange_tang@163.com>
References: <20251127032407.33475-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCX4NVfxCdptnYQFg--.3639S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFW8urWUJryxtrykGr4fAFb_yoWrXr17pF
	45Ary3trWkJws3WayrJFZ8XryFkrn7uw1Igry7Ww1q9FnrJr1DAFy8tFy2kFy7AFW7Gr48
	WFnFga9Y93Z7ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKQ6JbUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/1tbiXAoTLmknwHtvOwAAsK

From: Tang Longjun <tanglongjun@kylinos.cn>

create a misc type driver for transferring log information between
user space and kernel space by /dev/virtnet_mon

Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
---
 tools/virtio/virtnet_mon/Makefile      |  10 +++
 tools/virtio/virtnet_mon/virtnet_mon.c | 110 +++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 tools/virtio/virtnet_mon/Makefile
 create mode 100644 tools/virtio/virtnet_mon/virtnet_mon.c

diff --git a/tools/virtio/virtnet_mon/Makefile b/tools/virtio/virtnet_mon/Makefile
new file mode 100644
index 000000000000..a443f62dbde4
--- /dev/null
+++ b/tools/virtio/virtnet_mon/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-m += virtnet_mon.o
+
+KDIR := `pwd`/../../..
+
+all:
+	make -C $(KDIR) M=$(PWD) modules
+
+clean:
+	make -C $(KDIR) M=$(PWD) clean
diff --git a/tools/virtio/virtnet_mon/virtnet_mon.c b/tools/virtio/virtnet_mon/virtnet_mon.c
new file mode 100644
index 000000000000..6e768ea5e28d
--- /dev/null
+++ b/tools/virtio/virtnet_mon/virtnet_mon.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+#include <linux/poll.h>
+#include <linux/string.h>
+#include <linux/if_ether.h>
+
+
+#define DEVICE_NAME "virtnet_mon"
+
+static struct miscdevice virtnet_mon_misc_device;
+
+static char buf[1024];
+static int buf_len;
+
+// open device
+static int virtnet_mon_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+// close device
+static int virtnet_mon_release(struct inode *inode, struct file *file)
+{
+    //pr_debug(KERN_INFO "virtnet_mon: Device closed\n");
+
+	return 0;
+}
+
+// read device
+static ssize_t virtnet_mon_read(struct file *file, char __user *buffer, size_t len, loff_t *offset)
+{
+	len = buf_len;
+	if (copy_to_user(buffer, buf, buf_len))
+		return -EFAULT;
+
+	buf_len = 0;
+	memset(buf, 0, sizeof(buf));
+	return len;
+}
+
+// write device
+static ssize_t virtnet_mon_write(struct file *file, const char __user *buffer,
+							size_t len, loff_t *offset)
+{
+	memset(buf, 0, sizeof(buf));
+	if (copy_from_user(buf, buffer, len))
+		return -EFAULT;
+
+	buf_len = len;
+	pr_info("virtnet_mon: Written: %s\n", buf);
+
+	return len;
+}
+
+// poll method
+static unsigned int virtnet_mon_poll(struct file *file, poll_table *wait)
+{
+	return 0;
+}
+
+// file operations structure
+static const struct file_operations virtnet_mon_misc_fops = {
+	.owner = THIS_MODULE,
+	.open = virtnet_mon_open,
+	.release = virtnet_mon_release,
+	.read = virtnet_mon_read,
+	.write = virtnet_mon_write,
+	.poll = virtnet_mon_poll,
+};
+
+// module load
+static int __init virtnet_mon_init(void)
+{
+	int ret;
+
+	// register misc device
+	virtnet_mon_misc_device.minor = MISC_DYNAMIC_MINOR;
+	virtnet_mon_misc_device.name = DEVICE_NAME;
+	virtnet_mon_misc_device.fops = &virtnet_mon_misc_fops;
+
+	ret = misc_register(&virtnet_mon_misc_device);
+	if (ret) {
+		pr_info("virtnet_mon: Failed to register misc device\n");
+
+		return ret;
+	}
+	pr_info("virtnet_mon registered with minor number %d\n", virtnet_mon_misc_device.minor);
+
+	return 0;
+}
+
+// module unload
+static void __exit virtnet_mon_exit(void)
+{
+	misc_deregister(&virtnet_mon_misc_device);
+	pr_info("virtnet_mon unregistered\n");
+}
+
+module_init(virtnet_mon_init);
+module_exit(virtnet_mon_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tang Longjun");
+MODULE_DESCRIPTION("Monitor virtio_net driver packet transmission and reception");
+MODULE_VERSION("0.1");
-- 
2.43.0

