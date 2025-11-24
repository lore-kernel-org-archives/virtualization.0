Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E15F50F
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023894; cv=none; b=WKt/n0KnNB866H3Hc7kQwc9JDrActXoGyraHLqgmWcOxJEYBzO7+YD/IwsTL1CFVU9k5zCw/mK3/Gcf0+sJ0L+TAzoCgNyZhSCg7EYlNRFfZ8C65CRq/wV1h4pUMLzlcJAtNjBmPoUWfCB++/mhVvoaOYgQ+/2m/Js9f8TEWuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023894; c=relaxed/simple;
	bh=MlVlvpsNZWXaqH1VbhW24JCjPkB+3j33oQrLeC90GJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bY6nPRv0x4rwwgYGjZrK828OPEGMYMdyZU2tsmbG1V17r1772C/kJPRMJwT2yGfkQmDIG/ZjpC2Kf7gAzFbQA6Mq1EDI8JHwEJHiNxii2fh/+klOerQ4kMeVb45XuCvpQnI0dbeA1S0Ev79nDsvDRNO7pca7LiSUnhZMwKS0Qnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXsd5VjB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXsd5VjB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764023891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msUF1V1H5YwxkxUBqlExWjc40jwM55YDfoB0wV7R5Oc=;
	b=UXsd5VjB0ujwegF9NV4gXyJi2CRlZ8rirPZr2raGj903nkL14rA8iqDvdXI5QY5tP8M3hl
	K6bxlpila7Lix+Xt1vBsL+zNRi8VnpL5lfYqWR9Sum/IBi13NJZz2ffyIZqwXvLhgtYIvy
	Wbz+/xwIyTnOx2/ot516oU6hYUdDfBc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-unA9qATJNM2IUpBx4BSdwA-1; Mon, 24 Nov 2025 17:38:10 -0500
X-MC-Unique: unA9qATJNM2IUpBx4BSdwA-1
X-Mimecast-MFC-AGG-ID: unA9qATJNM2IUpBx4BSdwA_1764023889
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so2288375f8f.2
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 14:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764023889; x=1764628689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msUF1V1H5YwxkxUBqlExWjc40jwM55YDfoB0wV7R5Oc=;
        b=YFdGjntaN9t/wfW1P++6i7ln2b1mUUI/Syjp8LhF1kYRIdprgSxyJt9S6DJ4gOZXtt
         iCgd5XwvKfHeLk9DkbVfF5MN1iVKXlPGb8J51Nx9WA/hJumPqVwvvb/+91ouMszxv7Rz
         Y8mCQ4lfSdqOZI/OW5pSuwm/okzB+pTqwHTL+otOBSi+Xuyb5NfZMJlr/CIxDmzMVcid
         NOW+yOwpjyRfNnwnylU4LQUnHHxqx5Lq6BMiLXhNkCVVjn5PDrkBI7E+Fr9yu9Ih+uoU
         //Jx8AjRFUXA+NmG97hSKDIVng8or/ypLut91wWg/tfZ6OZbKFnVQprFCFLxh2U/S8H0
         zCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcolBxHuL6IQm7chTsOjJkK0NrpdpNJJQAox6ofxF6drPRtXLYwpDk7v7NC+M5tQ+KRa77/GNKD6G5fy/lOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7yLkJimV0mtxGgNZolTHOAeDd+SuNSecXureWfKO2oMbHJEn5
	T7l6KSPlc9EG1i68FmAKVXxI3OAvmSVj4zyVBBzDGVjZfQx8vdsyEebw+PEriDVSrgaGJETkOJ0
	DsDihw9jb6OMXIrACBgD+ddVHnfOMG4U7+e+hVF+Ab5cnnvc/lEZZLxqxqZlM2SjZ0is3mGSNOY
	Z0
X-Gm-Gg: ASbGncvTDZElk3dN7VlJQnPwbJy8PHzbdoVfVVCDiuu0elbKoDWfqFoTCubYLXPpMOr
	rCbYqELDmVTP8+YC3arTEAc+SsYl++d4UHYPt7yM7zP23IwVRCZiN482jvTKwhSjmNSuvzU9YVu
	gFMRqDk7uDmCWBOOPsn0kB5ENy5xFoAmWoaKJO0M0hJT5jylY0zF7uBXNDV2XON6oHmYe7WyXqq
	1PPWmUmboK9p4X5mQa3mZmMAf8qUj51T5yIIEj2wlT86VWg7bwdwIQ+BfxknyzF0HWvoBKbSr/m
	RclY5ZvrPszfSNpFuJRYqY9XYSR+kWvIGdGcbLvpPLdFL/k8L69cthxYkqXp4Yw8Xn/aglFDO8Y
	hI5ptFaeF7Da/R5odZRRHv5poEQgYPg==
X-Received: by 2002:a05:600c:3108:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-477c110d83fmr98089075e9.9.1764023888963;
        Mon, 24 Nov 2025 14:38:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAlWhBMnkWCfhAIqp5gaAq+iu2thveVYcfwmW9pG3VyiuYtKkTzJJsZMCM6pVko1WeiMyr9A==
X-Received: by 2002:a05:600c:3108:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-477c110d83fmr98088895e9.9.1764023888505;
        Mon, 24 Nov 2025 14:38:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35c2sm29492381f8f.25.2025.11.24.14.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:38:07 -0800 (PST)
Date: Mon, 24 Nov 2025 17:38:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251124173322-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-9-danielj@nvidia.com>
 <20251124170321-mutt-send-email-mst@kernel.org>
 <d793f3da-17f8-489c-b48e-d1917412b87f@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d793f3da-17f8-489c-b48e-d1917412b87f@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NWCArLAsvB4jVrTS3NHG8KYeASM5_eI8nwAMKYH2K48_1764023889
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2025 at 04:31:54PM -0600, Dan Jurgens wrote:
> On 11/24/25 4:04 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:15:19PM -0600, Daniel Jurgens wrote:
> >> Classifiers can be used by more than one rule. If there is an existing
> >> classifier, use it instead of creating a new one. If duplicate
> >> classifiers are created it would artifically limit the number of rules
> >> to the classifier limit, which is likely less than the rules limit.
> >>
> >> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >> ---
> >> v4:
> >>     - Fixed typo in commit message
> >>     - for (int -> for (
> >>
> >> v8:
> >>     - Removed unused num_classifiers. Jason Wang
> >>
> >> v12:
> >>     - Clarified comment about destroy_classifier freeing. MST
> >>     - Renamed the classifier field of virtnet_classifier to obj. MST
> >>     - Explained why in commit message. MST
> >> ---
> >> ---
> >>  drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
> >>  1 file changed, 34 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 7600e2383a72..5e49cd78904f 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -32,6 +32,7 @@
> >>  #include <uapi/linux/virtio_pci.h>
> >>  #include <uapi/linux/virtio_net_ff.h>
> >>  #include <linux/xarray.h>
> >> +#include <linux/refcount.h>
> >>  
> >>  static int napi_weight = NAPI_POLL_WEIGHT;
> >>  module_param(napi_weight, int, 0444);
> >> @@ -302,7 +303,6 @@ struct virtnet_ff {
> >>  	struct virtio_net_ff_cap_mask_data *ff_mask;
> >>  	struct virtio_net_ff_actions *ff_actions;
> >>  	struct xarray classifiers;
> >> -	int num_classifiers;
> >>  	struct virtnet_ethtool_ff ethtool;
> >>  };
> >>  
> >> @@ -5816,12 +5816,13 @@ struct virtnet_ethtool_rule {
> >>  /* The classifier struct must be the last field in this struct */
> >>  struct virtnet_classifier {
> >>  	size_t size;
> >> +	refcount_t refcount;
> >>  	u32 id;
> >> -	struct virtio_net_resource_obj_ff_classifier classifier;
> >> +	struct virtio_net_resource_obj_ff_classifier obj;
> >>  };
> >>  
> >>  static_assert(sizeof(struct virtnet_classifier) ==
> >> -	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
> >> +	      ALIGN(offsetofend(struct virtnet_classifier, obj),
> >>  		    __alignof__(struct virtnet_classifier)),
> >>  	      "virtnet_classifier: classifier must be the last member");
> >>  
> >> @@ -5909,11 +5910,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
> >>  	return false;
> >>  }
> >>  
> >> -static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> >> +static int setup_classifier(struct virtnet_ff *ff,
> >> +			    struct virtnet_classifier **c)
> >>  {
> >> +	struct virtnet_classifier *tmp;
> >> +	unsigned long i;
> >>  	int err;
> >>  
> >> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >> +	xa_for_each(&ff->classifiers, i, tmp) {
> >> +		if ((*c)->size == tmp->size &&
> >> +		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
> >> +			refcount_inc(&tmp->refcount);
> >> +			kfree(*c);
> >> +			*c = tmp;
> >> +			goto out;
> >> +		}
> >> +	}
> >> +
> >> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
> >>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
> >>  		       GFP_KERNEL);
> >>  	if (err)
> >> @@ -5921,29 +5935,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> >>  
> >>  	err = virtio_admin_obj_create(ff->vdev,
> >>  				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> >> -				      c->id,
> >> +				      (*c)->id,
> >>  				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> >>  				      0,
> >> -				      &c->classifier,
> >> -				      c->size);
> >> +				      &(*c)->obj,
> >> +				      (*c)->size);
> >>  	if (err)
> >>  		goto err_xarray;
> >>  
> >> +	refcount_set(&(*c)->refcount, 1);
> >> +out:
> >>  	return 0;
> >>  
> >>  err_xarray:
> >> -	xa_erase(&ff->classifiers, c->id);
> >> +	xa_erase(&ff->classifiers, (*c)->id);
> >>  
> >>  	return err;
> >>  }
> >>  
> >> -static void destroy_classifier(struct virtnet_ff *ff,
> >> -			       u32 classifier_id)
> >> +static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
> >>  {
> >>  	struct virtnet_classifier *c;
> >>  
> >>  	c = xa_load(&ff->classifiers, classifier_id);
> >> -	if (c) {
> >> +	if (c && refcount_dec_and_test(&c->refcount)) {
> >>  		virtio_admin_obj_destroy(ff->vdev,
> >>  					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> >>  					 c->id,
> >> @@ -5967,7 +5982,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
> >>  				 0);
> >>  
> >>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> >> -	destroy_classifier(ff, eth_rule->classifier_id);
> >> +	try_destroy_classifier(ff, eth_rule->classifier_id);
> >>  	kfree(eth_rule);
> >>  }
> >>  
> >> @@ -6139,7 +6154,7 @@ static int build_and_insert(struct virtnet_ff *ff,
> >>  	}
> >>  
> >>  	c->size = classifier_size;
> >> -	classifier = &c->classifier;
> >> +	classifier = &c->obj;
> >>  	classifier->count = num_hdrs;
> >>  	selector = (void *)&classifier->selectors[0];
> >>  
> >> @@ -6149,14 +6164,16 @@ static int build_and_insert(struct virtnet_ff *ff,
> >>  	if (err)
> >>  		goto err_key;
> >>  
> >> -	err = setup_classifier(ff, c);
> >> +	err = setup_classifier(ff, &c);
> >>  	if (err)
> >>  		goto err_classifier;
> >>  
> >>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
> >>  	if (err) {
> >> -		/* destroy_classifier will free the classifier */
> >> -		destroy_classifier(ff, c->id);
> >> +		/* destroy_classifier release the reference on the classifier
> > 
> > 
> > try_destroy_classifier ? and I think you mean *will* release and free.
> > 
> > and what is "the reference"
> 
> I see the comment is munged. But classifiers are reference counted,
> try_destroy_classifier will release the reference. And free if the
> refcount is now 0.
> 
> See setup_classifier above.


ah I got it.
you mean refcount - the reference count - not "the reference".
And in the context of refcount_t there's decrement and
increment, not "release". acquire/release in fact refer to memory ordering.

> > 
> >> +		 * and free it if needed.
> >> +		 */
> >> +		try_destroy_classifier(ff, c->id);
> >>  		goto err_key;
> >>  	}
> >>  
> >> -- 
> >> 2.50.1
> > 

