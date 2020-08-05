Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F0C433E1
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97AF2065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFK+bqRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97AF2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4AA78818E;
	Wed,  5 Aug 2020 13:43:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnG4VrN70Dso; Wed,  5 Aug 2020 13:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E6B588177;
	Wed,  5 Aug 2020 13:43:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BCD4C0051;
	Wed,  5 Aug 2020 13:43:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D338C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 02968214FD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cB0QxoQvNOcx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 5B6272051E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTaDCFq9EEd7EtxWljV0ocT/0BezQzutVLOCNJo6y1g=;
 b=PFK+bqRZ0uTHZ8U0znn5bYQI2XerzFG/Zfs6PjlaY4q1iNPL13/AOACjZVGb3KaTwPyOaZ
 4Es+1oemUwT0CJx+nBWF/paCtcsfj8wp0TNy4XxhS9FcEC5hvaf2S5oJOdxuKZ9d4rd1ow
 PZcmmjp8mlQWqVZK57sY/uUqjs4WUYM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-TKXbMuz2PeOaFehcZCJJMQ-1; Wed, 05 Aug 2020 09:43:51 -0400
X-MC-Unique: TKXbMuz2PeOaFehcZCJJMQ-1
Received: by mail-wr1-f70.google.com with SMTP id d6so12034736wrv.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mTaDCFq9EEd7EtxWljV0ocT/0BezQzutVLOCNJo6y1g=;
 b=kB9OAtP5E5qqfAsJLspPYM6LRcqLVDDLujKKIVJXihIdBQWdxNA6p++rUILOQharxV
 zOP2a9cGx9U9FhLnvo/eJxFuZR/FDTJeZP0vhkxFXW6V1aLTXWs2N3bpOOY0si0EnhV2
 fGWsDkQxyKuHYHwVvi+NB4lrD4BupwyMthtxO2A8amyVdlkH5r7EU3tZdDqgvwxdNwhd
 ArQbBxjdF/mL8EovXsHRkX5I8MsGX28E7kV7ry8/W3fscpY0GV3pPExp4cQBUosS9poF
 1vurtlXoEcC0sQ/M+A+ofGIYa9ZvzZwrWNCxv4NDR796TCn1nJeypsR9lsZs2cwZRMfD
 or6Q==
X-Gm-Message-State: AOAM532xYgW0Bw54UgZYkIsJ1w3pw7v08q3nCWeQQJtBW8Vi5bVkuFvn
 C5qTUiEJpsWtS0x8/OrQjFU8JgYi8G6gxHyeUghanx7IRtH2ksBUjqjp2gEySQad7/KYFRe5/Az
 GKHitZucPQTntrvYatXJMckuXmLk7dIR950timAT/sQ==
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr3336551wmf.65.1596635030700; 
 Wed, 05 Aug 2020 06:43:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT1f4LtdHhh5Ky3zKW65+1UGCe/Bl8zMSMSLYR6HxdNcX+9Oze99mEQYLayP5cnoDyV6YEGw==
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr3336534wmf.65.1596635030516; 
 Wed, 05 Aug 2020 06:43:50 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id v16sm634wmj.14.2020.08.05.06.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:43:49 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:43:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/38] virtio_iommu: correct tags for config space fields
Message-ID: <20200805134226.1106164-13-mst@redhat.com>
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org
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
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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
