Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680643;
	b=VwyVbbrQ9XZJpWbulOSComdhpDNDd4carELM//dzW/G7uRLaAd++JtDoOyt+n8ZQcj1p
	 GKRw/i7IP0klPmp4xZE5B8ACfksMhKB0Qrm7HyDElWbTYmOcMbqSGi0nxYhStTu5KjNRL
	 8yMEjD896Ao0Nz6d8f6WRcJhbuQzvnOxiWMOtNe9nHParn/OtJscxNICd7ynuJU1Db8BN
	 v9W7MXatwEmrCsRxhqwUSLnA8ERPOSwKMBFu4ipRsIClueBk2e2T9b6Q1pO6nKbvWduAi
	 wb+gxLq/U5zbQJ+Iehbzx0AREKz1bhWjApAcfwgx1buiVFOTFQIA1sQ7miOctd8dcWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680643;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wvmi5SM0vAMLmyyo3G+QRFysVNMQJQ57ml+2YHKNzHE=;
	b=UwzZtCeuh/EHyFMfbIIrUkEMwisj9gaPAhOSz1b9/rrG9BxqDCnxO3UL23wjGHlWQmFo
	 GpkeTbK2vfOhAwiGTjwZun3Y6CngFvC65vlNsdUhPkUvj4x/Bc10ZKXCKkSlIMTripFCu
	 nFsWkbvd4b1+wk2LS6MmwsuH8sH8wV/0+xwDwdU5XM5NYbkEYyTEKUYTo2clMGxd3FFhP
	 a6LTc/+dGHq3KKTpzXi2sF3nQjsDobV3bv6f36656gKoRYTjs0PXyJfG9YBf7blE89+sC
	 GeBTurjPRiJgN/Cd3OAxEgpRpHA0IxDtumjOoJyoWXojkFk6hPCy/k1njMtNJgvahkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMC4Eyg8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74C606A688
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMC4Eyg8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C861F000D8;
	Thu, 26 Nov 2026 08:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795680643;
	bh=Wvmi5SM0vAMLmyyo3G+QRFysVNMQJQ57ml+2YHKNzHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMC4Eyg87HVxMSIwv/Vc6gde9e5feeEDl/LQXzIFNkJiCUrXKrYcrEgay3S/Wwzva
	 oYZgioA1QKW5/Jfq9lwc2FNVg54VtsysZE3PZ+At7P4pEZGhYscHW6CDN0gtLLRbk4
	 aBgtHOcLs7mloPwA/O+UYqGIiV6lH7+1wq1VFsNICoGiBsBH5oHxq8mwSEgkKE6Ixi
	 4dOArPC7/i63jzvdvH1M/AOVlffHBThdgWB40Zm5IJ8pGXNbOZOSekxoPgC0VqnrZz
	 63TjvQ3ZIvmd2ffHQgc60bzZ/zQMopyMPYAozK/uGB9fBzkWp/5sk+ZijaL9lod6Gs
	 8+dv1Tza8Ad7w==
Message-ID: <sashiko-outbox-234986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_ring: reject unrepresentable split indirect
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Seojin An" <love09010224@uos.ac.kr>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261126080209.2898344-1-love09010224@uos.ac.kr>
References: <20261126080209.2898344-1-love09010224@uos.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:10:42 +0000
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
- [Medium] virtio_ring: DMA mapping leak in virtqueue_add_split() at
  total_sg =3D=3D 65536
--

commit f02f3f32e75945fa59c0806b58f447abf08594d4
Author: Seojin An <love09010224@uos.ac.kr>

virtio_ring: reject unrepresentable split indirect tables

This commit rejects split indirect descriptor tables in virtqueue_add_split=
()
when total_sg exceeds 65,536, preventing 16-bit descriptor index wrapping.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a2002..ad9e52584fb52 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -686,9 +686,19 @@ static inline int virtqueue_add_split(struct vring_v=
irtqueue *vq,
> =20
>  	head =3D vq->free_head;
> =20
> -	if (virtqueue_use_indirect(vq, total_sg))
> +	if (virtqueue_use_indirect(vq, total_sg)) {
> +		/*
> +		 * The core historically permits an indirect chain to exceed the
> +		 * queue size.  Preserve that policy, but do not let its 16-bit
> +		 * split descriptor links wrap within the allocated table.
> +		 */
> +		if (unlikely(total_sg > (1U << 16))) {
> +			END_USE(vq);
> +			return -E2BIG;
> +		}
> +
>  		desc =3D alloc_indirect_split(vq, total_sg, gfp);
> -	else {
> +	} else {
>  		desc =3D NULL;
>  		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
>  	}

[Severity: Medium]
Can total_sg =3D=3D (1U << 16) still wrap i to 0 after the final descriptor=
 and
leak all 65,536 DMA mappings on the unmap_release path?

alloc_indirect_split() sets extra[i].next =3D i + 1 (where next is u16), so=
 for
total_sg =3D=3D 65536, extra[65535].next wraps to 0.  After mapping all 65,=
536 SG
entries, virtqueue_add_desc_split() returns that 0 into i.  If
vring_map_single() then fails when mapping the 1 MiB indirect descriptor
table, unmap_release sees err_idx =3D=3D 0 and i =3D=3D 0 and breaks out of=
 the
cleanup loop on the first iteration without unmapping any of the SG entries:

drivers/virtio/virtio_ring.c:virtqueue_add_split() {
	...
unmap_release:
	err_idx =3D i;

	if (indirect)
		i =3D 0;
	else
		i =3D head;

	for (n =3D 0; n < total_sg; n++) {
		if (i =3D=3D err_idx)
			break;

		i =3D vring_unmap_one_split(vq, &extra[i]);
	}
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126080209.2898=
344-1-love09010224@uos.ac.kr?part=3D1
