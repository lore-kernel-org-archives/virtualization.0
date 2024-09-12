Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C8F1BB6B7
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153948; cv=none; b=sSr+xDybi23lmRUKKs+mwG2oHpMy3Us6vygvy+UIrw/4ru5oPEP9lw0Gu1onBR9vpIpe9rTO/TpP0Wy/jkbsdt0z4Qg9SsctULRDDSKH+xPx4X7XKlHTCdS8weclIkOz/xnpx6wzEpFiEG18kM4u0EkbJyN+4gqSuIJN6kgHNqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153948; c=relaxed/simple;
	bh=I2voFZcLWTdXlH0Xxt1X+l2lqmh24ceGysC1sOnKj2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPn+V3IKW1EdEKIYSH2vUixKS7dDCIln5AZN69h8El/yxPFOAupzvP2NrPTNK0ZrDRu0DveBDvJr3R2ykhC6vO9wqLar7nWuAqfhsjMTfm4Bs8uYjDJrZnFNoHuDeOxMgNLkysqhZlHVhe0J++sv+/dNTQu7yHyWrlQnFbj12yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maTZbuV+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maTZbuV+"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so890861a12.1
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726153946; x=1726758746; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hornCASRPZxYyES6JkKYahDm/Amb2BvB/wmy3lSmhe8=;
        b=maTZbuV+cHXm/zvSXx1NE0pCx1UiFxl/T+5WDJ3OeEfExBo038A/I86tozmRNkiA+M
         /6tkdxqkWg8JhNdx8ckVA21WHaY0X3ZEdlBSmr0DWAFTcDBFZB7Q78xVUt2jcgODGFgf
         +l2e86BN5Jmhej152ZmrRMOsnrGWcTiUDS4P+i5ql2sdm1SC5RbX+3b53s7xkT2EdrE9
         AOQwkyz2OBSQt1K6OSzquTqTxspyAEIoAovsRGy32fmJRd3kHfY8SwBOrhAliRFUs/Eh
         pNCjKNh5NnWC+9yDkbIGuZRyxAoK7zrT1/Z8eq5KNuvmEO0xtzEeyXt0EWLylRiZi04Y
         V4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153946; x=1726758746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hornCASRPZxYyES6JkKYahDm/Amb2BvB/wmy3lSmhe8=;
        b=gtsnOMSscBftwbf8eUF4S495uP3oeLjVMjNJ5gF15TrvgQbF+rfoyGBnmdfdlakFVZ
         OtvEQjjkJAhBrpqglUBQqsW7IRPBRZdsf5OD91qBJ5S7uWLqOl+JKobrT7AKFaOQXKji
         7SOhHEgXCTcLKSqeBysRgEwQqdssyiaY8OTT5t+0JK1iXSjbA50bLBZCjPwlz7qfUSTk
         4nEteAOYfMjkQ2MSuqqDgnhBhGjhpjCmqdJkmJ1Tul1y9HbqoBR/9/DKcPjHTYESZQ8Q
         HHupSTikLy+Sp+qXPub26O88YRrC4LXw0Ol5S/lnyfHxG+d4pRGhQy7iNJkFd8s2hMk6
         Ptgw==
X-Forwarded-Encrypted: i=1; AJvYcCXgPOEwIR8iu5sNiLasuKxVap08AviwxwDzVgEtpF0ftre3DdF7zYDWwOab8ab4Wz1ihcviZuQYMHJUrNQhmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY/Bp3lNjkoZC4ayAB5LvNqS0ieSVwJz2wcSkfDqZ96Noq0k7e
	ipbcXzDK8kxOA+pqSxhYWtcVypIu+0YVbnGjVMd1sxlHk4NRmPK4L0R0cqphWGIzher5xEKe0Vm
	2Kn5v1lmS4vss0vy5QYC/GyL4FJE4pinixyyb
X-Google-Smtp-Source: AGHT+IFpigeOxXGsM9No1KNYNjI2xqYtkNJEQG1vrniLwX/lIuN2l+NdeRaljmmGR2d1QqRvBKl43C4rBl0OtQrx2rM=
X-Received: by 2002:a17:902:d2c8:b0:206:892c:b758 with SMTP id
 d9443c01a7336-2074c5ff323mr134718295ad.13.1726153945851; Thu, 12 Sep 2024
 08:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
In-Reply-To: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
From: Marco Elver <elver@google.com>
Date: Thu, 12 Sep 2024 17:11:43 +0200
Message-ID: <CANpmjNNU_-NCjN3qUm0-0_oDoO9TzbuO5zrLixA=M1=ON+5J7g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_ring: tag event_triggered as racy for KCSAN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 17:02, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Setting event_triggered from the interrupt handler
> is fundamentally racy. There are races of 2 types:
> 1. vq processing can read false value while interrupt
>    triggered and set it to true.
>    result will be a bit of extra work when disabling cbs, no big deal.
>
> 1. vq processing can set false value then interrupt
>    immediately sets true value
>    since interrupt then triggers a callback which will
>    process buffers, this is also not an issue.
>
> However, looks like KCSAN can not figure all this out, and warns about
> the race between the write and the read.  Tag the access data_racy for
> now.  We should probably look at ways to make this more
> straight-forwardly correct.
>
> Cc: Marco Elver <elver@google.com>
> Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Probably more conservative than the __data_racy hammer:

Acked-by: Marco Elver <elver@google.com>

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..98374ed7c577 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2588,7 +2588,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>
>         /* Just a hint for performance: so it's ok that this can be racy! */
>         if (vq->event)
> -               vq->event_triggered = true;
> +               data_race(vq->event_triggered = true);
>
>         pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>         if (vq->vq.callback)
> --
> MST
>
