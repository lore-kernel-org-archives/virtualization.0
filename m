Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE298C761AF
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 16:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3923E4096D;
	Wed, 29 Mar 2023 16:03:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3923E4096D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jUrINhWn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KiGqaqFIwpiA; Wed, 29 Mar 2023 16:03:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F92940074;
	Wed, 29 Mar 2023 16:03:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F92940074
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 730D0C0036;
	Wed, 29 Mar 2023 16:03:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25FDCC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 015E541D55
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:03:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 015E541D55
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jUrINhWn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i5HxKEqyb0_U
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:03:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BA3E4000B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3BA3E4000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680105807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WhrreSkv0vZH0WLUdB+/3ln6MeZlFYYMu2CO+omtwhg=;
 b=jUrINhWnZAt+gXZ7VAoE5LMje8y44LcxqnvCCteFhdtSyE7Nb12W5cyDYMO0tDp260HlRG
 cDFbi99sy+oh41k+c2dwgpMyiFVb5ex3KhY6QNWoV0DWb0pyLOuQlG1FVTWaTmSoyIwz4y
 BMqnX4ZDFKLcONwy+y4WUu119COP0bM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-yQE3_4dMNpCYodadfi3StQ-1; Wed, 29 Mar 2023 12:03:26 -0400
X-MC-Unique: yQE3_4dMNpCYodadfi3StQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 n10-20020a05622a11ca00b003e4e30c6c98so7805114qtk.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 09:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680105805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhrreSkv0vZH0WLUdB+/3ln6MeZlFYYMu2CO+omtwhg=;
 b=01ZXg/j+HVu1H0cwAVybGTtbiCs9Y1/LeQLjrGWZ7WB41qnyB9ZtdU6Swiq/CqhuX2
 MDVxOQQLnxQgVPY1UdO/44/X+X3FdBkwmNkYqPpq+BVAnkptDsA231ClcSzfkMFpaRlf
 alFFWLu1rXQYSQwXLtnqUHMrQspXtAnbn3sGlHdNzwSgnogIjSbuYH1t2C41L9YfNbnd
 QIzmLEdsCeFC0iiTBDfYkCMx7TuNvf3Gd82m83jXVnsUDnYTzkdGNCPNAPiowpvQZ9Hq
 rvkCcwnMgIO54LJdSPlm9GHar20Yu7x6mGNlvJHxkaGRYj+KzBw/FtIjH++LnvogYqi2
 Roow==
X-Gm-Message-State: AO0yUKUOGeL+Bxc9f3RpEilRwGOonJNpK1GWKu3GNvniissa86o+q/mm
 Ki1JJJTR29Rigl2tZ5uOhU39WWHd309i6nXApSeDYUmTQP3XaJTZ1pY71VYAd58AknmlZj+jbWs
 y/VRRi00CoKOjQAzrUZnhq1u/Zl168iuX/Ssb115+/SQ3SSgPNPNjcsqQN9GLMQK7ysOGpEsiWv
 HtVZEasuniLM7S1GVIISvfvxwspA==
X-Received: by 2002:ac8:58c3:0:b0:3e4:6329:448e with SMTP id
 u3-20020ac858c3000000b003e46329448emr35810491qta.16.1680105805195; 
 Wed, 29 Mar 2023 09:03:25 -0700 (PDT)
X-Google-Smtp-Source: AK7set/FoJCjgeNDT4rElGSF+Zl8YAW9TnymsfzUzUHuClJUBQwdLVEZBocjmA0YXTyxGB7KC7JO9Q==
X-Received: by 2002:ac8:58c3:0:b0:3e4:6329:448e with SMTP id
 u3-20020ac858c3000000b003e46329448emr35810447qta.16.1680105804906; 
 Wed, 29 Mar 2023 09:03:24 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 d184-20020a3768c1000000b0074688c36facsm13206442qkc.56.2023.03.29.09.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 09:03:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa_sim_net: complete the initialization before register the
 device
Date: Wed, 29 Mar 2023 18:03:21 +0200
Message-Id: <20230329160321.187176-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
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

Initialization must be completed before calling _vdpa_register_device()
since it can connect the device to the vDPA bus, so requests can arrive
after that call.

So for example vdpasim_net_work(), which uses the net->*_stats variables,
can be scheduled before they are initialized.

Let's move _vdpa_register_device() to the end of vdpasim_net_dev_add()
and add a comment to avoid future issues.

Fixes: 0899774cb360 ("vdpa_sim_net: vendor satistics")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    I don't have a reproducer, but I became aware of this problem while
    I was changing the buffer allocation.
    
    In the block device, as soon as the device is registered, the driver
    sends several requests, and I guess this might happen for the net
    device as well.
    
    Thanks,
    Stefano

 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 862f405362de..dfe2ce341803 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -466,16 +466,21 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 	vdpasim_net_setup_config(simdev, config);
 
-	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
-	if (ret)
-		goto reg_err;
-
 	net = sim_to_net(simdev);
 
 	u64_stats_init(&net->tx_stats.syncp);
 	u64_stats_init(&net->rx_stats.syncp);
 	u64_stats_init(&net->cq_stats.syncp);
 
+	/*
+	 * Initialization must be completed before this call, since it can
+	 * connect the device to the vDPA bus, so requests can arrive after
+	 * this call.
+	 */
+	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
+	if (ret)
+		goto reg_err;
+
 	return 0;
 
 reg_err:
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
