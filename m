Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBBFC433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 12:55:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BD521744
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 12:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzg/C85g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BD521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 697E788175;
	Wed,  5 Aug 2020 12:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nDpznMUqY7uc; Wed,  5 Aug 2020 12:55:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ADBF887D1D;
	Wed,  5 Aug 2020 12:55:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94236C0050;
	Wed,  5 Aug 2020 12:55:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C87C5C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B179486783
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:55:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XqPfUpzhJIZC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:55:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 107278672E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596632134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7wryOIrrGjx7qHTonL03QxNMVi3GzMOIvfN7c2/DZ4s=;
 b=bzg/C85g1OLU4CBN+rsLtJH1XB5vCK9z8yhNrZwgAE855XtiAsX2ntN2/gFC3h/prWLvSk
 9yxzPpqNpLmYTz/DRoeaJknAv2oUPh6T7VhMgWXDICiP4EGRIRqteSOjyi/ednygdO6lyb
 Wm2bZMRisLrP9Fs5moM1s2HKbPRSBCQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-CWuIixkENE-rmW69Y1d_NQ-1; Wed, 05 Aug 2020 08:55:32 -0400
X-MC-Unique: CWuIixkENE-rmW69Y1d_NQ-1
Received: by mail-wr1-f70.google.com with SMTP id t12so13644863wrp.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 05:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7wryOIrrGjx7qHTonL03QxNMVi3GzMOIvfN7c2/DZ4s=;
 b=aqMz5d6xQb9jEX8fEM54jUIXMB+su/87pH6hI632eISLHCj1Xmi/vP7hcBuCyrSNTE
 PNj+G7bUA4gafowlLeJhNoVsW/lhv6Mm2lQgFYAsXyAq/ML4XisIYqpKWcKZNrsS00Kr
 2ZL9gvSB4RzLAqoxy6+4WqEsG+5k0RUvSggl74psGKZt5ZudVK+rfO2mC+gyAiyInbon
 XphzOQaCN03/71ghJeruFHFp88x3v2ySm9a4N/dn/3j8N6P1zCFBnD75eyIC2Ve7g/Ni
 kV+ukl8vekFCByk1yN3FPTRnDFQTostOe6JFcBcQzxfXR1xEnn3hVi/Oj8lDeX4Y5rAB
 MMLw==
X-Gm-Message-State: AOAM530Loi+i0kDW7mtXojdRKWs/gvJVzFFNvZ353mHoF96nQz2T/E9A
 VFJpHrYAqkOub6XhQILjuqqqh1QGyIRArWwixkfykoEMOAqIjvHdCsr/fzSkuVUIGJkq6p3+5bz
 684ao3hJSQvtgyPGc1CzJwqKp5SOLxn+e9ZRr+I/HGQ==
X-Received: by 2002:a5d:5641:: with SMTP id j1mr2726631wrw.399.1596632131184; 
 Wed, 05 Aug 2020 05:55:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+d3vclQ9GPgtT3OT3+FcxmtxQjAU228iBaB3UFD2Bzh1BnV8/Gw9OtsyrBfKZn8DubjRAFQ==
X-Received: by 2002:a5d:5641:: with SMTP id j1mr2726609wrw.399.1596632130998; 
 Wed, 05 Aug 2020 05:55:30 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 32sm2783363wrn.86.2020.08.05.05.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 05:55:30 -0700 (PDT)
Date: Wed, 5 Aug 2020 08:55:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] vdpa: get_iova_range() is mandatory for device
 specific DMA translation
Message-ID: <20200805085217-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-4-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200617032947.6371-4-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

On Wed, Jun 17, 2020 at 11:29:46AM +0800, Jason Wang wrote:
> In order to let userspace work correctly, get_iova_range() is a must
> for the device that has its own DMA translation logic.

I guess you mean for a device.

However in absence of ths op, I don't see what is wrong with just
assuming device can access any address.

> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/vdpa.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index de211ef3738c..ab7af978ef70 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -82,6 +82,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  	if (!!config->dma_map != !!config->dma_unmap)
>  		goto err;
>  
> +	if ((config->dma_map || config->set_map) &&
> +	    !config->get_iova_range)
> +		goto err;
> +
>  	err = -ENOMEM;
>  	vdev = kzalloc(size, GFP_KERNEL);
>  	if (!vdev)

What about devices using an IOMMU for translation?
IOMMUs generally have a limited IOVA range too, right?



> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
