Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC82F8E8F
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739999; cv=none; b=aodJ1sExLMkfyYV1IuFCNBBFnY26ClW6eC3U1mrRsogZXi5uEMz0OwnlH2E4bQLoqf18+Bm24mh3XPPR/64SpdPkV2/LRoDpqPaWilQDwfCjfW6wSS+wycsJNNyuR4qnYsb9SgkxNmb7eJq6k61u4u46GFV4K2ylk69u8CjzT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739999; c=relaxed/simple;
	bh=bu6eqLkuk9/04esvcIJgZ6AVoRhWYg/x1c+G3GcGof0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GNcECm22jE+wBOyhcREPqzOSnePe9TDjszntFGh9e/EdyuPMQRclEPHNnmdh7ByQhYxZlSX/pgjPZsdbJK68eRKDGNn/h2LywhqPmHuuSABxQxoqXEAUgL7cDZbA/dZJyYc4pyrpFV1bzTJ1VSe2MN/UcefOjhvcaGvHKRf8Td8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VClgInfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VClgInfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409451F00898;
	Fri, 18 Sep 2026 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789739997;
	bh=jfoeunxvxuOLn2nIvUOrzok2yZ5ULZIJxtxHYKNo1vQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VClgInfhOcxPblxkO/Eqy8sU2GyThwIXSXW0ieRyA2/fZHIVttlwoxsCIYoM8RlHc
	 /4VoUKe1oAfzbFQ/2L8YS6lCnaZ3vXQrWHRYwBFJPcdr4B8fK28RWaVU6f+1BNBzQk
	 vd9TCyEuN+wcRCbp+WnWv9sIo0kG6NNE/EFFegoWQyyY29RBwxzzae9RfUsPhrsDV3
	 mPLHrRJqv2sdXKWG9cM2cw32IhCaenVqzVq6idN8DvluCa6uu3+RFz+2FJpYYvVpaF
	 vWoQBFIyj+XV7NYJXAPMTYVXY5SzOHTkRnkX2YurO/RxuPqucfsPYPvV4hgzpr/s5l
	 Kqm23yuTSy07Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] virtio-blk: clamp max_segments to virtqueue ring
 size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergii Ushakov" <sergiiushakov@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260918135120.1261150-1-sergiiushakov@google.com>
References: <20260918083557-mutt-send-email-mst@kernel.org>
 <20260918135120.1261150-1-sergiiushakov@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 13:59:56 +0000
Message-Id: <20260918135957.409451F00898@smtp.kernel.org>
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
> Fixes: 0864b79a1533 ("virtio: block: dynamic maximum segments")
> Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918135120.1261=
150-1-sergiiushakov@google.com?part=3D1

