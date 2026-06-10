Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C065E3A7D81
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080092; cv=none; b=lJtaUQTeLiNsC9cH0ep5yIoQOXbZpIIJRSCcI2FEoHq3PXwg472bUgpyXMC4lfpNt/AQnfO4oW1piIuq4Gn5dXfaALyJyoiBak/w302Vls/4ZsFBRwIZryM/4LMX/FM6qdbb1lhl70zc92C79j8WQ8eHwR49IguI9aBychNNDYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080092; c=relaxed/simple;
	bh=gNELbO8qe9PmTJbD0VSp0KcGVTlNaeuYAPwDbT//UMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2cRLunzOk2laZCo9R5KuRJufxkb+tPpOsMip8+v7QNYbuJYVjFOEjTKAV3PxuDbQh65uw5eMHFU/YGZ7A3R7e2bCbW2/DIEFKC3AS93UeI26PUVjGnjES6eEyLTV37us49y7jmnK1HWRsVrwyxCmPdP3anM86YCpycqVBQ5VHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmYZfYH0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmYZfYH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781080088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB8F8zX7dRu2b8YaeiMKfygD+Y+62k1+ixQsacU6UGQ=;
	b=AmYZfYH0BF2Al6FwOQOnF8bI71GFK9azODqtH3bGDYT4pRVW6xLU1vOuqSA5hs9V0gZvys
	3JZSAZhKRVYe3jlL4+DmUB8f0klPGJrKSxSRhyUWYlvqH3OUVGKVz2Z2MrwDhUHVe7ws2d
	qnFXor9oVRrA/xEL4MBLsxLrVZjOcZw=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-KG1HmjIIPiSqIx9H1Rh2Vg-1; Wed, 10 Jun 2026 04:28:07 -0400
X-MC-Unique: KG1HmjIIPiSqIx9H1Rh2Vg-1
X-Mimecast-MFC-AGG-ID: KG1HmjIIPiSqIx9H1Rh2Vg_1781080087
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-660668ea5cdso4982343d50.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 01:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080087; x=1781684887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZB8F8zX7dRu2b8YaeiMKfygD+Y+62k1+ixQsacU6UGQ=;
        b=RB5HB+buKQT8Y2Dyf96pOV05JbU11lGP+S0IL3n0UFFyJ9A/skJeS+N37Ubi1cHwO4
         nVVkX2XoJ546pWsQ7CRcqf8l1GdRe++oQSpCChgvoyvJToIL7Yp/VrbAyJe5LDE/kbXk
         9mBu0eAXclQKp26aN6c3Q2QUyhrZYqo/r4UIO8TqEJ49RlLWeCvRKPhxzeXb/6LlOInN
         aJVYaNs/cKi2L+41fr637h7di0iJ6OXUMYosH58MZewO0tlJmTkDT+5154T6yk1i7kDv
         cmfCbihuKcL9c1zclPeLS5UVQuG6q7ioCZiYbevcy9raTUjtrCZfjIT2DJoraSOqkgr6
         o8Mw==
X-Forwarded-Encrypted: i=1; AFNElJ8ns9oReUZByyoxMHTimi/Q+l/aXcwit29G0VFjQdxfAu1dZvDok/u6/BJA9/E3ryW0CKUlAQo+sMsy/Au0UQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0cQhuxgrexSPevoQI8qF0RA18fFTXdQGffWyB7UsIvwa/q9e+
	4tcOKIPMUDnSmgFET1PC6s0nCaQKBltN7DFWsNnJlHlcVLTpllx3sSdzx240LQCnCi9clpKDr/F
	qhLJN1d9pPfb5bLf1aI/7fovPufLrPzgDBAp0MMbEToxgZQK8rf8ouPzcCS6TWLDNZstG1pk6ht
	cljG+9HFzVkiVubDSn4uDBv8Ss40IC8WzTHUGnAxuf6is=
X-Gm-Gg: Acq92OGSFn59Z77DlJX6p3bz/dfi3CyG85wWVVVValQX4tocoijCJmXecBvEwYwfzuX
	ifQSdtGf6OZGSBaCYq4peQ79h9bhmcUGIL+wWYJlQSzsw7gQ857L/8Juj3hBOqNFebOE1EcYKky
	D+0SPR0lzAZEu9SOor6wksGBq+mhnQNdJ0K3DGAOlz9+qTnismYf312MjAiIPBtaC78exBY4Pt2
	Ze+aLfaw/iIvL8/
X-Received: by 2002:a05:690e:1242:b0:660:74f5:7e19 with SMTP id 956f58d0204a3-66106942890mr20633074d50.0.1781080086801;
        Wed, 10 Jun 2026 01:28:06 -0700 (PDT)
X-Received: by 2002:a05:690e:1242:b0:660:74f5:7e19 with SMTP id
 956f58d0204a3-66106942890mr20633037d50.0.1781080086202; Wed, 10 Jun 2026
 01:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 10 Jun 2026 10:27:28 +0200
X-Gm-Features: AVVi8CcfYFsKQnOe4E8gEOU8WNwyNAYJQQd-Lf6-GzdkgBEZs4Y0nsc-FVAqBQ4
Message-ID: <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: liz_VY_MCrn_h0eh_dVjBPaowTqhuVs7d1bGvxYYutk_1781080087
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net=
.
> Take the tx path for example, we set xsk_set_tx_need_wakeup() in
> virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> anywhere, which means the user will call send() for every packet.
>
> For the tx path, we will call xsk_set_tx_need_wakeup() after
> virtnet_xsk_xmit_batch() if sq->vq is empty, as we can't be wakeup by the
> skb_xmit_done() in this case. Otherwise, we will clear the wakeup flag.
>
> For the rx path, we will call xsk_set_rx_need_wakeup() if we have free
> buffers in rq->vq.
>
> Race condition is considered for both rx and tx path.
>

I didn't review the code itself, but the patch message lacks a Fixes:
tag. And the From and Signed-off-by emails don't match, which I'm not
sure is valid.

> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/virtio_net.c | 52 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9b3da9f9786c..25e895b849a6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet=
_info *vi, struct receive_queue
>                                    struct xsk_buff_pool *pool, gfp_t gfp)
>  {
>         struct xdp_buff **xsk_buffs;
> +       bool need_wakeup;
>         dma_addr_t addr;
>         int err =3D 0;
>         u32 len, i;
>         int num;
>
> +       need_wakeup =3D xsk_uses_need_wakeup(pool);
>         xsk_buffs =3D rq->xsk_buffs;
>
> +       /* If both rq->vq and fill ring are empty, and then the user subm=
it
> +        * all the chunks to the fill ring and check the wake up flag
> +        * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup=
(),
> +        * we will lose the chance to wake up the rx napi, so we have to
> +        * set the need_wakeup flag here.
> +        */
> +       if (need_wakeup && virtqueue_get_vring_size(rq->vq) =3D=3D rq->vq=
->num_free)
> +               xsk_set_rx_need_wakeup(pool);
> +
>         num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>         if (!num) {
> -               if (xsk_uses_need_wakeup(pool)) {
> +               if (need_wakeup) {
>                         xsk_set_rx_need_wakeup(pool);
>                         /* Return 0 instead of -ENOMEM so that NAPI is
>                          * descheduled.
> @@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_i=
nfo *vi, struct receive_queue
>                 }
>
>                 return -ENOMEM;
> -       } else {
> -               xsk_clear_rx_need_wakeup(pool);
>         }
>
>         len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> @@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_=
info *vi, struct receive_queue
>                         goto err;
>         }
>
> +       if (need_wakeup) {
> +               if (rq->vq->num_free)
> +                       /* We have free buffers, so we'd better wake up t=
he
> +                        * rx napi as soon as possible.
> +                        */
> +                       xsk_set_rx_need_wakeup(pool);
> +               else
> +                       xsk_clear_rx_need_wakeup(pool);
> +       }
> +
>         return num;
>
>  err:
> @@ -1440,8 +1459,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq,=
 struct xsk_buff_pool *pool,
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         struct virtnet_sq_free_stats stats =3D {};
>         struct net_device *dev =3D vi->dev;
> +       int sent, vring_size;
> +       bool need_wakeup;
>         u64 kicks =3D 0;
> -       int sent;
>
>         /* Avoid to wakeup napi meanless, so call __free_old_xmit instead=
 of
>          * free_old_xmit().
> @@ -1451,8 +1471,29 @@ static bool virtnet_xsk_xmit(struct send_queue *sq=
, struct xsk_buff_pool *pool,
>         if (stats.xsk)
>                 xsk_tx_completed(sq->xsk_pool, stats.xsk);
>
> +       vring_size =3D virtqueue_get_vring_size(sq->vq);
> +       need_wakeup =3D xsk_uses_need_wakeup(pool);
> +       /* If the sq->vq is empty, and the tx ring is empty, and the user
> +        * submit an entry to the tx ring after virtnet_xsk_xmit_batch() =
and
> +        * before xsk_set_tx_need_wakeup(), we will lose the chance to wa=
ke
> +        * up the tx napi, so we have to set the need_wakeup flag here.
> +        */
> +       if (need_wakeup && vring_size =3D=3D sq->vq->num_free)
> +               xsk_set_tx_need_wakeup(pool);
> +
>         sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
>
> +       if (need_wakeup) {
> +               if (vring_size =3D=3D sq->vq->num_free)
> +                       /* we can't wake up by ourself, and it should be =
done
> +                        * by the user.
> +                        */
> +                       xsk_set_tx_need_wakeup(pool);
> +               else
> +                       /* we can wake up from skb_xmit_done() */
> +                       xsk_clear_tx_need_wakeup(pool);
> +       }
> +
>         if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
>                 check_sq_full_and_disable(vi, vi->dev, sq);
>
> @@ -1470,9 +1511,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq,=
 struct xsk_buff_pool *pool,
>         u64_stats_add(&sq->stats.xdp_tx,  sent);
>         u64_stats_update_end(&sq->stats.syncp);
>
> -       if (xsk_uses_need_wakeup(pool))
> -               xsk_set_tx_need_wakeup(pool);
> -
>         return sent;
>  }
>
> --
> 2.54.0
>

