Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594189;
	b=iWnWbE6RjY72b8pMm2bz13T60bHToAjj7Bx2fh5tZ4XanqMZPFyAEhAL1aQUx7IJrDpr
	 yE83yi2pnpYRcLh6FuwvuflNsljOtXlETEfvHPO73T+rFcQ+TZrG7AnHmvQzjOdoOkQ80
	 N6DLUjgyIyHel7iRVkC239naomrSJp0V+AnEyt34io/yqsim2ea6zfcP+GVE/W2Mnz+Uy
	 2XOQs3soxK1XrCkUFxq/PEkIXZUirIelGinfirZVDBCbsxONwESEY1bUEiZijfKqEQZN8
	 z6b6SeUP7txnt0YWDxpI+cKue5/tn9tCaLL5P55QIqckK+WmhpLZRCp+1u7ucczklVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594189;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dg6U/P0MMYUIgzijgvVFm5juGVgkNUmJ4jdws85ig2I=;
	b=O2nhawJmKttsX4Yp5vKcfNqpRRIbBpAKhlKubFzchVONZfK56oWwrbJZWYE6l0ftB+HM
	 ZX7LMJAQixAF29Be4lbxg8faC1W+Y6AugBez5eFPevq8l5aaWjeAxLFV1k7G7kjuxjGdT
	 VtN8Y+DfJBqZ2hgXMN5T4zNey+V6KnxAflE4e7gVoNyaABdB7QTtBIC2mFT9/4EYG4n72
	 RXVq4xLy8jsFP/NLW0dKPGbtekEFCu9iyrt6S6TUroIjzLBkm9PpqLBU3Ey6OaMu8uXqG
	 DktmVfzDqSahk676LfP0Zs+JebgqwoJmmeC9K90fD6S61zEbMCTgeIN/iRamV9BFDaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYAWNf4P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE725606A337
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYAWNf4P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4802F1F000C4;
	Wed, 25 Nov 2026 08:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795594189;
	bh=dg6U/P0MMYUIgzijgvVFm5juGVgkNUmJ4jdws85ig2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kYAWNf4PxDtLVWY5VtfGZex8kWzXJfs6z3xrt34L63aKS3b7xgF+sE22LJT1C9O5h
	 OFns3bI4q3YTzsFWBZtoIQ7b6u/hNsKXRISDNiYVnIsk8SHbL6P5sI2bu6rnGP1wm4
	 Y75is613V97wyZ+OsI44wgfMRr9Y4y09XWwg0wJ5iQv0eU9QIf2b5YNxca9u4mQIZ4
	 EnfVrRiNpTPzD8fdRffM/QLZIEwtFE5QURhKwCF/ZtA1DaWoPWUha3KvW0Hq0ViYov
	 0hf8s9Dq8a02FmkrqWGMP7bI6nVZrmO/7YP4OSKB9iZgH7Y8DpfVRaS7+eevftEvTb
	 Vk9ov/yII/WbQ==
Message-ID: <sashiko-outbox-232866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] virtio_blk: add fua write support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alberto Faria" <afaria@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261125075408.226762-2-afaria@redhat.com>
References: <20261125075408.226762-1-afaria@redhat.com>
 <20261125075408.226762-2-afaria@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:09:48 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] virtio_blk: missing VIRTIO_BLK_F_REQ_FLAGS check in
  virtblk_setup_cmd()
--

commit f7bfe54853bedaa1afa630f98325bb99ee3bb7cb
Author: Alberto Faria <afaria@redhat.com>

virtio_blk: add fua write support

This commit adds UAPI definitions for virtio-blk request flags and
VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA, and teaches virtio_blk to advertise and
handle REQ_FUA writes.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2b462005cdb68..b91d7dbd25cfd 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -248,7 +248,10 @@ static blk_status_t virtblk_setup_cmd(struct virtio_=
device *vdev,
>  		return BLK_STS_NOTSUPP;
> =20
>  	/* Set fields for all request types */
> -	vbr->out_hdr.ioprio =3D cpu_to_virtio32(vdev, req_get_ioprio(req));
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS))
> +		vbr->out_hdr.flags =3D 0;
> +	else
> +		vbr->out_hdr.ioprio =3D cpu_to_virtio32(vdev, req_get_ioprio(req));
> =20
>  	switch (req_op(req)) {
>  	case REQ_OP_READ:
> @@ -258,6 +261,10 @@ static blk_status_t virtblk_setup_cmd(struct virtio_=
device *vdev,
>  	case REQ_OP_WRITE:
>  		type =3D VIRTIO_BLK_T_OUT;
>  		sector =3D blk_rq_pos(req);
> +		if ((req->cmd_flags & REQ_FUA) &&
> +		    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA))
> +			vbr->out_hdr.flags |=3D cpu_to_virtio32(vdev,
> +				BIT(VIRTIO_BLK_REQ_FLAG_OUT_FUA));
>  		break;

[Severity: Medium]
Should REQ_OP_WRITE also check VIRTIO_BLK_F_REQ_FLAGS before touching
vbr->out_hdr.flags, or should virtio_blk clear
VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA in a .validate callback when
VIRTIO_BLK_F_REQ_FLAGS is not offered?

Unlike virtblk_probe() and cache_type_store(), which check both features,
virtblk_setup_cmd() only checks VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA here.  If
VIRTIO_BLK_F_REQ_FLAGS is not negotiated (for example, when filtered out
via debugfs_filter_features), virtio_blk accepts
VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without its prerequisite feature and can
fail feature negotiation with spec-compliant devices, or overwrite
vbr->out_hdr.ioprio in the union if a REQ_FUA write reaches the queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125075408.2267=
62-1-afaria@redhat.com?part=3D1
