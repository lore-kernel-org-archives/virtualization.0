Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8564D6C57
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726863; cv=none; b=Qqe+rawuInwIugvGZksH3EdOJNw/CTlmfLbeqS2n6RsmhuQgX1gVWVIzxEJgqfnYpEX1D5De7lwPMveq9ppV5rwz4gIwI89AMSp8gmR1w0igYf487J5htdt2xx2McQGiPqtcZTSwHMImRI0IZWbgQijxpV7fy14T+KM6X0MfH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726863; c=relaxed/simple;
	bh=Rxpkj7pp/Op5UkN01geCBSyaQDou7gWmpjsEUNkgPYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nWqYyedo0MF6HMoiaJ8x2ubDdoqyHw/PeENcSrknBoe7Xb4T9OwAZoKJRQeMG+lxb31GT9oG3ha6ubyVWu3Qdh7keSMFkw8hJuKfHugybiwbuMEcKTUDs+2HPsFaISoGjE3gGUoL/ehAG+5pjW0fhZuQa3y/AuwOiNC4MPLU/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1Wf6GXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1Wf6GXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5847E1F000FF;
	Fri, 18 Sep 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726861;
	bh=KDsfkNxMFu5fqNLr0RTeR89UAJDLSJBZCWfVWM75MFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a1Wf6GXKTpNhuJQ9XN32fR3nMZ5wEl8C+cq410//0xpco48IwJ+d/k2I67gsnqZ5Y
	 iFVILAh5ViSspakfHFTG+W5HjXnSwO5+u840QIVGQx5NiFCpWX/KwcEjxNT7H7kUav
	 9Z2KcfDq+tbWB9mG07wkhW92NDGq7UoS3FAANKbtQZ/SmlqUmfrO45UkgrwKBG9Qr7
	 /AX0rU3Qt2YiHgQpS0J3ezafg0NLZkWgVU3P6UCVzSvstIN6Wwx+YYkoM6Lh/YhS0U
	 CVpKwkjkXuNCCJFQ/B6SPt42fnmp9er4Y/NOEwwZ5MEU2epucl/gFrohyPDe3iftYn
	 dWFhN+PwJ7x2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] drm/virtio: implement userptr support for
 zero-copy memory access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260918095940.2253018-4-honghuan@amd.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:21:00 +0000
Message-Id: <20260918102101.5847E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add userptr blob objects so the guest kernel can pin an existing
> userspace mapping and advertise it as CREATE_BLOB backing entries.
>=20
> - New virtio_gpu_object_userptr type for userptr resources
> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>   required; use DMA_TO_DEVICE for USE_READONLY blobs
> - Sync userptr SG for the device on TRANSFER_TO_HOST
> - Mark writable pages dirty when unpinning
> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>   cleanup_object() on the unref response or on create failure
> - Clear userptr->pages on pin failure to avoid double-free on cleanup
> - Reject unaligned or overflowing userptr ranges at create time
> - Disallow PRIME export of userptr objects
> - Save CREATE_BLOB params and restore userptr resources after
>   hibernation without using the shmem restore path
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918095940.2253=
018-1-honghuan@amd.com?part=3D3

