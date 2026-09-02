Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E549E5E1;
	Wed,  2 Sep 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354747; cv=none; b=FmCln/KbCX/ynu77parYUvhSOxbUgYj4RG4Xq3GJgp/0pg0juHSlN9/BAo7z/Yrxo0T32lueP6W5S5QsI+6HfUpzEtK9a37AVdcVEfxQ+3J9h7xfTW10f0OpE5g7Md4cixRlfIqJFWqvDpJn2o9z4aCx15KpSGTFOUb9uEaTvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354747; c=relaxed/simple;
	bh=falnlbcb2UHBwUKJH8Cu9GLrjlrpmgIUxV5YqF/0WWw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agJbGurUaVuqQhzujgtdAS6CsYCifuMwBvJGJMa0uuHCXDfWGRYqA1OxklafFUciRMn0Yo9xrnf1dYmp6iKMFi15yFLIjZTmiQEEo35j4gApGEcHLYqMwct3gZY4maUvlU75ooda3MTu45OBsOWk1i541SpyxtQuRKVkr4NCrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtY+zxWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtY+zxWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02071F000E9;
	Wed,  2 Sep 2026 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354745;
	bh=K0Q1Gpew/bkMQQl/km6bepDqTCCbSQChZLPLW+0/d80=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dtY+zxWs79qzyHLA6LlQrLhSWIXuQPlfiHG4HdYChzeyG18V4gisS+qMqnsXb0cBN
	 KENE/wFp88z+puYwKzc8ABqLzPNZgwIujte3jpGWt+eO+wW9VtOOO25XfQ8dqAZiHo
	 1nf7GLMY2jghGOg4nE2tqJDO6dRun+wv3p/Q1TiPOnmWeqpp6Ibahv/1xQ803hGYPX
	 4nNEdyVfVoqqP3ZkZguS/jXSNdIlEsLm4s12oj063Hk1z94wu+/NMWRRgD0v9bEx/G
	 6cGvHHfRZw41YVz3I0+NOVPIuZwdvZp12O1VAQNxk0sXtRakD4AWI+x1PQZdJxzAtp
	 IXjWmZt7FyxDQ==
Subject:
 Re: [net-next,v23,07/14] virtio_net: Create a FF group for ethtool steering
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:24 +0000
Message-ID: <178835474446.3394541.12292421422984466705@kernel.org>
In-Reply-To: <20260831161109.2999926-8-shshitrit@nvidia.com>
References: <20260831161109.2999926-8-shshitrit@nvidia.com>
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

- [Medium] virtnet_ff_cleanup() (drivers/net/virtio_net.c:5945-5962)
  issues the new…

--

virtio_net: Create a FF group for ethtool steering

This adds a single flow filter group object, created during
virtnet_ff_init() with a hard-coded object ID, and destroyed in
virtnet_ff_cleanup().  A new uapi struct and object type define the
group payload.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4f78b881e493b..294cfd70662d3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -5897,6 +5907,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
> +	/* Use priority for the object ID. */
> +	err = virtio_admin_obj_create(vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      &ethtool_group,
> +				      sizeof(ethtool_group));
> +	if (err)
> +		goto err_ff_action;
> +
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>  
> @@ -5921,9 +5944,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  
>  static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  {
> +	int err;
> +
>  	if (!ff->ff_supported)
>  		return;
>  
> +	err = virtio_admin_obj_destroy(ff->vdev,
> +				       VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				       VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +				       VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				       0);
> +	WARN_ON_ONCE(err);
> +
>  	kfree(ff->ff_actions);
>  	kfree(ff->ff_mask);
>  	kfree(ff->ff_caps);

[Severity: Medium]

Is WARN_ON_ONCE() the right reporting mechanism for this error, given that
err here is not a kernel invariant?  Looking at virtio_admin_obj_destroy()
in drivers/virtio/virtio_admin_commands.c, err comes from either an
allocation failure or the device-supplied admin command status:

	data = kzalloc_obj(*data);
	if (!data)
		return -ENOMEM;
	...
	err = vdev->config->admin_cmd_exec(vdev, &cmd);
	kfree(data);

	return err;

virtnet_ff_cleanup() runs from virtnet_remove(), from the virtnet_probe()
error path, and from virtnet_freeze_down() on suspend.  An already reset or
NEEDS_RESET device, a surprise removal, or a misbehaving backend would then
produce a warning splat on an ordinary teardown path, and a guest panic when
panic_on_warn is set.  Would a rate-limited netdev_warn() or dev_warn()
convey the same information here?

The second part of the question is what happens to the device-side object
when the destroy does fail.  The error is discarded and the driver then
unconditionally does:

	kfree(ff->ff_actions);
	kfree(ff->ff_mask);
	kfree(ff->ff_caps);
	ff->ff_supported = false;

so no record of the group object is kept, while the device may still hold
it.  Since virtnet_ff_init() always re-creates the same hard-coded ID:

	err = virtio_admin_obj_create(vdev,
				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
				      ...);
	if (err)
		goto err_ff_action;

can a group object left behind by a failed destroy make the next create of
that same ID fail, and thereby turn an ignorable teardown error into a
probe or resume failure on re-bind?  There is no retry, no alternate ID, and
no state retained that would allow either.

Note that this depends on whether a device reset already releases admin
resource objects, which is not something that can be determined from the
tree.  Would it be worth documenting that expectation alongside the destroy
call?

This code is unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
