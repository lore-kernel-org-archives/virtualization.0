Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF86442B
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQ7P0d7P"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA30F60B4E
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:33:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA30F60B4E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQ7P0d7P
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwNWa2bCIJUg
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Dec 2023 03:33:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EDDA860B30
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:33:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDDA860B30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703129584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7FZ7AbvKJbxFkFYCPY/SnK8b/d1PgFCZ+bWPWNhxMg=;
	b=YQ7P0d7P8WmhiP62FTe5kJzley7H2olVinBy6M2ACoOVdMeuvUv+S1tUYCu1crMjnQcCXc
	Vl3QUCPlPeBRg9VIFETIsCLI+qOcAxKDXYyBAdeFHUtsr79b8/eQeH+aDS+WvELeMAY7Hw
	plDlgjITy/VuISJCbWfjRR8DDRaFiN8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-7jXKw50uOHK9yqqqFHZifg-1; Wed, 20 Dec 2023 22:33:02 -0500
X-MC-Unique: 7jXKw50uOHK9yqqqFHZifg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c641d55e27so241696a12.1
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 19:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129581; x=1703734381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7FZ7AbvKJbxFkFYCPY/SnK8b/d1PgFCZ+bWPWNhxMg=;
        b=Gra8Wvtc8e2jNnaWIVDZN0aNgfGkRHnnTfCL884DCbpSQp8Qrh5/phgfjFWUA2ylTT
         C6P9GP8Xi99xkf9R2ecSfL/9dFgx7Deo8Ezi17W5ps89p80z9kpyB73Os7BBOHROEJcx
         UuW48alSDjmtM1A3rFMzN/M3AsAguMwf0f5i8sy6tbAEVqiTt4JnQw/ZPV3phNSSDZJd
         sYFfqU9ilcTzyLkTeEtBeBD8HF6qFKUVVmPvk/57m8+vXbIvYVZkcgxAvABk0LaKoUp8
         UUUI93yQ3hJvxV+sQmK/vpnAxIajNvRjPgppuQh3xOKYJ8J66RIPytdrl4EA6XIewwue
         P8aA==
X-Gm-Message-State: AOJu0YxdEIYj9CMImu+DTuXEST8g11F0fMWcZlkowyI0/2s0t3o0CfHx
	XvD8pHARAiCjP+a8tHSYX0Ky4FVKNUOp3Pt4sO1xZ49bYC0Pc+1r2OA5Lv2OMzWxk5MkmFJcX9a
	mjnAx2r6zh2nlorqGogmEjXPC0XF5b08Q040OmQe/1jWCRwEOxv7Rt5O+Yg==
X-Received: by 2002:a05:6a20:8f14:b0:18c:26cc:c054 with SMTP id b20-20020a056a208f1400b0018c26ccc054mr79984pzk.7.1703129580742;
        Wed, 20 Dec 2023 19:33:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIDYSu9gMeojq2Rvy3LuwbWAorLY8lWDAztSbBbRberFuQkwgkrggCRLcnpZYbQboVH7FekH5CNQJxXeXQpk0=
X-Received: by 2002:a05:6a20:8f14:b0:18c:26cc:c054 with SMTP id
 b20-20020a056a208f1400b0018c26ccc054mr79976pzk.7.1703129580403; Wed, 20 Dec
 2023 19:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com> <20231207080353.6575-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231207080353.6575-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 11:32:49 +0800
Message-ID: <CACGkMEstikKFNTrTeytjrDhuaGxEys=t=ZqGK1Eqv6giemWneQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0.123 -m 00=
:16:3e:12:e1:3e -n 0 -p 100
> matchine:  ecs.ebmg6e.26xlarge of Aliyun
> cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> iommu mode: intel_iommu=3Don iommu.strict=3D1 iommu=3Dnopt
>
>                       |        iommu off           |        iommu on
> ----------------------|--------------------------------------------------=
---
>                       | 16         |  1400         | 16         | 1400
> ----------------------|--------------------------------------------------=
---
> Before:               |1716796.00  |  1581829.00   | 390756.00  | 374493.=
00
> After(premapped off): |1733794.00  |  1576259.00   | 390189.00  | 378128.=
00
> After(premapped on):  |1707107.00  |  1562917.00   | 385667.00  | 373584.=
00
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 120 ++++++++++++++++++++++++++++----

Any reason to depend this series to the relocation series?

>  drivers/net/virtio/virtio_net.h |  10 ++-
>  2 files changed, 117 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 83f24de00497..9600ffe1af86 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -167,13 +167,39 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_dm=
a_head *dma)
> +{
> +       int i;
> +
> +       if (!dma)
> +               return;
> +
> +       for (i =3D 0; i < dma->next; ++i)
> +               virtqueue_dma_unmap_single_attrs(sq->vq,
> +                                                dma->items[i].addr,
> +                                                dma->items[i].length,
> +                                                DMA_TO_DEVICE, 0);
> +       dma->next =3D 0;
> +}
> +
>  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>                             u64 *bytes, u64 *packets)
>  {
> +       struct virtio_dma_head *dma;
>         unsigned int len;
>         void *ptr;
>
> -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> +       if (virtqueue_get_dma_premapped(sq->vq)) {
> +               dma =3D &sq->dma.head;
> +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> +               dma->next =3D 0;
> +       } else {
> +               dma =3D NULL;
> +       }
> +
> +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, NULL=
)) !=3D NULL) {
> +               virtnet_sq_unmap_buf(sq, dma);
> +
>                 if (!is_xdp_frame(ptr)) {
>                         struct sk_buff *skb =3D ptr;
>
> @@ -567,16 +593,70 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq=
, u32 size, gfp_t gfp)
>         return buf;
>  }
>
> -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> +static void virtnet_set_premapped(struct virtnet_info *vi)
>  {
>         int i;
>
> -       /* disable for big mode */
> -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> -               return;
> +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +               virtqueue_set_dma_premapped(vi->sq[i].vq);
>
> -       for (i =3D 0; i < vi->max_queue_pairs; i++)
> -               virtqueue_set_dma_premapped(vi->rq[i].vq);
> +               /* disable for big mode */

Let's use a TODO here.

Other looks good.

Thanks

