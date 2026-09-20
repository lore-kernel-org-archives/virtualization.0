Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE93D9DA2
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928348; cv=pass; b=dHbni3u0pP0PG+HqadVByIPShHQ074h5du8uTGQj85mtnuzC0JXdTGj1RfEf+v6PhKOpFrJ4W5J9nhjoxX1C7qa/E2VG5Uavi3iHhBI188ZZTsGmFWfWyENXDyc2PhvPhE4nGNsfcFe9DStDWX0Ma2MGZptyoaxBuX3oVOswZ4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928348; c=relaxed/simple;
	bh=+X4OzsY3stcqbywP9OeHUn7Zys0o9g7OYuRZNgPlxYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDOcdVliurqzA5U2pS99NZwl51m8UZBXuCGAkgSBsZ16AbUfz1bvNVhTmTcpfN+fD3c8TOVUeFt02knL3o8enDT3206QWd9ODVxMWBV60f4xYHs3ELD+WamocG1gYqbiDUb1nJCcftL74oEfxpE2rmWO82Z6nLfkL0ndMFhpxFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ifpdPC4q; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ifpdPC4q"
ARC-Seal: i=1; a=rsa-sha256; t=1789928326; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LNghYtD4OlH9P0WaTUm6A3H9I2vTZRSnc3C4vn49JtzUOMuNwnz03SzjvAEBBKTCRHUKLqY1Rrfzu3MRnPO79MnarWmuDFdnnHFZe/cOG1g1486lzJC9yZRqCF8/H15tSkfPs1mt934BzpswLYq0e7GwS7a1b0ekTJke8vA5SGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789928326; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x7YggTuTmPe64d88OlRZlcygIYMj9+soGRs8ans7674=; 
	b=Ss0TClOGw55bZKYXiMOzKXvN3OqMBbcfL1I/bngAbTpg6klunAnzMu6oBzaDwh0LfmAW0aHVGW3nNKjA7Xutqzo56kDb8o2EhkpcDPIh2KCCL/NWxuZrorwSM/hCkZ4UJA5AwWX24ZenRiuZIoI/4M44BOO1fK5nWl/yrurZSWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789928326;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=x7YggTuTmPe64d88OlRZlcygIYMj9+soGRs8ans7674=;
	b=ifpdPC4qGitMf24+5bTuT3JLVA5ypDdMvFJqqNr100XLqTevKPb9/s9l0qbY/Aa9
	/ExqUjpyEgN4yqL2Kff3qlNUcSUaJXxkeYoq3s5iNBltTenvEwGzld7b2aistuNey6B
	fFnHzyv2P673DsFUpgBlslqKk14aMmBwYekgkhII=
Received: by smtp.zohomail.com with SMTPS id 1789928325465408.72793580338316;
	Sun, 20 Sep 2026 11:18:45 -0700 (PDT)
Message-ID: <f60abdeb-d62f-4034-a73f-2b954006f3af@collabora.com>
Date: Sun, 20 Sep 2026 21:18:40 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] drm/virtio: fix GEM object leaks on error paths
To: moonafterrain@outlook.com, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/15/26 10:39, Junrui Luo via B4 Relay wrote:
> v1 fixed one drm_gem_object_release() misuse in virtio_gpu_gem_create().
> Dmitry asked for the other occurrences the Sashiko bot pointed at [1], so
> v2 turns it into a series.
> 
> Patches 1-3 replace drm_gem_object_release() with drm_gem_object_put() on
> the GEM creation error paths. Patch 1 is unchanged from v1.
> 
> Patch 4 adds the missing drm_gem_object_release() before kfree(vram) in
> virtio_gpu_vram_create().
> 
> Only compile-tested (x86_64, CONFIG_DRM_VIRTIO_GPU=m).
> 
> [1] https://lore.kernel.org/all/55240372-c265-4b38-be94-f29a58ddbb22@collabora.com/
> 
> Changes in v2:
> - Add patches 2-4 covering the other occurrences reported by the bot
>   (Dmitry Osipenko)
> - Link to v1: https://lore.kernel.org/r/20260815-virtgpu-gem-create-leak-v1-1-a4e9fb18caa3@outlook.com
> 
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> Junrui Luo (4):
>       drm/virtio: fix object leak when drm_gem_handle_create() fails
>       drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
>       drm/virtio: fix object leaks in virtio_gpu_resource_create_blob_ioctl()
>       drm/virtio: release the GEM object on virtio_gpu_vram_create() errors
> 
>  drivers/gpu/drm/virtio/virtgpu_gem.c   |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 +++---
>  drivers/gpu/drm/virtio/virtgpu_vram.c  | 17 +++++++++--------
>  3 files changed, 13 insertions(+), 12 deletions(-)
> ---
> base-commit: 587858367581b9c55c3690f4e63382ad622719d4
> change-id: 20260915-fixes-8c6917e90665
> 
> Best regards,

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry
