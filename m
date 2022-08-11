Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB82C19F2D
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 436F681AAB;
	Thu, 11 Aug 2022 08:48:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 436F681AAB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TYgUbMUc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Np05cSN7Fotl; Thu, 11 Aug 2022 08:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CBF3681A92;
	Thu, 11 Aug 2022 08:47:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBF3681A92
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97376C0033;
	Thu, 11 Aug 2022 08:47:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99359C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B0BC60FD1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:47:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B0BC60FD1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TYgUbMUc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s1hRNWOUgpcj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:47:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F1CE60E64
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F1CE60E64
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660207676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5AXFiHe2CmpDevMhSkIWn01i/EnbWuauw5G+9+V6hIc=;
 b=TYgUbMUckLuMewBM9neph44utKZwrWX/25Zs6dJECma3vF5M8s53Xl0fyP8rpIA0eMsv27
 rPOflv0QmAAXaZqogqstX+sadjSz9N7xKMPip+DgcAdQXTgd43VJOTBagFztWi/NSPdSPs
 gL//3JV6LGZ/Gx63bNldP5Cvo+Mnkx8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-_Z0dszYpNxG_vlSMh-ZoDg-1; Thu, 11 Aug 2022 04:47:55 -0400
X-MC-Unique: _Z0dszYpNxG_vlSMh-ZoDg-1
Received: by mail-qt1-f197.google.com with SMTP id
 e30-20020ac8011e000000b00342f61e67aeso8836542qtg.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=5AXFiHe2CmpDevMhSkIWn01i/EnbWuauw5G+9+V6hIc=;
 b=4wDNfYYqhKkWvANTMEPm0Y1geamLOJcZtvWXU3lKi/3mFazNHAKaenVhh3WA8nyZ7+
 IUNHDxeDD6GwhgCMVtaTClIiLO/Ry/BGFHU6BnZhgLbpieOdeme3RO5PsGpW1qtwwWjB
 takc0z7adJFnMio1sPBhHIuZ+qoXluwRmG7DrxaiiSzE1dQTsn7EJh7+9x/vehvL7s1h
 ZQAM+o0jMpKIzVlQfJH2SWmOt9/VvHx9LE89qLS6nl7dF7uGQ63VUeqKWZu4WySknY6F
 fQYRewd8H0OGozCrueagFx/+PIQpWSSmsnbhG7PM+EGUhpAjxRKOraqLKT/4sBR+SUrI
 k28Q==
X-Gm-Message-State: ACgBeo1HnwrrjS3oOtRcaSAw2emJu/LIkTktypI1ONWVFPPd1taKTf5c
 g5cO2Nff3C3K5f7MiYJPgclmYAs1+ModOJD2QhaszSj1HT4QCQD3nZCSCy/hdhhRpJn/+oKPU/0
 Ascr6i71J/YEyRiEgP8A35ZFudmWQaJu/ldDv96iJ1E5cIT9I998vIbiWBXZVXNrX2pBCo9Jb2h
 c0w65YcRHk9lgm3XsV0w==
X-Received: by 2002:a05:620a:170d:b0:6b8:fd9c:da91 with SMTP id
 az13-20020a05620a170d00b006b8fd9cda91mr22778160qkb.683.1660207673938; 
 Thu, 11 Aug 2022 01:47:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR44pcESFHkNdNM3Yf3jmpUmzHiMOEidvVu/fsIBlqr+kIf/Fux++cUEWpNdKhU50QGFjuV0EQ==
X-Received: by 2002:a05:620a:170d:b0:6b8:fd9c:da91 with SMTP id
 az13-20020a05620a170d00b006b8fd9cda91mr22778151qkb.683.1660207673670; 
 Thu, 11 Aug 2022 01:47:53 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 q31-20020a05620a2a5f00b006a793bde241sm21508qkp.63.2022.08.11.01.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:47:52 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa: fix warning casts when building with C=2
Date: Thu, 11 Aug 2022 10:47:49 +0200
Message-Id: <20220811084749.83809-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

Use __virtio16_to_cpu() to read `max_virtqueue_pairs` field in
virtio_net_config since its type is __virtio16.

This silences the following warning when building with `make C=2`:

    ../drivers/vdpa/vdpa.c:811:19: warning: cast to restricted __le16
    ../drivers/vdpa/vdpa.c:811:19: warning: cast from restricted __virtio16

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index c06c02704461..2466d5087478 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -808,7 +808,7 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
 	if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
 		return 0;
 
-	val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
+	val_u16 = __virtio16_to_cpu(true, config->max_virtqueue_pairs);
 	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
 }
 
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
