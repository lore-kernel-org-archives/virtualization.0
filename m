Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360661991C6
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129768; cv=none; b=JaK0dlXspua+pahBZI0r/hk/jHFvthHW9xy1VxzFeKGmqx7thDOaPyhLw9QnKEnZDBQINVNdg7I+5QSHcvyT3/Fpkj/qgpTBcwW/rE18bJz3vIAoAnYtySNte2mpV7qEW/DEFwM/l1UopVZorMpkWUSKog65r2RpzbBF5zji9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129768; c=relaxed/simple;
	bh=VMvzt0STg1hEcgswaVYvSlNInE21YIcDZBn1YU9g7fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWT/zmbkyZEzCnN3k5lNO+B+1fWcbw2XosLLxx9NJt64161SmnOWXwtkHjYfii3VNyd+u1h+b5FuytR12STC6YjhhDBTWFGCvrmBX2NGw/2KC38w3yy5hLd+eSEnPt9nNvPs0BoQBY8DysTPW97/wAToN0sOPVLywAEV5KISEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Eb1FvAzY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Eb1FvAzY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367a081d1cdso2880800f8f.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129764; x=1721734564; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xq0z7qDnKLcuG2bdgPVenX7I5loiNYf7yPy5HkHLATM=;
        b=Eb1FvAzYkuXyBOU3lekzpmTF5sSpV7bRfJYpyh31Z5UKn0yOknlDaa6Vp5HpmiKHz8
         Sr4vXY7LX+6s5NpJuhj52n+rN/x/V92wNvFknoEn8t4HYWL/5rIfTEqkNw+H2xoWbSLM
         VUt6x28+fzTqyV8Ta/wxsqQyok0gGyrRYqOx8P7hGD1a9d7Lk5cW5f0GSQNA+qRBLaI1
         6Vr8iE5WN5GL2efYBm7WFLsCSDLCXKVOIp2ibtLx/1q1/466zGOasSvHN/7902VFLVov
         Esev6Ur4HVG20PoaLJYJyQrV0bIdyaXrR2R0Q6HzdECqOJWZ0hIU/IdkpAUU0AwTi+fv
         yhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129764; x=1721734564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq0z7qDnKLcuG2bdgPVenX7I5loiNYf7yPy5HkHLATM=;
        b=HdzKaONxWXkl1GxkxyHy1byW2l2N/Vf/ie3J0k8GvCJZzKa/CmqbDpxCp8Al4/BpX0
         p/M2MWx3Ru8HkzVbeEj5n8bm7dcCGBS4iyi9+Y6Q5OEIEIqI/f+zyX1aYeBb1ELt559s
         7zC+nczoRE0hbwSpj4PfABE3WWwdOAvIpcce9PU3Umg2SZrtclE7OIbxLI5MROT6LVDr
         mOSFUdebLbQFxFUNyYJTSno2KqEL5Rx62R3hpPQzocMJK2KpqYHynq3kp/yvZW0L4kp/
         91Z0qL+YDMtJUnbbBDhLbVJ60kHqNSsoH5sDpAnaRreAKdqRi9mVFDQxM/XjquXpvm0y
         kHhQ==
X-Gm-Message-State: AOJu0YyucvPSi8OwtCa3vbQ8t5if3u7pAOTjphFCPf7C5puBbaK4+3gA
	8HlIyacBUu011QBcPqmy6lb00+Kp3QIpwTNOYWsmaXMmHWIZRLa3if9d4r+kFSYSooDBC3zxKHJ
	Yb+g=
X-Google-Smtp-Source: AGHT+IE0k9yhzrWAF1ivTJ/UUxCLJpt+uRGKB3dy1BY1ywYKnX8XKWqdJgN2SM8LdSFozA3Wjin+7w==
X-Received: by 2002:a5d:6d05:0:b0:367:f13b:ae8c with SMTP id ffacd0b85a97d-36826324a0emr1474170f8f.47.1721129764682;
        Tue, 16 Jul 2024 04:36:04 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680d9771aasm8989573f8f.0.2024.07.16.04.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:04 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 02/13] virtio_pci: simplify vp_request_msix_vectors() call a bit
Date: Tue, 16 Jul 2024 13:35:41 +0200
Message-ID: <20240716113552.80599-3-jiri@resnulli.us>
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

Pass desc arg as it is always to vp_request_msix_vectors(). There rely
on per_vq_vectors arg and null desc in case it is false.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 277591a6ab96..cda0d35dd9e1 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -125,6 +125,9 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 					GFP_KERNEL))
 			goto error;
 
+	if (!per_vq_vectors)
+		desc = NULL;
+
 	if (desc) {
 		flags |= PCI_IRQ_AFFINITY;
 		desc->pre_vectors++; /* virtio config vector */
@@ -349,8 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		nvectors = 2;
 	}
 
-	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors,
-				      per_vq_vectors ? desc : NULL);
+	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors, desc);
 	if (err)
 		goto error_find;
 
-- 
2.45.2

