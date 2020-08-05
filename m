Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F05C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4802065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3beiLYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4802065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F021587821;
	Wed,  5 Aug 2020 13:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J5RYIFrsX4TI; Wed,  5 Aug 2020 13:44:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 76949877E1;
	Wed,  5 Aug 2020 13:44:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 520CDC0051;
	Wed,  5 Aug 2020 13:44:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEB93C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DBF9586888
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ybJSMRUEMbbb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4BEE48688C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7dHJWpRpe+SGCeKRCL7RrX1ymnMkDIH+g5Ri3pUQbvw=;
 b=I3beiLYR760knHthbeDalvWcnNhdiRX/Q9HkmsTNJ2HVqBmv/fIj3y7NZXS9GTXlTdMWgP
 xXeI52sQjNeoCZ+ucOC+dBygdhupXTUt6Yp5rkyCHD/Mv0Fk0FsVd0syZC9towlVetiro2
 rtcRcj96K7FnQb1vgffZCqPtcaitgw4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-Ns1gjrVJMuaCwi0HSgsSJA-1; Wed, 05 Aug 2020 09:44:37 -0400
X-MC-Unique: Ns1gjrVJMuaCwi0HSgsSJA-1
Received: by mail-wm1-f69.google.com with SMTP id d22so2750459wmd.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7dHJWpRpe+SGCeKRCL7RrX1ymnMkDIH+g5Ri3pUQbvw=;
 b=IpgPVLi4p9A+03S2UX7POmPRvUpsXdhBrkiIBTffi5yYe+MHSdsf7bWVXRoqVp2BC0
 2AVOIFgoOgvt77FQKB+bnQfM8afVhPu+EpiH3exrghrJ15CCSQfm0a4UohVVeSTXHA5H
 YlwPbd7l5Xa17uvJY3HL1XKXdW6HhvQEezbO0inV5fOWHA93+iRsiLXrK409hQxmXFcb
 yoyUpfb+Rtk8cdL5Drss1T6UbVxuqT4I4LRPgN1foISatj8nJ5TFgqB/0zihaMZVKEm5
 IWabmj8A4KWGwDQOLyKWq0/N8pEDCFs8RTpwv2q3pETO07jvCywsUtNQq7MSdPYJ8n1B
 Ynsw==
X-Gm-Message-State: AOAM532WZ5Q6Fhx9MrEtNDprXfGT9MTW3qnawDWYRaYzeVTH2/qmMCgJ
 LjKTJy6sIOdts4CV2b0lDOS/cplB1aqMt+iMShef1FsFZiaUa1PSiDLQAq6kBllP4s2arudQ+Ww
 pLEBI0PvLiHwsz+ghGz9c851r4/7LZVBiqtgTGz9F3A==
X-Received: by 2002:adf:b441:: with SMTP id v1mr2885512wrd.61.1596635076656;
 Wed, 05 Aug 2020 06:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQGdbl54JNx1KvL4TiD4XZk3a0G829i0AZqCQq/0GXJ2UmmPCnIhNjqrC/ljNwKlqjr429kg==
X-Received: by 2002:adf:b441:: with SMTP id v1mr2885496wrd.61.1596635076408;
 Wed, 05 Aug 2020 06:44:36 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id o2sm3136755wrh.70.2020.08.05.06.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:35 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 29/38] virtio_balloon: use LE config space accesses
Message-ID: <20200805134226.1106164-30-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

Balloon is LE, it's cleaner to access it as such directly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8bc1704ffdf3..31cc97f2f515 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -398,12 +398,9 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	s64 target;
 	u32 num_pages;
 
-	virtio_cread(vb->vdev, struct virtio_balloon_config, num_pages,
-		     &num_pages);
-
 	/* Legacy balloon config space is LE, unlike all other devices. */
-	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
-		num_pages = le32_to_cpu((__force __le32)num_pages);
+	virtio_cread_le(vb->vdev, struct virtio_balloon_config, num_pages,
+			&num_pages);
 
 	target = num_pages;
 	return target - vb->num_pages;
@@ -462,11 +459,8 @@ static void update_balloon_size(struct virtio_balloon *vb)
 	u32 actual = vb->num_pages;
 
 	/* Legacy balloon config space is LE, unlike all other devices. */
-	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
-		actual = (__force u32)cpu_to_le32(actual);
-
-	virtio_cwrite(vb->vdev, struct virtio_balloon_config, actual,
-		      &actual);
+	virtio_cwrite_le(vb->vdev, struct virtio_balloon_config, actual,
+			 &actual);
 }
 
 static void update_balloon_stats_func(struct work_struct *work)
@@ -579,12 +573,10 @@ static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
 {
 	if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
 			       &vb->config_read_bitmap)) {
-		virtio_cread(vb->vdev, struct virtio_balloon_config,
-			     free_page_hint_cmd_id,
-			     &vb->cmd_id_received_cache);
 		/* Legacy balloon config space is LE, unlike all other devices. */
-		if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
-			vb->cmd_id_received_cache = le32_to_cpu((__force __le32)vb->cmd_id_received_cache);
+		virtio_cread_le(vb->vdev, struct virtio_balloon_config,
+				free_page_hint_cmd_id,
+				&vb->cmd_id_received_cache);
 	}
 
 	return vb->cmd_id_received_cache;
@@ -987,8 +979,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		if (!want_init_on_free())
 			memset(&poison_val, PAGE_POISON, sizeof(poison_val));
 
-		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
-			      poison_val, &poison_val);
+		virtio_cwrite_le(vb->vdev, struct virtio_balloon_config,
+				 poison_val, &poison_val);
 	}
 
 	vb->pr_dev_info.report = virtballoon_free_page_report;
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
