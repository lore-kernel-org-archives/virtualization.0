Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA4186A
	for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736741169; cv=none; b=kX7wgQz1I4VIdiVou2B1LYkerFEZtVJnioPlMb+7pYsT1+S18tjr8Oy8vDbbYIkerYuLu3YhxbQBRLVvX2D5zXX+ev815ImGKq0rfsvP1pTOJ5EqP08oKOwfIa9QTDMtiu2ku4mgd0cfUrgHWjXHSy9Ara8LqXsfWC6NLeFnBIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736741169; c=relaxed/simple;
	bh=YZZ9I+l3G7qr3EMipQUJR0fSHci2HaxgX7ZkbidFbrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0C39bWgmVRtXx3L87ZuiURDQminb9L9YgfcZKe+NLvQOV1eemA5GHROWQiZr17OiHIUFw7ZBrnb/upUM002MxdimzyVprpoh8yxo+VznAQMMwgn7iqvtxCqgFqpJ9Rv0WeIbxQIIYklJes+lkKSrpMS5AKC69KsopcRxFfmT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKMZYkPt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKMZYkPt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736741165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZ9KVJCNW1gWH14rRZNf+IonExJW3H1qiVrWM9RW4co=;
	b=UKMZYkPt0JngMWLXgzqlkROSqiVmcIrPaEddMZNbL3egK9o7o73I1+Y4/r2PpCcnG1Wi84
	acDKFVQb6tIZ6Qr23thj57TaLIT4joGzY25yhfwd/jEdeC+OU2w0DZ0Ip+vobtXHL8egWP
	WV7ecVXi8QIds3OadaPIze2ndhdWlZs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-dUrYxQvwMRelCsvAkGimvA-1; Sun, 12 Jan 2025 23:06:04 -0500
X-MC-Unique: dUrYxQvwMRelCsvAkGimvA-1
X-Mimecast-MFC-AGG-ID: dUrYxQvwMRelCsvAkGimvA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef114d8346so6610219a91.0
        for <virtualization@lists.linux.dev>; Sun, 12 Jan 2025 20:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736741163; x=1737345963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ9KVJCNW1gWH14rRZNf+IonExJW3H1qiVrWM9RW4co=;
        b=VaPmDE4m7kjZiuFv1trZAEXCGGNZ8YXc2ifaC9gdO7Yf91i793uu46KIQ2DiMJfudW
         GXOrDXQEa3kh7DzH0rDD1B1/yR+oJimEhwntfELpHH6D/XAg6mJugQsNbxfvcCwewGCg
         cLKPGXdGVPWpDp4iF1TF4ZQgwskXMUld55kqR+A7UIY+fWZkhRuTVIWVH4biaxyJp4VH
         ucvFaLbqS46dGnlxyDTp2i+WDY5qzG8FoF3Swf5B4VG36da330m2IXw3ZCzEHw+1JRMQ
         GWZ18R0JBsZwZ6WDclWTeCDI4Q4T5yRs9LeOQvSYb2feqGTU8VKzvJoBYW834ioXMzZJ
         LfAg==
X-Forwarded-Encrypted: i=1; AJvYcCWcIWilFBHeXAxtgfAFW8nqUXUJywnwjpoo7AelrcFeZJqemf5tR6T+27aWsDj8rwy+B8BVvGgbn8nC4H76cw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkHk0OEq1oLGaX+jhH2zPPWw1wAbvqKvj6PEMdHM1Ipm7fvUwh
	QlXwOm0pL5vhHuGHrmAZIGa2jVsntVtYxYKELoWRM4Po6AgV1n1e4D59D7O+5ZP/at6RXQ+S3e9
	KbQ2jJPizLsURYB8Q6apdUWjGxJkBiXQ7bS95q8ePU5io1CtUkfsvWdmwB4Bqm0xqab/g7sg+Dt
	zzKpPMmddEl8m2WNByHgylyRlG7sk5b/3QfOW3X4U=
X-Gm-Gg: ASbGnctfgbnWYFHRgEwgYKW0EQQsdAt/YHwNCHZ4Rgmlba8vHKM3K1kX8RDgiNAe8xA
	44c433yY5J11LTRXxq+crjG+lkQA+XPckzW/QTGo=
X-Received: by 2002:a17:90b:51cb:b0:2ef:3192:d280 with SMTP id 98e67ed59e1d1-2f548f162acmr26190269a91.5.1736741163607;
        Sun, 12 Jan 2025 20:06:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1A+G5TTiOBCTRJzQQc8LlM21qz/pIEYJLiWzPbeMHcvlPcNaP8l/WEchbVIhmKLEDwqkhau6vUzNiW09UCBo=
X-Received: by 2002:a17:90b:51cb:b0:2ef:3192:d280 with SMTP id
 98e67ed59e1d1-2f548f162acmr26190231a91.5.1736741163106; Sun, 12 Jan 2025
 20:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250110202605.429475-1-jdamato@fastly.com> <20250110202605.429475-4-jdamato@fastly.com>
In-Reply-To: <20250110202605.429475-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jan 2025 12:05:51 +0800
X-Gm-Features: AbW1kvbJjBsqd5MxoROEXNyf-c5A5BV1qq0kCSqjUPSk4kLtr3sC7nlacQgsc78
Message-ID: <CACGkMEtjERF72zkLzDn2OKz3OGkJOQ+FCJS3MRscJqakEz9FYA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ChI8_jP5JUfwib5WM6OwJOZj3aUvec2Dafj9k-kBjMU_1736741164
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 4:26=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4e88d352d3eb..8f0f26cc5a94 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2804,14 +2804,28 @@ static void virtnet_napi_do_enable(struct virtque=
ue *vq,
>  }
>
>  static void virtnet_napi_enable_lock(struct virtqueue *vq,
> -                                    struct napi_struct *napi)
> +                                    struct napi_struct *napi,
> +                                    bool need_rtnl)
>  {
> +       struct virtnet_info *vi =3D vq->vdev->priv;
> +       int q =3D vq2rxq(vq);
> +
>         virtnet_napi_do_enable(vq, napi);
> +
> +       if (q < vi->curr_queue_pairs) {
> +               if (need_rtnl)
> +                       rtnl_lock();

Can we tweak the caller to call rtnl_lock() instead to avoid this trick?

> +
> +               netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, na=
pi);
> +
> +               if (need_rtnl)
> +                       rtnl_unlock();
> +       }
>  }
>
>  static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct=
 *napi)
>  {
> -       virtnet_napi_enable_lock(vq, napi);
> +       virtnet_napi_enable_lock(vq, napi, false);
>  }
>
>  static void virtnet_napi_tx_enable(struct virtnet_info *vi,
> @@ -2848,9 +2862,13 @@ static void refill_work(struct work_struct *work)
>         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
>                 struct receive_queue *rq =3D &vi->rq[i];
>
> +               rtnl_lock();
> +               netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYPE_RX, NU=
LL);
> +               rtnl_unlock();
>                 napi_disable(&rq->napi);

I wonder if it's better to have a helper to do set napi to NULL as
well as napi_disable().

> +
>                 still_empty =3D !try_fill_recv(vi, rq, GFP_KERNEL);
> -               virtnet_napi_enable_lock(rq->vq, &rq->napi);
> +               virtnet_napi_enable_lock(rq->vq, &rq->napi, true);
>
>                 /* In theory, this can happen: if we don't get any buffer=
s in
>                  * we will *never* try to fill again.
> @@ -3048,6 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi, i=
nt budget)
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex)
>  {
>         virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> +       netif_queue_set_napi(vi->dev, qp_index, NETDEV_QUEUE_TYPE_RX, NUL=
L);
>         napi_disable(&vi->rq[qp_index].napi);
>         xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>  }
> @@ -3317,8 +3336,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_que=
ue *rq)
>  {
>         bool running =3D netif_running(vi->dev);
> +       int q =3D vq2rxq(rq->vq);
>
>         if (running) {
> +               netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NU=
LL);
>                 napi_disable(&rq->napi);
>                 virtnet_cancel_dim(vi, &rq->dim);
>         }
> @@ -5943,6 +5964,8 @@ static int virtnet_xdp_set(struct net_device *dev, =
struct bpf_prog *prog,
>         /* Make sure NAPI is not using any XDP TX queues for RX. */
>         if (netif_running(dev)) {
>                 for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYP=
E_RX,
> +                                            NULL);
>                         napi_disable(&vi->rq[i].napi);
>                         virtnet_napi_tx_disable(&vi->sq[i].napi);
>                 }
> --
> 2.25.1
>

Thanks

