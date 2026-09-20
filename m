Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147F42E405
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907942; cv=none; b=tZ+N7DeW9rY4FT0YPxVgV31pEGS+E48m+LAX3+AEEWYExZd/ruy8eqAvyNRU/qrQ6XTBxJyyfCeHyMLGF1h2C68re5Oe99tHqwgxrmiuU2svYizZWxAg4RHVt+lrXY9AHQ5IkiQ+9GPg1kjPVW8aHx9kPOuOLqFZSEPojalwqjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907942; c=relaxed/simple;
	bh=8fyPPEx77qko/wwfCJOuflY0phl+ZlIf7pcwbZrd/Bw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g4elnV3lISKxoLb3LZaGqfXyaTMWHt/RHZkDgdzf8epySVqkMfN9LVSL1Ixm/X1ihDQx/ZYW2DtxkuFp66axSz0ylQevwPqe7bgBmpkdtyTZKO7Ba3AQd9w24rkXlY2xArQt7ST1Fex3V8rOqtS5qSg40U8kfEv2z/JKU8j9AHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg1cUBul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg1cUBul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF61D1F000FF;
	Sun, 20 Sep 2026 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789907921;
	bh=aHuL77ADTbQsVK0tLmAweE9mn7naqBZD5Y7GrmIEvWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kg1cUBulPT0eiOpcBUZy+DrBH6sbqiKcffukz6v39lGO7WL6EpsE6WlwxjbkU0+Xa
	 fHWQYsngo++j4gInAImCrxr8qU/68Y+iybxOtn3AwcCAj5tB0vRHFd+4YBbRu2IJ7h
	 S8xoLdBpKI7othNn5ESe2txK+2OtnB6xONn5hjg+Tx31t63EyGGeeAcDzS3O5zQ5nl
	 utVfF65K3Kx+G/h8W8XYgG2qAnWofqvr9GXILOea+OeqajwPajWwzKw5g2aE10n7JP
	 jrEnV2YEMj9rjiHOtP0vnlqnTQnW3I9svZMXvD6tzbgLTrRkeJqryjcCH2Gdo+YiPF
	 b9KsVK8RBs+pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] virtio_blk: add inline encryption support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linlin Zhang" <linlin.zhang@oss.qualcomm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260920122444.2549493-3-linlin.zhang@oss.qualcomm.com>
References: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
 <20260920122444.2549493-3-linlin.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 12:38:40 +0000
Message-Id: <20260920123840.EF61D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] block: memory leak of sensitive cryptographic key material in virt=
io_blk
- [High] block: DMA cacheline sharing in virtblk_ctrl_request causes data c=
orruption
- [High] block: deadlock in virtblk_crypto_generate_key() due to vdev_mutex
- [Medium] block: incorrect bitwise arithmetic in get_supported_blk_key_typ=
es() breaks negotiation
- [Medium] block: Kconfig VIRTIO_BLK_INLINE_ENCRYPTION tristate causes link=
er errors
--

commit 3dd149ac489e952ca2319a45325b2d578747f639
Author: linlzhan <linlin.zhang@oss.qualcomm.com>

virtio_blk: add inline encryption support

This commit adds support for the virtio-blk inline encryption feature,
allowing the guest to offload per-I/O encryption to the host. It wires up
device characteristics to a blk_crypto_profile and manages keys via the
control virtqueue.

> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 858320b6ebb7e..58bb050d4617c 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -372,4 +372,16 @@ config BLK_DEV_ZONED_LOOP
> =20
>  	  If unsure, say N.
> =20
> +config VIRTIO_BLK_INLINE_ENCRYPTION
> +	tristate "Virtio block inline encryption support"
> +	depends on VIRTIO_BLK && BLK_INLINE_ENCRYPTION

[Severity: Medium]
Should this option be a bool instead of a tristate?

If a user configures CONFIG_VIRTIO_BLK=3Dy and CONFIG_BLK_INLINE_ENCRYPTION=
=3Dm,
this dependency evaluates to 'm'. Because the inline encryption code is
integrated directly into virtio_blk.c using IS_ENABLED(), it gets compiled
as built-in alongside virtio_blk. It will then attempt to link against
blk_crypto_profile_init() and other block crypto symbols which are loadable
modules, causing unresolved symbol errors during linking.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2fad86e8f7a9a..30c303364ca97 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
[ ... ]
> @@ -124,7 +136,21 @@ struct virtblk_req {
>  };
> =20
>  struct virtblk_ctrl_request {
> +	/* Type byte, always its own out-sg for every command. */
>  	__virtio32 type;
> +	/* Out request, sent as a second, separate out-sg if any. */
> +	union {
> +		struct virtio_blk_crypto_key_desc key_desc;
> +		struct virtio_blk_crypto_key_blob blob;
> +	} out_req;
> +
> +	/* In response */
> +	union {
> +		struct virtio_blk_crypto_key_blob blob;
> +		struct virtio_blk_crypto_sw_secret secret;
> +		struct virtio_blk_crypto_modes modes;
> +	} in_resp;
> +	/* Status byte, always its own in-sg for every command. */
>  	u8 status;
> =20
>  	struct completion *compl;

[Severity: High]
Could this struct layout cause cacheline corruption on architectures with
non-coherent DMA?

The virtblk_ctrl_request struct dynamically allocates fields mapped for=20
DMA_TO_DEVICE (type, out_req) and DMA_FROM_DEVICE (status, in_resp),
alongside CPU-modified fields (abandoned, compl). Because the struct is
not cacheline aligned internally, these fields share CPU cachelines. If the
CPU writes to the abandoned field while a DMA operation is occurring, or
before dma_unmap_sg() invalidates the cache for DMA_FROM_DEVICE, the cache
coherency conflict might overwrite or discard data.

[ ... ]
> +static int virtblk_crypto_keyslot_program(struct blk_crypto_profile *pro=
file,
> +					   const struct blk_crypto_key *key,
> +					   unsigned int slot)
> +{
[ ... ]
> +	creq->type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_KEYSLOT_=
PROGRAM);
> +
> +	err =3D set_virtblk_crypto_key_desc(vblk->vdev, creq, key, slot);
> +	if (err)
> +		goto out_free;
> +
> +	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
> +	sg_init_one(&out_req_sg, &creq->out_req.key_desc, sizeof(creq->out_req.=
key_desc));
> +	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
> +	sgs[0] =3D &type_sg;
> +	sgs[1] =3D &out_req_sg;
> +	sgs[2] =3D &status_sg;
> +
> +	err =3D virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 1);

[Severity: Medium]
This is a pre-existing issue, but does virtblk_ctrl_vq_request() contain a
race condition when handling timeouts for these allocated control requests?

If wait_for_completion_timeout() times out, virtblk_ctrl_vq_request() sets
creq->abandoned =3D true to inform the callback to free the memory. However=
, if
the interrupt fires exactly after the timeout expires but before the lock is
acquired, virtblk_ctrlq_callback() reads abandoned =3D=3D false and assumes=
 the
waiting thread will free it. The waiting thread then returns -ETIMEDOUT and
skips freeing it, leading to a permanent leak of both creq and compl.

> +	if (err =3D=3D -ETIMEDOUT)
> +		goto out_unlock;
> +	if (err)
> +		goto out_free;
> +
> +	err =3D blk_status_to_errno(virtblk_result(creq->status));
> +out_free:
> +	kfree(creq);

[Severity: High]
Does this leak sensitive cryptographic key material in memory?

The creq buffer contains the plaintext or wrapped key descriptor, but it is
freed via kfree() instead of kfree_sensitive(). The fscrypt subsystem rules
mandate that keys must be zeroized after use to prevent memory disclosure.

[ ... ]
> +static int virtblk_crypto_derive_sw_secret(struct blk_crypto_profile *pr=
ofile,
> +					    const u8 *eph_key, size_t eph_key_size,
> +					    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
> +{
[ ... ]
> +	err =3D blk_status_to_errno(virtblk_result(creq->status));
> +	if (err)
> +		goto out_free;
> +
> +	memcpy(sw_secret, creq->in_resp.secret.secret, BLK_CRYPTO_SW_SECRET_SIZ=
E);
> +out_free:
> +	kfree(creq);

[Severity: High]
Similar to virtblk_crypto_keyslot_program(), does this leave the highly
sensitive derived software secret in memory instead of zeroizing it with
kfree_sensitive()?

[ ... ]
> +static int virtblk_crypto_generate_key(struct blk_crypto_profile *profil=
e,
> +					u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	struct virtio_blk *vblk =3D virtblk_from_profile(profile);
> +	struct scatterlist type_sg, resp_sg, status_sg, *sgs[3];
> +	struct virtblk_ctrl_request *creq;
> +	unsigned int key_size;
> +	int err;
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +	if (!vblk->vdev) {
> +		err =3D -ENXIO;
> +		goto out_unlock;
> +	}
> +
> +	creq =3D kzalloc_obj(*creq, GFP_KERNEL);

[Severity: High]
Can holding vdev_mutex during a GFP_KERNEL allocation cause a deadlock here?

Under memory pressure, GFP_KERNEL triggers direct reclaim, which flushes
dirty pages to the block device. If the bio requires inline encryption, the
block layer synchronously calls virtblk_crypto_keyslot_program() from the I=
/O
submission path. That callback immediately attempts to acquire vdev_mutex,
which is already held by the sleeping thread, causing a strict AB-BA/AA
deadlock.

[ ... ]
> +static unsigned int get_supported_blk_key_types(u8 virtio_key_types)
> +{
> +	unsigned int supported =3D 0;
> +
> +	if (virtio_key_types & VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW)
> +		supported |=3D virtio_key_type_to_blk(VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW);
> +	if (virtio_key_types & VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)
> +		supported |=3D virtio_key_type_to_blk(VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WR=
APPED);
> +
> +	return supported;
> +}

[Severity: Medium]
Does this construct an invalid capability bitmask by directly bitwise ORing
raw enum values instead of shifting them?

The block layer's profile->key_types_supported strictly requires a bitmask
where support is represented as (1 << BLK_CRYPTO_KEY_TYPE_...). For
BLK_CRYPTO_KEY_TYPE_HW_WRAPPED (value 2), the accumulated enum value sets
bit 1, making supported equal to 3. The core block layer later checks
3 & (1 << 2), which evaluates to 0, incorrectly causing
blk_crypto_config_supported() to reject hardware-wrapped keys as unsupporte=
d.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920122444.2549=
493-1-linlin.zhang@oss.qualcomm.com?part=3D2
