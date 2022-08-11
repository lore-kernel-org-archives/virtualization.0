Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED857C19F2D
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DD8A40C62;
	Thu, 11 Aug 2022 08:37:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DD8A40C62
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F4HuLqH2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P7Q0H2s-qSRs; Thu, 11 Aug 2022 08:37:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 153A74025F;
	Thu, 11 Aug 2022 08:37:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 153A74025F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F055BC0033;
	Thu, 11 Aug 2022 08:37:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A93DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36591402E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:37:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36591402E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQr5Vo7oilY9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:37:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B5604025F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B5604025F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660207033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxI8STE90R3MtFxd5bcngd81yGb5pFXt8S9v1lVULlg=;
 b=F4HuLqH2KMPn7CO5SYl9WtSKg7hXp7GhvmA8Anj0cTHAADjwRr7499YdkkMb0y0OakMCx6
 8l+vDY/hPdMLtdzr4JfktxMaU0KXhD2kMKNpioxg8vvwKkbpcOLBky0PEdz0mPaUcG1OCB
 rcOOzyvYPX7HlL43ytoKGtd9gre9kq4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-4UWf8alXNBSM5ylynI8pLQ-1; Thu, 11 Aug 2022 04:37:12 -0400
X-MC-Unique: 4UWf8alXNBSM5ylynI8pLQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 de4-20020a05620a370400b006a9711bd9f8so14225172qkb.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=wxI8STE90R3MtFxd5bcngd81yGb5pFXt8S9v1lVULlg=;
 b=ffR13ZdOEXUXB5AIgN+dTdqlH5TyOwi2FPCr8gCEhI99MoppFAYhMBpyVVwEYcL7Ib
 PSKUWBVg1fzT+RvihE6d0XquPnmvkggiVU4SMordxm6ccdsW0/ZakNGLuXWcH0Rzd+GI
 krnN/dxD4kgT1rwNbYBvG6Sbmk/nf94ddjN42uqXs4JCokrecTRHxokOAjXLl/ydd6ps
 YEN6LTlDKKSCgnTySgW+UI1Mn8n+S7DODiQoXHbPkC8Mpb/u6rQbMQs7A77hZKNCZ+sC
 JJ7iqrglL41lSi+q1y2U+uZPn2QJydaygYoWOgic67T9o6tblpr4Tiz8Iu0onykghYLb
 CCnA==
X-Gm-Message-State: ACgBeo0cr8SheGwOCb2Jyjx+PTyDF+KgLD72lCHdlN/Gmbu9C9AmWcj6
 0WsWWO1K2pgtlIU/WnY/00o6Fvjj8XIYvh1/a3R2QboaydpEJIeyqTZAsk9iw1M6vRDM138UgNK
 Z2sCjZEIVMTlpMqvLBOUviF+QXdIY2lc5+Y8R7TlDF7f7K7ugr8m4InFlj4Pxfl4HUCAEh7GtUZ
 GK3aD7xPeWkymZ+hDyqw==
X-Received: by 2002:a05:622a:1a01:b0:343:310d:fedf with SMTP id
 f1-20020a05622a1a0100b00343310dfedfmr9614056qtb.622.1660207031522; 
 Thu, 11 Aug 2022 01:37:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7iG5hpVQZhHnEux2Ys32Xpb0iTat8U/eI0t5jz6ZCTF9Xjo89LNFBwu9MSbN4hXHLgOHdEhQ==
X-Received: by 2002:a05:622a:1a01:b0:343:310d:fedf with SMTP id
 f1-20020a05622a1a0100b00343310dfedfmr9614035qtb.622.1660207031241; 
 Thu, 11 Aug 2022 01:37:11 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 i14-20020a05620a248e00b006b57b63a8ddsm1485774qkn.122.2022.08.11.01.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:37:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 4/4] vdpa_sim_blk: add support for discard and write-zeroes
Date: Thu, 11 Aug 2022 10:36:32 +0200
Message-Id: <20220811083632.77525-5-sgarzare@redhat.com>
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

Expose VIRTIO_BLK_F_DISCARD and VIRTIO_BLK_F_WRITE_ZEROES features
to the drivers and handle VIRTIO_BLK_T_DISCARD and
VIRTIO_BLK_T_WRITE_ZEROES requests checking ranges and flags.

The simulator behaves like a ramdisk, so for VIRTIO_BLK_F_DISCARD
does nothing, while for VIRTIO_BLK_T_WRITE_ZEROES sets to 0 the
specified region.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 74 +++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 1f18f336cf0c..c8bfea3b7db2 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -30,11 +30,14 @@
 				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
 				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
 				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
-				 (1ULL << VIRTIO_BLK_F_MQ))
+				 (1ULL << VIRTIO_BLK_F_MQ)       | \
+				 (1ULL << VIRTIO_BLK_F_DISCARD)  | \
+				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES))
 
 #define VDPASIM_BLK_CAPACITY	0x40000
 #define VDPASIM_BLK_SIZE_MAX	0x1000
 #define VDPASIM_BLK_SEG_MAX	32
+#define VDPASIM_BLK_DWZ_MAX_SECTORS UINT_MAX
 
 /* 1 virtqueue, 1 address space, 1 virtqueue group */
 #define VDPASIM_BLK_VQ_NUM	1
@@ -193,6 +196,64 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		/* nothing to do */
 		break;
 
+	case VIRTIO_BLK_T_DISCARD:
+	case VIRTIO_BLK_T_WRITE_ZEROES: {
+		struct virtio_blk_discard_write_zeroes range;
+		u32 num_sectors, flags;
+
+		if (to_pull != sizeof(range)) {
+			dev_dbg(&vdpasim->vdpa.dev,
+				"discard/write_zeroes header len: 0x%zx [expected: 0x%zx]\n",
+				to_pull, sizeof(range));
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &range,
+					      to_pull);
+		if (bytes < 0) {
+			dev_dbg(&vdpasim->vdpa.dev,
+				"vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
+				bytes, offset, to_pull);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		sector = le64_to_cpu(range.sector);
+		offset = sector << SECTOR_SHIFT;
+		num_sectors = le32_to_cpu(range.num_sectors);
+		flags = le32_to_cpu(range.flags);
+
+		if (type == VIRTIO_BLK_T_DISCARD && flags != 0) {
+			dev_dbg(&vdpasim->vdpa.dev,
+				"discard unexpected flags set - flags: 0x%x\n",
+				flags);
+			status = VIRTIO_BLK_S_UNSUPP;
+			break;
+		}
+
+		if (type == VIRTIO_BLK_T_WRITE_ZEROES &&
+		    flags & ~VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP) {
+			dev_dbg(&vdpasim->vdpa.dev,
+				"write_zeroes unexpected flags set - flags: 0x%x\n",
+				flags);
+			status = VIRTIO_BLK_S_UNSUPP;
+			break;
+		}
+
+		if (!vdpasim_blk_check_range(vdpasim, sector, num_sectors,
+					     VDPASIM_BLK_DWZ_MAX_SECTORS)) {
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
+			memset(vdpasim->buffer + offset, 0,
+			       num_sectors << SECTOR_SHIFT);
+		}
+
+		break;
+	}
 	default:
 		dev_dbg(&vdpasim->vdpa.dev,
 			"Unsupported request type %d\n", type);
@@ -281,6 +342,17 @@ static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
 	blk_config->min_io_size = cpu_to_vdpasim16(vdpasim, 1);
 	blk_config->opt_io_size = cpu_to_vdpasim32(vdpasim, 1);
 	blk_config->blk_size = cpu_to_vdpasim32(vdpasim, SECTOR_SIZE);
+	/* VIRTIO_BLK_F_DISCARD */
+	blk_config->discard_sector_alignment =
+		cpu_to_vdpasim32(vdpasim, SECTOR_SIZE);
+	blk_config->max_discard_sectors =
+		cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_DWZ_MAX_SECTORS);
+	blk_config->max_discard_seg = cpu_to_vdpasim32(vdpasim, 1);
+	/* VIRTIO_BLK_F_WRITE_ZEROES */
+	blk_config->max_write_zeroes_sectors =
+		cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_DWZ_MAX_SECTORS);
+	blk_config->max_write_zeroes_seg = cpu_to_vdpasim32(vdpasim, 1);
+
 }
 
 static void vdpasim_blk_mgmtdev_release(struct device *dev)
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
