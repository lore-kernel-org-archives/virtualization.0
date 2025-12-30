Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669551E49F
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089752; cv=none; b=JN+KWToXGkd/NZ0OeA9Y+Qb1OtM1VdrFKFLrn2UTiJm5Zv7EJbB1he6wxFqdVWRw+yjBoJ/4jD1EmZURCZR9yrCxKo2pZarjvbkJ6ezU4wHN0LYOBgEF+zz9Ql9x1iPOR0U4dMUWVh1J99kHNBcNMCwRnJtAsbM2TOo6KON3PjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089752; c=relaxed/simple;
	bh=LCt+6pV3SVXX+jVlhPofZ+B+PV2iA9I/7Ha5xrB3hCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=St36WZMtz/9pEpuo79Y2iDmEGsM7VnOB6T//K9X5fbLNq4xnCPdqXEbefTbMHin/jg2ssrNKcvdWHVvJZpC1wt+ITr19ip1t0PYFmBbUDaMqw1KzUbMvmICGZHalFeKvUWzyJ4Aqft78Sbd+fi+P/xo4Ws5Kg5J83PY1OCjg4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0yYMVW3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0yYMVW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QPeHJm+twCiufdOXqLeCn+SgUmZXimx3Kj8OMbSgWcg=;
	b=P0yYMVW35jxYgBF3YWX+d5Ks1WvgEpHVbY7hSsHdHk78Zw0WyrCeBBSmS2yyK5oTbRjjF3
	I2ThzC+UAqPDYagw+qh9Y0x6x56cCzUJauXeqWrqndmgRCxf/08HSGzrcABR2iQB8QGVxM
	4lSXGaXGdADw9gUk4PbTfeYlI1of3DM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-XqoPBGxkMwayk-0oiL1j0g-1; Tue, 30 Dec 2025 05:15:47 -0500
X-MC-Unique: XqoPBGxkMwayk-0oiL1j0g-1
X-Mimecast-MFC-AGG-ID: XqoPBGxkMwayk-0oiL1j0g_1767089747
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcf10287so6886325f8f.0
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089747; x=1767694547;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPeHJm+twCiufdOXqLeCn+SgUmZXimx3Kj8OMbSgWcg=;
        b=tM0LQw2q5ImXux4bo1sM3VGt9MRQ7RXzkjmwy/iZZ3K67c0x6MkfR5XNHL2Jk4vfNG
         sJI6Mazytjp2EFzn7P7uXbrgvrC/Zi+luqChHPuWQbiqN+5+2nNFoIEu18X0CR1SOsgY
         n+vUcEQbuzjrgNunnwvrebrEVIGa13DPSRmpLZsAVFb97KsaWHEOOl0zp3cYoEHa+s1V
         Pfgluh2hhmpHtgdFtdyLHMdygB/6G8OEkmlrRznuJVChwxJUi3EHeQKzOURaX/y/12nO
         tU+gjXhMZpiSAIUGYVzFOhHEwEm4vsCaui5Ts3WO4Pd2KXWXR2SF/AE1uOUn8al9JJyk
         IPvg==
X-Forwarded-Encrypted: i=1; AJvYcCU1MJfzpnenNgEnNR8MDhQQ+a1GETzDFEbaOBRyCvum9/OergjX1idULcCPPOqAP8b/wUB/GkcxHnFbqjfGFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFeuoofhRH/PO9X+lZNbBLR8Hp82BR9IlFXSizt4voFDTAsS1u
	E0WGrY5C3KYFO0tLHmR4ws4CwQcsCKGPNOpX+kMSNAJPwlm3Oslj8wu7kZHRSRlUlbh2nssuhX+
	4KQ6QcdZEBLOrWnbCSaPxyGc2Wwu5z0w4Z1ZlxGCIaL2zZHIV7xN2e0rshHv3+qF8/0bc
X-Gm-Gg: AY/fxX41Jr6AFmgyMk6hvEhde9LIjcEgwbDy2P9ZhfT7eUiS3CaAh5gimzzCMCn51jE
	1RNnvUr6JqFlMuREUg5cCgNB0lBa5G+XS4nbw6BQneoRAQICZffUKmfBJY/NtWaSFJXNimmxyla
	vAyNjfY11ylTAXONy/V1fqgohg+dgkKA/jhE3uBot9lY3+bLFAhVRZbU7o9uoxwp5+2Gt57OFnZ
	b4N/h4LV9xgeHI10vdDGzHaOqQFENH5+5igPb3K9BshsjEX/TGqK+1+xQ0J9yC/EhJYIAxekPhF
	2U42OdN9BI4mpi314nugjq8q1UX9jA8fGW42AkWhEOTM6gAEEUQvtiK8n4j5OISN1nGFzcKFnDb
	nLxMTGX6zVLHdivVKUeKuobldmuUk3JewoA==
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30005595f8f.8.1767089746597;
        Tue, 30 Dec 2025 02:15:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbvOFHJ91a0TKLxq+k7tMABBS8U1GQCYZPCELRU5Zsc1Gaj+GYCwYcD6RmChYOtX8+5x3fqQ==
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30005566f8f.8.1767089746108;
        Tue, 30 Dec 2025 02:15:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm67681523f8f.0.2025.12.30.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:45 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 00/13] fix DMA aligment issues around virtio
Message-ID: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n6pokU3VHetKr2tLBKjvQ-hOqYZtdGS2DNB8USohpIk_1767089747
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Cong Wang reported dma debug warnings with virtio-vsock
and proposed a patch, see:

https://lore.kernel.org/all/20251228015451.1253271-1-xiyou.wangcong@gmail.com/

however, the issue is more widespread.
This is an attempt to fix it systematically.
Note: i2c and gio might also be affected, I am still looking
into it. Help from maintainers welcome.

Early RFC, compile tested only. Sending for early feedback/flames.
Cursor/claude used liberally mostly for refactoring, and english.

DMA maintainers, could you please confirm the DMA core changes
are ok with you?

Thanks!


Michael S. Tsirkin (13):
  dma-mapping: add __dma_from_device_align_begin/end
  docs: dma-api: document __dma_align_begin/end
  dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
  docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
  dma-debug: track cache clean flag in entries
  virtio: add virtqueue_add_inbuf_cache_clean API
  vsock/virtio: fix DMA alignment for event_list
  vsock/virtio: use virtqueue_add_inbuf_cache_clean for events
  virtio_input: fix DMA alignment for evts
  virtio_scsi: fix DMA cacheline issues for events
  virtio-rng: fix DMA alignment for data buffer
  virtio_input: use virtqueue_add_inbuf_cache_clean for events
  vsock/virtio: reorder fields to reduce struct padding

 Documentation/core-api/dma-api-howto.rst  | 42 +++++++++++++
 Documentation/core-api/dma-attributes.rst |  9 +++
 drivers/char/hw_random/virtio-rng.c       |  2 +
 drivers/scsi/virtio_scsi.c                | 18 ++++--
 drivers/virtio/virtio_input.c             |  5 +-
 drivers/virtio/virtio_ring.c              | 72 +++++++++++++++++------
 include/linux/dma-mapping.h               | 17 ++++++
 include/linux/virtio.h                    |  5 ++
 kernel/dma/debug.c                        | 26 ++++++--
 net/vmw_vsock/virtio_transport.c          |  8 ++-
 10 files changed, 172 insertions(+), 32 deletions(-)

-- 
MST

