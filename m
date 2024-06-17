Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781CC4DA1F
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605931; cv=none; b=ryBrTJJ/5QxcQ4tuamzcW0T2NmD9iTAlhy0fPJ3YjGRNiPPSihVy14xvNPKmw0T51j5DX6L+EhmzsQ2lf0tiiaP3YDcTlN8oqCDyPCZ9HfC507xUSRiFgtxXvGr3W91/+MMipzr3xuJDLIm9pp+62jk04WYNYBYBTQiOd/rW7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605931; c=relaxed/simple;
	bh=+SnHGBT0dEbHmy6M7zBTRMqmh8abTUvjhC0ZSGnLMqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB1eA+k8Xpsx2gXz2NkBi9DvEHCljTcYUsDkC2kjkhvIl+V/OqasA+xkFp1cSJTqGfp73qDwcpL9Rzj53flrJ68iczuD/Ptp2sH+he8DlD0z4rNxJCQjowU6i7DWHuyeyU3Gf9cEHgb37+BXIwUnmDjfNMj1rGjx69KhnB2XlZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlO4Ihhj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlO4Ihhj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718605929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdjqRPBQHAxoGBuZ2sA/XQpy9enBxGSufgOepPoFtj0=;
	b=NlO4IhhjVfl6FeZd/taKPqx2V1xaaG6GrMr8PWoC6pW8bqsLYP3/JdnU5SVYUpa4M+paCP
	u9JBH55EW5ozMSCoVZ9ZK2zpR4xV6IzKcH8g1U+tMCVPceWOGymrJuW1ijHKGYTCEr6fSK
	RtqNCvqYanaAk4OgMpW6gNe/+t/93r8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-q6MoMLIDOsigNKGYGhkP5Q-1; Mon, 17 Jun 2024 02:31:40 -0400
X-MC-Unique: q6MoMLIDOsigNKGYGhkP5Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1e953176cso4218234a91.0
        for <virtualization@lists.linux.dev>; Sun, 16 Jun 2024 23:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605899; x=1719210699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdjqRPBQHAxoGBuZ2sA/XQpy9enBxGSufgOepPoFtj0=;
        b=TgZJ9DMORpSjpE6+0Dq3m+BAOJ4CBTFROVChsf593ksl0JllNgT1JpQ7hDJqI+azHl
         Wnq1hFa7MwcT/sZNTMUOByxOkfCn9/3Dgi3QJ/Te+D4Kpj+UnR8u/9goZgBEgbGAcbgG
         SXaBZtKxkZ1vVMBbDnO+/fahGMSPx8VfK4QSeQueP19ZMxx31aIvGD2aVk/fiGoLi1PV
         NO8e4l4T3ZUrWHSsOcW6g3HEUt+A3qtexPGUX7W3JTkys53L1v4HDxcQXZsr9yEPr6Dw
         NGOAixbZPAynt0dgs1xIvi7B6jH+m+bFitvAOoUvMnxjkuLc6d1AwcQinn183T2QGVCa
         klEw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ55LDt7/jiur1LJiJf5YYADULL6uOYlSXCBPqMdoBNcm7dm57/G8WLvb5zfHbjvc/OUmKPLlqmc+OFBPg+vhk6jpnfrl8f/kHXmaef3k=
X-Gm-Message-State: AOJu0YzP4ntVRmGFgUNJtH+E9enIrwubAPd/X5mA/J9XWd5LTZH6GldS
	oEHtfO/A7uK38EdYCAvwPNl70EWLpoVEKkiiIH4LcloHFfKHMcFukqNpWGSu2HaenZfKNFq74w8
	ZqZyTme7Pt/t6aRRj/gOzc0X2IHfU/QuzlT1b0/SCWIU733/I55t4qIOSqDkBSpkGYPGISgcCYr
	yn/SKwPPNy6JenJj76l+J+ijwNjQDG6J6/EK0YUEo=
X-Received: by 2002:a17:90a:db55:b0:2c3:2592:110c with SMTP id 98e67ed59e1d1-2c4dbb43e62mr8278240a91.36.1718605899122;
        Sun, 16 Jun 2024 23:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7KefAopNA2i5sAqiaST2GA+tSESU8wWsjtyQlOa227A495/1OOwv6HQiwb6XHO33GM2MTivOGpNjHpfT4AXI=
X-Received: by 2002:a17:90a:db55:b0:2c3:2592:110c with SMTP id
 98e67ed59e1d1-2c4dbb43e62mr8278225a91.36.1718605898833; Sun, 16 Jun 2024
 23:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com> <20240614063933.108811-13-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240614063933.108811-13-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 14:31:25 +0800
Message-ID: <CACGkMEuk8rcSxt-+2AkPWixPoWcKXA+1swfMnzTFSyM=XazQKg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 12/15] virtio_net: xsk: tx: support wakeup
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 2:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
> user.
>
> Virtio-net does not support to actively generate an interruption, so it
> tries to trigger tx NAPI on the local cpu.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e811f392768..9bfccef18e27 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1368,6 +1368,29 @@ static bool virtnet_xsk_xmit(struct send_queue *sq=
, struct xsk_buff_pool *pool,
>         return sent =3D=3D budget;
>  }
>
> +static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct send_queue *sq;
> +
> +       if (!netif_running(dev))
> +               return -ENETDOWN;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +
> +       if (napi_if_scheduled_mark_missed(&sq->napi))
> +               return 0;
> +
> +       local_bh_disable();
> +       virtqueue_napi_schedule(&sq->napi, sq->vq);
> +       local_bh_enable();
> +
> +       return 0;
> +}
> +
>  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>                                    struct send_queue *sq,
>                                    struct xdp_frame *xdpf)
> @@ -5706,6 +5729,7 @@ static const struct net_device_ops virtnet_netdev =
=3D {
>         .ndo_vlan_rx_kill_vid =3D virtnet_vlan_rx_kill_vid,
>         .ndo_bpf                =3D virtnet_xdp,
>         .ndo_xdp_xmit           =3D virtnet_xdp_xmit,
> +       .ndo_xsk_wakeup         =3D virtnet_xsk_wakeup,
>         .ndo_features_check     =3D passthru_features_check,
>         .ndo_get_phys_port_name =3D virtnet_get_phys_port_name,
>         .ndo_set_features       =3D virtnet_set_features,
> --
> 2.32.0.3.g01195cf9f
>

