Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691CD48424D
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075324; cv=none; b=Nsog4UlfkM0ZMj7jUYwMJxQzAgOkfxwlPs9axnIz1VxQAdqeCl+SU3hLOZY7EuJDRhTQp4RC+4B6Qw70URZNeHPSJEFNW2BnAVoPYXw7Oqw95jo5YihSOAzE+sUUQoL5e4lkBwfCsBz4VFbtyVNDUApVYwK9/9/iYB3hwx8Xld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075324; c=relaxed/simple;
	bh=AQMdFN7bk5Vi64trWrWw3isTNps9BgI9KO/GKD/+ywk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLvxP2v+eCgIkQ2NrKJKPm1K9h+kx3unExVBqyiqZVS9PFgWp/7ubbCW3mC9b/IsaErUVOZrnL5Qhfa936XL6HBCvBqAWfbQmwISX2yNvM7H0AJNH91ZcoDC6BoJOSkUqTBg3HaMFvlPGEs9JWeXztZqXcV8jeCtQWlKEAYUUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edera.io; spf=pass smtp.mailfrom=edera.dev; dkim=pass (2048-bit key) header.d=edera.io header.i=@edera.io header.b=oFe7Gqi4; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edera.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edera.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edera.io header.i=@edera.io header.b="oFe7Gqi4"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8eeb4508f29so1568946d6.0
        for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edera.io; s=google; t=1787075321; x=1787680121; darn=lists.linux.dev;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sZfKlpmmAGMPY0pYQ5qB8sNVCzbuLBNICRyvhJ/UKoY=;
        b=oFe7Gqi4p1eLSjECJDSmmj7aTkopXnSX9gHYWMgQ1RYQHvGUv3nkSmd1Tzm8JGkZZ9
         26GE+5Q9E5WtgoWPKfwZpSdpyY9eGVV9PUeiw1VU7f+UVlHnM2A9GPdGmiYQCQ8ORb7f
         02wJ2tFL52hJ/MuRFZuS2ySLE/6IyVvfN4ZHJqeujYO/52asXY5Cfm3LkJ+Kleyc8IaQ
         kAgzjRACIeix99csIbU4Y0+G8o2Dcil3PH85NQ/M3XTbcTDbBTCf4OCWud59jCYygKNP
         ay8ymV9ntUUj0OHbBnRObgw/3wR+2OhbADSzXwvwjFpnSd/usnxRfJcmZ6biwlzRzV4y
         yCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787075321; x=1787680121;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sZfKlpmmAGMPY0pYQ5qB8sNVCzbuLBNICRyvhJ/UKoY=;
        b=VBwLspZRJrezkz8Ruee+eabI5wVmZHw1nRFYdZyE7d6CywZK/ivZxD+1XOOKkUO1oH
         x23ip3rIwRxxkbGvmBK927IkjtHOX/le+n9DltuBqkzNngAexv0TWmLLW332z+wvw7Cn
         Dm1d1pTNVLyHcGrOTU6QdCrWeC20tlrN9YJaK15bWx8S3Rq8TerMRCx01idQVjs+yFX3
         bsyQDLhd85UQ8MV80DFsXyHFvh3XUjj72dPanwGT3wDNxapURtNm8xr44ZzJOsKJJyZQ
         vlpS6xt6X3Rx16v481RBaT9//Xeww9bIjwmDn2Wimg2itRNTsDvPEwLXGo56lVty59Gg
         Y3sA==
X-Forwarded-Encrypted: i=1; AHgh+Rrz4u6oNqgztaKLutpdQnv22YEkyLgBWptkvQIrlnyvpowfehgn69yPFlYDVeh7H0oCT3r+TOnDRBixl1jKYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqKo2JJ8JEZxM8XuW28Gfoh17HkLOK/bSouQGXw3fIzLNr/B9y
	1tLDRunXzlHEUQr07f4BQQQ4QmGpxDAm33K5QUitVnkGanGHWSDavVrMbjqtctCWXuY=
X-Gm-Gg: AR+sD13gRSQE3eyVN2SvACnATNJMNKpgISfKJZG6h2wIG/9Y94b0QXODlIwaDk7SD82
	ddYsYw1GGx140XOwEdj0KO78T/qci3vep6B+n+d26BiVgCnISAl2ZuLAdu2D2w2b/6uuaEdn+m0
	M5bogeztXery9IY03STmUAl7scIpPZPNli+yIc1PTOCD5LfNSxKW+xfsuOshBtBMPcXLJo9rq5y
	mv4YQGrFJfURWGOqBwFnUmckmxkWftY8rckjhCLYMuiD706rCSqFWRTOrXEjvesWZINNUWGlhtj
	m4BYRhxnLn4s75mta9ofYkI4H2qPSeIoQ1wZ42CnYFfmvYvnzGljWLzDeda1ZYPbS0XSovQNBmO
	bid0S9DXO6ER03zYkiq4Bza6OAlFxSZTMk4sVXq+Sh+wyhbxWR0SbFiMl/EvAbOx7lNta4ASN4u
	teRVMCRQSpvG5W9w7jfnKL2pEJRRK/HEvclHpHiD6BJfWDcD6iEYv3rW6+VU6kIxtTIrKDRjXlV
	2GH6A+BtC9fietXbCcnjQ+S2SwLOJr2CcNQM9httlN9
X-Received: by 2002:a05:6214:860d:b0:8ec:235c:7a66 with SMTP id 6a1803df08f44-90c5c12de8dmr1581236d6.27.1787075321126;
        Tue, 18 Aug 2026 10:48:41 -0700 (PDT)
Received: from StolidWingnut ([174.80.170.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4597b7desm36800736d6.46.2026.08.18.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 10:48:40 -0700 (PDT)
From: Benjamin Leggett <benjamin@edera.io>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
  Gurchetan Singh <gurchetansingh@chromium.org>,  Chia-I Wu
 <olvaffe@gmail.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  Simona Vetter
 <simona@ffwll.ch>,  dri-devel@lists.freedesktop.org,
  virtualization@lists.linux.dev,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: use the DMA API for resource backing on Xen
In-Reply-To: <657a88d7-e1d4-46ee-9b79-b33144e749dd@collabora.com>
References: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
	<657a88d7-e1d4-46ee-9b79-b33144e749dd@collabora.com>
User-Agent: mu4e 1.12.12; emacs 32.0.50
Date: Tue, 18 Aug 2026 13:48:37 -0400
Message-ID: <875x17tj4a.fsf@edera.io>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 8/7/26 01:54, Benjamin Leggett via B4 Relay wrote:
>> From: Benjamin Leggett <benjamin@edera.io>
>> 
>> On a Xen PV domain page addresses bear no relation to the real machine
>> addresses the host would have to use to reach it.
>> virtio_ring.c handles this correctly, vring_use_map_api() returns true
>> for any xen_domain() regardless of VIRTIO_F_ACCESS_PLATFORM.
>> 
>> virtio-gpu makes the same decision independently, but its copy
>> looks only at the feature bit:
>> 
>> 	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>> 
>> QEMU does not set iommu_platform on virtio-vga by default, so
>> VIRTIO_F_ACCESS_PLATFORM is not negotiated, use_dma_api is false, and
>> virtio_gpu_object_shmem_init() describes the framebuffer's backing pages
>> to the host with sg_phys().  Those are guest-physical addresses. In a PV
>> domain they resolve, on the host side, to pages belonging to some other
>> domain, so the host scans out unrelated memory.
>> 
>> Move the decision into virtio_gpu_use_dma_api() and give it the
>> xen_domain() check, like vring_use_map_api() has. This
>> additionally enables the dma_sync_sgtable_for_device() calls in
>> virtgpu_vq.c, which are required for correctness whenever swiotlb
>> is in play.
>> 
>> Reproduced with a Xen 4.21 PV dom0 nested inside QEMU 8.2 with
>> virtio-vga, on both a distro 6.8 kernel and 6.18 LTS. A PVH dom0
>> works fine and doesn't need this fix because it is identity-mapped,
>> only PV dom0s are affected.
>> 
>> Fixes: a3b815f09bb8 ("drm/virtio: add iommu support.")
>> Signed-off-by: Ben Leggett <benjamin@edera.io>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 20 ++++++++++++++++++++
>>  drivers/gpu/drm/virtio/virtgpu_object.c |  2 +-
>>  drivers/gpu/drm/virtio/virtgpu_vq.c     |  6 +++---
>>  3 files changed, 24 insertions(+), 4 deletions(-)
>
> Feel free to send follow-up patches to fix problems reported by the
> Sashiko bot.
>
> Applied to drm-misc-fixes, thanks!

Thanks, a proposed followup for the Sashiko-bot reported issue
submitted: https://lore.kernel.org/dri-devel/20260814-virtgpu-from-host-sync-v4-1-64dd736b1779@edera.io/
