Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514403EFD29
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289545; cv=pass; b=FKQe1+bpWU1lA4Lrtpga4GXFp8yyKNu2tBAE5yUGEofC6jy2yOmpUjd7in2MDe7nLxkbpRXNyKMRsMexGMfbKaFW0/RurLHtgwWxE0b0KLqNQffgO+5fPiuCibtHekp7btPk+juA6ii+sRoMXdJqun5L24dUUMJ1c6TPE11YzgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289545; c=relaxed/simple;
	bh=96EEa2Z+/JS3QftqKuJ1lhUX73f0fiofxaWZ7ZDlWmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LKcK+/W1bnMxOJ4dM+v3WMIRn7S6+N4oNqaDeQZZ7lZrzVWrXW8MUnbV8U+cO+nFGL7+r3B376bbT1gOTBlyTJ+6ep0koHPCt3DvuFVZlyEi+MCbiGCeBlOXLAPgBeU7Q3Ww9Zf4EFw2SRCq652m+bnwdetS/UymppKJjYXoM/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Zmy8qXKk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Zmy8qXKk"
ARC-Seal: i=1; a=rsa-sha256; t=1779289529; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nGR376jrROr2uJ3rjtw59qHCZlWNLP46lVPOEnEKxeJPEsqHsGZZ2IKLEREWOuvGB8F0pnswnEuCQjBlvEWhr8SIxTZ4XZif+G47yj8OEcWqXehH9n8XgLSh9zfLKoJdPTV9Kobxy0s/8uk7eBbbr9S6Zgwk1TvPLEtaXG3FEME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779289529; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=3BKtKUyHQJrtpBvB7G1utzo2T87gBxc/CZcvP9tnSew=; 
	b=l+WctTFeivg9Y4j5ZBqBXseb/DWHnso/VqS0x6GKcKy4MVWC5bLVSku2jaJgybRufy1xeOnX0EiFmt6BVy+NKWYam1apqyKP+yO24MVJhnjw/h6cLa9nX+Q+m7EL8CroK6tvRYlco1a91fvxF1mhmxDfEh8Q+MlKl2EZGHkXDhc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779289529;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=3BKtKUyHQJrtpBvB7G1utzo2T87gBxc/CZcvP9tnSew=;
	b=Zmy8qXKkpCT6s3JGHDxzj+1l/QqHWebiz/x/WBD7DBxbvYllcIXDx+qlVN51x8Rv
	4gnSuZUTmcAZAdIY7FQ6BnYbbRHmTd+QY8qLiihnhGQgRHCOQQw99rWSSuYXUAgmIkF
	2bLgeXr0d+Dx0sV/bgWx9a31KOh5P7zWj12i0gtE=
Received: by mx.zohomail.com with SMTPS id 1779289505758769.0851870406319;
	Wed, 20 May 2026 08:05:05 -0700 (PDT)
Message-ID: <fb0ef5b4-33ed-4b67-bcc1-1c4df22dd73d@collabora.com>
Date: Wed, 20 May 2026 18:05:00 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/virtio: introduce F_BLOB_ALIGNMENT support
To: Sergio Lopez <slp@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20260428194450.518296-1-slp@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260428194450.518296-1-slp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/28/26 22:44, Sergio Lopez wrote:
> There's an increasing number of machines supporting multiple page sizes
> and on these machines the host and a guest can be running, each one,
> with a different page size.
> 
> For what pertains to virtio-gpu, this is not a problem if the page size
> of the guest happens to be bigger or equal than the host, but will
> potentially lead to failures in memory allocations and/or mappings
> otherwise.
> 
> To deal with this, the virtio-spec was extended to introduce with the
> VIRTIO_GPU_F_BLOB_ALIGNMENT feature [1]. If this feature is negotiated,
> we must use the "blob_alignment" field in the config to ensure every
> CREATE_BLOB and MAP_BLOB is properly aligned before sending it to the
> device.
> 
> We also introduce the VIRTGPU_PARAM_BLOB_ALIGNMENT parameter to allow
> userspace to query the alignment restrictions for blobs.
> 
> This supersedes "drm/virtio: introduce the HOST_PAGE_SIZE feature" [2].
> 
> [1] https://github.com/oasis-tcs/virtio-spec/commit/f9abfd55cb663837dda1153b826216dcf4d25b84
> [2] https://lkml.org/lkml/2024/7/23/438
> 
> Changes in v2:
> - Rebased.
> - Moved blob size alignment validation to verify_blob(), rejecting
> misaligned sizes early in the ioctl path instead of checking in
> virtio_gpu_cmd_resource_create_blob() and virtio_gpu_cmd_map()
> (Dmitry Osipenko).
> 
> Sergio Lopez (3):
>   drm/virtio: support VIRTIO_GPU_F_BLOB_ALIGNMENT
>   drm/virtio: honor blob_alignment requirements
>   drm/virtio: add VIRTGPU_PARAM_BLOB_ALIGNMENT to params
> 
>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 10 ++++++++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c   | 14 +++++++++++---
>  include/uapi/drm/virtgpu_drm.h         |  1 +
>  include/uapi/linux/virtio_gpu.h        |  9 +++++++++
>  6 files changed, 34 insertions(+), 3 deletions(-)
> 

Applied to misc-next, thanks

-- 
Best regards,
Dmitry
