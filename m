Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1E322B6A
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112843; cv=none; b=V78+uZQCdlx+kY5b4mR6rXJ0gZBKrrEBJqMJ6DAZ3EgFo1UYCXVI2GD4mAL38ithtm7GbKed6MY66hZFqCAntElYkaKHG8OoXBSIbjDJflLj4T6n6/RcbmK5YHCDzRrEWMWlRJJ7M5Hmnzjw39sPHTF/cVQWEz4RK6v5qVTwQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112843; c=relaxed/simple;
	bh=rJvyv/DkZDnTdlk5mMz+iorYKgEElNGmDI1t8E4mVas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Psd8KFs6YZ/aF0gLqHBWD2dOFssr0NwxDjDxXuQE+0JsqZRoPY1utpyYsUMU/SXdRFEq6BUwqwteokqJWI0zoYzjvSYtkGX7mc5dBuKWtXxaqfnuv4avgDiqhMn9HqeHbiJU7x8YdYUjp6MV6YArHv81qilzpHvvAup7mKbbfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PH7LuFAs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PH7LuFAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767112840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGewFge/6sMWyfD/6+VNEsuf36DWmJ0Q3xqEbJz+f7M=;
	b=PH7LuFAsj6XUk/4EbdGhLB7ISzz7kfm1g7oyx9y3XcUiyKMEa0BuFourlWUkkJpI7KaH6z
	zPLa7j7LiCDgNlBZNOKqezN6WUIounga/WNnWFpFmLc9Y+/VdByBk7jzhmhTHsxBRFbpX3
	TztSEUUMKL7FTjEWi8GQKqU1mw6Yh4w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-z_HDuPlwMMSdA_Qp7rMAag-1; Tue, 30 Dec 2025 11:40:38 -0500
X-MC-Unique: z_HDuPlwMMSdA_Qp7rMAag-1
X-Mimecast-MFC-AGG-ID: z_HDuPlwMMSdA_Qp7rMAag_1767112837
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325cc15176so4728899f8f.1
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 08:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112837; x=1767717637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGewFge/6sMWyfD/6+VNEsuf36DWmJ0Q3xqEbJz+f7M=;
        b=XNxBs6k83qHG2498lzXv8g+2zgajAQCrTX/sZRX9qHj/lc4CftTWQjIR8BY/Bh4bn1
         QaXmtWj0km2cNAvgxFFkfXZc5zkuwbLzdj4pN3ztOQacC61BjQVdCjY08JWn3j+ya4O1
         qn5igNsfu546d58EDRSwy28dQ/faTQNu5q0QGpfBONUTGULVwuS3tTEolchjBCLLWC1H
         EHXsJ/Qs8M0o5X5lgxH2c853GUS3OUg5GXhv7NujJo2dQrZUu1rNg1ESaiF2l3ExTtLL
         98J6H0+YRHcFsB6hqedVPIMj/7h/7LYyPGD0LoXHAgZdp7eEIwa6MTK05j93XGp9N2Hd
         lBGw==
X-Forwarded-Encrypted: i=1; AJvYcCUTIsfxiIMeBB4ScSF1HENe3RTQEYGk6nXLgVLooY59rTRdV0042p5TjVud0YMfON6FidSu1kWtnr5MVgxxBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2uFQY55lwr0kjcOACaMJe6eAB1PJY+xAwwmgrXz5tGe+wnNCN
	R52SFY/CXK9XdLasFieUrhb24hQGfrhRlxD8iG/WWwO10uay+aV543g+j4vFhMrvViLcCf3uFPR
	AY9b0RRa67pAFIoUhR/iiw72Dby9VjsmR9qs8VKahY/NhJuo2XVJfqXG7BMKDCPIv145+
X-Gm-Gg: AY/fxX7RHHg6te0Iw6ppUCeOGAKBjUBUCWnzMEEvNJGkFJGNwlWL7ZHohKkzIbEG/8e
	h/+3HDsuyfRwTrCnzIamkZ8vzQq5G9Sr+4FbMcrf+NoUV8U7vbGrAzasl33J5g0+cFv75ogItoP
	CECoeu2tu2X87GPLIEHDU1PH063XDOldDoOLMQnoQpsqFfipYUP7QSMe6xnBw3yuYV6bN40IybK
	9WZlT3atf8uXDUha88umTz3n4iH9PuPHyyJdspC9unWNhXflHDScmo/zt0e0mXdbjZxpzLKwk8E
	zh9R9oR0NzrnLWd5qhQm6ydCk/EMEfkG9UkBc72jV7EmY49raaDy+aGugRrM8b0QVS9jO/DHRrd
	mglNccwHvOTDUSoDzNLX6BpaWxlcGWq/srg==
X-Received: by 2002:a05:6000:1865:b0:42f:b9f6:f118 with SMTP id ffacd0b85a97d-4324e4cc03bmr47308996f8f.15.1767112837182;
        Tue, 30 Dec 2025 08:40:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJgojb32FwsKVmHhWZwfLhjoCLU41JBrW58xQS8ik2FTwcPC3e2aYiOOV4nGFH+isXC/64yA==
X-Received: by 2002:a05:6000:1865:b0:42f:b9f6:f118 with SMTP id ffacd0b85a97d-4324e4cc03bmr47308928f8f.15.1767112836647;
        Tue, 30 Dec 2025 08:40:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm69151255f8f.1.2025.12.30.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:40:36 -0800 (PST)
Date: Tue, 30 Dec 2025 11:40:33 -0500
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
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH RFC 15/13] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 5aLLimu-bwDmqlWDNZd1TX0Cj54RpZfPYjf4rGadloA_1767112837
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reorder struct virtio_gpio_line fields to place the DMA buffers (req/res)
last. This eliminates the need for __dma_from_device_aligned_end padding
after the DMA buffer, since struct tail padding naturally protects it,
making the struct a bit smaller.

Size reduction estimation when ARCH_DMA_MINALIGN=128:
- request is 8 bytes
- response is 2 bytes
- removing _end saves up to 128-6=122 bytes padding to align rxlen field

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpio/gpio-virtio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 32b578b46df8..8b30a94e4625 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -26,12 +26,11 @@ struct virtio_gpio_line {
 	struct mutex lock; /* Protects line operation */
 	struct completion completion;
 
+	unsigned int rxlen;
+
 	__dma_from_device_aligned_begin
 	struct virtio_gpio_request req;
 	struct virtio_gpio_response res;
-
-	__dma_from_device_aligned_end
-	unsigned int rxlen;
 };
 
 struct vgpio_irq_line {
-- 
MST

