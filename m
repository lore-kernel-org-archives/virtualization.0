Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397823BB109
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520420; cv=none; b=IK5pgl5aDCVgV9xTwmxHIPpvcf36uZCxqqKfZIjva94yECPL+SDoq0fWcRjeECGznY/RuKgWjI62pC2CKV6a38ReCwU+jlHP5RJjE8MFH3QF9n3bZDWsFXwzebmd47noiE6DwsqOCla2E8HJ5Tqa1YUm/NXNd5zJXnhVP7iBJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520420; c=relaxed/simple;
	bh=NjYkUbCxuX75H8du5evzDpcA/Ew4sVfJm9OykKrVcRM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JvYA8Imh7ucQZa7crY1HXiwCjLPDNwBcOyMpneXoRcJjET6MK2W0uMwpR47yh+8BHUcAlqxA5GYzaNhBYzfaQSZOMTWknUYZIHnKC9SOb8z6IziL7JscOiu6bVDRMXBwCkRnpGsoJjh0OBkaNyTnoZjg63+Px1nLQ4vc10UqV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/nw2hsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/nw2hsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6981F000FF;
	Fri,  9 Oct 2026 04:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791520416;
	bh=Ne/2qI03msERplZ8vivi85sAyWgx8UYkQFXP4scr3UE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/nw2hshMDcQ9BjAZmHQCCZqvXc/MTZFaDuTs5fIYetiWplrqXKk8iLX48sUdR7fJ
	 HaUGIjctxzM/zODbBGyV33Z5WC7TFIbDPafWfnHVJ5qNQQQDfhIgsUNFZoc3QdIpwo
	 HGJKPe1C++gWSmwlOGyekmDczX4mBM4TSKOrT3BbQPSKiUnpHs21hDrrc9gbem1dUY
	 3IM32wyd7cK6Li5LUJ2nX3oaAf1nsFSb+ot+ng6XX249Pz3KmWV2K8ac6zkaZSvu+4
	 GcUKkJx8lFs5FxIzctkZvwJZ3HKhnPNXL+Ahfk9y3Q3B/88Gw/iZ3p94UHdMX8lvEQ
	 5lQZLQD6g6BNA==
Message-ID: <sashiko-outbox-164844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] virtio_blk: add inline encryption support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linlin Zhang" <linlin.zhang@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261009041727.3170811-3-linlin.zhang@oss.qualcomm.com>
References: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
 <20261009041727.3170811-3-linlin.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:33:36 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] block: 3-way deadlock between vdev_mutex, q_usage_counter, and que=
ue freeze
- [High] block: virtio-blk mempool-less dynamic allocation in bio submissio=
n path
- [Medium] virtio_blk: TOCTOU race in ctrl_vq timeout causes memory leak
- [Medium] block: memory leak of crypto profile on virtblk_probe error path
--

commit d627f18e8794bdd76b3e4d25da68c27a6fd40f71
Author: Linlin Zhang <linlin.zhang@oss.qualcomm.com>

virtio_blk: add inline encryption support

This commit adds support for the virtio-blk inline encryption feature. It
allows offloading per-I/O encryption to the host's inline crypto engine
instead of performing it in software in the guest.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2499ae2fb9e22..6fd23b45868a1 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
[ ... ]
> @@ -985,7 +1051,7 @@ static void virtblk_ctrlq_callback(struct virtqueue =
*vq)
>  			 */
>  			if (abandoned) {
>  				kfree(creq->compl);
> -				kfree(creq);
> +				kfree_sensitive(creq);
>  			} else {
>  				complete(&creq->compl->done);
>  			}

[Severity: Medium]
Does this modification leave a time-of-check to time-of-use (TOCTOU) memory
leak unaddressed?

If a timeout expires in virtblk_ctrl_vq_request(), the waiter thread prepar=
es
to mark the request abandoned. If the device interrupt fires concurrently a=
nd
virtblk_ctrlq_callback() reads abandoned as false before the waiter updates
it, the callback will complete the request without freeing it.

The waiter then sets abandoned to true and returns -ETIMEDOUT. Callers like
virtblk_crypto_keyslot_program() receive -ETIMEDOUT and skip their local
cleanup, assuming the background mechanism will free it. Neither path frees
the memory.

[ ... ]
> @@ -1067,11 +1133,566 @@ static int virtblk_ctrl_vq_request(struct virtio=
_blk *vblk,
[ ... ]
> +static int virtblk_crypto_keyslot_program(struct blk_crypto_profile *pro=
file,
> +					   const struct blk_crypto_key *key,
> +					   unsigned int slot)
> +{
> +	struct virtio_blk *vblk =3D virtblk_from_profile(profile);
> +	struct scatterlist type_sg, out_req_sg, status_sg, *sgs[3];
> +	struct virtblk_ctrl_request *creq;
> +	int err;
> +
> +	mutex_lock(&vblk->vdev_mutex);

[Severity: High]
Can this create an AB-BA-C deadlock with queue freezing?

virtblk_crypto_keyslot_program() acquires vdev_mutex. Since this runs as a
block crypto profile callback during bio submission, the q_usage_counter re=
ad
reference is already held by the submitting thread.

If a concurrent teardown initiates a queue freeze via blk_mq_freeze_queue(),
it blocks waiting for existing readers to finish. Concurrently, if
virtblk_report_zones() has acquired vdev_mutex and attempts to allocate a
request (blocking on the freeze), a 3-way deadlock occurs where
virtblk_report_zones blocks on the freeze, the freeze blocks on the bio
submission, and the bio submission blocks on vdev_mutex.

> +	if (!vblk->vdev) {
> +		err =3D -ENXIO;
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * GFP_NOIO: this callback runs on the bio-submission path, which
> +	 * memory reclaim can reach while writing back dirty pages to this
> +	 * same device; GFP_KERNEL here could recurse into that same reclaim
> +	 * and self-deadlock.
> +	 */
> +	creq =3D kzalloc_obj(*creq, GFP_NOIO);

[Severity: High]
Is it safe to use a mempool-less dynamic allocation here in the synchronous
bio submission path?

Under severe memory pressure, kzalloc_obj() (and kmalloc_obj() in
virtblk_ctrl_vq_request) can fail and return -ENOMEM. This causes the block
layer to immediately fail the bio with BLK_STS_RESOURCE instead of requeuing
it, potentially dropping page writebacks and breaking forward-progress
guarantees.

[ ... ]
> @@ -1764,6 +2387,28 @@ static int virtblk_probe(struct virtio_device *vde=
v)
[ ... ]
> +		} else {
> +			err =3D virtblk_init_crypto(vblk);
> +			if (!err) {
> +				if (!blk_crypto_register(&vblk->profile, vblk->disk->queue))
> +					dev_warn(&vdev->dev,
> +						"failed to register inline crypto profile\n");
> +			} else {
> +				dev_warn(&vdev->dev,
> +					"inline crypto init failed: %d, continuing without inline crypto su=
pport\n",
> +					err);
> +			}
> +		}
>  	}
> =20
>  	err =3D device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);

[Severity: Medium]
Does this error path leak the crypto profile allocations?

If device_add_disk() fails, the probe function jumps to out_cleanup_disk.
Because device_add_disk() failed, the disk's GD_ADDED flag isn't set,
meaning put_disk() will skip the .free_disk callback (virtblk_free_disk).
As a result, virtblk_destroy_crypto() is never called, leaking the
dynamically allocated profile.slots and profile.slot_hashtable arrays.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041727.3170=
811-1-linlin.zhang@oss.qualcomm.com?part=3D2
