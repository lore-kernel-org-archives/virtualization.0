Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654AA1D90DD
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382225; cv=none; b=cgW3A3VrsaAnlPJ24s78t+S7Ru12bHU9CbB4iBkZT//dZ+6JKTQNYPTCuDgfqhG2yoH3XXHYjQ/mVTkX8vFfOpHxAXpVMAV14rAxB5crTOx5xpLjA845Khyk1c1TJFptbjdevDH+EyGX9Lf1rru0GrDw3185g55ppUU9fSXLhkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382225; c=relaxed/simple;
	bh=/iR6H4jr1ARWE/5biMkgTQ9VIqRD+A+nSoB7kUdSyCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgD/CUI3jGlzrBHaqv2xBDRzAuBvKA/1gCE0IUqHFWPvXuKlmE0QSfDHUKwDhNbta4I8E6gB7No3F7Ny7HAzykpyi/te5sb45Jp3IfeAsrBPRms0PnM1CoNoCMD1zW06otTZbn5MpGdMV29HmTQ0iqoERWveiQqeeAAO84n5+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9jFbFUF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9jFbFUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773382223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEKsLbbuK4rqjcbBkQvwfGzKzEsUkH5eDtzU9/JBt0o=;
	b=f9jFbFUFpI1YqROXXpn6L34J5CZZuHFGwBy1uHhxDt4y3LTBfWoN0w4xDVijn5wSA6L7+G
	jbrbWuqxIQfsplRcQ0jYPdsYlxIz6EwbXABR21qy+4olhLoHGp9cCQnks3Ujl5CxFgxL8a
	vw/eBofcqki2H5MpvY8b1SupjxWY0jM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-q4CXRATvPNCjl0EiEhf0NQ-1; Fri, 13 Mar 2026 02:10:20 -0400
X-MC-Unique: q4CXRATvPNCjl0EiEhf0NQ-1
X-Mimecast-MFC-AGG-ID: q4CXRATvPNCjl0EiEhf0NQ_1773382219
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-359fe456655so1334724a91.3
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 23:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382219; x=1773987019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEKsLbbuK4rqjcbBkQvwfGzKzEsUkH5eDtzU9/JBt0o=;
        b=fxftr8QZywb8oCtoZMi4U4wig9AfVpyUbsrRYoYd9wRGJ+I/laaVUBLHPj+3/0H4rg
         WGQr5ySHndlCa21B0ST7nuCp+5DeVcA5UVkRANEb8t2SNNHd15UjCBDR4YfjP+HG3YM5
         H8UR1M7YYISb5lwSBD08H9/lh3eTxpipXuDEyg3dDEWn5JbzUMED3Dwv8ystcLkmXHLm
         ZLLIswwCD9uzPHC/X8spyLxWWGSH/B0+V/ER0u5tX5/4bHQBFg29M07Nmjsz5QxpsQQH
         6VrmmkanNWp5npYKHbTQ41UuvSXpRjdSIyp9ZvSQYZsW10gOmRzQN5dYD6yy5WrEcaKs
         2plA==
X-Forwarded-Encrypted: i=1; AJvYcCUFwE+gv6xNf/HGRx1ilS/HMkluh32iVwI/KDLEAZlw6ix4rUdFgwBx6sFl4bCk/dZ0nrHGgT8TaneAtJbNIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLJzzs3s9tWGCNBfC4t/z1Ht/V4EsgLJG9IVXEIH7L4467OaP0
	RNndM0MMsBtXei2Wg0F4h6s2PPETb4CgVSV4zxZ60bfKrgMaNW2BSGDBfGLuJgb0SyT0HVhmD0X
	rG0bbzETZjwhM+ZRosm3wDLl3GfvPxKAF2alGQbIryu0Sy5Js1OyLgyLWGr9kpE9sKHVkiHp0ZG
	coMKinGJ/98Wt0OGeMGhzD9i/YigW5/WSdFLO1vX2wtGY=
X-Gm-Gg: ATEYQzydjJ3Zr8k4xZkMDNuqaKorBBW5JSeoObPTnQkdUMXhZkGUo4ICDKMMvS8YTjl
	P6uBwK7HiIGzVTfUN3vzYXqXR2rIpj+aWmu1tOoJgXhgX7fWOQyAYL0SYRX+m2lroEw8KVSvzIP
	sxNKWDM9qaCcc+JYyL8Ec22Imcgs6e2n1rRhGCrHDQPTGfTXMYGWd00U56B/zXTFEnxRY2J4otZ
	04=
X-Received: by 2002:a05:6a20:72a4:b0:398:c0ba:9ceb with SMTP id adf61e73a8af0-398eca31fb6mr1855049637.12.1773382218937;
        Thu, 12 Mar 2026 23:10:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a4:b0:398:c0ba:9ceb with SMTP id
 adf61e73a8af0-398eca31fb6mr1855016637.12.1773382218487; Thu, 12 Mar 2026
 23:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260313013040.896924-1-zhud@hygon.cn>
In-Reply-To: <20260313013040.896924-1-zhud@hygon.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Mar 2026 14:10:06 +0800
X-Gm-Features: AaiRm504cXpHm99uEXVGnGiUvzq_5LRcfaS9FMPZmiSnxPRP_JS7ljpAlHy91qU
Message-ID: <CACGkMEvwR2WWyKvho-WU=_06OmWsYTSDSkML9JS9pSkzOQVkTA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: clear NETIF_F_GRO_HW if no GRO-related
 offloads are capable
To: Di Zhu <zhud@hygon.cn>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, lijing@hygon.cn, yingzhiwei@hygon.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0J36YCx0gniISP5Y7su17jdIdzgPlXPgMaWGbCxf418_1773382219
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 9:37=E2=80=AFAM Di Zhu <zhud@hygon.cn> wrote:
>
> Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which indicates
> the device supports dynamic control of guest offloads, it does not
> necessarily mean the device supports specific hardware GRO features.
>
> If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such as
> TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable, the
> device effectively lacks the hardware capability to perform GRO.
>
> In this case, NETIF_F_GRO_HW should be cleared from dev->hw_features
> to prevent the stack from attempting to enable an unsupported
> hardware offload configuration.
>
> Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> Signed-off-by: Di Zhu <zhud@hygon.cn>
> ---
>  drivers/net/virtio_net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..49a60af684d5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -7058,6 +7058,9 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>         }
>         vi->guest_offloads_capable =3D vi->guest_offloads;
>
> +       if (!(vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> +               dev->hw_features &=3D ~NETIF_F_GRO_HW;
> +

It looks to me the root cause is this during probe?

        if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
                dev->hw_features |=3D NETIF_F_GRO_HW;

Thanks

>         rtnl_unlock();
>
>         err =3D virtnet_cpu_notif_add(vi);
> --
> 2.34.1
>
>

