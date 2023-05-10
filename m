Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE835C7EE22
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 15:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6743984709;
	Wed, 10 May 2023 15:37:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6743984709
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DP6rbK7a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uj3FWhjYa1eg; Wed, 10 May 2023 15:37:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 05C3681F4D;
	Wed, 10 May 2023 15:37:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05C3681F4D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFE38C0037;
	Wed, 10 May 2023 15:37:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B73B6C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 15:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9ED1070030
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 15:37:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9ED1070030
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DP6rbK7a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8aUZSIVGsyM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 15:37:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B77B26FEDA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B77B26FEDA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683733050;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIZ5R0R1UQfkowNLwICZ300tn7bItysSdexUg4jQHeA=;
 b=DP6rbK7aOECtosPh4GCcve0LDT3QwmNxBUke7CMRMGNK1BY2cHWkOMEhAvtKobT48JL8JG
 VUDJKOm2rJVtUIDzXKVbyM6F6k2sA+mBz7k8K5LmCGs2lzX3jW9XjxTT/f3ZUVLOr2vngB
 YXwtrzZ3TsofT+lKKrA4Bz6Lr0Frg1U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-wjRJilyzNWy1C8x8OYQzGQ-1; Wed, 10 May 2023 11:37:29 -0400
X-MC-Unique: wjRJilyzNWy1C8x8OYQzGQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-61acaf012f0so41896586d6.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683733049; x=1686325049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIZ5R0R1UQfkowNLwICZ300tn7bItysSdexUg4jQHeA=;
 b=DVBqnY6fJo8cXEUEQu1fUJv7WNIF6ykHhspXpSgYLbd4hxyGGKovzYIx9lWQetXw7e
 OcZGY+s5sGjVEH1QHaRI6WyGqbPNdj8LTJjanZbE0C7Q6qK7d6KiEk+4L/XIp7r4SMe+
 10w60jSXknKDo6AhJVy6QBqfwbeUdoaJwf2S/9Wupd6p8Dz+nD8WHH/I3bp+FBcyahmF
 N2QEGuCxVgvBZGdSwB/RA6pRed4uzC6LTarPvD0E2D+ShiTzLoWe+wNI/+fR2/p6BzET
 QD+4YWP/1VEun7shDVYMw7auOXCpdMxcY2FC/mA3eIccmbv+SZBU3IVWuhoRlVZ7oUMe
 7AqA==
X-Gm-Message-State: AC+VfDwWYIDlgtGRURWuw4FX+wkkN07aHW3Em41uqjRAbW1IdhR5FN7t
 P+gak413BJfI7Hq7hNVlC9Kl7uoYShIf2opkAZ3yppuCYjjT8dTYZH5kD44+ZCXMb2+74e3VL/9
 Ggx9Zbq6CZzmAptxBHtjNzc0Yzg7KTZRfYmX9PTsZSA==
X-Received: by 2002:ac8:57c5:0:b0:3ef:54c9:170c with SMTP id
 w5-20020ac857c5000000b003ef54c9170cmr26382874qta.65.1683733049228; 
 Wed, 10 May 2023 08:37:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7x4Nh/Th0I2IjTD1CuHQU/tchDx2COUk/jt7qdEJSagD5mjsOl3ihA6veijLUrqWhgtGmMzg==
X-Received: by 2002:ac8:57c5:0:b0:3ef:54c9:170c with SMTP id
 w5-20020ac857c5000000b003ef54c9170cmr26382836qta.65.1683733048911; 
 Wed, 10 May 2023 08:37:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 c23-20020ac81e97000000b003f38b4167e5sm1487432qtm.2.2023.05.10.08.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 May 2023 08:37:28 -0700 (PDT)
Message-ID: <e58c48e0-6339-41ec-e65b-e3104c65bb81@redhat.com>
Date: Wed, 10 May 2023 17:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
References: <20230414150744.562456-1-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230414150744.562456-1-jean-philippe@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: akihiko.odaki@daynix.com, iommu@lists.linux.dev, robin.murphy@arm.com,
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Jean,

On 4/14/23 17:07, Jean-Philippe Brucker wrote:
> When an endpoint is released, for example a PCIe VF is disabled or a
> function hot-unplugged, it should be detached from its domain. Send a
> DETACH request.
>
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 5b8fe9bfa9a5..3d3d4462359e 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	return 0;
>  }
>  
> +static void viommu_detach_dev(struct viommu_endpoint *vdev)
> +{
> +	int i;
> +	struct virtio_iommu_req_detach req;
> +	struct viommu_domain *vdomain = vdev->vdomain;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
> +
> +	if (!vdomain)
> +		return;
> +
> +	req = (struct virtio_iommu_req_detach) {
> +		.head.type	= VIRTIO_IOMMU_T_DETACH,
> +		.domain		= cpu_to_le32(vdomain->id),
> +	};
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> +		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
> +	}
just a late question: don't you need to decrement vdomain's nr_endpoints?

Thanks

Eric
> +	vdev->vdomain = NULL;
> +}
> +
>  static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
>  			    int prot, gfp_t gfp, size_t *mapped)
> @@ -990,6 +1012,7 @@ static void viommu_release_device(struct device *dev)
>  {
>  	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  
> +	viommu_detach_dev(vdev);
>  	iommu_put_resv_regions(dev, &vdev->resv_regions);
>  	kfree(vdev);
>  }

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
