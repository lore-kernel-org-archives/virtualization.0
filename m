Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A251CAA92
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674220; cv=none; b=TOpqpSXW1nWreJSs8SdJz2QLlqMgLw4zgus19MstlvTwGvoQc3rlgVY39vElhqSFe5Bv3G7m7sEfYzO9R3oCYyZ/foTQBDq8Ag0xvaFa/dwlsz/9bxKQPHjrFq6OSATKD8XAZgDQchRYeByMtFbLPh8OFSdIbjQfRAx5IZLTHL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674220; c=relaxed/simple;
	bh=iPt/IuCgv7X6wzHFK3I4GCGSIo9yuavU0rKQEyFHi4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DmP96dISn8Rx2cnV4EOPGEpKny/klCZDh/oss48AwNt7B8Y3mA2zvZ+Uj1oZuJx5xJSG1c+rroei3FjHGmn+hT8BYM2fdMzQOm/tNc1Z3tT9cQNeygErt/ZFZO45wdBynmhvOGfSVKx6ed0EIkVOaw2goUtvEW9QsEXp8ZPYRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L61GihwD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L61GihwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fU90Rrx5Q2FZQjCI0B6EMx3qMx3LCWE+lzijdY4q10=;
	b=L61GihwDy/vdDkbxdH5X7JDQTKh273eATNLOMvg0jHLdLvF/by76EUwI819bfvtskglYVE
	jAmAb8+GMRXE209O2mm+ZYJ2jreY7MaKUoPEGOtCYYAN9t8cAjBqOLkETiZzgnQIEON4VX
	wWvxb8jhLe8UcZ1wwTH0YAE1nm/bsQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-gdl7kMC1O-KTEKqEREusvQ-1; Wed, 16 Jul 2025 09:56:56 -0400
X-MC-Unique: gdl7kMC1O-KTEKqEREusvQ-1
X-Mimecast-MFC-AGG-ID: gdl7kMC1O-KTEKqEREusvQ_1752674215
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816cc58so2334203f8f.3
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 06:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674215; x=1753279015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fU90Rrx5Q2FZQjCI0B6EMx3qMx3LCWE+lzijdY4q10=;
        b=fV48R7iDM7SeEFqlYr6ocyxsZYgqaC87KY2fIx37INHarwYaWbPHjvdXdStc415u50
         bAOOjyi2qSNR+8Cktp6smr/813P+6HMiVLYX/SEhlU3+enxT9VQhcI+/0QTGiI5GLISX
         tSuJ8eIJICagCzrJhCXWimMqBN4esO4CwISU7wRIMO07y3tk/iF+iOn5EeikU9rxa4DB
         xAgYMRpf5coZw3CSkN3chpbi6pXMSIN0K5/XSeyuWWiiubcyL51u+o79VYQDDsKVemgr
         W8lCdatlRHlRvnFMA1b80I60NRLJAlByVN5ZoxQWjnqxe4zIp7SMgsw12BdMqOfdDtWN
         GluQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnaMYDdth1WoqnqTMsLOvovYw3AMiBcNlQBXj3FIETO4dx7N8KpSwtseIdLHIpXWm6xzwHug2QDpRx7qberw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVjFRhO5rvOflDE6mJ6R5P+qbXxbzbd371nf+t4/q2fg8CqCtb
	tUTQkfowNjnkw7TmJkZ2NUbcxJ7Z/MUnM/s+Jj5HHhr8RlB9KLKk3FQJwhdrMJN9zQJWcwoxvKO
	FNQBjPNzNnElvtphsoej7imKvQkTXh63QeTjDZSsnhdOeAyCvd0vAZHSAc8iJKigzvT16
X-Gm-Gg: ASbGnctYH73Es821LiCrD/2rgaJAbln/wQn7QdrB6TqCi89TQx9fOm1InLSgtHXDHyO
	zNHzJIFZWJk6FTMSp2DtwYJyr1o52gBzz2ftLZ1rQ+AJ1GGLwdu6MkX6g78A/o9oMYUooyjKAKx
	J3ew9oJZsGVvr2L99mwe4w7//8C2RXry57P9+yw6ypm/7K5uIUQmla4HPDuTf0NYjq7F6qulWFo
	rBuztJcNRGlIzHI7+wXOqETxPMet7IBNFpLPpvDgHnyMq96PVTqxmql5n7uXVVrUTF3y6vAO8WD
	G+CubFiENJQqvgOKENdiLHbx2mPgJIg7
X-Received: by 2002:adf:f64b:0:b0:3b6:936:92fa with SMTP id ffacd0b85a97d-3b60dd8df46mr2367237f8f.52.1752674215040;
        Wed, 16 Jul 2025 06:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDkw4tjXyAdhQ6LVjUDIf1HaSWqF1ZS/CeOQWr/qZekbvwZ8qxdZocOeTQ+5WAYNkarEumJw==
X-Received: by 2002:adf:f64b:0:b0:3b6:936:92fa with SMTP id ffacd0b85a97d-3b60dd8df46mr2367218f8f.52.1752674214534;
        Wed, 16 Jul 2025 06:56:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd15bfsm18252140f8f.19.2025.07.16.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:56:54 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:56:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: jiang.peng9@zte.com.cn
Cc: jasowang@redhat.com, krzk@kernel.org, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: Re: [PATCH v2] virtio: Update kerneldoc in
 drivers/virtio/virtio_dma_buf.c
Message-ID: <20250716095046-mutt-send-email-mst@kernel.org>
References: <20250705105803198ff11jYCkg1TxntcCEb00R@zte.com.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250705105803198ff11jYCkg1TxntcCEb00R@zte.com.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QplVAceRgfJSHZuaYoUnuc00Tav5NFVA3N9R4W3xaaM_1752674215
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 05, 2025 at 10:58:03AM +0800, jiang.peng9@zte.com.cn wrote:
> From: Peng Jiang <jiang.peng9@zte.com.cn>
> 
> Fix kernel-doc descriptions in virtio_dma_buf.c to fix W=1 warnings:
> 
> drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' not described in 'virtio_dma_buf_attach'
> drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' not described in 'virtio_dma_buf_attach'
> 
> Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>


The extra documentation unfortunately just mechanically repeats what the
code does. Code comments should explain the reasoning behind the code,
instead.


> ---
>  drivers/virtio/virtio_dma_buf.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> index 3fe1d03b0645..0b39b1b209ee 100644
> --- a/drivers/virtio/virtio_dma_buf.c
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -9,13 +9,20 @@
>  #include <linux/virtio_dma_buf.h>
> 
>  /**
> - * virtio_dma_buf_export - Creates a new dma-buf for a virtio exported object
> + * virtio_dma_buf_export() - Creates a new dma-buf for a virtio exported object

virtio core uses the form without () consistently, everywhere.



>   * @exp_info: [in] see dma_buf_export(). ops MUST refer to a dma_buf_ops
>   *     struct embedded in a virtio_dma_buf_ops.
>   *
>   * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
>   * for an virtio exported object that can be queried by other virtio drivers
>   * for the object's UUID.
> + *
> + * Returns:
> + *   - Valid struct dma_buf pointer on success
> + *   - ERR_PTR(-EINVAL) if:
> + *     - exp_info->ops is NULL
> + *     - attach callback isn't virtio_dma_buf_attach()
> + *     - virtio_ops->get_uuid() is not implemented

Too verbose, no one will rememeber to update this when changing code.
Just 
	Returns the dma_buf or ERR_PTR

is enough.


>   */
>  struct dma_buf *virtio_dma_buf_export
>         (const struct dma_buf_export_info *exp_info)
> @@ -35,7 +42,16 @@ struct dma_buf *virtio_dma_buf_export
>  EXPORT_SYMBOL(virtio_dma_buf_export);
> 
>  /**
> - * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> + * virtio_dma_buf_attach() - Mandatory attach callback for virtio dma-bufs
> + * @dma_buf: Pointer to the shared dma-buf structure
> + * @attach: Pointer to the newly created attachment metadata
> + *
> + * Implements the standard dma-buf attach operation for virtio devices.
> + * Retrieves virtio-specific operations through container_of macro,
> + * then invokes device-specific attach callback if present.
> + * This enables virtio devices to participate in dma-buf sharing.
> + *

Same thing pls do not repeat all of code.

> + * Return: 0 on success, error code on failure

we say "Returns zero or a negative error" elsewhere. seems clearer.

>   */
>  int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>                           struct dma_buf_attachment *attach)
> @@ -55,8 +71,12 @@ int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>  EXPORT_SYMBOL(virtio_dma_buf_attach);
> 
>  /**
> - * is_virtio_dma_buf - returns true if the given dma-buf is a virtio dma-buf
> - * @dma_buf: buffer to query
> + * is_virtio_dma_buf() - Check if a dma-buf was created by virtio DMA framework
> + * @dma_buf: [in] buffer to query
> + *
> + * Returns:
> + *   - true  if the dma-buf uses virtio_dma_buf_attach() as its attach callback
> + *   - false otherwise


one is return one is returns ... no consistency.

>   */
>  bool is_virtio_dma_buf(struct dma_buf *dma_buf)
>  {
> @@ -65,7 +85,7 @@ bool is_virtio_dma_buf(struct dma_buf *dma_buf)
>  EXPORT_SYMBOL(is_virtio_dma_buf);
> 
>  /**
> - * virtio_dma_buf_get_uuid - gets a virtio dma-buf's exported object's uuid
> + * virtio_dma_buf_get_uuid() - gets a virtio dma-buf's exported object's uuid
>   * @dma_buf: [in] buffer to query
>   * @uuid: [out] the uuid
>   *
> -- 
> 2.25.1

