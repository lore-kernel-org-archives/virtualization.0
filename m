Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA62377A9C
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138082; cv=pass; b=aoDiUlykoNmZOFlgfVSydkLeAsMsvok8px8Hji99xxjn5agUXk2zUMI+SKz8olId1vGwf1Y9QXPsdN5k91DOHQXmFxEhIR39/sjL1bKGhiuNUMuvmV7V0AshPMygQ00SCWGLz3y7JOHTuxDL8diV7jNq9kWcFWZ0w9OyhaydVSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138082; c=relaxed/simple;
	bh=GHLg6SDNrhkM9DKrw86apgo/7DFazTpKpjhlOWv7OUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnDb2JWqRLCsvq3lIxQBDsGpjiDy7lfDvdE1zb7hgtk6lVSrkp8jC2YHedsEfaECy4B3AhjfynU27M+MPMB02lxRxRM2YRsXt/CAnKnFuLFchGXZuzpGcJ0Gmjct6+yJngbIw3XtDQgMYm/Ymc8xMz2u6pQ6jafNV0EfMN+RZy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=e8NBZ1f8; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="e8NBZ1f8"
ARC-Seal: i=1; a=rsa-sha256; t=1789138062; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=POe0m7d4cWCiT03WhfoKBkO4K/pcxpMIErYSKCTMMkshbAkDvudwxGxz8zUkcIk8hNhzyNN72pJGlLLYe4PCQFiUadnowlSrI614yQI1j56endTUdom1LKx34LZjG6nCA2Rqpywm4Ex2mobtjtYiW6tvAOvlpnfg8THnHvrBmrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789138062; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XDUuN6FRh6Lu+K5r5tPMrhat8mAWhPBxs1WD3laJcM0=; 
	b=UgkcqzI9FfSX4DvxnK4myK+KEMIlBfOEHZBC53k7rNoajxyTI5FWfvXEbJqhnLj4Z1VpFyWxPnWG6BqUgfjyG5/QBPLM5txnAA7/5V1h00tg85mWcpsXV5Itymx5ANuKFx0UNeIk+qDC1xc9vmyh6K3Ov2nQqVImIYNmSHc5isA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789138062;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XDUuN6FRh6Lu+K5r5tPMrhat8mAWhPBxs1WD3laJcM0=;
	b=e8NBZ1f8C8FWVnmvLu6MzHjI4dZZyCNAnOsz4/WI5jOmA8QzIUkfWtzxJFikBddj
	Bcu0VbjAO8bCKXoR313lxAohoOWn6goZ2aUf1oaWm7IVw3TqRE92OHOzK0MuQKTCjPt
	tCpp/rQDm9p3O4Fm7lw/o+wS5S0R91t4zJJ4NQOk=
Received: by mx.zohomail.com with SMTPS id 1789138060386322.0119231572652;
	Fri, 11 Sep 2026 07:47:40 -0700 (PDT)
Message-ID: <b624e1a8-e957-48bb-9ae3-93215d764e53@collabora.com>
Date: Fri, 11 Sep 2026 17:47:35 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] virtio-gpu: Add userptr support for compute
 workloads
To: Honglei Huang <honglei1.huang@amd.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Ray.Huang@amd.com
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 odaki@rsg.ci.i.u-tokyo.ac.jp, Chia-I Wu <olvaffe@gmail.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Honglei Huang <honghuan@amd.com>
References: <20260115075851.173318-1-honglei1.huang@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260115075851.173318-1-honglei1.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/15/26 10:58, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Hello,
> 
> This series adds virtio-gpu userptr support to enable ROCm native
> context for compute workloads. The userptr feature allows the host to
> directly access guest userspace memory without memcpy overhead, which is
> essential for GPU compute performance.
> 
> The userptr implementation provides buffer-based zero-copy memory access. 
> This approach pins guest userspace pages and exposes them to the host
> via scatter-gather tables, enabling efficient compute operations.
> 
> Key features:
> - Zero-copy memory access between guest userspace and host GPU
> - Read-only and read-write userptr support
> - Runtime feature detection via VIRTGPU_PARAM_RESOURCE_USERPTR
> - ROCm capset support for ROCm stack integration
> - Proper page lifecycle management with FOLL_LONGTERM pinning
> 
> Patches overview:
> 1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
> 2. Add virtio-gpu API definitions for userptr blob resources
> 3. Extend DRM UAPI with comprehensive userptr support
> 4. Implement core userptr functionality with page management
> 5. Integrate userptr into blob resource creation and advertise to userspace
> 
> Performance: In popular compute benchmarks, this implementation achieves
> approximately 70% efficiency compared to bare metal OpenCL performance on
> AMD V2000 hardware, achieves 92% efficiency on AMD W7900 hardware.
> 
> Testing: Verified with ROCm stack and OpenCL applications in VIRTIO virtualized
> environments.
> - Full OPENCL CTS tests passed on ROCm 5.7.0 in V2000 platform.
> - Near 70% percentage of OPENCL CTS tests passed on ROCm 7.0 W7900 platform.
> - most HIP catch tests passed on ROCm 7.0 W7900 platform.
> - Some AI applications enabled on ROCm 7.0 W7900 platform.
> 
> V4 changes:
>     - Renamed VIRTIO_GPU_CAPSET_HSAKMT to VIRTIO_GPU_CAPSET_ROCM
>     - Remove userptr feature probing cause it can reuse the guest 
>       blob resource code path, reduce patch count from 6 to 5
>     - Updated corresponding commit messages
>     - Consolidated userptr feature detection in final patch
>     - Update corresponding cover letter content
> 
> V3 changes:
>     - Split into focused patches for easier review
>     - Removed complex interval tree userptr management 
>     - Simplified resource creation without deduplication
>     - Added VIRTGPU_PARAM_RESOURCE_USERPTR for feature detection
>     - Improved UAPI documentation and error handling
>     - Enhanced code quality with proper cleanup paths
>     - Removed MMU notifier dependencies for simplicity
>     - Fixed resource lifecycle management issues
> 
> V2: - Split add HSAKMT context and blob userptr resource to two patches.
>     - Remove MMU notifier related patches, cause use not moveable user space
>       memory with MMU notifier is not a good idea.
>     - Remove HSAKMT context check when create context, let all the context
>       support the userptr feature.
>     - Remove MMU notifier related content in cover letter.
>     - Add more comments  for patch 6 in cover letter.
> 
> Honglei Huang (5):
>   drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
>   virtio-gpu api: add blob userptr resource
>   drm/virtgpu api: add blob userptr resource
>   drm/virtio: implement userptr support for zero-copy memory access
>   drm/virtio: advertise base userptr feature to userspace
> 
>  drivers/gpu/drm/virtio/Makefile          |   3 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  33 ++++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c   |   9 +-
>  drivers/gpu/drm/virtio/virtgpu_object.c  |   6 +
>  drivers/gpu/drm/virtio/virtgpu_userptr.c | 231 +++++++++++++++++++++++
>  include/uapi/drm/virtgpu_drm.h           |   9 +
>  include/uapi/linux/virtio_gpu.h          |   7 +
>  7 files changed, 295 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c
> 

Hi, could you please send rebased patches?

-- 
Best regards,
Dmitry
