Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248F0EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 07:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B65D60B38;
	Wed, 12 Jul 2023 07:35:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B65D60B38
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KvKILagB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h8Rqnb__MSsA; Wed, 12 Jul 2023 07:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6D1D60B32;
	Wed, 12 Jul 2023 07:35:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6D1D60B32
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D433C0071;
	Wed, 12 Jul 2023 07:35:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E854C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 794CD403E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:35:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 794CD403E9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KvKILagB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VM74DchlXPKM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:35:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E8BC40194
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E8BC40194
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689147351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WH/4Ems2mfhffGi2vC78WpF6GNjKx3SGMKS37D3r+ds=;
 b=KvKILagBUPhtTB6/041hYqLwFO0w9EmvN8R1/DN/1fqq3zO/jUWAchD3xGS/eTSwNzWRri
 J2eqbGV9tW9LfxGgAhlxUebLLV1wZUscZ9KePT1Lqr+zzoRx6Yfl2Z+A5NNr1+tp2dDNZK
 sxGgfMfR7D94hwIW4YEv3aNCGsCtXws=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-lrUXC-_NOrazDKcpKmBu8A-1; Wed, 12 Jul 2023 03:35:49 -0400
X-MC-Unique: lrUXC-_NOrazDKcpKmBu8A-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6f97c9d54so64687941fa.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 00:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689147348; x=1691739348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WH/4Ems2mfhffGi2vC78WpF6GNjKx3SGMKS37D3r+ds=;
 b=Frl16+zoXqGoU7QFnIeseFen4VUfwR0yn7fDD8IAnDjkSSJjJ1JtG7Zh2TGDKYODZf
 ys/CMdbcKr138ANEAwiZhceivs2mV49EPTnm/9cQ//d3mDicjMlGStE8xuatavjCHetK
 KMDGU4KIo4R/UzyC38kj02OlaooZ+pvIqjQjkIoONOXzUj/BVlyXDpOJnpyG8wnkkKcl
 gYcEO2y+tNujL77QWc88KOtvneV3Zdnivh5MMlQBD3oUTJSYB/rrMmuKYW8izCkvNypc
 mxavnV5cGw5C1AnHP0sGf6e3AufjPdgpcVgYAgF/Tb+YbWaPfbAuWsyP2aKAKBgahRW9
 RaWQ==
X-Gm-Message-State: ABy/qLZ/8x9MNkfEefqw4RD7IQaUIBk5zlJqTn5/iGlUcSzCNqHS3eW4
 Rwtjp/a3yJIgJ4Lue7vyVQ4jK07ZT4jgExM9ZdwwTkL+xvqOIJNCIh8tLIPk13EFBs7cvFVb6es
 Q9jcaelh7GVbbXux9WE3jpuiN/dI7yn3Ce6ZXSF7FQUPqxxhIq2PwHap9aQ==
X-Received: by 2002:a2e:9e58:0:b0:2b6:e12f:267 with SMTP id
 g24-20020a2e9e58000000b002b6e12f0267mr4971389ljk.5.1689147348310; 
 Wed, 12 Jul 2023 00:35:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGCWkDTwEws+wOWyoQGXDKlZ0eQQkt/1Lkr25aVzIo2kwlQ0au/2D2r4rw4spmS3GeIikUFdQYMgIhpBGJVUFw=
X-Received: by 2002:a2e:9e58:0:b0:2b6:e12f:267 with SMTP id
 g24-20020a2e9e58000000b002b6e12f0267mr4971379ljk.5.1689147348035; Wed, 12 Jul
 2023 00:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230710092005.5062-2-gavinl@nvidia.com>
In-Reply-To: <20230710092005.5062-2-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 15:35:34 +0800
Message-ID: <CACGkMEuVHqj4v+UZsk1wLJt1OP7Gm36LUEEUu4a4b4Nk2a0ciw@mail.gmail.com>
Subject: Re: [PATCH net-next V1 1/4] virtio_net: extract interrupt coalescing
 settings to a structure
To: Gavin Li <gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, hawk@kernel.org, daniel@iogearbox.net,
 mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, edumazet@google.com, jiri@nvidia.com, kuba@kernel.org,
 bpf@vger.kernel.org, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============0137520694728263292=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0137520694728263292==
Content-Type: multipart/alternative; boundary="000000000000a740460600454341"

--000000000000a740460600454341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 5:21=E2=80=AFPM Gavin Li <gavinl@nvidia.com> wrote:

> Extract interrupt coalescing settings to a structure so that it could be
> reused in other data structures.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0db14f6b87d3..dd5fec073a27 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -126,6 +126,11 @@ static const struct virtnet_stat_desc
> virtnet_rq_stats_desc[] =3D {
>  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_desc)
>  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_desc)
>
> +struct virtnet_interrupt_coalesce {
> +       u32 max_packets;
> +       u32 max_usecs;
> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>         /* Virtqueue associated with this send _queue */
> @@ -281,10 +286,8 @@ struct virtnet_info {
>         u32 speed;
>
>         /* Interrupt coalescing settings */
> -       u32 tx_usecs;
> -       u32 rx_usecs;
> -       u32 tx_max_packets;
> -       u32 rx_max_packets;
> +       struct virtnet_interrupt_coalesce intr_coal_tx;
> +       struct virtnet_interrupt_coalesce intr_coal_rx;
>
>         unsigned long guest_offloads;
>         unsigned long guest_offloads_capable;
> @@ -3056,8 +3059,8 @@ static int virtnet_send_notf_coal_cmds(struct
> virtnet_info *vi,
>                 return -EINVAL;
>
>         /* Save parameters */
> -       vi->tx_usecs =3D ec->tx_coalesce_usecs;
> -       vi->tx_max_packets =3D ec->tx_max_coalesced_frames;
> +       vi->intr_coal_tx.max_usecs =3D ec->tx_coalesce_usecs;
> +       vi->intr_coal_tx.max_packets =3D ec->tx_max_coalesced_frames;
>
>         vi->ctrl->coal_rx.rx_usecs =3D cpu_to_le32(ec->rx_coalesce_usecs)=
;
>         vi->ctrl->coal_rx.rx_max_packets =3D
> cpu_to_le32(ec->rx_max_coalesced_frames);
> @@ -3069,8 +3072,8 @@ static int virtnet_send_notf_coal_cmds(struct
> virtnet_info *vi,
>                 return -EINVAL;
>
>         /* Save parameters */
> -       vi->rx_usecs =3D ec->rx_coalesce_usecs;
> -       vi->rx_max_packets =3D ec->rx_max_coalesced_frames;
> +       vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_usecs;
> +       vi->intr_coal_rx.max_packets =3D ec->rx_max_coalesced_frames;
>
>         return 0;
>  }
> @@ -3132,10 +3135,10 @@ static int virtnet_get_coalesce(struct net_device
> *dev,
>         struct virtnet_info *vi =3D netdev_priv(dev);
>
>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
> -               ec->rx_coalesce_usecs =3D vi->rx_usecs;
> -               ec->tx_coalesce_usecs =3D vi->tx_usecs;
> -               ec->tx_max_coalesced_frames =3D vi->tx_max_packets;
> -               ec->rx_max_coalesced_frames =3D vi->rx_max_packets;
> +               ec->rx_coalesce_usecs =3D vi->intr_coal_rx.max_usecs;
> +               ec->tx_coalesce_usecs =3D vi->intr_coal_tx.max_usecs;
> +               ec->tx_max_coalesced_frames =3D vi->intr_coal_tx.max_pack=
ets;
> +               ec->rx_max_coalesced_frames =3D vi->intr_coal_rx.max_pack=
ets;
>         } else {
>                 ec->rx_max_coalesced_frames =3D 1;
>
> @@ -4119,10 +4122,10 @@ static int virtnet_probe(struct virtio_device
> *vdev)
>         }
>
>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
> -               vi->rx_usecs =3D 0;
> -               vi->tx_usecs =3D 0;
> -               vi->tx_max_packets =3D 0;
> -               vi->rx_max_packets =3D 0;
> +               vi->intr_coal_rx.max_usecs =3D 0;
> +               vi->intr_coal_tx.max_usecs =3D 0;
> +               vi->intr_coal_tx.max_packets =3D 0;
> +               vi->intr_coal_rx.max_packets =3D 0;
>         }
>
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
> --
> 2.39.1
>
>

--000000000000a740460600454341
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 5:21=E2=80=AF=
PM Gavin Li &lt;<a href=3D"mailto:gavinl@nvidia.com">gavinl@nvidia.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Extra=
ct interrupt coalescing settings to a structure so that it could be<br>
reused in other data structures.<br>
<br>
Signed-off-by: Gavin Li &lt;<a href=3D"mailto:gavinl@nvidia.com" target=3D"=
_blank">gavinl@nvidia.com</a>&gt;<br>
Reviewed-by: Dragos Tatulea &lt;<a href=3D"mailto:dtatulea@nvidia.com" targ=
et=3D"_blank">dtatulea@nvidia.com</a>&gt;<br>
Reviewed-by: Jiri Pirko &lt;<a href=3D"mailto:jiri@nvidia.com" target=3D"_b=
lank">jiri@nvidia.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/virtio_net.c | 35 +++++++++++++++++++----------------<br>
=C2=A01 file changed, 19 insertions(+), 16 deletions(-)<br></blockquote><di=
v><br></div><div>Acked-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat=
.com">jasowang@redhat.com</a>&gt;</div><div><br></div><div>Thanks</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c<br>
index 0db14f6b87d3..dd5fec073a27 100644<br>
--- a/drivers/net/virtio_net.c<br>
+++ b/drivers/net/virtio_net.c<br>
@@ -126,6 +126,11 @@ static const struct virtnet_stat_desc virtnet_rq_stats=
_desc[] =3D {<br>
=C2=A0#define VIRTNET_SQ_STATS_LEN=C2=A0 =C2=A0ARRAY_SIZE(virtnet_sq_stats_=
desc)<br>
=C2=A0#define VIRTNET_RQ_STATS_LEN=C2=A0 =C2=A0ARRAY_SIZE(virtnet_rq_stats_=
desc)<br>
<br>
+struct virtnet_interrupt_coalesce {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_packets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 max_usecs;<br>
+};<br>
+<br>
=C2=A0/* Internal representation of a send virtqueue */<br>
=C2=A0struct send_queue {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Virtqueue associated with this send _queue *=
/<br>
@@ -281,10 +286,8 @@ struct virtnet_info {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 speed;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Interrupt coalescing settings */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tx_usecs;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 rx_usecs;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tx_max_packets;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 rx_max_packets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtnet_interrupt_coalesce intr_coal_tx;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtnet_interrupt_coalesce intr_coal_rx;=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long guest_offloads;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long guest_offloads_capable;<br>
@@ -3056,8 +3059,8 @@ static int virtnet_send_notf_coal_cmds(struct virtnet=
_info *vi,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Save parameters */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;tx_usecs =3D ec-&gt;tx_coalesce_usecs;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;tx_max_packets =3D ec-&gt;tx_max_coalesc=
ed_frames;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;intr_coal_tx.max_usecs =3D ec-&gt;tx_coa=
lesce_usecs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;intr_coal_tx.max_packets =3D ec-&gt;tx_m=
ax_coalesced_frames;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vi-&gt;ctrl-&gt;coal_rx.rx_usecs =3D cpu_to_le3=
2(ec-&gt;rx_coalesce_usecs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vi-&gt;ctrl-&gt;coal_rx.rx_max_packets =3D cpu_=
to_le32(ec-&gt;rx_max_coalesced_frames);<br>
@@ -3069,8 +3072,8 @@ static int virtnet_send_notf_coal_cmds(struct virtnet=
_info *vi,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Save parameters */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;rx_usecs =3D ec-&gt;rx_coalesce_usecs;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;rx_max_packets =3D ec-&gt;rx_max_coalesc=
ed_frames;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;intr_coal_rx.max_usecs =3D ec-&gt;rx_coa=
lesce_usecs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;intr_coal_rx.max_packets =3D ec-&gt;rx_m=
ax_coalesced_frames;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -3132,10 +3135,10 @@ static int virtnet_get_coalesce(struct net_device *=
dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtnet_info *vi =3D netdev_priv(dev);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virtio_has_feature(vi-&gt;vdev, VIRTIO_NET_=
F_NOTF_COAL)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ec-&gt;rx_coalesce_=
usecs =3D vi-&gt;rx_usecs;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ec-&gt;tx_coalesce_=
usecs =3D vi-&gt;tx_usecs;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ec-&gt;tx_max_coale=
sced_frames =3D vi-&gt;tx_max_packets;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ec-&gt;rx_max_coale=
sced_frames =3D vi-&gt;rx_max_packets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ec-&gt;rx_coalesce_=
usecs =3D vi-&gt;intr_coal_rx.max_usecs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ec-&gt;tx_coalesce_=
usecs =3D vi-&gt;intr_coal_tx.max_usecs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ec-&gt;tx_max_coale=
sced_frames =3D vi-&gt;intr_coal_tx.max_packets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ec-&gt;rx_max_coale=
sced_frames =3D vi-&gt;intr_coal_rx.max_packets;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ec-&gt;rx_max_coale=
sced_frames =3D 1;<br>
<br>
@@ -4119,10 +4122,10 @@ static int virtnet_probe(struct virtio_device *vdev=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virtio_has_feature(vi-&gt;vdev, VIRTIO_NET_=
F_NOTF_COAL)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;rx_usecs =3D=
 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;tx_usecs =3D=
 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;tx_max_packe=
ts =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;rx_max_packe=
ts =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;intr_coal_rx=
.max_usecs =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;intr_coal_tx=
.max_usecs =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;intr_coal_tx=
.max_packets =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;intr_coal_rx=
.max_packets =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_=
REPORT))<br>
-- <br>
2.39.1<br>
<br>
</blockquote></div></div>

--000000000000a740460600454341--


--===============0137520694728263292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0137520694728263292==--

