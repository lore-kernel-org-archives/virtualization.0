Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852A6C433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2422060A81;
	Wed, 30 Mar 2022 06:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xJaXI0Y1r8fN; Wed, 30 Mar 2022 06:23:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B4C4660804;
	Wed, 30 Mar 2022 06:23:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 904FAC002C;
	Wed, 30 Mar 2022 06:23:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD706C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C65DA812C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fF2lEK_CMFx7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:23:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 676DB812B7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648621413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=8TGY8FPvAj69Ea635jOIsz/rfPRMfoGdBaPywDij9qk=;
 b=MMH8WpxtjPbPyz5cgNC9lzbISZaywE9mml8yzi2PqEMh6wDg5SDBCSbmA7oLCeYSAhUbp6
 tnIxJ3plbGlLYdEt2RQekbCXDe3yb4ySFPiTBKwCdwnH0n8R8rLhxpgz9guZJZBWCG2pvp
 86SB9/wNigEeQuYa75Xuo9aXR1uDPXo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-TbAJgzOjPPundCCSS25pvA-1; Wed, 30 Mar 2022 02:23:31 -0400
X-MC-Unique: TbAJgzOjPPundCCSS25pvA-1
Received: by mail-wr1-f69.google.com with SMTP id
 p18-20020adfba92000000b001e8f7697cc7so5568576wrg.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 23:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=8TGY8FPvAj69Ea635jOIsz/rfPRMfoGdBaPywDij9qk=;
 b=uSBQsS3rF9Ef4tRa1xhHkKHhLkQqFNmamAbVUgQZSfxFFjc5Yeyi/laa36c4A4z83l
 8h7B4wocN1N4XgC2rs8FtglPYtMQlcSTdPqByFzT+UnyGpTvu+Qn33fMV+btBIveKoim
 3Zh/uSXnU8HMwJvU7tgtUFwTSCrD51NTukGzu0zGsgQ92GYZPh/kqIVIHi+GmTg195Zx
 G4ABynu25rNwF6zr3FDPfrTF/2meibNrS/rK8Bv3SDG6szx/bfUlEpUQlceJ2O2Wu4gs
 28DQqJqKAqqW1YYnvObEZX+ZsK32AmxRnLQTC5wtOlYMp3sTkqNV/c9CHngtXOCqmfvU
 tizw==
X-Gm-Message-State: AOAM5311nurj6jsj9+SPBI53Aafa94BdKk0FQ+x1cLkYICd34hAHRvyj
 +0ioTVDW1YGgWn4VESwK8idrzCmPye6/+tVTZXdEzCwW7WhMScmqYN0FgRqy/VctOQKlJDhhU5+
 I0M65asv2YmHsMEXbpkDkfsLiCKFQmntzitqfOyqc9g==
X-Received: by 2002:adf:e58a:0:b0:203:f3c8:4cfe with SMTP id
 l10-20020adfe58a000000b00203f3c84cfemr34658945wrm.475.1648621410662; 
 Tue, 29 Mar 2022 23:23:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqd0k6v3wYqEXpvBX5cQt/Kl9g/JqVY1JyMjZJFzrNQq8Nfcjn2ou2eHRnr8n6fxvobm+ufQ==
X-Received: by 2002:adf:e58a:0:b0:203:f3c8:4cfe with SMTP id
 l10-20020adfe58a000000b00203f3c84cfemr34658934wrm.475.1648621410459; 
 Tue, 29 Mar 2022 23:23:30 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c1d1400b0038cba2f88c0sm5173811wms.26.2022.03.29.23.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 23:23:29 -0700 (PDT)
Date: Wed, 30 Mar 2022 02:23:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "virtio: use virtio_device_ready() in
 virtio_device_restore()"
Message-ID: <20220330062315.125924-1-mst@redhat.com>
MIME-Version: 1.0
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

This reverts commit 8d65bc9a5be3f23c5e2ab36b6b8ef40095165b18.

We reverted the problematic changes, no more need for work
arounds on restore.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75c8d560bbd3..22f15f444f75 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -526,9 +526,8 @@ int virtio_device_restore(struct virtio_device *dev)
 			goto err;
 	}
 
-	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
-	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
-		virtio_device_ready(dev);
+	/* Finally, tell the device we're all set */
+	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
 
 	virtio_config_enable(dev);
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
