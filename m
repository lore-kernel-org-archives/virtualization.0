Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C081DDF5
	for <virtualization@lists.linux.dev>; Fri, 28 Jun 2024 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541204; cv=none; b=X0b4HD0iNCI6HrX3ARl3wa7EQ0oMrQ6tHSLuj/vVOXvyV2xdVZG+ZZHOLn5POKwYc7HZquAC5Z174qCh/1BGJx3YCgX++sBB/+4+wQJv6WdfzrfM70q7UbG0vEl3evBG8uTyzCBtjknc8I62nc/93ugpL4FjSEXYeBU4mlEzfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541204; c=relaxed/simple;
	bh=O/CQfmPQM0eY4d7wyOW5I4ggKNFPLdYmErVxqBo6dFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgDh89XKZlcB0IbMAUi324QcURKBd1Bi/h39AkMy00CxXCPawgrVnfs1JjJrrs7UZaRO+DmLe8ojtSRT9ZdQNMVMSLpISnB55Ht9TgFtfc96RFwOv4ErUxaP936KBUWDud+zgNSnNTvFGVzVgrXKU/uWtei+2oVjMaNXgPt/f9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hufR1Z6e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hufR1Z6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24Ce/ZaIZMNMqzCu0jVvb+4QsT79hmjdfiG5HRValjs=;
	b=hufR1Z6eGLxPI/OPQA5g+Zk9rY1e4y17FT3s4bx59wKiBnkC57JnJiwWn6ZRyYGYojhI9c
	3e2TcURaH70BK+lCE/2tV5U1yXR/e/+2IMIQcjfhyof2coWb0kdC5lDywZPd2BK3PIyhcy
	BWB26eHooSkz1IwHZMs2U34PqXDqS9Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-lPnmYHuqOwe-TyHZz6pf3Q-1; Thu, 27 Jun 2024 22:19:58 -0400
X-MC-Unique: lPnmYHuqOwe-TyHZz6pf3Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c7a8a79cebso198534a91.3
        for <virtualization@lists.linux.dev>; Thu, 27 Jun 2024 19:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541196; x=1720145996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24Ce/ZaIZMNMqzCu0jVvb+4QsT79hmjdfiG5HRValjs=;
        b=gR3mLdxjFSG6zERS5vjCbGIbUUxem8ChXDhbXEhBBRXCM3zBWrX8XToZH8ff7g2zK+
         +6bb+3d6Udcr2gBe6XARDYeMXpHal7oVk2khd4OgY9r2edtAS9OVJioNBZ0L5MJtQPXt
         8MZ6x9dLZwoTeMNoymXk1pysq6Yvq8oXWDat9cFZezVBnb4Vd4sxJdNYRoRviSiEq+mQ
         i3K/QQ5sr6BG97fF/4eQOS16Eh10hnQ3Bw8eMM1y4QQhgum82whUtkdrNypBXgiG2xh9
         kD2NvvefIjq8VjfUoCGbNmjyoOkxBI7e2hNffUHzLcJPmJ83kXvB8skhDD3yPZU5XADQ
         +qlA==
X-Forwarded-Encrypted: i=1; AJvYcCUKouaMTa+eanuY0DCsTKukcVpHYZFogT8jREp7GH8jdVF0jT10+hK28QT2D/A7Glr9/WAhGiSkv7NA/85bvR80RuGidO0bWG5ZBirVL8U=
X-Gm-Message-State: AOJu0Yz80fIDMEwM2MiEo0T4rrLu4Q6HaUnwZ5/j3YQObC306fMytYFB
	enMQ47PDJ+trG+CM3apd327ttN27J0GKF17JqlMBtjTXN4LE+pLgnGYSCzlDYniIl1+fC7rV9mV
	NIf/QN+GzEgy1IwSiXXSIbxSwQ3waKwDDtR/oms3W1CVogQKCLZST+V/Cm/sQggTE2USc119eb8
	oobxt6Waw/qcSbS2+ZQUHswKkfiomXx32EWMVXeCI=
X-Received: by 2002:a17:90a:b116:b0:2c8:858:7035 with SMTP id 98e67ed59e1d1-2c8614096cemr12176240a91.25.1719541196386;
        Thu, 27 Jun 2024 19:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHudDP8J7qpcW2Ue6bVOpBtlOp14tFGDgoD+/QZ3lixc37SvGcGCSAu5MccMrSsp2Brpo3cHqpWaXec/5SUpo=
X-Received: by 2002:a17:90a:b116:b0:2c8:858:7035 with SMTP id
 98e67ed59e1d1-2c8614096cemr12176229a91.25.1719541195933; Thu, 27 Jun 2024
 19:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:44 +0800
Message-ID: <CACGkMEsqBeV9mSVV0yO_sZ=hB==PFoHvtPyma1pctc_+HMEFrA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 09/10] virtio_net: xsk: rx: support recv merge mode
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
> Support AF-XDP for merge mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 139 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 06608d696e2e..cfa106aa8039 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -504,6 +504,10 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_=
prog, struct xdp_buff *xdp,
>                                struct net_device *dev,
>                                unsigned int *xdp_xmit,
>                                struct virtnet_rq_stats *stats);
> +static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +                                              struct sk_buff *curr_skb,
> +                                              struct page *page, void *b=
uf,
> +                                              int len, int truesize);
>
>  static bool is_xdp_frame(void *ptr)
>  {
> @@ -1128,6 +1132,139 @@ static struct sk_buff *virtnet_receive_xsk_small(=
struct net_device *dev, struct
>         }
>  }
>
> +static void xsk_drop_follow_bufs(struct net_device *dev,
> +                                struct receive_queue *rq,
> +                                u32 num_buf,
> +                                struct virtnet_rq_stats *stats)
> +{
> +       struct xdp_buff *xdp;
> +       u32 len;
> +
> +       while (num_buf-- > 1) {
> +               xdp =3D virtqueue_get_buf(rq->vq, &len);
> +               if (unlikely(!xdp)) {
> +                       pr_debug("%s: rx error: %d buffers missing\n",
> +                                dev->name, num_buf);
> +                       DEV_STATS_INC(dev, rx_length_errors);
> +                       break;
> +               }
> +               u64_stats_add(&stats->bytes, len);
> +               xsk_buff_free(xdp);
> +       }
> +}
> +
> +static int xsk_append_merge_buffer(struct virtnet_info *vi,
> +                                  struct receive_queue *rq,
> +                                  struct sk_buff *head_skb,
> +                                  u32 num_buf,
> +                                  struct virtio_net_hdr_mrg_rxbuf *hdr,
> +                                  struct virtnet_rq_stats *stats)
> +{
> +       struct sk_buff *curr_skb;
> +       struct xdp_buff *xdp;
> +       u32 len, truesize;
> +       struct page *page;
> +       void *buf;
> +
> +       curr_skb =3D head_skb;
> +
> +       while (--num_buf) {
> +               buf =3D virtqueue_get_buf(rq->vq, &len);
> +               if (unlikely(!buf)) {
> +                       pr_debug("%s: rx error: %d buffers out of %d miss=
ing\n",
> +                                vi->dev->name, num_buf,
> +                                virtio16_to_cpu(vi->vdev,
> +                                                hdr->num_buffers));
> +                       DEV_STATS_INC(vi->dev, rx_length_errors);
> +                       return -EINVAL;
> +               }
> +
> +               u64_stats_add(&stats->bytes, len);
> +
> +               xdp =3D buf_to_xdp(vi, rq, buf, len);
> +               if (!xdp)
> +                       goto err;
> +
> +               buf =3D napi_alloc_frag(len);

So we don't do this for non xsk paths. Any reason we can't reuse the
existing codes?

Thanks

