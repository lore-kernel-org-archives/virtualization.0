Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB401339714
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027204; cv=none; b=MmqrkbZc8MAM8VJHKy86zpzppcWL6Uf/ESP+ZSzagSFb2Fm3495oLdlPLjPro5t7nRxi8B7tM2f67RN0G1UdsDmf3eND4v1S5pQ4P3Gd48mLxWK00AZtKtGTPuZiwHr6fLcHtI9gZT+zffoTcX0KPO7JA/aMz1x1JgzVrh+8OIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027204; c=relaxed/simple;
	bh=i5lJDuKpaj451ORek1RkuNKvrVPA7j5ESmxEVRGGCBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wx0jPshQzsbhtoEaQ9rTZTKcgpNI5M7F90+NZ+ifqryOWfQahqasHQmo/dIgiTpxB3pweCr7rCUuqE5t68pcFagrkKn5EHvT+NmQCHx4dzM0cPUz4sjYGpzK3GHZxhJ6uZBS6hrcqoQ+0gUTFqdf3D0TMHLKULEtRGdgjmj6xNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCf4QtOH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCf4QtOH"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a2dcede83so5694017b3a.3
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 21:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787027202; x=1787632002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UpRGh7AB0RzVN4Z1bHcSA/fyKDz1HZtg4D8+CDGvt3U=;
        b=QCf4QtOHdOOymGaUwT/11CX7UrI8vlCVBPfW8eM07hwskdSFHvOQs4buTixMxTuiBd
         PaX3NNnRImF2I+/NJvUmEyU2TtJQxN+h+gAhFBFHMJ0E2pRN9wmPBGI6p9BlISEeWKgH
         8LY2C11FcZ/uDuHP8KQpU25N97/gEdRORy+qPI/UBrBSdN3CGRo4cZnhT3gC55CRwRla
         TOV1vGigcKBOQ1HSqH0EQAOhInsLB0m/L6Xzvn88luLavnf1M/WfsCAQFQYDLxy11IoM
         NbhP5ZDVmOF3lXskbJmjQF7GkKYycPMm/3QuDIK+4cEjIG+3Hd3sLZi+bWgvKjxKv2j5
         Qd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027202; x=1787632002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UpRGh7AB0RzVN4Z1bHcSA/fyKDz1HZtg4D8+CDGvt3U=;
        b=l9JPwfvXpmNdpEXVgT4LdCIis0/hy+bFRt61IFOkdhITiLdOC7NG1d2ElJ0gu91cYe
         CGe09Ng08V6jiNoG/i1IaCmfjUryDOhkX1V8HpWTimPaVAY7mO2FmGujiE2fI2ZtGbo3
         q8x5k0P979IQjxC8R68189g4WMD7jtqo1HOVjYa4qfQ3ONbJODIUvXgRtDPPTtHIyaz8
         eOtQmPwFao5KHNtQbFQXIzmMP37bSO3EuFAmRY8glSu+RvAzOASyOkWrK5DWB+Gx7fsR
         nKX9tmWE6dpo98NWn+lhCM6tQcVwB97A4hfZ6HbBbnshoUjybzNu40ep3uxAf5Afh0V2
         2N5g==
X-Forwarded-Encrypted: i=1; AHgh+RqDZb+Dbxp+41mHLrkRPECmhzbTrYNJ3+zpM8RJ5LUuUzb1O6/yeSM3U9zCV0bO3CiXXBn9ydqJ2xyusuyW/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcVc66Vtwyq3B4IJ6HzBn8wsYIIdUtOb972kDQae59axgndr/Y
	+xaBTMXF8rtXaynN5fbFUKU7ZVB0FHqD27KS44uFyMjwhCsmODq8bZbq
X-Gm-Gg: AR+sD13Kau/osbYJLY0Vl708UPTxb0LbBjGkWAT/0HdquLw/Cbf/rwOUJ0CXPzzbAqC
	PCrW48fZvWv7V5pkHvwShCrGVEbqJ2NcuNTmaVm2pG/1VxKGk+QyrOl7Igot08PYxLAUrv1wh9w
	0/EtLch6HvKuXsOKzifzYkmHhVulSy0trwRmLBVOURzvYJxdKfgNyL5IJSMgeAyqjpdYlqWs0Vo
	qF3Vg7bDO35RcRLEqwGQruc0PZlVwbAib/cKHGFiNKtzERC39NE9NVLheo03LM/PEKpE4aEo9Wc
	/f9DgEBDJg1Kgjlhc6qYAo0OSPJIP5rdwcQQvJB4dRu65rkAQvPOl59Gbh7Zeb16OUxRtuVtd4+
	g3Y76Qs4Tu+WV2xpfsG/PZSeEpBYVwOgNogd2EqdRBTFYX3IX8dlaYkuFp3+SOcMyLPyiLelz4S
	WCSIkBzzBnTThJ+Qrs/FuJW6xaf/mjHrUxHgrmlS5i710vJm5RmtPt3Co800Rljgrtb71Xjg==
X-Received: by 2002:a05:6a00:4ac3:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-84fde001affmr33624373b3a.13.1787027201198;
        Mon, 17 Aug 2026 21:26:41 -0700 (PDT)
Received: from jia ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fefb3asm1005919b3a.53.2026.08.17.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:26:40 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v6 1/3] vhost: invalidate vring access on IOTLB transitions
Date: Tue, 18 Aug 2026 12:26:11 +0800
Message-Id: <20260818042613.281125-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818042613.281125-1-physicalmtea@gmail.com>
References: <20260818042613.281125-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
used change meaning with the address space. Clear the cached vring access
state when the device IOTLB is installed or removed so stale IOVAs cannot
be reused as direct userspace addresses.

Keep device IOTLB initialization idempotent and apply the mode change even
when a virtqueue backend is attached. Drop the device-wide IOTLB first,
then clear each VQ state under its own mutex, and keep the old table alive
until every VQ has completed the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses
for the new address mode before data processing can resume.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..9f74537b1c1c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
 		vq->meta_iotlb[j] = NULL;
 }
 
+/* Caller must hold the virtqueue mutex. */
+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
+{
+	vq->desc = NULL;
+	vq->avail = NULL;
+	vq->used = NULL;
+	vq->log_used = false;
+	vq->log_addr = -1ull;
+	__vhost_vq_meta_reset(vq);
+}
+
 static void vhost_vq_meta_reset(struct vhost_dev *d)
 {
 	int i;
@@ -1911,6 +1922,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
 	unsigned int num = vq->num;
 
+	if (!vq->desc || !vq->avail || !vq->used)
+		return 0;
+
 	if (!vq->iotlb)
 		return 1;
 
@@ -2270,11 +2284,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
+/* Caller must hold the device mutex. */
+void vhost_clear_device_iotlb(struct vhost_dev *d)
+{
+	struct vhost_iotlb *iotlb;
+	int i;
+
+	iotlb = d->iotlb;
+	if (!iotlb)
+		return;
+
+	/*
+	 * Drop the device-wide view first.  Each VQ then drops its
+	 * per-VQ view and its cached ring access under its own mutex.
+	 * Keep the old table alive until every VQ has completed this
+	 * handoff, since a worker may still be using it while waiting
+	 * for its VQ mutex.
+	 */
+	d->iotlb = NULL;
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->iotlb = NULL;
+		vhost_vq_invalidate_access(vq);
+		mutex_unlock(&vq->mutex);
+	}
+
+	vhost_clear_msg(d);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
+}
+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
+
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
 	int i;
 
+	if (d->iotlb)
+		return 0;
+
 	niotlb = iotlb_alloc();
 	if (!niotlb)
 		return -ENOMEM;
@@ -2287,7 +2338,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
 
 		mutex_lock(&vq->mutex);
 		vq->iotlb = niotlb;
-		__vhost_vq_meta_reset(vq);
+		vhost_vq_invalidate_access(vq);
 		mutex_unlock(&vq->mutex);
 	}
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..3c75e8089373 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock);
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 			     struct iov_iter *from);
+void vhost_clear_device_iotlb(struct vhost_dev *d);
 int vhost_init_device_iotlb(struct vhost_dev *d);
 
 void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,

