Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3B7C25B06
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 09:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CD5160D80;
	Wed, 10 Aug 2022 09:44:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CD5160D80
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ScIQAoz8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WNZLujxJtI6Z; Wed, 10 Aug 2022 09:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6EFE60B8F;
	Wed, 10 Aug 2022 09:43:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6EFE60B8F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E19FBC007F;
	Wed, 10 Aug 2022 09:43:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 718ABC0033
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5117E60D63
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5117E60D63
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GHCWwRnm2D3B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FA2460ACA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FA2460ACA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660124636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38oYZZo5oxfiL5gDqzJLWx2Nj0BFm9A6p9CXqcxwNdc=;
 b=ScIQAoz8opntk0i4mjwVMYcnXSeZ/JokK2r9/iIy5r29AlmHRvRvFaFMvUtFHM9+7XsuYl
 UYA6EJMlz/f4Yi6DyW0rXxzwdO7kZot/j0W+sUqYN64DMVlt1/xIp3CYNEIldLXYK+BClW
 J4iLVCUvFKefnLsxMkUCpVhOE0WkDG8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-173-Q7BnYHGZMFqy_G87dQ75wQ-1; Wed, 10 Aug 2022 05:43:55 -0400
X-MC-Unique: Q7BnYHGZMFqy_G87dQ75wQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 b16-20020a05600c4e1000b003a5a47762c3so1428205wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 02:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=38oYZZo5oxfiL5gDqzJLWx2Nj0BFm9A6p9CXqcxwNdc=;
 b=TGELIW+ndQWfSoQsO4QR4SvMyFrkW0cHvr45Era1W5I27gCKyG+cgtr2DcA9XovmfH
 uZr7QnLzv+0gH4nV0WazouQOU3rwVJ9Fzu8HD6lE8KzAOexO2JEBDmhOv6lvKq2B8VxR
 L5NgdxWXhUQE9WrImiWC1aPZFMazRuOe7o5sXO8/bWAzOYHkniwLS75jw191WBY8I9f6
 YVJzq/xmeaj4iKnlv/qhoIxrC4Cw4u5BujKVdyPDTZTVzursEQQK6R3nvekV3whffu8V
 VbbXeiNDBcTRpbeLrB6FFZtxnZc/onf3jKXqPeKoGCLDHvmyzgL6mD9t5U4ynarJZ1Lp
 /hkg==
X-Gm-Message-State: ACgBeo23vA3hrmgRuA47rFBMLfKJJXYJQ2RvcAIIx4ygiUniEqJRKtB9
 sVGSTOaghcTve6H0GkhW51bWlH9b+2Y6NZMTkNjjRh0PzDrr9lCfwXhsFRCQdIJbQlew5IN+TJo
 WUiNqhMwDAT+unxq4KOOqUQ5Z8meENVkZUu53riKC+6Anv77PlYaqDWfCmtAGUOv5T5IbfW2qdn
 DihcaV+Iw6YqOhtFSPvg==
X-Received: by 2002:a05:600c:4fc9:b0:3a3:3537:1726 with SMTP id
 o9-20020a05600c4fc900b003a335371726mr1807914wmq.26.1660124633975; 
 Wed, 10 Aug 2022 02:43:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6+x6w6khhisrJ7VVikYRvP5aWnDOo2jZbJ9hkj27Qmee0ul8zS76kXeQOyfuD1Ht+pNk6ezA==
X-Received: by 2002:a05:600c:4fc9:b0:3a3:3537:1726 with SMTP id
 o9-20020a05600c4fc900b003a335371726mr1807903wmq.26.1660124633749; 
 Wed, 10 Aug 2022 02:43:53 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 q11-20020a5d658b000000b0021e4bc9edbfsm12921743wru.112.2022.08.10.02.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 02:43:52 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/4] vdpa_sim_blk: make vdpasim_blk_check_range usable by
 other requests
Date: Wed, 10 Aug 2022 11:43:45 +0200
Message-Id: <20220810094347.20449-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810094347.20449-1-sgarzare@redhat.com>
References: <20220810094347.20449-1-sgarzare@redhat.com>
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
