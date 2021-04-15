Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25590C43460
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 13:42:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C8F61249
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 13:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C8F61249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A7F7608DF;
	Thu, 15 Apr 2021 13:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RwQS9pditbQg; Thu, 15 Apr 2021 13:42:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1254F6068A;
	Thu, 15 Apr 2021 13:42:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1083C000B;
	Thu, 15 Apr 2021 13:42:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE6D2C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D151984724
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJ_Ti2PNFMQV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:41:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1317384714
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618494114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWBwNvOA3bfYgGwRaFOHTKgSUsx4hve9qhx0Mr44bE8=;
 b=VAbF1XKpeXQhzm8s1D1r+MYIQ286wXXic707kS0Z8ACmG2hVPyczR0SSL6dl/sTVyYZELY
 ETevtHA8+x+kF16whKQTkgv6Ek4ok/WnKsmOqmTsCQwMmfEBI4KhbD/jouBNr9y8lqM0M4
 rzGca7jrtyfluIr6AXCdeQVhMvXmh5k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-oVC-0tprM2WdDC4JTkzh3A-1; Thu, 15 Apr 2021 09:41:52 -0400
X-MC-Unique: oVC-0tprM2WdDC4JTkzh3A-1
Received: by mail-ej1-f70.google.com with SMTP id
 16-20020a1709063010b029037417ca2d43so942785ejz.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZWBwNvOA3bfYgGwRaFOHTKgSUsx4hve9qhx0Mr44bE8=;
 b=Dix34YYtwIe+/O8XjZf+Sz3s/5gaL9AbF2mhy9XAIihoHSKLjy+4cjELdXeQ7synck
 TkDuLmmloZxO07PhR7IOed2toViAfmEPAjthqiHP3f2g4akQA1HRSe27NTUQh0w/L7lF
 rM4HV04MzcZIgIv/OCsjGtfTJx0uu193CdU9xB6Z6u1GY1rN6qwixrG7HCC9GUiyAH67
 KQKfaG9wNhwWDGDQPLAZjBqpC62S+ATmeeOTpvMrYBSZmWiAtSGS1LnHcs+hkxCt4Le+
 8mvqDuppYgvk5uPKimqklxcWnSVDQ+ZdEeYNpq3gzpkY32CdxbG/hZA5hCYzjkf952oG
 259g==
X-Gm-Message-State: AOAM532F0GTXmO5LoZB8fuj/FKr8AEYMksC8d6ArNkOaKGtZj96wQH1O
 u3fX9xbc5mGhn2pv9D5cnn+KEJ+0L/ojclbhCGc5dfU0RjVEn8lHxIJ39YZLlZvdHKThzxf77Fj
 0GoQcsncvRIr92AZQgtWGjs5eW/ZqLPqoF1HdoNVIoA==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr4285846eds.166.1618494111619; 
 Thu, 15 Apr 2021 06:41:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyemgNsvx8pZ1RlfDQ7s7LT6G11+jyHeg9kKcfvRUnwPB3uY5DW+Uiq1h1T6dV5iO/rg2AG3A==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr4285830eds.166.1618494111460; 
 Thu, 15 Apr 2021 06:41:51 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id mm8sm1973637ejb.28.2021.04.15.06.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 06:41:51 -0700 (PDT)
Date: Thu, 15 Apr 2021 15:41:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V2 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block
 for vDPA
Message-ID: <20210415134148.q53glknhktbjwtzz@steredhat>
References: <20210415095336.4792-1-lingshan.zhu@intel.com>
 <20210415095336.4792-3-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210415095336.4792-3-lingshan.zhu@intel.com>
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

On Thu, Apr 15, 2021 at 05:53:35PM +0800, Zhu Lingshan wrote:
>This commit enabled Intel FPGA SmartNIC C5000X-PL virtio-block
>for vDPA.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/ifcvf/ifcvf_base.h |  8 +++++++-
> drivers/vdpa/ifcvf/ifcvf_main.c | 10 +++++++++-
> 2 files changed, 16 insertions(+), 2 deletions(-)
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
>index 469a9b5737b7..cea1313b1a3f 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -171,7 +171,11 @@ static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
> 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> 	u64 features;
>
>-	features = ifcvf_get_features(vf) & IFCVF_SUPPORTED_FEATURES;
>+	if (vf->dev_type == VIRTIO_ID_NET)
>+		features = ifcvf_get_features(vf) & IFCVF_NET_SUPPORTED_FEATURES;
>+
>+	if (vf->dev_type == VIRTIO_ID_BLOCK)
>+		features = ifcvf_get_features(vf);
>

Should we put a warning here too otherwise feature could be seen 
unassigned?

Thanks,
Stefano

> 	return features;
> }
>@@ -517,6 +521,10 @@ static struct pci_device_id ifcvf_pci_ids[] = {
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
