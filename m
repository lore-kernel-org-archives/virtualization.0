Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3E762CF
	for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649356; cv=none; b=YbV157ecG4xZuJe+jMK2BMsOGftz4b4yvGA0fjEYWA4DO6NQnZy5e82Vqxywvbssc7Hvudh0pwWTtm+4nefum9Xp265TXiwgLlkokzohuJMbviI7GWN8Af+JaShJKYBxV3+xQisq++h8TPJBjL/BRkfVBRsvoHKmt6FBeZNwLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649356; c=relaxed/simple;
	bh=2J6sAooCk62fHjWrW7YUBlLRP5OyzMo31VVLNDHdhWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBy0jYT80DoJM2c0rCct2TVpDMm/+jyRiL6T5fGul5ZBbdjQqCw/A+rP/pVT6ezo4lw7ZC/zb0n5i2n9ZgSYPgVCNiJHB3Xz3qQDy/ZvKEO7PGBePzIQbPnxHzMFUDS/93lfXSbozc4vBy7/YzRl5Mc6N69CRiODCON41xgfMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyn4QsSt; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyn4QsSt"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2144ce7ff41so2152972fac.3
        for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 13:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649354; x=1707254154; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7uVaLbUp0zV3Lqp8SjRyaTBacDGvqyOGhA2F/OG5J9Q=;
        b=lyn4QsStfm0xunIkj10c1Vd3wsXK5kNqynS6CbGSM+DL1AUAVESaM5Xb09RlYIeygq
         nbontjxzdHOaLRIUxkN8xZ3QPCgUXYIMwjYpYbS4kFWRo3Fq6MBI7EiLfU32LB6rqno8
         LWimvGiDL2J9AQfwHhGXSFaP+VujLPNYZDbqKytyCav2emuhBv1+8SgwkC0Tx3qPhgLm
         WzR7/8qdK7B0HVsx93ccEFaENgdFU1QQTFm9cySmkjcBItWj6rVaJHguxeIEfxxrY2RW
         sANHSKhotLGg0XJ+Iy10/TiK26Rr0NyMOwy+InuPq6J4+p4IRNMs52jWxDWwSgCLWvVn
         CwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649354; x=1707254154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uVaLbUp0zV3Lqp8SjRyaTBacDGvqyOGhA2F/OG5J9Q=;
        b=EnJ8RY6Y0wqX2z9moHVyGJv1excYWZmxl0/Z2N9P+kJYuXx/r/k2D11hyHC7/VAb/w
         T0wzMXom4ifhabcy99GeCKaKGQLzv/8OWgGKqkVbmo4qNmZprJxSZcTJqyxgL6seWJCj
         ka6ATJWqtWkR5rjV3EBgvi/eLheoUvF7pURLT/1fbUniQxO0lCIo87pWzTMZnigaQFnp
         PbAGvQocL8RDitJAnIkDwJRZSyhhU2lEWBbLW+Ec2BQAQqWMpe8fRUwo5yF7N9CEVE5t
         V2lxHaKWzX/MW/BihfkraVq50Rk7rqmj71/bpCXZOk1NU0Cbo3JPe5q+B9QsuncH11j0
         wU2g==
X-Gm-Message-State: AOJu0Yz/qfUzEQfdhi3S5wgl+h3MnzvRmy93w+Yp3OM79BnJbRcBr8Ll
	BsQ7b1yXUZ799jzZO+zI7g5ubQx9CKCFhLZB8cgzYooXJngm4S1D8MPBOYva3+dLYfKLbY4Lxw8
	cwGDgBMKkvMsbr5JoDV7c3CNKGec=
X-Google-Smtp-Source: AGHT+IGH9PpeiWaqfEAXJVURKEkRwkn0w1eqpTcew158AuIabqXuAJ+Md2qP4etm6tpr/3laTRZT+arssHuDHEtrV9w=
X-Received: by 2002:a05:6871:3415:b0:218:7597:2018 with SMTP id
 nh21-20020a056871341500b0021875972018mr5405415oac.16.1706649354251; Tue, 30
 Jan 2024 13:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240129085250.1550594-1-yi.sun@unisoc.com>
In-Reply-To: <20240129085250.1550594-1-yi.sun@unisoc.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 Jan 2024 16:15:41 -0500
Message-ID: <CAJSP0QWLk_=Nm2aw+rwgg6L4CJPy6w--=SyF4vCU_sDCyQdosQ@mail.gmail.com>
Subject: Re: [PATCH V2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
To: Yi Sun <yi.sun@unisoc.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk, 
	sunyibuaa@gmail.com, hongyu.jin@unisoc.com, zhiguo.niu@unisoc.com, 
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 03:54, Yi Sun <yi.sun@unisoc.com> wrote:
>
> Ensure no remaining requests in virtqueues before resetting vdev and
> deleting virtqueues. Otherwise these requests will never be completed.
> It may cause the system to become unresponsive.
>
> Function blk_mq_quiesce_queue() can ensure that requests have become
> in_flight status, but it cannot guarantee that requests have been
> processed by the device. Virtqueues should never be deleted before
> all requests become complete status.
>
> Function blk_mq_freeze_queue() ensure that all requests in virtqueues
> become complete status. And no requests can enter in virtqueues.
>
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>  drivers/block/virtio_blk.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3b6b9abb8ce1..14ecc14ce8db 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,14 +1595,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
>  {
>         struct virtio_blk *vblk = vdev->priv;
>
> +       /* Ensure no requests in virtqueues before deleting vqs. */
> +       blk_mq_freeze_queue(vblk->disk->queue);
> +
>         /* Ensure we don't receive any more interrupts */
>         virtio_reset_device(vdev);
>
>         /* Make sure no work handler is accessing the device. */
>         flush_work(&vblk->config_work);
>
> -       blk_mq_quiesce_queue(vblk->disk->queue);
> -
>         vdev->config->del_vqs(vdev);
>         kfree(vblk->vqs);
>
> @@ -1620,7 +1621,7 @@ static int virtblk_restore(struct virtio_device *vdev)
>
>         virtio_device_ready(vdev);
>
> -       blk_mq_unquiesce_queue(vblk->disk->queue);
> +       blk_mq_unfreeze_queue(vblk->disk->queue);
>         return 0;
>  }
>  #endif
> --
> 2.25.1
>
>
