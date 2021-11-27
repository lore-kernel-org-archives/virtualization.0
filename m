Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401D1C433F5
	for <virtualization@archiver.kernel.org>; Sat, 27 Nov 2021 16:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2CB780B40;
	Sat, 27 Nov 2021 16:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ikTvWN_9acn0; Sat, 27 Nov 2021 16:18:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9094E80B0E;
	Sat, 27 Nov 2021 16:18:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 786C8C001C;
	Sat, 27 Nov 2021 16:18:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC2E0C000A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 16:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA8EC60608
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 16:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ytfyCDnz9o5O
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 16:18:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB69160598
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638029913;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kP9G5nOumtKjxrGUQQJElSXHdsDYmsWeOL5Vc10tFp8=;
 b=JeZYRbuaorxwqgd7Q4/YKLbe6mWsPrBVbI41EJN3t0Krpaxt6eRH8xwcxBZB6oJ3oc2bgr
 r/s5B5QEMDqIfX1KciKt6wyb5qGsmn8FY3K5eHH+9ftEBLr8R3KUl2p5kHqope/WVAXA3L
 sH9ZccFQ3XVe1Rsw+q3VKVj6yYbb4mM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-63-z90RjNdKvdBBz-OvgYQ-1; Sat, 27 Nov 2021 11:18:32 -0500
X-MC-Unique: 63-z90RjNdKvdBBz-OvgYQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 j25-20020a05600c1c1900b00332372c252dso7253285wms.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 08:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=kP9G5nOumtKjxrGUQQJElSXHdsDYmsWeOL5Vc10tFp8=;
 b=uvqLYOXCpZOIsv0iQqfLgDrrWTjeGpqBOhOUw5Uxos6s0APCZMhOLhQgSQ4CL46CE7
 IbhDUwt51SKr9a7s21Kn8agNWJ70E3MDnSviER0MUBFQ5SFns9kYUDAxzHPqGTz3qgjj
 qi3cZu5IWF+Hx6omqCeOdlQk4hERnk+uVDLKJA6aKwNYpPqwOZIHsCgTXLy9bTC8c3Mo
 KKMulgHyb+pNQxBwMOj6szm4hdjHNPz/dQB4PUKsGh4Dj2poh+qrHJrb46cGDp1BCsdN
 9lCW83WlOfIB3gHe2+kjwzjonsFwiQTsR5Z8MxkXIifsXVd77y65J1bgUcuQrxfiZnX7
 6+0w==
X-Gm-Message-State: AOAM532ESzNAiOTD+DUKip79aNw5pXYpJ4gRMR3Y/4ZGJNUhOLnDt7RU
 baeqkSyC7nLmDOfoks8HJH6YVmk/kLYwxqBxWhMEysvXrrCvd2vCC/A2122ojtgsJ9DQ7PNNvZl
 YqdTfIXtY9kNsiQ7wasOJQY/GEXjWHhJvBY2pdtDgNQ==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr21220539wrr.385.1638029910891; 
 Sat, 27 Nov 2021 08:18:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytZwHqxY+KvXMZhaFZl21+/JpV13hJPqRL/1UC79cwtAyf0HQ7txFbJs99R25+hd9EGf2Tfg==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr21220508wrr.385.1638029910605; 
 Sat, 27 Nov 2021 08:18:30 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id bd18sm9210802wmb.43.2021.11.27.08.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Nov 2021 08:18:29 -0800 (PST)
Subject: Re: [PATCH v2 2/5] iommu/virtio: Support bypass domains
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org, mst@redhat.com, jasowang@redhat.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-3-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <fd03ac99-9bd4-197b-26c8-dcc5de1b3057@redhat.com>
Date: Sat, 27 Nov 2021 17:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-3-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com
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

On 11/23/21 4:52 PM, Jean-Philippe Brucker wrote:
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
> ---
>  drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 80930ce04a16..ee8a7afd667b 100644
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
nit: couldn't the check be done before the ida_alloc_range(),
simplifying the failure cleanup?

Thanks

Eric
> +					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> +			ida_free(&viommu->domain_ids, vdomain->id);
> +			vdomain->viommu = 0;
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
