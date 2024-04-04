Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7D823D0
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Apr 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244586; cv=none; b=PLyXzwlbs+dCE5kG1u+scAm8m9PYCMj+3Impkk0vgkgF14TxWbVgfgF+aHdMTjxMiqn7NqeLqlEdxqUque8YrpVFRgRr9ccDq+3b7lqvs5L36bR7dde+FdTa9KS3djnoRkhSrXRXRIaxHbSW3llDQK0fq+vUCk+bZCj4XCNZSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244586; c=relaxed/simple;
	bh=zfakYO7CS29y5adFO9lRm1TfVsKhvUUh8TJ3RmzDees=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lc1yzFZ5Dt8j7R4ZJMLq5GbWCOzCcinF3/+IpU1P+9AIv5+2+XAVN9kCUK7ONnxm0muX2HincDDS7jyvQ22SY6Z6kMh4hc3M6gmFxWSq0HFXjEKJUNZ/fsm6aZ9isSzqkvCC7irRSW0z6lACXLy98gbB7qu2OBBtxJOql0hQ3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bTFCO1zG; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bTFCO1zG"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84F4641B9C
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Apr 2024 15:29:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BvqsxpMe8o6Y for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Apr 2024 15:29:42 +0000 (UTC)
X-Greylist: delayed 346 seconds by postgrey-1.37 at util1.osuosl.org; Thu, 04 Apr 2024 15:29:42 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 267A041B08
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 267A041B08
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bTFCO1zG
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.235.227.194; helo=madrid.collaboradmins.com; envelope-from=dmitry.osipenko@collabora.com; receiver=<UNKNOWN> 
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 267A041B08
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Apr 2024 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712244233;
	bh=zfakYO7CS29y5adFO9lRm1TfVsKhvUUh8TJ3RmzDees=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bTFCO1zGGbjB8onR6iZ4lBCNh9FODnJT9hBCwn4S/byXbNgUKQM9toMO9XrndQ0sn
	 qN1C3bs0FtXvkvghDMLs4VoksoBiBAdoEi8z8S/ZHKoP0zHcK01EtlLnzRB6B46GxZ
	 y9YZW4dA7xN6p2plCxTlDcQiNDOwEA/g5h8QgxHimdtOHgbwwcOoH6XYmoHVp7VOiq
	 zz+qjkcJTgYrcWfk1bUp05IVfCu+m0j3MQ/vFojMOFoDUFfVjDNuAKLDIcYaJOZni4
	 H8YIyU88BGwX6iL83kGnIL6tcagzZMEJUuUcMppg8pxiGQIvXIK+ddTGr8/sJfarmJ
	 ySE3ee9VaUySQ==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B892D37813A4;
	Thu,  4 Apr 2024 15:23:51 +0000 (UTC)
Message-ID: <1f23ab7a-334c-4d7d-b917-8e8029e6c690@collabora.com>
Date: Thu, 4 Apr 2024 18:23:49 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 17/30] drm/panfrost: Fix the error path in
 panfrost_mmu_map_fault_addr()
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org,
 David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Emma Anholt <emma@anholt.net>,
 Melissa Wen <mwen@igalia.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-18-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20240105184624.508603-18-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 21:46, Dmitry Osipenko wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> If some the pages or sgt allocation failed, we shouldn't release the
> pages ref we got earlier, otherwise we will end up with unbalanced
> get/put_pages() calls. We should instead leave everything in place
> and let the BO release function deal with extra cleanup when the object
> is destroyed, or let the fault handler try again next time it's called.
> 
> Fixes: 187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index bd5a0073009d..4a0b4bf03f1a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -502,11 +502,18 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  	mapping_set_unevictable(mapping);
>  
>  	for (i = page_offset; i < page_offset + NUM_FAULT_PAGES; i++) {
> +		/* Can happen if the last fault only partially filled this
> +		 * section of the pages array before failing. In that case
> +		 * we skip already filled pages.
> +		 */
> +		if (pages[i])
> +			continue;
> +
>  		pages[i] = shmem_read_mapping_page(mapping, i);
>  		if (IS_ERR(pages[i])) {
>  			ret = PTR_ERR(pages[i]);
>  			pages[i] = NULL;
> -			goto err_pages;
> +			goto err_unlock;
>  		}
>  	}
>  
> @@ -514,7 +521,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
>  					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
>  	if (ret)
> -		goto err_pages;
> +		goto err_unlock;
>  
>  	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL, 0);
>  	if (ret)
> @@ -537,8 +544,6 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  
>  err_map:
>  	sg_free_table(sgt);
> -err_pages:
> -	drm_gem_shmem_put_pages_locked(&bo->base);
>  err_unlock:
>  	dma_resv_unlock(obj->resv);
>  err_bo:

Applied to misc-fixes

Forgot that this patch doesn't depend on others in this series, sorry
for not doing it earlier

-- 
Best regards,
Dmitry

