Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FA3570CC;
	Mon,  2 Feb 2026 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026394; cv=none; b=gLivVZBPDBoBa3h4BwikgCvDYLXHPkm8TAk+NiSKZDtqElShWlE4Y1gdna7jUcU3I148MwUYVhtFfGNajLV48AiFQeXShTQlKVO2Loh7okDE0UkYg8gcKJ/9JqfSsx5jrKf6jyqalDk+dOubPqhmcUsRS2LkpC9fqeEIDHxAubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026394; c=relaxed/simple;
	bh=TmoHHrqGpHnyUdm3r7UYpmil7JS9bcpmpcteUVJVhlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OW+HosDJNwTb1iPPlMkHTVVwknLyhEv82LqR4DuB+niXaR0TIdCMarLlI5m5CF4U6S3UF/OQjLOevNHGaIU048tTfXwLLXw+IbnzyZlF5bqRr3hEr7UT6iIaCmy4JzJOYVKLiYS6wgf54hIV4ezsngWcYcROwEeineCd95JjA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVwlTeHj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVwlTeHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C46C2BC87;
	Mon,  2 Feb 2026 09:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026393;
	bh=TmoHHrqGpHnyUdm3r7UYpmil7JS9bcpmpcteUVJVhlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVwlTeHjyRMw/f98dRafO+WxW2pa/VChMQknnYrwRrBoESK1uYOq95icigvzwSlwX
	 Lob6jtX48avGe+fkSVTSL1sIV1YpmDeyg/7FsKPD2hGZNA2+GaHzZcCXaiao6Bd1Lp
	 wstfrGk86S/LkLBIEmLDayFpbjXKdlcTxDA7Xgt53ONDewUeg1SrHB3kkKnAjpNqDo
	 A3JiaEfkK7PSNAtRznkhBFP4cq4dNhzcUWtcTzIyhvBpvez1M2jLEkKzv6TtLOyOTy
	 vIsGuKyKbAt49t7UjQdX1M2/9GW6ZwDNuRBqdB3W6AlayGbFSgjTFZ6xbZsAemQDuo
	 59fOBxTfTrHNQ==
From: Arnd Bergmann <arnd@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Date: Mon,  2 Feb 2026 10:59:32 +0100
Message-Id: <20260202095940.1358613-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260202095940.1358613-1-arnd@kernel.org>
References: <20260202095940.1358613-1-arnd@kernel.org>
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

Add compad handling to the regular ioctl handler to just handle
them the same way and ignore the extra padding. This could be
done in a separate .compat_ioctl handler, but the main one already
handles two versions of VDUSE_IOTLB_GET_FD, so adding a third one
fits in rather well.

Fixes: ad146355bfad ("vduse: Support querying information of IOVA regions")
Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 43 +++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 405d59610f76..39cbff2f379d 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1341,6 +1341,37 @@ static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
 	return r;
 }
 
+#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
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
+#endif
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -1352,6 +1383,9 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		return -EPERM;
 
 	switch (cmd) {
+#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
+	case COMPAT_VDUSE_IOTLB_GET_FD:
+#endif
 	case VDUSE_IOTLB_GET_FD:
 	case VDUSE_IOTLB_GET_FD2: {
 		struct vduse_iotlb_entry_v2 entry = {0};
@@ -1455,13 +1489,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		ret = 0;
 		break;
 	}
+#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
+	case COMPAT_VDUSE_VQ_GET_INFO:
+#endif
 	case VDUSE_VQ_GET_INFO: {
-		struct vduse_vq_info vq_info;
+		struct vduse_vq_info vq_info = {};
 		struct vduse_virtqueue *vq;
 		u32 index;
 
 		ret = -EFAULT;
-		if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
+		if (copy_from_user(&vq_info, argp, _IOC_SIZE(cmd)))
 			break;
 
 		ret = -EINVAL;
@@ -1491,7 +1528,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		vq_info.ready = vq->ready;
 
 		ret = -EFAULT;
-		if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
+		if (copy_to_user(argp, &vq_info, _IOC_SIZE(cmd)))
 			break;
 
 		ret = 0;
-- 
2.39.5

