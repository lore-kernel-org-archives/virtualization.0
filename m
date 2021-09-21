Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DA0C433FE
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 15:59:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55DC61242
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 15:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D55DC61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A2F7403E2;
	Tue, 21 Sep 2021 15:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id us1jQNfDuHMd; Tue, 21 Sep 2021 15:59:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B0EF8400EB;
	Tue, 21 Sep 2021 15:59:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87A07C000F;
	Tue, 21 Sep 2021 15:59:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D65DC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BCE76065A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cie57erAuMAG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:59:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C26F605BB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 15:59:47 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id d6so40496397wrc.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AtZyyTP986q5izPT5lFbv6cJ5CVeOkj7bVUgoAF+aPE=;
 b=qn8z1Wbkql8CqtKixkOZJfHbzjeuBbinRO0kMwKxCb0qOIrbleyJ5e2P2YBme9hhQd
 npB+D2tprMu7tQ9xPboAPoUxLWvzYj0qtGUdZWjjnX/QACr4MJjk9P6kaSN/NVT4vhSo
 C9ODmI/mHhyqcDhULh3v0wjFyt8Uu/Elftxsz4cTyqK6mkROt3VFsJtokj4kXciRUZfX
 OsxZgAgRk2Z8USr6T+8L0LP7KNak3SelmLNRb6o1DuePBxyc0FGr/ZG6/wccXWQhCKg4
 fu5VLgQA3b/YaW/POQ2oM8m7kG1gdwq9KHKIwzfrYAYUI2CMm+Wbw7X6yS6nTTRLRwEq
 3kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AtZyyTP986q5izPT5lFbv6cJ5CVeOkj7bVUgoAF+aPE=;
 b=KvvEhugIoOxtWiuS0EI2kUDcBdEMFG30ORosA8dTWoE7lxgrjmDU8+jMbnskU8dzLP
 JBxc4d87ZW2vIER4I/BEOUJtPEH8DN8sGIljb3mUuofcdxHZmvC+ZsYQQ7qwpLkgyGOf
 yjlloroiT1PGHWCLDUsORJQPIzZvPSwzyxIiRFuzz1QLjL/iLl3OPxFFuAX2WmQTP6h3
 HSQWNJxbfv13OiMaL3LJE65RScnjHWOtWHMMaRVyC3PNGR51sr5Ov2RLnJI7O4vkrS3j
 +Ovepao/+9Zm4SWmnjZW2I4yflQX6ugbT2Fjj8pxHPZrr3hXlqfO2s2OpLTfm3U1/WHf
 rQBw==
X-Gm-Message-State: AOAM533MPWiYMXq87pDsO+lpodxGpiQRb6/R0z6El6uWEFyGTi8X88F/
 v+FdInUcPf7nKAwUAHV45j4QgA==
X-Google-Smtp-Source: ABdhPJwaROKNZrdKnelWS30U+Qu/Ae+90Y3oEspXKLXzr2302zCcSxHLGjrCndLcOXgApQye9wguvg==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr36130015wru.285.1632239985681; 
 Tue, 21 Sep 2021 08:59:45 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id o1sm2799031wmq.26.2021.09.21.08.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 08:59:45 -0700 (PDT)
Date: Tue, 21 Sep 2021 16:59:23 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints
 served by viommu_dev
Message-ID: <YUoBW13+CvIljUgc@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-3-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-3-vivek.gautam@arm.com>
X-TUID: +1WeLErnK1xS
Cc: jacob.jun.pan@linux.intel.com, mst@redhat.com, joro@8bytes.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com,
 Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Apr 23, 2021 at 03:21:38PM +0530, Vivek Gautam wrote:
> Keeping a record of list of endpoints that are served by the virtio-iommu
> device would help in redirecting the requests of page faults to the
> correct endpoint device to handle such requests.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 50039070e2aa..c970f386f031 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -48,6 +48,7 @@ struct viommu_dev {
>  	spinlock_t			request_lock;
>  	struct list_head		requests;
>  	void				*evts;
> +	struct list_head		endpoints;

As we're going to search by ID, an xarray or rb_tree would be more
appropriate than a list

>  
>  	/* Device configuration */
>  	struct iommu_domain_geometry	geometry;
> @@ -115,6 +116,12 @@ struct viommu_endpoint {
>  	void				*pgtf;
>  };
>  
> +struct viommu_ep_entry {
> +	u32				eid;
> +	struct viommu_endpoint		*vdev;
> +	struct list_head		list;
> +};

No need for a separate struct, I think you can just add the list head and
id into viommu_endpoint.

> +
>  struct viommu_request {
>  	struct list_head		list;
>  	void				*writeback;
> @@ -573,6 +580,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  	size_t probe_len;
>  	struct virtio_iommu_req_probe *probe;
>  	struct virtio_iommu_probe_property *prop;
> +	struct viommu_ep_entry *ep;
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  
> @@ -640,6 +648,18 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  		prop = (void *)probe->properties + cur;
>  		type = le16_to_cpu(prop->type) & VIRTIO_IOMMU_PROBE_T_MASK;
>  	}
> +	if (ret)
> +		goto out_free;
> +
> +	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
> +	if (!ep) {
> +		ret = -ENOMEM;
> +		goto out_free;
> +	}
> +	ep->eid = probe->endpoint;
> +	ep->vdev = vdev;
> +
> +	list_add(&ep->list, &viommu->endpoints);

This should be in viommu_probe_device() (viommu_probe_endpoint() is only
called if F_PROBE is negotiated). I think we need a lock for this
list/xarray

Thanks,
Jean

>  
>  out_free:
>  	kfree(probe);
> @@ -1649,6 +1669,7 @@ static int viommu_probe(struct virtio_device *vdev)
>  	viommu->dev = dev;
>  	viommu->vdev = vdev;
>  	INIT_LIST_HEAD(&viommu->requests);
> +	INIT_LIST_HEAD(&viommu->endpoints);
>  
>  	ret = viommu_init_vqs(viommu);
>  	if (ret)
> -- 
> 2.17.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
