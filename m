Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03B47F2F3
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395564; cv=none; b=aP5Xuiw/atP9Jig1mANvpiVb7im6aIKW3O1g7h61+pGkOBbZhjttRo8bIleacUZoZlEs+/GQBXjoBdQhOWraxpPbq4zpTPST6QA9EaRLYgmHY0THCgiH+2ljB3AExaDiIqxR4oDBdJsNkab44Y4qWBGTO/xI4vdgwlzVli/W0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395564; c=relaxed/simple;
	bh=sRKg0Uq+/cqF4eameyT7s8bXuKpanQAHnlgQscLwO7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SO0X1ne9fizoV2DDdfB/TKzsXfvY//r3oKdXix6d3kZYtzQNCpjcpDRvcL/AMUEc2Zhei85+njoTkFz9TNTWzBSEBphYeZJ4MbO4x7gYadvFRApQLdr6BMcOhcakalAXdQazEoF0ScfPqGJu2tQCDmQ14oUTqy9fbuounmkAqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOErOI2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOErOI2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B9A1F00893;
	Mon, 14 Sep 2026 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395559;
	bh=qGPicOM+xg1jWVwbxs4v/qeBdfCHAo9k50ozOykepls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iOErOI2xG5Rkv0by48VXAqP2sv1kOY8Y5AU0XPOBm8JE2+zpkaIk4S6UUXl1MTozT
	 z9XV4vl3cgkrb0BHHSgmLW8+X/6oWrcR0RY+/EKjKDDGlDoWllLuoYvNhchZcdLAef
	 qeeyMpCOPlIqiXnkaH8eEDdeOsNIpI/liijyc9yWt8n9YtR8iN+8v9cLfJ/u4g7RIS
	 ckU2Co6+DxGUGO00EbA1QDu9qiXtWyCNhyctCzYDj3kfWYQASwYTP+KkqOuw6RCc15
	 T+9XCu5xVDUavGigFjqshtbal8KxVQyQ2UjzkX2iyk1fWOImHgFEgo9H3E6j3v3kzv
	 7VqDiyWl6MkMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] virtio_blk: add inline encryption support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linlin Zhang" <linlin.zhang@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260914133733.15429-3-linlin.zhang@oss.qualcomm.com>
References: <20260914133733.15429-1-linlin.zhang@oss.qualcomm.com>
 <20260914133733.15429-3-linlin.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:19:18 +0000
Message-Id: <20260914141919.18B9A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:

New issues:
- [Critical] REQ_OP_ZONE_APPEND requests with an encryption context are sil=
ently written in plaintext.
- [High] Zoned block devices completely skip inline encryption initializati=
on due to an 'else if' block.
- [High] Memory allocation on the block I/O submission path uses GFP_KERNEL=
 without a mempool, causing deadlocks.
- [High] Hardware queues are unquiesced before encryption keys are reprogra=
mmed during resume.
- [High] Cacheline sharing in `struct virtblk_ctrl_request` violates the DM=
A API, risking memory corruption.
- [High] Uninitialized vblk->crypto_profile_initialized leads to wild frees=
 on probe error paths.
- [High] blk-crypto operations can race with device removal, leading to NUL=
L pointer dereference.
- [Medium] The driver directly assigns Linux-internal crypto mode enums to =
the Virtio hardware descriptor without translation.
- [Low] VIRTIO_BLK_INLINE_ENCRYPTION is defined as a tristate but cannot be=
 built as an independent module.

Pre-existing issues:
- [High] The error cleanup path in virtblk_probe contains a use-after-free =
and double free of vblk.
--

commit 787711d9770fce24131418d43dc33cb33a894de6
Author: linlzhan <linlin.zhang@oss.qualcomm.com>

virtio_blk: add inline encryption support

This commit adds support for the virtio-blk inline encryption feature,
allowing guest VMs to offload per-I/O encryption to the host's inline
crypto engine. It wires up device encryption characteristics to a
struct blk_crypto_profile and handles key management via control commands.

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

[Severity: Low]
Could this lead to configuration ambiguity? VIRTIO_BLK_INLINE_ENCRYPTION is
defined as a tristate, but the code is conditionally included directly with=
in
the virtio_blk module. Users might select 'M' thinking it builds a separate
crypto module, but it functions as an intra-file boolean.

[ ... ]

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 252ec93661532..3fd318e5e1f17 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -124,8 +136,23 @@ struct virtblk_req {
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
> +
>  	struct completion compl;
>  };

[Severity: High]
Does this struct packing risk memory corruption on non-cache-coherent
architectures?

The DMA-written buffers (in_resp, status) are packed directly adjacent to t=
he
compl field. On non-coherent architectures, cache invalidation for the DMA
fields can destroy the CPU's ongoing modifications to the waitqueue inside
compl during wait_for_completion().

[ ... ]

> @@ -262,20 +310,27 @@ static blk_status_t virtblk_setup_cmd(struct virtio=
_device *vdev,
>  				      struct request *req,
>  				      struct virtblk_req *vbr)
>  {
[ ... ]
>  	case REQ_OP_ZONE_FINISH:
>  		type =3D VIRTIO_BLK_T_ZONE_FINISH;
>  		sector =3D blk_rq_pos(req);
>  		break;
>  	case REQ_OP_ZONE_APPEND:
>  		type =3D VIRTIO_BLK_T_ZONE_APPEND;
>  		sector =3D blk_rq_pos(req);
>  		in_hdr_len =3D sizeof(vbr->in_hdr.zone_append);
>  		break;

[Severity: Critical]
Could this lead to plaintext data being written for encrypted zone append
requests?

When handling REQ_OP_ZONE_APPEND, the type is forced to
VIRTIO_BLK_T_ZONE_APPEND. Because this path does not check is_crypto_reques=
t(),
it bypasses the crypto setup...

[ ... ]

> @@ -337,6 +392,18 @@ static blk_status_t virtblk_setup_cmd(struct virtio_=
device *vdev,
>  	if (type =3D=3D VIRTIO_BLK_T_DISCARD || type =3D=3D VIRTIO_BLK_T_WRITE_=
ZEROES ||
>  	    type =3D=3D VIRTIO_BLK_T_SECURE_ERASE) {
>  		if (virtblk_setup_discard_write_zeroes_erase(req, unmap))
>  			return BLK_STS_RESOURCE;
>  	}
> =20
> +	if (type =3D=3D VIRTIO_BLK_T_CRYPTO_IN || type =3D=3D VIRTIO_BLK_T_CRYP=
TO_OUT) {
> +		memset(&vbr->out_hdr.crypto_append.msg, 0,

[Severity: Critical]
...and subsequently fails this check since type is VIRTIO_BLK_T_ZONE_APPEND
instead of VIRTIO_BLK_T_CRYPTO_OUT.

This prevents the crypto message descriptor from being attached, causing the
host hypervisor to see a standard unencrypted write and store the plaintext
data to disk.

[ ... ]

> @@ -1001,11 +1068,478 @@ static int virtblk_ctrl_vq_request(struct virtio=
_blk *vblk,
[ ... ]
> +static int set_virtblk_crypto_key_desc(struct virtio_device *vdev,
> +				       struct virtblk_ctrl_request *creq,
> +				       const struct blk_crypto_key *key,
> +				       unsigned int slot)
> +{
> +	struct virtio_blk_crypto_key_desc *desc =3D &creq->out_req.key_desc;
> +	enum blk_crypto_key_type key_type =3D key->crypto_cfg.key_type;
> +
> +	if (sizeof(desc->bytes) < key->size)
> +		return -EOVERFLOW;
> +
> +	memset(desc, 0, sizeof(*desc));
> +	desc->slot =3D cpu_to_virtio32(vdev, slot);
> +	memcpy(desc->bytes, key->bytes, key->size);
> +	desc->key_size =3D cpu_to_virtio32(vdev, key->size);
> +	desc->crypto_mode =3D cpu_to_virtio32(vdev, key->crypto_cfg.crypto_mode=
);

[Severity: Medium]
Can this leak a Linux-internal enum value directly into the hardware protoc=
ol
descriptor?

The desc->crypto_mode is set directly from key->crypto_cfg.crypto_mode, whi=
ch
is an internal enum blk_crypto_mode_num. If Linux adds a new mode or virtio
assigns different numbers in the future, this will silently send incorrect
crypto modes to the hypervisor.

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
> +	creq =3D kzalloc_obj(*creq, GFP_KERNEL);
> +	if (!creq)
> +		return -ENOMEM;

[Severity: High]
Is it safe to use GFP_KERNEL here?

This allocation occurs on the block I/O submission path. Under memory press=
ure,
this could recurse into memory reclaim, which may attempt to flush dirty pa=
ges
to this same block device, leading to a deadlock.

[ ... ]

> +static int virtblk_crypto_keyslot_evict(struct blk_crypto_profile *profi=
le,
> +					 const struct blk_crypto_key *key,
> +					 unsigned int slot)
> +{
> +	struct virtio_blk *vblk =3D virtblk_from_profile(profile);
> +	struct scatterlist type_sg, out_req_sg, status_sg, *sgs[3];
> +	struct virtblk_ctrl_request *creq;
> +	int err;
> +
> +	creq =3D kzalloc_obj(*creq, GFP_KERNEL);
> +	if (!creq)
> +		return -ENOMEM;

[Severity: High]
Similar to the programming path, is GFP_KERNEL appropriate here? The evicti=
on
path often occurs during inode or dentry reclaim, and recursing into memory
reclaim could cause deadlocks.

> +
> +	creq->type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_KEYSLOT_=
EVICT);

[Severity: High]
Could this race with device removal?

In virtblk_crypto_keyslot_evict(), vblk->vdev is accessed unconditionally. =
If
the virtio device is hot-unplugged, virtblk_remove() sets vblk->vdev to NUL=
L.
Since the block device may still be open by userspace, fscrypt might
subsequently tear down a key and call into this driver, causing a NULL poin=
ter
dereference.

[ ... ]

> +static void virtblk_destroy_crypto(struct virtio_blk *vblk)
> +{
> +	if (vblk->crypto_profile_initialized)
> +		blk_crypto_profile_destroy(&vblk->profile);
> +}

[Severity: High]
Could this cause a wild free on probe error paths?

vblk is allocated using kmalloc_obj() which does not zero memory. If the pr=
obe
fails before the profile is initialized, virtblk_destroy_crypto() might rea=
d a
true value for vblk->crypto_profile_initialized and pass garbage to
blk_crypto_profile_destroy().

[ ... ]

> @@ -1698,6 +2232,19 @@ static int virtblk_probe(struct virtio_device *vde=
v)
[ ... ]
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>  	    (lim.features & BLK_FEAT_ZONED)) {
>  		err =3D blk_revalidate_disk_zones(vblk->disk);
>  		if (err)
>  			goto out_cleanup_disk;
> +	} else if (IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION) &&
> +		   virtio_has_feature(vdev, VIRTIO_BLK_F_INLINE_ENCRYPTION) &&
> +		   virtio_has_feature(vdev, VIRTIO_BLK_F_CTRL_VQ)) {
> +		err =3D virtblk_init_crypto(vblk);

[Severity: High]
Does this else if inadvertently disable inline encryption for zoned block
devices?

If a device advertises both ZONED and INLINE_ENCRYPTION features, the initi=
al
if block executes, causing the entire crypto initialization block to be ski=
pped
silently.

[ ... ]

>  	err =3D device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>  	if (err)
>  		goto out_cleanup_disk;
> =20
>  	return 0;
> =20
>  out_cleanup_disk:
>  	put_disk(vblk->disk);
>  out_free_tags:
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  out_free_vq:
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
>  	vblk->ctrl_vq.vq =3D NULL;
>  out_free_vblk:
>  	kfree(vblk);

[Severity: High]
This is a pre-existing issue, but does this error cleanup path have a
use-after-free and double free?

The call to put_disk(vblk->disk) drops the reference count, invoking
virtblk_free_disk() which frees vblk. The subsequent labels continue to
dereference vblk->tag_set and vblk->vqs, and eventually kfree(vblk) is call=
ed
again.

[ ... ]

> @@ -1798,6 +2345,9 @@ static int virtblk_restore_priv(struct virtio_devic=
e *vdev)
>  	virtio_device_ready(vdev);
>  	blk_mq_unquiesce_queue(vblk->disk->queue);
> =20
> +	if (vblk->profile.slots)
> +		blk_crypto_reprogram_all_keys(&vblk->profile);
> +
>  	return 0;
>  }

[Severity: High]
Could this expose unprovisioned keyslots during resume?

The hardware queues are unquiesced before blk_crypto_reprogram_all_keys() is
called. This instantly restarts I/O dispatch, meaning any pending encrypted
requests could be executed by the hypervisor with empty or invalid keyslots
before they are reprogrammed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914133733.1542=
9-1-linlin.zhang@oss.qualcomm.com?part=3D2
