Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26810C433B4
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 08:47:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AED161153
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 08:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AED161153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FF8D41864;
	Fri, 16 Apr 2021 08:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CP2rI2gBqzjg; Fri, 16 Apr 2021 08:47:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C58674185D;
	Fri, 16 Apr 2021 08:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A095DC000B;
	Fri, 16 Apr 2021 08:47:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3259EC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 08:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DBFE60DCB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 08:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r3QszzJSpxCd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 08:47:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CD5660715
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618562864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2r7NGmqheP2GV+6A/LiwNG2tOhjWpE+ouB1t/RVmSe4=;
 b=FUhgS5DsuE9li4xMlFG9nF2S4BrL+uOfeU8Cwf5Es7/eZ22UJGXVILczvaPcWcHvtbunbU
 77xXP4Ox9Atq3lLNIW1H1VQx8Bk6kW0iUgYpfPqn/o0BEh/IPLij5ONUcAqTvuF0lRRZet
 /j0lRhQa0q9aRVYVvrA/slWu+49x1Xs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-gXZ55by_Pf-YrEYVLIeasg-1; Fri, 16 Apr 2021 04:47:42 -0400
X-MC-Unique: gXZ55by_Pf-YrEYVLIeasg-1
Received: by mail-ed1-f69.google.com with SMTP id
 f9-20020a50fe090000b02903839889635cso4655189edt.14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 01:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2r7NGmqheP2GV+6A/LiwNG2tOhjWpE+ouB1t/RVmSe4=;
 b=nbGIAEBVV3yimlE8Xyy98hzcM93Se/ZA19OicLGUAW9dcxPy+NXtilSGZZuB5o1TXE
 5OLrgicWsOKun7yz+QFyvEFsmMUrIzZmnqrTbcW7gDgGljRDVL0zrsvdMSLhbpFRjpfP
 xpw3gY3XpljFMqlL3CMW84HcaYNo7dSURwepjORg1mWycl6iGJW6iB3FWkn6teSePeNX
 xgzguUEvlQS+GkoYx5GlqZC4fp+ayv3+4SoAxIjtOGBYMEI+IvyjKnAqmn7I6V6IE+7+
 ks/wrcrLUGQr/NvuJbWs7G0YaHneX9Ss9NUVShKmLsyEHFA4NubJYipRVIe0B/uduWqN
 RxAQ==
X-Gm-Message-State: AOAM532RH8YS86EFee6KKMx2+VjSL6odhO4dB8KnMfQGr59OrtQmDHKN
 dQ4W4FNMcYYtSPp1aruvAyn0JFRP3ornlaO1AgeVIyVCih2YA3yhOD1RMoXimRfY80lBRwxD7ns
 jbdZ3bBtlNcr8mVC88SbkCOinLnzuttNPXhyz++ecSw==
X-Received: by 2002:aa7:db87:: with SMTP id u7mr8433900edt.16.1618562861496;
 Fri, 16 Apr 2021 01:47:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB2d7tIaEFMBWd3DwYN1KfiOebKxLZRxhbIvY5dtME0hUSHkW/0SULGJHTws6pnnflB3CeaA==
X-Received: by 2002:aa7:db87:: with SMTP id u7mr8433888edt.16.1618562861323;
 Fri, 16 Apr 2021 01:47:41 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id m14sm1016232edc.18.2021.04.16.01.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 01:47:41 -0700 (PDT)
Date: Fri, 16 Apr 2021 10:47:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 3/3] vDPA/ifcvf: get_config_size should return dev
 specific config size
Message-ID: <20210416084738.k2xr7m6rdhrvoqr2@steredhat>
References: <20210416071628.4984-1-lingshan.zhu@intel.com>
 <20210416071628.4984-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210416071628.4984-4-lingshan.zhu@intel.com>
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

On Fri, Apr 16, 2021 at 03:16:28PM +0800, Zhu Lingshan wrote:
>get_config_size() should return the size based on the decected
>device type.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/ifcvf/ifcvf_main.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index 376b2014916a..3b6f7862dbb8 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -356,7 +356,24 @@ static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>
> static size_t ifcvf_vdpa_get_config_size(struct vdpa_device *vdpa_dev)
> {
>-	return sizeof(struct virtio_net_config);
>+	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
>+	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>+	struct pci_dev *pdev = adapter->pdev;
>+	size_t size;
>+
>+	switch (vf->dev_type) {
>+	case VIRTIO_ID_NET:
>+		size = sizeof(struct virtio_net_config);
>+		break;
>+	case VIRTIO_ID_BLOCK:
>+		size = sizeof(struct virtio_blk_config);
>+		break;
>+	default:
>+		size = 0;
>+		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", vf->dev_type);
>+	}
>+
>+	return size;
> }
>
> static void ifcvf_vdpa_get_config(struct vdpa_device *vdpa_dev,
>-- 
>2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
