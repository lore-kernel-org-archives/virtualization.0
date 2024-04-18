Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0454BE2
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420841; cv=none; b=Cy47AoeKQiDd2wdhaBGIoqhhRG01KYN8fOqaxnpqZ4aCWqEyGEZNPrSz2HuKnLQ8fvmlBOUvhiVcFZgLfmMaBiKAeUUugOPwsQqSCKSXS8gGknyUgL5Nj6JKKe0MzvRqoxsRwlG6WIg8NSEDO/UntGyTU+cAmkyiSsV527I1C8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420841; c=relaxed/simple;
	bh=DzHtYet7xw33U75FxEw5lUmOXI3xG0fMjLZjCs81rD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXPdfT/wL0dPa2nD6v0OsaeNxWx82lLjmfCx1KA9gtddfnjiuY1hUCfJzElnY7do9XDytsJQb1lMkk76wojL6aDXxJG/1LRUaRI2qB/Hw9MYnYMVAx+pg1et/bDkqFvtpyKSEzDX9CyKhFGNDiKfCSUzsq53jXnAN+HsMX5H8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYaVT3Az; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYaVT3Az"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713420838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyAsixzg/C7NuM2YrjqrwtUhaKllzlyI1uPLxkOcmsM=;
	b=DYaVT3AzM3eLdPQRYMhQIDOIAtwT/u/WrgoBaD1TMJDIiUBYe9eKNmxT0Go9Irwas14gL6
	O0guuClzcWtQhjGPQ6MrzJTy/6hlWqGIJIiTSdVcU9fg0+NpBlGS7NktEoFn/SCybY42lK
	xGYYWJdvO2cXsHQAu8TRIfy55qJIX3E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-G61E1gMDOn6TONJ2od-LKw-1; Thu, 18 Apr 2024 02:13:56 -0400
X-MC-Unique: G61E1gMDOn6TONJ2od-LKw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a2bc796cf4so724255a91.0
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420836; x=1714025636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyAsixzg/C7NuM2YrjqrwtUhaKllzlyI1uPLxkOcmsM=;
        b=MI8nCvxIRUqsPd6y+lDML3rb9xEF5w7MlMNjW6KdUfAzqGeXKpCKdjU8cSw3eYdFU6
         LzQ8dLy+LLdwEVu6ETo81bg4sQvKnuGEG/2wB5FeW8LDVmKSacUyfugH0M0mEDHt+4Mq
         lfUultxp4P4HfnK2zUHf8IBkZfk4It/RzC66veJtUi+8YtUv9hS2DMhJ8bTfZN2W/5gt
         GEF8RGB3RWBToCV3umJ73khNQQCLmE1MN/Ml0dgNh0sN2jWcwpe6uycAHiDdM4MmQ6Eb
         1rN/MmeLTq+xhgqMQ2X8bPsfW2Zblz8SrRNHSTXvmWpctXCCXS3Hk+d4jXNzi6YmZVfj
         Aokg==
X-Gm-Message-State: AOJu0Yzcn0aj+KUtlnjiZmgU9IHt86smzY+QZ0RYQsanZhk3iyXrgLZZ
	SpUFO4A4gaNpC8pnis8Al37gvKJiVORQagSfssJFbJSv1R5+M/9c8VWUjRtW7G3zOSW5L88foQC
	H/pcRvk0FvZijL3wWx8OEnlgFxOPjFje3coao3w3NyXFb5ymLbZ4FM94dB+neYOegFqR/SAQl7s
	JamzxkYBnHdFdvi8Ttxj7eZaBr8Chm13LeGfMdiZ4=
X-Received: by 2002:a17:90b:253:b0:29b:b3fa:b7a5 with SMTP id fz19-20020a17090b025300b0029bb3fab7a5mr1690933pjb.7.1713420835843;
        Wed, 17 Apr 2024 23:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVdzu9+TyIRaPXKFdcEi9FoNx1ow6iyhMtDgpvTH0oQRz2sSRKXwXqslukumyf5i3Aw/86PTvEgHH+60ZGtgs=
X-Received: by 2002:a17:90b:253:b0:29b:b3fa:b7a5 with SMTP id
 fz19-20020a17090b025300b0029bb3fab7a5mr1690925pjb.7.1713420835550; Wed, 17
 Apr 2024 23:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:13:44 +0800
Message-ID: <CACGkMEt8hZ3UdMwuANu2KwMFAeZ3DvD9n5UcqJTbZE+eQtM=ow@mail.gmail.com>
Subject: Re: [PATCH vhost 2/6] virtio_ring: enable premapped mode whatever use_dma_api
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, we have virtio DMA APIs, the driver can be the premapped
> mode whatever the virtio core uses dma api or not.
>
> So remove the limit of checking use_dma_api from
> virtqueue_set_dma_premapped().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1b9fb680cff3..72c438c5f7d7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2730,7 +2730,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   *
>   * Returns zero or a negative error.
>   * 0: success.
> - * -EINVAL: vring does not use the dma api, so we can not enable premapp=
ed mode.
> + * -EINVAL: NOT called immediately.

Let's tweak the comment here, for example, we can say the vq is in use.

Thanks

>   */
>  int virtqueue_set_dma_premapped(struct virtqueue *_vq)
>  {
> @@ -2746,11 +2746,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *=
_vq)
>                 return -EINVAL;
>         }
>
> -       if (!vq->use_dma_api) {
> -               END_USE(vq);
> -               return -EINVAL;
> -       }
> -
>         vq->premapped =3D true;
>         vq->do_unmap =3D false;
>
> --
> 2.32.0.3.g01195cf9f
>

