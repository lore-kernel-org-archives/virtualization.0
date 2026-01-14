Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80062ED860
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416541; cv=none; b=H8GD9L3VIjAJHpDZLwmI5OVQpM0HU2n2d4Ped9zPTkpZnCUGdkKhkyBJzxoRWkMdTonAXWlnPMUo89pWbFnqDjlq/zxT6pAaXCNTF8hEz2i8/ZFKv+Ts3q++7ucBKs69CLZdhbUh4fAUcCN9sA3R96Vb3wjaI4w6GvZj0h2ZVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416541; c=relaxed/simple;
	bh=dA8aM5+FTrs2SZyvHM/kGbqORmpjrkxKf/g72PEscSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toUwtcPZgRfWhohs1pmXLKuQ8MueyatcIbm4Cy7IqDDt6LhF20ogaV4/wwqnwwfHnwrhPzU64km6u7j5ViYEsqLroI/UVKs9KhWKKlDi948bBhedEnJSi1VQscOsNHV2b/NP5dS6HEzrKIbDwWrScyo7nws/5IKJpeZLYdYESj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETwmbWfd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETwmbWfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768416535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdiLQGvhjs6xdz37edyKpYey6rGP6zjGCqgHSVUedJM=;
	b=ETwmbWfdR5ofxDLktcQOE8UwMWM4iNGrZu1Xaimh1MUO3GmK0xPd73ppNcXRLidA6fa4s3
	pP9hAbgcROXGazS7US7uZdE2liS2sdobF//DFvX4gCR91bV17c5u4KRds3219vKnNVwfYO
	nNixD1wDQj3M/Je2jJOb+4YLwDzSXVk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-QXmdTbb2MRaHBqb33-GSOw-1; Wed,
 14 Jan 2026 13:48:51 -0500
X-MC-Unique: QXmdTbb2MRaHBqb33-GSOw-1
X-Mimecast-MFC-AGG-ID: QXmdTbb2MRaHBqb33-GSOw_1768416530
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D98E319560B2;
	Wed, 14 Jan 2026 18:48:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3841019560A7;
	Wed, 14 Jan 2026 18:48:45 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v12 01/13] vhost: move vdpa group bound check to vhost_vdpa
Date: Wed, 14 Jan 2026 19:48:27 +0100
Message-ID: <20260114184839.926884-2-eperezma@redhat.com>
In-Reply-To: <20260114184839.926884-1-eperezma@redhat.com>
References: <20260114184839.926884-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Remove duplication by consolidating these here.  This reduces the
posibility of a parent driver missing them.

While we're at it, fix a bug in vdpa_sim where a valid ASID can be
assigned to a group equal to ngroups, causing an out of bound write.

Cc: stable@vger.kernel.org
Fixes: bda324fd037a ("vdpasim: control virtqueue support")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v12: Add Fixes tag (MST).
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ---
 drivers/vdpa/vdpa_sim/vdpa_sim.c  | 6 ------
 drivers/vhost/vdpa.c              | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ddaa1366704b..44062e9d68f0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3640,9 +3640,6 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	int err = 0;
 
-	if (group >= MLX5_VDPA_NUMVQ_GROUPS)
-		return -EINVAL;
-
 	mvdev->mres.group2asid[group] = asid;
 
 	mutex_lock(&mvdev->mres.lock);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index c1c6431950e1..df9c7ddc5d78 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -606,12 +606,6 @@ static int vdpasim_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
 	struct vhost_iotlb *iommu;
 	int i;
 
-	if (group > vdpasim->dev_attr.ngroups)
-		return -EINVAL;
-
-	if (asid >= vdpasim->dev_attr.nas)
-		return -EINVAL;
-
 	iommu = &vdpasim->iommu[asid];
 
 	mutex_lock(&vdpasim->mutex);
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 05a481e4c385..9d25b735b43d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -680,7 +680,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	case VHOST_VDPA_SET_GROUP_ASID:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
-		if (s.num >= vdpa->nas)
+		if (idx >= vdpa->ngroups || s.num >= vdpa->nas)
 			return -EINVAL;
 		if (!ops->set_group_asid)
 			return -EOPNOTSUPP;
-- 
2.52.0

