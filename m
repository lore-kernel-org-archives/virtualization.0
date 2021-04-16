Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6482C43462
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 08:47:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0A361152
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 08:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0A361152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EB5241859;
	Fri, 16 Apr 2021 08:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXh2A3gWu0Xb; Fri, 16 Apr 2021 08:47:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 718A44185B;
	Fri, 16 Apr 2021 08:47:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EF47C000B;
	Fri, 16 Apr 2021 08:47:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF80BC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 08:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72D1484768
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 08:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c9osncakW1zf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 08:47:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 843BB84760
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618562833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wRo3dX7HZBf9pYjFq5ETZzrsfm6Cv5K3vSoaAXFlhHU=;
 b=Zhc59n+wMFOArTO2MZ7egfc3ywABXk260fQ7d6GwaQWaS1C2RzScIn+urEQ/l17YZZEHlq
 rYxh/MHk4rMGitotSu+V309799g1JN03JtXm16Hr2uA3rEvMoDBDOuRL105qNBv9YZJ3p/
 Kxy1igSbxKNvhj3WeFCwNxy9eiy6/AE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-fKeMwKqdPIOKwfs4SkGJog-1; Fri, 16 Apr 2021 04:47:11 -0400
X-MC-Unique: fKeMwKqdPIOKwfs4SkGJog-1
Received: by mail-ej1-f72.google.com with SMTP id
 x21-20020a1709064bd5b029037c44cb861cso1793340ejv.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 01:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wRo3dX7HZBf9pYjFq5ETZzrsfm6Cv5K3vSoaAXFlhHU=;
 b=IgYjbgH4wtQ/QigrwisO2nRx/9NuibWud68VX9HpKsYUsMf4tSgNAqbWOs4osHJ4Xi
 SyoBywoJNlfibrp2DJFJaTs+eG55MrlqnK/UFuAWma2vy0M7W74eT+0NxPWvleqrBU54
 EcGUKZxLNHdf0b90AMbpVy2gYkpuN5IDb5yiGYv0YbV3/SbgD1vbW+BOHJQBXvwHZRQO
 kr/NTUcnHPWSigGygHpD8aFSMastL9U6Zap6Ct+DKwx+ayMLQa74rSD5PGS0Op2jCMmo
 bi2lcSVc1K4id8lT9jELw7/u7lO8iJ+ZrTEKjb4KxiElFYRiZpK75O9hhD98E0A/zCn8
 6BXg==
X-Gm-Message-State: AOAM531Pjx4NCGgHLni7QSNCnuD91SsmiJTUuQMDhNBtjURVKCeCVs9t
 nMX9lZ2R0X2u2cy4WOIrn/RMxpxzF4BdOZnQbDq7it72kPxlsKaK71MDVjXhPcFgJXm3Jcp0gIR
 znQyBo2YtMs0/LNJjNUcKdYvvtxlSiI0go9I2wDnM/w==
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr8637330edy.224.1618562830126; 
 Fri, 16 Apr 2021 01:47:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh1Zl2ub3jfnrnRMGdIeGAkIGOzcVmqwkMtbMOyGQ3+DRwPr4tDakxV4LySH2DCPUs/c6RYw==
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr8637313edy.224.1618562829919; 
 Fri, 16 Apr 2021 01:47:09 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id k9sm3617309eje.102.2021.04.16.01.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 01:47:09 -0700 (PDT)
Date: Fri, 16 Apr 2021 10:47:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block
 for vDPA
Message-ID: <20210416084707.ruqzvg4airzkkc2t@steredhat>
References: <20210416071628.4984-1-lingshan.zhu@intel.com>
 <20210416071628.4984-3-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210416071628.4984-3-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Apr 16, 2021 at 03:16:27PM +0800, Zhu Lingshan wrote:
>This commit enabled Intel FPGA SmartNIC C5000X-PL virtio-block
>for vDPA.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/ifcvf/ifcvf_base.h |  8 +++++++-
> drivers/vdpa/ifcvf/ifcvf_main.c | 19 ++++++++++++++++++-
> 2 files changed, 25 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
>index 1c04cd256fa7..0111bfdeb342 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_base.h
>+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
>@@ -15,6 +15,7 @@
> #include <linux/pci_regs.h>
> #include <linux/vdpa.h>
> #include <uapi/linux/virtio_net.h>
>+#include <uapi/linux/virtio_blk.h>
> #include <uapi/linux/virtio_config.h>
> #include <uapi/linux/virtio_pci.h>
>
>@@ -28,7 +29,12 @@
> #define C5000X_PL_SUBSYS_VENDOR_ID	0x8086
> #define C5000X_PL_SUBSYS_DEVICE_ID	0x0001
>
>-#define IFCVF_SUPPORTED_FEATURES \
>+#define C5000X_PL_BLK_VENDOR_ID		0x1AF4
>+#define C5000X_PL_BLK_DEVICE_ID		0x1001
>+#define C5000X_PL_BLK_SUBSYS_VENDOR_ID	0x8086
>+#define C5000X_PL_BLK_SUBSYS_DEVICE_ID	0x0002
>+
>+#define IFCVF_NET_SUPPORTED_FEATURES \
> 		((1ULL << VIRTIO_NET_F_MAC)			| \
> 		 (1ULL << VIRTIO_F_ANY_LAYOUT)			| \
> 		 (1ULL << VIRTIO_F_VERSION_1)			| \
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index 469a9b5737b7..376b2014916a 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -168,10 +168,23 @@ static struct ifcvf_hw *vdpa_to_vf(struct vdpa_device *vdpa_dev)
>
> static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
> {
>+	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
> 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>+	struct pci_dev *pdev = adapter->pdev;
>+
> 	u64 features;
>
>-	features = ifcvf_get_features(vf) & IFCVF_SUPPORTED_FEATURES;
>+	switch (vf->dev_type) {
>+	case VIRTIO_ID_NET:
>+		features = ifcvf_get_features(vf) & IFCVF_NET_SUPPORTED_FEATURES;
>+		break;
>+	case VIRTIO_ID_BLOCK:
>+		features = ifcvf_get_features(vf);
>+		break;
>+	default:
>+		features = 0;
>+		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", vf->dev_type);
>+	}
>
> 	return features;
> }
>@@ -517,6 +530,10 @@ static struct pci_device_id ifcvf_pci_ids[] = {
> 			 C5000X_PL_DEVICE_ID,
> 			 C5000X_PL_SUBSYS_VENDOR_ID,
> 			 C5000X_PL_SUBSYS_DEVICE_ID) },
>+	{ PCI_DEVICE_SUB(C5000X_PL_BLK_VENDOR_ID,
>+			 C5000X_PL_BLK_DEVICE_ID,
>+			 C5000X_PL_BLK_SUBSYS_VENDOR_ID,
>+			 C5000X_PL_BLK_SUBSYS_DEVICE_ID) },
>
> 	{ 0 },
> };
>-- 
>2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
