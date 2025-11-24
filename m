Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AA2D6E66
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021888; cv=none; b=h8feJDNnBDZTtV/eVuZBCbK+W603lBodg6ftAZnK/sIlUybH5V7ul4q1xyUtON9fihO5aNvF25xf6kE6QJfukOi+NFVtuBXZLxS+lxyCF6P46mAd3rO59jT8V9KbRfG+sfVxmqLdtxFB2UGsXcfMHOyh+N4FSkRkfmgAZbwivG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021888; c=relaxed/simple;
	bh=NFi4G2n1uMZYEwXBWV6BO8y08SlAW726DN8RLbyNzaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YA9bLSS0z5na3yG1QCHA5tRXEc8BhjB5ubgSuePE/qZKzsG8H6xtGA+4OGY+SOwuQuDs0eJRSQJ0jWZuLv+9Lz5ZXy0tV+OnAe2cbxMQCnlUDOkJLLxjlN5ES9Hnq/0dWphywx7EiH9VlLu5zGN7/vJaxQQ8c+jLggSv7ORla/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGzF+7UK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGzF+7UK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764021886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+O629B+qMO5boWUleDiLjisQSZzyD9d8ug/NcHfs/FQ=;
	b=fGzF+7UK2+pNxj4LDw/EKYs0sn/bxXJrlT+pTLgcg4l2rZ4sIUm2aLc598AfBxnkVHTmt9
	GvbNNTYV/gRhKBX/DiRTKA3J63vf0VCQlPpzBT+G9j2x6r2EZBgyxXfXaZfpLqCvTaYLVM
	kHtDqfuR8aXb7wmKDOIhPmaGhAQDpAM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-inSSmy0rMo26B_boRr0x2Q-1; Mon, 24 Nov 2025 17:04:44 -0500
X-MC-Unique: inSSmy0rMo26B_boRr0x2Q-1
X-Mimecast-MFC-AGG-ID: inSSmy0rMo26B_boRr0x2Q_1764021883
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so22090245e9.3
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 14:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764021883; x=1764626683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O629B+qMO5boWUleDiLjisQSZzyD9d8ug/NcHfs/FQ=;
        b=Obi/C2SUlWRaCPQsfu4rKc0Yn32ntk9ylS8KLaNvI18LapbM3UIsqODWXt4v+uQzSH
         y/JrgFbwKSMcrQ83fnSWyHsZ1R+nY3l/md1JB1gqnkU6zjJRsgFd48xuwb7NQTmcy92o
         9MshZ85tlkJI1dAxv5D8C+iGncTvHYoVcrfodqTWrO8+sUIl26oHUSjNnYoaY0cGQ26h
         1tZp7O1p2AnKjni/RNJlLlhcWTr8SxLY0VLZv/0gHbUTMtLmRsv5gseDKXsgE9BBeaUj
         E6CCRHPHSyrF/ZGrNfs/8l1khuw6U1L7alXtCSQ5Ku6I5lHjHSJyn+YO41mfSBu2Mg0f
         xFFw==
X-Forwarded-Encrypted: i=1; AJvYcCUatSM7SFB86zf+HLwL/87qUx4DcTbqkLunEupyGK3cy8OxWfDUHVOf1dut3f9eZyjvMbUcEBM6ex6kwMvukg==@lists.linux.dev
X-Gm-Message-State: AOJu0YznBoiiHYpU0pskoIC2h9tYVb2xxtb2iOQIBOaGIOfgn6Xfuzco
	UjR1QZUHsjetKLk0BTQfNSsxKBX+OOEUUsBhyiOj5eQT/mEdCT3fqssKPXHqruFfP11l2E8OllG
	ipUf/sbuDexzAKG9J/adI8CbQwuR8PK1Voz0KcrvkBQq2qcSVjboEonzEtod2eeJ1MAmc
X-Gm-Gg: ASbGnctN66c6pJArX8u9SRa/7R6V1EUuk4gpF2KWTAYO361C6z+KaY9RRHNXIh4NAit
	54N9+Qh4adif3P5IqnBCspLLeOQR32XaK04ZyzMpavqTOfgGUFL5Mv0AhswwRebuhrNjH+QFSGZ
	dqHDhyHPa7FqcxJyHdTgNyA6fdlLrx7oNH/PK/daCHaxGMNfRU3A20ZpdCuneDfRg8FYOu+2tXd
	HnJjrmNCgV2R7SD6XL6brVUyw0Pl/jlloNlcHhlg9U1tX5VvJlVLndNHqmnV5KogWQSaHhY81wa
	3a1QRREQYPzJoFwAQah/EWb1JEJaHpXx6gfS9qVtxyJxZj807/LpPbKObJ8nxdCu/DAgyJatayr
	L23Bvsy/G/QxUDK7mxaKf4cQF3ORAdw==
X-Received: by 2002:a05:600c:1d23:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47904b12ddbmr2879685e9.20.1764021883382;
        Mon, 24 Nov 2025 14:04:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLWolPoz1Gtb3rKgis0WwBvpWfkB0SGuJ04SkFbKQYhj+AuNKQCmj4OzGv7gPeYEILDTcnQA==
X-Received: by 2002:a05:600c:1d23:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47904b12ddbmr2879555e9.20.1764021882937;
        Mon, 24 Nov 2025 14:04:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf355933sm223044435e9.2.2025.11.24.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:04:41 -0800 (PST)
Date: Mon, 24 Nov 2025 17:04:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251124170321-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-9-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119191524.4572-9-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sRbuUmkhHL3pRZ-aOHLGF_GeMvpsZ1pdjQeV15GW0t4_1764021883
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:15:19PM -0600, Daniel Jurgens wrote:
> Classifiers can be used by more than one rule. If there is an existing
> classifier, use it instead of creating a new one. If duplicate
> classifiers are created it would artifically limit the number of rules
> to the classifier limit, which is likely less than the rules limit.
> 
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
> 
> v12:
>     - Clarified comment about destroy_classifier freeing. MST
>     - Renamed the classifier field of virtnet_classifier to obj. MST
>     - Explained why in commit message. MST
> ---
> ---
>  drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7600e2383a72..5e49cd78904f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -32,6 +32,7 @@
>  #include <uapi/linux/virtio_pci.h>
>  #include <uapi/linux/virtio_net_ff.h>
>  #include <linux/xarray.h>
> +#include <linux/refcount.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -302,7 +303,6 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
>  	struct xarray classifiers;
> -	int num_classifiers;
>  	struct virtnet_ethtool_ff ethtool;
>  };
>  
> @@ -5816,12 +5816,13 @@ struct virtnet_ethtool_rule {
>  /* The classifier struct must be the last field in this struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
> -	struct virtio_net_resource_obj_ff_classifier classifier;
> +	struct virtio_net_resource_obj_ff_classifier obj;
>  };
>  
>  static_assert(sizeof(struct virtnet_classifier) ==
> -	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
> +	      ALIGN(offsetofend(struct virtnet_classifier, obj),
>  		    __alignof__(struct virtnet_classifier)),
>  	      "virtnet_classifier: classifier must be the last member");
>  
> @@ -5909,11 +5910,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> +		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
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
> @@ -5921,29 +5935,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>  
>  	err = virtio_admin_obj_create(ff->vdev,
>  				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> -				      c->id,
> +				      (*c)->id,
>  				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>  				      0,
> -				      &c->classifier,
> -				      c->size);
> +				      &(*c)->obj,
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
> @@ -5967,7 +5982,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
>  				 0);
>  
>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> -	destroy_classifier(ff, eth_rule->classifier_id);
> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>  	kfree(eth_rule);
>  }
>  
> @@ -6139,7 +6154,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	}
>  
>  	c->size = classifier_size;
> -	classifier = &c->classifier;
> +	classifier = &c->obj;
>  	classifier->count = num_hdrs;
>  	selector = (void *)&classifier->selectors[0];
>  
> @@ -6149,14 +6164,16 @@ static int build_and_insert(struct virtnet_ff *ff,
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
> -		/* destroy_classifier will free the classifier */
> -		destroy_classifier(ff, c->id);
> +		/* destroy_classifier release the reference on the classifier


try_destroy_classifier ? and I think you mean *will* release and free.

and what is "the reference"

> +		 * and free it if needed.
> +		 */
> +		try_destroy_classifier(ff, c->id);
>  		goto err_key;
>  	}
>  
> -- 
> 2.50.1

