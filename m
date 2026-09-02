Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128AF49F106;
	Wed,  2 Sep 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354750; cv=none; b=Ky7+6HI5EqlvlG1LmR8pF+8qNDAS8i7of5F0EaWlu19yYrku9Fb+HUE2GqBRTMWtEyTlT/abQspoeNbeaSsnlOZTwIliHspC9P3iwhnGxZy5UR8+POgM54TrdHBcxIwTjxAVOEaYHX0jQg6MnmpTkpGjA5/8A/DHl+hRW7UCUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354750; c=relaxed/simple;
	bh=bLssvxp68Wvs8/Ccn//S6y2mTbP5TE25anWlC9tfOVg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=teEKoWTb9U8+7mxEWvUZhHOE9p77/yJR0htrtg6HoKVBWNHlZ6rqOqGeTfYx14sGdJwG4Vm1sVBxjbnoM5Ue6FbkvNWNU/Ht6RqY7Ie205hU3pVlK1iDERtRxpIQS8fx1HJMnPnFA/uBf5StOlmIuzxgeQKjZcfEdQEfEvPnaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab6eQdS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab6eQdS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6BD1F000E9;
	Wed,  2 Sep 2026 13:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354748;
	bh=Mai1R/lwKOCi/BoTld/AA2MZHvEeapcM3VWYSb4b5IE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ab6eQdS6OqqdNiR4WQccU5i83cZeCKKDf9m4nFALuIDDbbkVCHEkfJEPfJp3+bf1w
	 h3NrApPaPLFqsP0QXS8Hb1W0BuwQ6RrGU38fJO1HBC9OQw3PotvyYURYEzIXCSheT4
	 sh80z2wh2Xw6SZuCJMuL7OCB4k3DT13geqqI6sHyYJKn2Gw+t8goHep5+oFRfpC//m
	 wd6CGhvTvBf7URy10DvqKw9AgbshJirW4fGGrtCMRMQd0SfajFYWJ7Ccyz9NPW1n7K
	 0EOFxF0zuMqEriRla35ZHmXKDdEgXi8drLFXyZFmfDQXhkbWxJvDrDVz1lnunYB+Do
	 HnoQd8OtnrVcg==
Subject:
 Re: [net-next,v23,10/14] virtio_net: Use existing classifier if possible
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:27 +0000
Message-ID: <178835474741.3394541.2162581150485655984@kernel.org>
In-Reply-To: <20260831161109.2999926-11-shshitrit@nvidia.com>
References: <20260831161109.2999926-11-shshitrit@nvidia.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] `try_destroy_classifier()`
  (drivers/net/virtio_net.c:5871-5888) treats a failed…

--

virtio_net: Use existing classifier if possible

This adds a refcount to struct virtnet_classifier and makes
setup_classifier() scan ff->classifiers for an identical classifier
object, reusing it instead of creating a duplicate device object.  The
release side becomes try_destroy_classifier(), which only destroys the
device object when the last reference goes away.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6217c5bcfee9f..6c07eab047afe 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -5823,11 +5825,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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

[ ... ]

> @@ -5835,30 +5850,31 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>  
> -static void destroy_classifier(struct virtnet_ff *ff,
> -			       u32 classifier_id)
> +static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
>  {
>  	struct virtnet_classifier *c;
>  	int err;
>  
>  	c = xa_load(&ff->classifiers, classifier_id);
> -	if (c) {
> +	if (c && refcount_dec_and_test(&c->refcount)) {
>  		err = virtio_admin_obj_destroy(ff->vdev,
>  					       VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>  					       c->id,

[Severity: Medium]
With this patch ff->classifiers becomes the authoritative mirror of the
classifier objects that exist in the device, since setup_classifier() now
scans it with memcmp() to decide whether an equivalent device object is
already present.

Given that, is the unconditional cleanup in the tail of
try_destroy_classifier() still correct?

drivers/net/virtio_net.c:try_destroy_classifier() {
	c = xa_load(&ff->classifiers, classifier_id);
	if (c && refcount_dec_and_test(&c->refcount)) {
		err = virtio_admin_obj_destroy(ff->vdev,
					       VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
					       c->id,
					       VIRTIO_ADMIN_GROUP_TYPE_SELF,
					       0);
		WARN_ON_ONCE(err);

		xa_erase(&ff->classifiers, c->id);
		kfree(c);
	}
}

virtio_admin_obj_destroy() is synchronous and returns non-zero when the
object was not removed, and it can fail without any device malfunction:

drivers/virtio/virtio_admin_commands.c:virtio_admin_obj_destroy() {
	if (!vdev->config->admin_cmd_exec)
		return -EOPNOTSUPP;

	data = kzalloc_obj(*data);
	if (!data)
		return -ENOMEM;
	...
	err = vdev->config->admin_cmd_exec(vdev, &cmd);

After such a failure the device still holds the classifier object while the
driver has erased and freed its tracking entry.  Does this leak one of the
device's ff_caps->classifiers_limit slots permanently?

Two follow-on effects also look reachable from that state:

- the id is immediately available to xa_alloc() again, so a later
  virtio_admin_obj_create() for that id can be rejected by the device and
  userspace sees an ETHTOOL_SRXCLSRLINS failure the driver cannot explain.

- an identical classifier requested afterwards no longer matches anything in
  the xarray, so a second device object is created for it, which is the
  duplicate-classifier case the commit message says this change avoids.

Would it be better to leave the entry in ff->classifiers (and restore the
refcount) when virtio_admin_obj_destroy() reports an error?

Separately, in destroy_ethtool_rule() the FF_RULE destroy result is saved but
not acted on before the classifier reference is dropped:

drivers/net/virtio_net.c:destroy_ethtool_rule() {
	err = virtio_admin_obj_destroy(ff->vdev,
				       VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
				       eth_rule->flow_spec.location,
				       VIRTIO_ADMIN_GROUP_TYPE_SELF,
				       0);

	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
	try_destroy_classifier(ff, eth_rule->classifier_id);
	kfree(eth_rule);

	return err;
}

If the rule destroy fails, can the now shared classifier be destroyed on the
device while a device-side rule still references its id?

>  @@ -5885,7 +5901,7 @@ static int destroy_ethtool_rule(struct virtnet_ff *ff,
>  				       0);
>  
>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> -	destroy_classifier(ff, eth_rule->classifier_id);
> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>  	kfree(eth_rule);
>  
>  	return err;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
