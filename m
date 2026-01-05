Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F9336EF9
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606490; cv=none; b=lf1q33Z1rZKlT9aECBnLf7UXnmEuKuf0T17rKKnl4lQM8wqUQYp113pmJjeTN7/OXHsU7lXfI7iLA5oxblhEOvdKZoro8wci7nXlmud056nRgXCCCS35DzOU+ZijbaF+TrZ644/HVkuiyQverNHV7z7+t82o5UxwQqIw7uuxhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606490; c=relaxed/simple;
	bh=GqAwY0OHbZKQzzJb3VatReAfBA97RCbOF3bWO0/Z1Js=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoKGJXKk2TgZnE/jFJMmJWLkKl1fSHYo7GE6rRjTLFUSTs3AY/0XKGF2E0Sy0Gqn7LxsvDW/9HYqzR1qlSdJXC5fVeUVEIVoSxfJgpWrqquHitsvoWpUefRoLi72/Xx7UGXvobyafc016vemtea1eWA20JHCAelQWWmCPfVmw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PIyyXwcj; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PIyyXwcj"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47d6ac8db1eso2629855e9.3
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 01:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767606485; x=1768211285; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YNJPmUNbnGNTCEfFfuOCZFqj9o9elJ+A8mEb2IK5hU=;
        b=PIyyXwcjn8WhNqSYF4TN8LHGqVx/YTH808wLXMMBTMBF0rh4aUxIuy+4vsPpCjT2VP
         x2UW/s1uI+NO8A04X9ddcwjJpn0Ei0yzQSs8hrsbCRcTYmR59X5YWgzSbr87gjYOD2sL
         aWGq6gW2xy5qQI77xBf+s8CEx0UtpZx1qWxgS7MYvfV6e6HNW+Y3yYPRTSq6spFgQVZw
         c8hXufW8Y9wZeYvTlpqmCsL5A5SR06R5Tgq0Xtqh7oRlu/Rn9Qq6phE/O6x8sO2ungaR
         lcRQgvfANzYReQSMavbd0eyzRMPKbykpB+quQ5yHnMnQaCNNCefS16ViwHY8u+IVVxrh
         K/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606485; x=1768211285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3YNJPmUNbnGNTCEfFfuOCZFqj9o9elJ+A8mEb2IK5hU=;
        b=pgmNUNv5YEfJfRIcTVGvb5CY6HouARrdD9w53rLUY9e5VUwgmdJu4dWIYaad4TlKY0
         1m7ajPPU0HUs39J3KTBkhAWngdOV+bBiio5TlEo+0jIaqdW6ONAYJbQaRDBXucADZDUJ
         tJ+Hx9GTFY0CnlPwpu1oBtFGSqJ1WJTTz98sbEHZMvbfnuij/lR+Uu5UXciy4qqgVSAM
         L41OgRubctv0rjo4GL0suL9uF9nN9xUC5uO7nt2nX8ZfnIBPT7sTAPzZFg8kjo6u4H5A
         Zz0smwSXfMm6muNDhMqLiTH7J4MljfSGvGl/SJxsltioHWtqgern3EOz+GQtpybKWn9+
         e5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUtIiY9cvQfez3gGTXoHbbkq21OfjDP8m2x/JpXdgSUYuo95otNR6lr2p59tUuqodM8E4MraWHM90vEuMGLQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjTW5ZvgRhZfx4uVLvKZpWYa8EcrqhE9VCZLEre47vmXxfLnxu
	hBFYliOu1Rhqd+3bJgoKdhI6v34CllP5hrBdn8Hj7DlCJ+HXwUh2jD5t4mwyjGNHYoc=
X-Gm-Gg: AY/fxX40bbApyvMVCfQrCrEHTdlDgNOlkOm6mHothg8pfEk3dQXlLEq5eP8RzjnhQfH
	TEm8uAwFSWru/RYzYxSO65HWk2wBATvD0Gd2a8eo+m4N6QOuz2eRvhFTa086MW8KPIa7IIke4Mw
	0YBL9s93Oj3rbozzxLdhsajuwyXBoMdHqg9/cvP6xt+TvhM4Jq7ZFRpEzbsxDDh/NpAv7m0/vfl
	vhUy2k9W2zwuoK7orLFtBRFeWZyFvp3NX+jl3WZ+pKto/qsXSJyncQMfdF5o/Qoh/AB5R7h9fIG
	DWPhWhlI0kLFG9BcA0fapD9RVP8ie3lbwz1ld/tAnfm+IGEke1OhFp43BuTQJGHV+TPpRg8F4mT
	vfLc3PJ47wt3Rr4vkJl7n/24AapZgILJ1Y2zyjdcaEstG5z0KOOZY0Efp4ix5cvhjFW+VcnuIm4
	g1udLYS7sCKgpuCGPAOUugXld5FUexVDyszp5LmOzDAcIwfmpJ35OTIFkodlp/8fTUzVWxmX/W2
	Ujc
X-Google-Smtp-Source: AGHT+IHPziOrpKV7Kr9yyjS7tcuC3KfVS3vu6/0u8YX5ecS7isO2cmN7o1CvFXRGO2JgzmojB4/s8Q==
X-Received: by 2002:a5d:548c:0:b0:432:5b81:493 with SMTP id ffacd0b85a97d-4325b810aa7mr24854531f8f.5.1767606485367;
        Mon, 05 Jan 2026 01:48:05 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm99699009f8f.1.2026.01.05.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:48:04 -0800 (PST)
Date: Mon, 5 Jan 2026 10:48:02 +0100
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
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 02/15] docs: dma-api: document
 __dma_from_device_group_begin()/end()
Message-ID: <20260105104802.42bd8fe5@mordecai>
In-Reply-To: <01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
	<01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 03:22:57 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Document the __dma_from_device_group_begin()/end() annotations.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I really like your wording ("CPU does not write"), which rightly refers
to what happens on the bus rather then what may or may not make a
specific CPU architecture initiate a bus write.

I'm not formally a reviewer, but FWIW:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

> ---
>  Documentation/core-api/dma-api-howto.rst | 52 ++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
> index 96fce2a9aa90..e97743ab0f26 100644
> --- a/Documentation/core-api/dma-api-howto.rst
> +++ b/Documentation/core-api/dma-api-howto.rst
> @@ -146,6 +146,58 @@ What about block I/O and networking buffers?  The block I/O and
>  networking subsystems make sure that the buffers they use are valid
>  for you to DMA from/to.
>  
> +__dma_from_device_group_begin/end annotations
> +=============================================
> +
> +As explained previously, when a structure contains a DMA_FROM_DEVICE /
> +DMA_BIDIRECTIONAL buffer (device writes to memory) alongside fields that the
> +CPU writes to, cache line sharing between the DMA buffer and CPU-written fields
> +can cause data corruption on CPUs with DMA-incoherent caches.
> +
> +The ``__dma_from_device_group_begin(GROUP)/__dma_from_device_group_end(GROUP)``
> +macros ensure proper alignment to prevent this::
> +
> +	struct my_device {
> +		spinlock_t lock1;
> +		__dma_from_device_group_begin();
> +		char dma_buffer1[16];
> +		char dma_buffer2[16];
> +		__dma_from_device_group_end();
> +		spinlock_t lock2;
> +	};
> +
> +To isolate a DMA buffer from adjacent fields, use
> +``__dma_from_device_group_begin(GROUP)`` before the first DMA buffer
> +field and ``__dma_from_device_group_end(GROUP)`` after the last DMA
> +buffer field (with the same GROUP name). This protects both the head
> +and tail of the buffer from cache line sharing.
> +
> +The GROUP parameter is an optional identifier that names the DMA buffer group
> +(in case you have several in the same structure)::
> +
> +	struct my_device {
> +		spinlock_t lock1;
> +		__dma_from_device_group_begin(buffer1);
> +		char dma_buffer1[16];
> +		__dma_from_device_group_end(buffer1);
> +		spinlock_t lock2;
> +		__dma_from_device_group_begin(buffer2);
> +		char dma_buffer2[16];
> +		__dma_from_device_group_end(buffer2);
> +	};
> +
> +On cache-coherent platforms these macros expand to zero-length array markers.
> +On non-coherent platforms, they also ensure the minimal DMA alignment, which
> +can be as large as 128 bytes.
> +
> +.. note::
> +
> +        It is allowed (though somewhat fragile) to include extra fields, not
> +        intended for DMA from the device, within the group (in order to pack the
> +        structure tightly) - but only as long as the CPU does not write these
> +        fields while any fields in the group are mapped for DMA_FROM_DEVICE or
> +        DMA_BIDIRECTIONAL.
> +
>  DMA addressing capabilities
>  ===========================
>  

