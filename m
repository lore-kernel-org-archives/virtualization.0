Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E492C4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 14:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 041AC401C2;
	Thu, 10 Nov 2022 14:13:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 041AC401C2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WW/yugTI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uvIKXECfGcYg; Thu, 10 Nov 2022 14:13:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 87CE74026A;
	Thu, 10 Nov 2022 14:13:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87CE74026A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31DC3C0032;
	Thu, 10 Nov 2022 14:13:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A48D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 14:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B9C281ADE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 14:13:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B9C281ADE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WW/yugTI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OBcyJsHKuTIy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 14:13:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85FA981A92
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85FA981A92
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668089632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EGdeBqZHdvW6TGtz0bzuryVKHsywKrh20LlxuiZOelI=;
 b=WW/yugTIwELAe9ZiAPoRU/MeGz0f4zD+NrEt59rNO7tpTAoU56ecpE7asIBVr8XeRbM7Ou
 5y+Zsjl/dKZuYWJopH8OM81Lk6Bj+sKBV5gayxtgkWOBaq70MgHeETcfNx2nAO+Xnz1MKH
 dFKfQzglmI/NQo1DEaKp1NBghM2M1vU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-tqQgJWNkNcm0IMyzxpKwSQ-1; Thu, 10 Nov 2022 09:13:50 -0500
X-MC-Unique: tqQgJWNkNcm0IMyzxpKwSQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 u63-20020a638542000000b004701a0aa835so1064755pgd.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGdeBqZHdvW6TGtz0bzuryVKHsywKrh20LlxuiZOelI=;
 b=FLa7dvDPpKnQRiNEBiXl7MA12Tm1+rr2mo/AWL3l0nJDH215uDdplk5R//sEqeOa6M
 +rfOXbfh/aIrmOnwuyI/V9oMEweD/wk9fr5uCaZ6n6YxoT7dK7pnVwzYitWl/8N6+3Wc
 Piq+DGeMlDVTob7AnK0UAjbkzqDvcaBVejEHjn9dgAzXMk+8YCNBsZCyW22VDFsqMN8J
 38jzHYhaHXEyK3xxQSatdPGAv1wZcPxcRlQDc+TuD+B2ZOCVXTBF5gAoRhUymP/zV6xY
 aPAhGXI+kfUoNbyNak58F7Xl2qoYlbnBLJhs2w3jUo8r574VoV0fnARKYUfpotsmwZp6
 d3zg==
X-Gm-Message-State: ACrzQf0/8EDflfSTVcouF6XJoeE+BgwBk9XlEmorhuo1EK0oQxeSfmNT
 9L+xI8c1rd1j9dLNqkkq1u7Royt6gCKLushPoSMe0cjiA5oGEZu9LPUjCwB2ILJvH1kr49yvcV/
 FTnc0KF9J0rd8XYL93+LxHYpdiXQFw4jv8aW2rWNuHsvglsyDWi9YMLVPmNhEDZT0V3XxYJMgyF
 e5br1Riztk8nsG6LldEQ==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id
 z2-20020a170902ccc200b0017829f95c5emr62089275ple.21.1668089628925; 
 Thu, 10 Nov 2022 06:13:48 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4pTVwwwoLGWtQena1F0pLzfeP30NWs5AAYEwbAd4Bo+neGArXMZ1NL4blW72ZgkwHqxgCYsw==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id
 z2-20020a170902ccc200b0017829f95c5emr62089242ple.21.1668089628429; 
 Thu, 10 Nov 2022 06:13:48 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 o24-20020aa79798000000b0056a7486da77sm10503973pfp.13.2022.11.10.06.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Nov 2022 06:13:47 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa_sim: fix vringh initialization in vdpasim_queue_ready()
Date: Thu, 10 Nov 2022 15:13:35 +0100
Message-Id: <20221110141335.62171-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eugenio Perez Martin <eperezma@redhat.com>, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

When we initialize vringh, we should pass the features and the
number of elements in the virtqueue negotiated with the driver,
otherwise operations with vringh may fail.

This was discovered in a case where the driver sets a number of
elements in the virtqueue different from the value returned by
.get_vq_num_max().

In vdpasim_vq_reset() is safe to initialize the vringh with
default values, since the virtqueue will not be used until
vdpasim_queue_ready() is called again.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..b20689f8fe89 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
-	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
-			  VDPASIM_QUEUE_MAX, false,
+	vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
 			  (struct vring_avail *)
 			  (uintptr_t)vq->driver_addr,
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
