Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E88AC5519F
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:30:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8841B206F9
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZ7uxCLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8841B206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4ADD27404;
	Wed, 25 Nov 2020 09:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ak5IOoURJjTi; Wed, 25 Nov 2020 09:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 788A4203F2;
	Wed, 25 Nov 2020 09:30:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 578D2C163C;
	Wed, 25 Nov 2020 09:30:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30776C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2C82486946
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QrVvDLzcVxpU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:30:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 62D70849D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606296619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5ijUdlPbjuoWrXXDFOXREtxJfQXFxDa6K+nnhuKKjM=;
 b=SZ7uxCLXQI2bSTupHneLP9QJvA36MynSdx2FfmvtfRKUno6y2Wg0xY6fw7KjipNF9goHhE
 fCSkgjoZNly+SQub/SV1H92v6bLYxplCX/86EdgnUajFjzYbWZ51Y+oKgzw9FoIy/GEg4/
 YALggH6tUju4F0sCmwSSC1I2lk94c3g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-GAx6dYxFNreaSMCDj2Crpg-1; Wed, 25 Nov 2020 04:30:17 -0500
X-MC-Unique: GAx6dYxFNreaSMCDj2Crpg-1
Received: by mail-wr1-f70.google.com with SMTP id l5so552683wrn.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 01:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P5ijUdlPbjuoWrXXDFOXREtxJfQXFxDa6K+nnhuKKjM=;
 b=F0i2SbSohLY0ZYnmuqi0qKgL6wA4yaNH/WSTuWzqOg2nQzCMOsmDck583CjeOaZ/tG
 vxq39KDrIq54hnmRxV/bCqh4wcIh+ScwWo5fhxhLGYKZqGRsq1bL5DWdbT02V9LuXh+Q
 ZB60aOASfhTBaKiHPzeWB9xZRWngpa7xQnG+8DxFZvgitdd8hjqeDrXhDeiJltJfzVrV
 aQSv6UNx393OtDYNOINY6m5UiU78p77GOgImDiqEFG95ld+H3cz4rWzNLlK+0Yaov+jr
 GNzn6mp82ElTIkFdDSCDbdKz9iMJHezVUpWmcORLKsPyyCXI9/p7BBJXlYiFZNCzvQ7h
 Jbcg==
X-Gm-Message-State: AOAM531hsrqgbdS+yp4OrNBOgn7Cb9Q04dOd2I4/a1NK2Cjtr30UXind
 ajx2ALWNOHgGF0oqJ1Td1D3faun9SAYwz11CHa9bLnb7FDHPzKelTjq+COziyVP/L1UOx1MzH4r
 taLI+sJH9AgLj4QDLYEAq7PJIM4Qe5Vu2OP/rMEVH7w==
X-Received: by 2002:adf:9461:: with SMTP id 88mr3010749wrq.171.1606296615853; 
 Wed, 25 Nov 2020 01:30:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGsDNQ+/xp7pKOrcW8bWMYdD6vIYpIHxZVMhpT9C2+RaEkv/dTrGDdRIUMU3zog4xL+VQWPw==
X-Received: by 2002:adf:9461:: with SMTP id 88mr3010720wrq.171.1606296615673; 
 Wed, 25 Nov 2020 01:30:15 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id i11sm3746755wro.85.2020.11.25.01.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 01:30:14 -0800 (PST)
Date: Wed, 25 Nov 2020 04:30:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v3] vhost-vdpa: fix page pinning leakage in error path
 (rework)
Message-ID: <20201125042834-mutt-send-email-mst@kernel.org>
References: <1604618793-4681-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1604618793-4681-1-git-send-email-si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lingshan.zhu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com
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

On Thu, Nov 05, 2020 at 06:26:33PM -0500, Si-Wei Liu wrote:
> Pinned pages are not properly accounted particularly when
> mapping error occurs on IOTLB update. Clean up dangling
> pinned pages for the error path.
> 
> The memory usage for bookkeeping pinned pages is reverted
> to what it was before: only one single free page is needed.
> This helps reduce the host memory demand for VM with a large
> amount of memory, or in the situation where host is running
> short of free memory.
> 
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>


Not sure which tree this is against, I had to apply this with
minor tweaks. Pls take a look at the vhost tree and
let me know whether it looks ok to you.

> ---
> Changes in v3:
> - Turn explicit last_pfn check to a WARN_ON() (Jason)
> 
> Changes in v2:
> - Drop the reversion patch
> - Fix unhandled page leak towards the end of page_list
> 
>  drivers/vhost/vdpa.c | 80 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 62 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b6d9016..5b13dfd 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>  
>  	if (r)
>  		vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
> +	else
> +		atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
>  
>  	return r;
>  }
> @@ -591,14 +593,16 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>  	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> -	unsigned long locked, lock_limit, pinned, i;
> +	unsigned long lock_limit, sz2pin, nchunks, i;
>  	u64 iova = msg->iova;
> +	long pinned;
>  	int ret = 0;
>  
>  	if (vhost_iotlb_itree_first(iotlb, msg->iova,
>  				    msg->iova + msg->size - 1))
>  		return -EEXIST;
>  
> +	/* Limit the use of memory for bookkeeping */
>  	page_list = (struct page **) __get_free_page(GFP_KERNEL);
>  	if (!page_list)
>  		return -ENOMEM;
> @@ -607,52 +611,75 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>  		gup_flags |= FOLL_WRITE;
>  
>  	npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> PAGE_SHIFT;
> -	if (!npages)
> -		return -EINVAL;
> +	if (!npages) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
>  
>  	mmap_read_lock(dev->mm);
>  
> -	locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>  	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -
> -	if (locked > lock_limit) {
> +	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>  		ret = -ENOMEM;
> -		goto out;
> +		goto unlock;
>  	}
>  
>  	cur_base = msg->uaddr & PAGE_MASK;
>  	iova &= PAGE_MASK;
> +	nchunks = 0;
>  
>  	while (npages) {
> -		pinned = min_t(unsigned long, npages, list_size);
> -		ret = pin_user_pages(cur_base, pinned,
> -				     gup_flags, page_list, NULL);
> -		if (ret != pinned)
> +		sz2pin = min_t(unsigned long, npages, list_size);
> +		pinned = pin_user_pages(cur_base, sz2pin,
> +					gup_flags, page_list, NULL);
> +		if (sz2pin != pinned) {
> +			if (pinned < 0) {
> +				ret = pinned;
> +			} else {
> +				unpin_user_pages(page_list, pinned);
> +				ret = -ENOMEM;
> +			}
>  			goto out;
> +		}
> +		nchunks++;
>  
>  		if (!last_pfn)
>  			map_pfn = page_to_pfn(page_list[0]);
>  
> -		for (i = 0; i < ret; i++) {
> +		for (i = 0; i < pinned; i++) {
>  			unsigned long this_pfn = page_to_pfn(page_list[i]);
>  			u64 csize;
>  
>  			if (last_pfn && (this_pfn != last_pfn + 1)) {
>  				/* Pin a contiguous chunk of memory */
>  				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
> -				if (vhost_vdpa_map(v, iova, csize,
> -						   map_pfn << PAGE_SHIFT,
> -						   msg->perm))
> +				ret = vhost_vdpa_map(v, iova, csize,
> +						     map_pfn << PAGE_SHIFT,
> +						     msg->perm);
> +				if (ret) {
> +					/*
> +					 * Unpin the pages that are left unmapped
> +					 * from this point on in the current
> +					 * page_list. The remaining outstanding
> +					 * ones which may stride across several
> +					 * chunks will be covered in the common
> +					 * error path subsequently.
> +					 */
> +					unpin_user_pages(&page_list[i],
> +							 pinned - i);
>  					goto out;
> +				}
> +
>  				map_pfn = this_pfn;
>  				iova += csize;
> +				nchunks = 0;
>  			}
>  
>  			last_pfn = this_pfn;
>  		}
>  
> -		cur_base += ret << PAGE_SHIFT;
> -		npages -= ret;
> +		cur_base += pinned << PAGE_SHIFT;
> +		npages -= pinned;
>  	}
>  
>  	/* Pin the rest chunk */
> @@ -660,10 +687,27 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>  			     map_pfn << PAGE_SHIFT, msg->perm);
>  out:
>  	if (ret) {
> +		if (nchunks) {
> +			unsigned long pfn;
> +
> +			/*
> +			 * Unpin the outstanding pages which are yet to be
> +			 * mapped but haven't due to vdpa_map() or
> +			 * pin_user_pages() failure.
> +			 *
> +			 * Mapped pages are accounted in vdpa_map(), hence
> +			 * the corresponding unpinning will be handled by
> +			 * vdpa_unmap().
> +			 */
> +			WARN_ON(!last_pfn);
> +			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
> +				unpin_user_page(pfn_to_page(pfn));
> +		}
>  		vhost_vdpa_unmap(v, msg->iova, msg->size);
> -		atomic64_sub(npages, &dev->mm->pinned_vm);
>  	}
> +unlock:
>  	mmap_read_unlock(dev->mm);
> +free:
>  	free_page((unsigned long)page_list);
>  	return ret;
>  }
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
