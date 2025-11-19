Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41602D7814
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Nov 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520997; cv=none; b=lGAb5qVpLCaQL2uGukXZR2MxjsHUBTUUy4bjW/17lC1As85jLK7jkbo9m2rx2zqnw5Mgb6kxQ4BBp2ZRO0Lvhg0Xs+QgElrd7JlYYbzxBEgn3eYCPS9iGpZoeD7TE4Ok8C23ZAjMtvhkYbMRfndAr6LaWBkolo2lFN4npfq9fFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520997; c=relaxed/simple;
	bh=G12hxObS9vVdQSHOVQsEwJdya84pJfSeHUQ2pXezb/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQxcBHT2qF8wyOuJZTXat3pkJWrYN67mNI/aSMtL4StA5xIFJwJlybcHLzsS0DyrS4CzEEuo/djvsToHDtyV81jgch2kJ+QorXsh56Xm4QwdhMsX4SQ8/B9yZZBx8UxqmY48OEE9D7h82iQDDjJb/0J/uxesPLvktG6kKKPlbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsz7qVHw; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsz7qVHw"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E74961BBF
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Nov 2025 02:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3LXlVWf-WXXE for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Nov 2025 02:56:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 157D061B80
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 157D061B80
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dsz7qVHw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 157D061B80
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Nov 2025 02:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763520992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDvPTx8od/LRicGRV59Ci5CqBppmh/yq9CH+cOE9Xiw=;
	b=dsz7qVHw9C3W8GO2xcE9wkLwabbmpZ9EAmM9paEYPbRJGY3y0JwEks/PAkp8pz4ECp+k/P
	o96fGsYaICUgkDQqXcU7H5DM+8WUII/aCA7OV+CWcAOeK4GIh+bVHFOErXOP+pUTlldWg0
	Y2DHuqjR4CfS6/cqWyPmXhZ+q0z7BZc=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-PQ-USjQkMOucwiDppPgC9A-1; Tue, 18 Nov 2025 21:56:30 -0500
X-MC-Unique: PQ-USjQkMOucwiDppPgC9A-1
X-Mimecast-MFC-AGG-ID: PQ-USjQkMOucwiDppPgC9A_1763520990
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5dfb62a866eso15910908137.2
        for <virtualization@lists.linux-foundation.org>; Tue, 18 Nov 2025 18:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520990; x=1764125790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDvPTx8od/LRicGRV59Ci5CqBppmh/yq9CH+cOE9Xiw=;
        b=i8XuW8eBDUZ2E93tdfaEnn7ye1DhSUqtQJic7As6U5eQG+Wcwi0eeS0FKBQb3xrJzx
         xw+RAyTwmHSByPLQ2uR7GxN/j4vL8ZYQkAqvK0W5Wh0EdJ3PQtJ1F5nx71/+fd7WeU0/
         Owc5X7lmP43h64FozLW5NaeoqCaR3W1MvQMpYi6BDSVavtkX0RmZKjZqzMUFMR860aJm
         9s7CoSUrYpIPyU7v++VahDsdT1gLzyZyUc5LQ5Cx8kgCHSituPsvkfji3mJz0imuaEy2
         QUiwMSF0I/SaZUdEllc9LcKbTTq3L+A/4boEUoR8Z5pWtLXn+bTM7h9Prtm9js5GxYrf
         AyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9ksdTbHh4Owk0ljdmjzSHf2grX5bW4bSNjN+VKasdeuoxmxVUNCSLd/cD11HE8og0GnfyL5pMsBRtRrulWg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YymmUA1gV0O6lOiYF70z7COt9t6h/Wu435kqC+Gcj6XzsIA+fmg
	EceUeZlQBhLLUD60wb8wVHgUxPrNJmDQFhuBsWCMKAtGHC+wb+QqseL7XzXIdQQl5aFTSH3ujjW
	xKk3z9JuegQuhoqf2JVbo3/MGdPUOz8cHaRpdNYjxiVDVrf554/4RyxwQwEtmzBoeAwhmTZWdbU
	nTsspIIFk+aU9MrkPjBDvC3e5R8AP3T0avtrUcFuxt5dxQkr8ITaTWhvzSMw==
X-Gm-Gg: ASbGnctdPuyccmHtm3JsA2E8hretD1vS2o0xaJuBZY15Sl9AKKg1ewl1BWoT1h6iuYh
	fbG9ThX/hwl2ah2qnnMx5c2IsoftKo0MF7hagfUFLtxXdBehMAg2xyQKosGXx5HfeaBSte1ahTX
	NAWYXdCe0XinBx0BHrmBQ/PBg8UWbhda9Sij90sQ4toLxa3UcTsEfZ/Ek0VkdhE3U=
X-Received: by 2002:a05:6102:e0a:b0:5db:ef3f:6c7d with SMTP id ada2fe7eead31-5dfc5556bf8mr6112209137.14.1763520990178;
        Tue, 18 Nov 2025 18:56:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMHvc8TbnsY8T2F+eiw7C0cSgj9lMpJACXTR8AzjwZ2GrCglhiRk/Pmo0QAEu0HhMJS9z+SDjksvQGpkSmyfk=
X-Received: by 2002:a05:6102:e0a:b0:5db:ef3f:6c7d with SMTP id
 ada2fe7eead31-5dfc5556bf8mr6112195137.14.1763520989781; Tue, 18 Nov 2025
 18:56:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251118090942.1369-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20251118090942.1369-1-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 10:56:17 +0800
X-Gm-Features: AWmQ_bmKFv4JLlor4jL7WLrkrIdgod9abx7FeAA8sB4t9HbQcF1R97xzgCvVagE
Message-ID: <CACGkMEvwedzRrMd9hYm7PbDezBu1GM3q-YcUhsvfYJVv=bNSdw@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: enhance wake/stop tx queue statistics accounting
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zDg6FWEDmqMcAJNlvCTi50_RbQmXc6U6tbt0lEdlChM_1763520990
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 5:10=E2=80=AFPM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> This patch refines and strengthens the statistics collection of TX queue
> wake/stop events introduced by a previous patch.

It would be better to add commit id here.

>
> Previously, the driver only recorded partial wake/stop statistics
> for TX queues. Some wake events triggered by 'skb_xmit_done()' or resume
> operations were not counted, which made the per-queue metrics incomplete.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  drivers/net/virtio_net.c | 49 ++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..f92a90dde2b3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -775,10 +775,26 @@ static bool virtqueue_napi_complete(struct napi_str=
uct *napi,
>         return false;
>  }
>
> +static void virtnet_tx_wake_queue(struct virtnet_info *vi,
> +                               struct send_queue *sq)
> +{
> +       unsigned int index =3D vq2txq(sq->vq);
> +       struct netdev_queue *txq =3D netdev_get_tx_queue(vi->dev, index);
> +
> +       if (netif_tx_queue_stopped(txq)) {
> +               u64_stats_update_begin(&sq->stats.syncp);
> +               u64_stats_inc(&sq->stats.wake);
> +               u64_stats_update_end(&sq->stats.syncp);
> +               netif_tx_wake_queue(txq);
> +       }
> +}
> +
>  static void skb_xmit_done(struct virtqueue *vq)
>  {
>         struct virtnet_info *vi =3D vq->vdev->priv;
> -       struct napi_struct *napi =3D &vi->sq[vq2txq(vq)].napi;
> +       unsigned int index =3D vq2txq(vq);
> +       struct send_queue *sq =3D &vi->sq[index];
> +       struct napi_struct *napi =3D &sq->napi;
>
>         /* Suppress further interrupts. */
>         virtqueue_disable_cb(vq);
> @@ -786,8 +802,7 @@ static void skb_xmit_done(struct virtqueue *vq)
>         if (napi->weight)
>                 virtqueue_napi_schedule(napi, vq);
>         else
> -               /* We were probably waiting for more output buffers. */
> -               netif_wake_subqueue(vi->dev, vq2txq(vq));
> +               virtnet_tx_wake_queue(vi, sq);
>  }
>
>  #define MRG_CTX_HEADER_SHIFT 22
> @@ -1166,10 +1181,7 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>                         /* More just got used, free them then recheck. */
>                         free_old_xmit(sq, txq, false);
>                         if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2) {
> -                               netif_start_subqueue(dev, qnum);
> -                               u64_stats_update_begin(&sq->stats.syncp);
> -                               u64_stats_inc(&sq->stats.wake);
> -                               u64_stats_update_end(&sq->stats.syncp);
> +                               virtnet_tx_wake_queue(vi, sq);

This is suspicious, netif_tx_wake_queue() will schedule qdisc, or is
this intended?

>                                 virtqueue_disable_cb(sq->vq);
>                         }
>                 }
> @@ -3068,13 +3080,8 @@ static void virtnet_poll_cleantx(struct receive_qu=
eue *rq, int budget)
>                         free_old_xmit(sq, txq, !!budget);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -               if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2 &&
> -                   netif_tx_queue_stopped(txq)) {
> -                       u64_stats_update_begin(&sq->stats.syncp);
> -                       u64_stats_inc(&sq->stats.wake);
> -                       u64_stats_update_end(&sq->stats.syncp);
> -                       netif_tx_wake_queue(txq);
> -               }
> +               if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2)
> +                       virtnet_tx_wake_queue(vi, sq);
>
>                 __netif_tx_unlock(txq);
>         }
> @@ -3264,13 +3271,8 @@ static int virtnet_poll_tx(struct napi_struct *nap=
i, int budget)
>         else
>                 free_old_xmit(sq, txq, !!budget);
>
> -       if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2 &&
> -           netif_tx_queue_stopped(txq)) {
> -               u64_stats_update_begin(&sq->stats.syncp);
> -               u64_stats_inc(&sq->stats.wake);
> -               u64_stats_update_end(&sq->stats.syncp);
> -               netif_tx_wake_queue(txq);
> -       }
> +       if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2)
> +               virtnet_tx_wake_queue(vi, sq);
>
>         if (xsk_done >=3D budget) {
>                 __netif_tx_unlock(txq);
> @@ -3521,6 +3523,9 @@ static void virtnet_tx_pause(struct virtnet_info *v=
i, struct send_queue *sq)
>
>         /* Prevent the upper layer from trying to send packets. */
>         netif_stop_subqueue(vi->dev, qindex);
> +       u64_stats_update_begin(&sq->stats.syncp);
> +       u64_stats_inc(&sq->stats.stop);
> +       u64_stats_update_end(&sq->stats.syncp);
>
>         __netif_tx_unlock_bh(txq);
>  }
> @@ -3537,7 +3542,7 @@ static void virtnet_tx_resume(struct virtnet_info *=
vi, struct send_queue *sq)
>
>         __netif_tx_lock_bh(txq);
>         sq->reset =3D false;
> -       netif_tx_wake_queue(txq);
> +       virtnet_tx_wake_queue(vi, sq);
>         __netif_tx_unlock_bh(txq);
>
>         if (running)
> --
> 2.34.1
>

Thanks

