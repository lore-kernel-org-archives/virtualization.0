Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E3EC433DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A362F22C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFF/k5Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A362F22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F28E85C9E;
	Mon,  3 Aug 2020 20:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DPz56rVNyw9L; Mon,  3 Aug 2020 20:59:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F0BD38557B;
	Mon,  3 Aug 2020 20:59:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD0CBC0050;
	Mon,  3 Aug 2020 20:59:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA750C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DE64820482
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Yxe0VE-56KU
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id D1A1A204CB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1xI/ZbWF2py8QNl8K4JvYs5q6EbwT+mCnh8MoqYwvB8=;
 b=fFF/k5HtgospneUQ+q4pSYX+vihS62/ZCBS1wyD9EcpPRHlb1OfpVcjnfv4E3eDCR0Mxkz
 3NaBkYSZvxhHq7PJVdsh5ZjJOOJof2bLOzYBo0iUoKKEIH5ItqM1VcbuQXc0G0smZPw3Ev
 tcFoJhtW4uaWDOqShbT+pUGRNhsIqt0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-rCsueNW7N26zjSZGOWhqag-1; Mon, 03 Aug 2020 16:59:32 -0400
X-MC-Unique: rCsueNW7N26zjSZGOWhqag-1
Received: by mail-qk1-f199.google.com with SMTP id 1so13761239qki.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1xI/ZbWF2py8QNl8K4JvYs5q6EbwT+mCnh8MoqYwvB8=;
 b=TW7DxlxXrmMnFWpsYd9R1bhvQRCdRC+3ZWwckHNtOk2qIWJR3BjsPu9j0MobL1tLLk
 UVefUVKSm2oJT+zy3Hl4efB/bh0qLxK9WeajGLrBykzhyAX/s/BkJ/KakTvNYGLvKdh4
 hL8hPMadLU/VVNukfyHkse7cFwHc4VrAQy/sknRCnhti9KB7a9mXLi8n6y4O4zlM8b9j
 ySz5P+0acet68PjpVTvxyBB7KV+QCG0UL/AtO0wop1Y1q/yj5lJjiih+xiiNYIYlSFVn
 ERwo5FAkcgqaz7+RZYx1JUaZwwP7096vx2+6Lm2P11VuFQPe3oF/SouWEqfLWvLdxyR3
 c9ig==
X-Gm-Message-State: AOAM533aYHwStl9XEel5AauEXNQWhlUoWQRdE0z8AD2qbK0NpvD80+6s
 QUue34WalnaHK2d+Arwm1QS0++aAiOBlk7BhNiASZRiuT4mb6p1JyaEEyFx4Ci2QhkbYOgv9fPy
 40PeHP2sH2mEHqKwkIpiL3BpMRj+VOPMJERnksJ4blw==
X-Received: by 2002:a05:6214:2a4:: with SMTP id
 m4mr19500146qvv.120.1596488371967; 
 Mon, 03 Aug 2020 13:59:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynR48xJ6D4DOziFIFJBOXMH9jlnKkDjS+iRN3OJhEHYTDmDbmB5mxmE4Lvgl56jXzaOzntUQ==
X-Received: by 2002:a05:6214:2a4:: with SMTP id
 m4mr19500129qvv.120.1596488371743; 
 Mon, 03 Aug 2020 13:59:31 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id b23sm19696745qtp.41.2020.08.03.13.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:59:31 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:59:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/24] virtio_iommu: correct tags for config space fields
Message-ID: <20200803205814.540410-13-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
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

Since this is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_iommu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 48e3c29223b5..237e36a280cb 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -18,24 +18,24 @@
 #define VIRTIO_IOMMU_F_MMIO			5
 
 struct virtio_iommu_range_64 {
-	__u64					start;
-	__u64					end;
+	__le64					start;
+	__le64					end;
 };
 
 struct virtio_iommu_range_32 {
-	__u32					start;
-	__u32					end;
+	__le32					start;
+	__le32					end;
 };
 
 struct virtio_iommu_config {
 	/* Supported page sizes */
-	__u64					page_size_mask;
+	__le64					page_size_mask;
 	/* Supported IOVA range */
 	struct virtio_iommu_range_64		input_range;
 	/* Max domain ID size */
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
-	__u32					probe_size;
+	__le32					probe_size;
 };
 
 /* Request types */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
