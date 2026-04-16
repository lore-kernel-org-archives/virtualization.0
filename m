Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74230C62D;
	Thu, 16 Apr 2026 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376820; cv=none; b=ZnDIkWQB/7WTX23+BOXe+QLkIsNW/0Z0DBdVqqj1Z0yuCHC43Qim0GpfXgJHx1SyqLXGWFVOjA0jrt9AbqiIfcS3ZUxC2ZHn+lsNpUYWAt23CUeBy6/WEExrymzoIQ93Y9+DGMCEhSCmZISJa9jEHBWEw7L+nsPAibMtytKHIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376820; c=relaxed/simple;
	bh=Zp6chEtxownhwoUKCBThrAtydlX0SCmGdgtvm0fwe20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOg7IDBmGsCAROub9/XDBiQPp6qjlEhQ+Ubk2DyHDg5hG14poyYtdkobRVYYnEgrF/hBqVQNcX5uznFgb83SgTAbPtCWyXM3IjvDnATCjwXH3A9vWT/eAkkiutLZF869TYBRmQaCWpPFzc8+gRnp4w2CCTd1/4x1NpNxZSueCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=32b2pTRd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="32b2pTRd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/5Ll6RZjkyPiImK0NVHYUTe3B1+/sjVfboYdnI1PtJ4=; b=32b2pTRd/nP/QKmbckI1id7E7t
	8zqLL129D0CPN1RWa1n1UvpMgsWesILzMtqr/qZ5c4jo79QyVMFPImmdTaUK+bqHavU6YSQXrSbwW
	8yT6T5aCMw/PZzdELYXn9K6rJqGexKalY7HFXftoeyOD47+/dIkG6D2wnmib9i3VKY5fYWmRbwIne
	8So9LEhEfWfErZSdFm7cMaWk/F0mtiqN65bAU/UFV/mix4kmombA7dhiDtpXvmIN5php9p0mUm0dL
	M9vX+gYVWDd5wDqBLHLFAhBVbFmZAGXtmaesQrWuvJ82o+yLEyEZQR74rsuspG1hVlENpxnD7uqAE
	27tCm/Qw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUkz-000000037Ls-37mZ;
	Thu, 16 Apr 2026 22:00:17 +0000
Message-ID: <75a01b73-f46a-47fd-91bb-4ce9d5c30866@infradead.org>
Date: Thu, 16 Apr 2026 15:00:17 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: virtio: drop an extaneous kernel-doc comment
To: linux-sound@vger.kernel.org
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20260216055956.2784399-1-rdunlap@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260216055956.2784399-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ping.

On 2/15/26 9:59 PM, Randy Dunlap wrote:
> Drop a kernel-doc struct comment since the struct member was removed.
> This eliminates a kernel-doc warning when make W=1 is used.
> 
> virtio_pcm.h:65: warning: Excess struct member 'msg_last_enqueued'
>  description in 'virtio_pcm_substream'
> 
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtualization@lists.linux.dev
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: linux-sound@vger.kernel.org
> 
>  sound/virtio/virtio_pcm.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-next-20251210.orig/sound/virtio/virtio_pcm.h
> +++ linux-next-20251210/sound/virtio/virtio_pcm.h
> @@ -37,7 +37,6 @@ struct virtio_pcm_msg;
>   *             the device side at resume.
>   * @msgs: Allocated I/O messages.
>   * @nmsgs: Number of allocated I/O messages.
> - * @msg_last_enqueued: Index of the last I/O message added to the virtqueue.
>   * @msg_count: Number of pending I/O messages in the virtqueue.
>   * @msg_empty: Notify when msg_count is zero.
>   */

-- 
~Randy

