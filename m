Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552273;
	b=Sh8G2/2GBcPAgcPAAv4CZfBaoOsi1N+xYsgyLQunRVaehZ8g/Lo05Q+aJB0tPGeUPmJ+
	 tZdG4j9jw33J90hdn/9THU4PXxk5L6c1hLG8b0RM81SAx6BIRfbJh8AZV+d9VTe2d7daG
	 hyKVBH/RXx7ALKDbCCwdWA9cYYLhCXyKqrstQsSQL0UV4P9RQZQVPhXAt0utqB1T0k4fO
	 DHvu9BM3WGx19f5lhCmiBEn7F6zFoRWSkr8jIAip+/IEjFx5Mcnim2HEGxl9LSOJrG0Y8
	 rCFv8VFmxQM+KBTEwBTBG2SpuBitphjGXFJ/MjxLFipU4gN9Lbm3LHdPCmE72S51JqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=faqxa6myYJ9pQ23V8PkdK/VSlqmXEPGWPxyH5A5RGgA=;
	b=N1k5FNCeymlpTdvat4Yc/kmj1QjdF5ayCO3+B3hX6ytxA/Tt0kxpmOQnzsqEiiL9zVfK
	 ZOJwNR3QODhe8EZUX2u3Jck+sy3/tM9uaYCmn7SIw38oK2MHYxgaw/JZMScT9gw7sYrlQ
	 aAPHMmm8+XdUrlun6PxY9YmweFvYgB9CSIkNs/eOpiC29Jqv7lA56bi4Lmx/CrZOwuOBE
	 ainZQzlMDgKMdlrzwQPsZ/3ZwFYpYyy1e1g5rTspe9B/HqIVseZXwgKzvkRq24+OEv1Wo
	 21Cn74JPRRft4Yexulzsbtb7vQgP0KxbF0uHJuOb2DH6ko/Zhmswg+rkKLwiRqkmqRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+anp9ai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607F606A324
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+anp9ai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99171F000C1;
	Sun,  1 Nov 2026 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793552272;
	bh=faqxa6myYJ9pQ23V8PkdK/VSlqmXEPGWPxyH5A5RGgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+anp9aiODGj/xyGd1V7ShWocEaL6Bcq59Y+qYaAHEjDcBnhRGf61O5w9wF1BtCiJ
	 HuOBxHSNXIcMoFdn+T17BXsX2jzZkpx1h+Hvo6OPCS9iW+Siyw+Pfg+MXNFvOVNJo5
	 QYeWd4u55wTXLJoSwuBG4t20QDY0h6HP46INRdjUrccjDqqlbggfHVqpKuTsyVEBAV
	 GmfsljsRXPaTyh6zLeCS63u4LnuUVC0QPprxKNtogyWI3F4IIODxMZWTJagNb6RtAQ
	 e+jrA3Y2h/nO3G4lJjirOvNyNbYgxgU03XUNaljLpiYGSECwanZK03jVe9zaRJFrEO
	 ZWoJBp2PZbFqg==
Message-ID: <sashiko-outbox-192516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] virtio_blk: fit max_segments to the virtqueue
 without indirect descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stjepan Poljak" <stjepan.poljak@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261101165307.2557421-3-stjepan.poljak@gmail.com>
References: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
 <20261101165307.2557421-3-stjepan.poljak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 16:57:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtblk_read_limits() takes max_segments from the device's seg_max and
> only clamps it to VIRTIO_BLK_MAX_SG_ELEMS - 2, which fits the largest
> virtqueue the spec allows, not the one the device has. Without
> VIRTIO_RING_F_INDIRECT_DESC every segment takes a descriptor in the
> ring, next to the header and the status. A device that offers a seg_max
> above its queue size minus two thus lets the block layer build requests
> that can never be added: virtqueue_add_split() warns that the request
> is larger than the ring and returns -ENOSPC, and the hardware queue is
> stopped to wait for descriptors that even an empty ring does not have.
> The I/O hangs.
>=20
> Seen with a device that offers seg_max 254 on a 128-entry queue without
> indirect descriptors, where the boot hangs loading /sbin/init:
>=20
>   WARNING: drivers/virtio/virtio_ring.c:688 at virtqueue_add_split+0x6c0/=
0x850
>   ...
>    virtqueue_add_sgs+0xd1/0x120
>    virtblk_add_req+0xe2/0x140
>    virtio_queue_rq+0x79/0x1a0
>=20
> With seg_max 126 it boots, with 127 it hangs.
>=20
> Without indirect descriptors, clamp max_segments to the size of the
> smallest virtqueue minus two. The previous commit makes the probe fail
> for a virtqueue smaller than three, so at least one segment is left.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101165307.2557=
421-1-stjepan.poljak@gmail.com?part=3D2

