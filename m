Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DEC1DDE9
	for <virtualization@lists.linux.dev>; Sat, 11 May 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715398738; cv=none; b=Gem4YuGlgQK6pbFtDYt6svkWMSwk0au5uSxU9/dsfsQORguSjga3ne1UvoUHF+yDYKN4fh94quERUuvwpul6EBPUWf32V5sGkmmFBic9o94yxW8UTtR0bFyENzaswI60x24mBhZn5xWWC+C6y0slaaIw2gDwLUfXF17XRHnMgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715398738; c=relaxed/simple;
	bh=rYUj3aHDAjTWCO3zmRdQgFYArGOHZewr+0dPdqdJQMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/6GoxzzDJ7uLlf28Yq7qzYrNIu7rJAau99bxCuCY75qNZJimH7HCZKBWqb0nSjr+tNC1fT5WfplxYa1EVQkvsWRwY7wcUcz9RnLAQH4oVleRLRRa7o0oia0UGKcESihCRAWSVm9D80ZoJHkBFfD+CK4fYXp6I3ylIPKSQXymAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U43XiFZ/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U43XiFZ/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so2826209e87.3
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715398735; x=1716003535; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMwJyrS69aBB/AIHg+ejA8vPPkzSH95eVzoKFAGJIhI=;
        b=U43XiFZ/TZV6sSc5Ty6VMAaPIw6MA9zXCTDBFleeQqfzsSP1BA6zHjYrDJTjLoHUCm
         CvddCGFTnhYN1i9qjq4T3qpzWWmq4Ob5oqNCojvJkFiXeatD9A/5ST2HepJGloqtQlz2
         DAtb+vrzn23VXEDI9n/tOHFmIzkBlI7G1VrmSiVBpTc9p6NKl9KiBUlJN5+IZ284z0pp
         jOMtdICYV7ToNkbxIhIzbkDWmFEK/nnqGsRRqpy8WuS1lm/GgZqk6xKoU2LcQCzUwYlh
         9iUvYYhm+IyyIXn6SkuN4mHjIYmCUyz125oeT1Q9ghNAgNQoqkYDBFqIS4Laein3Rb+A
         Rh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715398735; x=1716003535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMwJyrS69aBB/AIHg+ejA8vPPkzSH95eVzoKFAGJIhI=;
        b=e0i6uzgoc1MNK4MnYh4Ewjzf7sS4qJqS0cSl2TKEdjMDZ6cDQPS6Y7jnsPiyhTgRLZ
         djNc+hxtjN1FRAjWKS5Pu5soo1eHEHbhHLeFok2hNVICvFLst6abevHHLWub7FQNDkq/
         /SHeXE6u+uJNZluZt6GTotsTtclNutEX7aSEQn9IRBocpoLqYP067sehnKqY/Q+ZIgq9
         Tn/JeIZPmtZ+HOkenKfkLwfhIWLPNaXNlRh6Wr2O0I5P0zDrHKN7P3eyNo4Bui6lACh+
         yEYiXcwnsUMmozY4fJdypIY7U9cXl3tUA5MMrTSeDc82Ci+otcwJQVEe02RtfSgoNhnB
         9v/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgH3zydkJvHb9ZQL9ErHSrriazwsOPt22s9DHH15h5n6O6FTMVA7E9FCduLsPC/LZ3vDK2FwGwjGVSfNJ76QVDR9uk9IJKslkxgb1PWMw=
X-Gm-Message-State: AOJu0Yzjzp1Cg6Tn4lx/MDjGUoKsERSi/QeliBKWRLCMD7QqcpJG3whw
	x6Bo+q3pSJXA0S1qirZPlJk5leE2HBbYt53CjxAUTl8hE2vR2CvL2bQnBYHfETjTgE2WLYNW34+
	2G004FAaW2wawNFatWRTchDKo3YU=
X-Google-Smtp-Source: AGHT+IHp03TXfkKPY1+1X+ydJPdmjx3TQTPhvudtPm3tFZLbWL/wLGGLmceTQC3YSFR/Tlea6G2zvZ2FfIAIx7xnuCc=
X-Received: by 2002:a05:6512:4025:b0:521:9315:670 with SMTP id
 2adb3069b0e04-5220fb774eamr3499607e87.9.1715398734995; Fri, 10 May 2024
 20:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240510201927.1821109-1-danielj@nvidia.com> <20240510201927.1821109-3-danielj@nvidia.com>
In-Reply-To: <20240510201927.1821109-3-danielj@nvidia.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 11 May 2024 11:38:18 +0800
Message-ID: <CAL+tcoBRqEyr+4NPDiORJgM4nUzYjeHNZJLDo2K=dAJhKWvz_g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] virtio_net: Add TX stopped and wake counters
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jiri@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 4:20=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> Add a tx queue stop and wake counters, they are useful for debugging.
>
> $ ./tools/net/ynl/cli.py --spec netlink/specs/netdev.yaml \
> --dump qstats-get --json '{"scope": "queue"}'
> ...
>  {'ifindex': 13,
>   'queue-id': 0,
>   'queue-type': 'tx',
>   'tx-bytes': 14756682850,
>   'tx-packets': 226465,
>   'tx-stop': 113208,
>   'tx-wake': 113208},
>  {'ifindex': 13,
>   'queue-id': 1,
>   'queue-type': 'tx',
>   'tx-bytes': 18167675008,
>   'tx-packets': 278660,
>   'tx-stop': 8632,
>   'tx-wake': 8632}]
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

> ---
>  drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 218a446c4c27..df6121c38a1b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -95,6 +95,8 @@ struct virtnet_sq_stats {
>         u64_stats_t xdp_tx_drops;
>         u64_stats_t kicks;
>         u64_stats_t tx_timeouts;
> +       u64_stats_t stop;
> +       u64_stats_t wake;
>  };
>
>  struct virtnet_rq_stats {
> @@ -145,6 +147,8 @@ static const struct virtnet_stat_desc virtnet_rq_stat=
s_desc[] =3D {
>  static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] =3D =
{
>         VIRTNET_SQ_STAT_QSTAT("packets", packets),
>         VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
> +       VIRTNET_SQ_STAT_QSTAT("stop",    stop),
> +       VIRTNET_SQ_STAT_QSTAT("wake",    wake),
>  };
>
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] =3D =
{
> @@ -1014,6 +1018,9 @@ static void check_sq_full_and_disable(struct virtne=
t_info *vi,
>          */
>         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>                 netif_stop_subqueue(dev, qnum);
> +               u64_stats_update_begin(&sq->stats.syncp);
> +               u64_stats_inc(&sq->stats.stop);
> +               u64_stats_update_end(&sq->stats.syncp);
>                 if (use_napi) {
>                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
))
>                                 virtqueue_napi_schedule(&sq->napi, sq->vq=
);
> @@ -1022,6 +1029,9 @@ static void check_sq_full_and_disable(struct virtne=
t_info *vi,
>                         free_old_xmit(sq, false);
>                         if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
>                                 netif_start_subqueue(dev, qnum);
> +                               u64_stats_update_begin(&sq->stats.syncp);
> +                               u64_stats_inc(&sq->stats.wake);
> +                               u64_stats_update_end(&sq->stats.syncp);
>                                 virtqueue_disable_cb(sq->vq);
>                         }
>                 }
> @@ -2322,8 +2332,14 @@ static void virtnet_poll_cleantx(struct receive_qu=
eue *rq)
>                         free_old_xmit(sq, true);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -               if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> +               if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> +                       if (netif_tx_queue_stopped(txq)) {
> +                               u64_stats_update_begin(&sq->stats.syncp);
> +                               u64_stats_inc(&sq->stats.wake);
> +                               u64_stats_update_end(&sq->stats.syncp);
> +                       }
>                         netif_tx_wake_queue(txq);
> +               }
>
>                 __netif_tx_unlock(txq);
>         }
> @@ -2473,8 +2489,14 @@ static int virtnet_poll_tx(struct napi_struct *nap=
i, int budget)
>         virtqueue_disable_cb(sq->vq);
>         free_old_xmit(sq, true);
>
> -       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> +       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> +               if (netif_tx_queue_stopped(txq)) {
> +                       u64_stats_update_begin(&sq->stats.syncp);
> +                       u64_stats_inc(&sq->stats.wake);
> +                       u64_stats_update_end(&sq->stats.syncp);
> +               }
>                 netif_tx_wake_queue(txq);
> +       }
>
>         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
>
> @@ -4790,6 +4812,8 @@ static void virtnet_get_base_stats(struct net_devic=
e *dev,
>
>         tx->bytes =3D 0;
>         tx->packets =3D 0;
> +       tx->stop =3D 0;
> +       tx->wake =3D 0;
>
>         if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
>                 tx->hw_drops =3D 0;
> --
> 2.45.0
>
>
