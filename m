Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F018276051
	for <virtualization@lists.linux.dev>; Fri,  2 Jan 2026 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358019; cv=none; b=sxGBZC6A7XeH9E1QO/9ATX0rExWSKcxyw1VzkSm2pxLdJriILAKd3Ac6lnRWWLrQoD5wOuIeVSksusJP3JE1s9/C0spSye3KmBvN6iA57DiBYBmIAzMkqdgTLlnOpK6UpDTWDgoUnlhWzCdyJ1ksZlJAT32WScO9XLRa2Gj4AL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358019; c=relaxed/simple;
	bh=6KPWXH/kC7jOHkn729my4NVFkh9cBa46BBKTL8WhXtA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQZwkD3kJMiNf4I6Gq1x94fRrZlaOhPZAcXEHVeFd1eIBeHl+2pmGlN6yQHnlO+Wf1FgZsxa4MWOfH17mm19VeIPUXiUA6Wq8oWQCJ4gvcWe/D+QPA0nnpAqDMKumKti1jT9Awya8ShNUQ6zLPpcTr/AXwyclKg60d9HbQALDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo2gvuCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo2gvuCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C78BC116B1
	for <virtualization@lists.linux.dev>; Fri,  2 Jan 2026 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767358019;
	bh=6KPWXH/kC7jOHkn729my4NVFkh9cBa46BBKTL8WhXtA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Mo2gvuCIh6e9sPcCb5IzU03yjkBLo4h6nsdwnp0oP+T+l9dghrrR1r9elGcrPRH9w
	 gmB89BKxlupe8Wkd9eQfUuncMnXpMr+iA0AM0fmN1MMXcKqupmQe6PqaKeETh2fSl+
	 17Am1SBDB0HZleuAUQ1PN8NVPEjTp4ZSlS8bcbMlBrZNMo3p4Du+GNJyYyBY2BPUSj
	 HiZ/owx7Yp5hVVtOP/yP8JJ2iybsfSbX+CVi5O9ChZODri1HQEfP0EO5baJ0+JcYlP
	 /fJ/xmPzdJJV5zPsDUctPujy4I/Vl5I9joe0Kfy2JgZbrz96r+SHAgMDQFZ3ic5iyE
	 SKi3F49JMTCYw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59584301f0cso2903292e87.0
        for <virtualization@lists.linux.dev>; Fri, 02 Jan 2026 04:46:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZd3eCcj6mVDFyA4r4cdCNVZSOD9qTNB9+qMov3kpD8WEedxbni90BmtVMyAh7B+wFDlt2s01LryEFj/OU4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu+b53/0XmXCP0hOpYQvWJjf1F8mpZTX/779s8QUcWrReeb98C
	K37LMEtkRZRNV+TrfkNhZ8xUUMoQyU/1x1Y0Ai6+A6t/KSeHpfgqE5sabGD3+skYAm+9ncqNuKz
	46EG8jPNk+NSVnH3tpBvpftQZWHp1iCQeBRoXUuuHBA==
X-Google-Smtp-Source: AGHT+IGc2inPJAzzOkCkSBFCoOg9QxkQFVWecr7c4xhZfdJchBGS03PyeQgZEMV/dRlvfiPAbf/AJ8Wav/AAUBMesSQ=
X-Received: by 2002:a05:6512:33cc:b0:592:f521:188a with SMTP id
 2adb3069b0e04-59a17d66a60mr12745131e87.49.1767358012955; Fri, 02 Jan 2026
 04:46:52 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 06:46:51 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 06:46:51 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <6f2f2a7a74141fa3ad92e001ee276c01ffe9ae49.1767112757.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1767089672.git.mst@redhat.com> <6f2f2a7a74141fa3ad92e001ee276c01ffe9ae49.1767112757.git.mst@redhat.com>
Date: Fri, 2 Jan 2026 06:46:51 -0600
X-Gmail-Original-Message-ID: <CAMRc=MdaHfsJnbB2hOO6EbVMwZaWqO7zMkv8ZVugHnfOuDn=AA@mail.gmail.com>
X-Gm-Features: AQt7F2oUFrPkMorjc5uJ7mhwaGHd2BKNe3yeZtbMYJ_tunJRlIVF48L1J9wKaic
Message-ID: <CAMRc=MdaHfsJnbB2hOO6EbVMwZaWqO7zMkv8ZVugHnfOuDn=AA@mail.gmail.com>
Subject: Re: [PATCH RFC 14/13] gpio: virtio: fix DMA alignment
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 17:40:28 +0100, "Michael S. Tsirkin" <mst@redhat.com> said:
> The res and ires buffers in struct virtio_gpio_line and struct
> vgpio_irq_line respectively are used for DMA_FROM_DEVICE via virtqueue_add_sgs().
> However, within these structs, even though these elements are tagged
> as ____cacheline_aligned, adjacent struct elements
> can share DMA cachelines on platforms where ARCH_DMA_MINALIGN >
> L1_CACHE_BYTES (e.g., arm64 with 128-byte DMA alignment but 64-byte
> cache lines).
>
> The existing ____cacheline_aligned annotation aligns to L1_CACHE_BYTES
> which is now always sufficient for DMA alignment. For example,
> with L1_CACHE_BYTES = 32 and ARCH_DMA_MINALIGN = 128
>   - irq_lines[0].ires at offset 128
>   - irq_lines[1].type at offset 192
> both in same 128-byte DMA cacheline [128-256)
>
> When the device writes to irq_lines[0].ires and the CPU concurrently
> modifies one of irq_lines[1].type/disabled/masked/queued flags,
> corruption can occur on non-cache-coherent platform.
>
> Fix by using __dma_from_device_aligned_begin/end annotations on the
> DMA buffers. Drop ____cacheline_aligned - it's not required to isolate
> request and response, and keeping them would increase the memory cost.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
