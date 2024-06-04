Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F942145A0D
	for <virtualization@lists.linux.dev>; Tue,  4 Jun 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502144; cv=none; b=tlPDRLTnChni27UiAuUF3OG0BMqvI89+ZYeFqkcivIHe9LdqOP4VqDGaqMbHzRINexIM5fOD4gYzFQFDVYECe439enV5kFf5NPbi685yaSiHVv9wb4RJ+MEGbVZILHaJRS4IH6IYTArYsB15yVHkM0X8ydiHd3e/vGmMxBQCaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502144; c=relaxed/simple;
	bh=F1drlEwszPU9F0tuO69yMHTYmBReoRJFrrPImhmczTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KcYTGJlErDye4zCMkL6mOZ+Xk922iaAM1C6myZz62dkHeqz+eoEzIVrH/pwjYL6SdxBTZj6p+T7ctur4DetGYMPvgyCayY6XIRkHedgK83+WkH0e7Lc7W40V5IXq5yart6RGkpabMufNPLybcgdbLWaPulbCaey2UZh8+vPZlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PL3k+5Jz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PL3k+5Jz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717502140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPK651wHYrkYBCXh8jpOOzyZoFpupY8aSft7y4xq4W8=;
	b=PL3k+5Jz+yA8jTivcoIPBdarf40RJFXD9Y1q4LayQVf/9y6rNqddZ8Jp3nG7nwvD+F3q7g
	urbRBJoXsRGk6l6uLVAXlUfns3ZnFlpKWxwmpltWPWN89BDVhiBlpwY3fUFoJWRtZceUOv
	t4PvYnGbUcv5B6dCEvlCXeeBnbDEQ3U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-LYAfQiN3OBu8Iyq42vi29w-1; Tue, 04 Jun 2024 07:55:39 -0400
X-MC-Unique: LYAfQiN3OBu8Iyq42vi29w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35e808b1db8so247695f8f.1
        for <virtualization@lists.linux.dev>; Tue, 04 Jun 2024 04:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717502138; x=1718106938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPK651wHYrkYBCXh8jpOOzyZoFpupY8aSft7y4xq4W8=;
        b=fLEWI1IBJ7iPjkskW9G0ocIMVkwzsb5Iykdie3OkvWSAkxWiRs6pBC0+YQlykZdep7
         JUtFwsL3L5kT06WPtP2IimM2Xfqwu29GKit8EohVqg1x08jfU82UrG3rVNVSapmo7pw8
         sFScL59yqe5DuZVSKe9zEFxKCnAmEoL0IiBGOS8PECu6sW2y5EAT4Yz/tVORbvtabFLL
         N5hfGOzzzSEHu9KYlUwvTuqG/5KGFh6qBSSUEZc2ARIraS2ZwgUwCZUK0r2/xQTYqYV0
         6xXZvJpx4y0a9qp9QiZKOd8VyMtovtgKxyiCAaPBhR+Bkd1NY07DKD2t7KVWIBMFuU/6
         pTZA==
X-Forwarded-Encrypted: i=1; AJvYcCUsc8zFHNfbeQRtCl1rCEZemNMJGKucoq0r6azsd0JfU479uzR5FwZ1R5ervGpc4MP1Ja2T+b2dfE3hm5413+OkTka5tQa/qOXt4McqYJ8=
X-Gm-Message-State: AOJu0YyQAewSBcVNlgT/ivvFV2/zXehoAQW7KTret6cvdGP7Z/Yz2ImY
	V+tHyTCXtULU6Ir8YOsKNaMChLe3EZ/PvpBTIvDtWU/RO9P6HXyrUkphhFGO9T1k/XQjmr/VdC7
	mTQa+oyVbR97JJ+qXB8OUc7/s8mP+bN6WmUj7UGy3Ouc6Cph+T/rby1Utb9tvKODX
X-Received: by 2002:a5d:400e:0:b0:351:b130:45c2 with SMTP id ffacd0b85a97d-35e7c54b270mr2388403f8f.14.1717502138509;
        Tue, 04 Jun 2024 04:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5YmUTkrAQDfHoDcyYwJ45C3sk3mPdapxdGOCihWWjx8N1UxmvRgBSSSw0kLMmoTen9a9x3Q==
X-Received: by 2002:a5d:400e:0:b0:351:b130:45c2 with SMTP id ffacd0b85a97d-35e7c54b270mr2388383f8f.14.1717502138120;
        Tue, 04 Jun 2024 04:55:38 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-171.retail.telecomitalia.it. [82.53.134.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e0f97ba3csm10968582f8f.73.2024.06.04.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 04:55:37 -0700 (PDT)
Date: Tue, 4 Jun 2024 13:55:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, mst@redhat.com, vattunuru@marvell.com, sthotton@marvell.com, 
	ndabilpuram@marvell.com, jerinj@marvell.com
Subject: Re: [PATCH] vdpa: Add support for no-IOMMU mode
Message-ID: <s5tkqdls55n535tvrlalsej44hvrzqgcdqkspyxrvnl4muard6@nyvdw7xptoze>
References: <20240530101823.1210161-1-schalla@marvell.com>
 <CACGkMEsxPfck-Ww6CHSod5wP5xLOpS3t2B8qhTL0=PoE3koCGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsxPfck-Ww6CHSod5wP5xLOpS3t2B8qhTL0=PoE3koCGQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 31, 2024 at 10:26:31AM GMT, Jason Wang wrote:
>On Thu, May 30, 2024 at 6:18 PM Srujana Challa <schalla@marvell.com> wrote:
>>
>> This commit introduces support for an UNSAFE, no-IOMMU mode in the
>> vhost-vdpa driver. When enabled, this mode provides no device isolation,
>> no DMA translation, no host kernel protection, and cannot be used for
>> device assignment to virtual machines. It requires RAWIO permissions
>> and will taint the kernel.
>> This mode requires enabling the "enable_vhost_vdpa_unsafe_noiommu_mode"
>> option on the vhost-vdpa driver. This mode would be useful to get
>> better performance on specifice low end machines and can be leveraged
>> by embedded platforms where applications run in controlled environment.
>
>I wonder if it's better to do it per driver:
>
>1) we have device that use its own IOMMU, one example is the mlx5 vDPA device
>2) we have software devices which doesn't require IOMMU at all (but
>still with protection)

It worries me even if the module parameter is the best thing.
What about a sysfs entry?

Thanks,
Stefano

>
>Thanks
>
>>
>> Signed-off-by: Srujana Challa <schalla@marvell.com>
>> ---
>>  drivers/vhost/vdpa.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index bc4a51e4638b..d071c30125aa 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -36,6 +36,11 @@ enum {
>>
>>  #define VHOST_VDPA_IOTLB_BUCKETS 16
>>
>> +bool vhost_vdpa_noiommu;
>> +module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
>> +                  vhost_vdpa_noiommu, bool, 0644);
>> +MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode, "Enable UNSAFE, no-IOMMU mode.  This mode provides no device isolation, no DMA translation, no host kernel protection, cannot be used for device assignment to virtual machines, requires RAWIO permissions, and will taint the kernel.  If you do not know what this is for, step away. (default: false)");
>> +
>>  struct vhost_vdpa_as {
>>         struct hlist_node hash_link;
>>         struct vhost_iotlb iotlb;
>> @@ -60,6 +65,7 @@ struct vhost_vdpa {
>>         struct vdpa_iova_range range;
>>         u32 batch_asid;
>>         bool suspended;
>> +       bool noiommu_en;
>>  };
>>
>>  static DEFINE_IDA(vhost_vdpa_ida);
>> @@ -887,6 +893,10 @@ static void vhost_vdpa_general_unmap(struct vhost_vdpa *v,
>>  {
>>         struct vdpa_device *vdpa = v->vdpa;
>>         const struct vdpa_config_ops *ops = vdpa->config;
>> +
>> +       if (v->noiommu_en)
>> +               return;
>> +
>>         if (ops->dma_map) {
>>                 ops->dma_unmap(vdpa, asid, map->start, map->size);
>>         } else if (ops->set_map == NULL) {
>> @@ -980,6 +990,9 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>>         if (r)
>>                 return r;
>>
>> +       if (v->noiommu_en)
>> +               goto skip_map;
>> +
>>         if (ops->dma_map) {
>>                 r = ops->dma_map(vdpa, asid, iova, size, pa, perm, opaque);
>>         } else if (ops->set_map) {
>> @@ -995,6 +1008,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>>                 return r;
>>         }
>>
>> +skip_map:
>>         if (!vdpa->use_va)
>>                 atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
>>
>> @@ -1298,6 +1312,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>>         struct vdpa_device *vdpa = v->vdpa;
>>         const struct vdpa_config_ops *ops = vdpa->config;
>>         struct device *dma_dev = vdpa_get_dma_dev(vdpa);
>> +       struct iommu_domain *domain;
>>         const struct bus_type *bus;
>>         int ret;
>>
>> @@ -1305,6 +1320,14 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>>         if (ops->set_map || ops->dma_map)
>>                 return 0;
>>
>> +       domain = iommu_get_domain_for_dev(dma_dev);
>> +       if ((!domain || domain->type == IOMMU_DOMAIN_IDENTITY) &&
>> +           vhost_vdpa_noiommu && capable(CAP_SYS_RAWIO)) {
>> +               add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>> +               dev_warn(&v->dev, "Adding kernel taint for noiommu on device\n");
>> +               v->noiommu_en = true;
>> +               return 0;
>> +       }
>>         bus = dma_dev->bus;
>>         if (!bus)
>>                 return -EFAULT;
>> --
>> 2.25.1
>>
>
>

