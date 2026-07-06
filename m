Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1DA5637C0F3
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318176; cv=none; b=DC7KLLNdCkNS9yzQzfVBT3PbJcQaUHE6yGYSRSASz0bk9D6SNH+byCMg3edsEheBmeW+eG3hQ45zpRsEQAm9q5xiYs6e06dArmrbrpyaXtp/N8e+zi/bLF5v3f7Y1ryAPy7mlkgprtgV+kmvs3O934kcX4/FbPecNqvly/h97MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318176; c=relaxed/simple;
	bh=mZ8RdtoHoaP2zKecqF7SODEaHQyJcEThwFDo29lFUhE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s4V4OAboEjbj4t1WSSIvVDzU+JfvbzXZ/3/OvsLto4qs9mY5KOMRQ+8zrlb4if5qShWV0XX0hAhAfN/+zawz6Kg0iTf6SI2Q0TXnRWm/ubDBLuQoI7Ta8lDQ7/dK5dq9uwgU07ZBHR0MY22jc4zOaXUYfWPzytYZshOYJk5UaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=f36j00JH; arc=none smtp.client-ip=111.202.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="f36j00JH"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>, Kees Cook
	<kees@kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] vdpa/mlx5: fix wrong MLX5_ADDR_OF struct type in alloc_inout()
Date: Mon, 6 Jul 2026 14:09:02 +0800
Message-ID: <20260706060902.2341-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc13.internal.baidu.com (172.31.51.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1783318166;
	bh=dOY/T0UMhDtLTqbVSJGV9b3hkKpMYso8tQdta9n8M/I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=f36j00JH7+p6N1q2sOzcb+ea4/6z7y8yvlzqXaSBDvTWeh0Lq3CF2exF8XfpS+dFg
	 LfbvRKu5tzHafRIlL99IbyROUfzQQ+oz6Tt7jG6vH24DnmTpIvy2Nq/dUqSurebO1V
	 IaTiTD8+7r6jkGt9c5+m6A44co1ZWspcodb+WskkL6Jpl3IkW1keRUBvzeX9ZgaHiq
	 VKlWclmMjP+0L7Iynlpa74g0AtGnq5JEoZ3ucOFr12TPyIQdyt/I8z5tvO6xkvegOr
	 MTGmUifdO6gLpN/OWfAOBMArAM3R76DdEBczIBKo0e8EqokfTmq8NVcOlzkFCW/oZC
	 jgD01syghdVgw==

From: Li RongQing <lirongqing@baidu.com>

In alloc_inout(), the qpc field offset was computed using
MLX5_ADDR_OF(rst2init_qp_in, ...) in both the INIT2RTR_QP and
RTR2RTS_QP cases. This is a copy-paste error: each case should use
its own input structure type to get the correct qpc offset.

Fix the INIT2RTR_QP case to use MLX5_ADDR_OF(init2rtr_qp_in, ...)
and the RTR2RTS_QP case to use MLX5_ADDR_OF(rtr2rts_qp_in, ...).

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ad0d5fbb..eb431a1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1080,7 +1080,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
 		MLX5_SET(init2rtr_qp_in, *in, opcode, cmd);
 		MLX5_SET(init2rtr_qp_in, *in, uid, ndev->mvdev.res.uid);
 		MLX5_SET(init2rtr_qp_in, *in, qpn, qpn);
-		qpc = MLX5_ADDR_OF(rst2init_qp_in, *in, qpc);
+		qpc = MLX5_ADDR_OF(init2rtr_qp_in, *in, qpc);
 		MLX5_SET(qpc, qpc, mtu, MLX5_QPC_MTU_256_BYTES);
 		MLX5_SET(qpc, qpc, log_msg_max, 30);
 		MLX5_SET(qpc, qpc, remote_qpn, rqpn);
@@ -1098,7 +1098,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
 		MLX5_SET(rtr2rts_qp_in, *in, opcode, cmd);
 		MLX5_SET(rtr2rts_qp_in, *in, uid, ndev->mvdev.res.uid);
 		MLX5_SET(rtr2rts_qp_in, *in, qpn, qpn);
-		qpc = MLX5_ADDR_OF(rst2init_qp_in, *in, qpc);
+		qpc = MLX5_ADDR_OF(rtr2rts_qp_in, *in, qpc);
 		pp = MLX5_ADDR_OF(qpc, qpc, primary_address_path);
 		MLX5_SET(ads, pp, ack_timeout, 14);
 		MLX5_SET(qpc, qpc, retry_count, 7);
-- 
2.9.4

