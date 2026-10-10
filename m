Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CC2E7622
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791662723; cv=pass; b=ZeZ0/+BNvLe4Y/ibye/mhZs0kow2e0VpevDZYiRd6plNWpm7QeUseUr+maXvw06P1EE5ZvS/D7ZlCIg+AuxI28wPsMBFR8bGwZy7Rl1mS1j5YJ6ULGW6Kl2PMk29bqg4TJE8gMw5Qn+7qSHLbpEdhW22LmHpx3KPDU6lXqUQJ+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791662723; c=relaxed/simple;
	bh=ks60+6qU+UK7gaXO6jw0WhVNUVXMz5wDLFxByNVuv9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FU2X3DNmbxQUMEVRC5XA9AfRX0hHdR7WHT8ZgIUiu2n36yh7GYaDtPj0IcNpuJCkcTeF+0Txd7KfB45kdVYgMXbQQp3WcpacqDl2YD+dcDfO9mEVWQL9XXJ6Wvm4Jl1fBeYaUWkfKVwYlbIhZh0lbFTUzrxZJAYdEN+0bmCg0OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=VffhjRea; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="VffhjRea"
ARC-Seal: i=1; a=rsa-sha256; t=1791662715; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y3EIQJhUWX0V9ut354Rom+PlvEyE7yN2/uNsW2QK+zD6OWZs8Q2af27/sXABVdap+26U7LeKRIYLdgIM3CWOEwmXb406j4vihYtHG/Ng/Qixo6Fg5UKjx8Tpmq95/WRasOQN/bFm8z4eQpbe/vJdhmDprYnwLeZTDwc3m9fUuQo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791662715; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=86nH4rDPCAqx0bxA8LuKagPLnUL7JcTSpGdqaI2PTR0=; 
	b=aVkszdlXQfgQFcSKLeNRqa+zJzxm/N2Wk5NboogKvqR5Cj7Ieiq4cge43EDdoha4JJUnNxkzb6mf6F4VlUh4f6FKjODSAv8CFvf8DrTE7JLYnheTqhKm+U3hk8APH3HvPz4t7V+pXMbVVxFwMUU7i4eRh9/7ftQrslAmDDgiDuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791662715;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=86nH4rDPCAqx0bxA8LuKagPLnUL7JcTSpGdqaI2PTR0=;
	b=VffhjReaT5Y2JjqiyZnkGofHg5YS3ki8unGDYRb8rytUdxTjgZBcsXQboBySqZG2
	xwf7ia/7gjw4/LIeV31ICdv3OmPNNb1TkP4CryNAnlclsC+ucg3JoNI4ZbM4UxQjCKB
	amnvGrFhUqZH1+aD4ajCD1snxBWWWPOdrGckLGVU=
Received: by smtp.zohomail.com with SMTPS id 1791662713047795.6206079359732;
	Sat, 10 Oct 2026 13:05:13 -0700 (PDT)
Message-ID: <3b853922-1d29-4d50-a3c3-64db18963ed5@collabora.com>
Date: Sat, 10 Oct 2026 23:05:07 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/virtio: share one vbuf cache across all devices
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
References: <20261010150429.17036-1-ngocthang2710.1999@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261010150429.17036-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/10/26 18:04, Nguyen Ngoc Thang wrote:
> virtio_gpu_alloc_vbufs() creates a kmem_cache with the fixed name
> "virtio-gpu-vbufs" for every virtio-gpu device and destroys it from
> virtio_gpu_release(), which only runs once the last drm_device
> reference is dropped.
> 
> Two live virtio-gpu devices are enough to hit this: the second
> kmem_cache_create() call finds the name already taken and
> kmem_cache_sanity_check() WARNs. This reproduces at plain boot with
> two "-device virtio-gpu-pci" on the QEMU command line, no sysfs
> remove/rescan or held-open fd needed.
> 
>   kmem_cache of name 'virtio-gpu-vbufs' already exists
>   WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
>   Call Trace:
>    virtio_gpu_alloc_vbufs
>    virtio_gpu_init
>    virtio_gpu_probe
>    ...
> 
> syzbot found the same WARNing through a different path: open an
> fbdev node, then remove and rescan its PCI device over sysfs. The
> drm_device reference the open fd holds delays virtio_gpu_release(),
> so the old cache is still around when the rescan probes the device
> again and calls virtio_gpu_alloc_vbufs() a second time.
> 
> Either way kmem_cache_create() still returns a valid (merged) cache,
> so the device keeps working; the WARN is not a probe failure. But it
> is a real defect: as the comment next to the check says, a duplicate
> name "confuses slabtop, et al", and it is exactly what syzbot and
> any panic_on_warn setup treat as a crash.
> 
> The vbuf size is the same for every device, so create the cache once
> at module init and destroy it at module exit instead of per device.
> 
> Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> No Fixes: tag. I could not pin down which commit introduced the
> dedicated per-device cache (dc5698e80cf7, the original driver commit,
> still used a plain kzalloc() pool); happy to add the right one if
> someone can point to it.
> 
> v3: back to one cache shared at module scope (Dmitry), not kzalloc()/
>     kfree() (v2) -- kmem_cache keeps the allocation off the general
>     kmalloc slabs for this latency-sensitive path. Commit message
>     corrected: the duplicate-name WARN does not fail the probe (the
>     cache still gets created, merged with the existing one), and the
>     trigger is any two live virtio-gpu devices, not just the syzbot

I booted QEMU with two virtio-gpu devs, each created own kmem_cache and
there is no warning.

-- 
Best regards,
Dmitry
