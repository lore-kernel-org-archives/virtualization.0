Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8981C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:59:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC2560F92
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CC2560F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 564ED4016A;
	Mon, 25 Oct 2021 07:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1JNOAZhTbbd5; Mon, 25 Oct 2021 07:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E27B740140;
	Mon, 25 Oct 2021 07:59:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4FEEC0012;
	Mon, 25 Oct 2021 07:59:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23DB1C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BE9180D14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WKdSNHQIo3RO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:59:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1E9F80D0A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635148740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=dK/mYm1FrF9rRdNv3QxeLeadP1lFYA8IS+ck5qZJT8M=;
 b=bm6TNLNof5zDpICi7sVDSlGJkRw4/oB/eQNN8mhffcKg+5urd3CNNbLQxlVX/i3RJdAe0N
 nsD8lmhHw0NlI0Z5Hs7C27TCnKLTKmsb8bUN+gja6fxYv065FhCuITnQ2+lyMFIwgiLZrQ
 6zeNwtnbt6trxOOF4r6v2Ei+o+cAIDk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-A-wFFzKDPwuLSh-DaETZ5g-1; Mon, 25 Oct 2021 03:58:59 -0400
X-MC-Unique: A-wFFzKDPwuLSh-DaETZ5g-1
Received: by mail-ed1-f70.google.com with SMTP id
 f4-20020a50e084000000b003db585bc274so9026691edl.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 00:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=dK/mYm1FrF9rRdNv3QxeLeadP1lFYA8IS+ck5qZJT8M=;
 b=fpn0slaA/KnezilEJhqpEVq5LfLAEFsaYigco7ziAsLDv4K6Xr2jYi2LtMjIeDkMSP
 Ci/92kAyk7bUz+pqp+Pl6XclzsbF0J3DNJUr8ezHBaKHr826mqZ55Paumin7y413YDvg
 5I4c9bb6N++LPa3Q/c19FLmg9KjovjV5e4uzpsrVILNwkpROIZn2i/gP94xqNzYM8ewR
 T/xowl+iJmnz6aN/yknPw3B5olhV4aW+LTLGTtTIxtojV36nGFgK9qgg4TmHrdnP2OPl
 vseSgFlWuUxKIY7x5ekCrmqRPOT8EMmEpmClbDUH1i3E+r2r/iIkDSzJdyqwRaSB7goG
 b9nQ==
X-Gm-Message-State: AOAM532RGa+Dr4kfN2J5C6+3z5HfQ5k+ILNKGmpbZats8x+VsF7/4AYu
 DtTaNh1kiExdmz+XoX1QtAxEPRSaTSfdjndbjr+QF/z0tSijo/rw45mB3J/AOnD2HSTkM05bJbO
 IKympu+xvPb5R4OmeTcSmDD+FkMHqdhEEklkW/8UZNw==
X-Received: by 2002:a17:906:2a06:: with SMTP id
 j6mr20748786eje.401.1635148738308; 
 Mon, 25 Oct 2021 00:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8iS3IW2Yyq5Wb5XfIh0GRJczmyMiooQOgTEZEvApX2TIFLEIbhNiwxogw2Hx7VOkTSCCg/A==
X-Received: by 2002:a17:906:2a06:: with SMTP id
 j6mr20748761eje.401.1635148738124; 
 Mon, 25 Oct 2021 00:58:58 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
 by smtp.gmail.com with ESMTPSA id u14sm8581172edj.74.2021.10.25.00.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 00:58:57 -0700 (PDT)
Date: Mon, 25 Oct 2021 03:58:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_blk: corrent types for status handling
Message-ID: <20211025075825.1603118-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 kernel test robot <lkp@intel.com>, Israel Rukshin <israelr@nvidia.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Feng Li <lifeng1519@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

virtblk_setup_cmd returns blk_status_t in an int, callers then assign it
back to a blk_status_t variable. blk_status_t is either u32 or (more
typically) u8 so it works, but is inelegant and causes sparse warnings.

Pass the status in blk_status_t in a consistent way.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c336d9bb9105..c7d05ff24084 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -208,8 +208,9 @@ static void virtblk_cleanup_cmd(struct request *req)
 		kfree(bvec_virt(&req->special_vec));
 }
 
-static int virtblk_setup_cmd(struct virtio_device *vdev, struct request *req,
-		struct virtblk_req *vbr)
+static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
+				      struct request *req,
+				      struct virtblk_req *vbr)
 {
 	bool unmap = false;
 	u32 type;
@@ -317,14 +318,15 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	unsigned long flags;
 	unsigned int num;
 	int qid = hctx->queue_num;
-	int err;
 	bool notify = false;
+	blk_status_t status;
+	int err;
 
 	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
 
-	err = virtblk_setup_cmd(vblk->vdev, req, vbr);
-	if (unlikely(err))
-		return err;
+	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	if (unlikely(status))
+		return status;
 
 	blk_mq_start_request(req);
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
