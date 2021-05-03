Return-Path: <SRS0=lx0b=J6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECC2C433ED
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:47:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D38C60FE9
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D38C60FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33DCA4046B;
	Mon,  3 May 2021 08:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oCh30MI6exja; Mon,  3 May 2021 08:47:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B61FD400D0;
	Mon,  3 May 2021 08:47:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D6CCC000D;
	Mon,  3 May 2021 08:47:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0746AC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6BAB83DB5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HCdA__rvQ3fm
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:47:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BD3683DB4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620031654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNh3VIIaagnprujVXdPtNBa4jPKLHbvzqtglqUzkcjA=;
 b=e8RC2eL+gnIHgBWKOfx+Hl9RYkeKrrYo7MUxRfcsI1bb2zm01SWe7udILlPhPmH+L6IE1h
 TCg0jyyWlhPi24bWNYZIweJXrCFs4a9ofidjuvD9PJc0aYFwrZSqY6fDGQd1905vSDLIYG
 LS2GmVgq0j6RcEMYA96HrKjQYpkBKzQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-tqE-5rfwPE6EWFmAzDGk4g-1; Mon, 03 May 2021 04:47:32 -0400
X-MC-Unique: tqE-5rfwPE6EWFmAzDGk4g-1
Received: by mail-wr1-f71.google.com with SMTP id
 93-20020adf93e60000b029010d9bb1923eso3530277wrp.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 May 2021 01:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oNh3VIIaagnprujVXdPtNBa4jPKLHbvzqtglqUzkcjA=;
 b=aQ5qf4ikme5cNZ0yPNbPkbb++ooJQatQgI/frRYsm7Nff84CuUn4ndz72lhGvKRLMv
 vs4ys9StEcmzlpthHiSIHWQSGpZodCCDsQoSnQhgtMzX1WYcnQy09z+nvDjWAOctec9z
 S8e+7Bqr3p3zg8qQbTjGR/Uzmyp0DWWAAX8tOVBMh0V+wihRV+TQNMpkG1uw784Z4+PW
 ZNjT7hz1DDpl2x5t1kf8+cTm0/7gcjIQkNPow50S8eiE9c26dBaZq4gQeSGcLafOptqc
 X3V2YDsKxmPluZd1EOmN5hveuW4pIyI2jLwEtkq752ZpTMrZzCqE77sAC14z3xuAEBLT
 d9EQ==
X-Gm-Message-State: AOAM533yt2d0IZdRsUxuHQfMh9bOWDamu8QJk4tQYW9ZgKdicFzYjOd6
 2KFPmmPqyr05L0Wsab/khJJsxpud1nfDa50/LY9zUL0HWzG42vl2a16uoPQUh8zPpdoxCwvTPRC
 /Wdvp/epjVLrdm0QjQ3fTh03DV3u0UtYtB/x+TFltQg==
X-Received: by 2002:adf:f00a:: with SMTP id j10mr23036895wro.231.1620031651548; 
 Mon, 03 May 2021 01:47:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvQn7ZILmdzPLig2hPkrpiOMpynXsLhaYHpmRxuCUep9NSoCwjLciJspeYLkl3+SmLIr8RrA==
X-Received: by 2002:adf:f00a:: with SMTP id j10mr23036877wro.231.1620031651405; 
 Mon, 03 May 2021 01:47:31 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
 by smtp.gmail.com with ESMTPSA id i20sm20091020wmq.29.2021.05.03.01.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 May 2021 01:47:30 -0700 (PDT)
Date: Mon, 3 May 2021 04:47:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V4 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block
 for vDPA
Message-ID: <20210503043801-mutt-send-email-mst@kernel.org>
References: <20210419063326.3748-1-lingshan.zhu@intel.com>
 <20210419063326.3748-3-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210419063326.3748-3-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Apr 19, 2021 at 02:33:25PM +0800, Zhu Lingshan wrote:
> This commit enabled Intel FPGA SmartNIC C5000X-PL virtio-block
> for vDPA.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.h |  8 +++++++-
>  drivers/vdpa/ifcvf/ifcvf_main.c | 19 ++++++++++++++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index 1c04cd256fa7..0111bfdeb342 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -15,6 +15,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/vdpa.h>
>  #include <uapi/linux/virtio_net.h>
> +#include <uapi/linux/virtio_blk.h>
>  #include <uapi/linux/virtio_config.h>
>  #include <uapi/linux/virtio_pci.h>
>  
> @@ -28,7 +29,12 @@
>  #define C5000X_PL_SUBSYS_VENDOR_ID	0x8086
>  #define C5000X_PL_SUBSYS_DEVICE_ID	0x0001
>  
> -#define IFCVF_SUPPORTED_FEATURES \
> +#define C5000X_PL_BLK_VENDOR_ID		0x1AF4


Come on this is just PCI_VENDOR_ID_REDHAT_QUMRANET right?



> +#define C5000X_PL_BLK_DEVICE_ID		0x1001

0x1001 is a transitional blk device from virtio spec too right? Let's add these to virtio_ids.h?

> +#define C5000X_PL_BLK_SUBSYS_VENDOR_ID	0x8086
> +#define C5000X_PL_BLK_SUBSYS_DEVICE_ID	0x0002

VIRTIO_ID_BLOCK?

> +
> +#define IFCVF_NET_SUPPORTED_FEATURES \
>  		((1ULL << VIRTIO_NET_F_MAC)			| \
>  		 (1ULL << VIRTIO_F_ANY_LAYOUT)			| \
>  		 (1ULL << VIRTIO_F_VERSION_1)			| \
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 66927ec81fa5..9a4a6df91f08 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -168,10 +168,23 @@ static struct ifcvf_hw *vdpa_to_vf(struct vdpa_device *vdpa_dev)
>  
>  static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
>  {
> +	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
>  	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> +	struct pci_dev *pdev = adapter->pdev;
> +
>  	u64 features;
>  
> -	features = ifcvf_get_features(vf) & IFCVF_SUPPORTED_FEATURES;
> +	switch (vf->dev_type) {
> +	case VIRTIO_ID_NET:
> +		features = ifcvf_get_features(vf) & IFCVF_NET_SUPPORTED_FEATURES;
> +		break;
> +	case VIRTIO_ID_BLOCK:
> +		features = ifcvf_get_features(vf);
> +		break;
> +	default:
> +		features = 0;
> +		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", vf->dev_type);
> +	}
>  
>  	return features;
>  }
> @@ -514,6 +527,10 @@ static struct pci_device_id ifcvf_pci_ids[] = {
>  			 C5000X_PL_DEVICE_ID,
>  			 C5000X_PL_SUBSYS_VENDOR_ID,
>  			 C5000X_PL_SUBSYS_DEVICE_ID) },
> +	{ PCI_DEVICE_SUB(C5000X_PL_BLK_VENDOR_ID,
> +			 C5000X_PL_BLK_DEVICE_ID,
> +			 C5000X_PL_BLK_SUBSYS_VENDOR_ID,
> +			 C5000X_PL_BLK_SUBSYS_DEVICE_ID) },
>  
>  	{ 0 },
>  };
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
