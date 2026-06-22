Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C003AEB32;
	Mon, 22 Jun 2026 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138597; cv=none; b=ZkaRI5S8FaSbs/XgoD2guC0x+eia36E6tN1wlo+JYXbAO4+iXw5+0LWkoLyLoYpP14XZC8vUVdPndVuj2263ajISTJ34THdxMmSeVezChsOCfNG1runG/D14zTQh1XF+HFLRoLf9h/gTfX9TlPMhKb5nlfhwuMmrKLl2RrHQ49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138597; c=relaxed/simple;
	bh=2FAUR5H/eA1BJeYRJ0dOeeRSuekHwVwbyrJqDLSICXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNse7JX9Ss1ikL28clIxsu5ik8V8BMpgFp2jfhUWMlLnrXgeCvzzCqU9k6soblNZCDCpklZWhrsY+59E3PRXlOvAPVsT/tfe3RLgzgxAXaNkEdw8mz/Cox1+juS8KvSYyrqBAKCbOKxRZ8Bv0BVq4tJuU9kmYZt7pvsVUdS7C3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQhDBQcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQhDBQcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759B11F000E9;
	Mon, 22 Jun 2026 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138596;
	bh=eqSkhNQ+NgLJ4tVlOFvrjOTsyPPZ107xn3Q7uyoJPB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NQhDBQcrFjkByujeOizLiWMyqOVL/pSjhgwKVob95E1Vxfe3vOzzTthOJkcAutfx3
	 aI+bC0fh+yxFDqaD62W3ktBLUX5FiiiU5HgEE+RtngDBpMifyZ/K3n34hyF/WW4QXk
	 A4zyAZns8ls/ZZ2/7AS96Ce59tbUm870UlRJ62w7fYo22koX6kgpql21DuIi33TzCu
	 FnkcUMzbJCjXqgd5jFYKFgq2OYOKWo/Kl1f/wAF1kXHfjUXZb39AzWmSajMaT3QSBz
	 P6ZJvuHjyQw6nsWfmsCgX3lDMj02xnI9ok3xQAKouDywQBMMcp4zNYBMWXAN8xSuCe
	 Y9WJd5XL3c0XA==
Message-ID: <de197e27-e56e-48e1-ac2d-e76ba0c3e6b2@kernel.org>
Date: Mon, 22 Jun 2026 16:29:54 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio_balloon: quiesce balloon work on device
 shutdown
To: "Denis V. Lunev" <den@openvz.org>, mst@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260622133715.3707707-1-den@openvz.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260622133715.3707707-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 15:37, Denis V. Lunev wrote:
> Since commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
> device_shutdown()") the virtio bus breaks and resets every virtio device
> during device_shutdown(), i.e. on reboot and kexec. virtio_balloon has no
> .shutdown of its own, so that generic path runs while the balloon's
> asynchronous work is still armed: the free page reporting worker, the
> inflate/deflate and stats workers, the OOM notifier and the free page
> shrinker.
> 
> Once the device has been broken, virtqueue_add_inbuf() in
> virtballoon_free_page_report() returns -EIO and trips its WARN_ON_ONCE().
> On a kernel booted with panic_on_warn that turns an ordinary reboot into a
> fatal panic in the middle of device_shutdown(), so the machine never
> reaches the new kernel. The inflate/deflate and OOM paths do not warn but
> are no better off: they call wait_event(vb->acked, ...) and would block
> forever on a queue that can no longer complete.
> 
> This was hit in the field as an intermittent failure of a virtualization
> cluster upgrade: guest storage nodes were rebooted via kexec into the new
> kernel, and the ones whose free page reporting happened to run during
> device_shutdown() panicked (the guests run with panic_on_warn) and never
> came back, stalling the rolling upgrade. The crash dump showed the WARN at
> virtio_balloon.c:216 in a page_reporting kworker, with all the balloon
> virtqueues already broken.
> 
> Patch 1 factors the teardown out of virtballoon_remove() into a
> virtballoon_quiesce() helper (no functional change). Patch 2 adds a
> virtio_balloon .shutdown handler that quiesces via that helper while the
> device is still alive, then breaks and resets it the way the generic
> virtio_dev_shutdown() would.
> 
> Relaxing the single WARN_ON_ONCE() instead was considered and rejected: it
> would silence the panic but leave the inflate/deflate and OOM paths
> hanging on the broken device. The device has to be quiesced, not just kept
> quiet.

Do you have a link to that discussion you could add?


-- 
Cheers,

David
