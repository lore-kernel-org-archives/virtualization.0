Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE719D09C
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732281; cv=none; b=ZjJNgzbAkFcElrkkrK5NowGXYKWdjzQmVyldE7poYkOqrhbcZlSI6Eb6MIw009SvwVZle8RxhKbr41JD7skAyWVCElY/KwoZqHzabx0srHxCt7YT1aMEYoIgl8pibJknLpFvNQHhg+D12szLLLvbNBCqRGzfOPRMLHd6QSQ8Ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732281; c=relaxed/simple;
	bh=P3S2zvRoo7lQJ0ChcHfU5Ea5iDRhwpVODl4UsA4zdsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aUox6xQaE46QZUkFUzq7sApebiB6uxn7bvIaYXehSHLgc+KL6tTmjztCLNnXL9c1VTeLrJuTleZbIm2V9128L1BfmhtWwpNaoVUxnnMX101/DKbLnNvWo5Q2wwUuqjOwuaicnpDHw0rncUBDjEkn1NiQ+/BKut+iuWPMab/HhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXSP8YNo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXSP8YNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752732277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUkb4nCGAHcNyByaHU5iCpVWleaJyNw90ZAtHNo4HkE=;
	b=JXSP8YNo+m+8ITdVBAnBAa6UYBcS6tBAsn1hFa5PjIq2PsdPVmS3FuPRzCYinuj+biQ2P7
	O7N2WxA8y6SBRa23a95nCwz5q465KEzGNRDKr/GwV5BYDYeqmgnm9/1HMdarGF2dUoSgPX
	hd/EKrpK6NuYmXVMlsUG4sfowDS7sTM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-oRepktWGNnunZQDjhS5AnQ-1; Thu, 17 Jul 2025 02:04:35 -0400
X-MC-Unique: oRepktWGNnunZQDjhS5AnQ-1
X-Mimecast-MFC-AGG-ID: oRepktWGNnunZQDjhS5AnQ_1752732275
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4538f375e86so5392115e9.3
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 23:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752732275; x=1753337075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUkb4nCGAHcNyByaHU5iCpVWleaJyNw90ZAtHNo4HkE=;
        b=cAJL/z8vEpMdbs6atWLkeD5X6QR/NdEb8JYcvXv9GkY/RmGNmCLz6hs8V2SKXc7Atv
         roZznQxtgCSgfMTqDwytUbpjIet6hFGBzXpVaho4qCY95tew/IQN3PRze+x3YCZO9vJ1
         ZR6NEyD7cZDcr3iYP+D5Gn0ekR1gBUJs0C1nmvQA4EJTAT20b8vA56yuY+gDHbsFUAXr
         4YuR+9CYAvwKlJMLdxjqm+7dmue4yWd1N2q2srPgZGN/CHhwbdztJdBn5rJP6nvZVCrM
         UHA393YHT6U2iiFTYN1jBz+RTYdWiFVkpbYDr2j8C976N+PNmGcq1/LfdfhzWGKr5YFc
         2fTw==
X-Forwarded-Encrypted: i=1; AJvYcCUbfL6CRuku0hGSi2RIPfB3K7ZxjGNDi6v6WalteN+8ohq9V2vnMgbbSaHTQSYiqu58/6nWaOevMQvEYUuprw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8OevqG49FnDho0u1rOGDcoak9+SX4qB+pzktZ+OnpTwbR4ynP
	Dx2MT8a7FcveSmRrv75r1YrDdk5WpPHtVnwxUTMKqnToysr8VWm0Wz2Z1l7Rsn3Qv32btYwEpVa
	wIUqps+5oK2aqL3YNjD9du32adBjY22jWEEHCDfnPSX0NYxA0SnHCKC7embWae/WrRWzD
X-Gm-Gg: ASbGnctaO5lBS371i0SLUOl6apeIv5tHHfpX6983Jxf4d3NvuDlOQAbvMiphu4qgNLa
	6tErmTPO2alCzOu9YSSpxWFXx906KUsvATIsaOPuSGDEhwiazKiagqRvLSchpf8enVDpx4CJtAF
	dOIRHDqv6Y5cdjJ9FGwfQuonpLuwBrOjefREBjEbPTUbJNpsQ3vxf/L2b8J/RdzRncgwzQW7zCp
	hRNGdFWRgKIOXsAycaosjG0Qx77dhEE/W3DfBfsirjL8qOgOCGfV9XIrhOo3+DAcjZvp5+T69kP
	S4XwXAU2h3ugrdaoXJKIJ5bRZAyVDo+n
X-Received: by 2002:a05:600c:a55:b0:456:1442:854 with SMTP id 5b1f17b1804b1-4562e28616amr46679105e9.24.1752732274624;
        Wed, 16 Jul 2025 23:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjrUfFCvAdm/MUeAz0hpuBCDwLEyQ3RVRuTxAsQFHlPQhXRkgs7ZoZlJruFXtXCDIWxuHA8Q==
X-Received: by 2002:a05:600c:a55:b0:456:1442:854 with SMTP id 5b1f17b1804b1-4562e28616amr46678735e9.24.1752732274082;
        Wed, 16 Jul 2025 23:04:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f5ea01sm11589685e9.14.2025.07.16.23.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:04:33 -0700 (PDT)
Date: Thu, 17 Jul 2025 02:04:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: jiang.peng9@zte.com.cn
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	sumit.semwal@linaro.org, christian.koenig@amd.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v3] virtio: Update kerneldoc in
 drivers/virtio/virtio_dma_buf.c
Message-ID: <20250717015524-mutt-send-email-mst@kernel.org>
References: <202507171041593886W7pGra5n2hPMaT1j17NV@zte.com.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <202507171041593886W7pGra5n2hPMaT1j17NV@zte.com.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6R-ZCTfQxG9AMjBUJO-lSm7TRugDBkUUlkm8yRotvR0_1752732275
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2025 at 10:41:59AM +0800, jiang.peng9@zte.com.cn wrote:
> From: Peng Jiang <jiang.peng9@zte.com.cn>
> 
> Fix kernel-doc descriptions in virtio_dma_buf.c to fix W=1 warnings:
> 
> drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' not described in 'virtio_dma_buf_attach'
> drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' not described in 'virtio_dma_buf_attach'
> 
> Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
> ---
>  drivers/virtio/virtio_dma_buf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> index 3fe1d03b0645..986cc73c503f 100644
> --- a/drivers/virtio/virtio_dma_buf.c
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -16,6 +16,8 @@
>   * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
>   * for an virtio exported object that can be queried by other virtio drivers
>   * for the object's UUID.
> + *
> + * Returns: dma-buf pointer on success, ERR_PTR on failure.

Most people write "dmabuf".


>   */
>  struct dma_buf *virtio_dma_buf_export
>         (const struct dma_buf_export_info *exp_info)
> @@ -36,6 +38,14 @@ EXPORT_SYMBOL(virtio_dma_buf_export);
> 
>  /**
>   * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> + * @dma_buf: DMA buffer being attached to a device

And here it's different for some reason.

> + * @attach: Attachment metadata for the device-dma_buf association

and here in a third form.

> + *
> + * Allows virtio devices to perform device-specific setup when a DMA buffer
> + * is attached to a device. This is part of the DMA-BUF sharing mechanism
> + * that enables virtio devices to interoperate with other subsystems.

I'm sorry this is just empty of content.
I can not shake the feeling this is AI written.
If we wanted AI to document all APIs in this way, I'd just script it.

> + *
> + * Returns: 0 on success, negative on failure.

This one is ok.

>   */
>  int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>                           struct dma_buf_attachment *attach)
> -- 
> 2.25.1

