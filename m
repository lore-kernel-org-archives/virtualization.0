Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644E194A60;
	Fri, 13 Feb 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997257; cv=none; b=DxpbxWSDC3ZVCkwoDwxxGgK/i23lyJa+7Cgd779UUKU3sl8npI3pYpmp4TfJO2Wz3de46Bgo6cX9dCXdZex4wR/OkAv9ZHAYFK4Vl52me7r+YbrkvDt1Jv6+W8D65jPtyqQptFiKAOrozqeH7uHIlai9gJIds/nTIemK8UX6vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997257; c=relaxed/simple;
	bh=plNiWAmAz/3wmy/voy09XFl5s2ajo4x9ohqdbJJ4rkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KXuXe34I6nuUpwwqKIkEu01VwdqdDyCsWiTA0GNc6RI+kFZ1sOxOwO7WRa5lbVEAmdNVjcMIXgFO5NjXhTgwy0M0Kb9pjAtDJE2QJHTF/kR7s1q9MEz+SRAuC/Cre/LfKcmuhIaoXAVDXhA+0Cn5F358CA3E0gVmvgLO0C0ooNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6BmWvTQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6BmWvTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89F5C116C6;
	Fri, 13 Feb 2026 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770997256;
	bh=plNiWAmAz/3wmy/voy09XFl5s2ajo4x9ohqdbJJ4rkk=;
	h=From:To:Cc:Subject:Date:From;
	b=B6BmWvTQ6oxLkwDShHEjZ2I+cSALEKZsB+bepUC5KDJ1Booym1hYfPqW+dAQ+LLXE
	 qBUwQQI+Ie2Rh4Erw7jweNllv3rxWEhouQzBXTiy4F53k8KFmk2o3mlzfbNEfRU5Rg
	 wDJcmVEJFm0qeYyT6f7bEV0b4G6qcEu/XD9o+GwZo9kWgSwtMYtJmPmAD4Xgx3/JPH
	 Q8heP8zdKkRWpbZxFf5MGGsy9eUQteDN3djxoLddmQdbsPw/j7UBJthj80KPy5SE50
	 O3qeUuygXc1r3PwHjFWFNJ3pabsAtPHNw9ATuvuB8bYhM2wcvQ8x14IuZdF+iMN+qE
	 BoyvOF+krRuEg==
From: Arnd Bergmann <arnd@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Date: Fri, 13 Feb 2026 16:40:46 +0100
Message-Id: <20260213154051.4172275-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

These two ioctls are incompatible on 32-bit x86 userspace, because
the data structures are shorter than they are on 64-bit.

Add a proper .compat_ioctl handler for x86 that reads the structures
with the smaller padding before calling the internal handlers. On
all other architectures, CONFIG_COMPAT_FOR_U64_ALIGNMENT is disabled
and no special handling is required.

Fixes: ad146355bfad ("vduse: Support querying information of IOVA regions")
Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3 changes:
 - check CONFIG_COMPAT_FOR_U64_ALIGNMENT in preprocessor
v2 changes:
 - split compat handler into separate function
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 123 ++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 405d59610f76..e0f5a7397221 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1618,6 +1618,127 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT_FOR_U64_ALIGNMENT
+/*
+ * i386 has different alignment constraints than x86_64,
+ * so there are only 3 bytes of padding instead of 7.
+ */
+struct compat_vduse_iotlb_entry {
+	compat_u64 offset;
+	compat_u64 start;
+	compat_u64 last;
+	__u8 perm;
+	__u8 padding[3];
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
+	__u8 padding[3];
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
+#else
+#define vduse_dev_compat_ioctl compat_ptr_ioctl
+#endif
+
 static int vduse_dev_release(struct inode *inode, struct file *file)
 {
 	struct vduse_dev *dev = file->private_data;
@@ -1678,7 +1799,7 @@ static const struct file_operations vduse_dev_fops = {
 	.write_iter	= vduse_dev_write_iter,
 	.poll		= vduse_dev_poll,
 	.unlocked_ioctl	= vduse_dev_ioctl,
-	.compat_ioctl	= compat_ptr_ioctl,
+	.compat_ioctl	= vduse_dev_compat_ioctl,
 	.llseek		= noop_llseek,
 };
 
-- 
2.39.5

