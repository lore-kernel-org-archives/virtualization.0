Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E65471D1C
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244486; cv=none; b=Mn2SQ69TQv3yGQuiLMA7MG23je07b4Eoq84QasSun2fYO8CXJd9+k0M8bd3pd4e5aH1LGzXfmeQPkA2iK8MhdpLac8J12fcP5zHHR6h7jjjWcGRwd8F0Bd4OVUSLS2u6x2tqj0v/329K9HIp8WPa8DpjReXOk20TkvaHdK9uhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244486; c=relaxed/simple;
	bh=5mutbPuw/2juQ2/YevMqDPWsLNas6VClzZ/Wno5kI8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F88UWW4+ahbHAm0Dyqws+ZXIUeOMYUhXKueNQAd5TmOduHJxT3jge87LRhhBDKntr/ewCWG+1BX5MmnQURWZsZ2ig7GKR8GlFdixsJPIbAz2p3y/z2KZtoYZOy/U8IT+Rkc0H6GQwWX6ZnEIq1c1vat+RR2UGM/0es/4KQki+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gaf9HbiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gaf9HbiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABB01F00898;
	Thu, 24 Sep 2026 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790244478;
	bh=cOuYAWQzfp8h6z0+79qmbP7zq2+xblr6aMlVg6a2ckk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gaf9HbiNhHHf5dQyvcAZIYUyrSopIWn1MQxOTtJanlzbjFiBFmmAA4Y958gGE9E00
	 LSZqf/BSd7cfSfk6IV/3PIqDzNxnxs7YT7EqK/BLLy+kmcpLJEnbxL4al9WCYEqm5g
	 dU3+tTfQMknG1sDq3rBbXgtsAkp/eBjwrwC+ymQwS8VDoqxCkFb555AMlRY73PhyTM
	 jD/On4Srv3FrnvBCO5mAZMVcPqLzPXByJLzwcNoE6AlDD5z/nor5kUwR+57bmr5mKD
	 K/ak7JOfDLm78/636Ai9slKngf+mvOqxaDloPx5d/lZJHCo3pbl2IwYAuLzraIDS6F
	 KDgoWipW0zjaQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260924095556.1326164-4-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:07:57 +0000
Message-Id: <20260924100758.1ABB01F00898@smtp.kernel.org>
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
> - Mark writable pages dirty when unpinning
> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>   cleanup_object() on the unref response or on create failure
> - Clear userptr->pages on pin failure to avoid double-free on cleanup
> - Reject unaligned or overflowing userptr ranges at create time
> - Disallow PRIME export of userptr objects
> - Save CREATE_BLOB params and restore userptr resources after
>   hibernation without using the shmem restore path
>=20
> The hibernation restore path maps with the same attrs and direction
> used at create time, as documented next to the call. Like shmem
> blobs, the DMA API can still bounce through a buffer there. This
> design only avoids a second guest side shmem allocation and memcpy,
> nothing more.
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924095556.1326=
164-1-honghuan@amd.com?part=3D3

