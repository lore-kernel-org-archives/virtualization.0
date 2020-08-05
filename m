Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A7EC433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0F32065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+QHFi/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0F32065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 846988666C;
	Wed,  5 Aug 2020 13:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qt4-wjQG4qcq; Wed,  5 Aug 2020 13:43:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E96DA84836;
	Wed,  5 Aug 2020 13:43:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB272C0051;
	Wed,  5 Aug 2020 13:43:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D503C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 49A1F2083F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xuRblWf-rdsw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id F177520768
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9jhUCzJG3d5qzZf8hbOT7t6D5kO04BfJCWtdPEBjeI=;
 b=M+QHFi/WxXMEnXPHn11GkROuqn+JNllhzPMPVVWWahxZ0ozHrV+GCiNHSqZnhXowkAmMTQ
 395r2u8LPYSQid9MquNIA2Vua5/OSeFthDT0uCQSSLVSkaFrD7aOl4+3bcKMaAkiWNdWK/
 VxCTdPzPiAJm+yLYMr1JfgoAHZSkqm4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-biTbdefqOK6JwxF2Xbs8qQ-1; Wed, 05 Aug 2020 09:43:34 -0400
X-MC-Unique: biTbdefqOK6JwxF2Xbs8qQ-1
Received: by mail-wr1-f71.google.com with SMTP id e14so10116886wrr.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F9jhUCzJG3d5qzZf8hbOT7t6D5kO04BfJCWtdPEBjeI=;
 b=khR8AYSW0Syy1Wweu+Ed+DzGGYKy0K0Sqd+5nqFutP0ATtU1V2HEgUu0Az943iMkch
 fb/FjJ/wOCkWF8l/YxwHQ24C940nECAJsKbCBO7GSlSxpRaDgME+5+WJNusomm700djW
 pds1lJfBsQsBKhTjfnoIiUF8qZmEHjqr1KdAACb1txbA1VzJcxkaREdvlt03pjwGYW0h
 G5B4UT7Wiq1iuACOfT7llxJyNz81FYM6X0aWxlOS83R0baStsjkcEoGAceiVnErfUTzo
 +XpZOM0vVJ3MycEETNZboztFlJ1/fIe9kTMO7HuIhgDq4wY86t96c7jAo6zfIU+F0Blv
 filg==
X-Gm-Message-State: AOAM530JXRb7YZT3UZ5NN6SgQ93mbeQP/DEbHlKwim0XSxe57Elo5Kbj
 INHnKV0EYKiWxK2yQAX39CkW3VwubOFAN2FPkPsCdl7fzVnhY/0FYy3Q6wFUAuWq0frXnEUdf3C
 fvbgsmCeKnH0AacxNfu0AvvYuTTULKyRvSE+gzZ4+MA==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr2969674wrn.10.1596635013755;
 Wed, 05 Aug 2020 06:43:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfXfkwVyl/Yt6AwMxy0nKXq0LBvruLr2Su9H68DLB9XOWjMZCC4BO0f4hY/ktMSHKoTxRjuA==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr2969643wrn.10.1596635013338;
 Wed, 05 Aug 2020 06:43:33 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 y203sm2956845wmc.29.2020.08.05.06.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:43:32 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:43:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/38] virtio_blk: correct tags for config space fields
Message-ID: <20200805134226.1106164-7-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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
