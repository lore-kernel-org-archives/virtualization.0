Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AD3C43219
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 14:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B24184344;
	Wed, 16 Mar 2022 14:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id evgThbNCN7j5; Wed, 16 Mar 2022 14:17:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F53F842E3;
	Wed, 16 Mar 2022 14:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC7ADC0012;
	Wed, 16 Mar 2022 14:17:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 485BDC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 14:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 369564175C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 14:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hsgBD90MpWCR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 14:17:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D915402A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 14:17:08 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 915D5613C5;
 Wed, 16 Mar 2022 14:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D24C340EC;
 Wed, 16 Mar 2022 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647440227;
 bh=6zLz/9Zh1RR3ggBa17qzUrw7ZSDAunI0M98e6yogLJc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bgJjQJK0RTD3reI6B4Q6dcuCvqmz7jwcJpCJUTaiO/rY3/GO2O3WqN96WWF2wIj6F
 lY/UL6EcqjQRhCxgcJ/+eKESuPFPJ6cFb2cF2ZMbdbo9xS9gyf7uNmJ8MHLW4Kwc+E
 xkZ4N3S0hQPPT9sYzpyQvgnqTyDsNtZkIQB0JJtbihmoD18STLOpmavTWft/iO8xMD
 Q7aFQTUBGi8vWCF2es8mr6KBMpIsHCNjjqsYVpwv1Yyj8y27KlRlr8FM1Tn9R3zBqn
 rIuV9y9aHFIecNu5nItbsPPswokMsiYV+tTdr2/c/0FTB5MYPz4BVkbLL7KpFLbDR0
 ad2acdiJl8KBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/12] vdpa/mlx5: should verify CTRL_VQ feature
 exists for MQ
Date: Wed, 16 Mar 2022 10:16:30 -0400
Message-Id: <20220316141636.248324-6-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220316141636.248324-1-sashal@kernel.org>
References: <20220316141636.248324-1-sashal@kernel.org>
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

[ Upstream commit 30c22f3816ffef8aa21a000e93c4ee1402a6ea65 ]

Per VIRTIO v1.1 specification, section 5.1.3.1 Feature bit requirements:
"VIRTIO_NET_F_MQ Requires VIRTIO_NET_F_CTRL_VQ".

There's assumption in the mlx5_vdpa multiqueue code that MQ must come
together with CTRL_VQ. However, there's nowhere in the upper layer to
guarantee this assumption would hold. Were there an untrusted driver
sending down MQ without CTRL_VQ, it would compromise various spots for
e.g. is_index_valid() and is_ctrl_vq_idx(). Although this doesn't end
up with immediate panic or security loophole as of today's code, the
chance for this to be taken advantage of due to future code change is
not zero.

Harden the crispy assumption by failing the set_driver_features() call
when seeing (MQ && !CTRL_VQ). For that end, verify_min_features() is
renamed to verify_driver_features() to reflect the fact that it now does
more than just validate the minimum features. verify_driver_features()
is now used to accommodate various checks against the driver features
for set_driver_features().

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Link: https://lore.kernel.org/r/1642206481-30721-3-git-send-email-si-wei.liu@oracle.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 65d6f8fd81e7..577ff786f11b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1482,11 +1482,25 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
 	return ndev->mvdev.mlx_features;
 }
 
-static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
+static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 features)
 {
+	/* Minimum features to expect */
 	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
 		return -EOPNOTSUPP;
 
+	/* Double check features combination sent down by the driver.
+	 * Fail invalid features due to absence of the depended feature.
+	 *
+	 * Per VIRTIO v1.1 specification, section 5.1.3.1 Feature bit
+	 * requirements: "VIRTIO_NET_F_MQ Requires VIRTIO_NET_F_CTRL_VQ".
+	 * By failing the invalid features sent down by untrusted drivers,
+	 * we're assured the assumption made upon is_index_valid() and
+	 * is_ctrl_vq_idx() will not be compromised.
+	 */
+	if ((features & (BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ))) ==
+            BIT_ULL(VIRTIO_NET_F_MQ))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1544,7 +1558,7 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 
 	print_features(mvdev, features, true);
 
-	err = verify_min_features(mvdev, features);
+	err = verify_driver_features(mvdev, features);
 	if (err)
 		return err;
 
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
