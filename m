Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11523C433F5
	for <virtualization@archiver.kernel.org>; Sat, 27 Nov 2021 17:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BD1D40253;
	Sat, 27 Nov 2021 17:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zLWOvT287ktq; Sat, 27 Nov 2021 17:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1382E40211;
	Sat, 27 Nov 2021 17:09:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEBEBC0012;
	Sat, 27 Nov 2021 17:09:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF020C000A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9F7340141
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kJFwlJrXDjVJ
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:09:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D20740010
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638032985;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFe5yi/mr65ynfmwsUKvWvB/XkbIsXm8YUYXCa3ZMc0=;
 b=gSoLKpVcNyaxqlDAYfUKK4pFisNVyMXTxLKAs9FOtyJKi3xcCt8gA4UjB6po4yw/DTarsK
 hnGTO7mC5a9uWhwW6Wjr8LgtzsKXcuUIO2PeSCn1th0eeVnXaA2QYi3BKRqdAVTzAT8z7o
 N7iosy7nAtKAdOaFKlsUKW18+Pm4Lu0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-rZuZ5DEtNLuxoy9hVgRhlA-1; Sat, 27 Nov 2021 12:09:44 -0500
X-MC-Unique: rZuZ5DEtNLuxoy9hVgRhlA-1
Received: by mail-wr1-f70.google.com with SMTP id
 d18-20020adfe852000000b001985d36817cso2053774wrn.13
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 09:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=KFe5yi/mr65ynfmwsUKvWvB/XkbIsXm8YUYXCa3ZMc0=;
 b=gJ3kIKFZJZyUhP7ESwrIi7W+B1yzGbsMN6MA4uMDq9VSZJSvouRmiLkoPU8wBAHWmd
 Zd4UYlAE7yF4KK7JJcnkHIuu8b+e4YIHGtIm4j5PxzHmhLNif6bnVEwtcrYML82LiBDd
 4WLMkYosgZdZfYCtGmrXXe6+WrbrZXv6C+wYZWPpu3Evwr5m3HhTmzwyHyLJjoToZSvp
 4c8VJbGHxPGNiNc47QN1YqWBoO0vVJ5IJ4aC6XwI+22L51kqPkrgTNkLd6VAHLceTzHw
 hKtbKwv9tm+vnehBaY6wce4/GwaAmcdsD8o59Alv3VMy740MP8EY6OZ61SxDmqbHhhmo
 9Nww==
X-Gm-Message-State: AOAM532sUd+eL5EgPTdj3YjrlTb4t+YUwPgPFS5tv9t6TX8/ykxKMpcb
 jT3/oSvfGyJVb9swaVSWyF7lv7MYs5Qk/igyhsTuRCBQKGq7NKQobiPVONxsKhqKAJn5Sy2LVUh
 XVUpfrjaoB13YehYt7lv1QWD+uiK1U+GGhb/XRmavHg==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr21446984wrt.93.1638032982914; 
 Sat, 27 Nov 2021 09:09:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKkAndP1VxD/wPVzJiOOQlf4hxPHuE1NhzAzQNf9jHdgC1HjQtChnnWsj8U3KacpCaoBgyEg==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr21446941wrt.93.1638032982584; 
 Sat, 27 Nov 2021 09:09:42 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id e8sm8682624wrr.26.2021.11.27.09.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Nov 2021 09:09:41 -0800 (PST)
Subject: Re: [PATCH v2 4/5] iommu/virtio: Pass end address to
 viommu_add_mapping()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org, mst@redhat.com, jasowang@redhat.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-5-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <7b79fe9b-9d51-8bda-2868-b48781f07fc9@redhat.com>
Date: Sat, 27 Nov 2021 18:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-5-jean-philippe@linaro.org>
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



On 11/23/21 4:53 PM, Jean-Philippe Brucker wrote:
> To support identity mappings, the virtio-iommu driver must be able to
> represent full 64-bit ranges internally. Pass (start, end) instead of
> (start, size) to viommu_add/del_mapping().
>
> Clean comments. The one about the returned size was never true: when
> sweeping the whole address space the returned size will most certainly
> be smaller than 2^64.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  drivers/iommu/virtio-iommu.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index d63ec4d11b00..eceb9281c8c1 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -311,8 +311,8 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
>   *
>   * On success, return the new mapping. Otherwise return NULL.
>   */
> -static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> -			      phys_addr_t paddr, size_t size, u32 flags)
> +static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
> +			      phys_addr_t paddr, u32 flags)
>  {
>  	unsigned long irqflags;
>  	struct viommu_mapping *mapping;
> @@ -323,7 +323,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
>  
>  	mapping->paddr		= paddr;
>  	mapping->iova.start	= iova;
> -	mapping->iova.last	= iova + size - 1;
> +	mapping->iova.last	= end;
>  	mapping->flags		= flags;
>  
>  	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
> @@ -338,26 +338,24 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
>   *
>   * @vdomain: the domain
>   * @iova: start of the range
> - * @size: size of the range. A size of 0 corresponds to the entire address
> - *	space.
> + * @end: end of the range
>   *
> - * On success, returns the number of unmapped bytes (>= size)
> + * On success, returns the number of unmapped bytes
>   */
>  static size_t viommu_del_mappings(struct viommu_domain *vdomain,
> -				  unsigned long iova, size_t size)
> +				  u64 iova, u64 end)
>  {
>  	size_t unmapped = 0;
>  	unsigned long flags;
> -	unsigned long last = iova + size - 1;
>  	struct viommu_mapping *mapping = NULL;
>  	struct interval_tree_node *node, *next;
>  
>  	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> -	next = interval_tree_iter_first(&vdomain->mappings, iova, last);
> +	next = interval_tree_iter_first(&vdomain->mappings, iova, end);
>  	while (next) {
>  		node = next;
>  		mapping = container_of(node, struct viommu_mapping, iova);
> -		next = interval_tree_iter_next(node, iova, last);
> +		next = interval_tree_iter_next(node, iova, end);
>  
>  		/* Trying to split a mapping? */
>  		if (mapping->iova.start < iova)
> @@ -656,8 +654,8 @@ static void viommu_domain_free(struct iommu_domain *domain)
>  {
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> -	/* Free all remaining mappings (size 2^64) */
> -	viommu_del_mappings(vdomain, 0, 0);
> +	/* Free all remaining mappings */
> +	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
>  
>  	if (vdomain->viommu)
>  		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
> @@ -742,6 +740,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  {
>  	int ret;
>  	u32 flags;
> +	u64 end = iova + size - 1;
>  	struct virtio_iommu_req_map map;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> @@ -752,7 +751,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  	if (flags & ~vdomain->map_flags)
>  		return -EINVAL;
>  
> -	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
> +	ret = viommu_add_mapping(vdomain, iova, end, paddr, flags);
>  	if (ret)
>  		return ret;
>  
> @@ -761,7 +760,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  		.domain		= cpu_to_le32(vdomain->id),
>  		.virt_start	= cpu_to_le64(iova),
>  		.phys_start	= cpu_to_le64(paddr),
> -		.virt_end	= cpu_to_le64(iova + size - 1),
> +		.virt_end	= cpu_to_le64(end),
>  		.flags		= cpu_to_le32(flags),
>  	};
>  
> @@ -770,7 +769,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  
>  	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
>  	if (ret)
> -		viommu_del_mappings(vdomain, iova, size);
> +		viommu_del_mappings(vdomain, iova, end);
>  
>  	return ret;
>  }
> @@ -783,7 +782,7 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
>  	struct virtio_iommu_req_unmap unmap;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> -	unmapped = viommu_del_mappings(vdomain, iova, size);
> +	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
>  	if (unmapped < size)
>  		return 0;
>  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
