Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC79ECAAD3
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 06:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24AE640275;
	Wed,  7 Sep 2022 06:01:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24AE640275
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VA+4qBfz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hYhe3C2k5gao; Wed,  7 Sep 2022 06:01:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B105B40239;
	Wed,  7 Sep 2022 06:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B105B40239
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B4CFC0033;
	Wed,  7 Sep 2022 06:01:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59C85C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34E1A818A1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34E1A818A1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VA+4qBfz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ttM0n5CDHCao
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:01:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F7498188B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F7498188B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662530486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ovHoM9YpW21oT3aBioqYivK4mMYTlNS9bEeTyk27HO8=;
 b=VA+4qBfzbqSAw5gfWQXUN3AFNoKBPZFE8iHTL1260JjV9kSJL8iVZFITfufwK4jMpih3fC
 1nk7nEbxvGXEs4r5+tS+BihSGmq7tcCoALSzQj0OGLDhRzJtyXQ00ovcEPcdowdCzsva24
 CZSrZ6IHDhbcqkxaz8RAAzTDwBLqBng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-sMpKTXSHNsGUx8QJsaujwA-1; Wed, 07 Sep 2022 02:01:15 -0400
X-MC-Unique: sMpKTXSHNsGUx8QJsaujwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 351ED804191;
 Wed,  7 Sep 2022 06:01:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-171.pek2.redhat.com
 [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D441E4010FA1;
 Wed,  7 Sep 2022 06:01:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa: conditionally fill max max queue pair for stats
Date: Wed,  7 Sep 2022 14:01:10 +0800
Message-Id: <20220907060110.4511-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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

For the device without multiqueue feature, we will read 0 as
max_virtqueue_pairs from the config. So if we fill
VDPA_ATTR_DEV_NET_CFG_MAX_VQP with the value we read from the config
we will confuse the user.

Fixing this by only filling the value when multiqueue is offered by
the device so userspace can assume 1 when the attr is not provided.

Fixes: 13b00b135665c("vdpa: Add support for querying vendor statistics")
Cc: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index c06c02704461..bc328197263f 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -894,7 +894,6 @@ static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
 {
 	struct virtio_net_config config = {};
 	u64 features;
-	u16 max_vqp;
 	u8 status;
 	int err;
 
@@ -905,15 +904,15 @@ static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
 	}
 	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
 
-	max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
-	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
-		return -EMSGSIZE;
-
 	features = vdev->config->get_driver_features(vdev);
 	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
 			      features, VDPA_ATTR_PAD))
 		return -EMSGSIZE;
 
+	err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
+	if (err)
+		return err;
+
 	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
 		return -EMSGSIZE;
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
