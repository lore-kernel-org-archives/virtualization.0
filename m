Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CA318EEE
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170849; cv=none; b=UUA5KhxISDCCwCldNiroj8YNKWuAUdyzopv2CbUc8MfUSaDYk8JZp1y1ujpC7+qfTMbeyj+2XWkhGKwsNgmg5yNg+WN7UfCJg31Wnz1T9ig3P9JbIgAPOAA5EhpFyRGsDCTz8LTO9BjnmNOFz+66M1Qihj4Vw17pjyklwkD8FiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170849; c=relaxed/simple;
	bh=8cHM0BZyWFnwWbxwNz3AyzT6I9Q2rXFPmSViRVuevvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rx4F0PtoHPz4Qg5+fO/pmTNtaacEcRdNVmy2Asz1DETEmbt3tx1uf9p0PqdVTBTiZLBMtM60Uk+dYA801TLaGQpRe14jCWBwTTqasIojJY+04A1yUPJpSAKJVHQfwEE3jXHrw01wYRFqHuUJRHEuSOQ9RTH1gT/kIQDHJMBd5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SrZzHpSk; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SrZzHpSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vr
	q+uW6BkBZKWYz5ksyQ44ROYJQVsXZ5qBm8e5hwgIY=; b=SrZzHpSkSVMM0G8qMm
	EAnVRhMSJhDxq+yod/nCFrtPpWb75YvekK49GbjJBIElFkhBSqr/2/WFlpWZ7lRG
	4RmiSzQLQStxeOOLnCcUPVJoL8UARd751MuL0e5vzbZrcyd0IQ6Y+GPlbbk1sWc/
	sHS+EDmmXP+ZGsOGpmDPstku0=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAXtftXSVhqGiJ8Gw--.48374S2;
	Thu, 16 Jul 2026 11:00:40 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	dtatulea@nvidia.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa/mlx5: fix MR state corruption on setup_vq_resources failure
Date: Thu, 16 Jul 2026 11:00:44 +0800
Message-ID: <20260716030044.123831-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAXtftXSVhqGiJ8Gw--.48374S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw15uw4xuw45Zw47urWfKrg_yoW8Ww4UpF
	WfKFnIkrWDXFy3XFsIgF4rXF15uayrtrW8K3y2grnIywn8tryDJrs5KFyrZryUCrWrCFsx
	Kr48Ja18GFykWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jZ8nrUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzhgZqGpYSVhQjQAA3Z

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

