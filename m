Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8E1CA96
	for <virtualization@lists.linux.dev>; Wed, 17 Jul 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209824; cv=none; b=R1V/GYA15AxDxZoxWM0kiNwXb1IxTadJpNqcIZcHX62p1R1vXPrgP4m3hkRAMo3wpp4BLQLb/QRAWbJYUpHDSYElwR9yQ9hHH2iwslbz/GSAyuvNnh8u3BPr3WgwgmQcj+TsgQ/8cwK8T9ceIMvwwqAJY1HUidmTmuD17YALnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209824; c=relaxed/simple;
	bh=1GWDLi+rpH5kf8UEfpUbvHAag3ZG04JK6FiCae7FEdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IbQgYYbxL/RgNchbCg2fRj1mU1Wt3RZtH6ijUdu+7NGTRdAIlqtrFGhKj6YI6kc11nWlu6fT6RTbv4ekPWRns4V/FiVet7FACQAjpXUU+z4LBj2l3J/jxE1FA4GLs+HrHvVEbu918R+4dQJVcoTGw+Lbjyv8pmi31ZjNGyXHAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYfCaCuc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYfCaCuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721209821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5c0R7RDnqopCcCZP1eZaSuKmjpWay3dHbgxoGXMIDE=;
	b=NYfCaCucFcJQE//GJzQs4QYKBfjcawU37YRrd4P2F9qApe7O67PQpE9VaJiJobbKxCXqAE
	3arccdlQShR8VY5XoVKJEuzsSs+MVMQhY2VqlBYxFry9xNApnuEjoIvMymCWhYa3OmA3zT
	IBFJZsTAkiqcHlcro+5bzP28uUF6m0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-zZvj0FxUMf-YiJOyK-lKaw-1; Wed, 17 Jul 2024 05:50:19 -0400
X-MC-Unique: zZvj0FxUMf-YiJOyK-lKaw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3678f403afaso3872872f8f.0
        for <virtualization@lists.linux.dev>; Wed, 17 Jul 2024 02:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721209818; x=1721814618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5c0R7RDnqopCcCZP1eZaSuKmjpWay3dHbgxoGXMIDE=;
        b=rDFldDorBqEHtzgb4WU084ujryFdM4tFhvFcsza4WUwNQTgVeeB9k0L+Fvv9Bk6gPl
         lm7IJsgPZE2SyDJhNjzysV968sDooW3G4hAgV3+NZSHBCDGPe4pqL1fJ5FV++Yd7X9zS
         w9QiI1mO1atDxRMERH9tKipNjsoPRLw9Sn42l2ztjwUGZc93szs9ZatJvFCXsnabNjcU
         QXp5/j4MbouLWzwTkFLvEu+Q6Qt0EHOHQ6sMCcYt2czV9yiQA74l42yDgoTGqy2i+ypw
         bFYjbEN3QarV49W2avY1pQuscBYkxTo0qA6dF+3JF6lELNTmfzvEDtc1s/XmQ+TdIAF+
         gapQ==
X-Gm-Message-State: AOJu0Yynp+FLXIvPpVt+algqaBiouL6UIvGRiI/IDB6LbTNpPtOaEKZh
	Xil7S8p91mLqdwIWMitNqJwmdDUMlnYlLZJ1gcTZwTbP3O9fRqfd/2i5N5p5J3wzI9WJl6DgkG5
	pjweuwuu1HdKH+t3P5TStcBf853WMbfaQZdWSmW6WwoFOEe4AbZ5MJG5ctv/4FzEh
X-Received: by 2002:a5d:5385:0:b0:362:7c2e:e9f7 with SMTP id ffacd0b85a97d-3683165b58cmr950848f8f.32.1721209818158;
        Wed, 17 Jul 2024 02:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnZDMUmEl0a9ZjZlUyXEG0/8IGoPV7z2kmIum/zE5asvvqWw8BO8/MquAo8rD6ksuXJmeMVQ==
X-Received: by 2002:a5d:5385:0:b0:362:7c2e:e9f7 with SMTP id ffacd0b85a97d-3683165b58cmr950822f8f.32.1721209817548;
        Wed, 17 Jul 2024 02:50:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:360d:da73:bbf7:ba86:37fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb939sm11239854f8f.89.2024.07.17.02.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 02:50:16 -0700 (PDT)
Date: Wed, 17 Jul 2024 05:50:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org,
	jasowang@redhat.com, vattunuru@marvell.com, sthotton@marvell.com,
	ndabilpuram@marvell.com, jerinj@marvell.com
Subject: Re: [PATCH] vdpa: Add support for no-IOMMU mode
Message-ID: <20240717054547-mutt-send-email-mst@kernel.org>
References: <20240530101823.1210161-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240530101823.1210161-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 03:48:23PM +0530, Srujana Challa wrote:
> This commit introduces support for an UNSAFE, no-IOMMU mode in the
> vhost-vdpa driver. When enabled, this mode provides no device isolation,
> no DMA translation, no host kernel protection, and cannot be used for
> device assignment to virtual machines. It requires RAWIO permissions
> and will taint the kernel.
> This mode requires enabling the "enable_vhost_vdpa_unsafe_noiommu_mode"
> option on the vhost-vdpa driver. This mode would be useful to get
> better performance on specifice low end machines and can be leveraged
> by embedded platforms where applications run in controlled environment.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>

Thought hard about that.
I think given vfio supports this, we can do that too, and
the extension is small.

However, it looks like setting this parameter will automatically
change the behaviour for existing userspace when IOMMU_DOMAIN_IDENTITY
is set.

I suggest a new domain type for use just for this purpose.  This way if
host has an iommu, then the same kernel can run both VMs with
isolation and unsafe embedded apps without.

> ---
>  drivers/vhost/vdpa.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..d071c30125aa 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -36,6 +36,11 @@ enum {
>  
>  #define VHOST_VDPA_IOTLB_BUCKETS 16
>  
> +bool vhost_vdpa_noiommu;
> +module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
> +		   vhost_vdpa_noiommu, bool, 0644);
> +MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode, "Enable UNSAFE, no-IOMMU mode.  This mode provides no device isolation, no DMA translation, no host kernel protection, cannot be used for device assignment to virtual machines, requires RAWIO permissions, and will taint the kernel.  If you do not know what this is for, step away. (default: false)");
> +
>  struct vhost_vdpa_as {
>  	struct hlist_node hash_link;
>  	struct vhost_iotlb iotlb;
> @@ -60,6 +65,7 @@ struct vhost_vdpa {
>  	struct vdpa_iova_range range;
>  	u32 batch_asid;
>  	bool suspended;
> +	bool noiommu_en;
>  };
>  
>  static DEFINE_IDA(vhost_vdpa_ida);
> @@ -887,6 +893,10 @@ static void vhost_vdpa_general_unmap(struct vhost_vdpa *v,
>  {
>  	struct vdpa_device *vdpa = v->vdpa;
>  	const struct vdpa_config_ops *ops = vdpa->config;
> +
> +	if (v->noiommu_en)
> +		return;
> +
>  	if (ops->dma_map) {
>  		ops->dma_unmap(vdpa, asid, map->start, map->size);
>  	} else if (ops->set_map == NULL) {
> @@ -980,6 +990,9 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  	if (r)
>  		return r;
>  
> +	if (v->noiommu_en)
> +		goto skip_map;
> +
>  	if (ops->dma_map) {
>  		r = ops->dma_map(vdpa, asid, iova, size, pa, perm, opaque);
>  	} else if (ops->set_map) {
> @@ -995,6 +1008,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  		return r;
>  	}
>  
> +skip_map:
>  	if (!vdpa->use_va)
>  		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
>  
> @@ -1298,6 +1312,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  	struct vdpa_device *vdpa = v->vdpa;
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
> +	struct iommu_domain *domain;
>  	const struct bus_type *bus;
>  	int ret;
>  
> @@ -1305,6 +1320,14 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  	if (ops->set_map || ops->dma_map)
>  		return 0;
>  
> +	domain = iommu_get_domain_for_dev(dma_dev);
> +	if ((!domain || domain->type == IOMMU_DOMAIN_IDENTITY) &&
> +	    vhost_vdpa_noiommu && capable(CAP_SYS_RAWIO)) {

So if userspace does not have CAP_SYS_RAWIO instead of failing
with a permission error the functionality changes silently?
That's confusing, I think.


> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +		dev_warn(&v->dev, "Adding kernel taint for noiommu on device\n");
> +		v->noiommu_en = true;
> +		return 0;
> +	}
>  	bus = dma_dev->bus;
>  	if (!bus)
>  		return -EFAULT;
> -- 
> 2.25.1

