Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11583176EE
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170965; cv=none; b=COSSu8KFJobcG6wdxX2BBlWsjTrTr2T0dxMnV6niCxv+Dc/kdf/3FbHNhg7MKAuPG05Q1WKT2hAQIb7QWFWlCfzR+f9Frdv9qVEtNekTES/1z5UK2O2Kty7a2v3XXBZSs+QHy2vt+1+wKoIoGtkMzXqfJtge4/yRW87fHL2dU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170965; c=relaxed/simple;
	bh=8cHM0BZyWFnwWbxwNz3AyzT6I9Q2rXFPmSViRVuevvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dH1c9tCqHQNAYGM0GF4a4qNGvLVj7obYarzFaHpBZZWFJ/I+zA+bemCpgFBs+Pvzr06s1i9IasvGoVCWskovrPoJZQykZMYv8DoKWrqQstnYXaSMbTJcE2NWUbGsJWUHKIyEh92saK1vmLzDaCgDuqamRo/qTBJPxUwZLPtTjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MSRrphyS; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MSRrphyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vr
	q+uW6BkBZKWYz5ksyQ44ROYJQVsXZ5qBm8e5hwgIY=; b=MSRrphySzty3i3rp4F
	wUY5ULOkRw1w0XQ0YwuLMOftt+Dgi+/9QWFzGb3YkHeTxssgUzKV2AjMCNjW7taA
	Rtjk5M6BeomzQ5GvAUqTYx6gUtWQwE/lFMZLQYLe/0Xlma0GRkJ1/bZn0kb1CJ8C
	XIXHTNFyc9+q+0Ec3+YGCSwwQ=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHLtnMSVhqdqI8KA--.51016S2;
	Thu, 16 Jul 2026 11:02:37 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	dtatulea@nvidia.com,
	kvm@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa/mlx5: fix MR state corruption on setup_vq_resources failure
Date: Thu, 16 Jul 2026 11:02:41 +0800
Message-ID: <20260716030241.124412-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHLtnMSVhqdqI8KA--.51016S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw15uw4xuw45Zw47urWfKrg_yoW8Ww4UpF
	WfKFnIkrWDXFy3XFsIgF4rXF15uayrtrW8K3y2grnIywn8tryDJrs5KFyrZryUCrWrCFsx
	Kr48Ja18GFykWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jNmRUUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzQ02xWpYSc1SQgAA3V

From: xiongweimin <xiongweimin@kylinos.cn>

In mlx5_vdpa_change_map(), mlx5_vdpa_update_mr() is called before
setup_vq_resources(), which releases the old MR and updates
mres.mr[asid] to point to new_mr. If setup_vq_resources() then
fails, the function returns an error but the MR pointer is already
updated, leaving mres.mr[asid] pointing to a potentially invalid
state.

Fix by calling setup_vq_resources() before updating the MR pointer.
On failure, the old MR is still intact and can be restored by the
caller.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 24 ++++++++++++++++----------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ad0d5fbbb..8a6ddc00b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3067,24 +3067,28 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 		teardown_vq_resources(ndev);
 	}
 
-	mlx5_vdpa_update_mr(mvdev, new_mr, asid);
-
 	for (int i = 0; i < mvdev->max_vqs; i++)
 		ndev->vqs[i].modified_fields |= MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY |
 						MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY;
 
 	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspended)
-		return 0;
+		goto done;
 
 	if (teardown) {
 		restore_channels_info(ndev);
 		err = setup_vq_resources(ndev, true);
 		if (err)
-			return err;
+			goto out_err;
 	}
 
 	resume_vqs(ndev, 0, ndev->cur_num_vqs);
+	goto done;
 
+out_err:
+	return err;
+
+done:
+	mlx5_vdpa_update_mr(mvdev, new_mr, asid);
 	return 0;
 }
 
--
2.39.3

