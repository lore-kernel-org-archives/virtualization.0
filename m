Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659640BE5
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219925; cv=none; b=Et0orxiCzLtqHd8zo0IV8RFHXlaTSjCDw6jtiWpWmENo+JCwK9s7v272xqJDucB4LnJ5NxZJTlLyoN1jOeOK+32paTrYdEGvD+sbnpXpSpPCQBc18QcKGtX7sW9V3024IapQtgSWxLctOqx4Dscbaz3SwwscdDsXAjB4VQIJhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219925; c=relaxed/simple;
	bh=WeIDOvSkSNORBjYo8DtKhwi8HjK0RbQrQFTQoUGUe5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siYiayb9GWWl9sXam3WdN0JaHhaYo2iDZ3J1yZIk0Ds2ouK3ahSejQ7lZjhBUKv8kqXMYplyhZmBjJ/PrBa4Ni7uRGNswrLtylD5MAWFoumKoJnEpx2pBRyXz2NFcijh3u26Q0QLiD8OyhlCDAWAfIbxO578DZ0Qc7JomsptALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0K7Tbb2a; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0K7Tbb2a"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe785b234so43783791fa.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719219922; x=1719824722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYaIu0FQLFw2UdyfXTImESa5aCcTiPIX3I1TRmCQPac=;
        b=0K7Tbb2aSdFjByIy0O6pSfEx/kDNzNC0C1D9kXETjrPU/UCWSp/N1SXi9nrJsQMCXi
         GyzYWC1Yt8uLHnWdOxvCkaCiGqChIlmoSQHrKnJv9ZmndxmuSvPP0SJwHeR4Se0OhKyY
         JH/Ii5q/93PlHImAwGA4GhSuRTTj8hBQvOOkfQL+cFKGHYjbttSkwaZF9Dy+AN1mgKrq
         nYL+4klNKCFhsQysy2QkCUsMGywyiEb6T5lLbZP4CeU6e6+ZmUClv9hA9l9u+JW1Bs8u
         vePiUdgaE1YULZ9GoPrkaw9XJ++M3a15aNFD6vqFR6eSiq2R3WtsiRTxIL+gdVSxKrhU
         LbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219922; x=1719824722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYaIu0FQLFw2UdyfXTImESa5aCcTiPIX3I1TRmCQPac=;
        b=wM7Wz5hZ8uVI5WO4RuEfcusXZqGUXzCxf4f+n610Mu15UBER7mE0YLFyAn7KMHRW7W
         lyFS8SAZBO0bQRWUfPPWVhhv7u3hxkxy3jrmCAOKo22cNZrMbA5ci81Vz1xtCHFPf7jh
         r01/4VSzjBf4IVoSaslduCDdMFdl2nNkQUCEDZ9d0campMU+HLn8DEmyHSzawLRhsnbg
         LP1dDuphV9TdTeUWH0NP1GBKx9WV6eA/H50g5ES0y4to9m2SNQf5DNG0XHaJDdHFZpth
         c4YA8nLu8/Oj5Ld9Cm11a7A7DCemuQj0MTAkB4Fa5Z/bWaVqJYIxTsLLSSjGsLsWa1Vw
         GVGQ==
X-Gm-Message-State: AOJu0Ywb83PnOgGaAz+r+wdSQqXnGAi9/XfLZ0JLBNDGSc4RGYzOSikP
	4hTtK3cE5SHB8RT9LSsrAt2cECk9Mp1X/o84LbV8dW2cGV2bQAzkE5JTaNsrCIzcotGXyvhSrsi
	nwbg=
X-Google-Smtp-Source: AGHT+IGvDnojNZBAC3Ptl0IR/Evl1bZDZWlRI0VA3esYlfqeI1IoMMSPkhrwUiaVqSxOuTLwaQNYHw==
X-Received: by 2002:a2e:90d0:0:b0:2eb:e405:dc with SMTP id 38308e7fff4ca-2ec5931d881mr33917391fa.14.1719219921909;
        Mon, 24 Jun 2024 02:05:21 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c5179sm164269905e9.26.2024.06.24.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:21 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com
Subject: [PATCH virtio 8/8] virtio_pci_modern: remove admin queue serialization lock
Date: Mon, 24 Jun 2024 11:04:51 +0200
Message-ID: <20240624090451.2683976-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624090451.2683976-1-jiri@resnulli.us>
References: <20240624090451.2683976-1-jiri@resnulli.us>
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
 drivers/virtio/virtio_pci_common.h | 2 --
 drivers/virtio/virtio_pci_modern.c | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 38a0b6df0844..b3d2adca4383 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -43,8 +43,6 @@ struct virtio_pci_vq_info {
 };
 
 struct virtio_pci_admin_vq {
-	/* serializing admin commands execution. */
-	struct mutex cmd_lock;
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index b9937e4b8a69..d983e37c7d39 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -165,12 +165,9 @@ int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 		in_num++;
 	}
 
-	mutex_lock(&vp_dev->admin_vq.cmd_lock);
 	ret = virtqueue_exec_admin_cmd(vp_dev, &vp_dev->admin_vq,
 				       le16_to_cpu(cmd->opcode),
 				       sgs, out_num, in_num, cmd);
-	mutex_unlock(&vp_dev->admin_vq.cmd_lock);
-
 	if (ret) {
 		dev_err(&vdev->dev,
 			"Failed to execute command on admin vq: %d\n.", ret);
@@ -815,7 +812,6 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->vdev.id = mdev->id;
 
 	spin_lock_init(&vp_dev->admin_vq.lock);
-	mutex_init(&vp_dev->admin_vq.cmd_lock);
 	return 0;
 }
 
@@ -823,6 +819,5 @@ void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
 {
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 
-	mutex_destroy(&vp_dev->admin_vq.cmd_lock);
 	vp_modern_remove(mdev);
 }
-- 
2.45.1

