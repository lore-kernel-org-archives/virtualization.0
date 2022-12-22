Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F697C4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 19:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A92A181F0A;
	Thu, 22 Dec 2022 19:32:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A92A181F0A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gx6YSVPa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZBZaNyyVp5PB; Thu, 22 Dec 2022 19:32:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3958681E1C;
	Thu, 22 Dec 2022 19:32:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3958681E1C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 051E3C0071;
	Thu, 22 Dec 2022 19:32:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28EFBC0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 19:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0DFF41882
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 19:32:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0DFF41882
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gx6YSVPa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PT85YXS3Rg2S
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 19:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0285941831
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0285941831
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671737543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=zap0JwOZPciWQqxrEZrpNo6QM+wJhPmhrAnvkD5DXS8=;
 b=Gx6YSVPaqT+uMNVd4GpvTU7bSeZP9/Y6ga6JtsP6/J2L89bUf8ft1jc5I5Tll1YJgxEtLP
 Ql7gKGLXbVaw03tZOBtctLvaAQ2xTtEXkxenUFZCmv2xmonaacPIyoEL/tc8yBM/QrVT8w
 ofZQbNVrZR3j3IQulDKJvrCLGPj0+7A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-ixlHr471PeChYiziO_kckw-1; Thu, 22 Dec 2022 14:32:21 -0500
X-MC-Unique: ixlHr471PeChYiziO_kckw-1
Received: by mail-wm1-f71.google.com with SMTP id
 r67-20020a1c4446000000b003d09b0fbf54so2722566wma.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 11:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zap0JwOZPciWQqxrEZrpNo6QM+wJhPmhrAnvkD5DXS8=;
 b=JsnxwrpZoYOCjtAM8gwomhgNjGbiUS8Qns6DbvV7qbiPdEGGqlmgd/lu7eJXzLDhsU
 xFBAxSM+xu8OlXaSUX1KbKCvqqopAY7vKrtlT23kjFRGGjbVgRpDC6C/BEEciXn+3e9n
 MBbCoZQzzpufxAW0X8J8ZyEM5DnsOFxBrtzvGIiFTcZffoLCsrY/Wo35BWZUKnVVNK0M
 YcGQv9LLnf0VjmRZDKWyx4lWXZW30UyKI4wZFyJ3WN1a2zs/wVPt7Ece4vAImf9eVa8k
 s788kF90Wvbda5pNp27S3N6dvrKPyjle3mX+OJbMoO2wEb5sRcKmUPqTSablFP0WgyLT
 d3JQ==
X-Gm-Message-State: AFqh2kovJ9+RrTr+87D1V11pSV/1WN8Vtqzwt5qUW6d+uy/jSWcuGj7B
 50JmI0CjoPtC9XMhVrsGpN0Ko6jXXGBy3OgFtoxgZvCsyoYESENhSeg+vMLcN/rWSah9ohKBrxJ
 vwJq6hhw/dRx2dvcH5CRN5r4FoJmDpUTTrjoxwDSNMg==
X-Received: by 2002:a7b:c3c9:0:b0:3d2:e28:647f with SMTP id
 t9-20020a7bc3c9000000b003d20e28647fmr5919276wmj.15.1671737540610; 
 Thu, 22 Dec 2022 11:32:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXssW/ik7XCSyiY9jeoHIpwkMDNZnTvLvGPFUSuKuEA7Q3/AV+A2011ANA99S7Y8nFWZwfD4Yg==
X-Received: by 2002:a7b:c3c9:0:b0:3d2:e28:647f with SMTP id
 t9-20020a7bc3c9000000b003d20e28647fmr5919263wmj.15.1671737540417; 
 Thu, 22 Dec 2022 11:32:20 -0800 (PST)
Received: from redhat.com ([2.55.175.215]) by smtp.gmail.com with ESMTPSA id
 iz17-20020a05600c555100b003d1e1f421bfsm6600067wmb.10.2022.12.22.11.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Dec 2022 11:32:19 -0800 (PST)
Date: Thu, 22 Dec 2022 14:32:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_blk: mark all zone fields LE
Message-ID: <20221222193214.55146-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org
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

zone is a virtio 1.x feature so all fields are LE,
they are handled as such, but have mistakenly been labeled
__virtioXX in the header.  This results in a bunch of sparse warnings.

Use the __leXX tags to make sparse happy.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_blk.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index f4d5ee7c6f30..ec3c3779406f 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -141,11 +141,11 @@ struct virtio_blk_config {
 
 	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
 	struct virtio_blk_zoned_characteristics {
-		__virtio32 zone_sectors;
-		__virtio32 max_open_zones;
-		__virtio32 max_active_zones;
-		__virtio32 max_append_sectors;
-		__virtio32 write_granularity;
+		__le32 zone_sectors;
+		__le32 max_open_zones;
+		__le32 max_active_zones;
+		__le32 max_append_sectors;
+		__le32 write_granularity;
 		__u8 model;
 		__u8 unused2[3];
 	} zoned;
@@ -245,11 +245,11 @@ struct virtio_blk_outhdr {
  */
 struct virtio_blk_zone_descriptor {
 	/* Zone capacity */
-	__virtio64 z_cap;
+	__le64 z_cap;
 	/* The starting sector of the zone */
-	__virtio64 z_start;
+	__le64 z_start;
 	/* Zone write pointer position in sectors */
-	__virtio64 z_wp;
+	__le64 z_wp;
 	/* Zone type */
 	__u8 z_type;
 	/* Zone state */
@@ -258,7 +258,7 @@ struct virtio_blk_zone_descriptor {
 };
 
 struct virtio_blk_zone_report {
-	__virtio64 nr_zones;
+	__le64 nr_zones;
 	__u8 reserved[56];
 	struct virtio_blk_zone_descriptor zones[];
 };
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
