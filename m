Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F36EC433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F33722C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEf53UHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F33722C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 90D5320531;
	Mon,  3 Aug 2020 21:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EqkDJEUW6LlX; Mon,  3 Aug 2020 21:00:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D4A01204C7;
	Mon,  3 Aug 2020 21:00:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC82BC0050;
	Mon,  3 Aug 2020 21:00:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49542C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3902F858F7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vGqD1wSsNrJ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A13DE844C9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I+p73nl+scMLErwVWZPy2fCb3efmQTrWaZiPCg4cXlI=;
 b=cEf53UHT3GKUxVhfpKHJT50GKHBZJg60hN5262GybkCP0ks+sPqttGiHvfn84Fj5WDAkBR
 YeV12yxDdDEggXANEPLRq1B1heN6xlo6apMRWpvG3BnOXu+wtPnIqj7ctPevGTfethJdYC
 U2y6mawvL0BUu8VgVCnL6fvaOPO/xJU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-c3BwK4v9PTSR48UG5HLObQ-1; Mon, 03 Aug 2020 16:59:58 -0400
X-MC-Unique: c3BwK4v9PTSR48UG5HLObQ-1
Received: by mail-qt1-f199.google.com with SMTP id q7so23947732qtd.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I+p73nl+scMLErwVWZPy2fCb3efmQTrWaZiPCg4cXlI=;
 b=ZdqKzaf6O8NBzWY9pzYZN6qyBlkWy+VBlu5XbzEhDRjin/uzbqdhSDNdHxFQtgnbrL
 HQcUgO+O5wvdUSMjfMiuNlm4p6G7Jgphx0BkhRgbT+5CyE1FtAQrf1AFi+gWko42LSKL
 TGFtiRTu3VyIfwUo1weXfTETgIYgT/YvyHnwFsFUzqIPaZAYZh5IfWgs3UexPl3dh2cI
 eyI0InURxWhDyPBHvBwFrxjvf93nOyBnUTOWTd3fHXHjj6ynuuaenrBcTx3vhoW3lO+K
 Vge9yU5uAo8RwsYWo11cwbFgkZJNzetFUi932kzmpfUhDXfljhHm57GvW26esntkbdQ3
 8Eyw==
X-Gm-Message-State: AOAM532QSAGFhMwHnyXSM8moYnc807G6KdEA3F5Nw7pebuw7ygXypGJz
 +q2JqYO6ureyd4+cTxeVPd+TvZ+kd0chi/1oV8Ipc4HQ3mAES+xBMq2Ce52tvXSPy5y0GIEyI/y
 yA0U2vUqMPUL5bUGttR/8YckZEiEQ2ViV5pwYc7Fw5g==
X-Received: by 2002:a37:8a06:: with SMTP id m6mr17949039qkd.191.1596488397674; 
 Mon, 03 Aug 2020 13:59:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+kFhyjENOmK99izI/iD0vLcf7qIDUTr7k6L/7ugA+5BkNdYKwj7GdM+Gahf0BqUL5tx7Xeg==
X-Received: by 2002:a37:8a06:: with SMTP id m6mr17949024qkd.191.1596488397469; 
 Mon, 03 Aug 2020 13:59:57 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id t35sm23436618qth.79.2020.08.03.13.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:59:56 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:59:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/24] virtio_scsi: correct tags for config space fields
Message-ID: <20200803205814.540410-17-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>
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
 drivers/scsi/virtio_scsi.c       |  4 ++--
 include/uapi/linux/virtio_scsi.h | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 0e0910c5b942..c36aeb9a1330 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -746,14 +746,14 @@ static struct scsi_host_template virtscsi_host_template = {
 
 #define virtscsi_config_get(vdev, fld) \
 	({ \
-		typeof(((struct virtio_scsi_config *)0)->fld) __val; \
+		__virtio_native_type(struct virtio_scsi_config, fld) __val; \
 		virtio_cread(vdev, struct virtio_scsi_config, fld, &__val); \
 		__val; \
 	})
 
 #define virtscsi_config_set(vdev, fld, val) \
 	do { \
-		typeof(((struct virtio_scsi_config *)0)->fld) __val = (val); \
+		__virtio_native_type(struct virtio_scsi_config, fld) __val = (val); \
 		virtio_cwrite(vdev, struct virtio_scsi_config, fld, &__val); \
 	} while(0)
 
diff --git a/include/uapi/linux/virtio_scsi.h b/include/uapi/linux/virtio_scsi.h
index cc18ef8825c0..0abaae4027c0 100644
--- a/include/uapi/linux/virtio_scsi.h
+++ b/include/uapi/linux/virtio_scsi.h
@@ -103,16 +103,16 @@ struct virtio_scsi_event {
 } __attribute__((packed));
 
 struct virtio_scsi_config {
-	__u32 num_queues;
-	__u32 seg_max;
-	__u32 max_sectors;
-	__u32 cmd_per_lun;
-	__u32 event_info_size;
-	__u32 sense_size;
-	__u32 cdb_size;
-	__u16 max_channel;
-	__u16 max_target;
-	__u32 max_lun;
+	__virtio32 num_queues;
+	__virtio32 seg_max;
+	__virtio32 max_sectors;
+	__virtio32 cmd_per_lun;
+	__virtio32 event_info_size;
+	__virtio32 sense_size;
+	__virtio32 cdb_size;
+	__virtio16 max_channel;
+	__virtio16 max_target;
+	__virtio32 max_lun;
 } __attribute__((packed));
 
 /* Feature Bits */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
