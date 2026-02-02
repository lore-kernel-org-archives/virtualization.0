Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4F3563F7;
	Mon,  2 Feb 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026386; cv=none; b=qPjiIRRwjNntMo5hXU0bFhpgtY2ZZSI/54SS9pLAUC8TDSZk6IvQiomK6KHsgCFTWRSP2ny6XBI1/0XhYUHaHpTHLf3QJuBSeO6SW89HCJvVgsjLPaeD23vGAc9NvDoAr9qouO8g/9GSTBv74ro6jvEdv+OpMOgRIxmWCosU1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026386; c=relaxed/simple;
	bh=pF6YGx3RZsVuHs/wNmNxMg3/97lYgI02Is4iPd9f628=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cl7IEuDUASfcCaq/6UOHdzwnrerQYOd6lmJRRX7RYYLTZchuIXgTvG4B+cl9ZuxKXRHvxC5wHqc6dH3CnTPgPFIxxqKQCWbOF9d8NgjFiaFcamZ1OKMEPQq2ic00q/0dez7pb86BoAaLabp7RKBDysA/usxZM7QCNyXL1v0ZEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4DlN9HU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4DlN9HU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB4BC116C6;
	Mon,  2 Feb 2026 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026386;
	bh=pF6YGx3RZsVuHs/wNmNxMg3/97lYgI02Is4iPd9f628=;
	h=From:To:Cc:Subject:Date:From;
	b=o4DlN9HUSWyMSsjX0ygPDEmKc94+nItM3RDKZJQIQD9I7KJCkmxxb7+FaoUtvuODc
	 +h1MEZoUUotAN49StCCv7OiA7xofB8UqHC4CBUxitBWqA3s4spuf4mpgDOGqz9s6Cr
	 blC+DqDlVAccYot1vNcdzjzmQH1slNwySdbZq/4Jov+ODBkGMfiuyMmUjdrl8xT1yq
	 mEXFK8Mvg71+SQ82+Fqq58QpCtQ6SHLyksk6bkI5oEmjVt3eOdhbK70QL37+hAeZ1X
	 VrvvgchExULpy5Ot5nkfa2+hsjeikgCNSXTnV5HA4ShSSYe7cKz03eAlPcyAfuOGan
	 k8wBwoZVzA7wg==
From: Arnd Bergmann <arnd@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ashwini Sahu <ashwini@wisig.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vduse: avoid adding implicit padding
Date: Mon,  2 Feb 2026 10:59:31 +0100
Message-Id: <20260202095940.1358613-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The vduse_iova_range_v2 and vduse_iotlb_entry_v2 structures are both
defined in a way that adds implicit padding and is incompatible between
i386 and x86_64 userspace because of the different structure alignment
requirements. Building the header with -Wpadded shows these new warnings:

vduse.h:305:1: error: padding struct size to alignment boundary with 4 bytes [-Werror=padded]
vduse.h:374:1: error: padding struct size to alignment boundary with 4 bytes [-Werror=padded]

Change the amount of padding in these two structures to align them to
64 bit words and avoid those problems. Since the v1 vduse_iotlb_entry
already has an inconsistent size, do not attempt to reuse the structure
but rather list the members indiviudally, with a fixed amount of
padding.

Fixes: 079212f6877e ("vduse: add vq group asid support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 40 +++++++++++-------------------
 include/uapi/linux/vduse.h         |  9 +++++--
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 73d1d517dc6c..405d59610f76 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1301,7 +1301,7 @@ static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
 	int r = -EINVAL;
 	struct vhost_iotlb_map *map;
 
-	if (entry->v1.start > entry->v1.last || entry->asid >= dev->nas)
+	if (entry->start > entry->last || entry->asid >= dev->nas)
 		return -EINVAL;
 
 	asid = array_index_nospec(entry->asid, dev->nas);
@@ -1312,18 +1312,18 @@ static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
 
 	spin_lock(&dev->as[asid].domain->iotlb_lock);
 	map = vhost_iotlb_itree_first(dev->as[asid].domain->iotlb,
-				      entry->v1.start, entry->v1.last);
+				      entry->start, entry->last);
 	if (map) {
 		if (f) {
 			const struct vdpa_map_file *map_file;
 
 			map_file = (struct vdpa_map_file *)map->opaque;
-			entry->v1.offset = map_file->offset;
+			entry->offset = map_file->offset;
 			*f = get_file(map_file->file);
 		}
-		entry->v1.start = map->start;
-		entry->v1.last = map->last;
-		entry->v1.perm = map->perm;
+		entry->start = map->start;
+		entry->last = map->last;
+		entry->perm = map->perm;
 		if (capability) {
 			*capability = 0;
 
@@ -1363,14 +1363,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EFAULT;
-		if (cmd == VDUSE_IOTLB_GET_FD2) {
-			if (copy_from_user(&entry, argp, sizeof(entry)))
-				break;
-		} else {
-			if (copy_from_user(&entry.v1, argp,
-					   sizeof(entry.v1)))
-				break;
-		}
+		if (copy_from_user(&entry, argp, _IOC_SIZE(cmd)))
+			break;
 
 		ret = -EINVAL;
 		if (!is_mem_zero((const char *)entry.reserved,
@@ -1385,19 +1379,13 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (!f)
 			break;
 
-		if (cmd == VDUSE_IOTLB_GET_FD2)
-			ret = copy_to_user(argp, &entry,
-					   sizeof(entry));
-		else
-			ret = copy_to_user(argp, &entry.v1,
-					   sizeof(entry.v1));
-
+		ret = copy_to_user(argp, &entry, _IOC_SIZE(cmd));
 		if (ret) {
 			ret = -EFAULT;
 			fput(f);
 			break;
 		}
-		ret = receive_fd(f, NULL, perm_to_file_flags(entry.v1.perm));
+		ret = receive_fd(f, NULL, perm_to_file_flags(entry.perm));
 		fput(f);
 		break;
 	}
@@ -1603,16 +1591,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		} else if (info.asid >= dev->nas)
 			break;
 
-		entry.v1.start = info.start;
-		entry.v1.last = info.last;
+		entry.start = info.start;
+		entry.last = info.last;
 		entry.asid = info.asid;
 		ret = vduse_dev_iotlb_entry(dev, &entry, NULL,
 					    &info.capability);
 		if (ret < 0)
 			break;
 
-		info.start = entry.v1.start;
-		info.last = entry.v1.last;
+		info.start = entry.start;
+		info.last = entry.last;
 		info.asid = entry.asid;
 
 		ret = -EFAULT;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index faae7718bd2e..deca8c7b9178 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -299,9 +299,13 @@ struct vduse_iova_info {
  * Structure used by VDUSE_IOTLB_GET_FD2 ioctl to find an overlapped IOVA region.
  */
 struct vduse_iotlb_entry_v2 {
-	struct vduse_iotlb_entry v1;
+	__u64 offset;
+	__u64 start;
+	__u64 last;
+	__u8 perm;
+	__u8 padding[7];
 	__u32 asid;
-	__u32 reserved[12];
+	__u32 reserved[11];
 };
 
 /*
@@ -371,6 +375,7 @@ struct vduse_iova_range_v2 {
 	__u64 start;
 	__u64 last;
 	__u32 asid;
+	__u32 padding;
 };
 
 /**
-- 
2.39.5

