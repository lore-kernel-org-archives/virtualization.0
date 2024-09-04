Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642EE84A32
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431519; cv=none; b=p+ZTSEhBewewU6aX23oIzmGsuE4aqjSDzmL41mYbNak+RE41QM355kMzf/rXVXJrtjkV053QwX81KRrg0AKbAnxVv7JxI4YIJOqzLkX0cmBrNT4T7m9Ux442QI9j1LPXwSJNG8DKS52zsjFUgdigGP+DMv2K/a9SKzdyEuYofKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431519; c=relaxed/simple;
	bh=NHk8FpIJQC2mzNX+SVK98/2jJ0cuZFoSyhCWm6EdBtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdJ1WIO/dnyn1eyoQ4wzOqyD/jqyteR5NtNS0a4vv2c+ZJRpcY/RUxyzUP/jbRydRUwv3BHKX9JuLcZpoAoIei7nzppCZZINI0EFWT6LT7k5XHlOM5gc+YYoUi04j4qziOQhFuNmlxe++synnbVV8OFHyxrR1kVkUz9yR8QhhTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1EQ2u1N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1EQ2u1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725431516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTZ9w0ekh4uK8i4TV5xGSvspEeutq9HPzTvoRIeqw5k=;
	b=R1EQ2u1NOAm3NBuJvJ1veJTpf1Z2GMqBpfoQP35trvyLDBeGGdYltE/diLBPPO2krg8yOK
	yHGCcPxz5NERFem0UntW77hR0NnL4yXxQ0JG4A2IFgrw5Cb6HA7zVXJqjey6Gd67h6XxF+
	9VhgcdxC7y1GBfOCk67Jj3fuRypWGfA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-qUaG7NufMaK0StJdzocn3w-1; Wed, 04 Sep 2024 02:31:55 -0400
X-MC-Unique: qUaG7NufMaK0StJdzocn3w-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7143d66b510so6944317b3a.3
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 23:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725431514; x=1726036314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTZ9w0ekh4uK8i4TV5xGSvspEeutq9HPzTvoRIeqw5k=;
        b=gh3B6eIAnkpXWFzXKH8tiJM4udjx+y/ZcrzlLO4otc0hxvIck0vkCK/goknqYB2kO0
         C0IyEcwRnQEkvYRv00bRMYjNcjU7m9OnMWpKNl8nlzXBsdQIgMbcLib/Zms9Ry1tQdkr
         wsGUFawJpwTHS37ybdpi1q5CKL+0yQIbrej224K5CukpbysecNlTJQ63W0URCuuWiO3f
         vcvnzBVzI0yJW2nYpca/yLxNvUqRLT6UE/IofXqNFPNY+D0B/gTtl4R3hkEtcJ9s1kZM
         DhhvFAv8RJOmi4LTp6BOdK79Sa29oNYTsX0aHOe7WjWptr7m9XGvFKPqlVdRoOnP7jZ2
         3qQw==
X-Forwarded-Encrypted: i=1; AJvYcCWuoKLeqYmAXdFWwzGfujawGTM1slkjC6Bo8NbJjl6Ia4boYv76nQ3TBc+DOKrswIsHo6Yht7pMGCmcqnor5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4LtrXBPYM+AoEdMNpPEBbTsfY5gok+cPWkyfG8JrOcLiCGA4c
	kFlZeVuOA86VVtCzsz/dZq3rcoQTavFgcKTlEqtdwxE74hSy81gV9KjhqQEOwn1TA5mDI1aicFK
	OWYF8Cq9UiFz2XLSK+s60Sp+IB5i2LiR91bzZB0BGlnfzkbhQg2J+5LoT+o3cN5G+q+Z3UsDyBe
	YuCRZM9D3KmQxe4EFxTrY2OICkeloaJS4q+Ub6PD8=
X-Received: by 2002:a05:6a20:9c89:b0:1ca:981:8e4e with SMTP id adf61e73a8af0-1cce1003859mr18255945637.3.1725431513972;
        Tue, 03 Sep 2024 23:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA2IPAlHgkpPhPv0OlmQPhO59Hrm6A57UoLBdFNZjRY9QRb8AYf52TsZjskxoDtYGD0Us3AKueXQPBXy7HSlo=
X-Received: by 2002:a05:6a20:9c89:b0:1ca:981:8e4e with SMTP id
 adf61e73a8af0-1cce1003859mr18255924637.3.1725431513524; Tue, 03 Sep 2024
 23:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
In-Reply-To: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Sep 2024 14:31:42 +0800
Message-ID: <CACGkMEsMnEX25+-jyn3sjwF4iDEFCWKX2478dK-mf-fJeBrKtA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: Fix mismatched buf address when unmapping
 for small packets
To: Wenbo Li <liwenbo.martin@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiahui Cen <cenjiahui@bytedance.com>, 
	Ying Fang <fangying.tommy@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:10=E2=80=AFPM Wenbo Li <liwenbo.martin@bytedance.c=
om> wrote:
>
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
>
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
>
> This patch handles small and mergeable packets separately and fixes
> the mismatched buffer address.
>
> Changes from v1: Use ctx to get xdp_headroom.
>
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling merge=
able buffers")
> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> ---
>  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948..cbc3c0ae4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct receive_queue=
 *rq, u32 *len, void **ctx)
>         return buf;
>  }
>
> +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
> +                                     u32 *len,
> +                                     void **ctx,
> +                                     unsigned int header_offset)

header_offset is unused?

> +{
> +       void *buf;
> +       unsigned int xdp_headroom;
> +
> +       buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +       if (buf) {
> +               xdp_headroom =3D (unsigned long)*ctx;
> +               virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom,=
 *len);
> +       }
> +
> +       return buf;
> +}
> +
>  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, =
u32 len)
>  {
>         struct virtnet_rq_dma *dma;
> @@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct virtnet=
_info *vi,
>         int packets =3D 0;
>         void *buf;
>
> -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> +       if (vi->mergeable_rx_bufs) {
>                 void *ctx;
>                 while (packets < budget &&
>                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
>                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stat=
s);
>                         packets++;
>                 }
> +       } else if (!vi->big_packets) {
> +               void *ctx;
> +               unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
> +               unsigned int header_offset =3D VIRTNET_RX_PAD + xdp_headr=
oom;
> +
> +               while (packets < budget &&
> +                      (buf =3D virtnet_rq_get_buf_small(rq, &len, &ctx, =
header_offset))) {
> +                       receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stat=
s);
> +                       packets++;
> +               }
>         } else {
>                 while (packets < budget &&
>                        (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D NUL=
L) {
> --
> 2.20.1
>

Thanks

