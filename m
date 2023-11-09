Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF575695
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMEk1Saw"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1312408F5
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 04:45:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1312408F5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PMEk1Saw
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tfCy57eDW9lC
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 04:45:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 012DB408E9
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 04:45:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 012DB408E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699505149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nh+OheXPRInxC2fw6E13xlQ+H/XwSKIUTWgl8w4QNlA=;
	b=PMEk1SawXxsEIyajHdcGKeqiL8cPhL1KTcLOlv2cn3+qfS3RG9cRY0B8Tzy5XNB97UYGE9
	yz0Ga8+wBD8FlHXgqS2s/4xNNKlkkNcffQ6ZbwBaOzbiVJ058tznrKJuzx12Y8nRFjDckC
	oHn4l8Xhi+VSAMyiS2KTq7OIqNATshI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-WhD2pGgOPsCHaBXYk-bbwQ-1; Wed, 08 Nov 2023 23:45:48 -0500
X-MC-Unique: WhD2pGgOPsCHaBXYk-bbwQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507d2e150c2so387170e87.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 20:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699505147; x=1700109947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nh+OheXPRInxC2fw6E13xlQ+H/XwSKIUTWgl8w4QNlA=;
        b=uh/GvmSfBE64jcR/Hnr2dMCb/t+hwX/Ut3pB0ZuuEDTdHeGHy+9UbGkR6WYl59XMn7
         x8+2b7sl70ZHsB8f7c/9znSo2qDtXaGLPWsMUldmqbTAdhmChMClIboN0RYCnQoZUObM
         PdgDuR0ot8ur8oGeCEUI8+69O97lIVZD/UHRkKZXcgfOJjgqQGHruqL+Mq62CRBEYIpZ
         Ze+tlwQtlNAuK58awPpbxmG9kl6+Aw3yDrloyZPpT1aji8ecaBwziw05FtbPUPYeeChS
         LD6BWgndSGOZFAQGZCl9FfOX34lr7U0IWpe1De0IS7cwDqTgo2YnvyWW40CojflE2tXB
         ljFA==
X-Gm-Message-State: AOJu0YyCrCDT6ulwPkz1TMQ7pqPBFOHOkdsF7OzH9hS9vxe0Nw6zepgP
	HALxNHmHt8235dtocXAYmlhI6oeSNb6bJ/so5kLTSAI5gKPfOllCDLuYW8W6FT0VTXY/kgcwe8T
	C3r3FFsy7GYJ6htZU5q3czO9nnqmngyQF4gE5VPFCHlnAWNxxxXahordiJA==
X-Received: by 2002:a05:6512:24a:b0:507:9a05:1aed with SMTP id b10-20020a056512024a00b005079a051aedmr422532lfo.4.1699505147291;
        Wed, 08 Nov 2023 20:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGQMnknnnttfvBSMewmasPT2BjoSrq4FLu8yWvCTCIlglMuIJ7gAhwUlxK5SUgFrDof+u7pQyWySSesmhudN8=
X-Received: by 2002:a05:6512:24a:b0:507:9a05:1aed with SMTP id
 b10-20020a056512024a00b005079a051aedmr422508lfo.4.1699505146669; Wed, 08 Nov
 2023 20:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1698929590.git.hengqi@linux.alibaba.com> <4d57c072ca7d12034a1be4d9284e2be5988e1330.1698929590.git.hengqi@linux.alibaba.com>
In-Reply-To: <4d57c072ca7d12034a1be4d9284e2be5988e1330.1698929590.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 12:45:35 +0800
Message-ID: <CACGkMEt23Xm=dpwJMwX9dnwVjmQZqBp0SBxnpY19fgc=xMpcjA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/5] virtio-net: return -EOPNOTSUPP for adaptive-tx
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:10=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> We do not currently support tx dim, so respond to -EOPNOTSUPP.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> v1->v2:
> - Use -EOPNOTSUPP instead of specific implementation.
>
>  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5473aa1ee5cd..03edeadd0725 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3364,9 +3364,15 @@ static int virtnet_get_link_ksettings(struct net_d=
evice *dev,
>  static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
>                                           struct ethtool_coalesce *ec)
>  {
> +       bool tx_ctrl_dim_on =3D !!ec->use_adaptive_tx_coalesce;
>         struct scatterlist sgs_tx;
>         int i;
>
> +       if (tx_ctrl_dim_on) {
> +               pr_debug("Failed to enable adaptive-tx, which is not supp=
orted\n");
> +               return -EOPNOTSUPP;
> +       }

When can we hit this?

Thanks

> +
>         vi->ctrl->coal_tx.tx_usecs =3D cpu_to_le32(ec->tx_coalesce_usecs)=
;
>         vi->ctrl->coal_tx.tx_max_packets =3D cpu_to_le32(ec->tx_max_coale=
sced_frames);
>         sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx=
));
> @@ -3497,6 +3503,25 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struc=
t virtnet_info *vi,
>         return 0;
>  }
>
> +static int virtnet_send_tx_notf_coal_vq_cmds(struct virtnet_info *vi,
> +                                            struct ethtool_coalesce *ec,
> +                                            u16 queue)
> +{
> +       bool tx_ctrl_dim_on =3D !!ec->use_adaptive_tx_coalesce;
> +       int err;
> +
> +       if (tx_ctrl_dim_on) {
> +               pr_debug("Enabling adaptive-tx for txq%d is not supported=
\n", queue);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
> +                                              ec->tx_coalesce_usecs,
> +                                              ec->tx_max_coalesced_frame=
s);
> +
> +       return err;
> +}
> +
>  static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>                                           struct ethtool_coalesce *ec,
>                                           u16 queue)
> @@ -3507,9 +3532,7 @@ static int virtnet_send_notf_coal_vq_cmds(struct vi=
rtnet_info *vi,
>         if (err)
>                 return err;
>
> -       err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
> -                                              ec->tx_coalesce_usecs,
> -                                              ec->tx_max_coalesced_frame=
s);
> +       err =3D virtnet_send_tx_notf_coal_vq_cmds(vi, ec, queue);
>         if (err)
>                 return err;
>
> --
> 2.19.1.6.gb485710b
>

