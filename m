Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7F3B3BE1;
	Mon, 22 Jun 2026 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139138; cv=none; b=Pq8ZrOnKf4hwTZR/hKdXyyYNt7k7OpnEZkD/NdhF04QwkaNcxGICPFzyJr+Ab0IPZ6JSdW0LRTVNa7eMLfMWCMeOG1N89RdFu7+62G4grkVQbA9b3vpfQATtsuB3+4IZXtlY+bkmUlac7KMTfgWD2Wa4yILcqSaQQ9XIFSjFLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139138; c=relaxed/simple;
	bh=OyKSR115bKLYHAyLUX7MNavqBz7tPhevDZSM768E/9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBA0fZPa3y5sa5UHlunK2z+rqnC7gboicTL53c5vIR34neMpfybtnFKuYNPwM+VMc7rVt70pzuP6krnC7Jy2usJVIYbIB57F6sF2hhwmKSkcAFxv+xMvCfgiNWiBJYBA7i7xfAH0i5cpms0YADpvGcjgNf4S1dtIoQRJFr0Xh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si6PYAEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si6PYAEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D63E1F000E9;
	Mon, 22 Jun 2026 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139136;
	bh=aIy5JYqqyN4lYGAvP4PJprQOXNEO2nmNgN+8COp28Ek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Si6PYAEJ2qenlLjzIgr2SUvuMEmogWISUNZ00oYOfxMrvnIjP74b7IA6qaXnIit42
	 NLmQux6I9G4j+E2P3nVkQs6CISG6nYfsGwsYqt8McQT0uEkfyl+46eAJxdq2YxiLGz
	 C7UDOSsdcOLRwkhybsikKsrJcHFYMB79JoloL8LLD90oqrTa62jtB2X3rihbyghah9
	 Cl2o4JnV2F9o7G0NS63R+ypJ82fAJPeD+n/kjwFHRLPUhNp7g7RYJjGanVuThFUPwM
	 9xZWeBP5m1grUkUJI4DN3KG0eWmK586dZx3yLI25zFPOe+tV/4V6rg1gIKCIy/UBEz
	 r0OtwrCz/zQ2g==
Message-ID: <8b83f251-3a3e-4fc9-8ea9-8d101fb92919@kernel.org>
Date: Mon, 22 Jun 2026 16:38:54 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio_balloon: quiesce balloon work before device
 shutdown
To: "Denis V. Lunev" <den@openvz.org>, mst@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260622133715.3707707-1-den@openvz.org>
 <20260622133715.3707707-3-den@openvz.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260622133715.3707707-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 15:37, Denis V. Lunev wrote:
> Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
> device_shutdown()") added a generic virtio bus .shutdown handler that
> breaks and resets every virtio device during device_shutdown(), i.e. on
> reboot and kexec.
> 
> virtio_balloon provides no .shutdown of its own, so that generic path
> runs while the balloon's asynchronous work is still armed. Once the
> device has been broken, virtqueue_add_inbuf() in
> virtballoon_free_page_report() returns -EIO and trips its
> WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
> ordinary reboot, for example a kexec based upgrade, into a fatal panic
> in the middle of device_shutdown(), so the machine never reaches the
> new kernel.
> 
> Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
> inflate/deflate and OOM paths do not warn, they call
> wait_event(vb->acked, ...) and would instead block forever on a broken
> queue that can no longer complete. The device has to be quiesced, not
> just kept quiet.

Ah, so

	/* We should always be able to add one buffer to an empty queue. */
	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);

is not actually correct.

Yeah, quiescing sounds cleaner, although I am thinking whether we should also
warn if virtqueue_add_outbuf() fails, similar to what we do in
virtballoon_free_page_report().

> 
> Add a .shutdown handler that quiesces the balloon via the shared
> virtballoon_quiesce() helper while the device is still alive, and only
> then breaks and resets it. The break and reset are repeated here rather
> than reused from virtio_dev_shutdown(): drv->shutdown replaces the
> generic handler rather than augmenting it, so that drivers such as
> virtio-gpu can opt out of the reset. Unlike virtballoon_remove() the
> balloon workqueue is not destroyed, as shutdown does not free the
> device and cancel_work_sync() together with stop_update already prevent
> any further work from being queued.
> 
> Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  drivers/virtio/virtio_balloon.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5b02d9191ac6..e35ada767b4b 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1137,6 +1137,15 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  	kfree(vb);
>  }
>  
> +static void virtballoon_shutdown(struct virtio_device *vdev)
> +{
> +	virtballoon_quiesce(vdev->priv);
> +
> +	virtio_break_device(vdev);
> +	virtio_synchronize_cbs(vdev);
> +	vdev->config->reset(vdev);

I guess it would be good if we wouldn't have to copy what the default handler
does, but could instead just have it in a reusable core function?

> +}
> +

-- 
Cheers,

David
