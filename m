Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A4495AC6
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731947; cv=none; b=eDc4YdpNmE5t48uZnm2Kj6a1Q7MJEwfeNnpqiTgwZe6ZeXI7Zbz9K71KN/3VvvKqpMnE2ybNdaeLXj7Rk/6MzQwmkqtkReT4647whNv/V7eO2ggB+bKeSasVh6Ji3aL5vHGxYkjIEKJPlEYL4/dbCMFu9hc4SzeuMx7J4YQnmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731947; c=relaxed/simple;
	bh=mrVFUJTOo1daounfcUE+emr2WEPUyPkJ5wb/K2MCep0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UX1/XJsi+kyAK+0jJxXzloMz9r/ouxKOrW4ZqHu3FefmCigTnhJkpa3rgPL9IA0zxMq7+1xNIwKubqNP9VIex9Y98e3aKPETeAgSmEQRF17i6UVPhhk5tDBODa5KcvuWE3N1mjaXE1qbGSVvU/e7C7+sCz3Qw60YKyXZX4uBqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAQeXa/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAQeXa/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D531D1F000FF;
	Fri, 18 Sep 2026 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789731946;
	bh=YkDvTLTkdhJflGXQPlSJUCCZj6atYIpjcJ7hm44cEwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAQeXa/v5A4w9Wm061XeeMnlvXVMIt/pqM3C0BM6yCyZaqptBfdj2vsxMuWWBcKFU
	 /TJkHE03VhL3X17bMjxy8IcESznNub3F//LtDOwnZAaMOtOnFwVsN8BM/qg+U3ixjT
	 GWrH51Mnjyu2FVDWipmQwi4Rmb0YfHyk6pdXsSm5CihBogKUdZJXohvJr7Ed/YA93p
	 BSJXSJZr+qlaPtiuXC9MY7Bzp3Rn6JjMWennEa/gUWtTmjNTqmDjgnifmPEru14vys
	 13VM7ZMbW8v5hwA4s544nrk4UNmy6cQjcxfu0l/GZvGNQL4vuLr6fWGmK45qcOmO2+
	 ydsOHLlyPrrgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] virtio-blk: clamp max_segments to virtqueue ring
 size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergii Ushakov" <sergiiushakov@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260918113412.1142493-1-sergiiushakov@google.com>
References: <20260916104218-mutt-send-email-mst@kernel.org>
 <20260918113412.1142493-1-sergiiushakov@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 11:45:45 +0000
Message-Id: <20260918114545.D531D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> In virtblk_add_req(), each request consumes 2 extra descriptors (out_hdr
> and in_hdr) in addition to the data scatter-gather segments.
>=20
> When a hypervisor (e.g. QNX Hypervisor) advertises VIRTIO_BLK_F_SEG_MAX
> with seg_max =3D 1024 alongside a 1024-entry split ring (vring.num =3D 10=
24)
> and VIRTIO_RING_F_INDIRECT_DESC disabled, lim->max_segments is set to
> 1024. When the block layer submits requests with 1023 or 1024 data
> segments, total_sg reaches 1025 or 1026. This exceeds vring.num (1024),
> causing virtqueue_add_split() to return -ENOSPC and permanently wedge
> the blk-mq queue.
>=20
> Furthermore, the Virtio specification (2.7.5.3.1) requires that a
> descriptor chain never exceed the Queue Size, and virtqueue_add_split()
> falls back to direct descriptors if indirect table allocation fails.
>=20
> Fix this by:
> 1. Rejecting queues with ring_size < 3 at probe, or
>    ring_size < (queue_max_segments + 2) during resume/reset recovery in
>    init_vq().
> 2. Unconditionally clamping sg_elems to (ring_size - 2) across all
>    virtqueues in virtblk_read_limits().
>=20
> Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918113412.1142=
493-1-sergiiushakov@google.com?part=3D1

