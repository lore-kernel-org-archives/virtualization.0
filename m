Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16F15491
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129782; cv=none; b=IlgAAQkrQdkk7Og65IrtRAMllUWrfexqNy7ldXl1akkmoZZTM+D2Q5fA3AAerbzUwzLZaIQ/zxh79i2NQveNkGNFDQJtcxtvsDQODEBUJi08CV0gFfgEFFpZV0w52tYKYS9nUGHd0hI0woi/kYZrovwmgo+TxQHJozlJ7xsdaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129782; c=relaxed/simple;
	bh=nteVyXjgfpS4fSC8Dpr+1qY1lavd9fMKprQgm5QLxVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYPw8olZrVQf70c6asRGx2+Hlzac5RFWLeKbdc2l3aegIuJp9vBbg8sV62B0cjzFWXBuYa80MMKCDwmvVX/kdCW623fQdm6RadoMjpHFlFq42O5KNKpN//DpQRO/YmihCpbfgZiqVSKGCxqxyrYvj8F57NQJUixm5QCZlGgGKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZreiECqk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZreiECqk"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-427b9dcbb09so5313235e9.3
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129779; x=1721734579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbu9oMg7pQfBqvpQVyX/tLEKFDsAREKU93l2yotCovU=;
        b=ZreiECqkXRuiU6rJ3s+gZDSQAbJzDbv7i3ChVQWl48KbFwL+m/L2SVEiFM4TSGsdYW
         5b2RaWwqRWVOH2AhYY4EDpSPpnazqQ9kMGwdZYefCfJBt8JWtpZ0aEfWmWnhtMZvsc5P
         lD4DZoGbtwIU3yCbmzTE/qycUJuyZFSHl7sRAvidNO7Du94FdeEX6S3LZXYOAzkDoH0X
         o8iYAxYVKhsP0aRFX3cSh5dU7fqsCnoY2E7P7Dhv2OBzAwTb3xKcYoUL5aemFKGAhO/D
         vwSZyMIxv5G+Oycynwf72wak6e/biPmaZ+Wt+TpzrnISUc2ytpzqgfiOADy+iHiN+egR
         T5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129779; x=1721734579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbu9oMg7pQfBqvpQVyX/tLEKFDsAREKU93l2yotCovU=;
        b=SC4DZBUBjvzRXOz1FUDCzf3caoDAbLL6qZ1ZI7NuqbImhrT+vAUN9iALcYby9XSyDe
         S0L212NSQWGPIzsb2zSqfL9L7vveN5B7GKqbmeiXCR8KQfb1AkQBG7tsb/RJVGzlIjwQ
         YSJvyqTP5LNcyVMXN8EsbzOH5TtQXmp+wwdUYwjQOypBxTUrzfkd2lTASI2gJv+dIfBI
         s2YchgpXp8de1ACRwJJ0EPm9YiblajxasYJ/bYFx7xo6th6AKJd9FHHb57VIIk/Wosc9
         VUagPAqz53WSSg+53L4oU3KXg0+5NC0tNzOh+yAHNeib2VcoJoDVhm5AJrSzykPq6bJa
         cAuw==
X-Gm-Message-State: AOJu0Ywyyhql62xsrTBlZ7evTyUSCgFS5yjaGvGMIDZ/nLG/z33o91Gc
	AEIOXINRuT6NxShwKqxfOt+rJRHH6UGM9wkWrJTBZFgBP4QujypUiraXefRZs9ngZ+bd1yGuIBp
	tFKQ=
X-Google-Smtp-Source: AGHT+IGbE5uhuXpmx/42xwXCcBBLPfc7UWredjGChtRL/NqRw4sHmUI5ZTMTXfWWX2ZvXY8kKASn9w==
X-Received: by 2002:adf:e68e:0:b0:367:8876:68e1 with SMTP id ffacd0b85a97d-3682613a0dfmr1270797f8f.33.1721129779251;
        Tue, 16 Jul 2024 04:36:19 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3681c30a024sm4524730f8f.96.2024.07.16.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 06/13] virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
Date: Tue, 16 Jul 2024 13:35:45 +0200
Message-ID: <20240716113552.80599-7-jiri@resnulli.us>
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

It is guaranteed by the virtio_pci and PCI layers that none of the VFs
is probed before setup_vq() is called for admin queue and after del_vq()
is called for admin queue. Therefore treat vp_dev->admin_vq.info.vq as
static, don't null it and don't take cmd lock during assign.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_common.h |  2 +-
 drivers/virtio/virtio_pci_modern.c | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 0cb6fdc8c354..aa43875b6353 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -45,7 +45,7 @@ struct virtio_pci_vq_info {
 struct virtio_pci_admin_vq {
 	/* Virtqueue info associated with this admin queue. */
 	struct virtio_pci_vq_info info;
-	/* serializing admin commands execution and virtqueue deletion */
+	/* serializing admin commands execution. */
 	struct mutex cmd_lock;
 	u64 supported_cmds;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 3b5b9499a53a..6d653bea9a87 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -580,11 +580,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		goto err;
 	}
 
-	if (is_avq) {
-		mutex_lock(&vp_dev->admin_vq.cmd_lock);
+	if (is_avq)
 		vp_dev->admin_vq.info.vq = vq;
-		mutex_unlock(&vp_dev->admin_vq.cmd_lock);
-	}
 
 	return vq;
 
@@ -620,12 +617,6 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 
-	if (vp_is_avq(&vp_dev->vdev, vq->index)) {
-		mutex_lock(&vp_dev->admin_vq.cmd_lock);
-		vp_dev->admin_vq.info.vq = NULL;
-		mutex_unlock(&vp_dev->admin_vq.cmd_lock);
-	}
-
 	if (vp_dev->msix_enabled)
 		vp_modern_queue_vector(mdev, vq->index,
 				       VIRTIO_MSI_NO_VECTOR);
-- 
2.45.2

