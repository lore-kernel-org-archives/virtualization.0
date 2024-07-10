Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441E6FE16
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593387; cv=none; b=EwMJVI/AgIW23W22QcES2q2VfrJlYu27MU/COe60Wi/QabZiXSL4tXBQaPAJ7+PSQ3t+Eumu/C3W3cQh1CQfd57/YEOmACbGYE2g2cAbPVUtrkZbN4UCXUwJIMKwI17FWSwPw6dZAUZJEHcjQ60DovWGL0wN2GBDVWV7bq7FQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593387; c=relaxed/simple;
	bh=fMdD7fEtJVQU47rRGMlxl8NIRogqbZgxtCtvAZlYluo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/gmgigHhkmYH7ndtBbLZqzss/HeLijtUVIZGf26xbIlG4E1mKJvPGB9K8z2Z5SIaUzjbGBFUw40kxBdYMfmEdcgosm0Dyv7MVQ17ymfu4JGHM74+oxLgJQzm6bqbtHrjLu/NHoH9kWl3h8YwP8HGN6dTbqd5qkIgyh/qVHauTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DVIfgrzz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DVIfgrzz"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367975543a8so3966394f8f.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593384; x=1721198184; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sgdeyK7oRC2/FkPl5Zzw+Jry5zip9Yv0QBaxB83/DQ=;
        b=DVIfgrzzRlfMzz7+Q6Kw9tcW3ws/Iyq4XteK6i9rnUY8fkNA+vC4OJCT7aWsTbGNP3
         4gHQ/KLfrHE/9zo+RfJKbbnYncGjTXDe9FuV6sxuEyZzuGOa46WGTjm73E/QYpCX8nil
         rWnray7HMNSVPDARdS0RXs2OGwGiqmuM2WqCNRt9/l7piJ+KCooWWyvV7UUJsEqzEKoB
         qvymx6DRSBMlCeaK8sj5d+DKEMOPRNrmcB1moKNlyNfbtqGU6WsiB56EtX5EQSTviCdt
         CU06ZoY0wVX0okq1EKKQ2uRMCppTimieEqwZg5JPVB3JVLHMLpgbvnE2+Meda/babILW
         Qauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593384; x=1721198184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sgdeyK7oRC2/FkPl5Zzw+Jry5zip9Yv0QBaxB83/DQ=;
        b=XgAjF/1TxSnz3sdx5s6A/h+vAK98FzSmQabN++k7ct3rEmcrv+jQ+W8Bo/me2PNUwG
         gHnceEA4VkgnyQQwzcSnbzJHAghUICdLDq8uTYS35IESOsFkseBurJkx9MiaAfhmCMLR
         tiD+zbM6cJRInqYj/jhQ8c55Iv5unmjO8i13rDP1SeJm1bTWkSDWenzfOKu9Ys37NdFP
         oHm7xxAAXnXCzRSCk9/7MVdG6o/FZDfmjJhHv/QB1ljSGZsYmF2OEMTyqUZbieJAlxPl
         9RSgkupqVrznDMTUB/5wjV0M/McBZpzmLuB40b2bhZDW0pF9cQXTaTSIMYRCoXoyWHWl
         OEJA==
X-Gm-Message-State: AOJu0YwXZ2KMnpxsLr9n8rx6bqjTdR49VudNEWLVYMiAqM2/p5rDi4QW
	/k3uclc2XADtvKvtd7SyAbNDICLAvPy+99fzcAqV7Xio3Sku5yuS2FfS44BurUhvQ3G8dIeKv1a
	K
X-Google-Smtp-Source: AGHT+IHsDghpcUxlxAJF/5Aw2+Yqyf1MxRNs1+E4F7KJLbuY+icD/QcCP920n6sowvKEJrA0H62VAQ==
X-Received: by 2002:a5d:6986:0:b0:367:9575:2820 with SMTP id ffacd0b85a97d-367ceac57bdmr2553009f8f.45.1720593384175;
        Tue, 09 Jul 2024 23:36:24 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e17csm4408863f8f.7.2024.07.09.23.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 12/13] virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result
Date: Wed, 10 Jul 2024 08:36:00 +0200
Message-ID: <20240710063601.2000149-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710063601.2000149-1-jiri@resnulli.us>
References: <20240710063601.2000149-1-jiri@resnulli.us>
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

