Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655432938E
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601444; cv=none; b=JlsxPC+SYuSSngkCHtoazJRU9uBn2Ig1cfMKHJHhMoZxJsLxB32TZzgTXQDk7vAjUmmjJ8lSR0ch5DgUazl3rHeuPQA14TOWMpuxNBLnoHMEAdbG3gGTkkKj+6KhWXRsZB6EOinEQeCEcKZvpcFcBPCadTxxoaEb2AkNtfBTa2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601444; c=relaxed/simple;
	bh=jIFi+Zvcrqx5KM1Tn7Vx/X/Ro5vONbP7sNW0Mf3F+ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CPV9uMHQtSKBDzB94LlG9YRdDHP5FrsH6kAuCsr1om+iHPK9FDVXECIAEBmY1eAlLEjJQTRXKDPTjtGDxnRe4uIEUQAVTLwEna8CVZJLIbQK9ZR6E7dNdkEdwajxkhzMhB7I/UiMU2QSi/dKpjE7SheCmVDwW0f9I3qk9Nyh+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=fail (0-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0EJGw52 reason="key not found in DNS"; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0EJGw52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ko5SEulg/0toBKRpZAMNGsguRweEFK2Nvy+yQ/ftdE=;
	b=U0EJGw525N36TsoWhwIOnHH1npKLZARnTZguj2NX/3prDCcmeRPQbwt+hNfC0WXAQ3xUXf
	72jxF5QIZDsJqNjXDrw/4uv/LyZg03zEUPojJb9o56hhsYdQgPliO9LIbaDzxu0dd7svGC
	fhwmZSYop0+2nnDzQJGqmS6QbD+QSn0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-aya-jKFgMU-nG6MJNA8D3w-1; Mon, 05 Jan 2026 03:23:55 -0500
X-MC-Unique: aya-jKFgMU-nG6MJNA8D3w-1
X-Mimecast-MFC-AGG-ID: aya-jKFgMU-nG6MJNA8D3w_1767601434
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so88358715e9.2
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601434; x=1768206234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ko5SEulg/0toBKRpZAMNGsguRweEFK2Nvy+yQ/ftdE=;
        b=MGWyodtbTY7QFbF1PNCdfzLko0q/BOIDndsGpFOtMFbSKGRUh3ELA9rBmdNGWiYOSt
         TjbT+SEvXRRw5hcyjGh46pCRlahHKVQWI+RqVknzL+GwKIqKKCtpqB6QopUtf3yi/Q7B
         Ar6b5EWXgEKwOT3uVjqVAIkw5ICwuuYX7++hFqG0AMquZiwnRlliwNVtE2SnjTlft5y1
         rltbONgyH8YBBhQGN9sbKiLzTP7A6SU+BnOPHbKRgEM3wU3zpannphjHp6QiHHexJP7z
         fbJRVRehTCrFrvhfrqz7l4OG+5N2M44yjoJ+QeO5G5kEUO8x2UBEOmAHND20Zo+VvEuj
         IDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg8bKlgEQfDtIkGomGBzEuhjcBHeyYhvkPUJGrcr/1Pi6fY6tTHi06KCx2exIT4kTANTOe/Dy4TEdnN6WEWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHS/joUDroRyJIugNMc++bKfR2DyZzn3gsmdDez/oWFLNECvsJ
	57I2znJHQ5RJgx9b8e/g3y8S4wL3NJgeuj0mNMm723Bjzy/GUA6kFyG93Sp70WK8hK0lkR7MIau
	zyOxhggHvIDd8/BU+1rrFV9sPGdBX6Iet62icMzMX+J4jd1LbuIa70D4su+0SvWf6lJAu
X-Gm-Gg: AY/fxX5deXz5sq8EAqrQqLH5hzEK8gnax1LwXTE9Ef4DvRgNQSUH5D5YPDGlixd7nBH
	w7z/4BigxG9BuoU9GPGkzmGyrw6zall1FSUMQz7oFQc8VsS84v7moY3dwH4DMGWBc+YZ73u/iqu
	w27ajprwNQCVhIziygLhaqJcJgbzS7wpGGgkHYYF+zm9Z48agY/l6OCQCmXsypcQIRnSE91xZm3
	f7B8QcId/gn6fWaCl/YP6YCjj2BUKKcZqlZBerdSZPnczD+nLBMKpJLliCbsY6DXlZNkawMUloY
	z88oR2YvQUSAus+4IsVk7u3QeWjJytVZiY0sXGCK0uMhb8InWloAH/pVh1Or2usGlrJ2YM1l8hB
	rk1RnQHGIacxvnx2TEzudH4zsLwqwMgY+kw==
X-Received: by 2002:a05:600c:4fd4:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-47d1957afd8mr619221795e9.21.1767601433824;
        Mon, 05 Jan 2026 00:23:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMqr5RF3PmeKLntFlggNTcPo2ZIBIezL7tE6/J3AdeaKkIeEvwYa+UmsMabaObW/38gLAvfg==
X-Received: by 2002:a05:600c:4fd4:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-47d1957afd8mr619221495e9.21.1767601433387;
        Mon, 05 Jan 2026 00:23:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm99141541f8f.39.2026.01.05.00.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:52 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:49 -0500
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH v2 15/15] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <f1221bbc120df6adaba9006710a517f1e84a10b2.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YxNCrYslZU39I9WnkmXOGptKKB2bZGVyYGVxgEbeMSY_1767601434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reorder struct virtio_gpio_line fields to place the DMA buffers
(req/res) last.

This eliminates the padding from aligning struct size on
ARCH_DMA_MINALIGN.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpio/gpio-virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index b70294626770..ed6e0e90fa8a 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -26,11 +26,12 @@ struct virtio_gpio_line {
 	struct mutex lock; /* Protects line operation */
 	struct completion completion;
 
+	unsigned int rxlen;
+
 	__dma_from_device_group_begin();
 	struct virtio_gpio_request req;
 	struct virtio_gpio_response res;
 	__dma_from_device_group_end();
-	unsigned int rxlen;
 };
 
 struct vgpio_irq_line {
-- 
MST

