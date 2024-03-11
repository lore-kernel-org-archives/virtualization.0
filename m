Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597D56B77
	for <virtualization@lists.linux.dev>; Mon, 11 Mar 2024 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193934; cv=none; b=L5Oonvaq5D/jyz0MTQitnG/ldLocFoIOUl6HDw3xTaeSiLsn/ro1mRh4Fwsa22NC7JzC/cvTN8BitgOD1Z3F9LKusk9F3xfyXp6+ODD3M9CA+RchynuEfMW7+1cA+xXSr6YDMlSx/+HIsDhs4niBd/IRXd/TgxThA27hCqbDmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193934; c=relaxed/simple;
	bh=G3PsOHFrYJtHkNhKadH4zMG3Rkf5nMiw+jz9fku5Ijs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qc9foCUS9Emj0F0n1L7GwiuwuA0PnEaDQXNSIxMQEyFWJL4JUl42K+zbDnsW1Y1MHfV53OfAjxrqVlrDEhGefNnawH/brI8AtBy4Ru4r+YeUqXjm5Zsk3EwFYab4ocOItkY7Nghy4MzjG27m/6hwpXcOJE2xoxBBaxkrlxJmGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gTEP+qU+; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gTEP+qU+"
Message-ID: <03fe26b2-1b6b-49c8-ac34-e90c76562114@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710193930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3PsOHFrYJtHkNhKadH4zMG3Rkf5nMiw+jz9fku5Ijs=;
	b=gTEP+qU+CrDNEe+UqbIGyHEDITEIH6ZCbnXqkhAaC/NEp/42LkFaVLwHPSvhKmRFh4EXoK
	7wAIXQFNQ8YGzxV+NiKnK3uIzUx+SctMmQPXRsxBs27pV4tQA3PPx+ydlh7ZPc6jVOlLSV
	NKQQ0EZZCwY6ASqyrph/T80T22GVoQ4=
Date: Tue, 12 Mar 2024 05:51:42 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [09/13] drm/gem: Acquire reservation lock in
 drm_gem_{pin/unpin}()
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 christian.koenig@amd.com, sumit.semwal@linaro.org,
 dmitry.osipenko@collabora.com, robdclark@gmail.com,
 quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org, sean@poorly.run,
 marijn.suijten@somainline.org, kherbst@redhat.com, lyude@redhat.com,
 dakr@redhat.com, airlied@redhat.com, kraxel@redhat.com,
 alexander.deucher@amd.com, Xinhui.Pan@amd.com, zack.rusin@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20240227113853.8464-10-tzimmermann@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240227113853.8464-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/2/27 18:14, Thomas Zimmermann wrote:
> Acquire the buffer object's reservation lock in drm_gem_pin() and
> remove locking the drivers' GEM callbacks where necessary. Same for
> unpin().
>
> DRM drivers and memory managers modified by this patch will now have
> correct dma-buf locking semantics: the caller is responsible for
> holding the reservation lock when calling the pin or unpin callback.
>
> DRM drivers and memory managers that are not modified will now be
> protected against concurent invocation of their pin and unpin callbacks.

'concurent' -> 'concurrent'

> PRIME does not implement struct dma_buf_ops.pin, which requires
> the caller to hold the reservation lock. It does implement struct
> dma_buf_ops.attach, which requires to callee to acquire the
> reservation lock.

which requires 'the' callee to acquire the reservation lock.


> The PRIME code uses drm_gem_pin(), so locks
> are now taken as specified. Same for unpin and detach.
>
> The patch harmonizes GEM pin and unpin to have non-interruptible
> reservation locking across all drivers, as is already the case for
> vmap and vunmap. This affects gem-shmem, gem-vram, loongson, qxl and
> radeon.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>


Tested with drm/loongson, play with a few days.
Switch to virtual terminal, then switch back is fine.
not found problems yet. So,

Tested-by: Sui Jingfeng <sui.jingfeng@linux.dev>

