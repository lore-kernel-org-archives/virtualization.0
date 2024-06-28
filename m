Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E31CA8A
	for <virtualization@lists.linux.dev>; Fri, 28 Jun 2024 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541198; cv=none; b=qeDsfikKYe0s0rVzWzKHWy7KMwXIrcpsq4PDgG4o7yl3/9C0q50pacAlasi1ovkmZE5JecXpYyKEoH2Sqqamb2Of8CXFUvjkbera7pjKs22FTOdZIVaoCeI4tZeokg24bhfQAVXIlNGE5LhWO+RZd3uc9wbSWDu0wkCTYT7d0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541198; c=relaxed/simple;
	bh=0pl5IDO84YuTZzRBLOi54dqVTmqUceO1ojj7jTBbAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5iI2Y9fWKd4T0N7VoibGDb+4urPPx8CrMiY2oJHRJCmvVzepofQEFDL7DEap3KfbPzq1lFawnUfnkxdPHY7ueXgHhCa8CP037zeEL8NpjPkK54Rdc274IolYPyBkn67W6sYyYy3ttg46M/kf7uytKBc2GwopcPMMbKDcAvH4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grF4KJTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grF4KJTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nd9rJ/TDcLIKdWBumem351Ij8O7si91I+/ZDY+8chw=;
	b=grF4KJTgYoHHfFRGm1EoGBw+Vz8xoK0T1F+aWtA1Ijzh3IFukcMZmzUqOkbByo58nlH0cN
	ADR7CkCNEpspNMrr3zfkh4ufHm2f42QsBDpBDX3JkAq2fKVSHz/gWJGKl2Y8mqOCAiJIPo
	5lpjL0LDQJOlujalaQgVasNcBWkqv38=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-DDFCU6YvMC2-HYg2apdqnw-1; Thu, 27 Jun 2024 22:19:52 -0400
X-MC-Unique: DDFCU6YvMC2-HYg2apdqnw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3d5658b50e1so247620b6e.0
        for <virtualization@lists.linux.dev>; Thu, 27 Jun 2024 19:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541191; x=1720145991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nd9rJ/TDcLIKdWBumem351Ij8O7si91I+/ZDY+8chw=;
        b=XA78xO5KvbzDRnbpWE44u8O2tcQbeGHxwekNTGd9bYZK2t+Tp5x2ItTX0C/hskykjz
         jv+sL/1pAvry7dZYi9Ywgc61WctFC7GtIIVOtzfMNwhBARfEs+1wMIRepdwuk9xH1m44
         OddT3NSGBDMFg+ycENGrL48YsQH/gJQb2RiRpbhFfNkcX7tJ7ClbqyIFV4t9+hn2fLGh
         GqDMYvpR8VpNSRWfj25RgsZ2QSodi4egjEPC+A5mERkBPhpVWkga/0louSyRujwsND3B
         Net5fbuylTbYKo4zq3goCE9ryrHWjy2L2YE8SMyEKpc46RUUSSkNhVLtKBSjwxcbBdl7
         sPzA==
X-Forwarded-Encrypted: i=1; AJvYcCVxo8mXFlX1hbZIsc5AnhneOt9YBA8ndRrWC0t1f6cBotIo7Qcl29YLvVS/gQnZQ2Pn0uyHniSqAkEp2ysbDylbsLSwTIecaA9CbuOjKFY=
X-Gm-Message-State: AOJu0YwXd/PpK9DHsTrpryAQ0WR1HsEqnpXU/bpsIEh/9xZvvwz7ICe+
	+GlBzE2Ygz0gcY9K6AzhN1CFkTvhp7oa2I3A1PmdHdbUZsLLtEfOX5GMIhPEtNMn4t9h/kvFt+y
	S8dnpusZepSnnL/paWr6pV6YDVrbCO21nokbZ0utjjfmuXUT9/KQh3EM95L0E7seHawRHScKZJM
	LtAY+MlyJZeuLM3B+YeXSJIdvpMb6r4MZtUGMstS0=
X-Received: by 2002:a05:6808:15a6:b0:3d5:64be:890f with SMTP id 5614622812f47-3d564be8c87mr6974067b6e.49.1719541191261;
        Thu, 27 Jun 2024 19:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwwofqbOpDvkSmww0NDTJydZp0AN9afbKh2t1W7XoMUGKRy4SuVLpPH3aktVMj0GBaaPOqCpDTYZtjp/p+Mrw=
X-Received: by 2002:a05:6808:15a6:b0:3d5:64be:890f with SMTP id
 5614622812f47-3d564be8c87mr6974036b6e.49.1719541190592; Thu, 27 Jun 2024
 19:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:37 +0800
Message-ID: <CACGkMEta9o97cqUy+wV=1Xpu8MBoFt4CEtWS35dhTMs0Dm4AKg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/10] virtio_net: xsk: rx: support fill with
 xsk buffer
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

On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Implement the logic of filling rq with XSK buffers.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 68 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2bbc715f22c6..2ac5668a94ce 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -355,6 +355,8 @@ struct receive_queue {
>
>                 /* xdp rxq used by xsk */
>                 struct xdp_rxq_info xdp_rxq;
> +
> +               struct xdp_buff **xsk_buffs;
>         } xsk;
>  };
>
> @@ -1032,6 +1034,53 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>         }
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;
> +}
> +
> +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> +                                  struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +       struct xdp_buff **xsk_buffs;
> +       dma_addr_t addr;
> +       u32 len, i;
> +       int err =3D 0;
> +       int num;
> +
> +       xsk_buffs =3D rq->xsk.xsk_buffs;
> +
> +       num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> +       if (!num)
> +               return -ENOMEM;
> +
> +       len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               /* use the part of XDP_PACKET_HEADROOM as the virtnet hdr=
 space */
> +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len=
;

We had VIRTIO_XDP_HEADROOM, can we reuse it? Or if it's redundant
let's send a patch to switch to XDP_PACKET_HEADROOM.

Btw, the code assumes vi->hdr_len < xsk_pool_get_headroom(). It's
better to fail if it's not true when enabling xsk.

Thanks

