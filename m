Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51533B95C
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416576; cv=none; b=WtGXgkrqnPrsHtUn8pKBcffsiTuGcNiWQhmPe02MJSW/oqzZ+ju/r24fADu8SXLH/McI0jmhS1CE4K6Qwz3+8llTPlXclx8750yUua8MxIHlzXwzHvWaAPsYYB7LVNL6nCsmNVS/4fiMGkR7dW+JkFGQNxXrd3/o3ZLBqWzC57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416576; c=relaxed/simple;
	bh=PNBh+R4gtPom8IIGuBbLOqMPoeu3XxmCScbdUj4zhqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkPxUl3tabMeo6YmPNyfyM3KINNNuRvmeVJ9JDzudE2iRNMyknkYr7gOmjMwm6P9an1GVdIpGZamohxrJNpt5gaeYiRws4epFDMEkoWD13QeaEuX29Uc7mFixIoapzlJsmnstv8jvQQWelz/KVIe2zhjjsEoE7CEifp9IQ8q0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmzKWasf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmzKWasf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768416574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJrFObN2+HvZ/6DsZLFzYceBUqLw0RZMKMyLkfFomZA=;
	b=XmzKWasf1KI9XAUw+hQme6vDd+MedcOFr5jVR89LgnNX7WGslXlRD4UuhtKu2bTKHFkhtn
	9q9Mg7o6UECp7TXqQ4rEnAQBGrQqRa/IPTaBisfeoT/Oc/fVddYU+01jDDlfHafn0e8pM/
	3hb/ZbAwO5dTOL3F9xJMkl5vi+MmSYw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-yjRj46VBOXCeQx7zsfHECA-1; Wed,
 14 Jan 2026 13:49:30 -0500
X-MC-Unique: yjRj46VBOXCeQx7zsfHECA-1
X-Mimecast-MFC-AGG-ID: yjRj46VBOXCeQx7zsfHECA_1768416569
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A72A519560B2;
	Wed, 14 Jan 2026 18:49:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2202419560B4;
	Wed, 14 Jan 2026 18:49:25 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v12 10/13] vduse: merge tree search logic of IOTLB_GET_FD and IOTLB_GET_INFO ioctls
Date: Wed, 14 Jan 2026 19:48:36 +0100
Message-ID: <20260114184839.926884-11-eperezma@redhat.com>
In-Reply-To: <20260114184839.926884-1-eperezma@redhat.com>
References: <20260114184839.926884-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The next patch adds new ioctl with the ASID member per entry.  Abstract
these two so it can be build on top easily.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v12:
* Avoid dereferencing map_file if not assigned in vduse_dev_iotlb_entry
  function (MST).

v11: New in v11
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 102 ++++++++++++++++-------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6dba1f3224d9..d658f3e1cebf 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1243,6 +1243,51 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
 	vq->irq_effective_cpu = curr_cpu;
 }
 
+static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
+				 struct vduse_iotlb_entry *entry,
+				 struct file **f, uint64_t *capability)
+{
+	int r = -EINVAL;
+	struct vhost_iotlb_map *map;
+
+	if (entry->start > entry->last)
+		return -EINVAL;
+
+	mutex_lock(&dev->domain_lock);
+	if (!dev->domain)
+		goto out;
+
+	spin_lock(&dev->domain->iotlb_lock);
+	map = vhost_iotlb_itree_first(dev->domain->iotlb, entry->start,
+				      entry->last);
+	if (map) {
+		if (f) {
+			const struct vdpa_map_file *map_file;
+
+			map_file = (struct vdpa_map_file *)map->opaque;
+			entry->offset = map_file->offset;
+			*f = get_file(map_file->file);
+		}
+		entry->start = map->start;
+		entry->last = map->last;
+		entry->perm = map->perm;
+		if (capability) {
+			*capability = 0;
+
+			if (dev->domain->bounce_map && map->start == 0 &&
+			    map->last == dev->domain->bounce_size - 1)
+				*capability |= VDUSE_IOVA_CAP_UMEM;
+		}
+
+		r = 0;
+	}
+	spin_unlock(&dev->domain->iotlb_lock);
+
+out:
+	mutex_unlock(&dev->domain_lock);
+	return r;
+}
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -1256,36 +1301,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case VDUSE_IOTLB_GET_FD: {
 		struct vduse_iotlb_entry entry;
-		struct vhost_iotlb_map *map;
-		struct vdpa_map_file *map_file;
 		struct file *f = NULL;
 
 		ret = -EFAULT;
 		if (copy_from_user(&entry, argp, sizeof(entry)))
 			break;
 
-		ret = -EINVAL;
-		if (entry.start > entry.last)
+		ret = vduse_dev_iotlb_entry(dev, &entry, &f, NULL);
+		if (ret)
 			break;
 
-		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
-			mutex_unlock(&dev->domain_lock);
-			break;
-		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
-					      entry.start, entry.last);
-		if (map) {
-			map_file = (struct vdpa_map_file *)map->opaque;
-			f = get_file(map_file->file);
-			entry.offset = map_file->offset;
-			entry.start = map->start;
-			entry.last = map->last;
-			entry.perm = map->perm;
-		}
-		spin_unlock(&dev->domain->iotlb_lock);
-		mutex_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
 			break;
@@ -1475,41 +1500,26 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	}
 	case VDUSE_IOTLB_GET_INFO: {
 		struct vduse_iova_info info;
-		struct vhost_iotlb_map *map;
+		struct vduse_iotlb_entry entry;
 
 		ret = -EFAULT;
 		if (copy_from_user(&info, argp, sizeof(info)))
 			break;
 
-		ret = -EINVAL;
-		if (info.start > info.last)
-			break;
-
 		if (!is_mem_zero((const char *)info.reserved,
 				 sizeof(info.reserved)))
 			break;
 
-		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
-			mutex_unlock(&dev->domain_lock);
-			break;
-		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
-					      info.start, info.last);
-		if (map) {
-			info.start = map->start;
-			info.last = map->last;
-			info.capability = 0;
-			if (dev->domain->bounce_map && map->start == 0 &&
-			    map->last == dev->domain->bounce_size - 1)
-				info.capability |= VDUSE_IOVA_CAP_UMEM;
-		}
-		spin_unlock(&dev->domain->iotlb_lock);
-		mutex_unlock(&dev->domain_lock);
-		if (!map)
+		entry.start = info.start;
+		entry.last = info.last;
+		ret = vduse_dev_iotlb_entry(dev, &entry, NULL,
+					    &info.capability);
+		if (ret < 0)
 			break;
 
+		info.start = entry.start;
+		info.last = entry.last;
+
 		ret = -EFAULT;
 		if (copy_to_user(argp, &info, sizeof(info)))
 			break;
-- 
2.52.0

