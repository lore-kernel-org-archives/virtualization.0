Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0BA10A16
	for <virtualization@lists.linux.dev>; Thu, 25 Apr 2024 02:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714011134; cv=none; b=dk0U2bYZuJtyddCwu2FiG64S3fhayUap4MiOQbwfYeU2Lje/8vOH/foYt54R18yXhtuVAktW1kuvUA0EO+jQrnxoiU3BJZ5pa4lY4RGx4/pWE9MKHWwJXkvRw9/zEFUZSLN4JhJh0O1hG/t630VPpgQZpI3Pq9PvopebgQtHz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714011134; c=relaxed/simple;
	bh=yShuvNccjLyvICZ3HWa71xpZjSNMMVy9zeSiecZZBQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/vvGsiVKZHW8ji96jlYAgodsQVWLUo5TkM6/KoOY7PcPTatyLgp08PzRZ89T2zjmKucSySGA4kdukhspOu50RE+4pOKyOuImXudnz9iy27uoUDHcdQNqI2bGaMcTgRh+shQSBjD2WcsL7BL2sYTeyQKcWst1iREFLQNu65sgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpNSqWLa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpNSqWLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714011131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VieOJoodA3aQktmUt4XUYLH0Iv/muRLCMET0Cp2G8Wk=;
	b=UpNSqWLaUS7SiskqLfJdYiILHSpZg4JmhgKSMDLw/2bJVvSIrlG2zEGpVRPX1BDBz6qP0F
	ny4LEwdXgEcKXRGcZsl1LfIwqlThJyBQBiUUtvQcHMqg/2d5+gBm6t6lbJusE63qLSfUxj
	yl6ZVNRr3/bLPdjSOsXs1lHyyAEtbsw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-dIIdZmIYO4qTLP2Rvpd3bg-1; Wed, 24 Apr 2024 22:12:08 -0400
X-MC-Unique: dIIdZmIYO4qTLP2Rvpd3bg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-604bad9b2e8so582073a12.2
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 19:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714011127; x=1714615927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VieOJoodA3aQktmUt4XUYLH0Iv/muRLCMET0Cp2G8Wk=;
        b=ezpc/Out4DEmYYri/z3+DjTEW5gQqe1ch1I4OPCj14aebL8rmZWFmqS2a4axK4Xc71
         daXJMqJtlU19v8atW0ywB4nIUGJXceMRsR3i4j5ObbiUsbzz1E0IAqNo9RuJ3JEVss0R
         1hNLh6YxH7Hn2961dlVYPV9vkLhft1lExO3ngz84WMDgJT4JjcGeFKGgP5gE846OQfiv
         Zh/ft/diBU/jNLfvADBUsCfcplzH1S3CSq+1+bR58m0xv7Ou7HbplU/7H9fxkeRMbgFr
         OE9kKTDeRcE1aXRYAI9BgoUyMrDa4rQWOKuJE7B74b4U9pKBOBF5whWKwDe3KHNcye9v
         6z1Q==
X-Gm-Message-State: AOJu0YzqZXK1UiBCprZNnSsw0vaNKMhxe0RUrsQaRlkUza3r2oqNaVts
	xREV9m693ygFVAhNSoghYPPX7R2psx7Cg7Bpy7FxFy28D2sGMoCoBMjRBOi6yy2AZO401r7mrC5
	0LXcYxcwK04GBvTaXnT0+0+hSBdgcEKspqPL70UK/VUdtDezkpLN768aERgyFuUpNpFiJsrXusR
	wpqajGqDf1Lnlqa7ahGqN15XoVLmySeQvgDV8bhSf27EahxESuGQ==
X-Received: by 2002:a05:6a20:7f90:b0:1aa:5d76:1916 with SMTP id d16-20020a056a207f9000b001aa5d761916mr5294571pzj.34.1714011127342;
        Wed, 24 Apr 2024 19:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtdiizeK+BxYnb7LzT0xWj3CdDiw5EZJx2ei/mgBGSNkE5gfIWc7AbKJjR5bL2uY7hDXujeHJ1mq1UP9aZCVE=
X-Received: by 2002:a05:6a20:7f90:b0:1aa:5d76:1916 with SMTP id
 d16-20020a056a207f9000b001aa5d761916mr5294552pzj.34.1714011127014; Wed, 24
 Apr 2024 19:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com> <20240424081636.124029-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240424081636.124029-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Apr 2024 10:11:55 +0800
Message-ID: <CACGkMEtf9twxTSGpGpmcR4LYS_k1g=NRO78NhkG4uLJ3d+TqAA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 2/4] virtio_net: big mode skip the unmap check
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 4:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The virtio-net big mode did not enable premapped mode,
> so we did not need to check the unmap. And the subsequent
> commit will remove the failover code for failing enable
> premapped for merge and small mode. So we need to remove
> the checking do_dma code in the big mode path.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..16d84c95779c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -820,7 +820,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueu=
e *vq, void *buf)
>
>         rq =3D &vi->rq[i];
>
> -       if (rq->do_dma)
> +       if (!vi->big_packets || vi->mergeable_rx_bufs)

This seems to be equivalent to

if (!vi->big_packets)


>                 virtnet_rq_unmap(rq, buf, 0);
>
>         virtnet_rq_free_buf(vi, rq, buf);
> @@ -2128,7 +2128,7 @@ static int virtnet_receive(struct receive_queue *rq=
, int budget,
>                 }
>         } else {
>                 while (packets < budget &&
> -                      (buf =3D virtnet_rq_get_buf(rq, &len, NULL)) !=3D =
NULL) {
> +                      (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D NUL=
L) {
>                         receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &st=
ats);
>                         packets++;
>                 }

Other part looks good.

Thanks

> --
> 2.32.0.3.g01195cf9f
>

