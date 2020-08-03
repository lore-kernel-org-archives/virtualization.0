Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EE0C433E1
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85C022C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUFb27gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85C022C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5D66020497;
	Mon,  3 Aug 2020 20:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vdupUy73aszo; Mon,  3 Aug 2020 20:59:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8A0502041B;
	Mon,  3 Aug 2020 20:59:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81496C0050;
	Mon,  3 Aug 2020 20:59:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77B61C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6AA6285BD0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6qh3aLZtq0jQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 88E37858F7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ksnf9HBHraqrjZuwYMeAj9n5YSqFyP9eX0KH8vvwtbE=;
 b=LUFb27gnW7hye5vuw1DPf26hA/mi8EyXgxBsWmZOabdSnMCVoKAXkX5RGY/zHzMeu7Bp4M
 IK1Gx3ba9WL1CWFWkREm6xzctwZQrVS6rTejfJUa8YKuK/M8IakWczgL7ss/Y06R5w5TNk
 +8TCCCUkjzQArj/vUVd7/4ouPwh4k7I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-nd-_wPlPPH60jw1MXj7ikw-1; Mon, 03 Aug 2020 16:59:06 -0400
X-MC-Unique: nd-_wPlPPH60jw1MXj7ikw-1
Received: by mail-qt1-f200.google.com with SMTP id d2so24284551qtn.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ksnf9HBHraqrjZuwYMeAj9n5YSqFyP9eX0KH8vvwtbE=;
 b=d6bP187qBL+lBp+c5WTenuJS7QLuXyT1Y10CanCw70vmtee4LEcO7ohAiy/iZSQTiP
 eFUAqCTHefkadHLw2UknrCXak4HkppbleT16vBrkNmtXPTeeW6fnGP4WeWUoTt/GX9mc
 /7XNJJeB3KV/fdFC0UTBiTeieVkXQLlLGn5gl4OJblxvVNdyT8eDRMaPcqk8XnoR5Yd/
 3xtGBcZchym8AIhL/QtELgcOZoEjC1KAe3J6gKEzK0GQKZKU+I4kAPeimUgpk46smdz3
 a/lgGg9eu1P0n90kwRZynpCt39PxfK7536HuIVnRGToynswXY12u56m2B34l1btMWF8T
 h9Wg==
X-Gm-Message-State: AOAM533oL5LkX3WXEl9bggye8/OQ+H+yqBwvAhQ21c+mxkCJU8N9xzaP
 7Bm6t5StJPBHWZQT9/FKDOOLlX7jZ/hiyl+rr3ErIblffpXtbvBiFh0BGCiZz7Lgl0GzBS/PBuw
 P1Io2LBjdrtJ8c9xcjt/foHgr4321x4E9RHGeK5DszA==
X-Received: by 2002:a37:6442:: with SMTP id y63mr18063646qkb.104.1596488344308; 
 Mon, 03 Aug 2020 13:59:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9IYdEeh2Xy0HETgWh/0dS6kL2ee/OlcIiyLeyR5/FPEsY7IGKatLylONrDcpjuvaLFPh86Q==
X-Received: by 2002:a37:6442:: with SMTP id y63mr18063622qkb.104.1596488343966; 
 Mon, 03 Aug 2020 13:59:03 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id w20sm4939699qki.108.2020.08.03.13.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:59:03 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:58:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/24] virtio_blk: correct tags for config space fields
Message-ID: <20200803205814.540410-7-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
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

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_blk.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 0f99d7b49ede..d888f013d9ff 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -57,20 +57,20 @@
 
 struct virtio_blk_config {
 	/* The capacity (in 512-byte sectors). */
-	__u64 capacity;
+	__virtio64 capacity;
 	/* The maximum segment size (if VIRTIO_BLK_F_SIZE_MAX) */
-	__u32 size_max;
+	__virtio32 size_max;
 	/* The maximum number of segments (if VIRTIO_BLK_F_SEG_MAX) */
-	__u32 seg_max;
+	__virtio32 seg_max;
 	/* geometry of the device (if VIRTIO_BLK_F_GEOMETRY) */
 	struct virtio_blk_geometry {
-		__u16 cylinders;
+		__virtio16 cylinders;
 		__u8 heads;
 		__u8 sectors;
 	} geometry;
 
 	/* block size of device (if VIRTIO_BLK_F_BLK_SIZE) */
-	__u32 blk_size;
+	__virtio32 blk_size;
 
 	/* the next 4 entries are guarded by VIRTIO_BLK_F_TOPOLOGY  */
 	/* exponent for physical block per logical block. */
@@ -78,42 +78,42 @@ struct virtio_blk_config {
 	/* alignment offset in logical blocks. */
 	__u8 alignment_offset;
 	/* minimum I/O size without performance penalty in logical blocks. */
-	__u16 min_io_size;
+	__virtio16 min_io_size;
 	/* optimal sustained I/O size in logical blocks. */
-	__u32 opt_io_size;
+	__virtio32 opt_io_size;
 
 	/* writeback mode (if VIRTIO_BLK_F_CONFIG_WCE) */
 	__u8 wce;
 	__u8 unused;
 
 	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
-	__u16 num_queues;
+	__virtio16 num_queues;
 
 	/* the next 3 entries are guarded by VIRTIO_BLK_F_DISCARD */
 	/*
 	 * The maximum discard sectors (in 512-byte sectors) for
 	 * one segment.
 	 */
-	__u32 max_discard_sectors;
+	__virtio32 max_discard_sectors;
 	/*
 	 * The maximum number of discard segments in a
 	 * discard command.
 	 */
-	__u32 max_discard_seg;
+	__virtio32 max_discard_seg;
 	/* Discard commands must be aligned to this number of sectors. */
-	__u32 discard_sector_alignment;
+	__virtio32 discard_sector_alignment;
 
 	/* the next 3 entries are guarded by VIRTIO_BLK_F_WRITE_ZEROES */
 	/*
 	 * The maximum number of write zeroes sectors (in 512-byte sectors) in
 	 * one segment.
 	 */
-	__u32 max_write_zeroes_sectors;
+	__virtio32 max_write_zeroes_sectors;
 	/*
 	 * The maximum number of segments in a write zeroes
 	 * command.
 	 */
-	__u32 max_write_zeroes_seg;
+	__virtio32 max_write_zeroes_seg;
 	/*
 	 * Set if a VIRTIO_BLK_T_WRITE_ZEROES request may result in the
 	 * deallocation of one or more of the sectors.
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
