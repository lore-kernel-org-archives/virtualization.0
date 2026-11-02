Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652461;
	b=cyX7auEskQ9wAXT+hmdXQewD4lIpe76r5HFG470Ej9QI4ya1FL8sCuTVdlPNJgEJ0NOa
	 jiIbje/tcYXirZQu3zDwv7qG9zLtE5RS41hAO87utDNy2aHj4Y+pkunpmthoNYHlWNlsA
	 SQ4eyCV25oFrvT2ahDcfL5Mhc2AXTZ20cidVnHuY8NbaVkemJj3GCLzzvASv2qaV1LlSQ
	 VqbHCEreBgyxWhKo2LbZm5ALb42iDRaoLs3itzYVkdFyXVzY6S7eiEF6zXxWkNW1YbkJz
	 Aa9fyGeWdjhTaYu6LxFz1eUEPBNczxT0RZX8W2nT0z0IDd9dFIFeUV1qqs7p8KkuCRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m8mSi3IAorPrWHZPk3j86qqURTkDETtees0X+vPzQzc=;
	b=Shx3zR+jXJ657UEr8VnDL8zsjFbQ5fi4vmRjCeuJmK5GpKow8ETHkkNl6YvDBfGj17uY
	 GNOS2VXbbRfBiHg1F/XaO3tQ05tEHorkC2rWzKAbLwxBR+MqslyI4eWk6fAgdpn12THys
	 jcWTXK0iZ8u10IInXAb5L0GjdPvIci+NA/RlMr6ixHkS3Am0RhPWutSIShbla5lD23A6s
	 29FcLR4NDP4kkYCK2Ls1U7ORcLnx524VuKIEXxCd7p5j8sbuSCBueIp1FOqBct5aVoekz
	 0nXKpQw+KMIrXZ9Y4abmE5Bg+nmS8I5YihRMu7hrHVYd7hez0Ub7YCSisO0Ol/cSH6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gytqAZVj;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB7606A326
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 20:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FEB7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gytqAZVj
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5363316fa0cso42921301cf.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 12:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793652459; x=1794257259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m8mSi3IAorPrWHZPk3j86qqURTkDETtees0X+vPzQzc=;
        b=gytqAZVj8SvOdnUEEJJa/wCrNMbzYLZKQq6lg+ZnIIfzYB4vEBZwEcu6YvpNAYmyXX
         x0llffUCN5/KLFd+9UTB41V4MQ8K4RLXLm6FTw3M0944trA4qECoqmRvGJBpfkE1bPpg
         uF11INaCWYUjzohG+oYMxmJK6DQh9TRrCONcOFM/n/w2F+aZeLiqr7PQFMu5w+xEoDqW
         7snh+tg8XcTpGvE6m9+HIl0AfeEBRkDBPCAtxRMOHQATlDHzSxGtHX2ZL9KuxcHJubVw
         BJwfd0sV4cDztnZQePlhlOT1KnwQGgannCSn+FLYgg4vbGQCjXVoTIzy5NP95w/LWd+N
         I2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652459; x=1794257259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m8mSi3IAorPrWHZPk3j86qqURTkDETtees0X+vPzQzc=;
        b=Rp3ciMUlE81xlK514oKhtHpHxjuC89oNWxyRWa5+7/eGcf3FWnk3uoDqNFj5hDTZWU
         5Cr40p7wZ7Cay2JI9lVBuGYNvxRtliwovM4yEPyfw8kaUBjv3GLBRJ1hQdtuECi62oAD
         BYRWompDQTiTQPB7xDl/Byfy6CinYfPs4e4BbFiYy12SN2sj/MoZ7ngz6slLSWhC9meK
         30KqRxwoweVnhmHJtE/nYaYg35VcA5PJ+YrYUVsJ9B7kFTBdSKbh8F3qLomcwaJka1MR
         twQZrkZqpAYbT6ZAT+xG25RfMzMNJcpputT00BTJmY1e4qfRNGu/7UAXli27UvXEjFCA
         QJKA==
X-Forwarded-Encrypted: i=1; AKwUvBzHYgbLVkAN00vSrSnh92TmCd/8abESlrUbzJgz3bskNy2SC+Gn3QAL6MdJ+AXnTJtE08uOeWzXF0qMhMWblA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Eh1wIdJetVIqRoQkQOn5kpMvcjAKFJz34YR/jKKe6kBUxi0RX
	4b4fqPrfRm741RTeKI32rGxP+7rqfNLjqHBIfuROWPT27P7UZM5IaHla
X-Gm-Gg: AYBFou0Ukaw1RmbXj9ehRrpnEE8R8CXWIKmq+WXuIdaT3+A+HlY4VO0rHrJ+8VV9tpt
	MmVoq3j4WeafMkSA7ldiE9luOn3buXhD+b2iqg4G5KeaSEPDaXmsbcraFFePkcPokyhcZcFJahc
	zzJYt0/6zyc8sxTKswjkgJNSYHyaLEI6zaP/OjUMpe1XNXQaJbeTCUz7zPKeQzbKRBZ/+ZXNQzD
	SfaSLSxftDC364i148JknTpMXqyTQiSXlPRFHHhWyEPdoNW52GBIV/Ljyr7DsrsiKNM7Cay6Ral
	gAwHHF6Yi2+OhomQ62VUmbVU8sBi0Y+SJA/YAEZmM0D2DzzkB8pm3fVTibdMUPfqIUmwik+keg8
	1AXyl8MIK7M9JKiJIYVma6r4YqwLlac/ytveu/LA7uE5xh5uVM8Q3ERBFTBMfi1W9TSYNTKfA+k
	sdQCViw/Ako1rO3VeMIIznrpXUxBbOR1HFBCDk7A1uyE+XJ9TYjEjqxqHdeR6f6emq8TIuQZWiA
	ErqhrZ+jw1ekF2giAviBryqrdcqOCo1SvmYrPm8JTTbDRbmRTXlo2BeUaE1/1ZDab/Yz6u4nTrY
	8Pa+4KmMDioOxDu5KXYkx9fDMiF/JqPFM8b2CWzACRM9rJu7IV3c
X-Received: by 2002:a05:622a:1826:b0:535:a5fb:645f with SMTP id d75a77b69052e-542b86e1d84mr191735211cf.74.1793652459409;
        Mon, 02 Nov 2026 12:47:39 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23b0bsm99669676d6.2.2026.11.02.12.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:47:38 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Dragos Tatulea <dtatulea@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2] vdpa/mlx5: Don't free QP buffers if destroying the QP fails
Date: Mon,  2 Nov 2026 15:47:30 -0500
Message-ID: <20261102204734.443140-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qp_destroy() frees the RQ buffer and doorbell record of a driver-owned
QP even when DESTROY_QP fails. The QP then still exists in firmware and
can read WQEs and the doorbell record from freed memory.

Return without freeing them in that case, as cq_destroy() does, and
include the QP type and the error in the warning.

Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
v2:
- Shorten the commit message (Dragos).
- Drop the Fixes and Cc: stable tags (Dragos).
- Print the QP type and the error in the warning (Dragos).
- Rebased on v7.4-rc1.

Compile-tested with W=1.

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 8563fec2855d..20f4ff67c975 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -479,12 +479,18 @@ static int qp_create(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
 static void qp_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_qp *vqp)
 {
 	u32 in[MLX5_ST_SZ_DW(destroy_qp_in)] = {};
+	int err;
 
 	MLX5_SET(destroy_qp_in, in, opcode, MLX5_CMD_OP_DESTROY_QP);
 	MLX5_SET(destroy_qp_in, in, qpn, vqp->mqp.qpn);
 	MLX5_SET(destroy_qp_in, in, uid, ndev->mvdev.res.uid);
-	if (mlx5_cmd_exec_in(ndev->mvdev.mdev, destroy_qp, in))
-		mlx5_vdpa_warn(&ndev->mvdev, "destroy qp 0x%x\n", vqp->mqp.qpn);
+	err = mlx5_cmd_exec_in(ndev->mvdev.mdev, destroy_qp, in);
+	if (err) {
+		/* The QP still owns its buffers */
+		mlx5_vdpa_warn(&ndev->mvdev, "destroy %s qp 0x%x failed: %d\n",
+			       vqp->fw ? "fw" : "sw", vqp->mqp.qpn, err);
+		return;
+	}
 	if (!vqp->fw) {
 		mlx5_db_free(ndev->mvdev.mdev, &vqp->db);
 		rq_buf_free(ndev, vqp);
-- 
2.43.0

