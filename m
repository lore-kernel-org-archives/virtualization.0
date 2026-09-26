Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA43A718D
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790459804; cv=none; b=P+JRHfhgXgPGK2Qp7rQWsOQe2JxYHOPQyRRL8Y9YshQGX2qnhh0byHUYTCwbsdVLN/dYPWtG6LqJv1EpoHFEMskRfGRk0ytYG7EWW55Lg/3LGrq2v6D3Z2BDHMkOB+YMsZGRWYuCy18j51A3oUcniYlBWyhYYA7TG8VOcogznuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790459804; c=relaxed/simple;
	bh=Cjb0hFk+lYAxfdjkO8gmpN8O/Agd+iJy0foNMq2/kIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2DFvsEf5wJuiDKwy42QkxgdKShQ76/zaCfvLLNsiFEmctEzLF3lCTof6ZYEPdXPkRwzH+7SLyPWJwxh0WJv/8AE2KRF8lbzYnbk+RJzTufRP9QQiQOfFaij8VQeYgU2XCIT0QIsyNiYEFUhLcZzEMM4W6YApNBFk/g9e3kO3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ9+PN//; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ9+PN//"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53122c5bbb4so24763051cf.2
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790459799; x=1791064599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=prCdYd82dRpV5/XCGhA/DCM01QvpeUvoZ3P5eCQY9/c=;
        b=gQ9+PN//n2cBx0/ctKdbFenOhQjAx3aOpaDKIbTWyQImVZ3q7akLSp1zaNzZjkV1SF
         tKGrpue5i8s6Nj4jMKUAaA2v5EeDsXkF/YVjuRbKu4UH/I8tAg3dPLVeOk1LLc1py9Tn
         JvaGbFkuYk5B8F4wifmzvKa/ZSpMkdAm98evEnFbKt5aaSN/SsGgUYXJBFPe3A1s/wvq
         537AfIC/OFL/QW71C3B0C8Dkn7IfLdmeoRudqH9xw1zz2NqqeTH6xMYEhPr04pnX3aAx
         xrCx3FROJLvk0UjrgsCD8r0PUmsdQnnC9XqZSMipkbEfW68vT/nTLgnAWLjkpW2oOFQd
         wJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790459799; x=1791064599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=prCdYd82dRpV5/XCGhA/DCM01QvpeUvoZ3P5eCQY9/c=;
        b=TYQfIm9QFJCJJevCddYDeT58goLlxPqpLGOsTXkXI1muHPnPI8bU41eIgkpJWVWcBo
         cjG73/Xsvt/ADcYyD7QO6I/2O2ch5SyTEMeDcl9pwsOd/CPbstCA1lWfUEnVmBv+h9JT
         H1u/c3dmyZJ5rJRGCWWAQ1c9X03HnmcbTuXKSNjiFLZ06tIkgskFLKuLL68lwI6vl9Bs
         QZdpEppdsTZXrvo3IRdY1kYdyDOIqNIxTBZlPvtbmTs1HPNhCyh/F6wpsnquW4RYqkee
         s5rUN3PSewINqCuT3rQ2IRY2SWZGDE47C2Fd+TMmtmYwNPvG9h+a7YhNtsAxYc1velgI
         pNNw==
X-Forwarded-Encrypted: i=1; AKwUvBzDrNKsbPRu2sFj6CYzJwVVnJf6bUy+d/jyAMsc6DfqWOJxoEQ/i/rttS/zgEaAKIZlHPax2yVAl4EIXnPz/A==@lists.linux.dev
X-Gm-Message-State: AFuF++lu8C2QQOLktAL2mQaTkvKMkaE2z9K2D1pwnzioo0Y3fJkKDjDC
	qixg6ncYCIL6GxdAEV4M4BPwcT55qNkrEOzWjc4XIBQuVtEh5P3b2g+D
X-Gm-Gg: AYBFou0L8d19fbDIkM1JDcLZNPHuIl6Iv2Rp2jB1ds1+l8vwrbzfcqtQu/YyO8BpATp
	B2t2GMYMHp7sv7CUjDbwSTOKhfM6ozU2xKBMho54DsQKXmbtzxpXoZYA8TAEVNNm6GJNeyBvqk7
	Ov7FmBIu5uxwXx/3QK2IOfeEBc7jTRWcRZMu8Bzl110ZinUvtHAhkQg0SvGcXyDyybR9iI/ZZMJ
	Vl39DaP0BLfYHuSFbejB9hcyzZHa8rxjaSuxaoguM7JgoOlZMNRcJeqv6+KGxv+bzUcNpRGJUJt
	/ayJHxjXyLF06rLPNbMbo7J1KAiy5yt7xY0LhyDBJhku549u4ergjmE8uqIFFX0bXsQYyiCDvyZ
	mJw93N/43SOYdooQHnQLwC4TBg5QUysPxfNb2cyB2BSsZLAnK1Ew4Af9nMvT3GzR1XpX2uz8Ucr
	bigevAEBx7IDCXjpENc8ci6ka6HtM+LmZuBZlLM9F44ZYexEhzipY4HXF2iUuqcfZCOg6i6f43N
	0wE5ZvM8dWucbiar4/jqLI=
X-Received: by 2002:a05:622a:6115:b0:533:33a6:8739 with SMTP id d75a77b69052e-53333a688a8mr24895121cf.7.1790459799409;
        Sat, 26 Sep 2026 14:56:39 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5332201fa44sm26850071cf.4.2026.09.26.14.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:56:38 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Dragos Tatulea <dtatulea@nvidia.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] vdpa/mlx5: Don't free QP buffers if destroying the QP fails
Date: Sat, 26 Sep 2026 17:55:17 -0400
Message-ID: <20260926215632.1343807-1-oss.patchbox@gmail.com>
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
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
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

