Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F932128E
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833644; cv=none; b=u6eY7OBMeSGch78DQnbBYtEL1UVw+3+OdoNNZa0LIk4QDU1bwNvytEqTtPUg5wdu8n4aksG6rN3gFLNYHB4YGou7/OmqlMfOR4m2ij5BFpBnKOyv16DFWfa0LBfw+IsnHP+1hjlWELiWg/8idVRFcM9+jlASdGIFDoGI+zqXyWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833644; c=relaxed/simple;
	bh=SSXxA/ov/JyorNZtlUeGUL46kNcV39OOXqs/vOEm0mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rx05lTgfWd8AgSHM3E2DIQ0Q6miKzj2WEGEYnLTsIAlLbOJh5adquS214/wz6cqrSc9iqkcQm1OrIbzAxdiOUPWnjp2ZhWnMURDf3DxgA9uP18ZJMAUJ8MKs6E/DueAAz2PL4tKx7Ae3vNLi+eHmwsliCGbZw7Erm9h3fV0TRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0VMdbxL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0VMdbxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758833641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9fhr54yCqYhL+KcvkOw0Wms1g0q65DbsfJhR6f884U=;
	b=b0VMdbxLIESSE/lUtQ9zbuun6hewuHkWa6q3INy56/bNixFpWTOUepDSupUuEcOuKYs8Dx
	1xFpbYJvOA7i0RqiVLTYqCTOQc1PXpdH9KSomFGrw26iBtdYEP30KyKPtSKZDDze6470zZ
	Bfylof0RdiFMoXNH7Ju2c4iJ+6z0WZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-LNtKXK54OZmC9Q9GgOw2Pw-1; Thu, 25 Sep 2025 16:53:59 -0400
X-MC-Unique: LNtKXK54OZmC9Q9GgOw2Pw-1
X-Mimecast-MFC-AGG-ID: LNtKXK54OZmC9Q9GgOw2Pw_1758833638
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso8794165e9.0
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 13:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833638; x=1759438438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9fhr54yCqYhL+KcvkOw0Wms1g0q65DbsfJhR6f884U=;
        b=Azl/STGZPFJsIz80mtSVGOIka0YFwdBwsHgvWFz/Eu5Zx6JjRqrY0SW2ea4iWHFSm7
         oB0mL8zTBbbyIQ4Sfz00PL8ukoeHUa4zOmd+czHt6yJqhTWaEaF+EqJO0ASkr2frWswh
         h8L2azOaVCCmxXikXPV0hhYEbuo3vKasN+yp1ESR8hUVAYWQ9A6a5+3yfd5xMQHKDqqO
         jRp9MRmboCz49fPX7ImbSogXEct9uTFWCHHICn20t6O5pz5XaKcdxqGFy2YXTwVRIINe
         RuZSp4gjRF0I/Jos1vhubn4Bw9B7eTA+SMPv91JSXajSa62UQGOMV0YypJWpLxPBZXgj
         tJcg==
X-Forwarded-Encrypted: i=1; AJvYcCUtxqMNoCcGvdtiA+GIcjlm3AAjbsV5JuAmkOiZYs/zK4J0lyYm4eJJlXyV4QGT5BnKSHyuwG06JNhHhORItQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjlTIn37lbsioLVerUdV41thN7f3zcoASKMS8EnKd/bo2g5oI6
	fljRarHKphiI0uToyqTC/qFK+9+K3Pqruugd2OEJdDWr+QvkSnTlDo29f8vBbp3KxRfPYEIHhB0
	znO2XKSVvTDO9BkgZFx8at2aGnBjrgtB0QAov9lvwK14uCmnrxmePxr+urTERRgSwspSi
X-Gm-Gg: ASbGncuazKwcgA0Jx84jR7L6fSkUGS6wLotkClFcFKmTkvH6EQvRA6DuslTht/xxFg2
	/ABGIrAnsFrjMgUzyGnSn7AujuPnzXSxQMksbt4kw60ZspwN4+gkT2CpFLveSl75EauKZ3IoXI8
	vKiPGpFWBxKRZx/m4XCYquLBOCWUnNp/BGXNTsOmBrTyiQ6lkfxFl5fEwFzAl5X9vbH/DM/HaYk
	8/UAbap6sFTmjj3qEDTHTbg4RexRqMtxvCa/LnK7MmVAuvQVGKpncCHOJ8wdNCo+ONLjen3UGdM
	EB8tQZlCgqnk070i7nzlwSQkL9s+zsYcYw==
X-Received: by 2002:a05:600c:4e90:b0:468:6049:95da with SMTP id 5b1f17b1804b1-46e329fac2amr51788825e9.24.1758833638307;
        Thu, 25 Sep 2025 13:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNU7+GhGL7b1X4/jV2DcudjXddD1vM81m2Dvfhm0YSo3L7EwN/2uO1L/7MssC9Fp4MbxXZCw==
X-Received: by 2002:a05:600c:4e90:b0:468:6049:95da with SMTP id 5b1f17b1804b1-46e329fac2amr51788555e9.24.1758833637874;
        Thu, 25 Sep 2025 13:53:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bef4b4sm46416235e9.20.2025.09.25.13.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:53:57 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:53:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 07/11] virtio_net: Use existing classifier if
 possible
Message-ID: <20250925165331-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250923141920.283862-8-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JEPltQ-mrw5t1y0mnJtk3aWOrKcqvUDbEYqk8SPf-YE_1758833638
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 09:19:16AM -0500, Daniel Jurgens wrote:
> Classifiers can be used by more than one rule. If there is an exisitng

existing

> classifier, use it instead of creating a new one.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net/virtio_net_ff.c | 39 ++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> index e3c34bfd1d55..30c5ded57ab5 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.c
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -17,6 +17,7 @@ struct virtnet_ethtool_rule {
>  /* New fields must be added before the classifier struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
>  	struct virtio_net_resource_obj_ff_classifier classifier;
>  };
> @@ -105,11 +106,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> @@ -117,27 +131,28 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>  
>  	err = virtio_device_object_create(ff->vdev,
>  					  VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> -					  c->id,
> -					  &c->classifier,
> -					  c->size);
> +					  (*c)->id,
> +					  &(*c)->classifier,
> +					  (*c)->size);
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
>  		virtio_device_object_destroy(ff->vdev,
>  					     VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>  					     c->id);
> @@ -157,7 +172,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
>  				     eth_rule->flow_spec.location);
>  
>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> -	destroy_classifier(ff, eth_rule->classifier_id);
> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>  	kfree(eth_rule);
>  }
>  
> @@ -340,13 +355,13 @@ static int build_and_insert(struct virtnet_ff *ff,
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
> -		destroy_classifier(ff, c->id);
> +		try_destroy_classifier(ff, c->id);
>  		goto err_key;
>  	}
>  
> -- 
> 2.45.0

