Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294CDC433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:24:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BF164F67
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BF164F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5FC232C35C;
	Thu,  4 Feb 2021 17:24:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cS+kLEO-EtCa; Thu,  4 Feb 2021 17:24:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9BB7B27A4E;
	Thu,  4 Feb 2021 17:24:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87821C07FD;
	Thu,  4 Feb 2021 17:24:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A447C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 42C5F29C87
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CBUzkbsKeS1u
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:24:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 9315027A4E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612459480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4j9zpih3Ykwem+k26aYRkULpCXmZClGuMDmmSgi8w0A=;
 b=e9JaO/w0KPBNxB+Lwu5yjfQ2FMl43/nE8SYrMsKVIxscwp8jMFZJsOcO/m0sLGFtt4akFA
 sGIgoaM7Vllf69/8DrhLa5pIEoOGEqpN1Knt3TpEKTuA6An3Mo5I1PpxS/wVug0gcm9nIH
 4mnIADWI4bhAKPAmdv59Fz4xW0Jn8sI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-o2Nj-lmQOB2Y9X-alkiFkw-1; Thu, 04 Feb 2021 12:24:37 -0500
X-MC-Unique: o2Nj-lmQOB2Y9X-alkiFkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625298799ED;
 Thu,  4 Feb 2021 17:24:35 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-213.ams2.redhat.com
 [10.36.113.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA8B35C3FD;
 Thu,  4 Feb 2021 17:24:30 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 13/13] vdpa_sim_blk: handle VIRTIO_BLK_T_GET_ID
Date: Thu,  4 Feb 2021 18:22:30 +0100
Message-Id: <20210204172230.85853-14-sgarzare@redhat.com>
In-Reply-To: <20210204172230.85853-1-sgarzare@redhat.com>
References: <20210204172230.85853-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Handle VIRTIO_BLK_T_GET_ID request, always answering the
"vdpa_blk_sim" string.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- made 'vdpasim_blk_id' static [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 2652a499fb34..4e4112dda616 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -37,6 +37,7 @@
 #define VDPASIM_BLK_VQ_NUM	1
 
 static struct vdpasim *vdpasim_blk_dev;
+static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
 
 static bool vdpasim_blk_check_range(u64 start_sector, size_t range_size)
 {
@@ -152,6 +153,20 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 		break;
 
+	case VIRTIO_BLK_T_GET_ID:
+		bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
+					      vdpasim_blk_id,
+					      VIRTIO_BLK_ID_BYTES);
+		if (bytes < 0) {
+			dev_err(&vdpasim->vdpa.dev,
+				"vringh_iov_push_iotlb() error: %zd\n", bytes);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		pushed += bytes;
+		break;
+
 	default:
 		dev_warn(&vdpasim->vdpa.dev,
 			 "Unsupported request type %d\n", type);
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
