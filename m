Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C832937A
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789358622; cv=none; b=JZyl64E9wfnk9s18XY05l/6+894a1E9WeW1i4mwwFG/H9YS8VRRzmkS+KBCBDhWocTqmYL962oTY4YM757eR961gWsIvGtL0/f4KIwcb8HisbBP9jWMwviqSXhWozkxqhfk2ts+u+5toRvHWuuGk168OFLvNGQqb1z8QyYnnI1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789358622; c=relaxed/simple;
	bh=qqo7APMuYRmz40m72oBvQUrF3Is0BBdbdy3rNR4+DjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAStDxRQ7NoV9vhqT3acNBQwe5icJCXcuMDLR8ZuMd0giYPCb7OvswmTkQQgGKmCt0eF480Hg7nayhW0Ipsh76/kgdqFDIJrRNTe9i+1SUaIsMSTiRUuGcubURu1wcG/1SkAn3bKEmxcK1yCoNaeGPGagTbG+hHTmDQHdKGYaug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfVjVmVD; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfVjVmVD"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309ce58730so29660971cf.2
        for <virtualization@lists.linux.dev>; Sun, 13 Sep 2026 21:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789358619; x=1789963419; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLnzNTwl6cA2paC1JejIJZG6aTRG3ekKPHTOqpPPe4s=;
        b=SfVjVmVDm6/VDzlfY9xwoY8ZRH/A/qbMtxk2uzMirW0Kk1tz7x3b6EHnt+K0521r0L
         5mdNknPqLE5/9gFPFvifnfwU2+R8pgq0nVG6DSH7kNqc7YGvNBsb9LUHzYWeUZR4NX/r
         oJ4HdXP/qXjLEATN/5CG+tEHewFxHu1+nMJ33pua6pYL0yan1ACtCCPbX2SChp1EPdRR
         pzgzyysmINqTvSsO0LAJuiCAqqNTRPZB269GtqvZgkGGqXORGRLhWWSj/lVRk5LEoYXn
         Z2jKcVRGsddzkgISlJDABlVyfj1L1p1JfYLpLFJYIznMyrgEV6vCAPFcw+AcU/XHzkx6
         +xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789358619; x=1789963419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLnzNTwl6cA2paC1JejIJZG6aTRG3ekKPHTOqpPPe4s=;
        b=QiN5PTfZNSbYQqO9iMxP1oywLgFF95rBXd/1uoQD5i58HO96Q2qhApriLZeQMsVQyo
         dvkhCfu0u/3PXQ26NW6ydxavN3XkSr2uS5hHKM1LWcafjlgqTmTbu+BCZ//DAQXZivnz
         DtCA7px2l759r0+qPvd3Ub9xhWvxygh7Qp0d5L/usqHbL9nrC0eSqoAPHsaFfNV73b+I
         k+HyEu5prJA3030RsiCxBoCCSEn4Fr0BA1L7drK5zHQbj4V2mCl0Pl2c1fGKUpalw2V4
         CkoQf1OiecB67stPIibIGjAD9XdqXNzoHmg3GX2vk/ASrQmzRDNmwUDfDTMe83V1E3ij
         3HTg==
X-Forwarded-Encrypted: i=1; AKwUvByO74xPuwgkmpbG6cARkEI5M1JOUT/mDuHdQWGP0mofF/I/5WpsbOa7aEy4jb0pU9kl42usSz22ilNioXIn5A==@lists.linux.dev
X-Gm-Message-State: AFuF++k+L3N0m27R7qoW9VUIHbDHVzOkqUbt0cnU9lldQayQdvfvBCvL
	/bInNHIMeDCVfmVZfG+5HDMn7SGclo4Ou5U+7MMqbtl69XS85G+Zyos+
X-Gm-Gg: AYBFou2mJmAhU+aHo1Zwq4WmExzsFulVuSmYLvYD7yJSPT4xjjrrRauZ2SmYbovPo26
	2k1B49zqEiSYx+v18AaurMvJu3BK5CMf+86OV582WtSXkUruoPzU11oBaYy0E5oMVVpHOo8jj2e
	SzpgjIadX+TcFoo4XWnrK/H9MtKL28WfWFTO4uQdt504bafYnUSeK0o4DdKu/AWkEqunx5p6OR8
	dlNemg5RSAqqfJqCN1/fIhOtHsqE8h03ZFehPr38qLrpcaXWpQSqewyPnJjkepkJcS4S6smwcQG
	39qNQwZ64TrvzuYSTHjS17MiQMrtwo0xrxQ9TnnBJzZNjSEIlnYi1aTPzUwUTlWhBj62bq0lfrG
	kYsC56etoGaOQ9oZcOlh3sItUSNhsNWSSEy+jP71kXboX3kB1fRw815t/aDECoM+GKI51fBSk6X
	ik3xoCUSUIxHjIUwuNLBf+4aZikFkn4SM7HYX8SVS3UtG7FRE9wfGuquBMc77MF54+yaxAPIqwp
	qSWY8a0Ff9cNBgYYcNeERFjV8hs6Smk
X-Received: by 2002:a05:622a:394:b0:530:b2e1:2f45 with SMTP id d75a77b69052e-5310d0c4294mr11756231cf.60.1789358619562;
        Sun, 13 Sep 2026 21:03:39 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca45b61dsm88435551cf.6.2026.09.13.21.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 21:03:39 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] vdpa/octeon_ep: Fix race condition in device deletion
Date: Mon, 14 Sep 2026 00:03:32 -0400
Message-ID: <20260914040332.1892175-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When firmware delivers OCTEP_VDPA_DEV_DEL_EVENT, octep_event_work()
checks if mgmt_dev->status is OCTEP_VDPA_DEV_STATUS_ADDED, but does
not claim ownership before calling octep_vdpa_dev_del(). Meanwhile,
userspace management deletion via octep_vdpa_dev_del() unconditionally
calls _vdpa_unregister_device() and marks status as REMOVED.

If a queued hardware DEL event checks the ADDED state and the management
path subsequently deletes the same oct_vdpa, the worker proceeds to call
octep_vdpa_dev_del() on the already unregistered and freed device. This
results in _vdpa_unregister_device() being invoked twice on the same
object, triggering a use-after-free or double release.

Fix this race by:
1. Atomically claiming deletion ownership in octep_vdpa_dev_del() using
   atomic_cmpxchg() from ADDED to REMOVED, and returning early if the
   device was already claimed for deletion.
2. Clearing mgmt_dev->oct_vdpa upon unregistration and on dev_add
   failure so dangling pointers are not referenced.
3. Reading mgmt_dev->oct_vdpa safely in octep_event_work() before
   invoking octep_vdpa_dev_del().
4. Canceling event work and ensuring child devices are unregistered
   before marking the management device UNINIT in octep_vdpa_remove_vf().

Fixes: a5786561649a ("vdpa/octeon_ep: Add vDPA device event handling for firmware notifications")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 85a3d35ea1e4..e29647bcf196 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -523,14 +523,16 @@ static void octep_vdpa_remove_vf(struct pci_dev *pdev)
 	int status;
 
 	oct_hw = &mgmt_dev->oct_hw;
-	status = atomic_read(&mgmt_dev->status);
-	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_UNINIT);
-
 	cancel_work_sync(&mgmt_dev->setup_task);
+	cancel_work_sync(&mgmt_dev->event_wk.work);
+
+	status = atomic_read(&mgmt_dev->status);
 	if ((status == OCTEP_VDPA_DEV_STATUS_READY) || (status == OCTEP_VDPA_DEV_STATUS_ADDED) ||
 	    (status == OCTEP_VDPA_DEV_STATUS_REMOVED))
 		vdpa_mgmtdev_unregister(&mgmt_dev->mdev);
 
+	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_UNINIT);
+
 	if (oct_hw->base[OCTEP_HW_CAPS_BAR])
 		octep_iounmap_region(pdev, oct_hw->base, OCTEP_HW_CAPS_BAR);
 
@@ -612,6 +614,7 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	return 0;
 
 vdpa_dev_put:
+	mgmt_dev->oct_vdpa = NULL;
 	put_device(&oct_vdpa->vdpa.dev);
 	return ret;
 }
@@ -619,8 +622,13 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 static void octep_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *vdpa_dev)
 {
 	struct octep_vdpa_mgmt_dev *mgmt_dev = container_of(mdev, struct octep_vdpa_mgmt_dev, mdev);
+
+	if (atomic_cmpxchg(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_ADDED,
+			   OCTEP_VDPA_DEV_STATUS_REMOVED) != OCTEP_VDPA_DEV_STATUS_ADDED)
+		return;
+
 	_vdpa_unregister_device(vdpa_dev);
-	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_REMOVED);
+	mgmt_dev->oct_vdpa = NULL;
 }
 
 static const struct vdpa_mgmtdev_ops octep_vdpa_mgmt_dev_ops = {
@@ -653,6 +661,7 @@ static void octep_event_work(struct work_struct *work)
 	u8 event = readb(addr + OCTEP_VF_EVENT_REG(0));
 	struct vdpa_dev_set_config config = {0};
 	char name[OCTEP_VDPA_NAME_BUFSIZE];
+	struct octep_vdpa *oct_vdpa;
 	int ret = 0;
 
 	switch (event) {
@@ -663,8 +672,9 @@ static void octep_event_work(struct work_struct *work)
 		}
 		break;
 	case OCTEP_VDPA_DEV_DEL_EVENT:
-		if (atomic_read(&mgmt_dev->status) == OCTEP_VDPA_DEV_STATUS_ADDED)
-			octep_vdpa_dev_del(&mgmt_dev->mdev, &mgmt_dev->oct_vdpa->vdpa);
+		oct_vdpa = READ_ONCE(mgmt_dev->oct_vdpa);
+		if (atomic_read(&mgmt_dev->status) == OCTEP_VDPA_DEV_STATUS_ADDED && oct_vdpa)
+			octep_vdpa_dev_del(&mgmt_dev->mdev, &oct_vdpa->vdpa);
 		break;
 	default:
 		break;
-- 
2.43.0

