Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40C24BBFD
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502964; cv=none; b=GXpCxUpCBMW4NWa0pXmbGL5QR3R6EkyAhl4lG3Zq+LYTa5Toh97kwCU+tFC17v/J2dFpnH0fT8pAhGnJZTfBWIzbfwdq69wMrjUKtB5SLAaqkghH+uhx9Cqvcd0PWImXpqp3BEyiNxljyDa9gjwuMuvDWL9vuLtLpvJO/0JBW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502964; c=relaxed/simple;
	bh=j+E0byoRvaORafNm6GmHS5qiC5HA9/iH79KXIlY3vcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IMW0drc3m9fPBtZOrtsiaBl1f6hMQ/2FUCMGo51SCq3J/GxG5mPtmGAEuR0TWErwwrO/h+PQF2Jd7xBsmvbjn8bu+wTYY8ywb2nMg3yMreu55clxInJabFhvGP5BsRbhq4rAKP691ncS7zMeF6H8WuG55iNnioU+5Mc52AVlr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqHdaXVa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqHdaXVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763502961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFZp+qcXN9gzuUdOxOz0uxVXwf1f1BfhlVSxFFzrPP4=;
	b=UqHdaXVadYAvl06e2PjMlsYXdU5+a2dtS84211+LS5cMS8ThvHPGUrwaXE5tMeUuOHZUVC
	9+2f/zC+olgTm/tfjymuXB5bf5AGx8fkhGGy5BBLfshT5G33qBcS2dxFj2eGsL6+Ygt8o+
	0k/J6ahC7vOozkh4w6IJmyaDC9LBcr8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-UPEPhn5mNZmsjwL27Wvl6w-1; Tue, 18 Nov 2025 16:56:00 -0500
X-MC-Unique: UPEPhn5mNZmsjwL27Wvl6w-1
X-Mimecast-MFC-AGG-ID: UPEPhn5mNZmsjwL27Wvl6w_1763502959
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b487cda00so1002008f8f.3
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 13:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763502959; x=1764107759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFZp+qcXN9gzuUdOxOz0uxVXwf1f1BfhlVSxFFzrPP4=;
        b=NLqROshN2q+O92EjBAIlXU3+2W6ODppV2vk1N8zLSP/jstR8xkNrfcs83amUzQPU1N
         IpoFbnizLCmPwcwddGUb3L0kqKVAoediY9BM9PEjgy4CORIkqjcdrLOU6fi4piCHS6tO
         bsjPDtWbvXvJKAThFn9PN7KhGiXP9XHxEOr8d/8rhenJUFZVAn0yZ5H/n6FNH/tZyDYY
         FisHn+flkGDPBLouJj/IDf8to9bDb7E/pJKfMURhVGDHZ94pP7Ku712QjXnczZNneQ7W
         2pFb53QechVMdv2+msexDllnwIQfvukeyIKR0ZRXnyq8npxIxX1u63pe/RQEUJH7xTuJ
         89IA==
X-Forwarded-Encrypted: i=1; AJvYcCXeIaKiE7/1ni/5S1QKFlBdluVokgv6+zFHxGLf1Ba5Ntnd88vHweD3wSdUPaTVNNzi/uCAwmQBx8pPvEyR0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YznJ7Iv7qFn1jxgjMi0qRMGcrjytevbS6/m+6QqAamfNQcIaA5J
	NzeKUuYcLFWy2zbqX2Dxbh3iXdhMhLCHXn/kW1KWepgNm+PpFHxW2NUVgIwHivwBS0ac3UuKgQN
	kZNk/WTWJ5VQ+ENtxj7JumItspKXd2zfBVHF84qDyAE0P1SANINxLVlX0x4pMiNGsUOzg
X-Gm-Gg: ASbGncv3z0xnTwsngovqyZWpGOWSPbtiyR6+1FTedVN3QDUwLGza52+aX1i4jLUgs7x
	8IGSNvqPMhi/22UG6t/CBsAD7J1HmCZnUq7Yy0Zq1qDn1x0nBvwL31SUId4UUwDNmd8Z2PkHIHr
	QhnVIrbPqbxPYJDn5U+3bfcbn7tIsz/3QdwTZ8w8d9Bb05xwOtnt1X5Z9DmYfMlpw1crDVmFWkD
	+gTm/maP2Ekw3f6mSZpqy16gnFbTLje+l7L7rTY+ItfXeqrGFCcW43a6B+UaK6oWbSFbopeFvCw
	dn8kK8MEgTmyGlUXdCRrKVB4A2A6g/bJ61ltKeGM2zrpqPRZFVS0EIH6rm9/7K7MBOvK9pN26U3
	YNMjmebmgp49DS/w0A9SLxhJcQHoVgA==
X-Received: by 2002:a05:6000:290d:b0:429:c711:22d8 with SMTP id ffacd0b85a97d-42cb1f3857amr240123f8f.15.1763502959191;
        Tue, 18 Nov 2025 13:55:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYLG810iYRWSGhPkxUgtASRGajCK7Eg8R/pcfoMOkqI3MUEehaN5Oc5HCpmxPQ/ILKsOlzGQ==
X-Received: by 2002:a05:6000:290d:b0:429:c711:22d8 with SMTP id ffacd0b85a97d-42cb1f3857amr240101f8f.15.1763502958696;
        Tue, 18 Nov 2025 13:55:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae98sm33789800f8f.2.2025.11.18.13.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:55:58 -0800 (PST)
Date: Tue, 18 Nov 2025 16:55:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251118164952-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: vl7B4EWQT3pavg-rvS1nJ9pSwWtDDg4ViixA5_IdjEU_1763502959
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> Classifiers can be used by more than one rule. If there is an existing
> classifier, use it instead of creating a new one.
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

note that classifier has padding bytes.
comparing these with memcmp is not safe, is it?


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

what kind of locking prevents two threads racing in this code?


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


so you insert uninitialized refcount? can't another thread find it
meanwhile?

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


same questions about locking.


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

will free is no longer correct, is it?

> -		destroy_classifier(ff, c->id);
> +		try_destroy_classifier(ff, c->id);
>  		goto err_key;
>  	}
>  
> -- 
> 2.50.1

