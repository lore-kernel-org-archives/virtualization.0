Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740A9EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 08:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7598404D8;
	Wed, 12 Jul 2023 08:24:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7598404D8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hf3VkNYf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iot1L_lmmaOd; Wed, 12 Jul 2023 08:24:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33E9240142;
	Wed, 12 Jul 2023 08:24:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33E9240142
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EB63C0072;
	Wed, 12 Jul 2023 08:24:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC7BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09BA8403E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:24:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09BA8403E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qBLBQTMNp27v
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:24:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A465940142
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A465940142
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689150272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cH45vzoohDDVn6swa6KSCYK51/6qmxTIVxrGvCpJhMA=;
 b=Hf3VkNYfVajcX8kO0fgHMJkNoGnI+Mpo1JsELQctfr1OeG0dJJxioKx7q+IcNi45/QFyoB
 K7cJZvSZhneAbLk1Eiko9izlklJ1aO9BWrhwOCueBFM4CLdbGV7zriHNqX+uRmbhYUOQ91
 mjg5A9g+cVzyNlec07JL4luHpqT/Ngk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-awZMB_PtNR2lSnybO60Gmw-1; Wed, 12 Jul 2023 04:24:30 -0400
X-MC-Unique: awZMB_PtNR2lSnybO60Gmw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b620465d0eso60209311fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 01:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689150269; x=1691742269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cH45vzoohDDVn6swa6KSCYK51/6qmxTIVxrGvCpJhMA=;
 b=jwLR31wZDyKfq3NJSqxZU9tcS8TiRu/uyfY/UskNULGXOg394ry697T6xJw7DydeQQ
 v3RdesbncrtBnAOAnj2Xq2deRl/nB5MxZStyPzMGKJ23o93z1p9YFbrqfIK5w3tQT2KD
 LMsf78epe/cRnd4TXVbabDVHU/PIiiwSrCL6I/fFkjmyz5R6WV0k9NU7SHYrU91pFdO7
 rif2b5+dTYqaCfUsywr74Xc69PTOWDpbfO8lvSNX9pj9pIJus1z0wXwG2fAC3HwV6voS
 PqMCQUf9o5TObI3WD3N+tqr/XleAYNoSi8ByIyRfiPeUUuFive/21XmGPvDswTA4hYZl
 +42g==
X-Gm-Message-State: ABy/qLaypGxtc5Nkv3VkDpF3epkw9vYZL0eDEl+Hdsdf7ihYBiDOCtO7
 b9hKFETAMf7+HOo4othgqsKSdC5YPuyQjdJO/fPqskKEwyltGv96h+MVfbC6/dUxog23ZBKMutk
 RUsIme4n/Lsotp+DWqicBayAkjc21Ztif0DVo0Ad2AhVEGKIH3dyu5wjxEg==
X-Received: by 2002:a05:651c:112:b0:2b7:3b73:2589 with SMTP id
 a18-20020a05651c011200b002b73b732589mr807681ljb.32.1689150269427; 
 Wed, 12 Jul 2023 01:24:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFfWVYSBS+pPEqldWEu1y4daYVzV9fnnTu5LTKLi59TaWf9NHbqfFHGiAQRzyzh3J1UwOAnAZfPfhYfRatHOc0=
X-Received: by 2002:a05:651c:112:b0:2b7:3b73:2589 with SMTP id
 a18-20020a05651c011200b002b73b732589mr807652ljb.32.1689150269158; Wed, 12 Jul
 2023 01:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 16:24:18 +0800
Message-ID: <CACGkMEumF73qbByV3K1+fdgnXBXqu-YS2yas+Vy_=Dn+yjy-cw@mail.gmail.com>
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce
 virtqueue_set_premapped()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5905904610071092614=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5905904610071092614==
Content-Type: multipart/alternative; boundary="000000000000c40f31060045f186"

--000000000000c40f31060045f186
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com>
wrote:

> This helper allows the driver change the dma mode to premapped mode.
> Under the premapped mode, the virtio core do not do dma mapping
> internally.
>
> This just work when the use_dma_api is true. If the use_dma_api is false,
> the dma options is not through the DMA APIs, that is not the standard
> way of the linux kernel.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 45 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 47 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 87d7ceeecdbd..5ace4539344c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -172,6 +172,9 @@ struct vring_virtqueue {
>         /* Host publishes avail event idx */
>         bool event;
>
> +       /* Do DMA mapping by driver */
> +       bool premapped;
> +
>         /* Head of free buffer list. */
>         unsigned int free_head;
>         /* Number we've added since last sync. */
> @@ -2061,6 +2064,7 @@ static struct virtqueue
> *vring_create_virtqueue_packed(
>         vq->packed_ring =3D true;
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
> +       vq->premapped =3D false;
>
>         vq->indirect =3D virtio_has_feature(vdev,
> VIRTIO_RING_F_INDIRECT_DESC) &&
>                 !context;
> @@ -2550,6 +2554,7 @@ static struct virtqueue
> *__vring_new_virtqueue(unsigned int index,
>  #endif
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
> +       vq->premapped =3D false;
>
>         vq->indirect =3D virtio_has_feature(vdev,
> VIRTIO_RING_F_INDIRECT_DESC) &&
>                 !context;
> @@ -2693,6 +2698,46 @@ int virtqueue_resize(struct virtqueue *_vq, u32 nu=
m,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
>
> +/**
> + * virtqueue_set_premapped - set the vring premapped mode
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Enable the premapped mode of the vq.
> + *
> + * The vring in premapped mode does not do dma internally, so the driver
> must
> + * do dma mapping in advance. The driver must pass the dma_address throu=
gh
> + * dma_address of scatterlist. When the driver got a used buffer from
> + * the vring, it has to unmap the dma address.
> + *
> + * This function must be called immediately after creating the vq, or
> after vq
> + * reset, and before adding any buffers to it.
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error.
> + * 0: success.
> + * -EINVAL: vring does not use the dma api, so we can not enable
> premapped mode.
> + */
> +int virtqueue_set_premapped(struct virtqueue *_vq)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       u32 num;
> +
> +       num =3D vq->packed_ring ? vq->packed.vring.num : vq->split.vring.=
num;
> +
> +       if (num !=3D vq->vq.num_free)
> +               return -EINVAL;
>

If we check this, I think we need to protect this with
START_USE()/END_USE().


> +
> +       if (!vq->use_dma_api)
> +               return -EINVAL;
>

Not a native spreak, but I think "dma_premapped" is better than "premapped"
as "dma_premapped" implies "use_dma_api".

Thanks


> +
> +       vq->premapped =3D true;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_set_premapped);
> +
>  /* Only available for split ring */
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
>                                       unsigned int num,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index de6041deee37..2efd07b79ecf 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -78,6 +78,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
>
>  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
>
> +int virtqueue_set_premapped(struct virtqueue *_vq);
> +
>  bool virtqueue_poll(struct virtqueue *vq, unsigned);
>
>  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
> --
> 2.32.0.3.g01195cf9f
>
>

--000000000000c40f31060045f186
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 11:42=E2=80=
=AFAM Xuan Zhuo &lt;<a href=3D"mailto:xuanzhuo@linux.alibaba.com">xuanzhuo@=
linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">This helper allows the driver change the dma mode to prema=
pped mode.<br>
Under the premapped mode, the virtio core do not do dma mapping<br>
internally.<br>
<br>
This just work when the use_dma_api is true. If the use_dma_api is false,<b=
r>
the dma options is not through the DMA APIs, that is not the standard<br>
way of the linux kernel.<br>
<br>
Signed-off-by: Xuan Zhuo &lt;<a href=3D"mailto:xuanzhuo@linux.alibaba.com" =
target=3D"_blank">xuanzhuo@linux.alibaba.com</a>&gt;<br>
---<br>
=C2=A0drivers/virtio/virtio_ring.c | 45 +++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0include/linux/virtio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A02 files changed, 47 insertions(+)<br>
<br>
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c<br=
>
index 87d7ceeecdbd..5ace4539344c 100644<br>
--- a/drivers/virtio/virtio_ring.c<br>
+++ b/drivers/virtio/virtio_ring.c<br>
@@ -172,6 +172,9 @@ struct vring_virtqueue {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Host publishes avail event idx */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool event;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Do DMA mapping by driver */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool premapped;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Head of free buffer list. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int free_head;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Number we&#39;ve added since last sync. */<b=
r>
@@ -2061,6 +2064,7 @@ static struct virtqueue *vring_create_virtqueue_packe=
d(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vq-&gt;packed_ring =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vq-&gt;dma_dev =3D dma_dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vq-&gt;use_dma_api =3D vring_use_dma_api(vdev);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vq-&gt;premapped =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vq-&gt;indirect =3D virtio_has_feature(vdev, VI=
RTIO_RING_F_INDIRECT_DESC) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !context;<br>
@@ -2550,6 +2554,7 @@ static struct virtqueue *__vring_new_virtqueue(unsign=
ed int index,<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vq-&gt;dma_dev =3D dma_dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vq-&gt;use_dma_api =3D vring_use_dma_api(vdev);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vq-&gt;premapped =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vq-&gt;indirect =3D virtio_has_feature(vdev, VI=
RTIO_RING_F_INDIRECT_DESC) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !context;<br>
@@ -2693,6 +2698,46 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,=
<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL_GPL(virtqueue_resize);<br>
<br>
+/**<br>
+ * virtqueue_set_premapped - set the vring premapped mode<br>
+ * @_vq: the struct virtqueue we&#39;re talking about.<br>
+ *<br>
+ * Enable the premapped mode of the vq.<br>
+ *<br>
+ * The vring in premapped mode does not do dma internally, so the driver m=
ust<br>
+ * do dma mapping in advance. The driver must pass the dma_address through=
<br>
+ * dma_address of scatterlist. When the driver got a used buffer from<br>
+ * the vring, it has to unmap the dma address.<br>
+ *<br>
+ * This function must be called immediately after creating the vq, or afte=
r vq<br>
+ * reset, and before adding any buffers to it.<br>
+ *<br>
+ * Caller must ensure we don&#39;t call this with other virtqueue operatio=
ns<br>
+ * at the same time (except where noted).<br>
+ *<br>
+ * Returns zero or a negative error.<br>
+ * 0: success.<br>
+ * -EINVAL: vring does not use the dma api, so we can not enable premapped=
 mode.<br>
+ */<br>
+int virtqueue_set_premapped(struct virtqueue *_vq)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vring_virtqueue *vq =3D to_vvq(_vq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 num;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0num =3D vq-&gt;packed_ring ? vq-&gt;packed.vrin=
g.num : vq-&gt;split.vring.num;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (num !=3D vq-&gt;vq.num_free)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>=
</blockquote><div><br></div><div>If we check this, I think we need to prote=
ct this with START_USE()/END_USE().</div><div>=C2=A0<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vq-&gt;use_dma_api)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>=
</blockquote><div><br></div><div>Not a native spreak, but I think &quot;dma=
_premapped&quot; is better than &quot;premapped&quot; as &quot;dma_premappe=
d&quot; implies &quot;use_dma_api&quot;.</div><div><br></div><div>Thanks</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vq-&gt;premapped =3D true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+EXPORT_SYMBOL_GPL(virtqueue_set_premapped);<br>
+<br>
=C2=A0/* Only available for split ring */<br>
=C2=A0struct virtqueue *vring_new_virtqueue(unsigned int index,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int nu=
m,<br>
diff --git a/include/linux/virtio.h b/include/linux/virtio.h<br>
index de6041deee37..2efd07b79ecf 100644<br>
--- a/include/linux/virtio.h<br>
+++ b/include/linux/virtio.h<br>
@@ -78,6 +78,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);<br>
<br>
=C2=A0unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);<br>
<br>
+int virtqueue_set_premapped(struct virtqueue *_vq);<br>
+<br>
=C2=A0bool virtqueue_poll(struct virtqueue *vq, unsigned);<br>
<br>
=C2=A0bool virtqueue_enable_cb_delayed(struct virtqueue *vq);<br>
-- <br>
2.32.0.3.g01195cf9f<br>
<br>
</blockquote></div></div>

--000000000000c40f31060045f186--


--===============5905904610071092614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5905904610071092614==--

