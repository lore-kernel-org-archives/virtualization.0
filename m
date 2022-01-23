Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35FCC433F5
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 00:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A43A560ADA;
	Sun, 23 Jan 2022 00:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpaE1jlj5g-u; Sun, 23 Jan 2022 00:12:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 568E660AAF;
	Sun, 23 Jan 2022 00:12:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2265AC0031;
	Sun, 23 Jan 2022 00:12:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06ECCC007A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC2F640162
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YMNqaQwbwJUn
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1EAA401A4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:55 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 30DCC60FAA;
 Sun, 23 Jan 2022 00:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5C6C340E7;
 Sun, 23 Jan 2022 00:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642896774;
 bh=lH0A/QKBIqfiGBlevd1r6WIjiQ9AhbmQphx2kvuwohU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pRom+PTLmI76gvyjygvc5D5/th3QRawMAcU6h/C8rv3z0vhAhd3d3ZRf/BXznhMIZ
 6EsSzLX8v4GlsYmHM44Z4jqRlm0u3Q1TwapFeWZzQwicP3hjM42LvOpoc7JbijrgJ5
 Z3yT83Gqb255qGojbcmiFDfPKTeoV+0dkCSoQZdTJOIdjpjLk0fHFs30ckxADd3Fs2
 6Nu1u8D4Md5/EV1v0IOp7u/+OT0lPOuEO4GLWwmfpImmFOvOrMHYLLqYV3Xs5fBR8r
 b7ZCtw5AwF7VK8NnBXNX4m1/G91OG0aejTzjDhIr7v3j83DJRDIV6dygpXlFgh0TH8
 TSBnwU6TjVSpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/16] vdpa/mlx5: Fix is_index_valid() to refer
 to features
Date: Sat, 22 Jan 2022 19:12:13 -0500
Message-Id: <20220123001216.2460383-14-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123001216.2460383-1-sashal@kernel.org>
References: <20220123001216.2460383-1-sashal@kernel.org>
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
index ae85d2dd6eb76..d538fbc472666 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -137,10 +137,14 @@ struct mlx5_vdpa_virtqueue {
 
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
