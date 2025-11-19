Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1D32D73B4
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538161; cv=none; b=d43TrQtb/LsK77ypAXdYhxG5u7CZR8hDhiQq1xV+4mhjRwMe0jiLUOqc10JOdt2RJk/OVoHM5lNT6HgfAm5hEAHbVyocRzMGy3N7n4GdVzEggP8MWH79m8ZVqC/ZRHJM9D7SillbBqX1q7h5+NbKzqMLzZ1ZBrTMdmcrC1CHVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538161; c=relaxed/simple;
	bh=OLA8m9TLLbYqvmKHcPxq9ZrLCV5444ywLE3KMmGFc8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hj2D2pi3wufIBaA81gb1hdVxWWZQAxrpBBK3K8AwVscYXyeI9EZHDEK35r0W16a3wSjUzpvwcwu8sco6GMBPfTGLDCtDKe74Rap1owYJ9sNQXMNgyfSvIzeZDb+XsUyOEpREdEtlIobyPtIrX9nMZ6kfhW2aM8GqBTwJxnxf3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5PNP5CD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5PNP5CD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4JiHNk8Un1Ag1G9pjG84VBhPIzZqe9VuqqmjTYDWtM=;
	b=X5PNP5CDjyc6sObCrKDnFBhLQ9jx/JKncYNv96n+GV+PEa8DKvJ34+82INwIwUufko7Evq
	eOlCbdH8s2Yoj1vtWJihyQv1Yqp+dL6PG+fbnOnKP3Pxx5zhaR+Syscr6ompmevOeqi3vS
	Y4NpyRtdmpktwnZxIROOBQLz4vqJsOY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-BLdE5suONjKosbjq22NOKA-1; Wed, 19 Nov 2025 02:42:33 -0500
X-MC-Unique: BLdE5suONjKosbjq22NOKA-1
X-Mimecast-MFC-AGG-ID: BLdE5suONjKosbjq22NOKA_1763538153
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b3ed2c3e3so4412528f8f.1
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538152; x=1764142952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4JiHNk8Un1Ag1G9pjG84VBhPIzZqe9VuqqmjTYDWtM=;
        b=J42zBUWhUwa3KCnEqfT2fNdD79rTwPxneQKfV9nBFc/T6LboMOLNtgXJrpKGGWAL0S
         qQ/lB8ZRbjm1HNVNRjO7NDFfr8vEtYDPppF1zJr77owWjl/Bjo63s5TBDyWHnwmz9TU/
         R+hU88WDkKwVihBNHFPgcaLm87eGMlB+3CrUO8K3hDzgTrnmqszioJ0cCQ59cN1mTA+y
         xE3Jo61M3sMxr01UJ62IWCEngRhHdZykSJnQWGCuLb8K5iyFYiMKe2AQH92cmnYXkT76
         OQ8LqSbmg1jdEg1a1/7+VXU51l/BsUFW1yu38McEjT2Bx4E6H8EJkPa36BPcaStBF9q0
         5bmg==
X-Forwarded-Encrypted: i=1; AJvYcCXeGqp8ouQyugpOGXRkr+bqW5buTmPQP+VsbB/EoDbq1ot4vGd+5xc6gvRa5eyUD3gB52KdBzwtA/M2Bk2FOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOp+41iBMgWbgb3OoMsS7rnqmLxoLVJH7sHxYpF8/NsVAHyuKK
	BI6ZDav3mbHdPgxHsNb0T1cNLPT0XXjqnAuGcH3pfvQXGH44ts6T/Z3Y0BowXN16g/tW9NKeFaM
	8o8R61EKuHu0F/ym+smljIUnC9FFsB7fJ//0GOWKMGBPEJYZ/l+MqC3tvcTBinxw6vh+pPW07iJ
	dm
X-Gm-Gg: ASbGncsNpp4g9eh8XuHsQ/lV1tZtOT/qE1DtnJ75cLV1fH1NTkhnK+cbI1R82SJmLZV
	zuNvP06nZRgXyXWgbLmw3t0ETa1GKmjVQ69Ty+YG/VX1x8W6zG9ysgLVZNF50xGMiYsgPJll2fi
	A4ps6VNcRghCi6W6DP6FZ2wPNtN8nGlwv45UTMqB8xYGLz3GBbokGXX9QBY+dCOxbpBismBKvr6
	sBNQraVLmr2ML/UPbRuwZ9xEtBYEc2l2gmeo5jBcD9/0mU4K70wpWBSEoqAz4pvf/Fs5cRfP/8X
	FOF2uXq9O03Mr0VW5btn2sG5P8i3H2QQr5xAaYv+0kaYlsjAGuheIMgoRFx5jGwS3QCmSRtISeq
	+9UjzXcusxQA/k3G8CqhCG2UUzBWBIA==
X-Received: by 2002:a05:6000:381:b0:429:c617:a32f with SMTP id ffacd0b85a97d-42b5938f44cmr18120191f8f.52.1763538152341;
        Tue, 18 Nov 2025 23:42:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVoKWTmCKGsdXq2+7eS8LR3Wv5tLzrt1q9s97tPznxCioRa2qIv0BW3ghrZRWPtDnT0sv9yQ==
X-Received: by 2002:a05:6000:381:b0:429:c617:a32f with SMTP id ffacd0b85a97d-42b5938f44cmr18120167f8f.52.1763538151805;
        Tue, 18 Nov 2025 23:42:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e846afsm35643837f8f.13.2025.11.18.23.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:42:31 -0800 (PST)
Date: Wed, 19 Nov 2025 02:42:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119024151-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-9-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4OQZNlzqq1h6xlP7FtveEIURve3r04NtAtTZkH9KJ5w_1763538153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> Classifiers can be used by more than one rule. If there is an existing
> classifier, use it instead of creating a new one.

explaining what's the point would be good. to save
device memory?

> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed typo in commit message
>     - for (int -> for (
> 
> v8:
>     - Removed unused num_classifiers. Jason Wang
> ---
>  drivers/net/virtio_net.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index de1a23c71449..f392ea30f2c7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -299,7 +299,6 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
>  	struct xarray classifiers;
> -	int num_classifiers;
>  	struct virtnet_ethtool_ff ethtool;
>  };
>  
> @@ -6827,6 +6826,7 @@ struct virtnet_ethtool_rule {
>  /* The classifier struct must be the last field in this struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
>  	struct virtio_net_resource_obj_ff_classifier classifier;
>  };
> @@ -6920,11 +6920,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  	return false;
>  }
>  
> -static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> +static int setup_classifier(struct virtnet_ff *ff,
> +			    struct virtnet_classifier **c)
>  {
> +	struct virtnet_classifier *tmp;
> +	unsigned long i;
>  	int err;
>  
> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> +	xa_for_each(&ff->classifiers, i, tmp) {
> +		if ((*c)->size == tmp->size &&
> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> +			refcount_inc(&tmp->refcount);
> +			kfree(*c);
> +			*c = tmp;
> +			goto out;
> +		}
> +	}
> +
> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
>  		       GFP_KERNEL);
>  	if (err)
> @@ -6932,29 +6945,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>  
>  	err = virtio_admin_obj_create(ff->vdev,
>  				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> -				      c->id,
> +				      (*c)->id,
>  				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>  				      0,
> -				      &c->classifier,
> -				      c->size);
> +				      &(*c)->classifier,
> +				      (*c)->size);
>  	if (err)
>  		goto err_xarray;
>  
> +	refcount_set(&(*c)->refcount, 1);
> +out:
>  	return 0;
>  
>  err_xarray:
> -	xa_erase(&ff->classifiers, c->id);
> +	xa_erase(&ff->classifiers, (*c)->id);
>  
>  	return err;
>  }
>  
> -static void destroy_classifier(struct virtnet_ff *ff,
> -			       u32 classifier_id)
> +static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
>  {
>  	struct virtnet_classifier *c;
>  
>  	c = xa_load(&ff->classifiers, classifier_id);
> -	if (c) {
> +	if (c && refcount_dec_and_test(&c->refcount)) {
>  		virtio_admin_obj_destroy(ff->vdev,
>  					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>  					 c->id,
> @@ -6978,7 +6992,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
>  				 0);
>  
>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> -	destroy_classifier(ff, eth_rule->classifier_id);
> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>  	kfree(eth_rule);
>  }
>  
> @@ -7159,14 +7173,14 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	if (err)
>  		goto err_key;
>  
> -	err = setup_classifier(ff, c);
> +	err = setup_classifier(ff, &c);
>  	if (err)
>  		goto err_classifier;
>  
>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
>  	if (err) {
>  		/* destroy_classifier will free the classifier */
> -		destroy_classifier(ff, c->id);
> +		try_destroy_classifier(ff, c->id);
>  		goto err_key;
>  	}
>  
> -- 
> 2.50.1

