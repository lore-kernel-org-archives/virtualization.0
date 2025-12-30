Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B06B2EA171
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089779; cv=none; b=OkgQYKB43Qf5YOZxhx8VNV5txyTe11Xpb3XNJcSARIKZ4WZH5ojQ39km7gNa+0HpFWrPIsKXtbJFtzQDsD3B9IiriGffmjiRMCLRm4iBx2aAzKqVPbggvCgInHe81qUCV29W3QUQZ5TQ9+94eqWmnBg4C5DscOpcdx0C6roMRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089779; c=relaxed/simple;
	bh=1nvGVVfYMss4t3CEcUrrF8Nk2cSppyMGKm3YyiTIiKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D5QVtc5gjc0/1+4oZF/n423zokRW9LtCZcAYy/TP8swT6SFXxu0oOP5jfItow7fuUlywUUmmnZDDqCrDOgpvUprYL3kLZVYIi5nMTmdCBV9jjGS4m7kYEFc05W3pFeyHIS6TO1fHVBWs9OWDqVhQ+C6dAYFwSHIZRdgTAI4E66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6rzMX85; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6rzMX85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N7TdGrHAal4YSCbHD/e5fBMwf7XbmUGP5Z2mh/ui0sA=;
	b=C6rzMX85bgMe0345b4wMBz6JtSUWNcqPV5Dx9iVOEQc/GNpEC5AZtIMmTCI52VdfVJ8z2Q
	Z2pq8YgMfLVI/kJ/CAjkVQUWK/zLtv34sxnQkdDYI2/tLRmfqT9gLxvICnKdOJv+1SJyY+
	EtV1mrUjrr5t1SAL/p9G4Nk0ot4/bc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-gT3hFkabPzGJwy3poTtUcQ-1; Tue, 30 Dec 2025 05:16:12 -0500
X-MC-Unique: gT3hFkabPzGJwy3poTtUcQ-1
X-Mimecast-MFC-AGG-ID: gT3hFkabPzGJwy3poTtUcQ_1767089771
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fdc1fff8so4846587f8f.3
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089771; x=1767694571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7TdGrHAal4YSCbHD/e5fBMwf7XbmUGP5Z2mh/ui0sA=;
        b=YlGZcSKXeXCp1VUYISppO1P6jwLgyfP1zdxH0kj9stClZfohd9gfdAHmegndA8RIJ6
         WKW60CasHE89Q2s40IKlBbdgszCyCz32IGw8ZG8olicrvhLXnDLRv4mAkuFvpDVPC5R/
         pzbeN+mOC9D3GA3w7G+5exUgeSy+HUCBctX7xBLM5Kvg4uvI+XjSDueqndxbGHHBknTL
         21fPuypfmF7oUVORVHppv2AY3ynnPykNAOS1Im381kz/mCokBJjke9vesVnGxOEDQD4t
         P281/SOL3i7ZxkvP+G4QiAdcVHeBoZP0uLOTOrKtNjVTbXEAiKbPORmXoBd3R+mBafNi
         FQeA==
X-Forwarded-Encrypted: i=1; AJvYcCWzULMd83O4qCKWeIIhy0mUojeQsaxD2FbhSj176qOc9cA5QWJWpS0e+E8imT8nUzabmsM+kqHUpzWWjis+Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5EGZgSa25ZrP0y46hQITqPydcf2zEsPpyQoCTvHt2//co+bMg
	ekxq1BwRxp1vDvpD4dzY77CY1JbocggjdZA1fm1DBHCmvgljhF9uA7TUo8emR9WuutlwFzkQm24
	NHezJejxgvv2G6wEsxdpu+/XVQXIT5iUc+Mm4YWnxQ8MqxVonJXHRrUG6t8rszWAxr6/z
X-Gm-Gg: AY/fxX5UI1lFIWemwRLxcZWC6+lVCcscXiEOWxGDgyophURb9yAmZJT53GAZiVGJ+UR
	E+Ag/m2AHG6X3HA7mPr7By7UtVVEJxzBTF44X3NxVuenAr5OZykDJOgoqsO7Abn50Nb1tZuDiQ3
	optRfxcZ9DUU07RzJwdYYtWLQ/cWgZXeHFI1JhILa5GE8eIUyNZaWfq+zvWWI6jedK7hSRj7z8X
	mzLtvwCiNDsFgHhNfS4CcE8lIXlk0PCcHwAwXuHiG6kDsVPgsekH3d5ndAIoJy9nbyivLeGzAhI
	jpJ6b1H7vzZ/6wU4Do9gR2OwHivyF0utcLKSgEb3RYG9mfeFtpjIKX0BXXgK6GjE8l90zo9EDms
	vMFuLlO1H6N0cQF1rNwKjWMz1dAk6MZDXrA==
X-Received: by 2002:a05:600c:45c8:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d195558bemr375729735e9.11.1767089771401;
        Tue, 30 Dec 2025 02:16:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjzVX0GYuttaIVhsj3PIAp1ZJ2Zp++QasW4yFBwV4WaDkrZ/icz8/Y8CMg+xDJDk6ilEld2g==
X-Received: by 2002:a05:600c:45c8:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d195558bemr375729355e9.11.1767089770967;
        Tue, 30 Dec 2025 02:16:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d4e91sm569777955e9.13.2025.12.30.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:09 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:07 -0500
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
Subject: [PATCH RFC 07/13] vsock/virtio: fix DMA alignment for event_list
Message-ID: <c195bc45032be85c3f0bad7362f0ba0a4e8a7726.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -zjn2SPXgUT9Mn0KMwgiEjHc0culfKHwzsTvu0rs8w0_1767089771
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On non-cache-coherent platforms, when a structure contains a buffer
used for DMA alongside fields that the CPU writes to, cacheline sharing
can cause data corruption.

The event_list array is used for DMA_FROM_DEVICE operations via
virtqueue_add_inbuf(). The adjacent event_run and guest_cid fields are
written by the CPU while the buffer is available, so mapped for the
device. If these share cachelines with event_list, CPU writes can
corrupt DMA data.

Add __dma_from_device_aligned_begin/end annotations to ensure event_list
is isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8c867023a2e5..76099f7dc040 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -17,6 +17,7 @@
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_vsock.h>
+#include <linux/dma-mapping.h>
 #include <net/sock.h>
 #include <linux/mutex.h>
 #include <net/af_vsock.h>
@@ -59,8 +60,10 @@ struct virtio_vsock {
 	 */
 	struct mutex event_lock;
 	bool event_run;
+	__dma_from_device_aligned_begin
 	struct virtio_vsock_event event_list[8];
 
+	__dma_from_device_aligned_end
 	u32 guest_cid;
 	bool seqpacket_allow;
 
-- 
MST

