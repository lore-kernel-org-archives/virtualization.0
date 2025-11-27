Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A732BF006
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 03:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213879; cv=none; b=lQ2+9JepPLR/vUckuz6Uai/8lXhLzsotSeUtTLwPvL/Db+UuWTUM3vOZ/WGgNflOMoU61PIKZe0BAUfFLa47ddsJitNoCKy82Q5nval8m2is13DG6y8hfTEb3sPNgRUvyd06AZuh2Vv5Ie9PF/LZcTD7JJrh467aawUdLHYPiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213879; c=relaxed/simple;
	bh=73ce8vzPDeXUjXzq8QKesbQavsD1AlPtlEcfwxCTff8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxtrJ+0FAlQJ6xrWbSjz0pcpvJm9Y5sXHHnGe3LTwD2CZQ3FcSFCXkLvJKUvgmgMgtj1xEDHbDKJwRjt9pVN+lZWCha7NpavjpiWXD5P2aGI8MZZ+JbGqRji5rvwz7uRjdxJsxNcsT/oiawAH67XRWXPLQ8g9fXYOwc1Jh8GBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NBqKdu2E; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NBqKdu2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SN
	ME6LdZDoS/Pd9Q1unrUE5hQCc1M7eIxFVuz8DExSo=; b=NBqKdu2ExPVNor9gJ0
	RYdy/4rVG5eHvlUBCtLN7vBi8CuKnYkPEcCYALfAFUYxD3NYRdALlxa+L6z7zkMi
	yaFUGNg5J+rkSAfXOshhj8DQq4FVfNhEwG8MDig+KqIRmXGABGLTLWafAhIq5lo3
	LwR92AYu5kTklJsNz2y2tsVdQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX4NVfxCdptnYQFg--.3639S4;
	Thu, 27 Nov 2025 11:24:23 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH v1 2/7] tools/virtio/virtnet_mon: add kfifo to virtnet_mon
Date: Thu, 27 Nov 2025 11:24:02 +0800
Message-Id: <20251127032407.33475-3-lange_tang@163.com>
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
X-CM-TRANSID:PigvCgCX4NVfxCdptnYQFg--.3639S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyUuryktr17JF15ZFy5Arb_yoW5tFy5pr
	45Ka4YqrZ3X3ZxXay8Aa98XryYvFn7Jw1IgrW7W34DuFnrJr1qvFy5ta4UKFySyF4xXr18
	Wr9rJanYgan7Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zReMKAUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/1tbiXRITLmknwAJ8yQAAsL

From: Tang Longjun <tanglongjun@kylinos.cn>

introduce kfifo buffers to support more frequent log output
or file writing

Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
---
 tools/virtio/virtnet_mon/virtnet_mon.c | 57 ++++++++++++++++++--------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/tools/virtio/virtnet_mon/virtnet_mon.c b/tools/virtio/virtnet_mon/virtnet_mon.c
index 6e768ea5e28d..696e621cf803 100644
--- a/tools/virtio/virtnet_mon/virtnet_mon.c
+++ b/tools/virtio/virtnet_mon/virtnet_mon.c
@@ -6,16 +6,14 @@
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
-#include <linux/string.h>
-#include <linux/if_ether.h>
-
 
 #define DEVICE_NAME "virtnet_mon"
+#define KFIFO_SIZE 1024     // ring buffer size
 
+static DEFINE_KFIFO(virtnet_mon_kfifo, char, KFIFO_SIZE);
 static struct miscdevice virtnet_mon_misc_device;
 
-static char buf[1024];
-static int buf_len;
+static DECLARE_WAIT_QUEUE_HEAD(virtnet_mon_wq);
 
 // open device
 static int virtnet_mon_open(struct inode *inode, struct file *file)
@@ -34,33 +32,56 @@ static int virtnet_mon_release(struct inode *inode, struct file *file)
 // read device
 static ssize_t virtnet_mon_read(struct file *file, char __user *buffer, size_t len, loff_t *offset)
 {
-	len = buf_len;
-	if (copy_to_user(buffer, buf, buf_len))
+	unsigned int copied;
+	char kfifo_buffer[KFIFO_SIZE];
+
+	// read data from kfifo
+	if (kfifo_is_empty(&virtnet_mon_kfifo))
+		return 0;
+
+	// read data and copy to user space
+	copied = kfifo_out(&virtnet_mon_kfifo, kfifo_buffer, len);
+	if (copy_to_user(buffer, kfifo_buffer, copied))
 		return -EFAULT;
 
-	buf_len = 0;
-	memset(buf, 0, sizeof(buf));
-	return len;
+	//pr_debug(KERN_INFO "virtnet_mon: Read %u bytes from kfifo\n", copied);
+
+	return copied;
 }
 
 // write device
 static ssize_t virtnet_mon_write(struct file *file, const char __user *buffer,
 							size_t len, loff_t *offset)
 {
-	memset(buf, 0, sizeof(buf));
-	if (copy_from_user(buf, buffer, len))
+	unsigned int copied;
+	char kfifo_buffer[KFIFO_SIZE];
+
+	// copy data from user space to kfifo
+	if (len > KFIFO_SIZE)
+		len = KFIFO_SIZE;
+
+	if (copy_from_user(kfifo_buffer, buffer, len))
 		return -EFAULT;
 
-	buf_len = len;
-	pr_info("virtnet_mon: Written: %s\n", buf);
+	copied = kfifo_in(&virtnet_mon_kfifo, kfifo_buffer, len);
+	pr_info("virtnet_mon: Written %u bytes to kfifo\n", copied);
+
+	wake_up_interruptible(&virtnet_mon_wq);
 
-	return len;
+	return copied;
 }
 
 // poll method
 static unsigned int virtnet_mon_poll(struct file *file, poll_table *wait)
 {
-	return 0;
+	unsigned int mask = 0;
+
+	poll_wait(file, &virtnet_mon_wq, wait);
+
+	if (!kfifo_is_empty(&virtnet_mon_kfifo))
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
 }
 
 // file operations structure
@@ -89,8 +110,8 @@ static int __init virtnet_mon_init(void)
 
 		return ret;
 	}
-	pr_info("virtnet_mon registered with minor number %d\n", virtnet_mon_misc_device.minor);
 
+	pr_info("virtnet_mon registered with minor number %d\n", virtnet_mon_misc_device.minor);
 	return 0;
 }
 
@@ -107,4 +128,4 @@ module_exit(virtnet_mon_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Tang Longjun");
 MODULE_DESCRIPTION("Monitor virtio_net driver packet transmission and reception");
-MODULE_VERSION("0.1");
+MODULE_VERSION("0.2");
-- 
2.43.0

