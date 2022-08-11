Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AA9C25B06
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69FA9417A3;
	Thu, 11 Aug 2022 08:36:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69FA9417A3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jsx9V5UM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T6kGfu5zqbqx; Thu, 11 Aug 2022 08:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39A1241758;
	Thu, 11 Aug 2022 08:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39A1241758
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A5C9C0033;
	Thu, 11 Aug 2022 08:36:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCA13C007B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FC5060FAE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FC5060FAE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jsx9V5UM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YULhyrQmWjwo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D10BF60E64
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D10BF60E64
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660207002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxa8o9Tbfqnk5UAsXfKTjPHNDbYRHlKkIXBkapUnTe8=;
 b=Jsx9V5UMKKzJIemgFfVG6rej/ShWav0ed0J+I53fv9XkshPwnPlFY66C/H1Uvu3gG3PDmy
 YbBvQn3srcibT8B4Tv33OPe+s3YUIkU9oShfX3DkrWPsQh7OYKKmViuZiTtgvGNDBJB+fs
 gpTCGHJktgpi9depi9tPWuKX+ePQFYQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-KuKWN7FKPjuVQMRGnS-XIg-1; Thu, 11 Aug 2022 04:36:41 -0400
X-MC-Unique: KuKWN7FKPjuVQMRGnS-XIg-1
Received: by mail-qk1-f198.google.com with SMTP id
 l15-20020a05620a28cf00b006b46997c070so14510133qkp.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=bxa8o9Tbfqnk5UAsXfKTjPHNDbYRHlKkIXBkapUnTe8=;
 b=Fcv4QS8dkwo4kRid1zVRUcP9CewAFMzhXWNTn+d9tUCY9bImlkS/tQBY4JTqO0pRIS
 VE1yoEM3Z7Q1fCCGZ9skNargA3/2rVO9j8zoHzWn/HthuPAj8xvUs4LEwDnq6BRnU3kt
 QRekcsbGW7B1XuYsKa1Y6Ys6bkYuEmxg9R1cVmRQCvh4ZJNZSkNBHdeSORJH+4CC6an+
 AVFc0CXX8bpaW7gom9KIqe1gCpCX6LVWSCdyitmPwg6yVSjz3U74Nsd6OjToACpG6yAH
 5de80O4kRx4pj/IjfgH18EQSfsmPuHmRtV8XdMxqLPBCgKh6GVYwvffVx2UbS6CjqQTc
 a4/Q==
X-Gm-Message-State: ACgBeo1N54TAgeIom/b8Nx2sPWg4z9XVWfYYXWfvPATlhbOBvi5Nk7Mg
 rFt2a9wmoD3VHfUNd22vZFEw3D6C1E0XH7bH51ahM710ngpi/QmXBULgo8zJhUNvwXwnJJMv4Eb
 imDX8SdKk651/aLpavJnn1z5hh6bE/JughKtZUXLMf7bixFODUD7yvWO6lycbiQj/ZQp/H2Ybj3
 KCa5XH2zXze0Hw+SwcVQ==
X-Received: by 2002:a05:620a:2615:b0:6b9:29a9:b734 with SMTP id
 z21-20020a05620a261500b006b929a9b734mr17656853qko.273.1660207000658; 
 Thu, 11 Aug 2022 01:36:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR57hP3DZIXEgM1Y5p0tV6h36y995LYZumXLSlAhdlc1snP7yqGxy4qnrXwGh6eXY8qYNOBP7A==
X-Received: by 2002:a05:620a:2615:b0:6b9:29a9:b734 with SMTP id
 z21-20020a05620a261500b006b929a9b734mr17656841qko.273.1660207000404; 
 Thu, 11 Aug 2022 01:36:40 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 ga25-20020a05622a591900b0034361fb2f75sm1343083qtb.22.2022.08.11.01.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:36:39 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 1/4] vdpa_sim_blk: check if sector is 0 for commands other
 than read or write
Date: Thu, 11 Aug 2022 10:36:29 +0200
Message-Id: <20220811083632.77525-2-sgarzare@redhat.com>
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

VIRTIO spec states: "The sector number indicates the offset
(multiplied by 512) where the read or write is to occur. This field is
unused and set to 0 for commands other than read or write."

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index ba253f8bce32..69c9f4f36f9a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -112,6 +112,15 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	offset = sector << SECTOR_SHIFT;
 	status = VIRTIO_BLK_S_OK;
 
+	if (type != VIRTIO_BLK_T_IN && type != VIRTIO_BLK_T_OUT &&
+	    sector != 0) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"sector must be 0 for %u request - sector: 0x%llx\n",
+			type, sector);
+		status = VIRTIO_BLK_S_IOERR;
+		goto err_status;
+	}
+
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
 		if (!vdpasim_blk_check_range(sector, to_push)) {
@@ -178,6 +187,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 	}
 
+err_status:
 	/* If some operations fail, we need to skip the remaining bytes
 	 * to put the status in the last byte
 	 */
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
