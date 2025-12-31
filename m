Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F27321F5F
	for <virtualization@lists.linux.dev>; Wed, 31 Dec 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767186756; cv=none; b=ONTJGGog7YiyefvHhSzmCFOBA6ynoEdp0tN7oAxdMwfP+4NtsYu7mXSllQt1Ga/ZvDo/GUD686SjeryoRdAo8dN3b+NI7UA+2PGABfHsyM1izpyOLjROW0xmFVSHtgRTwzqaAqJzRciGfOT6JgXNKNF5ZjWs6pDbdBFNmEtWo3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767186756; c=relaxed/simple;
	bh=+Rj9uS/xKO+b+rZgqDTkOPQ7AM9H+O0zY3sW6JnGIaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUJ657lZ7AV2UjjbdmZDQjqTMvMelCaVEq4yGJd/rWNDb5seuYq1v7xhmmVzeXYJP2QRJxqEwUfefUK7rp++q0rvgg88DH01sw0dZ2ghafZR5bXw3O3emtcO3VxXWIa3sIys070E7yT0ebSw/i7NePEIPZmY42TgBnRmkl8mEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FKUB60X/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FKUB60X/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d4105c275so6230665e9.3
        for <virtualization@lists.linux.dev>; Wed, 31 Dec 2025 05:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767186751; x=1767791551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fke3G5rSH2WPZ2DuQdyfqEfEpoI6l76uJNtI0EpEhAo=;
        b=FKUB60X/lQ5q7IscW8L1AEnZefkgf8Gsb63cXXL31AQxTtQW07QhM1RGYGjvkjgSed
         rSyaWdAK7hvRz6UP1qS6bTF3ZNRfP3sCMg3r7Ayzn3seJXeOVizX6B/OscJDCRvIT14x
         R+Tto78m8s62dFybv/8ohhqWmqgDarj8P98Ex9HfGwAJoHprMeRHwBJfsfVOzHUcYUx7
         +wyEXkoG6xf0wfL/NGXXOa2CI0QZH4Zbt4SDOd5Ds/0XQG/zRtH/mgjqLWIt/j3WPl+r
         dY/SZF8Us4M102oJggU3qVzLVNG1qpm11RDb7BlPJpUU9gkAvu+8YJAUKSfaOtz3/Yne
         LiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767186751; x=1767791551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fke3G5rSH2WPZ2DuQdyfqEfEpoI6l76uJNtI0EpEhAo=;
        b=UvFALacc46blWDGbHWihZGQQ5WfliRL0w6FA7NcsOfqkZCCFQ382V0maA8AYF/+csp
         Gd1dDd+6wIlNE2DP7V4RH/m4rLAqpvQrp++zo/889jqRD7mN3yWA47TekKk6SirEVYjt
         zMFOfaHDCnAH0KsjdNqCYaSfovcAczbAsTbllQNNaX8bSLigJ7iyhx8qMemn8fI3wl8d
         9M0w/Opu+7wFCwoHv7RY+ezKvSvO43UdirguFUM60lBq/Zgfhl+nyNFprOacfHFTa3BY
         5SJPSQfCbosxr2bzUqmzfWE83wtLdCUfLWICbj3QIVRqoJYIv1aDkS3vpTsP+gf4RxRL
         g6kw==
X-Forwarded-Encrypted: i=1; AJvYcCV3lzPEy26lpTH09P4I5t+HBCLXEf4m+3Gv9ePA4B7tVnIRMB3AXlTtPKLU/NjL0h6bh6DsQbvVzEiF4Anmgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzysyiInz6hwRD73KJ0B7RPwtD8Q0YSD+hQyRy7qY6mAgbZJvko
	wH6hQSFd3OWfRddNKVM3V2eHypotcyOmHryeJCzzcOV72bVczp0As8k3UpFA3dvymP0=
X-Gm-Gg: AY/fxX5xLRP7PZvCLyitJQhOrv3sahYnI3AoIBOYb8euHOuZsMj09RglGg1X+4ykrKS
	qSBALia/fLCtKWKLuqeYeQBIxt9VDwx2VxKRM6XYSYCjaxjStC0DcTgLbhBwAiZcl3rocIjNeSH
	N3tWfxMQ239mse7/cuHVKiF63kOJgMNbasepAvodn8eHdLktIqbuEZEEHslEghHYaMvj+AkYMBG
	jeYCfQR98VydRr6IwDJlsVuGh5fxMrayApUEsxKBVRfJdC4CYYqWoHnPqZK+SQNoBUIwtWnmJHt
	R9ZIlR1sx1wFZkVk1GK23qUFDid1yHniQKFUteW+Pn0HAD6uFLlCvJsVfc8zVA7nrdT/Aqu66Hx
	gw0g06D3nDYj6ulf7WH+u5YY2mbO36Onwik4VnP+1NPFq1CxlnQhrCaiZjeAslLzjeuLqOQ3y2H
	HbiIKZKOv11Iv/U+FNcVaS7v1C+ABFDONmnwWoM4fZF+sfbDMvyGJHgVY3gLLTKHTWvvOmMY/NJ
	5sZ
X-Google-Smtp-Source: AGHT+IF4mp6GOV5G6x95wPZOhGbqasawR+ZO3M57T/TzQMfUeMdF8kArZ+ePMOUwA5I3JuKmTuDssg==
X-Received: by 2002:a05:600c:3e0b:b0:477:9c73:268a with SMTP id 5b1f17b1804b1-47d195b3d55mr287631655e9.6.1767186751342;
        Wed, 31 Dec 2025 05:12:31 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a20af0sm269524875e9.4.2025.12.31.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 05:12:30 -0800 (PST)
Date: Wed, 31 Dec 2025 14:12:24 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 00/13] fix DMA aligment issues around virtio
Message-ID: <20251231141224.56d4ce56@mordecai>
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 05:15:42 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Cong Wang reported dma debug warnings with virtio-vsock
> and proposed a patch, see:
> 
> https://lore.kernel.org/all/20251228015451.1253271-1-xiyou.wangcong@gmail.com/
> 
> however, the issue is more widespread.
> This is an attempt to fix it systematically.
> Note: i2c and gio might also be affected, I am still looking
> into it. Help from maintainers welcome.
> 
> Early RFC, compile tested only. Sending for early feedback/flames.
> Cursor/claude used liberally mostly for refactoring, and english.
> 
> DMA maintainers, could you please confirm the DMA core changes
> are ok with you?

Before anyone else runs into the same issue as I did: This patch series
does not apply cleanly unless you first apply commit b148e85c918a
("virtio_ring: switch to use vring_virtqueue for virtqueue_add
variants") from the mst/vhost/vhost branch.

But if you go to the trouble of adding the mst/vhost remote, then the
above-mentioned branch also contains this patch series, and it's
probably the best place to find the patched code...

Now, let me set out for review.

Petr T

> Thanks!
> 
> 
> Michael S. Tsirkin (13):
>   dma-mapping: add __dma_from_device_align_begin/end
>   docs: dma-api: document __dma_align_begin/end
>   dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
>   docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
>   dma-debug: track cache clean flag in entries
>   virtio: add virtqueue_add_inbuf_cache_clean API
>   vsock/virtio: fix DMA alignment for event_list
>   vsock/virtio: use virtqueue_add_inbuf_cache_clean for events
>   virtio_input: fix DMA alignment for evts
>   virtio_scsi: fix DMA cacheline issues for events
>   virtio-rng: fix DMA alignment for data buffer
>   virtio_input: use virtqueue_add_inbuf_cache_clean for events
>   vsock/virtio: reorder fields to reduce struct padding
> 
>  Documentation/core-api/dma-api-howto.rst  | 42 +++++++++++++
>  Documentation/core-api/dma-attributes.rst |  9 +++
>  drivers/char/hw_random/virtio-rng.c       |  2 +
>  drivers/scsi/virtio_scsi.c                | 18 ++++--
>  drivers/virtio/virtio_input.c             |  5 +-
>  drivers/virtio/virtio_ring.c              | 72 +++++++++++++++++------
>  include/linux/dma-mapping.h               | 17 ++++++
>  include/linux/virtio.h                    |  5 ++
>  kernel/dma/debug.c                        | 26 ++++++--
>  net/vmw_vsock/virtio_transport.c          |  8 ++-
>  10 files changed, 172 insertions(+), 32 deletions(-)
> 

