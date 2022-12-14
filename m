Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACFAC001B2
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 16:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D6F360DE5;
	Wed, 14 Dec 2022 16:30:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D6F360DE5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G4DCMNNk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-M_wPuD12sM; Wed, 14 Dec 2022 16:30:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9BE5A60C15;
	Wed, 14 Dec 2022 16:30:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BE5A60C15
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77929C0033;
	Wed, 14 Dec 2022 16:30:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7788EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EB4081E9B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EB4081E9B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G4DCMNNk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aW0xg8aMn5qe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95A7A80C52
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95A7A80C52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671035433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1lGOBSIFe5pUAxEjRFkRz63QN+FtG9EzKvnfhz76nOw=;
 b=G4DCMNNkD4bdRP0bvCI7oekcs+Rn2e/mGamGIlrVtUA47ufJsNqrZCi/xaac67kX6pnFmN
 yhePSBKwsj64Zruq9o4y6/Yk8mEyQeG9/LFIzqtDT11fyKDXDtuLjatdCAccFFJtcCiaI5
 i0aEKrh2smah++vxUwCusMexFoxHeQk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-VQInO6LzNhOwIBqx2TUxMA-1; Wed, 14 Dec 2022 11:30:32 -0500
X-MC-Unique: VQInO6LzNhOwIBqx2TUxMA-1
Received: by mail-wm1-f72.google.com with SMTP id
 c126-20020a1c3584000000b003cfffcf7c1aso7440535wma.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 08:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lGOBSIFe5pUAxEjRFkRz63QN+FtG9EzKvnfhz76nOw=;
 b=YOZw/xq72cwrKqcqUwFnJ2dY7HCYMvufKSwza5sSlcgXzkxQus5E9qxAvzqS4X8fIo
 qIbcJ1INlaXmj+M64C0PcooeT8xN9n2RhsRoomhGzCCVTSgHB4j4H6WGWAiW/lRUjI5G
 cAV4m2cEk31PXfmr3OomkI/prdDGpU2f9bJaLpXHznzACMn3YZ/DS7GpMiSktUSTxXbC
 LKy72Z/nXTiZtdvFjio0f6YwRYyrhdKIWP2xNwMX/BhwvQW5OErH9Uh0dqAHBkmmBpur
 +BgxRO6FPeLJ4STDPcvzXu2wRsSUbL1ras28vZgUHjPPns/9UpBhNRb+Fn2eZLUypXwP
 ae1w==
X-Gm-Message-State: AFqh2ko9telV+mOi9rsxwWluIKhikuS/kuT35Ko+7Pm+X357b8DyK7m8
 MHsI/Z/SL4gxmpeo8V3hqWEmwYFIZswMBqiR889fN9/PpiRYZ2ck7ezAUF42GYeWKkiSGfglrVf
 wMSvdLHa4Pm2jf/1rUHbxYoj9TpvAJBqJpNoub5j/M/ZSINUR71SvD5KcpUp75oGn/6DgLp9/V6
 jyTprKK16fabOR5+KvSA==
X-Received: by 2002:a5d:6b82:0:b0:254:e300:df10 with SMTP id
 n2-20020a5d6b82000000b00254e300df10mr3175578wrx.0.1671035430334; 
 Wed, 14 Dec 2022 08:30:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtON+i2KOCKckOC+y5p1sstetwPc0ECbYZbXcpC/pxYXEHqSVOOlJPZuP9yMFAhSEmoSjaS2Q==
X-Received: by 2002:a5d:6b82:0:b0:254:e300:df10 with SMTP id
 n2-20020a5d6b82000000b00254e300df10mr3175558wrx.0.1671035430129; 
 Wed, 14 Dec 2022 08:30:30 -0800 (PST)
Received: from step1.redhat.com (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 e17-20020adffd11000000b002422816aa25sm3791759wrr.108.2022.12.14.08.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 08:30:29 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 1/6] vdpa: add bind_mm callback
Date: Wed, 14 Dec 2022 17:30:20 +0100
Message-Id: <20221214163025.103075-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214163025.103075-1-sgarzare@redhat.com>
References: <20221214163025.103075-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

This new optional callback is used to bind the device to a specific
address space so the vDPA framework can use VA when this callback
is implemented.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vdpa.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..34388e21ef3f 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -282,6 +282,12 @@ struct vdpa_map_file {
  *				@iova: iova to be unmapped
  *				@size: size of the area
  *				Returns integer: success (0) or error (< 0)
+ * @bind_mm:			Bind the device to a specific address space
+ *				so the vDPA framework can use VA when this
+ *				callback is implemented. (optional)
+ *				@vdev: vdpa device
+ *				@mm: address space to bind
+ *				@owner: process that owns the address space
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
  */
@@ -341,6 +347,8 @@ struct vdpa_config_ops {
 			 u64 iova, u64 size);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
+	int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm,
+		       struct task_struct *owner);
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
