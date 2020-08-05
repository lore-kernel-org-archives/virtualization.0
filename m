Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C038DC433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:45:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910022065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzAZTo55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910022065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E3F488275;
	Wed,  5 Aug 2020 13:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j233o9zQt5AL; Wed,  5 Aug 2020 13:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EF7B88823A;
	Wed,  5 Aug 2020 13:45:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2FD1C0051;
	Wed,  5 Aug 2020 13:45:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF9E5C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DC6DB868BE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:45:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c1N01mMKeFOQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:45:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 52F358688F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b15p4KXARwEoNlM1WPMg2pSx9ElZxt97JOcTPOVUe28=;
 b=GzAZTo5563V04HdZeYLUVjzEi9aVlzazZ7ISGud9vUTOY68055Bh41p9ohgxuzx7/vqoAY
 IMoXzO1iJCPaSiAlPRQce/mmik/QA9EP8wSxy3vHap3tIPfRXRxdzBP15Y/aWsKd9TSIY9
 6+YVEismahF29MW5MGiDc9k6fQzuhQk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-giS5VMpxP7up1b94LGFFHA-1; Wed, 05 Aug 2020 09:44:57 -0400
X-MC-Unique: giS5VMpxP7up1b94LGFFHA-1
Received: by mail-wr1-f70.google.com with SMTP id r14so1529775wrq.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b15p4KXARwEoNlM1WPMg2pSx9ElZxt97JOcTPOVUe28=;
 b=H/IW0wr6zKm6hQ5JupC02j+YUhlzsQYDZ9iViBm0vT63sVJmJRTWQKvDZWTLOBh1OP
 SN11PryxDTS2foSSXh/ukXBU5u/ZsjKfx0VARIXEYXvZXCYQP+ihRJU0YcrWqIOehLeu
 /w0V3OpT5F2ZLpWne8B9OhaX1iMkDoaedAw3x/njvUk6WP2Fuf2xTiAqrfQ7gsnh+3qr
 gJvUAp5BuFX5ZOWcuWplTMzQTAFLrmQiNq9kWYN2SHLf6vHYhO5/CWqnb94eSl99weP9
 eBgTf5vz0WlV9AnbbaGSqoOSzJtQr921o2mqJZVufouuBwRXopjL7y+brJrknsyZyT6M
 043Q==
X-Gm-Message-State: AOAM532uZCapg1ol4QAEiIq7Co5pJn7MLH8CYxnrnu2Pk3678i507y1W
 VHsKlqLgdFp9zNpP76KsC6U5h6YyYZk1FhC5pLhry+rKb61HRPB+a6zCYEXywaWA7aYwnnTarHH
 o9B7T0eAP1faBBtZUuJABTBSc0sG1JXMrQ7Dc2eX8aw==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr2753632wrq.85.1596635096341; 
 Wed, 05 Aug 2020 06:44:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIX/R1ocyCLsQIShtCU4c22XE3xHsPPWnbXDGuQ6U2zNmRfwjcU+K6dqulnNoNKqfVGu6vnw==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr2753620wrq.85.1596635096132; 
 Wed, 05 Aug 2020 06:44:56 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id b203sm2926580wmc.22.2020.08.05.06.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:55 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 36/38] virtio-iommu: convert to LE accessors
Message-ID: <20200805134226.1106164-37-mst@redhat.com>
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
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
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

Virtio iommu is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/iommu/virtio-iommu.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index f6f07489a9aa..b4da396cce60 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1010,8 +1010,8 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		return ret;
 
-	virtio_cread(vdev, struct virtio_iommu_config, page_size_mask,
-		     &viommu->pgsize_bitmap);
+	virtio_cread_le(vdev, struct virtio_iommu_config, page_size_mask,
+			&viommu->pgsize_bitmap);
 
 	if (!viommu->pgsize_bitmap) {
 		ret = -EINVAL;
@@ -1022,25 +1022,25 @@ static int viommu_probe(struct virtio_device *vdev)
 	viommu->last_domain = ~0U;
 
 	/* Optional features */
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
-			     struct virtio_iommu_config, input_range.start,
-			     &input_start);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
+				struct virtio_iommu_config, input_range.start,
+				&input_start);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
-			     struct virtio_iommu_config, input_range.end,
-			     &input_end);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
+				struct virtio_iommu_config, input_range.end,
+				&input_end);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
-			     struct virtio_iommu_config, domain_range.start,
-			     &viommu->first_domain);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+				struct virtio_iommu_config, domain_range.start,
+				&viommu->first_domain);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
-			     struct virtio_iommu_config, domain_range.end,
-			     &viommu->last_domain);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+				struct virtio_iommu_config, domain_range.end,
+				&viommu->last_domain);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_PROBE,
-			     struct virtio_iommu_config, probe_size,
-			     &viommu->probe_size);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_PROBE,
+				struct virtio_iommu_config, probe_size,
+				&viommu->probe_size);
 
 	viommu->geometry = (struct iommu_domain_geometry) {
 		.aperture_start	= input_start,
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
