Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4470C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 15:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C3D760DE5;
	Thu, 28 Apr 2022 15:12:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7IDKx6vU3Vu7; Thu, 28 Apr 2022 15:12:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0228660D70;
	Thu, 28 Apr 2022 15:12:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C4E9C0039;
	Thu, 28 Apr 2022 15:12:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED7E2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA1DB401C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1F2uhN2Xec56
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:12:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3C5E40198
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651158771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l7cbcgB7/LBI16VlALG4h+gnvPS9BXoCjSIEjFOAPWA=;
 b=e5FUMIqSv5PippccFURLPfRdcRTzGHj4XbXPCfhndhwbqhvTs1P2YOYxW36S3ylyNxkZKF
 2JPGVJfNoakSRpCv7Xd0aWMXtl/GLKAulenjt+TBS78AjRiIoc3lcEXP9IRkCC6MS12cxp
 FtUlBasjcmEhdwUZvaBN9hNNtm10t7c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-94NdzPzMNlyNPgGzk8oAKw-1; Thu, 28 Apr 2022 11:12:46 -0400
X-MC-Unique: 94NdzPzMNlyNPgGzk8oAKw-1
Received: by mail-wm1-f69.google.com with SMTP id
 g3-20020a7bc4c3000000b0039409519611so1503126wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 08:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l7cbcgB7/LBI16VlALG4h+gnvPS9BXoCjSIEjFOAPWA=;
 b=B7RlvnmnYlFscRtqFJ7CQHk/9a0r6WIwDqhoOPyP36B+AP7wXCj+T71iIJOPePak7M
 3WqRxD7ruKCFg/+guNYcFcv/sxkT7DycyuCoX+AVx5abuTo3pskmb0hHUeMxiwZOQGOS
 vhUbUoXLtPlpbFEv//RkfWUz5QA0aDP0xBidt14Oee4y9msYLWkutuwEAjsZX8rC0E8X
 w7jLUxPBrBe4nkLJO1qZd7mW0sGjaw7MTqS2D+rype8RMBs2oa3Kfd0CuHlQ153+23n/
 LWz1qM1bUABqLmAsDXxuFrBtyCqc+3zSFqFBxkg2HWPINvxZX/0kB8JP8knT5jnefGU+
 S50Q==
X-Gm-Message-State: AOAM531zd3NRW+Xz/D7DqY/32LbCVNymulp9VJ9Y+1/bHjn+/xyTJNoX
 ELd6Q2OqjXuWpuFzYTFnuqwdkBTIUQE7Kk6ECl9OM94ofhSHFckRf17zofuTzNFF5m7E85bgcXZ
 STEfQhER8mIg5cKZOLs7GRdDEkkIluUKpHzyaqxPcrFIZskwmMQOOEFdfqsm1YgtMW6wtcSB6Ku
 mynGdnNChNr+LQXyhrOw==
X-Received: by 2002:a5d:6a0f:0:b0:20a:ea3b:8d66 with SMTP id
 m15-20020a5d6a0f000000b0020aea3b8d66mr9037902wru.596.1651158764631; 
 Thu, 28 Apr 2022 08:12:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfaU4IRUPaTfN+PSjDCPo8Z/R+YWvg+fh9A3dxgD17Ii0lPQiheZMVy1BW43wJWTvMDO7l8Q==
X-Received: by 2002:a5d:6a0f:0:b0:20a:ea3b:8d66 with SMTP id
 m15-20020a5d6a0f000000b0020aea3b8d66mr9037881wru.596.1651158764395; 
 Thu, 28 Apr 2022 08:12:44 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-234.retail.telecomitalia.it.
 [87.11.6.234]) by smtp.gmail.com with ESMTPSA id
 y1-20020adfc7c1000000b0020ae65d2e91sm95612wrg.79.2022.04.28.08.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 08:12:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Date: Thu, 28 Apr 2022 17:12:42 +0200
Message-Id: <20220428151242.213824-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
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

The simulator behaves like a ramdisk, so we don't have to do
anything when a VIRTIO_BLK_T_FLUSH request is received, but it
could be useful to test driver behavior.

Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
that we support the flush command.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 42d401d43911..a6dd1233797c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -25,6 +25,7 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDPASIM_BLK_FEATURES	(VDPASIM_FEATURES | \
+				 (1ULL << VIRTIO_BLK_F_FLUSH)    | \
 				 (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
 				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
 				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
@@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		pushed += bytes;
 		break;
 
+	case VIRTIO_BLK_T_FLUSH:
+		if (sector != 0) {
+			dev_err(&vdpasim->vdpa.dev,
+				"A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
+				sector);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		break;
+
 	default:
 		dev_warn(&vdpasim->vdpa.dev,
 			 "Unsupported request type %d\n", type);
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
