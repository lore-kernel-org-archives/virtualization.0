Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C02D8DB9
	for <virtualization@lists.linux.dev>; Sun,  4 Jan 2026 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767506967; cv=none; b=fD/Qj5VeiR0SdyH8GCJsnqRiO8tjmSx7NQu4OeyvkJR3Dv2l88OXbQ7Ck3Grcp8WZ1JAA4eCm1m+usQiMkwtKSzFFZef/GitQ5Ml8qjRYV3C/in5gtqbf0J802wzrT4JL/QOW0vgBgi+ZVARKeniAvg0D7R3qnYpdQP5t0kuoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767506967; c=relaxed/simple;
	bh=d62UFEnU7fCkorQZkkR3CJODcl+iqve4VXrymJhCGPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlenEUKh3VXeM1IMlRsdEq2bLCSnT7AgarXLRlJWHd0KDxRbzopA8MBgwFOZhxVgjqLJ3KJCrDqucJRc+unUk+ZFOZNx7ozy9mso1hhUQgBjty/X7KccrVew9nAKAyeT7GH/zcPv+1GlJC+mFa5S9lb89q0M7RXFL218/OghPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIEz5bEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIEz5bEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767506963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJExj1wMdLs7y98GZ9+oLjZ8HntohnFo3s2nmuYpgMU=;
	b=BIEz5bEnNnrf4XsgR4i3vxwIp5B2yNI2R0yEG/I/vmyhs1xDFTa6iVqLkZfhnnCYbpCNds
	AfpsUAZwt1RjXSBcmO5rbBo+q8Wzg0ATYR3ytZHG04JXbjpl49yFa75dNBsyNKi5RIGMjK
	vx9wbr3L+HFgI/WEKHLp6Gfb7Izq/qM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-DTK7w3RhP-ueGywGl62Tww-1; Sun, 04 Jan 2026 01:09:19 -0500
X-MC-Unique: DTK7w3RhP-ueGywGl62Tww-1
X-Mimecast-MFC-AGG-ID: DTK7w3RhP-ueGywGl62Tww_1767506958
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c5d203988so28754302a91.3
        for <virtualization@lists.linux.dev>; Sat, 03 Jan 2026 22:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767506958; x=1768111758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJExj1wMdLs7y98GZ9+oLjZ8HntohnFo3s2nmuYpgMU=;
        b=H179NDLYIJ5jNF5ObMZwWCfqoEmk7hSJpMBYO/VZ5cEJSKPIXj4cN7GDAkld9Pu9qZ
         nvVyRvRz11Wg4/17XtC5WfrmX8dVyCjQdh1TC+QGvx9Y88BAy4u7gHMN6yQF+k9WOA+w
         GqV4v45+UFYZV1irMeLxpNbXRhq78BwPYthEbuEzoSXV/C26eH3wQUrvn0Deq/x04b7J
         Z6MysPGbm/+rnhcKsQV9VsrCXqH38wG6W1bUcYx6POr1aep7nbuuG49O5sFgV785qtf8
         brpt7R6LV/yggYoqpqL4KriPLUq7jC/wUH93I7eBk8ioSudnVyk8kwIIK3WJYZTp9AhH
         q8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGgRKPb7o06KAnp377H3OE0epLQBcUgfNxL4wLmIUzH+7LOXtEs1iyCHuCurlo+0TCnKAiPeWj6d1Qvn8HjA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5PUjwBMP+hogn2SSfoMgFJyqcYF/ZS9pVuUWeVp9eeCTTZMNv
	psgpYvALC0hlUkXrRS1bVAIxVgpjfdiE+645bxpIeMx7o6E6gPA/y0fTcQ8KgnQXJ20eyXq7ucq
	aOVLTezIFaNFghVg5g0dnP/twnsl1wnWY1MVrxq4vNPSTlE/RdrjBheJ3pnVxRE+6dI2PmVf499
	X3yHMl48F1TJtBgXoKhBYJTxSGgmOJcHMMcJdmpKgIY2M=
X-Gm-Gg: AY/fxX5S8P+EBN+8kdiw2c3AWWPD7c9suLWOlis5FNb21e+IA1AT9fT1OwZ11K5NrGE
	1PLIHrGwQs0ZR+Jj3j20OYwtHMcMUQ6vYxNm71SeE4T7IXxqVO6Wr+6+Df+CLQQHpGnbVcFZ+on
	/dI7Tb8SCWlu+vkK01SG1ntQZqr6V2xUJ4yxiI4K/5ipT5NoZUmuHzSOsYO+JhLL0=
X-Received: by 2002:a17:90b:2804:b0:339:a243:e96d with SMTP id 98e67ed59e1d1-34e921f7bb8mr34964887a91.36.1767506958554;
        Sat, 03 Jan 2026 22:09:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1TrnHOaObWiDYx4VRiV588ZpfCmQ2a6hTaoJiRv90CvgOiEyCA+WPpxYK2SDPSu+eSM2BKeUX90AdzmAJQvU=
X-Received: by 2002:a17:90b:2804:b0:339:a243:e96d with SMTP id
 98e67ed59e1d1-34e921f7bb8mr34964869a91.36.1767506958105; Sat, 03 Jan 2026
 22:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260102152023.10773-1-minhquangbui99@gmail.com> <20260102152023.10773-2-minhquangbui99@gmail.com>
In-Reply-To: <20260102152023.10773-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Jan 2026 14:09:06 +0800
X-Gm-Features: AQt7F2roE9LpNfzF8c2KtQ4VSRlYXoi2Mx29Nbq8m5ARZMNVXphPDvutIIePn_4
Message-ID: <CACGkMEs9wCM8s4_r1HCQGj9mUDdTF+BqkF0rse+dzB3USprhMA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill worker
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l4IxL_sAAq6TQ8bSTOcOcFhQLsQ36FTd2mLxsxUEhAA_1767506958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 11:20=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> When we fail to refill the receive buffers, we schedule a delayed worker
> to retry later. However, this worker creates some concurrency issues
> such as races and deadlocks. To simplify the logic and avoid further
> problems, we will instead retry refilling in the next NAPI poll.
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx"=
)
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results=
/400961/3-xdp-py/stderr
> Cc: stable@vger.kernel.org
> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..ac514c9383ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_i=
nfo *vi,
>  }
>
>  static int virtnet_receive(struct receive_queue *rq, int budget,
> -                          unsigned int *xdp_xmit)
> +                          unsigned int *xdp_xmit, bool *retry_refill)
>  {
>         struct virtnet_info *vi =3D rq->vq->vdev->priv;
>         struct virtnet_rq_stats stats =3D {};
> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *r=
q, int budget,
>                 packets =3D virtnet_receive_packets(vi, rq, budget, xdp_x=
mit, &stats);
>
>         if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vr=
ing_size(rq->vq)) / 2) {
> -               if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -                       spin_lock(&vi->refill_lock);
> -                       if (vi->refill_enabled)
> -                               schedule_delayed_work(&vi->refill, 0);
> -                       spin_unlock(&vi->refill_lock);
> -               }
> +               if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +                       *retry_refill =3D true;
>         }
>
>         u64_stats_set(&stats.packets, packets);
> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi,=
 int budget)
>         struct send_queue *sq;
>         unsigned int received;
>         unsigned int xdp_xmit =3D 0;
> -       bool napi_complete;
> +       bool napi_complete, retry_refill =3D false;
>
>         virtnet_poll_cleantx(rq, budget);
>
> -       received =3D virtnet_receive(rq, budget, &xdp_xmit);
> +       received =3D virtnet_receive(rq, budget, &xdp_xmit, &retry_refill=
);

I think we can simply let virtnet_receive() to return the budget when
reill fails.

>         rq->packets_in_napi +=3D received;
>
>         if (xdp_xmit & VIRTIO_XDP_REDIR)
>                 xdp_do_flush();
>
>         /* Out of packets? */
> -       if (received < budget) {
> +       if (received < budget && !retry_refill) {
>                 napi_complete =3D virtqueue_napi_complete(napi, rq->vq, r=
eceived);
>                 /* Intentionally not taking dim_lock here. This may resul=
t in a
>                  * spurious net_dim call. But if that happens virtnet_rx_=
dim_work
> @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, i=
nt budget)
>                 virtnet_xdp_put_sq(vi, sq);
>         }
>
> -       return received;
> +       return retry_refill ? budget : received;
>  }
>
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex)
> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 if (i < vi->curr_queue_pairs)
> -                       /* Make sure we have some buffers: if oom use wq.=
 */
> -                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -                               schedule_delayed_work(&vi->refill, 0);
> +                       /* If this fails, we will retry later in
> +                        * NAPI poll, which is scheduled in the below
> +                        * virtnet_enable_queue_pair
> +                        */
> +                       try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);

Consider NAPI will be eventually scheduled, I wonder if it's still
worth to refill here.

>
>                 err =3D virtnet_enable_queue_pair(vi, i);
>                 if (err < 0)
> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_in=
fo *vi,
>                                 bool refill)
>  {
>         bool running =3D netif_running(vi->dev);
> -       bool schedule_refill =3D false;
>
> -       if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -               schedule_refill =3D true;
> +       if (refill)
> +               /* If this fails, we will retry later in NAPI poll, which=
 is
> +                * scheduled in the below virtnet_napi_enable
> +                */
> +               try_fill_recv(vi, rq, GFP_KERNEL);

and here.

> +
>         if (running)
>                 virtnet_napi_enable(rq);
> -
> -       if (schedule_refill)
> -               schedule_delayed_work(&vi->refill, 0);
>  }
>
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *=
vi, u16 queue_pairs)
>         struct virtio_net_rss_config_trailer old_rss_trailer;
>         struct net_device *dev =3D vi->dev;
>         struct scatterlist sg;
> +       int i;
>
>         if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ=
))
>                 return 0;
> @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info=
 *vi, u16 queue_pairs)
>         }
>  succ:
>         vi->curr_queue_pairs =3D queue_pairs;
> -       /* virtnet_open() will refill when device is going to up. */
> -       spin_lock_bh(&vi->refill_lock);
> -       if (dev->flags & IFF_UP && vi->refill_enabled)
> -               schedule_delayed_work(&vi->refill, 0);
> -       spin_unlock_bh(&vi->refill_lock);
> +       if (dev->flags & IFF_UP) {
> +               /* Let the NAPI poll refill the receive buffer for us. We=
 can't
> +                * safely call try_fill_recv() here because the NAPI migh=
t be
> +                * enabled already.
> +                */
> +               local_bh_disable();
> +               for (i =3D 0; i < vi->curr_queue_pairs; i++)
> +                       virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i=
].vq);
> +
> +               local_bh_enable();
> +       }
>
>         return 0;
>  }
> --
> 2.43.0
>

Thanks

