Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76168C433F5
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 17:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3061E409AF;
	Thu,  2 Dec 2021 17:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l14qgyzP-Mlx; Thu,  2 Dec 2021 17:54:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4F81408CE;
	Thu,  2 Dec 2021 17:54:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B08F5C001C;
	Thu,  2 Dec 2021 17:54:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75193C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 17:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 565356F4C0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 17:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BnFvjTPKLUIe
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 17:54:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88CEE606D9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638467677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5iEY5+Q7187HBYcbnsC6m7DW/GH259D3TwsIkdXcDU=;
 b=EVEUFkwMX1B2HHMjsMplGqKhaYgPXMDvWTgcjoo7kibAGNtFjZ52CUtb+DpvvtuEfDVBXJ
 kxdPp2NQz/aa4BDX/b5LyM70MuZitC06bexMZAz/9Qm6vvx935KdS8v8MgkeuMDdAa6lGJ
 u9EYfqX02pOWY8oFtWRGBJXWGJcIHD8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-dFyU2s7VN22YpPuoM7QsvA-1; Thu, 02 Dec 2021 12:54:34 -0500
X-MC-Unique: dFyU2s7VN22YpPuoM7QsvA-1
Received: by mail-wr1-f70.google.com with SMTP id
 d7-20020a5d6447000000b00186a113463dso54921wrw.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Dec 2021 09:54:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=x5iEY5+Q7187HBYcbnsC6m7DW/GH259D3TwsIkdXcDU=;
 b=dhc3b0/RB9Ww7v7nLLDbChSx5VLxag3clVdXS/d3boGxW/WU0g1AVfzEL6FJRNyDbi
 GtcvG/m1fABWaXNUXD4D69Y74kCM12y0bDXvleCYknC+B+ofD/UoUysw6MHGHQGHrIaQ
 kw4aJcIKgytWjO+h2oXm8Nh5xIJ0wee7ssd+kzsS3Cw9MYP6GG3rGTNdoFjhBHUPu8pA
 EIlc2XZC0nnECdqOGvicCJ5tJ+kAcSZvbad4tdKipIvB3vk2V+ohqDhzCvloWcHwDxh6
 YtsOyov8rmpMzAjr8Bmm5ba+C6/QTBw7UM8Y6YWaI8sgOQrZzk5QzFD9J8+2abnLtD47
 6FYw==
X-Gm-Message-State: AOAM530l3uN6gNMCUJmG/dQ33QeOHinZEGsA1CwHVW95naAgcuhpi64u
 2Wvs3kxhIyYoDbmp9T4xFoaip7ENYk7KWJqVz+TLHCHTEIsVuvszIS4BBh3qggqtmdKbyfY6nI8
 spg4l3uqo+W78PD7YwPB7LQP5LJU4iDyZ1cX3cIzbTA==
X-Received: by 2002:a5d:4b8a:: with SMTP id b10mr16195906wrt.413.1638467673511; 
 Thu, 02 Dec 2021 09:54:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYTTWGt/H7jr5EqaJ/XAXM6YzxLjTMqvTL0UJNuYQt7GZE5bY2YOrYLBfllIbO3vd1+qeEuQ==
X-Received: by 2002:a5d:4b8a:: with SMTP id b10mr16195883wrt.413.1638467673291; 
 Thu, 02 Dec 2021 09:54:33 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id m9sm403778wmq.1.2021.12.02.09.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Dec 2021 09:54:32 -0800 (PST)
Subject: Re: [PATCH v3 2/5] iommu/virtio: Support bypass domains
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org, mst@redhat.com, jasowang@redhat.com
References: <20211201173323.1045819-1-jean-philippe@linaro.org>
 <20211201173323.1045819-3-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <41ec5c11-3a75-dd0a-c2d8-70baaa3d338e@redhat.com>
Date: Thu, 2 Dec 2021 18:54:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211201173323.1045819-3-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: pasic@linux.ibm.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, virtualization@lists.linux-foundation.org
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



On 12/1/21 6:33 PM, Jean-Philippe Brucker wrote:
> The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a new flag to the ATTACH
> request, that creates a bypass domain. Use it to enable identity
> domains.
>
> When VIRTIO_IOMMU_F_BYPASS_CONFIG is not supported by the device, we
> currently fail attaching to an identity domain. Future patches will
> instead create identity mappings in this case.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 80930ce04a16..14dfee76fd19 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -71,6 +71,7 @@ struct viommu_domain {
>  	struct rb_root_cached		mappings;
>  
>  	unsigned long			nr_endpoints;
> +	bool				bypass;
>  };
>  
>  struct viommu_endpoint {
> @@ -587,7 +588,9 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
>  {
>  	struct viommu_domain *vdomain;
>  
> -	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_DMA &&
> +	    type != IOMMU_DOMAIN_IDENTITY)
>  		return NULL;
>  
>  	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
> @@ -630,6 +633,17 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  	vdomain->map_flags	= viommu->map_flags;
>  	vdomain->viommu		= viommu;
>  
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		if (!virtio_has_feature(viommu->vdev,
> +					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> +			ida_free(&viommu->domain_ids, vdomain->id);
> +			vdomain->viommu = NULL;
> +			return -EOPNOTSUPP;
> +		}
> +
> +		vdomain->bypass = true;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -691,6 +705,9 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		.domain		= cpu_to_le32(vdomain->id),
>  	};
>  
> +	if (vdomain->bypass)
> +		req.flags |= cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
> +
>  	for (i = 0; i < fwspec->num_ids; i++) {
>  		req.endpoint = cpu_to_le32(fwspec->ids[i]);
>  
> @@ -1132,6 +1149,7 @@ static unsigned int features[] = {
>  	VIRTIO_IOMMU_F_DOMAIN_RANGE,
>  	VIRTIO_IOMMU_F_PROBE,
>  	VIRTIO_IOMMU_F_MMIO,
> +	VIRTIO_IOMMU_F_BYPASS_CONFIG,
>  };
>  
>  static struct virtio_device_id id_table[] = {

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
