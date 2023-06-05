Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52718C7EE23
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 11:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5B0640471;
	Mon,  5 Jun 2023 11:06:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5B0640471
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CapcsfTV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KKBDEYw5ZPmU; Mon,  5 Jun 2023 11:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6CED440124;
	Mon,  5 Jun 2023 11:06:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CED440124
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE87C007A;
	Mon,  5 Jun 2023 11:06:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5156CC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 11:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24446417D4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 11:06:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24446417D4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CapcsfTV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b0tAiZqvEOaF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 11:06:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CAA5417C8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CAA5417C8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 11:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685963210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kbCiwyqVxBGMkLGPRwYBBYz8NZcSuztWZwPhXZOo2A4=;
 b=CapcsfTV1dRtKD+kXAeqZ4iqyP1hwUCKplvxldtUSz6nJS04kqWLSz2kfC44lbZLC/T7Z+
 R9JGeJ1z6NHzmVcfExBjQhAXDu8NU/4nbe64tg9SOrokVITCsz5pTJ/qUdf15SLbTbSglg
 O1NAZnROlrBTgULLJ/2EbFLPC5+TdC4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-oGe3zRMxOeSXmJl6WU_Rxw-1; Mon, 05 Jun 2023 07:06:49 -0400
X-MC-Unique: oGe3zRMxOeSXmJl6WU_Rxw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f6f2f18ecbso22383505e9.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 04:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685963207; x=1688555207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kbCiwyqVxBGMkLGPRwYBBYz8NZcSuztWZwPhXZOo2A4=;
 b=C89hBpf6dnvB1iVseh5YM079fdZeuCfuOugIgmcWROk8NORraxwNZedhIKw5Mq3vr2
 VONs05+K86kKGI0slrh1HiYZHxl+ZK32+Fl+5mgIW6VcwSaBuWavo8++9esY4yOtIN4h
 1rxsHVAMsREUHTvYVBW2HKPHQ4FHWo9+U2vh4D7x0551AYh4irJH4mIXINnVXdbey+3o
 V57O5BLsa0fOIBuJckIkHdgSxnx8KJDKAuEzEwFkT4UpECjiFHKPDSNNkghFQiuNqc8v
 c+7VbT2tIkK5mZPpERO8l8cwzrBX7+SgScR8lcnaY53KMAriLo7SqYwILTC0YIdGRKDD
 lXHA==
X-Gm-Message-State: AC+VfDxPg4V3vadEhU9zjeHORtqSwMLN62885Opq/yJkd0Qa6D5uFlWy
 tNPNN1L5bDUgEFixLEPljUEjUyium5db+ZGg0UdzelW7oZTOdKOgtwYG/WdJiDoIxtxskPUS24j
 pijv3PxNdB/2/1ynbonMaxRSNtVcjr3z6s5s4vRT5eD3GNcqJ2lKb1r/GSTWJRXbIgqmDhzp+m3
 IGgpGTb9Xz5V1E44/qbnTO2+xDHw==
X-Received: by 2002:a05:600c:2318:b0:3f5:fb97:eafe with SMTP id
 24-20020a05600c231800b003f5fb97eafemr6359807wmo.30.1685963207667; 
 Mon, 05 Jun 2023 04:06:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53W9xn9TGBpaX8/z08DhNRppPkhtiy/6dFg/34pYnUjNp28hkX6GPjzKGWmEUJ3a7qTnjMfQ==
X-Received: by 2002:a05:600c:2318:b0:3f5:fb97:eafe with SMTP id
 24-20020a05600c231800b003f5fb97eafemr6359787wmo.30.1685963207240; 
 Mon, 05 Jun 2023 04:06:47 -0700 (PDT)
Received: from step1.redhat.com ([5.77.94.106])
 by smtp.gmail.com with ESMTPSA id
 s5-20020a5d4245000000b0030903d44dbcsm9407323wrr.33.2023.06.05.04.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 04:06:46 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Date: Mon,  5 Jun 2023 13:06:44 +0200
Message-Id: <20230605110644.151211-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
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

vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
don't support packed virtqueue well yet, so let's filter the
VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().

This way, even if the device supports it, we don't risk it being
negotiated, then the VMM is unable to set the vring state properly.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
    better PACKED support" series [1] and backported in stable branches.
    
    We can revert it when we are sure that everything is working with
    packed virtqueues.
    
    Thanks,
    Stefano
    
    [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/

 drivers/vhost/vdpa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 8c1aefc865f0..ac2152135b23 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -397,6 +397,12 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
 
 	features = ops->get_device_features(vdpa);
 
+	/*
+	 * IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE) don't support
+	 * packed virtqueue well yet, so let's filter the feature for now.
+	 */
+	features &= ~BIT_ULL(VIRTIO_F_RING_PACKED);
+
 	if (copy_to_user(featurep, &features, sizeof(features)))
 		return -EFAULT;
 

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
