Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79337CD53;
	Mon, 17 Aug 2026 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005752; cv=none; b=TzobPX5PV4N3M6rZtArmlXmv8OUbPfDRnouL5XVV1vhEHK6uCw9eWyNs8Z9adxTr32/lEXwqhxNO7qG0V64/7l+nP1lBvBV6iEGSrOECjNXoF/MM71HK6dUM/anJMHhLXWwou1fOhQpnBK3+LiA4MbAdmT8BbOzX+iMxY2hekxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005752; c=relaxed/simple;
	bh=b5EKJhyOsfDpZsBc00HQZrNdccZ7wXvf9PxKdTdKSJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYAc5a5+fTdoxBwa7Nts3ExfbSaT2gu+6cXz8/mRgTgUXckctQaayl6wNgIYd6hIWMa14GUz7xTmuIGSL2UgWg5UescNk2MLeOoIJYdyRygjtt33tA9rVTwBIT1RhXmkp8znvLxYlrnl/1TS0bOCpZbCVjNqdQFvxwMSihKcbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed0EOKRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed0EOKRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7491F000E9;
	Mon, 17 Aug 2026 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005750;
	bh=mtc1pe3dG9hjK6+NzPnEIWMpHuoV9nziD9Nq9Tki3nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ed0EOKRQ/v+CDnHObjUDXcEqOdxiH50khknwpH9lRufCEAn7xpNgyUbdPbXLm6Xco
	 E5WYcmp0TQs32xm3OerbfiegZ5BqfrNlME6HOVTMgSeXev0pNT+6UIvO3AU0frrthS
	 wklbQU+BCRPsrE1QJmm1rGwr0L9lH2/UQcbztJjgFGeF8BFM4EtEOOvmDlTbdWRtL2
	 ziI3uHG651Ct8ndPk5RT81zljIh8f8/mA4Gjp+jashBXEt+xN3W+AJ27xH3nc6CvzI
	 yNrhmcAYUhlTdRK21S7nQWpYb7qtJIrY4d3JNWjX5wMLfIxpuzqLYUe0RlvU+7OuPF
	 fQaFS4lYThp9Q==
From: Jakub Kicinski <kuba@kernel.org>
To: xiongweimin@kylinos.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	mst@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com
Subject: Re: [PATCH] virtio_net: roll back RSS state on control failure
Date: Mon, 17 Aug 2026 15:29:09 -0700
Message-ID: <20260817222909.3681921-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811022055.3465420-1-xiongweimin@kylinos.cn>
References: <20260811022055.3465420-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    virtio_net: roll back RSS state on control failure

This patch saves the driver's cached RSS state (hash types, hash key and
indirection table) before issuing an RSS/hash control virtqueue command
and restores it if the command fails.  It also makes virtnet_set_rxfh()
propagate the failure to the caller instead of returning success.

A couple of questions on the commit message and the new rollback paths
below.

>     Preserve the previous local state around RSS/hash control commands and
>     restore it when the device update fails, while propagating the error to
>     the caller.

[Severity: Low]
Should this carry a Fixes: tag?  The change alters user-visible behavior:
virtnet_set_rxfh() previously returned 0 even when the control command was
rejected, and all three paths left the cached RSS state describing a
configuration the device never accepted.

The rxfh and RXHASH paths come from c7114b1249fa ("drivers/net/virtio_net:
Added basic RSS support.") and the hash-flow callback from c11708209df2
("drivers/net/virtio_net: Added RSS hash report control."), so a Fixes:
line would help stable tooling and backporters scope the fix.

>     v1 -> v2:
>       - Use kvmemdup() instead of kmemdup() in virtnet_set_rxfh() for the
>         saved RSS header, since the indirection table can push the header
>         size up to ~128K.

[Severity: Low]
This isn't a bug, but the inter-version changelog is above the '---'
separator, so it becomes part of the permanent git history.  Could it move
below the '---' marker instead?

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e2a5876c6c8c..995ca46404088 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -4350,9 +4351,13 @@ static int virtnet_set_hashflow(struct net_device *dev,
>  	if (new_hashtypes != vi->rss_hash_types_saved) {
>  		vi->rss_hash_types_saved = new_hashtypes;
>  		vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
> -		if (vi->dev->features & NETIF_F_RXHASH)
> -			if (!virtnet_commit_rss_command(vi))
> +		if (vi->dev->features & NETIF_F_RXHASH) {
> +			if (!virtnet_commit_rss_command(vi)) {
> +				vi->rss_hash_types_saved = old_hashtypes;
> +				vi->rss_hdr->hash_types = cpu_to_le32(old_hashtypes);
>  				return -EINVAL;
> +			}
> +		}
> +		}
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but while the block is being
touched: the write to the device-visible vi->rss_hdr->hash_types in
virtnet_set_hashflow() happens outside the NETIF_F_RXHASH check, while the
control command is only sent inside it.  Should the header write also be
conditional?

With rx-hashing off, virtnet_set_features() has already programmed
VIRTIO_NET_HASH_REPORT_NONE into the same header:

	if (features & NETIF_F_RXHASH)
		vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
	else
		vi->rss_hdr->hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);

A following rx-flow-hash request then overwrites hash_types with a non-zero
value and skips the command, so the value stays staged in the shared
header.  The next unrelated commit sends the whole header:

drivers/net/virtio_net.c:virtnet_commit_rss_command() {
	sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
	...
}

so an ethtool -X key or indirection update via virtnet_set_rxfh() would
push those hash types to the device while dev->features still reports
RXHASH off.  ethtool_set_rxfh_fields() in net/ethtool/ioctl.c only checks
ops->set_rxfh_fields, so the sequence

	ethtool -K eth0 rx-hashing off
	ethtool -N eth0 rx-flow-hash tcp4 sd
	ethtool -X eth0 hkey ...

is reachable from userspace.  The new rollback only restores hash_types
inside the RXHASH branch, so this case is unchanged.

> @@ -5546,6 +5551,8 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  			    struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	struct virtio_net_rss_config_hdr *old_rss_hdr = NULL;
> +	u8 old_rss_key[NETDEV_RSS_KEY_LEN];
>  	bool update = false;
>  	int i;

[ ... ]

> +	if (rxfh->indir) {
> +		old_rss_hdr = kvmemdup(vi->rss_hdr, virtnet_rss_hdr_size(vi),
> +				       GFP_KERNEL);
> +		if (!old_rss_hdr)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < vi->rss_indir_table_size; ++i)
> +			vi->rss_hdr->indirection_table[i] =
> +				cpu_to_le16(rxfh->indir[i]);
> +		update = true;
> +	}
>  
> +	if (rxfh->key) {
> +		memcpy(old_rss_key, vi->rss_hash_key_data, vi->rss_key_size);
>  		memcpy(vi->rss_hash_key_data, rxfh->key, vi->rss_key_size);
>  		update = true;
>  	}
>  
> -	if (update)
> -		virtnet_commit_rss_command(vi);
> +	if (update && !virtnet_commit_rss_command(vi)) {
> +		if (old_rss_hdr)
> +			memcpy(vi->rss_hdr, old_rss_hdr, virtnet_rss_hdr_size(vi));
> +		if (rxfh->key)
> +			memcpy(vi->rss_hash_key_data, old_rss_key, vi->rss_key_size);
> +		kfree(old_rss_hdr);
> +		return -EINVAL;
> +	}
> +
> +	kfree(old_rss_hdr);

[Severity: High]
Should both of these frees be kvfree()?  old_rss_hdr comes from
kvmemdup(), whose kernel-doc in mm/util.c is explicit about the pairing:

mm/util.c:
 * Return: newly allocated copy of @src or %NULL in case of error,
 * result may be not physically contiguous. Use kvfree() to free.
 */
void *kvmemdup(const void *src, size_t len, gfp_t gfp)
{
	void *p;

	p = kvmalloc(len, gfp);

The vmalloc fallback is real for the sizes this patch's changelog
mentions:

mm/slub.c:__kvmalloc_node_noprof() {
	ret = __do_kmalloc_node(PASS_BUCKET_PARAM(b),
				kmalloc_gfp_adjust(flags, size),
				node, PASS_TOKEN_PARAM(token), &ac);
	if (ret || size <= PAGE_SIZE)
		return ret;
	...
}

The kmalloc attempt for size > PAGE_SIZE runs without
__GFP_DIRECT_RECLAIM, so plain fragmentation is enough to fall through to
__vmalloc_node().  The allocation size here is virtnet_rss_hdr_size(vi),
which is derived from vi->rss_indir_table_size, read straight from device
config space in virtnet_probe():

		vi->rss_indir_table_size =
			virtio_cread16(vdev, offsetof(struct virtio_net_config,
				rss_max_indirection_table_length));

Once a vmalloc pointer is returned, kfree() derives a struct page from a
non-direct-map address:

mm/slub.c:kfree() {
	page = virt_to_page(object);
	slab = page_slab(page);
	if (!slab) {
		/* kmalloc_nolock() doesn't support large kmalloc */
		free_large_kmalloc(page, (void *)object);
		return;
	}
	...
}

Can this corrupt slab state or oops, and leak the vmalloc area?  Note the
kfree() on the success path is the common case, so it would be hit on every
successful indirection-table update on such a device, not only on control
virtqueue failure.

> @@ -6171,13 +6195,17 @@ static int virtnet_set_features(struct net_device *dev,
>  	}
>  
>  	if ((dev->features ^ features) & NETIF_F_RXHASH) {
> +		__le32 hash_types = vi->rss_hdr->hash_types;
> +
>  		if (features & NETIF_F_RXHASH)
>  			vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
>  		else
>  			vi->rss_hdr->hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
>  
> -		if (!virtnet_commit_rss_command(vi))
> +		if (!virtnet_commit_rss_command(vi)) {
> +			vi->rss_hdr->hash_types = hash_types;
>  			return -EINVAL;
> +		}
>  	}

[Severity: Medium]
This is a pre-existing issue, but since partial rollback is being added
here: the guest-offload change earlier in the same function has already
been committed to the device by the time this RSS failure returns
-EINVAL:

drivers/net/virtio_net.c:virtnet_set_features() {
	...
		err = virtnet_set_guest_offloads(vi, offloads);
		if (err)
			return err;
		vi->guest_offloads = offloads;
	...
}

The core does not apply the requested feature set when ndo_set_features()
fails:

net/core/dev.c:__netdev_update_features() {
	if (unlikely(err < 0)) {
		netdev_err(dev,
			"set_features() failed (%d); wanted %pNF, left %pNF\n",
			err, &features, &dev->features);
		return -1;
	}
	...
}

So a single request toggling both rx-gro-hw and rx-hashing, where the
offload command succeeds and virtnet_commit_rss_command() then fails,
leaves dev->features with the old NETIF_F_GRO_HW state while the device
and vi->guest_offloads hold the new one.  Since vi->guest_offloads was
updated, can a later dev->features ^ features evaluation decide no
reprogramming is needed and make the divergence persistent?  Would
re-issuing virtnet_set_guest_offloads() with the previous mask and
restoring vi->guest_offloads before returning the error be appropriate
here?
-- 
pw-bot: cr
