Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF0199247
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129810; cv=none; b=BCAQCqzyfluCVqJNzavbBBf+lKjl0n03dq95t8fkCDa9v5dTw51jg1uvyiPEdemLzC6xEdGC3j6F1TveKSprUt6boutNXz4SNCxGx0IN7K2d15fCL4ZYs1qdKzABeqnOHJKyRLD5My4XwD6j+hqnqWviEecsuWwp9xZiOHuV5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129810; c=relaxed/simple;
	bh=z02rr5bnTzno4NGRuGtPDmncuIXldDV1jcrOeJUZ6ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/DJmC9JDPrvyasX+2Pk/NuefMOdqMifHa7scHOKovqj3pFFhAXTrcXxq4PLv60gjKzR1316a23RSnUZ9fB6vaT4hTTqT94/iIOICT7YSlqJPqK8Y+7rXA2LZzVmkEBKp696oaIK35cfnItRwVcobV/qjRoIjR5kjzT1rmtrpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GmFeJRC2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GmFeJRC2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36796aee597so3272053f8f.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129807; x=1721734607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB65zbinB2MISQMUM6dI/jqZTlx1Vh3IOjyM6wiaJRc=;
        b=GmFeJRC2Dg+DSrRkTEPAhybyKkt8pXhmgFaV+eJ/mIidVLHdKXTk7jfm7E/OTvElju
         +ajx6d9e/iqtyIWR9uIBhfi9gb1DyVQeSQEqpmkwXWcS2fdB5iMaTrk+kmqzpwZLmGYq
         xoES6BaXTuzJSsp2+P/MQ/iWpMnXJxAXRH37DQNzjZe1hDjWW+7iuf8vZ03ioG76yvRY
         RUMe5GtN1zPNyI+odK5pPono9kZ5+MOMnc48tDBQlWPfXA3qq2df38LQe53YZN9k9Bdm
         56kg19qoRXQESOKJJqYEsbYULQDS11qXoyP7EVSS8mQfVw01TSyBjs/s74YWaDoPVHBk
         JTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129807; x=1721734607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB65zbinB2MISQMUM6dI/jqZTlx1Vh3IOjyM6wiaJRc=;
        b=UvxbFbUhF/6+JmPfvjuUx4vAQHm1lN1HtYkDqP/XWrJLzDjwwb3F/FC7CE1ZkeQX7b
         yQAym7dicw0btNgGP7hw3+TuratEP40VgFjzcaMWOLNu5iMm2pXyGh+gYJ4oDlRoU4u5
         rk2rWb3OxjtB2S2gIWPWktYqp2gYYzBMqZASmKMARipmQpcjfA/sYCAUl2jleC6dEY3c
         Mq0kaM0PmCDHyYdkAj3y6S+hqRe9FXO9pSc4xkHzbnyZHucgP7sUeGXjUCU85Lti4Mwg
         MJDW2oCGnGdKm6RemEe6HwyT9wjZIfmnof6hkZWE4vow13blKsziKNhzE7T79yznS+29
         12jg==
X-Gm-Message-State: AOJu0Yyb/iDO65R/g+tkCT+9JfaPcFDlCn/d5Vza9uZTwvI1/zb5yC4S
	M4xqyGboe+9a1S9jvZ/kdslTLdNcgAmr5bB6IYL1xuscTYMnM18sx9ZcEwcPQOGp5XI2ly5/J9H
	QKeg=
X-Google-Smtp-Source: AGHT+IFmPbEEgnNl8uSXr4+ljlUm/GAKzZw7Q/19gRK+FybgyyvTJYpMuOXuhMUkryDqThHpDOOdtQ==
X-Received: by 2002:adf:fd48:0:b0:366:f994:33c with SMTP id ffacd0b85a97d-3682635bc24mr1337827f8f.56.1721129807257;
        Tue, 16 Jul 2024 04:36:47 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccac2sm8768953f8f.56.2024.07.16.04.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:46 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 13/13] virtio_pci_modern: remove admin queue serialization lock
Date: Tue, 16 Jul 2024 13:35:52 +0200
Message-ID: <20240716113552.80599-14-jiri@resnulli.us>
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

