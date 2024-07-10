Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86266FE16
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593385; cv=none; b=XySjnC3hBgoDuhSsrsNytxsIM2DtHMNGXWVnV3WS5tnGu/eDd7+zn4fTG/uV/B/N+7bneR9V9xA/Yv35QDWgEDFAtbI9yJHOuY02j3SPFr+ClLzLKC0fRt26vMNiNiFwSUYnjC7gT4u/WnUT4x2AMFI/+6f470fCMcXHor0b5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593385; c=relaxed/simple;
	bh=VeApwUj6+Ix5J5n2FpXdppl0Uw5f2RJODWXk+5IGJnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO9iHPD/HXZfml4yrjJMWqOH9Y2+8WESV1Sr77LmLQ+rWcwiR/l/CjIOSwcEs8Q9Q936vNKo0i8y9aP/940HQOzXbLpV9FMF+HEYDkJGE4cG/sOH34WSSOs2F2R5gLTQEUQHcVfzUb2ENwItPHaKn9s1KcMUHM+I6lHt9H9DADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=guUFvU+0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="guUFvU+0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so13613765e9.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593382; x=1721198182; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSJ5GO+Bw4UkjafRqM7dwa7YBd+IbWArRPNEQsW6YE4=;
        b=guUFvU+0NeaofWbOSBsrBxuMnGeSIUPYollIWGq+mjdw1FVbJVTKF24NmMZowW3Jxh
         wD9NfAoNNwCADStBvM5QkxscsausDNaeJmDy4F3SeRbO6UniNQOFgwCez68Cr8N0JPFy
         r08EYb+O41oPY5pTgURvp7LQK4BHpXQINRmOM9BWG25cfTu18j+3ZPFdficMIFvtdTh7
         wQVQ6ichgUch9fpCzUXUyGoWhs4nPjV3ufUB1pBZEob70KhM4vJPVLrF6IZactFDDk4A
         UK5xEXM9wC7nGL4dcaFid1BlBUdMLHqzpQeuBkC9VsiBrhv/TnmtWS95XbOYOxUNL9Wp
         +DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593382; x=1721198182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSJ5GO+Bw4UkjafRqM7dwa7YBd+IbWArRPNEQsW6YE4=;
        b=IKB+2vrgr9ekA9xnWFgHr+0s/pJQ7Ob3EbZg+QtPTDgiyQ2ZAMjfuIWx8DjmC2HfcZ
         PCwGk0TX2WF5OQW4XY4x8sjfIu5PSEl5+NHs9EdlZqXqyTnSnLMMnAfUyPeFE7IHTvjM
         dZOB1r7qNEFNvo2F/j7Btd0TtlFhvyqxFmGpMZ6eP7B0/O++hgDmJtc6ZDeCm39OQWZy
         nGg3MdcxP7j5o81M20ccFpQ677D4Cg91iwyDdJ6Yf3EhZct8n725fRvhbQVedRm/R4rC
         Jl9axYO5xWKnMBlUSqvPFcETXY/Y5wwX51UVUHbINciKJ0IjpPaGo8WfkLBFBk4wYWbk
         WkAQ==
X-Gm-Message-State: AOJu0YxA/zkgghEPviyJhEjLNthagC2yT/W5MuMRbNOZ1r7c6gqylnb0
	d4pz17+cGVWvMfKUFmvSghW4BUcAQ1xbeALBUGMs3bCfZNJQmF8AIA9c4BRFB/I1VjLfSKLiOWo
	r
X-Google-Smtp-Source: AGHT+IF2Wpzcg0d6BVJmjjMgiLWsdewgRW3AL3DysY/7cNEwwrEsKSuSf7eKYdQLHj8cYQOWE2dX3g==
X-Received: by 2002:a7b:c452:0:b0:426:623f:34ae with SMTP id 5b1f17b1804b1-426707d8bd5mr30542055e9.16.1720593382317;
        Tue, 09 Jul 2024 23:36:22 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42650b26c48sm200523145e9.17.2024.07.09.23.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:21 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 11/13] virtio_pci_modern: pass cmd as an identification token
Date: Wed, 10 Jul 2024 08:35:59 +0200
Message-ID: <20240710063601.2000149-12-jiri@resnulli.us>
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

In preparation to asynchronous admin queue processing, pass cmd pointer
as a data arg to virtqueue_add_sgs().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index a649c9dc436d..0fd344d1eaf9 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -58,7 +58,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 				    struct scatterlist **sgs,
 				    unsigned int out_num,
 				    unsigned int in_num,
-				    void *data)
+				    struct virtio_admin_cmd *cmd)
 {
 	struct virtqueue *vq;
 	int ret, len;
@@ -72,7 +72,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 	    !((1ULL << opcode) & admin_vq->supported_cmds))
 		return -EOPNOTSUPP;
 
-	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, data, GFP_KERNEL);
+	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
 	if (ret < 0)
 		return -EIO;
 
@@ -140,7 +140,7 @@ int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 	mutex_lock(&vp_dev->admin_vq.cmd_lock);
 	ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq,
 				       le16_to_cpu(cmd->opcode),
-				       sgs, out_num, in_num, sgs);
+				       sgs, out_num, in_num, cmd);
 	mutex_unlock(&vp_dev->admin_vq.cmd_lock);
 
 	if (ret) {
-- 
2.45.2

