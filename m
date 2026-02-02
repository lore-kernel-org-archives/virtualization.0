Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CA2D77E3;
	Mon,  2 Feb 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072536; cv=none; b=JQNeaA9IK2S3EhmP/6gSM8PCB+aMu4A75Zuz4p80Ro6gJfRSUOldU6MMTlHrfFM5RKYmc4z5vSe8J/YMNJjsbTbsgvSmbs8JRefR6hQS71BNNp9CCaJkQ6d4Iu34SVA+sa4GlcxQv9JSBEDSl22U7sonoGkH8tZ/UzKiCyvQsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072536; c=relaxed/simple;
	bh=2SQk6akRnaJrtIkyw0e1kuGJW8iEQ/1VXNLrxse1/Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvmlV+fzH8a+UgumZc89tkPmbe19PWnM9k6amEeCjCXl+Zpoi235GInd4ALdjivAMgNjX28ITyq7LGmIoWQRTYAA3aUj0NSTD1pzj+AgBn0G9H4XEdzAAnlXoA9sQ4QCToVL681DO4cd3zTRtfhENw28Yzz+sIjQ2EN8eCNfufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjWyEUAf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjWyEUAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCA0C116C6;
	Mon,  2 Feb 2026 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770072536;
	bh=2SQk6akRnaJrtIkyw0e1kuGJW8iEQ/1VXNLrxse1/Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjWyEUAfT3DxKONc8hQCQSbOvfqFjl9L6OdMc658VwYjwwxemxAfJSaaD9MoJWQ6W
	 ayf/9mrv1HEj5uSWPuFI60ab34RQl9J4FZ982INCFeaFsinCDW8XbtGlBshjgdnLq8
	 m5ZFoAs1yFx8eBrsZ64+IJjWnUUmMp2FOAwSm82HnCsF5kYribq0vYgPL/nb5K58x3
	 jrWj4pTqrCmPvZFz4hpgJLsUwSt86fgoj2llStxffae4dLfch8DTNCVzBom0hOZm5z
	 bSUIWA9IpDYZF4YwvFIJpDhDCGl/CSoOX6jSsm9xMtgrixKA9mLdYMu5IYDZPdpB3x
	 DXfBF/pBAxaaA==
From: Arnd Bergmann <arnd@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2] vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Date: Mon,  2 Feb 2026 23:48:08 +0100
Message-Id: <20260202224835.559538-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260202224835.559538-1-arnd@kernel.org>
References: <20260202224835.559538-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

These two ioctls are incompatible on 32-bit x86 userspace, because
the data structures are shorter than they are on 64-bit.

Add a proper .compat_ioctl handler for x86 that reads the structures
with the smaller padding before calling the internal handlers.

Fixes: ad146355bfad ("vduse: Support querying information of IOVA regions")
Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The code is directly copied from the native ioctl handler, but I
did not test this with actual x86-32 userspace, so please review
carefully.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 123 ++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 405d59610f76..3ada167ac260 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1618,6 +1618,127 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
+/*
+ * i386 has different alignment constraints than x86_64,
+ * so there are only 3 bytes of padding instead of 7.
+ */
+struct compat_vduse_iotlb_entry {
+	compat_u64 offset;
+	compat_u64 start;
+	compat_u64 last;
+	__u8 perm;
+	__u8 padding[__alignof__(compat_u64) - 1];
+};
+#define COMPAT_VDUSE_IOTLB_GET_FD	_IOWR(VDUSE_BASE, 0x10, struct compat_vduse_iotlb_entry)
+
+struct compat_vduse_vq_info {
+	__u32 index;
+	__u32 num;
+	compat_u64 desc_addr;
+	compat_u64 driver_addr;
+	compat_u64 device_addr;
+	union {
+		struct vduse_vq_state_split split;
+		struct vduse_vq_state_packed packed;
+	};
+	__u8 ready;
+	__u8 padding[__alignof__(compat_u64) - 1];
+} __uapi_arch_align;
+#define COMPAT_VDUSE_VQ_GET_INFO	_IOWR(VDUSE_BASE, 0x15, struct compat_vduse_vq_info)
+
+static long vduse_dev_compat_ioctl(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	struct vduse_dev *dev = file->private_data;
+	void __user *argp = (void __user *)arg;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return vduse_dev_ioctl(file, cmd,
+				       (unsigned long)compat_ptr(arg));
+
+	if (unlikely(dev->broken))
+		return -EPERM;
+
+	switch (cmd) {
+	case COMPAT_VDUSE_IOTLB_GET_FD: {
+		struct vduse_iotlb_entry_v2 entry = {0};
+		struct file *f = NULL;
+
+		ret = -EFAULT;
+		if (copy_from_user(&entry, argp, _IOC_SIZE(cmd)))
+			break;
+
+		ret = vduse_dev_iotlb_entry(dev, &entry, &f, NULL);
+		if (ret)
+			break;
+
+		ret = -EINVAL;
+		if (!f)
+			break;
+
+		ret = copy_to_user(argp, &entry, _IOC_SIZE(cmd));
+		if (ret) {
+			ret = -EFAULT;
+			fput(f);
+			break;
+		}
+		ret = receive_fd(f, NULL, perm_to_file_flags(entry.perm));
+		fput(f);
+		break;
+	}
+	case COMPAT_VDUSE_VQ_GET_INFO: {
+		struct vduse_vq_info vq_info = {};
+		struct vduse_virtqueue *vq;
+		u32 index;
+
+		ret = -EFAULT;
+		if (copy_from_user(&vq_info, argp,
+				   sizeof(struct compat_vduse_vq_info)))
+			break;
+
+		ret = -EINVAL;
+		if (vq_info.index >= dev->vq_num)
+			break;
+
+		index = array_index_nospec(vq_info.index, dev->vq_num);
+		vq = dev->vqs[index];
+		vq_info.desc_addr = vq->desc_addr;
+		vq_info.driver_addr = vq->driver_addr;
+		vq_info.device_addr = vq->device_addr;
+		vq_info.num = vq->num;
+
+		if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED)) {
+			vq_info.packed.last_avail_counter =
+				vq->state.packed.last_avail_counter;
+			vq_info.packed.last_avail_idx =
+				vq->state.packed.last_avail_idx;
+			vq_info.packed.last_used_counter =
+				vq->state.packed.last_used_counter;
+			vq_info.packed.last_used_idx =
+				vq->state.packed.last_used_idx;
+		} else
+			vq_info.split.avail_index =
+				vq->state.split.avail_index;
+
+		vq_info.ready = vq->ready;
+
+		ret = -EFAULT;
+		if (copy_to_user(argp, &vq_info,
+		    sizeof(struct compat_vduse_vq_info)))
+			break;
+
+		ret = 0;
+		break;
+	}
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	return vduse_dev_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+
 static int vduse_dev_release(struct inode *inode, struct file *file)
 {
 	struct vduse_dev *dev = file->private_data;
@@ -1678,7 +1799,7 @@ static const struct file_operations vduse_dev_fops = {
 	.write_iter	= vduse_dev_write_iter,
 	.poll		= vduse_dev_poll,
 	.unlocked_ioctl	= vduse_dev_ioctl,
-	.compat_ioctl	= compat_ptr_ioctl,
+	.compat_ioctl	= PTR_IF(IS_ENABLED(CONFIG_COMPAT), vduse_dev_compat_ioctl),
 	.llseek		= noop_llseek,
 };
 
-- 
2.39.5

