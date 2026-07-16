Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35B30EF63
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180645; cv=none; b=OnmKia29sq6ZLk2rGgYuQeHNeanMfHRhRIgscGp0bWOnDkl3UG7e0epOB1F9nda4Y6WdzpfIeICYuHSiPU+eBT01LSIqhkL96oURDSG4Ce71wiKcmY1EVfpZj9V14LoHTwT1S1hKq/n95x7DQMhtRtO54dZnG3a8cTEV+2+d4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180645; c=relaxed/simple;
	bh=+bletwqMDAdZLC+Ar0edB33LiWU+DUCf3VcwYQ4QTYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFi7gxkumJ8lsU8gPihV2a1KbIf10pnM8UstLvGSg/Z7isG4J4PfyDlJVpOlkDihAOwRWzgsLxG6zVuRwJi7+EfR6k2BxvpTKKIufNrWX5N4DNoYdlMs7QpDIqLkZPq7a2LvJCU8bM7dOkChUakjUoPkdGO7ZbV/D7rPgzSL5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pnHbOb/R; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pnHbOb/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Z3
	hMyhEOthr7u9xLZ5tBJvdNPON+BcMDv5z9O+hhYGE=; b=pnHbOb/Rq4rODfUPnr
	BRziqvU35DbTTDSZsbpIqVW6xbFxrQEPqFKSFI91n94ngR8tpzMucUh+VvDypcKs
	svqmUYxShRIJjkDKPM7fLdRZbY/gVyt3qnMbWxY1A32AUtLpFXXT3iX+el5RXr7b
	UumVVrUZgHWe0C1XWtEBjw7TM=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3J0eUb1hqXVp8Jg--.6352S2;
	Thu, 16 Jul 2026 13:43:49 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Weimin Xiong <xiongwm2026@163.com>
Subject: [PATCH v2] vdpa/mlx5: roll back MR update after VQ setup failure
Date: Thu, 16 Jul 2026 13:43:53 +0800
Message-ID: <20260716054353.155805-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3J0eUb1hqXVp8Jg--.6352S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWUJr18CFW3urW8Cr1kuFg_yoW5Xw1Upa
	y3Ka1qkFWkJFW5Jw4Dur4Fv3Wfurs3KrWFka45KwnIywn8Kr98XFn5KFWY9F95G34rCa9r
	Kw45Jw18XFWDJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR-db8UUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzRWxQWpYb5UunQAA3T

mlx5_vdpa_change_map() must install the new MR before rebuilding or
resuming virtqueues, because both paths read the MR keys from
mvdev->mres.mr[].

If rebuilding the virtqueue resources fails, the new MR must not remain
installed after its reference is released. Keep an extra reference to
the old MR before replacing it. On setup failure, restore the old MR;
the saved reference then becomes the map reference, while replacing the
new MR drops its map reference.

Make mlx5_vdpa_change_map() consume new_mr on all error paths so that
set_map_data() does not release an MR already released during rollback.

v2:
- Keep the new MR installed while virtqueues are rebuilt.
- Restore the old MR only after setup_vq_resources() fails.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
---
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ad0d5fbbb..25bf1c5cd 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3055,18 +3055,24 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 				unsigned int asid)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_vdpa_mr *old_mr;
 	bool teardown = !is_resumable(ndev);
 	int err;
 
 	suspend_vqs(ndev, 0, ndev->cur_num_vqs);
 	if (teardown) {
 		err = save_channels_info(ndev);
-		if (err)
+		if (err) {
+			mlx5_vdpa_put_mr(mvdev, new_mr);
 			return err;
+		}
 
 		teardown_vq_resources(ndev);
 	}
 
+	/* Keep the old MR alive in case rebuilding the VQs fails. */
+	old_mr = mvdev->mres.mr[asid];
+	mlx5_vdpa_get_mr(mvdev, old_mr);
 	mlx5_vdpa_update_mr(mvdev, new_mr, asid);
 
 	for (int i = 0; i < mvdev->max_vqs; i++)
@@ -3074,17 +3080,22 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 						MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY;
 
 	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspended)
-		return 0;
+		goto out;
 
 	if (teardown) {
 		restore_channels_info(ndev);
 		err = setup_vq_resources(ndev, true);
-		if (err)
+		if (err) {
+			/* The saved reference becomes the restored map reference. */
+			mlx5_vdpa_update_mr(mvdev, old_mr, asid);
 			return err;
+		}
 	}
 
 	resume_vqs(ndev, 0, ndev->cur_num_vqs);
 
+out:
+	mlx5_vdpa_put_mr(mvdev, old_mr);
 	return 0;
 }
 
@@ -3368,15 +3379,11 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 		err = mlx5_vdpa_change_map(mvdev, new_mr, asid);
 		if (err) {
 			mlx5_vdpa_err(mvdev, "change map failed(%d)\n", err);
-			goto out_err;
+			return err;
 		}
 	}
 
 	return mlx5_vdpa_update_cvq_iotlb(mvdev, iotlb, asid);
-
-out_err:
-	mlx5_vdpa_put_mr(mvdev, new_mr);
-	return err;
 }
 
 static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,

