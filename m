Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ECA101E6
	for <virtualization@lists.linux.dev>; Mon, 22 Jul 2024 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633280; cv=none; b=M4k/zHH9fg8UMOQpcGbSpscj3sWTLGdt2Kq+uYfXL5aWNrgi1hEsQvutTtoeHmIpX4whHS6OURylgdt0QiK/b72hxV0KUzioqzPsSvmRk/ZFE2CMuRcWoTqEEX68Qyd3RsJ3mMGviYf5bGsyiln+TS6HiNZa1G33VNE21yeXpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633280; c=relaxed/simple;
	bh=Nm/iP+Ef8w5C1p1oN7/SGXtY7xU8KLhZVOqrCxwRuHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLDBmy2yDXPS/7U9dbxzSvGPmp2226zMhJZvIwb2FySK+nEQyh7/3wkj0yZzLGFQf93nGCFFR8tMMfbWXMdOiSDnaSr3SJGnKJL8JUY7APwPH3OoYVB+0Fj/e+veBLSsagPpNK3tNst2rf7SwkhEMkh8FjVyeqcT7i5t+6XYY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFrQaFPW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFrQaFPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721633277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T95/0g9beK9xkQ+nBBsS0HYON2c9LYVJ1w/U2mpnGSc=;
	b=bFrQaFPWxqpAgZW2Bj8oXkoyQx4JVKa2Bw9dy270k6BEIO73yK1Wx3Rf7ci7tKvMsG6oLQ
	5kUPzQ3+5nTH5XztIOXlq1wy3UX7Sb7CMMaZ0kO2ACmjRsP5SA24NfKNJDFaAuW/DQN1w0
	xurLbHHpAueiQ6xjzaj/hL/KexdLZfQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-UEJzncTyOyq4MgDyuW6S2Q-1; Mon, 22 Jul 2024 03:27:55 -0400
X-MC-Unique: UEJzncTyOyq4MgDyuW6S2Q-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6716094a865so3114221a12.0
        for <virtualization@lists.linux.dev>; Mon, 22 Jul 2024 00:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633274; x=1722238074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T95/0g9beK9xkQ+nBBsS0HYON2c9LYVJ1w/U2mpnGSc=;
        b=eh6sBFRHk0eI+rHganhEUzhHUnlduQFLT5ND+sAidIHmCRJ4RXum3Dar0h4yfzBlei
         CM0i7W1jOKC9MsnyvIrioh/h+gna+R8ZwQcMXh8QBJk2i63zyPJADrYeW2N5ev2gFnSw
         V1gBx/+zmx4KUYGEahEKPmc74IJ18U09v7ZuGmwyYxohkzElDLMEl9chAyZQ0/BcHXth
         jQscJF3KDBaBb1dNSd5xHaT39Vs7PXJFW3edJo/WbQ4dc2Br6uQ1b4dmJ13awiTcbVZe
         0/ziFNHglMoEfXyUK/40yqav7th/E8ZnkkzKO8GIqFXM3++JKCajten9LTHT5MNuHOx0
         +oRw==
X-Forwarded-Encrypted: i=1; AJvYcCW6P+ljblQUvIC58bCraWLX+I2qJDQRSWcZA2TDLBE+Q1G1hqFICC1qjgrEbSiJFY/FjHLRTJqoORH2BcrfpfMZXZZE5ix/vZ3DjGdUz8k=
X-Gm-Message-State: AOJu0YwBcYkiTPNvl2XoyoRDAhFWW2DWfEdTqkAF0VVZZxoN8z+L2Ge6
	Klbr/cW7T44nCLgZjGs0nzaif4BJS75GUnuUVEVu/lVeplQzY22M5fvWJjZY9rXYIHWlNI1DFnU
	qz+nU3mGqlid2gonYpLIX4EqTQdwTMwxlj3SDr/h9AThdO2DmS5Nbzi0PqjsZUfe1czQQF190ld
	juXfTZqdQhN1+GzHhzusvxus/E+QwxprgpY6PzvF0=
X-Received: by 2002:a05:6a21:999b:b0:1c2:1ed4:4f90 with SMTP id adf61e73a8af0-1c4285689f6mr3925562637.19.1721633273712;
        Mon, 22 Jul 2024 00:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxIPcCd1WW98vl8lXbLzkIH0a8Q+ehSVLCBNp9CRt+/VuFx/jMBlf8mhAQqthIef6gJKjwps/aEk4qySfjQO4=
X-Received: by 2002:a05:6a21:999b:b0:1c2:1ed4:4f90 with SMTP id
 adf61e73a8af0-1c4285689f6mr3925519637.19.1721633273096; Mon, 22 Jul 2024
 00:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:27:42 +0800
Message-ID: <CACGkMEsX5CwQmrwYzosSDMRdOfYVEmaL6x0-M9fWq0whwyRwSQ@mail.gmail.com>
Subject: Re: [RFC net-next 00/13] virtio-net: support AF_XDP zero copy (tx)
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

On Tue, Jul 16, 2024 at 2:46=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> ## AF_XDP
>
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The z=
ero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already suppo=
rt
> this feature, This patch set allows virtio-net to support xsk's zerocopy =
xmit
> feature.
>
> At present, we have completed some preparation:
>
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
>
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
>
> Virtio-net can not increase the queue num at will, so xsk shares the queu=
e with
> kernel.
>
> This patch set includes some refactor to the virtio-net to let that to su=
pport
> AF_XDP.
>
> ## About virtio premapped mode
>
> The current configuration sets the virtqueue (vq) to premapped mode,
> implying that all buffers submitted to this queue must be mapped ahead
> of time. This presents a challenge for the virtnet send queue (sq): the
> virtnet driver would be required to keep track of dma information for vq
> size * 17, which can be substantial. However, if the premapped mode were
> applied on a per-buffer basis, the complexity would be greatly reduced.
> With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
> skb buffers could remain unmapped.
>
> We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
> indicates that the driver has performed DMA mapping in advance, allowing
> the Virtio core to directly utilize sg_dma_address(sg) without
> conducting any internal DMA mapping. Additionally, DMA unmap operations
> for this buffer will be bypassed.
>
> ## performance
>
> ENV: Qemu with vhost-user(polling mode).
> Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
>
> ### virtio PMD in guest with testpmd
>
> testpmd> show port stats all
>
>  ######################## NIC statistics for port 0 #####################=
###
>  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
>  RX-errors: 0
>  RX-nombuf: 0
>  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
>
>
>  Throughput (since last show)
>  Rx-pps:   8861574     Rx-bps:  3969985208
>  Tx-pps:   8861493     Tx-bps:  3969962736
>  ########################################################################=
####
>
> ### AF_XDP PMD in guest with testpmd
>
> testpmd> show port stats all
>
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
>
>   Throughput (since last show)
>   Rx-pps:      6333196          Rx-bps:   2837272088
>   Tx-pps:      6333227          Tx-bps:   2837285936
>   #######################################################################=
#####
>
> But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
>
> Please review.
>
> Thanks.
>
> Xuan Zhuo (13):
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: split: harden dma unmap for indirect
>   virtio_ring: packed: harden dma unmap for indirect
>   virtio_ring: perform premapped operations based on per-buffer
>   virtio-net: rq submits premapped buffer per buffer
>   virtio_ring: remove API virtqueue_set_dma_premapped
>   virtio_net: refactor the xmit type
>   virtio_net: xsk: bind/unbind xsk for tx
>   virtio_net: xsk: prevent disable tx napi
>   virtio_net: xsk: tx: support xmit xsk buffer
>   virtio_net: xsk: tx: handle the transmitted xsk buffer
>   virtio_net: update tx timeout record
>   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
>
>  drivers/net/virtio_net.c     | 363 ++++++++++++++++++++++++++++-------
>  drivers/virtio/virtio_ring.c | 302 ++++++++++++-----------------
>  include/linux/virtio.h       |   2 -
>  3 files changed, 421 insertions(+), 246 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>

Hi Xuan:

I wonder why this series is tagged as "RFC"?

Thanks

