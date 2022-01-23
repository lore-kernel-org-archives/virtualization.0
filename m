Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3266C433FE
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 00:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 526A56076A;
	Sun, 23 Jan 2022 00:12:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pEyAqFx-MI6u; Sun, 23 Jan 2022 00:12:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6C4B60783;
	Sun, 23 Jan 2022 00:12:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8378BC0031;
	Sun, 23 Jan 2022 00:12:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF593C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8DFC60AE5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3k5NcoKmuHkL
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 058E660A78
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:05 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C6C2060F77;
 Sun, 23 Jan 2022 00:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ED4C004E1;
 Sun, 23 Jan 2022 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642896724;
 bh=FZdORr6n1v/yWRKN8gy/VklB3+rU/+xBNX36oDx/RLM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JEZB0iXg7942aPGfHf/UtfJupOZwHKJERHV6OwGOgXmFJMR9nf1+HPHhfpTHZMIue
 4Z19V+KIzMsRS95ksG4jI0vp7kJZMzzOq2zD/rcpdSQElI++Zi51BfBfpbwuuWpCXa
 pck7TeTTWEUTjt3BJim7eVMSfjhnF0TBwp/AKRhyHgnbS8NxznxUnfEQHG7sp5GDe1
 IayYe0gbpB8nXtfeC4GYQrtuaGUPYqmmZ2HSfWWk/76VOULjGsVZ4H1IEIfHVWiqEh
 FuEmX+7UnMe4IEb7rVtfI/8w8349doUBuWdJAxkjyRGi48EiFHRJdKCKHLYRLLhDxY
 Am9aZMKElD4Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 13/19] net/mlx5_vdpa: Offer VIRTIO_NET_F_MTU when
 setting MTU
Date: Sat, 22 Jan 2022 19:11:06 -0500
Message-Id: <20220123001113.2460140-13-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123001113.2460140-1-sashal@kernel.org>
References: <20220123001113.2460140-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>
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

From: Eli Cohen <elic@nvidia.com>

[ Upstream commit 60af39c1f4cc92cc2785ef745c0c97558134d539 ]

Make sure to offer VIRTIO_NET_F_MTU since we configure the MTU based on
what was queried from the device.

This allows the virtio driver to allocate large enough buffers based on
the reported MTU.

Signed-off-by: Eli Cohen <elic@nvidia.com>
Link: https://lore.kernel.org/r/20211124170949.51725-1-elic@nvidia.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 63813fbb5f62a..d8e69340a25ae 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1895,6 +1895,7 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
 	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
 	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
 	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
+	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MTU);
 
 	print_features(mvdev, ndev->mvdev.mlx_features, false);
 	return ndev->mvdev.mlx_features;
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
