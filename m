Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF136FE16
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593377; cv=none; b=WTuDmCGCWl/fzxMlK6u6l6U5CrduFYjOS7EpylwooFbrkohxJ+QgqlfolfzxRR9vgPlOut9J1G4G+JnWALDEYaZaYWa4saU7pX1mFcdo9Govtm2Al+/R8L7XWA6T2HRTU0JBw2g9QR1HADDs0sQ1hb3QNexCkqwOZcU24oR05Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593377; c=relaxed/simple;
	bh=nteVyXjgfpS4fSC8Dpr+1qY1lavd9fMKprQgm5QLxVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTkdviOCehveHayH3ErgKQjpktZLacN8+Y7Tz0MV3fohqDZQFBUIEVaZbJRr8yclLcEqcrIDEtAJuVUh01XSiZmiXNuxJrR9lVtSLVftyd2iLl7dCjBsPF+yp+/86obsmMzsc1G97uEdEaIrFOA7l7Omibul0RfMQTlf8C7KEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hckgaXmk; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hckgaXmk"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee910d6aaeso66218241fa.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593374; x=1721198174; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbu9oMg7pQfBqvpQVyX/tLEKFDsAREKU93l2yotCovU=;
        b=hckgaXmkZGFvSCINT7iLGYoN7xB2M/plfXyCEHQDz2XJHcw+FiKS/jW/cIhhzLK0In
         egj3TJrboAIl9Eow1tvorTdz/3qs0J6EZvI0gtfsAZmkXzG8sPtOod+3+yj9wBqwZMJG
         z+UOiS60QDBmXIfcnYkl3Z92u8oTuUBGdvumcDGZSAp2lvl55chHY1CBYM6D6xrUxUoD
         IOFs15s5LodBNtN5IoAq4e0r0BGGBXy5UKkGgtWL4NQksP+013QD1TxObuasVaSCbGDi
         2uEvW0gXJgaA1GQdspkMTjVYyQupAPiA4ds2GoM0BP6J8aOggs/uTyfmV7LLty0faN99
         NlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593374; x=1721198174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbu9oMg7pQfBqvpQVyX/tLEKFDsAREKU93l2yotCovU=;
        b=vAhrWoeyQl4+TFSua7UTG68t7yZ6IYJg+JA3y+UXUvmksZ0XDzZEXOl2daz786PfHS
         BGSeY452nLE10ZqzLEC6saJ3OX8lhGZhnVSHTVHaeqCI4pGdpxmIcxeShL92wtRoUrK0
         dKP/cNqYdtqgxAAqHii0FDc1xt4wE9W3Hoo+ZCIWWQo0/ugaKqwM+l0xl9FXTu9k0kGA
         jBswLnfSwUhNIOILSw3vuW70KMuiMs8nbaFlPvQk51MnSfn5IyWUxkOovEjFO8mTujp0
         RbgycSId9j8r4tca0vtaek1cbJhuolygL70nqEMBazWRqJuIzbZ7B1lpwILV3Bbw1X3v
         YmMA==
X-Gm-Message-State: AOJu0YyvkWQAmryFkYzkC9HjHsaTQIh62D3T1Mc1yRAh9PpFLyP16Vx0
	qHqEpFym05BNxcZn03NqOECm8aaErtCMBO2+YgJzYZRD3oZdh1Y2emkoVJ/+GFAmfEdm8sWI5vs
	y
X-Google-Smtp-Source: AGHT+IHsQM0OnDRnIiTjyLn+8a6Htk7l61pa66cweKSx2axeyCkOgZ30ru9G2xNDIQtznggmu2aBUQ==
X-Received: by 2002:a05:6512:1256:b0:52e:97e5:a9dc with SMTP id 2adb3069b0e04-52eb99d3de1mr3110993e87.65.1720593373784;
        Tue, 09 Jul 2024 23:36:13 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4265e9de055sm162843635e9.34.2024.07.09.23.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:13 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 06/13] virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
Date: Wed, 10 Jul 2024 08:35:54 +0200
Message-ID: <20240710063601.2000149-7-jiri@resnulli.us>
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

It is guaranteed by the virtio_pci and PCI layers that none of the VFs
is probed before setup_vq() is called for admin queue and after del_vq()
is called for admin queue. Therefore treat vp_dev->admin_vq.info.vq as
static, don't null it and don't take cmd lock during assign.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_common.h |  2 +-
 drivers/virtio/virtio_pci_modern.c | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 0cb6fdc8c354..aa43875b6353 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -45,7 +45,7 @@ struct virtio_pci_vq_info {
 struct virtio_pci_admin_vq {
 	/* Virtqueue info associated with this admin queue. */
 	struct virtio_pci_vq_info info;
-	/* serializing admin commands execution and virtqueue deletion */
+	/* serializing admin commands execution. */
 	struct mutex cmd_lock;
 	u64 supported_cmds;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 3b5b9499a53a..6d653bea9a87 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -580,11 +580,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		goto err;
 	}
 
-	if (is_avq) {
-		mutex_lock(&vp_dev->admin_vq.cmd_lock);
+	if (is_avq)
 		vp_dev->admin_vq.info.vq = vq;
-		mutex_unlock(&vp_dev->admin_vq.cmd_lock);
-	}
 
 	return vq;
 
@@ -620,12 +617,6 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 
-	if (vp_is_avq(&vp_dev->vdev, vq->index)) {
-		mutex_lock(&vp_dev->admin_vq.cmd_lock);
-		vp_dev->admin_vq.info.vq = NULL;
-		mutex_unlock(&vp_dev->admin_vq.cmd_lock);
-	}
-
 	if (vp_dev->msix_enabled)
 		vp_modern_queue_vector(mdev, vq->index,
 				       VIRTIO_MSI_NO_VECTOR);
-- 
2.45.2

