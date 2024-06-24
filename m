Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769F4962B
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219903; cv=none; b=Xi6ZWeEhQHo9H/azBkaSGf/xEHS99wfM0nNwAM0o6s7jCU7klKmaQugOf806pIHn6WHhdmrhOEWsugaXCkHzyh1Sz3VgFsv1j/r+uqscpP5ZmXlD8QG9wbIEyLRbNTwQUe+Cov1BgigaaPSsbrpLw5mWUNW8CI9QMgAGID5UAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219903; c=relaxed/simple;
	bh=E0ZqKU1eQhYe2ubB4YqgRgTDhtRhWG79fRtWQ4Dul3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmtVNOI1DHsXZIUPtAZfsXH6XvJjILR1mxQq3MdPNwtzmSljeY71dQX/mZySn+WEzh/lAr148bDj6ouVaOUKA7rvQBp5C9kZ0PBPb/xkhfe4QROaUGAZt5g43L6G6kSzHRVZ1UtQWIidfuETl2vWiNUKn1SouIr2EO26O7txw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DgfzYdfL; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DgfzYdfL"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so49367861fa.3
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719219899; x=1719824699; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/45b42j2wvKffDG0uaEdaHcGGjQ1VyrfzVmw7MXxmc8=;
        b=DgfzYdfLIINKGovm+e3DGp89kd6wase+REHHpeC0PJmRwmycB6UUXNvR1cbUb+8c3V
         G5DO8iC9q9aV+OGRAVVwUdLb/9MFuTgQ5ZS8WzKWjvpJUpzXDU+erJeH85pUayEOeKCk
         g4o6SYpaO+B+xMXylvAx00pkI43V41YY9//i1eTryltjvt8UNmHDDbJLHzKJgQucc9WK
         /gcBTVL8bCIx7pb8I3AM9AvCWBRGG2WBKeYd7RjFH03EqYJFVy3Zv8njQSdwEH6b2lFY
         j6TFlUvtpRb/DxiMsCsvLNcLsqRBCVK4xFPD/q+VzhunkxJh+HFDDIxupJ5EiA6B+6GF
         XLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219899; x=1719824699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/45b42j2wvKffDG0uaEdaHcGGjQ1VyrfzVmw7MXxmc8=;
        b=UzrFXmQNspPoxu1dqt9dKM1YC0CUaFpbhdh3fIgmvppqLdg1fC3qr4Kqect6SatWSS
         g5sKb936COWBPKSpeuCS1UtZkNy3JaYEonxV7T818YZehraMRtxvlNfooeGKDcbqavHi
         BtDa3Gkv9sP3WAtmj3FusGTGmsQ4sx0ChZ7EXJE6AlGRGX6cWsDGiMBcxHWsWKiwfnk7
         m2TPaoFun9h60DdpoIdXdmvYYY2I/57ueSFLM/t+5yqNeSrmZw0eMNPixfLJUjtmyNQY
         jybkM+vDuxvGVnFSJ/JXhhI20xBb87jvTSYa3LdQ8aFTPq2yiWJe0FmyP8CLuWjCBCaC
         egZA==
X-Gm-Message-State: AOJu0YyOe1NzuXZ/AxkaXDCkEanvsWfN1Q3VCApxdo2RCwXYt7ojVfCb
	FtKqKfeK0CpPj8ixI/Luz0Hv9BAmZ8nbucuyt5/KRV6Cg2ulv7OkRDE0qj+hXODoeWFXf2FZ/uf
	ZrME=
X-Google-Smtp-Source: AGHT+IFsxebA4HD7iOh1gy0mUruwKmqhxpVPErpVrzJ95qWobHf+cdO1NJLW9D17uj8Rhu8ykeFFXA==
X-Received: by 2002:a2e:9b55:0:b0:2ec:50dc:af8d with SMTP id 38308e7fff4ca-2ec5b29fc03mr21972501fa.12.1719219898558;
        Mon, 24 Jun 2024 02:04:58 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366e88c0c38sm5058916f8f.32.2024.06.24.02.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:04:58 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com
Subject: [PATCH virtio 1/8] virtio_pci: push out single vq find code to vp_find_one_vq_msix()
Date: Mon, 24 Jun 2024 11:04:44 +0200
Message-ID: <20240624090451.2683976-2-jiri@resnulli.us>
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

In order to be reused for admin queue setup, push out common code to
setup and configure irq for one vq into a separate helper.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 69 ++++++++++++++++++------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f6b0b00e4599..1fb2183e409b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -284,6 +284,44 @@ void vp_del_vqs(struct virtio_device *vdev)
 	vp_dev->vqs = NULL;
 }
 
+static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
+					     int queue_idx,
+					     vq_callback_t *callback,
+					     const char *name, bool ctx,
+					     int *allocated_vectors)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtqueue *vq;
+	u16 msix_vec;
+	int err;
+
+	if (!callback)
+		msix_vec = VIRTIO_MSI_NO_VECTOR;
+	else if (vp_dev->per_vq_vectors)
+		msix_vec = (*allocated_vectors)++;
+	else
+		msix_vec = VP_MSIX_VQ_VECTOR;
+	vq = vp_setup_vq(vdev, queue_idx++, callback, name, ctx, msix_vec);
+	if (IS_ERR(vq))
+		return vq;
+
+	if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
+		return vq;
+
+	/* allocate per-vq irq if available and necessary */
+	snprintf(vp_dev->msix_names[msix_vec], sizeof(*vp_dev->msix_names),
+		 "%s-%s", dev_name(&vp_dev->vdev.dev), name);
+	err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
+			  vring_interrupt, 0,
+			  vp_dev->msix_names[msix_vec], vq);
+	if (err) {
+		vp_del_vq(vq);
+		return ERR_PTR(err);
+	}
+
+	return vq;
+}
+
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
 		const char * const names[], bool per_vq_vectors,
@@ -291,7 +329,6 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	u16 msix_vec;
 	int i, err, nvectors, allocated_vectors, queue_idx = 0;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
@@ -321,37 +358,13 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			vqs[i] = NULL;
 			continue;
 		}
-
-		if (!callbacks[i])
-			msix_vec = VIRTIO_MSI_NO_VECTOR;
-		else if (vp_dev->per_vq_vectors)
-			msix_vec = allocated_vectors++;
-		else
-			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     ctx ? ctx[i] : false,
-				     msix_vec);
+		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, callbacks[i],
+					     names[i], ctx ? ctx[i] : false,
+					     &allocated_vectors);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
 		}
-
-		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
-			continue;
-
-		/* allocate per-vq irq if available and necessary */
-		snprintf(vp_dev->msix_names[msix_vec],
-			 sizeof *vp_dev->msix_names,
-			 "%s-%s",
-			 dev_name(&vp_dev->vdev.dev), names[i]);
-		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
-				  vring_interrupt, 0,
-				  vp_dev->msix_names[msix_vec],
-				  vqs[i]);
-		if (err) {
-			vp_del_vq(vqs[i]);
-			goto error_find;
-		}
 	}
 	return 0;
 
-- 
2.45.1

