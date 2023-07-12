Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F387CEB64D9
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 07:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8325860B55;
	Wed, 12 Jul 2023 07:40:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8325860B55
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=djYAFDTj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CxEkqpQIcLQp; Wed, 12 Jul 2023 07:40:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D27F760B42;
	Wed, 12 Jul 2023 07:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D27F760B42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1F01C0071;
	Wed, 12 Jul 2023 07:40:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31EBBC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F21D060B44
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F21D060B44
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 48pIA0zujR51
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:40:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1740960B42
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1740960B42
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689147608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zyW2kkYgF1sFy9eNrDpLS4gtJ1VU9t38sQPrhUnbJU=;
 b=djYAFDTjhZ7J3Bth1f9H1b6kzpNbTElDaObVe0PfZkRmHihXVfjrPbb7S82v2t+vc3aRZV
 Idj24OxwTjBnKYuzNjozgf8DuZFXQQqnhb3CGVUXhaamuVJyFy3RlQFOz0PVZ9iu/IzVhR
 ZxuI4JDQweTEq4UEz6VakFo6H/9PfjQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-XAcgwL_vOGWxJ1W0a-nteQ-1; Wed, 12 Jul 2023 03:40:07 -0400
X-MC-Unique: XAcgwL_vOGWxJ1W0a-nteQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6fbed5189so63240921fa.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 00:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689147605; x=1691739605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+zyW2kkYgF1sFy9eNrDpLS4gtJ1VU9t38sQPrhUnbJU=;
 b=TAFVz10BT5OsUeeY8sG1Pun6ccyhWjTitPdf7fCPg138JIrstGAx/lOS3K8edlDgBl
 oTBivqZ9WChxoMmkaeqMUFq6npS+3iUX6y6wtsFs0HzV6Wln7j160nQkPeR+B6DwNUon
 MjCtc9urbphUjSj4Q15GlJK6OhF4tDzj8TdjAeIefnUIiJbjZBtWshkZPRK29lbcclV/
 /i5likp/+7zBZKhYwQMxRovuPkxz0uLdUrY3r52c1afD6rR3FCqCrWe7cNr/98DFv8ap
 q2EUvZhlleY/367TJ9ZAg7Y7IXSpcmJd0JVmmznC0mOrPvOBRHnU6pyQ+/2M4uLr5GC2
 03Ew==
X-Gm-Message-State: ABy/qLYvQ6Pqmyj+te4ZXbYN6EscNnRxWyEmyE0FMwpTeik74u0JYrlE
 K1qBglexgRGSdSrqErbiwP9bOWC2R14Hr7nmvjc7Y9Q2SRQQs+7dj0+NjAUhfEhmVIsCK69e24n
 LywqQ3iiAEQJJcA1h3tLdLgY2d7avVKiF1rKWemwpWHcRpFXKSBcd/MIiEQ==
X-Received: by 2002:a2e:9192:0:b0:2b6:cf31:5e81 with SMTP id
 f18-20020a2e9192000000b002b6cf315e81mr16334540ljg.20.1689147605761; 
 Wed, 12 Jul 2023 00:40:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHSbz5gByn+NQp1zc0np9L1tef/6xxyKE3BU5JILopzsbIQfDCSI1bD61cTonm7vyFxlLr1H4SuM/+bWBQNgLU=
X-Received: by 2002:a2e:9192:0:b0:2b6:cf31:5e81 with SMTP id
 f18-20020a2e9192000000b002b6cf315e81mr16334518ljg.20.1689147605475; Wed, 12
 Jul 2023 00:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230710092005.5062-3-gavinl@nvidia.com>
In-Reply-To: <20230710092005.5062-3-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 15:39:53 +0800
Message-ID: <CACGkMEsXC-BLvt2RuF99_veiKnYrnrg3rJNhoeP7FhCFSWbgAA@mail.gmail.com>
Subject: Re: [PATCH net-next V1 2/4] virtio_net: extract get/set interrupt
 coalesce to a function
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
Content-Type: multipart/mixed; boundary="===============1987077463591309567=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1987077463591309567==
Content-Type: multipart/alternative; boundary="000000000000ff7d5106004552a5"

--000000000000ff7d5106004552a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 5:21=E2=80=AFPM Gavin Li <gavinl@nvidia.com> wrote:

> Extract get/set interrupt coalesce to a function to be reused by global
> and per queue config.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd5fec073a27..802ed21453f5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3093,10 +3093,8 @@ static int virtnet_coal_params_supported(struct
> ethtool_coalesce *ec)
>         return 0;
>  }
>
> -static int virtnet_set_coalesce(struct net_device *dev,
> -                               struct ethtool_coalesce *ec,
> -                               struct kernel_ethtool_coalesce
> *kernel_coal,
> -                               struct netlink_ext_ack *extack)
> +static int virtnet_set_coalesce_one(struct net_device *dev,
> +                                   struct ethtool_coalesce *ec)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
>         int ret, i, napi_weight;
> @@ -3127,10 +3125,16 @@ static int virtnet_set_coalesce(struct net_device
> *dev,
>         return ret;
>  }
>
> -static int virtnet_get_coalesce(struct net_device *dev,
> +static int virtnet_set_coalesce(struct net_device *dev,
>                                 struct ethtool_coalesce *ec,
>                                 struct kernel_ethtool_coalesce
> *kernel_coal,
>                                 struct netlink_ext_ack *extack)
> +{
> +       return virtnet_set_coalesce_one(dev, ec);
> +}
> +
> +static int virtnet_get_coalesce_one(struct net_device *dev,
> +                                   struct ethtool_coalesce *ec)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
>
> @@ -3149,6 +3153,14 @@ static int virtnet_get_coalesce(struct net_device
> *dev,
>         return 0;
>  }
>
> +static int virtnet_get_coalesce(struct net_device *dev,
> +                               struct ethtool_coalesce *ec,
> +                               struct kernel_ethtool_coalesce
> *kernel_coal,
> +                               struct netlink_ext_ack *extack)
> +{
> +       return virtnet_get_coalesce_one(dev, ec);
> +}
> +
>  static void virtnet_init_settings(struct net_device *dev)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> --
> 2.39.1
>
>

--000000000000ff7d5106004552a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 5:21=E2=80=AF=
PM Gavin Li &lt;<a href=3D"mailto:gavinl@nvidia.com">gavinl@nvidia.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Extra=
ct get/set interrupt coalesce to a function to be reused by global<br>
and per queue config.<br>
<br>
Signed-off-by: Gavin Li &lt;<a href=3D"mailto:gavinl@nvidia.com" target=3D"=
_blank">gavinl@nvidia.com</a>&gt;<br>
Reviewed-by: Dragos Tatulea &lt;<a href=3D"mailto:dtatulea@nvidia.com" targ=
et=3D"_blank">dtatulea@nvidia.com</a>&gt;<br>
Reviewed-by: Jiri Pirko &lt;<a href=3D"mailto:jiri@nvidia.com" target=3D"_b=
lank">jiri@nvidia.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/virtio_net.c | 22 +++++++++++++++++-----<br>
=C2=A01 file changed, 17 insertions(+), 5 deletions(-)<br></blockquote><div=
><br></div><div>Acked-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.=
com">jasowang@redhat.com</a>&gt;</div><div><br></div><div>Thanks</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c<br>
index dd5fec073a27..802ed21453f5 100644<br>
--- a/drivers/net/virtio_net.c<br>
+++ b/drivers/net/virtio_net.c<br>
@@ -3093,10 +3093,8 @@ static int virtnet_coal_params_supported(struct etht=
ool_coalesce *ec)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
-static int virtnet_set_coalesce(struct net_device *dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ethtool_coalesce *ec,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct kernel_ethtool_coalesce *kerne=
l_coal,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct netlink_ext_ack *extack)<br>
+static int virtnet_set_coalesce_one(struct net_device *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ethtool_coalesce=
 *ec)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtnet_info *vi =3D netdev_priv(dev);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret, i, napi_weight;<br>
@@ -3127,10 +3125,16 @@ static int virtnet_set_coalesce(struct net_device *=
dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
-static int virtnet_get_coalesce(struct net_device *dev,<br>
+static int virtnet_set_coalesce(struct net_device *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ethtool_coalesce *ec,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct kernel_ethtool_coalesce *kern=
el_coal,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct netlink_ext_ack *extack)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return virtnet_set_coalesce_one(dev, ec);<br>
+}<br>
+<br>
+static int virtnet_get_coalesce_one(struct net_device *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ethtool_coalesce=
 *ec)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtnet_info *vi =3D netdev_priv(dev);<b=
r>
<br>
@@ -3149,6 +3153,14 @@ static int virtnet_get_coalesce(struct net_device *d=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+static int virtnet_get_coalesce(struct net_device *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ethtool_coalesce *ec,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct kernel_ethtool_coalesce *kerne=
l_coal,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct netlink_ext_ack *extack)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return virtnet_get_coalesce_one(dev, ec);<br>
+}<br>
+<br>
=C2=A0static void virtnet_init_settings(struct net_device *dev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtnet_info *vi =3D netdev_priv(dev);<b=
r>
-- <br>
2.39.1<br>
<br>
</blockquote></div></div>

--000000000000ff7d5106004552a5--


--===============1987077463591309567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1987077463591309567==--

