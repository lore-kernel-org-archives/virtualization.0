Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80F55897
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129802; cv=none; b=U/dGQqzYVpbZSKih49OD5/QWlFnyD3le57sV4c0tYop51esGhJ2CkiolBVWhhRu1Ogdu2UNWeNYh83/sUsxCZkJKnGotXGvTu5m+EhXOZ5TBBvGAmn4QjvzhaBf0NEevp6jIokUiqB81ig4/Ckw5kU1/8p0N9xhWP8x9AEV6uwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129802; c=relaxed/simple;
	bh=VeApwUj6+Ix5J5n2FpXdppl0Uw5f2RJODWXk+5IGJnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mixX2C5MEhs61cjKOzOElRg6wNU4SdKJGkq27Sh+Gl6nuDxeUC/oH1CVVJGN62J8RrZIOvex/UkoybtYBLO7kW+AHLtNfV6AlabwBzDRwOPaQRZkbJpve4wzxxIxxOXbsgA+IDHlnQHjFFWWqIaoowHRt9WY1JGH4gV4a2LreyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WAtRnBOd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WAtRnBOd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266f535e82so36317865e9.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129799; x=1721734599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSJ5GO+Bw4UkjafRqM7dwa7YBd+IbWArRPNEQsW6YE4=;
        b=WAtRnBOdx4kWSufhqhR/las2F9FL2L0Deyw9HMH1bx3+HyF+JPaJX/o65CqAw+cvdM
         /Lq1Di2Bu5m3ciI9iOnj3d7OhCPiRf9LpJTerKTvZ7Y5cUTiH2clQOnUNnL1160+pYD/
         FLTMyQrBMuz+09qu0b8gGzNmnoMAQZX0gaHKNtuE7qO1/QDtSiAHrdQBzswVCQZM08j8
         Naq8W+uLwJSQWirFcgDNkDcbCTC7oNIOqJ5DgEuZ9cjl57euZVanGEgxlxVED+F2o+fP
         b7T8IZ0WsmQctN3azKsZkzb4USvq2vbkWIcuIbTjx3O4izBuNc4DWXdZr33IufD0d184
         ZZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129799; x=1721734599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSJ5GO+Bw4UkjafRqM7dwa7YBd+IbWArRPNEQsW6YE4=;
        b=JIAXlyL7SkbZpKlKVHzTtdwqpXpkrhOOAZbn5C7yKTVisaMV11n3CIM+ahaLASEOZh
         YQ3B9PTVuIC1zxPf9MUbHoAQ6zdvct2X2v0cl3d/GWF2I+4ge54OuLvEXUvfIBnEKebS
         XK6ULBXItwCvTHd9mWteYE/kHnu6A0sHx2X5yXt8oweatADtTLzKoL5rtOSfoyoaIJkw
         deg+GXxDkKRExTZGP/wO9Rn6Q4SpAacM2LQVr3FtQFSXaFm7DzgKdqK/tV1RA26g+kEm
         s+o5Mem4mqAYe6Gv1VfsJHEmr2OQhcBYsxM+d9cQSSM/SxU3321Og0UXe/cOuEgoYjyL
         fLbA==
X-Gm-Message-State: AOJu0Yw7EbP+pQDMIBPkcdTfQ/MMXFNVChJjCtYatbvRzmNhkpAvjf38
	VVe7cpFJRyK4qNUmYFa3+gZseRFiprAZT1Xb60osAi0Zh6acHb8/wI9bovipGH4bIM+ZCTiWZJW
	1vkA=
X-Google-Smtp-Source: AGHT+IEWkRH4P1tikd5ZKSn/3GirIjU8L+4ZXPqDRNlcPZL5DRVmfpnoo1aoY+GJyev98LStVYgokA==
X-Received: by 2002:a05:600c:46c3:b0:427:abed:3602 with SMTP id 5b1f17b1804b1-427ba7033cbmr12000375e9.24.1721129799417;
        Tue, 16 Jul 2024 04:36:39 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc229sm157858645e9.38.2024.07.16.04.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 11/13] virtio_pci_modern: pass cmd as an identification token
Date: Tue, 16 Jul 2024 13:35:50 +0200
Message-ID: <20240716113552.80599-12-jiri@resnulli.us>
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

