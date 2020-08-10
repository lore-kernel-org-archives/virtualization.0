Return-Path: <SRS0=GaRw=BU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CAC433E0
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 13:16:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192C120729
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 13:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgU7RBhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192C120729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A64AC20520;
	Mon, 10 Aug 2020 13:15:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kje5+vN7Pk3Z; Mon, 10 Aug 2020 13:15:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8C59020116;
	Mon, 10 Aug 2020 13:15:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 709F8C0864;
	Mon, 10 Aug 2020 13:15:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81EECC004D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7EA408704C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N990TSvpTa7l
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:15:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8E82C86EA0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597065353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=SkccwtZwot+cQicoGLcB8HlwMrsRMKWiGoSDkAQlLl4=;
 b=RgU7RBhDVhD/F/0E3DPBFFUBjH6V6uTaWak9UgW+ldZlke36/VyzOs75ThUGMbAFnJynfj
 Gg1iBkxon5kb6kedGekEZ3/dge548tT4Yyq7KfTRwtd084CMe/sBDYTbjdi0L/6pFwIWnK
 jiMcTHqGeTH/glED3wvL+0J5FKFDbWU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-aEiKYZIpOa23hgMDTzP2tg-1; Mon, 10 Aug 2020 09:15:52 -0400
X-MC-Unique: aEiKYZIpOa23hgMDTzP2tg-1
Received: by mail-wr1-f72.google.com with SMTP id b13so4222989wrq.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 06:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=SkccwtZwot+cQicoGLcB8HlwMrsRMKWiGoSDkAQlLl4=;
 b=JLDxPf+pj/nPKli+V86jvbbLa0/yCPRMM7LnWwE4oZkqQxAZXuKSybVn/5cycDFNyE
 qEDiFYi3f6iXMRo6+MzYXfXuXYRV7W/Fm+dMxvzJbdoyEPZsVbZ2L3+K5leaklNg2g3I
 7yifYMu8R+ZSvNwKmKtPkWwkDw+R5Ksrg7qL5JF9iJRRGyQvq9lzDOsP3AW9vF9s1xpx
 9AXE8aZ8JW4uGTtr8jOJB/+hH16kCPN5KZv51N7OEOFVtO7lPPmiconyCk46TdP2Y+K5
 AfHdKbSKA6gENPwUg5bNHJ27xazI7DS+hdEfjwy2yCSR+rfMQHcZGfb39tsXG8poNKyi
 pvJQ==
X-Gm-Message-State: AOAM5325omqgOcD0qYMgFpxM9/hJDq84EdTS0k/ohnQGDmqOL8nOgN+L
 IRFBArG4qFqb90A09UHqjMb6uFTRKBnEPlb/a5bok+pC2SsZhW1sdhHqcGKarewyoo21K9f38UF
 gjfGzJU+z8Ccn04Auh36crmChxbNyRgCAdF+1DX5X1g==
X-Received: by 2002:a1c:6087:: with SMTP id
 u129mr24584910wmb.157.1597065350496; 
 Mon, 10 Aug 2020 06:15:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJHvW56HaHPIOjJ1zmGR1ZtqZ1Qm7WDWul/CFEd2atwUm51JZJIT272Ywlsls9/8VFgLcuMA==
X-Received: by 2002:a1c:6087:: with SMTP id
 u129mr24584894wmb.157.1597065350280; 
 Mon, 10 Aug 2020 06:15:50 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 y145sm22255849wmd.48.2020.08.10.06.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 06:15:49 -0700 (PDT)
Date: Mon, 10 Aug 2020 09:15:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa/mlx5: fix up endian-ness for mtu
Message-ID: <20200810131516.1563803-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org
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

VDPA mlx5 accesses config space as native endian - this is
wrong since it's a modern device and actually uses LE.

It only supports modern guests so we could punt and
just force LE, but let's use the full virtio APIs since people
tend to copy/paste code, and this is not data path anyway.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index c6b9ec47e51d..9df69d5efe8c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -137,6 +137,7 @@ struct mlx5_vdpa_net {
 	struct mlx5_fc *rx_counter;
 	struct mlx5_flow_handle *rx_rule;
 	bool setup;
+	u16 mtu;
 };
 
 static void free_resources(struct mlx5_vdpa_net *ndev);
@@ -1506,6 +1507,13 @@ static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
 	}
 }
 
+/* TODO: cross-endian support */
+static inline bool mlx5_vdpa_is_little_endian(struct mlx5_vdpa_dev *mvdev)
+{
+	return virtio_legacy_is_little_endian() ||
+		(mvdev->actual_features & (1ULL << VIRTIO_F_VERSION_1));
+}
+
 static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -1519,6 +1527,8 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 		return err;
 
 	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
+	ndev->config.mtu = __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev),
+					     ndev->mtu);
 	return err;
 }
 
@@ -1925,7 +1935,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
 	init_mvqs(ndev);
 	mutex_init(&ndev->reslock);
 	config = &ndev->config;
-	err = mlx5_query_nic_vport_mtu(mdev, &config->mtu);
+	err = mlx5_query_nic_vport_mtu(mdev, &ndev->mtu);
 	if (err)
 		goto err_mtu;
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
