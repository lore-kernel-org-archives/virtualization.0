Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A46118
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpCB7I33"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64A8240614
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 04:19:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64A8240614
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bpCB7I33
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RN1fXBwQsHm7
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 04:19:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2CB85408BD
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 04:19:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CB85408BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699503549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvFRg1ozX36hxCbAKKGm/5hTz3pL2jXDwI2xdrZTOrY=;
	b=bpCB7I335J1JUnUEobSWcpvtzO5P76rRwV500RU/96WGOUkuDR7Pv6L12A+tyWhNm0kLYm
	/R+Bwt6JcORzw/UdZz+JgxK6J1SRuzsx1FiXmOaLgkW85blZaa1Tl6qvNmDMRiYb78nf37
	mXwIPE2Vk0ChR0UM3cFW51URe6lSfpY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-evrW6WcBNduTnbVnnXHn_A-1; Wed, 08 Nov 2023 23:19:06 -0500
X-MC-Unique: evrW6WcBNduTnbVnnXHn_A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c6f33ee403so3644811fa.2
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 20:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699503545; x=1700108345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvFRg1ozX36hxCbAKKGm/5hTz3pL2jXDwI2xdrZTOrY=;
        b=h8PswMqnS97H2kzKhaVtaOp1ZPyI/H2bE0cWDGQtZc5TYffe5bYGK7HdGELP3WpSYU
         nR5+X4hWs3jBIWagrbwI8uEwJnhzmxCQDyzNUU0Q6j4OJDsb/98rs3cTcbmTVaNAIm68
         T9XuRWivqyqPEeAm93eYofXCc3WlTAUSiRx32ddOVEx119D8Ackwwj1GeZe/qi7rr2z8
         S41NiPHAAD7cQIt/UTbun8DIMtczoA1Ljdq64UexMV5ee8oFCOs16NynkImEZUJSu3ks
         5+9wk1igvaAx9QTKp0r6btcbQO/S1ALFnntcFbnLGiG0jkPqQwfrkZg1nq2kzQ7hK4bk
         +FTQ==
X-Gm-Message-State: AOJu0YxUj4Tih/ilN1RO5QS6D2r+Bf7bYoK97HM+2SZzuPtOm3J7d6eK
	e23XKC9aVFJumL7O2sCZmdVDWGloqMvyj0Rk9ksDfCvPYCFur+AWajqk7nAZXuC+5fRX4EHVgqy
	ZfzywMRSPpbFAJhzAewP2beVL33qaN069upVRhQIaCYllZI/pA2Tf8ld2Ng==
X-Received: by 2002:a19:f81a:0:b0:500:9f7b:e6a4 with SMTP id a26-20020a19f81a000000b005009f7be6a4mr406458lff.32.1699503545316;
        Wed, 08 Nov 2023 20:19:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEna4e4m+nuJ6m9UCRfwD82ztP57+PYWew/vMSloocMkgV1HqDEFZ2nPbc+nONZVgQ8+jfAMBYtWw38iK4mxn8=
X-Received: by 2002:a19:f81a:0:b0:500:9f7b:e6a4 with SMTP id
 a26-20020a19f81a000000b005009f7be6a4mr406443lff.32.1699503544910; Wed, 08 Nov
 2023 20:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1698929590.git.hengqi@linux.alibaba.com> <a8dd10692a8291029afe283808a5b9051e1400b5.1698929590.git.hengqi@linux.alibaba.com>
In-Reply-To: <a8dd10692a8291029afe283808a5b9051e1400b5.1698929590.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 12:18:53 +0800
Message-ID: <CACGkMEsgJ_MO2cQh18sJjTRUWrWzsX7DgOSHs8GsdeiZY+OjWw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] virtio-net: separate rx/tx coalescing
 moderation cmds
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
> This patch separates the rx and tx global coalescing moderation
> commands to support netdim switches in subsequent patches.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v1->v2:
> - Add 'i' definition.
>
>  drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0ad2894e6a5e..0285301caf78 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3266,10 +3266,10 @@ static int virtnet_get_link_ksettings(struct net_=
device *dev,
>         return 0;
>  }
>
> -static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
> -                                      struct ethtool_coalesce *ec)
> +static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
> +                                         struct ethtool_coalesce *ec)
>  {
> -       struct scatterlist sgs_tx, sgs_rx;
> +       struct scatterlist sgs_tx;
>         int i;
>
>         vi->ctrl->coal_tx.tx_usecs =3D cpu_to_le32(ec->tx_coalesce_usecs)=
;
> @@ -3289,6 +3289,15 @@ static int virtnet_send_notf_coal_cmds(struct virt=
net_info *vi,
>                 vi->sq[i].intr_coal.max_packets =3D ec->tx_max_coalesced_=
frames;
>         }
>
> +       return 0;
> +}
> +
> +static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> +                                         struct ethtool_coalesce *ec)
> +{
> +       struct scatterlist sgs_rx;
> +       int i;
> +
>         vi->ctrl->coal_rx.rx_usecs =3D cpu_to_le32(ec->rx_coalesce_usecs)=
;
>         vi->ctrl->coal_rx.rx_max_packets =3D cpu_to_le32(ec->rx_max_coale=
sced_frames);
>         sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx=
));
> @@ -3309,6 +3318,22 @@ static int virtnet_send_notf_coal_cmds(struct virt=
net_info *vi,
>         return 0;
>  }
>
> +static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
> +                                      struct ethtool_coalesce *ec)
> +{
> +       int err;
> +
> +       err =3D virtnet_send_tx_notf_coal_cmds(vi, ec);
> +       if (err)
> +               return err;
> +
> +       err =3D virtnet_send_rx_notf_coal_cmds(vi, ec);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
>  static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>                                          u16 vqn, u32 max_usecs, u32 max_=
packets)
>  {
> --
> 2.19.1.6.gb485710b
>
>

