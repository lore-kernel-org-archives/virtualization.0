Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B079C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 10:26:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3456610E5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 10:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3456610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8160816F5;
	Tue, 12 Oct 2021 10:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wbZdfQSWu1yC; Tue, 12 Oct 2021 10:26:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6012A81518;
	Tue, 12 Oct 2021 10:26:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B9ECC000F;
	Tue, 12 Oct 2021 10:26:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C56EC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1B8A400F6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOACQriGzxjw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:26:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B67E2401D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:26:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7D7461076;
 Tue, 12 Oct 2021 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634034404;
 bh=+Ov/odFSDKtJg/b3iJ6il+1spSIorisjqxVJM4WYeNM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DSHS+8VTjfqDauIEVUe4kY4RmpSCO6SJOSTVXU2J8YfC5aX4q5sL702XD/lVgiifH
 5avZOId+HBxZ0EUcIsZqzln1on9zv258JSHEqcBatTUJrfMMleL1h3R3Sh+DlTQEjm
 nagmkWnE1We4FN22+BakY5Eys/j409YINW0bAMmHmjnFpoyRVk3BYGg7P+tsaRPIOm
 H98o/dkcvVGtFoi4U86y08Lk/c/Kty1ZCXSV445H2/DRq4kle5qjW9UsQ+cKySG43G
 p1JYOxW2XsEcArUbb6dBRhH/QgLJWWrjjpj8K/7R8NXSMQEK2u9HJy1Tk9fC1ybwas
 SwjRsqVgRje7A==
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH mlx5-next 1/7] RDMA/mlx5: Don't set esc_size in user mr
Date: Tue, 12 Oct 2021 13:26:29 +0300
Message-Id: <f60a002566ae19014659afe94d7fcb7a10cfb353.1634033956.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634033956.git.leonro@nvidia.com>
References: <cover.1634033956.git.leonro@nvidia.com>
MIME-Version: 1.0
Cc: Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Saeed Mahameed <saeedm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Aharon Landau <aharonl@nvidia.com>

reg_create() is used for user MRs only and should not set desc_size at
all. Attempt to set it causes to the following trace:

BUG: unable to handle page fault for address: 0000000800000000
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 5 PID: 890 Comm: ib_write_bw Not tainted 5.15.0-rc4+ #47
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:mlx5_ib_dereg_mr+0x14/0x3b0 [mlx5_ib]
Code: 48 63 cd 4c 89 f7 48 89 0c 24 e8 37 30 03 e1 48 8b 0c 24 eb a0 90 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 30 <48> 8b 2f 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 8b 87 c8
RSP: 0018:ffff88811afa3a60 EFLAGS: 00010286
RAX: 000000000000001c RBX: 0000000800000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000800000000
RBP: 0000000800000000 R08: 0000000000000000 R09: c0000000fffff7ff
R10: ffff88811afa38f8 R11: ffff88811afa38f0 R12: ffffffffa02c7ac0
R13: 0000000000000000 R14: ffff88811afa3cd8 R15: ffff88810772fa00
FS:  00007f47b9080740(0000) GS:ffff88852cd40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000800000000 CR3: 000000010761e003 CR4: 0000000000370ea0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 mlx5_ib_free_odp_mr+0x95/0xc0 [mlx5_ib]
 mlx5_ib_dereg_mr+0x128/0x3b0 [mlx5_ib]
 ib_dereg_mr_user+0x45/0xb0 [ib_core]
 ? xas_load+0x8/0x80
 destroy_hw_idr_uobject+0x1a/0x50 [ib_uverbs]
 uverbs_destroy_uobject+0x2f/0x150 [ib_uverbs]
 uobj_destroy+0x3c/0x70 [ib_uverbs]
 ib_uverbs_cmd_verbs+0x467/0xb00 [ib_uverbs]
 ? uverbs_finalize_object+0x60/0x60 [ib_uverbs]
 ? ttwu_queue_wakelist+0xa9/0xe0
 ? pty_write+0x85/0x90
 ? file_tty_write.isra.33+0x214/0x330
 ? process_echoes+0x60/0x60
 ib_uverbs_ioctl+0xa7/0x110 [ib_uverbs]
 __x64_sys_ioctl+0x10d/0x8e0
 ? vfs_write+0x17f/0x260
 do_syscall_64+0x3c/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: a639e66703ee ("RDMA/mlx5: Zero out ODP related items in the mlx5_ib_mr")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 9091de381e83..0ffe7f5b77b6 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1335,7 +1335,6 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 		goto err_2;
 	}
 	mr->mmkey.type = MLX5_MKEY_MR;
-	mr->desc_size = sizeof(struct mlx5_mtt);
 	mr->umem = umem;
 	set_mr_fields(dev, mr, umem->length, access_flags);
 	kvfree(in);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
