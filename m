Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF333939C
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123140; cv=none; b=k2VpfsZ+ROQG1svsGXB88LgdHVx72JK1vUKUFGZUx6fHdxJ4pSvtAueBlIVEb5zO5EoI4mOVdKufm0NFdrbkGdl2nXcXuBuoD7n+l6htVMbhGbrLgvYuR+4haIhkn0a/VO3iiu5x6XUNWcjrJAf1zr6Yaycm92H97TLH3W/Hd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123140; c=relaxed/simple;
	bh=N+A6ai/vFvUwNv/kA2P3kWyIElTpe7zizyMn2yDiULc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9Q57M5VN3UHMmfaP7RMVk4dX6eLvuEaml9Ijy4///RKlxAHtDLuFieHBbVA0e8JSaEXbQptAjPWfvnWSTs9NgXD+3XgvfFnbBcko+5wPHGbg0fK3umPKBQEmJdp4wWc2JB8Rv3Z1vqqoLLReYuzguY+DDjfljt9ZjwiazffOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJ6Dq6Id; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ6Dq6Id"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e4c00d71aso456575985a.3
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 20:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123136; x=1792727936; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a4/QUaf0CkV4SNeRpp+SHFXjQfr9ekLh8jCWnPK82ew=;
        b=pJ6Dq6IdoP75K972HhIYN4F3L3gb0hMGZMEWu4UkeokDHU+gtVFWh0+iAJfGzbvxZQ
         zEhZPMo/xGC1TTpjIenlXSuJyMC+47J0OvV3AAgPI0wZajjqMILbnrbOn+0zrgLThZbZ
         J9nvmKIRxeY6Gt2fIn2+D815LJVySi1qj/xQiPDuZTSm1x59VyFmOpqlsEeRGbEmsGCV
         uIxAkR/DeTSEYZrOMSavBlp3eMvZMWiftCcOjPdqofSxX1xJtY5nHFyv10Uv3XtQ2c/m
         DzbzmqGFjtz7boOqNA73Qedx8mPB0zwd4TqT/u/CG6NLkgyErAwtUxtc4DFn2U2YV7Mq
         Cdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123136; x=1792727936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a4/QUaf0CkV4SNeRpp+SHFXjQfr9ekLh8jCWnPK82ew=;
        b=MfKOd5R5wptQh7vy1alHE3u/N/ul42ujZf81jJ2nVxz5b7SjoUYUN5tJAnJR3FcaHs
         A/jUzcIXqsORLulACmx+BxLOm140RgJ/Hi0I9sHgn2nHl2EYEMjI6bYcaf/CPX2IjZYg
         lmAyXZS9PirxIng6EuicwzOHl7yhTdeS76l1pUiIBXmuO+0sQLFlR3RP5oc/hTcpxeD7
         otY6Gp62wKWnRKtwbzJW4k6rmehXFqo4IfPQbv9n+nnFinXaB6url4Pu3Jla6eV7wJSm
         28E+wmeXp2RBwVZyf3IHZqiK+U98nK21WcSKPflOvH4dgbkGWrGoxu6VW1hs9VI7Q8ry
         JLpg==
X-Forwarded-Encrypted: i=1; AKwUvByzGu3F+TRSwi//OQyCTt0IVkZniE+XEX/7LaTu7qE2uRb5+rglW83s8OZkDdoKhqtgbg8sD0MLX07z49/E6g==@lists.linux.dev
X-Gm-Message-State: AFq9FYL7QCxNtZSj2Gu9XljBQmFnDloVFp+YeZyUCQJxLWN3Bz1h3nNR
	trgJhVkKqjfWusPKjWMOA6Jv7TLKmQYe4XYpgHzhVA/Mxv2TFEfoOGBE
X-Gm-Gg: AYBFou1FoWQzI5+m6VJ5YKqxXQ8LU/hL88OHShAdQv+QOYDJsIgdWRPlv5ZXddeE3oO
	i7Hvmww9tRYrZ+Gex8IeiLepeiNG00B38mP2CUJiCi5CTre21tKKXauE/MbSuI7EgW5bsONGl4Y
	y3ryCiadm7vFFr/FJ7PUUxPspnmOXQIjdl/05jh/f7ufKIOFtRQmVz/JcrUJPtQocnr5BuQZtFe
	K2Z/WlQGFAQy+DHkiQS5SEKKOEGLvIZyvzSTeqJ+hmJk36fkzQeFG2qbvHVRZPkNyyvZIeJ0ONA
	xrFUAjl2RNpc6x3vfuroJEHe0T8vjOfjUnieos3Nf0UIV3Vac8r4Bkwne4SjToZ7F25PMZybK4a
	7ZspP8sGWkktHaa1T65qwyNk50fZ2WFHVPNs5mcKejdVESbLZM3gtylm/elJ+mH4NBUJkArq96i
	TGUK0b+vBDfyr/M5gzNbIT5KPUe+29cgEb9olG3Xz9Oosh7ApE2wJky9K8I2N3pvUFYkMPHEInz
	Nt9NFNzjEATQhSXqL3KMLYgj0GQP3uF
X-Received: by 2002:a05:620a:17a3:b0:93c:89a0:bf82 with SMTP id af79cd13be357-93ebd209171mr3554739485a.43.1792123136506;
        Thu, 15 Oct 2026 20:58:56 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1c1d29sm105968985a.43.2026.10.15.20.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:58:56 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Dragos Tatulea <dtatulea@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 RESEND] vdpa/mlx5: Don't free QP buffers if destroying the QP fails
Date: Thu, 15 Oct 2026 23:58:28 -0400
Message-ID: <20261016035851.771496-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qp_destroy() only warns when DESTROY_QP fails and then frees the RQ
buffer and doorbell record of the driver-owned QP anyway. The QP still
exists in firmware, so the device can keep reading WQEs and the doorbell
record from memory that has been returned to the allocator. This is
reachable from teardown_vq(), which destroys the QPs even when
destroy_virtqueue() fails and the virtqueue still uses them.

Return after the warning, as cq_destroy() does, and leak the buffers
instead. A device in internal error is not affected, since the mlx5 core
reports success for DESTROY_QP in that state.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
No code changes, only added Cc: stable. Resending as the original posting
got no comments:
https://lore.kernel.org/all/20260926215632.1343807-1-oss.patchbox@gmail.com/

This was found with a static analysis tool from ongoing, not yet
published research, and confirmed by code inspection. It has not been
reproduced on hardware.

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 8563fec2855d..a01cd890bb58 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -483,8 +483,11 @@ static void qp_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_qp *vqp)
 	MLX5_SET(destroy_qp_in, in, opcode, MLX5_CMD_OP_DESTROY_QP);
 	MLX5_SET(destroy_qp_in, in, qpn, vqp->mqp.qpn);
 	MLX5_SET(destroy_qp_in, in, uid, ndev->mvdev.res.uid);
-	if (mlx5_cmd_exec_in(ndev->mvdev.mdev, destroy_qp, in))
+	if (mlx5_cmd_exec_in(ndev->mvdev.mdev, destroy_qp, in)) {
+		/* The QP still owns its buffers */
 		mlx5_vdpa_warn(&ndev->mvdev, "destroy qp 0x%x\n", vqp->mqp.qpn);
+		return;
+	}
 	if (!vqp->fw) {
 		mlx5_db_free(ndev->mvdev.mdev, &vqp->db);
 		rq_buf_free(ndev, vqp);

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
-- 
2.43.0

