Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2C55897
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129772; cv=none; b=SWPZl9SZ/cDss45taHGb6n0Bf6GRlYWIY4U+DdLVXp0oK3hM76tzx003ZFhExisyk8n29ogtMTSlMvnMZoSkkGRRfzb5AW6lc6BAEh8yCzbUCQiaLdAddvXrtblZ2a9Njkd9i6qfAuUYNUlc03aF3lEQsBgjr+rTLAY9DGDmWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129772; c=relaxed/simple;
	bh=bec4iyc1Sbq8yz22gt4sGJY5B9VhdZtggRzMHArlerw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf/XDfwU6sx4LXwKUuDseRWeDqjhPfuex/Z+ELQ+QigJfdZiNRc1efH7D1t03XLFgNwDrvizKffWAg41v6+D0z1wHwH8z+8KPZic/EKQVrcc+eHlEpwOhiupA6h7TguMHPAB98gVMXfCgijJIfj0ypjggXq9ZNbYBG/veRgAXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i1g0v+lU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i1g0v+lU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so42487625e9.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129769; x=1721734569; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnc5ZKFUsODytzmx/tV2yHyZn0mfCK3BqMy05RDjN4k=;
        b=i1g0v+lUzm/pSMwPOX3OdsFBrSZk88ri9gRfw3zMqQfwiYmBRNdsVGGTyu10LuKxrY
         Dfu0xIgPU72rqCisEdjUUWWAL1skLIYY3gBBHCHV/e9tMKAeqQHkMjsauQiFFtfU9udv
         6BEyPKHRQIi2pyd2q2qZkQ21dJk65+OXbFuVSUKLY+nIzJVzcwOzPQMESY6WasPlQO97
         9XLKxZZrzDRyAetE08FS0LJ/SPEJeGaBtxfzCHY6hlonsAHCS5Yzb9Znu3PRKfEry90W
         Muy8dKDdGgN3AsT5/ZOufJ7Tit8CqnkcyuQq+jr6WHKEoaBXXzqzR1cGGHuhwZ4MjgBQ
         qAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129769; x=1721734569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnc5ZKFUsODytzmx/tV2yHyZn0mfCK3BqMy05RDjN4k=;
        b=t5fkPAdfUxuBuQfO9ouB09QTAOvDR1WXONBwaHKiqK2sNyWnDhlva4UUGTsYABI4jm
         X3TDuyz1+a6TEI7Quhfb4mz6zMP6C3n5cfh7BVcbLD1V7CpOnoL27wAD06/vMnZGoZhK
         przEXW0Qz5y+O8TdfsOKC/0h21J2j+1FQenhS2jjAbXtxM6r2mophrgU6w5QnarlRjBT
         WUAZGShf/83VP/2/FiEqs5fwgz6z1pWFvHbQQ1Om5COptyVxVGSxmhsvmzOTHfVy/ReS
         MLoZ0XHOO1Uwf2osMgD+K51U1AbDCok3D6XOnknmvP+HoPIooBRQPhYn9WzYGk5Fz2lP
         bpPQ==
X-Gm-Message-State: AOJu0Yw4F5RokMMCxrLP+up8fC+OxO3TS2VUf+KMUvysOwpiie/9wEkj
	yBxQlsj/uIg2GR10ONbDsthCNGu4v/gbNkgKb1UWbfA6/Pzn0qiU3cllFzZsrWuXSjCRC9Ej3Xg
	wz6o=
X-Google-Smtp-Source: AGHT+IEiomJXtzBs2FkH7a+wVPU41hiPGw4w96hgFH8Au7e2S6GJdvPl+etnMSuJOHLLXhBfBjtPjA==
X-Received: by 2002:a05:600c:4708:b0:426:673a:2904 with SMTP id 5b1f17b1804b1-427ba71ecdamr16108315e9.36.1721129768584;
        Tue, 16 Jul 2024 04:36:08 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e93c92sm125031205e9.22.2024.07.16.04.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:08 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 03/13] virtio_pci: pass vector policy enum to vp_find_vqs_msix()
Date: Tue, 16 Jul 2024 13:35:42 +0200
Message-ID: <20240716113552.80599-4-jiri@resnulli.us>
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

In preparation for another irq allocation fallback,
introduce vector policy enum and pass the values
to vp_find_vqs_msix() instead of bool arg.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rebased on top if find_vqs() arg conversion patchset
---
 drivers/virtio/virtio_pci_common.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index cda0d35dd9e1..7fec2258d125 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -287,6 +287,11 @@ void vp_del_vqs(struct virtio_device *vdev)
 	vp_dev->vqs = NULL;
 }
 
+enum vp_vq_vector_policy {
+	VP_VQ_VECTOR_POLICY_EACH,
+	VP_VQ_VECTOR_POLICY_SHARED,
+};
+
 static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
 					     int queue_idx,
 					     vq_callback_t *callback,
@@ -328,17 +333,20 @@ static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			    struct virtqueue *vqs[],
 			    struct virtqueue_info vqs_info[],
-			    bool per_vq_vectors,
+			    enum vp_vq_vector_policy vector_policy,
 			    struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue_info *vqi;
 	int i, err, nvectors, allocated_vectors, queue_idx = 0;
+	bool per_vq_vectors;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
+	per_vq_vectors = vector_policy != VP_VQ_VECTOR_POLICY_SHARED;
+
 	if (per_vq_vectors) {
 		/* Best option: one for change interrupt, one per vq. */
 		nvectors = 1;
@@ -427,11 +435,13 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info, true, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info,
+			       VP_VQ_VECTOR_POLICY_EACH, desc);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info, false, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info,
+			       VP_VQ_VECTOR_POLICY_SHARED, desc);
 	if (!err)
 		return 0;
 	/* Is there an interrupt? If not give up. */
-- 
2.45.2

