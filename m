Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABA55897
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129806; cv=none; b=BR7QtMkfAupSNVxO+VrNE3e11eD4Vru6TCLuFvWWZogydiXb7ZDvpeq3Cz+Rx/tdFRqD7WKkdPvtdov8GaMF5Xe2EB2AacW1JYrqXL4MZoE2rRa3ose3xFjg8A8kJybvHD4HbG0eilHxRKLKskGwIwqceH/3dilUEf7DFGoGrM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129806; c=relaxed/simple;
	bh=fMdD7fEtJVQU47rRGMlxl8NIRogqbZgxtCtvAZlYluo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlBh1yVcB5dI82WAQxhTFAI4H7rYyiSvIzBhbdKyCRHLQbDGEQhXx7aOu9cpyXb9nZxOXrSzXxfFYC5qF4wRu1UYLNNr7Iny3rIZ8GZaiK6CRajTbi35I9EwvI+MD3lzB2RbDXyOS727rtzoL8ezCIoPM/q4LedsQdg/D9wOVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=csE26g4i; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="csE26g4i"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36798e62aeeso3492504f8f.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129803; x=1721734603; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sgdeyK7oRC2/FkPl5Zzw+Jry5zip9Yv0QBaxB83/DQ=;
        b=csE26g4ilZvbTqe6vRkXDOPNDYB/AhySfbMAvQj6JL+nidk9BRJtOT5cTvB/QXI2tI
         0D2YrR890hmoOtm4/HGaR8FRSxU9xnqyityrCfBNHYbvRQ9JUpKcOkQB5uHfB5dHpwyS
         4VmL4DvV9vD32fPhwS1uGD1TerOmXr5IDnTes3XeIQXekQ4oyig0oTPcjjpjTO9qtJoS
         u8rKiNalA+6jPBqo5oGkLn8my/vYcOQLDRBSTMzxqhjM/A2Lxrgdj6+HyCFbwF2WwOSb
         P1ElhzJIqFwSWtrjY3pAIIxEaQ9Db2/Ab6zxM+gF28HpUM32ydOTa/o/1avVTr6mdxY0
         luSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129803; x=1721734603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sgdeyK7oRC2/FkPl5Zzw+Jry5zip9Yv0QBaxB83/DQ=;
        b=k3WcVX5PruSuFklLPCcomRLgo867uJBs93i6qe+JDZfB9+rnvBljz3rUw4YFcdnNkm
         Oh36NoGx9b5SumnCohnnyvlTYG8tGCkAbBoy129mpnTmaQ/MPVak6A2E7x7R6yeEJcVB
         SZZZTxExklo6TnB2+wTebOcQezzpLZXiS/rlPWXoHY5xg4sdMKtxmseQP+lhV4FSeIWc
         zX4bqxc1PhKIRjF6LSC2XDxfVOIUjDfsQD9h6d8geg5R0bGVDdxRMocLRekAaIf0XPc9
         2ZOJXMZ/UXpiSZUjTPniaZBMXvGx6ixYZC1qUOVCFvq/77iRpPWvulPFdYvCsoTn4lbM
         kIuw==
X-Gm-Message-State: AOJu0YxgHD+RPv4/QskA4IFrZadwy5TTumAjsjdRXJgKXGmfO66qY1l+
	leRruTEvs7zTFdue6GImOcH7SWlRh1QcB+On77d2UObCl5JXbimCw7687YDK98aA0J+qN93P+iw
	xrHI=
X-Google-Smtp-Source: AGHT+IGy0U71Oi7xdNcB9LCApu5IXgxVN0en3KOQq5ja0s5KcIr8+AE2zGZZUmW08gfh2sy82BTTyg==
X-Received: by 2002:adf:fdcd:0:b0:367:8120:73ea with SMTP id ffacd0b85a97d-3682634d566mr1081631f8f.67.1721129803160;
        Tue, 16 Jul 2024 04:36:43 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb939sm8795683f8f.89.2024.07.16.04.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:42 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 12/13] virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result
Date: Tue, 16 Jul 2024 13:35:51 +0200
Message-ID: <20240716113552.80599-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716113552.80599-1-jiri@resnulli.us>
References: <20240716113552.80599-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently, the code waits in a busy loop on every admin virtqueue issued
command to get a reply. That prevents callers from issuing multiple
commands in parallel.

To overcome this limitation, introduce a virtqueue event callback for
admin virtqueue. For every issued command, use completion mechanism
to wait on a reply. In the event callback, trigger the completion
is done for every incoming reply.

Alongside with that, introduce a spin lock to protect the admin
virtqueue operations.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rebased on top of newly added patches
- rebased on top of changes in previous patches (vq info, vqs[])
- removed WARN_ON_ONCE() when calling virtqueue_kick()
- added virtqueue_is_broken check in virtqueue_exec_admin_cmd() loop
- added vp_modern_avq_cleanup() implementation to handle surprise
  removal case
---
 drivers/virtio/virtio_pci_common.c | 13 ++++--
 drivers/virtio/virtio_pci_common.h |  3 ++
 drivers/virtio/virtio_pci_modern.c | 74 +++++++++++++++++++++++++-----
 include/linux/virtio.h             |  3 ++
 4 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 267643bb1cd5..c44d8ba00c02 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -395,6 +395,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			if (vqi->name && vqi->callback)
 				++nvectors;
 		}
+		if (avq_num && vector_policy == VP_VQ_VECTOR_POLICY_EACH)
+			++nvectors;
 	} else {
 		/* Second best: one for change, shared for all vqs. */
 		nvectors = 2;
@@ -425,9 +427,9 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
-	vq = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name, false,
-				 true, &allocated_vectors, vector_policy,
-				 &vp_dev->admin_vq.info);
+	vq = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
+				 avq->name, false, true, &allocated_vectors,
+				 vector_policy, &vp_dev->admin_vq.info);
 	if (IS_ERR(vq)) {
 		err = PTR_ERR(vq);
 		goto error_find;
@@ -486,8 +488,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
-	vq = vp_setup_vq(vdev, queue_idx++, NULL, avq->name, false,
-			 VIRTIO_MSI_NO_VECTOR, &vp_dev->admin_vq.info);
+	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
+			 false, VIRTIO_MSI_NO_VECTOR,
+			 &vp_dev->admin_vq.info);
 	if (IS_ERR(vq)) {
 		err = PTR_ERR(vq);
 		goto out_del_vqs;
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index de59bb06ec3c..90df381fbbcf 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -47,6 +47,8 @@ struct virtio_pci_admin_vq {
 	struct virtio_pci_vq_info *info;
 	/* serializing admin commands execution. */
 	struct mutex cmd_lock;
+	/* Protects virtqueue access. */
+	spinlock_t lock;
 	u64 supported_cmds;
 	/* Name of the admin queue: avq.$vq_index. */
 	char name[10];
@@ -178,6 +180,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
 #define VIRTIO_ADMIN_CMD_BITMAP 0
 #endif
 
+void vp_modern_avq_done(struct virtqueue *vq);
 int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 			     struct virtio_admin_cmd *cmd);
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 0fd344d1eaf9..608df3263df1 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -53,6 +53,23 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
 	return index == vp_dev->admin_vq.vq_index;
 }
 
+void vp_modern_avq_done(struct virtqueue *vq)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
+	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
+	struct virtio_admin_cmd *cmd;
+	unsigned long flags;
+	unsigned int len;
+
+	spin_lock_irqsave(&admin_vq->lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((cmd = virtqueue_get_buf(vq, &len)))
+			complete(&cmd->completion);
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&admin_vq->lock, flags);
+}
+
 static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 				    u16 opcode,
 				    struct scatterlist **sgs,
@@ -61,7 +78,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 				    struct virtio_admin_cmd *cmd)
 {
 	struct virtqueue *vq;
-	int ret, len;
+	unsigned long flags;
+	int ret;
 
 	vq = admin_vq->info->vq;
 	if (!vq)
@@ -72,21 +90,33 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 	    !((1ULL << opcode) & admin_vq->supported_cmds))
 		return -EOPNOTSUPP;
 
-	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
-	if (ret < 0)
-		return -EIO;
+	init_completion(&cmd->completion);
 
-	if (unlikely(!virtqueue_kick(vq)))
+again:
+	if (virtqueue_is_broken(vq))
 		return -EIO;
 
-	while (!virtqueue_get_buf(vq, &len) &&
-	       !virtqueue_is_broken(vq))
-		cpu_relax();
+	spin_lock_irqsave(&admin_vq->lock, flags);
+	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
+	if (ret < 0) {
+		if (ret == -ENOSPC) {
+			spin_unlock_irqrestore(&admin_vq->lock, flags);
+			cpu_relax();
+			goto again;
+		}
+		goto unlock_err;
+	}
+	if (!virtqueue_kick(vq))
+		goto unlock_err;
+	spin_unlock_irqrestore(&admin_vq->lock, flags);
 
-	if (virtqueue_is_broken(vq))
-		return -EIO;
+	wait_for_completion(&cmd->completion);
 
-	return 0;
+	return cmd->ret;
+
+unlock_err:
+	spin_unlock_irqrestore(&admin_vq->lock, flags);
+	return -EIO;
 }
 
 int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
@@ -209,6 +239,25 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
 	virtio_pci_admin_cmd_list_init(vdev);
 }
 
+static void vp_modern_avq_cleanup(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_admin_cmd *cmd;
+	struct virtqueue *vq;
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
+		return;
+
+	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
+	if (!vq)
+		return;
+
+	while ((cmd = virtqueue_detach_unused_buf(vq))) {
+		cmd->ret = -EIO;
+		complete(&cmd->completion);
+	}
+}
+
 static void vp_transport_features(struct virtio_device *vdev, u64 features)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -403,6 +452,8 @@ static void vp_reset(struct virtio_device *vdev)
 	while (vp_modern_get_status(mdev))
 		msleep(1);
 
+	vp_modern_avq_cleanup(vdev);
+
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
@@ -785,6 +836,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->isr = mdev->isr;
 	vp_dev->vdev.id = mdev->id;
 
+	spin_lock_init(&vp_dev->admin_vq.lock);
 	mutex_init(&vp_dev->admin_vq.cmd_lock);
 	return 0;
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96fea920873b..999ff5934392 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -10,6 +10,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
 #include <linux/dma-mapping.h>
+#include <linux/completion.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -109,6 +110,8 @@ struct virtio_admin_cmd {
 	__le64 group_member_id;
 	struct scatterlist *data_sg;
 	struct scatterlist *result_sg;
+	struct completion completion;
+	int ret;
 };
 
 /**
-- 
2.45.2

