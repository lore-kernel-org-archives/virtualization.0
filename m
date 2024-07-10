Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E634BAA6
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593389; cv=none; b=gF/Gg2AkNDmIWOx6dg6lBswztrEnsiR83gsm5LCUx7dE0/Zzb2qfqJY80TwI4y4bM0Sz8icSnmnoCT5jsbWkUd4XN1Go3tDTp3np1fyjrlK8kb9L3NsfpF+o4sMv4Cl9Aqe4wtVlbH2dye8s2r8s6T2EC7b8kQMleF+8G2LY01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593389; c=relaxed/simple;
	bh=z02rr5bnTzno4NGRuGtPDmncuIXldDV1jcrOeJUZ6ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxEbpuR6PPHTRzy8cJ3iJXjRPy2bmWrxpFYmsK3K35isXeN2WzvXFjm1FKkzfejyXuypBYMAbwIDY8FNtBqD+YwNKuUuuuOcaVMbPMK9nvcf5ZgSL1+B996E2mXlxsIhBA5Ps1y+AZP+WDEsZ46hX0JaW6KNBdgyaygd/rhYRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DSpOhRyE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DSpOhRyE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367ab50a07aso3250473f8f.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593386; x=1721198186; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB65zbinB2MISQMUM6dI/jqZTlx1Vh3IOjyM6wiaJRc=;
        b=DSpOhRyE9lX+SqoLOCCTyYwt2h3fVjLZaqqBfxU/sZS/8pVmwYg4rgx6efhj05L6Z+
         +cMD5cZWlXjzbQ69uwF+REZVNyigavBWWANYjT1dDxXxq8g/kYRFxLYexuzwQjw+BxF8
         ZVzosG6zr4v0XIps23EGgeLbXWfXQBS5T8OzmxUcBh3zGnPiyAj2VgxaEuDqQRKid9Z+
         gxH+NQenFj/V9VNVFupgSyBwxikAUB1ZXjsv2iVNVp/er1xgqCuy6z4rYqckjpMRt6RO
         UznBXyECO7ZEhQmBpykWhZ5F88HlK9mJF1tEHQU7wPfe67zwr3rAYPj7onzlQ0C+ni5N
         Pgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593386; x=1721198186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB65zbinB2MISQMUM6dI/jqZTlx1Vh3IOjyM6wiaJRc=;
        b=MzpMHlCgQO9W9stqJv17mDwjVbQSuiKMiPzLOdfZskCgSWh8eKTcCphu3O4ovPFEr7
         zyFJmIE2jUg0/6SrqzUlGjcDZk5Wmp0BX2m1y9F35oUkt5WEdbfqBbTyAc+8zPTnXLAG
         DzCU7/2j4h5Y59KLsOdloA3l2/9l7SVoUVO4g7l3f5W6zLO8DqBTrdEym1vfpl/W3q2v
         pYPkoOAwYa5Wcpo/x6TPa/4cDCRju4oY8cGfBf5djBTzHfn4xGNamOUkgIc2Q2N8aEeP
         DOaJtrLPafl1t1RGJuavQ4ShSJylntMmWknRHwIhztemVguFqgI99qDnkFS4kZ3hE68p
         YuiA==
X-Gm-Message-State: AOJu0YzeC3Le9F3nXzvhW/dQhglqD33Q1HLRHDo+lYfQGNSUIdTsjxWJ
	+FzhL7/2le00viYbh5NWQpuUx4CDFCC7DHF5RDkzreX6VImYTEZyYLV4+wmC77LgKMgPIPCVAYQ
	Q
X-Google-Smtp-Source: AGHT+IHYNm4gnA8nqZ2DXTcUAXxfAL9zDc34pvLStx9qgnicojkYmRPzpiYWd9eO0o5GHVGqyy5FSg==
X-Received: by 2002:adf:ce0b:0:b0:362:dbc2:9486 with SMTP id ffacd0b85a97d-367ceadaeb7mr2849347f8f.68.1720593385919;
        Tue, 09 Jul 2024 23:36:25 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367df88b1c5sm2350165f8f.4.2024.07.09.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:25 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 13/13] virtio_pci_modern: remove admin queue serialization lock
Date: Wed, 10 Jul 2024 08:36:01 +0200
Message-ID: <20240710063601.2000149-14-jiri@resnulli.us>
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

The admin queue operations are protected by newly introduced
spin lock. To make it possible to issue parallel commands, remove the
admin queue serialization lock.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rebased on top of changes in previous patches (vq info)
---
 drivers/virtio/virtio_pci_common.h | 2 --
 drivers/virtio/virtio_pci_modern.c | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 90df381fbbcf..1d9c49947f52 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -45,8 +45,6 @@ struct virtio_pci_vq_info {
 struct virtio_pci_admin_vq {
 	/* Virtqueue info associated with this admin queue. */
 	struct virtio_pci_vq_info *info;
-	/* serializing admin commands execution. */
-	struct mutex cmd_lock;
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 608df3263df1..9193c30d640a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -167,12 +167,9 @@ int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 		in_num++;
 	}
 
-	mutex_lock(&vp_dev->admin_vq.cmd_lock);
 	ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq,
 				       le16_to_cpu(cmd->opcode),
 				       sgs, out_num, in_num, cmd);
-	mutex_unlock(&vp_dev->admin_vq.cmd_lock);
-
 	if (ret) {
 		dev_err(&vdev->dev,
 			"Failed to execute command on admin vq: %d\n.", ret);
@@ -837,7 +834,6 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->vdev.id = mdev->id;
 
 	spin_lock_init(&vp_dev->admin_vq.lock);
-	mutex_init(&vp_dev->admin_vq.cmd_lock);
 	return 0;
 }
 
@@ -845,6 +841,5 @@ void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
 {
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 
-	mutex_destroy(&vp_dev->admin_vq.cmd_lock);
 	vp_modern_remove(mdev);
 }
-- 
2.45.2

