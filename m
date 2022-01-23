Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EC6C433FE
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 00:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 867E860A78;
	Sun, 23 Jan 2022 00:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yy9gr_TNDybw; Sun, 23 Jan 2022 00:12:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30F7B605E9;
	Sun, 23 Jan 2022 00:12:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 087BFC0031;
	Sun, 23 Jan 2022 00:12:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 044B2C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7524408FE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0wfgPoHeHfdj
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13EA5414CD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 776BBB80924;
 Sun, 23 Jan 2022 00:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300C9C340E4;
 Sun, 23 Jan 2022 00:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642896732;
 bh=Ew//I/En9Gd8ruRvLDwh96Ay8uzpIAJMy1X0RMRL7uw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TODSJHGea3ns31tXDMpGlBP6UsIMydwrZ2T2xIbpgqbxeJa1qrKmZgPUeXAvITBYE
 2fGu3YW4AvdPHIj6DFQv7aO55uYCqAxrod+WATTxy7+2EyJQjgIHOO62anCxpdobzM
 e75tPoJ+2cPtcdkko9hflkLyiC/hju1GkvVHOK4o3H2ll9tHJKPhFlZP09JK6t2PX2
 wfUDaqXK6QYhAfoRlk366WudK8bWtpi+MEK8y1mofQ/lmuq4eRK9dO2G8F1Sg1SDi8
 P+6W+KhkVw9PZXUWMTokkWaUoTUvbTo+HXjfCqQGOkn1HovuzvM8WD+zLH7ednP8Tg
 0doSGLUj/Iklg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 17/19] vdpa/mlx5: Fix is_index_valid() to refer
 to features
Date: Sat, 22 Jan 2022 19:11:10 -0500
Message-Id: <20220123001113.2460140-17-sashal@kernel.org>
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

[ Upstream commit f8ae3a489b21b05c39a0a1a7734f2a0188852177 ]

Make sure the decision whether an index received through a callback is
valid or not consults the negotiated features.

The motivation for this was due to a case encountered where I shut down
the VM. After the reset operation was called features were already
clear, I got get_vq_state() call which caused out array bounds
access since is_index_valid() reported the index value.

So this is more of not hit a bug since the call shouldn't have been made
first place.

Signed-off-by: Eli Cohen <elic@nvidia.com>
Link: https://lore.kernel.org/r/20220111183400.38418-4-elic@nvidia.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index d8e69340a25ae..68ace0ad659f2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -138,10 +138,14 @@ struct mlx5_vdpa_virtqueue {
 
 static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 {
-	if (unlikely(idx > mvdev->max_idx))
-		return false;
+	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ))) {
+		if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
+			return idx < 2;
+		else
+			return idx < 3;
+	}
 
-	return true;
+	return idx <= mvdev->max_idx;
 }
 
 struct mlx5_vdpa_net {
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
