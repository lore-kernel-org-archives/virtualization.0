Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1A469D
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 03:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843502; cv=none; b=sfYO5qyN6SBW7vmMKQ+bk7kL5nSJb5WW9AF8ZoosIRa3f77+FeSNNZ+qOV+Ibc3Q61KZmOUP9uV0c4SxblcR0gJ2veeEi/RJljghlw6Mb5Tyt1AWlzUtL4f0mXN0HNcU59LOGW4X107lhflvIxXhxkBUt6h142Li+KTnTn7XnLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843502; c=relaxed/simple;
	bh=08ZpgLtfSYqi4+i/U9XHqQzEVglXimSDYNawkficNd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+wte335KN/jqrL9vy5TrcGVj4fyQZNoqroosd16YmsYnRLKZcnJ3+7Jecbbhhk4Osmq/MV3eOk77+L6h3f5WdBt3WAaT5IcZXg3obUbSEr+qwapvR/f/Tsqc6C2fHMGF8kGzAmEfDbv1FXhdtg95tnnESLsZJ9WkjcGz2e12LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWMTm52s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWMTm52s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767843500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v58SV4sfp1KPqLP1VgpxZ6XDQOK5uoDM/ahl82LBf0w=;
	b=RWMTm52strCSFLHMo6EGYyO/BWxkaySRmu5pnvCTQPnOBVyHqhXFsz+jpzBZvbi9Ls5gnD
	qyh5pJzH4FrIx7vRWyJcCGwbPtLtvejh2kGQv1iqkaGfL/qRMooNmziTnvVcA2Cait9PMv
	Kskr63vpHSogQZJvfCFXeS/dKvJA2rE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607--YG5JnkFNRWyMN8hVwJe1Q-1; Wed, 07 Jan 2026 22:38:19 -0500
X-MC-Unique: -YG5JnkFNRWyMN8hVwJe1Q-1
X-Mimecast-MFC-AGG-ID: -YG5JnkFNRWyMN8hVwJe1Q_1767843498
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso3258760a12.2
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 19:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843496; x=1768448296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v58SV4sfp1KPqLP1VgpxZ6XDQOK5uoDM/ahl82LBf0w=;
        b=nHAWpE4qXln+c9jK6KwzrqZzdRREfTJo+wQTjBT9dyP9/+oKhaGgmy9JhOHDsD4v3S
         XxEXNrWEz8ubpPHghv3AcCD/T6bKXvzcM/RWOFOm4gmoCBF9ssFPceXsVzmJnWTkNvG/
         lIqvEjc4sO4ZnygbER4fPqgccpHpBXRkB4dehhInNNkZrROSBuI8fRFWrhuafTsSQDHK
         5X1RAw/A3rGCrmiomlO8IDpWHynhoWAIjusPJE/iq0zExT5L0m9zpKWMdO/PWWdd+DnK
         H8K/rGZp207FZt145ERgh6b+6gCRjr2mlcLMNEU+qJdW9ChNoUe4fU4sp69XkvuSc/XN
         +T4A==
X-Forwarded-Encrypted: i=1; AJvYcCXM8GqXMYruVB+6Zu5UGIknc++ZT0JjkT0EqfUevaT76kS55iFlWKhae6qLvPabn7lRSPA3GnLOxDR4WiHH8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyp6geA8TgRjQYfZQC3+SN3OvwLVTMZa9veqpze71qCIrFCC8qL
	o18Qx/HUDlzypbBzRCQAVEpY4wggxI9tYBPiUnNmfsX/Op1E102RR6RU1MIyLQL0swXjjAUdUyx
	hqV4fMuYv/x+m3wGEGW4TB/TKUqTcb6jWBQKCuDioxTasOhmStHQhdM5jsDkh0VpR9K4bxTEFa+
	NnApz/FAqyQaX94sWRaz4SBu1vi85KY+5OSK7AxrP7hao=
X-Gm-Gg: AY/fxX5m4OK1UHEDy4Ygme6UjyjMZoFn/jgH03AYJ3ntBBiz3VLQvD0uCDOflwS0G2P
	cS0Jp02X0bJKq0IpmUmYpwfqPDb45VRsdt7huNAoClVJ/ZkpT6TF/yageVmm0wgKktWjKvX65Hs
	jz5d6FzLzJoDdQ1r4o2yrpSCzYBbL5hzo0pPBChIMHpAZ43dnU6cD7zDmk+r49klY=
X-Received: by 2002:a05:6a21:116:b0:35e:11ff:45c0 with SMTP id adf61e73a8af0-3898fa226d1mr4400184637.55.1767843496434;
        Wed, 07 Jan 2026 19:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrINQzJlx78fjSA9ruvmWJu0w8vOPujfDqFXxbDJsjPnMqr1tJkD5ak8/7tV8xdLw9u0H5oRpbFtVWYj1SfYw=
X-Received: by 2002:a05:6a21:116:b0:35e:11ff:45c0 with SMTP id
 adf61e73a8af0-3898fa226d1mr4400161637.55.1767843496025; Wed, 07 Jan 2026
 19:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-4-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-4-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 11:38:02 +0800
X-Gm-Features: AQt7F2pYgxF0Jvdv3uPx8yLVba1YerHhPNETBcotNKOEiOav4ZMJyA2wFtENvzw
Message-ID: <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 283T5L-3bIVWydx_OVDRHUTjnImbzdq_Q6ge4ggAKYA_1767843498
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_consume()
> and wake the corresponding netdev subqueue when consuming an entry frees
> space in the underlying ptr_ring.
>
> Stopping of the netdev queue when the ptr_ring is full will be introduced
> in an upcoming commit.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 1197f245e873..2442cf7ac385 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queue *q,
>         return ret ? ret : total;
>  }
>
> +static void *tap_ring_consume(struct tap_queue *q)
> +{
> +       struct ptr_ring *ring =3D &q->ring;
> +       struct net_device *dev;
> +       void *ptr;
> +
> +       spin_lock(&ring->consumer_lock);
> +
> +       ptr =3D __ptr_ring_consume(ring);
> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1))) {
> +               rcu_read_lock();
> +               dev =3D rcu_dereference(q->tap)->dev;
> +               netif_wake_subqueue(dev, q->queue_index);
> +               rcu_read_unlock();
> +       }
> +
> +       spin_unlock(&ring->consumer_lock);
> +
> +       return ptr;
> +}
> +
>  static ssize_t tap_do_read(struct tap_queue *q,
>                            struct iov_iter *to,
>                            int noblock, struct sk_buff *skb)
> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
>                                         TASK_INTERRUPTIBLE);
>
>                 /* Read frames from the queue */
> -               skb =3D ptr_ring_consume(&q->ring);
> +               skb =3D tap_ring_consume(q);
>                 if (skb)
>                         break;
>                 if (noblock) {
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8192740357a0..7148f9a844a4 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_struct *tu=
n,
>         return total;
>  }
>
> +static void *tun_ring_consume(struct tun_file *tfile)
> +{
> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> +       struct net_device *dev;
> +       void *ptr;
> +
> +       spin_lock(&ring->consumer_lock);
> +
> +       ptr =3D __ptr_ring_consume(ring);
> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1))) {

I guess it's the "bug" I mentioned in the previous patch that leads to
the check of __ptr_ring_consume_created_space() here. If it's true,
another call to tweak the current API.

> +               rcu_read_lock();
> +               dev =3D rcu_dereference(tfile->tun)->dev;
> +               netif_wake_subqueue(dev, tfile->queue_index);

This would cause the producer TX_SOFTIRQ to run on the same cpu which
I'm not sure is what we want.

> +               rcu_read_unlock();
> +       }

Btw, this function duplicates a lot of logic of tap_ring_consume() we
should consider to merge the logic.

> +
> +       spin_unlock(&ring->consumer_lock);
> +
> +       return ptr;
> +}
> +
>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err=
)
>  {
>         DECLARE_WAITQUEUE(wait, current);
>         void *ptr =3D NULL;
>         int error =3D 0;
>
> -       ptr =3D ptr_ring_consume(&tfile->tx_ring);
> +       ptr =3D tun_ring_consume(tfile);

I'm not sure having a separate patch like this may help. For example,
it will introduce performance regression.

>         if (ptr)
>                 goto out;
>         if (noblock) {
> @@ -2131,7 +2152,7 @@ static void *tun_ring_recv(struct tun_file *tfile, =
int noblock, int *err)
>
>         while (1) {
>                 set_current_state(TASK_INTERRUPTIBLE);
> -               ptr =3D ptr_ring_consume(&tfile->tx_ring);
> +               ptr =3D tun_ring_consume(tfile);
>                 if (ptr)
>                         break;
>                 if (signal_pending(current)) {
> --
> 2.43.0
>

Thanks

