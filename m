Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575A49E5C3;
	Wed,  2 Sep 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354747; cv=none; b=uAPSfq73IGGxzG/wUkMDZK9KCptg3eOJBUV11fwy8VpbUzwWss9PcdELDrzFkNlPbNntNALoxkBDdCe/XFCu+gMnInSt3J+X3QzLXfPvrzX6muAUMFugZca+MKcL7IKXCmXBLI5SuMc8zHsFc7E204+2xSbj9spsMxK4Fxc36Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354747; c=relaxed/simple;
	bh=2n+pdQxvw0P9Uu8ue8vPchqAoHM/6DjxY1+uXCbew+Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YMKpBTVVa7o1FBFq/Aoog433Cm44UoLhjPB1p7VW9X6q9gvKY0QDY7rn8AvayJ2vZ4DSdBILzFz493ZagQ4xs3EiYZTnfNbfGpaZbU369nmmQwSClvZqHZoQkGr8FBq9UaVxbGJx6gKJio/00E4vj5DJwVosSoFXvWTRNQ7GclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdqtkfYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdqtkfYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC7F1F00A3F;
	Wed,  2 Sep 2026 13:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354744;
	bh=4I+PKNNcD9ACgqXLWEfSRpwib9Cz6IRf30mt4qOQblA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DdqtkfYLaqLzQ+CVIXivHB6WqYRoDbYVsBplIorPZOn7OTc9AvH1osrwSavuKKgqv
	 MxcSRWKEPH8YhOoBRpRb9Di7nlkEkv9t/xYp54k0J97uni3EC26XPS3wV1g123K/Q+
	 RL5v/7vo/RijcDTeGciTWthqZK0Qp6mEvlww3JzzWYo11ltPKU9txvgY3nIIDJ52tp
	 cs8hans/jXOCi3buAcraqaure/KkCZ1/Rs9sjEGqBoyXR7qMgJErbwutt+VSSpsQCe
	 LF9Shxu9kvJxkjNdAykanivT9tr2/gh69xJ6yCX8vwm8aDB2xvetJA8Xuf6nI0CIdC
	 GuE9ZhAcPQdiQ==
Subject: Re: [net-next,v23,06/14] virtio_net: Query and set flow filter caps
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:23 +0000
Message-ID: <178835474310.3394541.14237006399257303655@kernel.org>
In-Reply-To: <20260831161109.2999926-7-shshitrit@nvidia.com>
References: <20260831161109.2999926-7-shshitrit@nvidia.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 · Low: 1

- [High] virtnet_ff_init() (drivers/net/virtio_net.c:5760) converts
  device-reported capability data into hard errors (-EINVAL at 5809 when…
- [Medium] In virtnet_ff_init() the bail-out 'if (!ff->ff_actions->count)
  goto err_ff_action;' (drivers/net/virtio_net.c:5852-5853) is taken…
- [Medium] virtnet_ff_init() commits driver capabilities to the device
  with up to three VIRTIO_ADMIN_CMD_DRIVER_CAP_SET commands — RESOURCE…
- [Medium] virtnet_ff_init() issues up to seven virtio admin commands (1x
  cap_id_list_query, 3x cap_get, 3x cap_set) with the global RTNL mutex…
- [Low] The patch's recorded author is Shahar Shitrit, but the Signed-
  off-by chain starts with Daniel Jurgens and there is no Co-developed-…

--

virtio_net: Query and set flow filter caps

This patch queries the virtio_net flow filter resource, selector and action
capabilities with admin commands during probe and resume, and writes the
values back to the device with capability set commands.  It also adds the
new uapi header include/uapi/linux/virtio_net_ff.h.

> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>

[Severity: Low]
The recorded author of the commit is Shahar Shitrit, but the
Signed-off-by chain begins with Daniel Jurgens and there is no
Co-developed-by: line for him.

Documentation/process/submitting-patches.rst asks that the chain of
custody start with the author, and that a non-author co-author be
recorded with Co-developed-by: immediately followed by their
Signed-off-by:.

Should this carry "Co-developed-by: Daniel Jurgens <danielj@nvidia.com>"
above his Signed-off-by:, or a From: line naming him as author?

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d39..4f78b881e493b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -5724,6 +5739,197 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>  	.get_base_stats		= virtnet_get_base_stats,
>  };
>  
> +static size_t get_mask_size(u16 type)
> +{
> +	switch (type) {
> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
> +		return sizeof(struct ethhdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +		return sizeof(struct iphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return sizeof(struct ipv6hdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
> +		return sizeof(struct tcphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
> +		return sizeof(struct udphdr);
> +	}
> +
> +	return 0;
> +}
> +
> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
> +{

[ ... ]

> +	if (!le32_to_cpu(ff->ff_caps->groups_limit) ||
> +	    !le32_to_cpu(ff->ff_caps->classifiers_limit) ||
> +	    !le32_to_cpu(ff->ff_caps->rules_limit) ||
> +	    !le32_to_cpu(ff->ff_caps->rules_per_group_limit) ||
> +	    !ff->ff_caps->selectors_per_classifier_limit) {
> +		err = -EINVAL;
> +		goto err_ff;
> +	}

[Severity: High]
Should values reported by the device be fatal to probe here?

virtnet_ff_init() returns -EINVAL whenever the device reports any of
groups_limit, classifiers_limit, rules_limit, rules_per_group_limit or
selectors_per_classifier_limit as zero, and -EPROTO from the selector
walk further down when a known selector type has a length other than
get_mask_size(type) or the reply is truncated.  The three kzalloc()s can
also return -ENOMEM.

Both callers only tolerate 0 and -EOPNOTSUPP:

virtnet_probe()
	err = virtnet_ff_init(&vi->ff, vi->vdev);
	if (err && err != -EOPNOTSUPP) {
		rtnl_unlock();
		goto free_unregister_netdev;
	}

virtnet_restore_up()
	err = virtnet_ff_init(&vi->ff, vi->vdev);
	if (err && err != -EOPNOTSUPP) {
		rtnl_unlock();
		virtnet_freeze_down(vi->vdev);
		remove_vq_common(vi);
		return err;
	}

So a device that advertises the three capability ids but reports zero
limits, or reports a selector mask length that does not match the Linux
header sizes, makes probe fail and unregister the netdev, and on resume
tears down an already restored device.  For a guest whose only interface
is virtio-net that removes the whole data path.

The comment above both call sites says "Not supported is an acceptable and
common return code", which suggests the feature is optional.  Would it be
better to leave ff_supported false and continue, the way an unknown
selector type is already handled with a break out of the loop, instead of
failing probe and resume?

> +
> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
> +		ff_mask_size += get_mask_size(i);
> +

[ ... ]

> +	ff->ff_actions->count = min_t(u8, ff->ff_actions->count,
> +				      VIRTIO_NET_FF_ACTION_MAX);
> +	if (!ff->ff_actions->count)
> +		goto err_ff_action;

[Severity: Medium]
Is err left at 0 on this branch?

The preceding virtio_admin_cap_get() succeeded, which is what "if (err)
goto err_ff_action;" just established, so err is still 0 when the zero
action count is detected.  The shared unwind path ends in:

	err_ff_action:
		kfree(ff->ff_actions);
		ff->ff_actions = NULL;
	...
		return err;

which returns 0 while ff_supported stays false and ff_caps/ff_mask/
ff_actions are all NULL.  Every other failure branch in the function
assigns -EOPNOTSUPP, -ENOMEM, -EINVAL or -EPROTO, so this looks like a
missing assignment.  The count byte comes straight from the device reply,
so a device reporting zero actions makes virtnet_ff_init() report success
to both callers, which test only the return value.

> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +	if (err)
> +		goto err_ff_action;

[Severity: Medium]
What happens on the device side when the second or third capability set
fails after this one succeeded?

virtnet_ff_init() commits three capabilities in sequence (resource,
selector, action), but the error labels only free the driver side copies:

	err_ff_action:
		kfree(ff->ff_actions);
		ff->ff_actions = NULL;
	err_ff_mask:
		kfree(ff->ff_mask);
		ff->ff_mask = NULL;
	err_ff:
		kfree(ff->ff_caps);
		ff->ff_caps = NULL;

No compensating capability set and no device reset is issued, so the
device keeps the flow filter resource capability committed while the
driver has discarded the limits it agreed to and leaves ff_supported
false.

vp_modern_admin_cmd_exec() turns the device reported admin status
directly into the errno:

drivers/virtio/virtio_pci_modern.c:vp_modern_admin_cmd_exec() {
	...
	ret = -status;
	...
}

so a device answering the selector or action set with status 95 produces
-EOPNOTSUPP, which both call sites deliberately swallow.  Probe and resume
then complete without reaching virtio_reset_device(), leaving the
half negotiated state in place.  Should the unwind path undo the
capabilities that were already accepted?

> +
> +	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
> +	sel = (void *)&ff->ff_mask->selectors;
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		/* If the selector type is unknown it may indicate the spec
> +		 * has been revised to include new types of selectors
> +		 */
> +		if (!sel->type || sel->type > VIRTIO_NET_FF_MASK_TYPE_MAX)
> +			break;
> +
> +		if (sel->length != get_mask_size(sel->type) ||
> +		    test_and_set_bit(sel->type, &sel_types)) {
> +			err = -EPROTO;
> +			goto err_ff_action;
> +		}
> +		real_ff_mask_size += sizeof(*sel) + sel->length;
> +		if (real_ff_mask_size > ff_mask_size) {
> +			err = -EPROTO;
> +			goto err_ff_action;
> +		}
> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> +	}
> +	ff->ff_mask->count = i;

[ ... ]

> @@ -5771,9 +5981,24 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  			goto err_destroy_pools;
>  	}
>  
> +	/*
> +	 * Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	rtnl_lock();
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		virtnet_freeze_down(vi->vdev);
> +		remove_vq_common(vi);
> +		return err;
> +	}
> +	rtnl_unlock();

[Severity: Medium]
Does this need to run with RTNL held?

virtnet_ff_init() issues up to seven admin commands (one cap id list
query, three cap gets, three cap sets), and each one ends in an
uninterruptible wait with no timeout:

drivers/virtio/virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
	...
again:
	if (virtqueue_is_broken(vq))
		...
	...
	wait_for_completion(&cmd->completion);
	...
}

virtqueue_is_broken() is only checked before the kick, and there is no
interruptible variant or fallback wake after it, so a device that never
completes the command never returns.  This hunk adds a new
rtnl_lock()/rtnl_unlock() section around the call on the resume path, and
virtnet_probe() calls it inside the existing RTNL section, so the global
RTNL mutex is held across those device round trips.  While it is held,
every netdev register/unregister and ip/ethtool operation on all
interfaces blocks, not just this device.

For comparison, the pre-existing control vq path in this driver
(virtnet_send_command) polls with a virtqueue_is_broken() escape.  Is
there something in virtnet_ff_init() that requires RTNL at these two
points?

>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> +
>  	return 0;
>  
>  err_destroy_pools:

[ ... ]

> @@ -7057,6 +7282,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		goto free_unregister_netdev;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
