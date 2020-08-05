Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2551AC433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:45:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E212065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrynVP6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E212065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C5D60868C5;
	Wed,  5 Aug 2020 13:45:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qmSOy0ne3q04; Wed,  5 Aug 2020 13:45:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58185868BE;
	Wed,  5 Aug 2020 13:45:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50D76C0051;
	Wed,  5 Aug 2020 13:45:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05B28C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E907B881F9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:45:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8wxtgJFHYe7w
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 669C18826E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nsePUp5bwDzPkeGMt9DhuoyzhxlPvsYKTxQ+QKtzY8M=;
 b=WrynVP6uVxFbFhSRLx3ieU+JOthpPB/ixXTc/sy654e+M2C3NuWowuQs8Grb+JTJCtDyhI
 4kh8epFRzSEX9dVziIB4a2Tz7pszX1vRPPtnFvSKEDtofnSiE+snoq+r2YyDfFr7tSYGQH
 9QjpsvbwoMimQA4FsCmIciV8b6LbT2I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-UizBiEdCNw65pIi_eCcDmg-1; Wed, 05 Aug 2020 09:45:04 -0400
X-MC-Unique: UizBiEdCNw65pIi_eCcDmg-1
Received: by mail-wm1-f70.google.com with SMTP id f74so2746560wmf.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nsePUp5bwDzPkeGMt9DhuoyzhxlPvsYKTxQ+QKtzY8M=;
 b=ja5E8YSHK9wdHz5Jn0RExJWGBT1cbWhf6mzwDk3MANZsDK8Ld8G2N2fiCmiNOBRHQY
 3M6W47CLAAHWaKI9abl1k50xdHUOYjeoQP4WhdIevZylNW7yP0W+7nyyzAbmqCHEuHby
 No35gmBUYei9mUEhk06hBneOZZms1sVRD+RAkoUTxzbBVGfdYtcN6TzoYvCTKTHhgAls
 RGB01BjEduzgsSBFaJliLWt4N4V6G3CJt7HDvaUswMhMt99eo8TLkOCzdMQfBZV4dKER
 5NGORuWINGYCRDRvYD2HcaOviXWCZg7G4Xmxwu2E86nUcwQ1qE/7NSAawsHw1QjMME/k
 osXA==
X-Gm-Message-State: AOAM533quGSQRxgaKEjgHCeBHmdQ2SNFvbKZTixuS0h3LbhJBSHh1H2Y
 5/F36M/b8+eKFNhFVO7KjQAzfT2D9k6SHIkkXRTNTgJMAW3ZVvftzWVUoSAkjHxBnpxjelFiuQo
 xaWsI1xAJLECNh4EEWvPjn0NiOIuvV+V7/4xCXpv43w==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr3540963wmd.72.1596635102979; 
 Wed, 05 Aug 2020 06:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhLoRx7IzuivQlViG9F0fDgIgMdjMVV9PC0dBe4LfMZpIiYNNk/XwHbeS7FyfdebXIBXrqkg==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr3540940wmd.72.1596635102770; 
 Wed, 05 Aug 2020 06:45:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 e16sm2907812wrx.30.2020.08.05.06.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:45:02 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:45:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 38/38] virtio_net: use LE accessors for speed/duplex
Message-ID: <20200805134226.1106164-39-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

Speed and duplex config fields depend on VIRTIO_NET_F_SPEED_DUPLEX
which being 63>31 depends on VIRTIO_F_VERSION_1.

Accordingly, use LE accessors for these fields.

Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c        | 9 +++++----
 include/uapi/linux/virtio_net.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ba38765dc490..0934b1ec5320 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2264,12 +2264,13 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
 		return;
 
-	speed = virtio_cread32(vi->vdev, offsetof(struct virtio_net_config,
-						  speed));
+	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
+
 	if (ethtool_validate_speed(speed))
 		vi->speed = speed;
-	duplex = virtio_cread8(vi->vdev, offsetof(struct virtio_net_config,
-						  duplex));
+
+	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
+
 	if (ethtool_validate_duplex(duplex))
 		vi->duplex = duplex;
 }
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 27d996f29dd1..3f55a4215f11 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -99,7 +99,7 @@ struct virtio_net_config {
 	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
 	 * Any other value stands for unknown.
 	 */
-	__virtio32 speed;
+	__le32 speed;
 	/*
 	 * 0x00 - half duplex
 	 * 0x01 - full duplex
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
