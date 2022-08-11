Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDDAC19F2D
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EAA34181D;
	Thu, 11 Aug 2022 08:36:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EAA34181D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ISLJT3lC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XAyiECmnOwQM; Thu, 11 Aug 2022 08:36:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 119C6417A9;
	Thu, 11 Aug 2022 08:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 119C6417A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DFE3C007C;
	Thu, 11 Aug 2022 08:36:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E824FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBDBD4025F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBDBD4025F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ISLJT3lC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5EMzCXCZkefq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C30740C3D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C30740C3D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660207005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38oYZZo5oxfiL5gDqzJLWx2Nj0BFm9A6p9CXqcxwNdc=;
 b=ISLJT3lCesclX3PAsnXSYt8oXrkcN/QDAMG/5S6BRpRWSD/6vLh+d3yLg6/H87Sse7yrEJ
 tcZlRFwV7Hox1/GrSAX/x2+MGIHTO1QtB8DSBUGoBnkjVCOv14aPggtsq4q+coOs1Qn/KI
 0JTu/VAKNnJWiMhKJoKwHntQ3ZBZc+8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-iw28MT_vNBqVcGjEwPpeJQ-1; Thu, 11 Aug 2022 04:36:44 -0400
X-MC-Unique: iw28MT_vNBqVcGjEwPpeJQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 cv14-20020ad44d8e000000b004760bec67a8so9100525qvb.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=38oYZZo5oxfiL5gDqzJLWx2Nj0BFm9A6p9CXqcxwNdc=;
 b=v+xQ6itRS/28eFmAHU0pN41QG06htf3R1B6qfWNPIlXv1WlysezN0TpmGzEfXHOCZU
 9YPMCre5fvUQK1KfXSJTJ+EmC65xzN9/qJxjaXRwtPnKo0K/g4+8K3W2y33gixgnEM7c
 3roGktPNGNiQRMi2LopkpKggQrbKdqHvaLm1UsFt4wrE7TzfytzrUt9WXYE6SAJoIwvk
 hfRFt0pRoC/6k4ZclVnTmrAYNXcF4jF8HMvz3SdZoTAnoShz8SiRC2VcApCQ2pggMc3Z
 iqNxiiQigC8s8ZlYEcUtOWWF/YLMPa32y6yY71SQvy3Noe/jK0WUZqM7pWPCbTWK1y3f
 vKNA==
X-Gm-Message-State: ACgBeo3u8DKCwIkj49Mb3AFRmliT22VIrbG+B/ZRkdvW8fBOrvZN8SoE
 NrFO1v0LF7WyDPsXn1vOW53eSJNhSsLvsV0lADa/nyrMzI/8ViMCEGkA9wZz8miEafk8sJD7ynv
 bF1pqR/fIrw0TConPPUzOxqt0ycJCRmywGsC573sva2POcN1Ds/Wm93ofI6qLvEbKUD6exfOImB
 ksa7lENNC6xI+hlvAdgQ==
X-Received: by 2002:a05:620a:288c:b0:6b3:9d1:dbf1 with SMTP id
 j12-20020a05620a288c00b006b309d1dbf1mr23327378qkp.593.1660207003294; 
 Thu, 11 Aug 2022 01:36:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR710n4edD3BI5O94vesCWGnN3jpA1lgY7qh5Pnj63dORRorlN4QFNOHDWfrAS62HS8gTf/NcA==
X-Received: by 2002:a05:620a:288c:b0:6b3:9d1:dbf1 with SMTP id
 j12-20020a05620a288c00b006b309d1dbf1mr23327364qkp.593.1660207002990; 
 Thu, 11 Aug 2022 01:36:42 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 ga25-20020a05622a591900b0034361fb2f75sm1343083qtb.22.2022.08.11.01.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:36:42 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 2/4] vdpa_sim_blk: make vdpasim_blk_check_range usable by
 other requests
Date: Thu, 11 Aug 2022 10:36:30 +0200
Message-Id: <20220811083632.77525-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811083632.77525-1-sgarzare@redhat.com>
References: <20220811083632.77525-1-sgarzare@redhat.com>
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

Next patches will add handling of other requests, where will be
useful to reuse vdpasim_blk_check_range().
So let's make it more generic by adding the `max_sectors` parameter,
since different requests allow different numbers of maximum sectors.

Let's also print the messages directly in vdpasim_blk_check_range()
to avoid duplicate prints.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 38 +++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 69c9f4f36f9a..24dd9cae6450 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -42,18 +42,28 @@
 
 static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
 
-static bool vdpasim_blk_check_range(u64 start_sector, size_t range_size)
+static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
+				    u64 num_sectors, u64 max_sectors)
 {
-	u64 range_sectors = range_size >> SECTOR_SHIFT;
-
-	if (range_size > VDPASIM_BLK_SIZE_MAX * VDPASIM_BLK_SEG_MAX)
-		return false;
+	if (start_sector > VDPASIM_BLK_CAPACITY) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"starting sector exceeds the capacity - start: 0x%llx capacity: 0x%x\n",
+			start_sector, VDPASIM_BLK_CAPACITY);
+	}
 
-	if (start_sector > VDPASIM_BLK_CAPACITY)
+	if (num_sectors > max_sectors) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"number of sectors exceeds the max allowed in a request - num: 0x%llx max: 0x%llx\n",
+			num_sectors, max_sectors);
 		return false;
+	}
 
-	if (range_sectors > VDPASIM_BLK_CAPACITY - start_sector)
+	if (num_sectors > VDPASIM_BLK_CAPACITY - start_sector) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"request exceeds the capacity - start: 0x%llx num: 0x%llx capacity: 0x%x\n",
+			start_sector, num_sectors, VDPASIM_BLK_CAPACITY);
 		return false;
+	}
 
 	return true;
 }
@@ -123,10 +133,9 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
-		if (!vdpasim_blk_check_range(sector, to_push)) {
-			dev_dbg(&vdpasim->vdpa.dev,
-				"reading over the capacity - offset: 0x%llx len: 0x%zx\n",
-				offset, to_push);
+		if (!vdpasim_blk_check_range(vdpasim, sector,
+					     to_push >> SECTOR_SHIFT,
+					     VDPASIM_BLK_SIZE_MAX * VDPASIM_BLK_SEG_MAX)) {
 			status = VIRTIO_BLK_S_IOERR;
 			break;
 		}
@@ -146,10 +155,9 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 
 	case VIRTIO_BLK_T_OUT:
-		if (!vdpasim_blk_check_range(sector, to_pull)) {
-			dev_dbg(&vdpasim->vdpa.dev,
-				"writing over the capacity - offset: 0x%llx len: 0x%zx\n",
-				offset, to_pull);
+		if (!vdpasim_blk_check_range(vdpasim, sector,
+					     to_pull >> SECTOR_SHIFT,
+					     VDPASIM_BLK_SIZE_MAX * VDPASIM_BLK_SEG_MAX)) {
 			status = VIRTIO_BLK_S_IOERR;
 			break;
 		}
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
