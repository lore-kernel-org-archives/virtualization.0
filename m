Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1826CC00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 09:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B002140345;
	Wed, 10 Aug 2022 09:44:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B002140345
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RH1SFAqf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZJHpmMANz5yq; Wed, 10 Aug 2022 09:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AD28540327;
	Wed, 10 Aug 2022 09:44:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD28540327
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67AF2C0033;
	Wed, 10 Aug 2022 09:44:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07FC9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6F3B60B8F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:44:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6F3B60B8F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RH1SFAqf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IbuB6jMLYOXl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:44:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09C7660ACA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09C7660ACA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660124659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7/Qe+5eTUGxbNC+s2zlukeDJxV02+FkntfjhZmwiRA=;
 b=RH1SFAqfFEgSEZujQvvi1PXd8rQpk2lsDjH3aXMIGguM8HnX4ZC4YIaRC9sOH1DqgmvRqt
 g40DwRLqsDZTI77N7e8eOZArxgpe3jK649gHP9IRhnKiWcuaZObVSslWfBbMoNNOiRo5vd
 e0JoZ/5aAsQebYpq5/WbJcJjj7MaGgE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-tLDtsXHLNXCEfY0Wx2Uhkw-1; Wed, 10 Aug 2022 05:44:19 -0400
X-MC-Unique: tLDtsXHLNXCEfY0Wx2Uhkw-1
Received: by mail-wm1-f72.google.com with SMTP id
 v24-20020a7bcb58000000b003a37681b861so391016wmj.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 02:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=k7/Qe+5eTUGxbNC+s2zlukeDJxV02+FkntfjhZmwiRA=;
 b=fu1Eb6hB6c1t9JMs4gLoDkxlz2Zy4yPkPJmaIdv3rm7mIIAC87M6nQVK1pSul4JAPH
 PY6U5QJ+LVRVigF2uK5kFbg/AsKprjmDRGCYyoPtJko1JtMbU8wR+ngVFSWGNP0O0pnL
 Tc5b2kcKlndey4LsYDxMjlFcrvobCBdQXWhQEHa7Es7t/9CUKiNWbuoohvAWve2UYVS4
 i1bNO1tHfnZ6nal5sMOXeBr/L9RxJqPU1P7/x1ll78D9fyom2ChlLvWDk+vpBPIhLbhh
 ikpvkKeDk2KZcZnAuZOdlKkclXOQOWoF1t4Y4fL9bKTDy8wG91bpK6zNari1Pa83mUak
 SdMw==
X-Gm-Message-State: ACgBeo0UbL5LgD3mO2fA8NW9IKNajW+eqEChOOyz5pb6ptEBihfmSxrD
 f2fPzIzL9gVvLjAc/Jy6RBwZONFUxSiRMH/lutMl2UgQ2iGkEPN1r0kJFKZhIMGCVN8Q5QnjhjK
 rYPw5w7JwbkMzjULzL9Cp9ZMm4O2VtN0xWQYDcHQg5ILl8hXsTnXOa1tLoGOc9AB8rzYCAfpKGU
 zgvhNACR0M71Y35sV9bg==
X-Received: by 2002:a05:6000:1542:b0:220:603d:ec93 with SMTP id
 2-20020a056000154200b00220603dec93mr17536690wry.73.1660124657636; 
 Wed, 10 Aug 2022 02:44:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6iclGAZJP+HWE3V0NXvbb7Pj7rFr6PGzc2/8kqTzVx9Xl8yB8UdjXdKIphvt2YtlzIaVYsVg==
X-Received: by 2002:a05:6000:1542:b0:220:603d:ec93 with SMTP id
 2-20020a056000154200b00220603dec93mr17536672wry.73.1660124657375; 
 Wed, 10 Aug 2022 02:44:17 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 t188-20020a1c46c5000000b003a327f19bf9sm1729195wma.14.2022.08.10.02.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 02:44:16 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 4/4] vdpa_sim_blk: add support for discard and write-zeroes
Date: Wed, 10 Aug 2022 11:43:47 +0200
Message-Id: <20220810094347.20449-5-sgarzare@redhat.com>
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
index 1f18f336cf0c..db85df1d5073 100644
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
+	case VIRTIO_BLK_T_WRITE_ZEROES:
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
+		sector = vdpasim64_to_cpu(vdpasim, range.sector);
+		offset = sector << SECTOR_SHIFT;
+		num_sectors = vdpasim32_to_cpu(vdpasim, range.num_sectors);
+		flags = vdpasim32_to_cpu(vdpasim, range.flags);
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
+
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
