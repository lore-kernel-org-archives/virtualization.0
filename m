Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8DBC433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FB122D05
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htXQy5FB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FB122D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A7EAA2034F;
	Wed,  5 Aug 2020 13:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kkb71kUZ3pof; Wed,  5 Aug 2020 13:44:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7FC09214FD;
	Wed,  5 Aug 2020 13:44:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D764C088E;
	Wed,  5 Aug 2020 13:44:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED9F6C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DCF0386BEC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QcOT8PvjCccR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 31213875BD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XBRZHl7JCJFhcfupZL8iAhY/apUMRtB5oC1LWGAgU4A=;
 b=htXQy5FBEfCJ3fjuJVA9BToWJiipa+Zo7cjZbo2QRIpgE7PENdOchUx6UMmhfHCXXOgFbi
 vCVTRQ6oe+N0ScIYKNr69nFcQv2a/LY4lCqLELe6rVc5oE12ZBfhV8AO29X5bb6+GMzLar
 w73+w3O4h7mbReJBOIvzOIXNZci02IA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-M-5FxtUsMVihhqrQFGOr_A-1; Wed, 05 Aug 2020 09:44:03 -0400
X-MC-Unique: M-5FxtUsMVihhqrQFGOr_A-1
Received: by mail-wr1-f70.google.com with SMTP id w7so11246207wre.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XBRZHl7JCJFhcfupZL8iAhY/apUMRtB5oC1LWGAgU4A=;
 b=JjZ/xH4TXcVGejmAKH2lx4BxAF00p9CrsTDWx/2WXuQ/luZiG0ZnBiEy2E8sjCp2c3
 6gSmLNKAEVLN14eg9+gIohy8Dv5ah9KcVJvs5c+nXQwv+c3/Zavq7Fi1ncZIlVI7LoFO
 PLIJq+afAEc7VB756YKXEQoV3eOr7b65Ji2eXSPkPdcMl0LKMIOOS87CSlXVYI1ZVe7i
 WOog0y4j8252Ykzs9DKjuCk+F2pY/O966uf4xAsia7M79SHMHmDw6t1DN6xWbLbS7ryV
 5tqXlKymmq/fOmX5gaQR7ezpelwwrAsZPqmuv3p8aEcatD0O5zbU5jFQcWTWqopmWaJr
 +VcA==
X-Gm-Message-State: AOAM533RJldS0VU30ibvu3hCbu/nw6ApOZgeHVPqGtLWfPL8PjbGU00q
 1/QllXq/LBHCzPW5EWnW/Tq3CSzddyD2/M2DAFbl5gUhC+J3mPgHDdkXHy4iuilIsTBF/YUvAkz
 eLr/XEUYF5BuzfrTkd7n3SQeNUqpZGBW1ZQu+cQt3IA==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr3291797wml.35.1596635042166; 
 Wed, 05 Aug 2020 06:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDiytpas+5HWe7CFND1zqnudLwtNEfOy8SdQ5eObOxwbDWWrns+xYAUPDW5UZJfGlbiTGXfw==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr3291789wml.35.1596635041995; 
 Wed, 05 Aug 2020 06:44:01 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 x2sm3035450wrg.73.2020.08.05.06.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:01 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:43:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/38] virtio_scsi: correct tags for config space fields
Message-ID: <20200805134226.1106164-17-mst@redhat.com>
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
Cc: linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org,
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
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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
