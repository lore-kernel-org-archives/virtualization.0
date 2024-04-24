Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA12E62F
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930940; cv=none; b=CaDWnp/k0LEb+m5r1d3ergZRUvyLtmkhyugBa4fwUbs+IW935O0PqhZH+x6rfQzTKQXrqh1xvpKf81Ikyz6lytO7gFHDEV2z6vprU3Y71lpL1+GvyGAOGVQbIueTnwbMUssh96zz7CDEGl1l2SY/+4kcpprHYpXbufou7e3Lxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930940; c=relaxed/simple;
	bh=KKcgxasDyJFXqv/hgRIywTzUidpY5yGFOfGd8BXBmas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSeXMOwJbfsJ1vsLvbdP2a7887f/7qnC3HjT+7OkFTGLvg+8HpTBDxBq5+4u37UnMJWeD0NNr5/7JqxfctLeX+XBDczrdCJAipNq6Mwm7jQNZupccdoL2bYHGKjJjW+jKiDj36xwCqckZSVL0qaDUUEfdaQocHj9U1uwBM4Ef3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSC4oSBq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSC4oSBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pzndRW90+wqE5EwVxS+cBCK5mYVppdbl6Yx4ow+tjY=;
	b=RSC4oSBqXty50/kp0tewl1tu8bXMjKWtLu3BdvjkGA84D1ZU0KxBjw0axBbDxcfElvNqQj
	qwwvkllkgvUlKf/4KcxmKfpDu9ED/yfyRhNR6lAoMHiheDJDz+a32C0ciDj++Vl21j1LZ7
	vaycnXbR8q507N7IMw8QS5mZOlTCHGY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-ohHNy5__N8ekY47GbRSauA-1; Tue, 23 Apr 2024 23:55:36 -0400
X-MC-Unique: ohHNy5__N8ekY47GbRSauA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e2a5cb5455so73163445ad.2
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 20:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930936; x=1714535736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pzndRW90+wqE5EwVxS+cBCK5mYVppdbl6Yx4ow+tjY=;
        b=wcnS66H6OOle2jjZWwcM4Fer1oPsUNQY+kyi3SpcuX06+sH1gLyiuYSncdCJbT6gJz
         a50o/BJcfgDr3XGW1H02x7FuZ4EHyRZBVaCAflsxXhZzvpQo6Q9grKd3sd/CONdQLF1R
         m+Dxq43/juVKpt6zM2wrZ9yXWNJE516tPKCo2RKZ/7qhLhIr1f28HQlqMcrjCKkMP3pI
         oEnT1Wtg9A02zPKUEw936QjoPqY8iUEDdgfspOZv7+AjHfi6qh3ooRDn3/eVhVXEeNGD
         AQQHjjW6at6Q0QF8lQDPv/CawqI2lfJtb+69t+2DtX10/avcCXxC4fmLeH25Qczlhl/D
         /RFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjS6x3I8BS2ZOWdBk0csHka7xzwDS0uglCdrqefUZ0gsy1py4yo9w3dmrrOE3qGAIAm7Lgei3heswmemnUwxcFA6UmPW6clh+O7/G1/rY=
X-Gm-Message-State: AOJu0YxRJEZe648kaXP5z09XavxG7SYOGW8mbqmTQ1sEDn2wFJ9lz/6m
	04/OBsG0jfBNv55y3qL7HKoGTITsneKD9CMUVTX2GJj0T/rbVT9mu1Mlau81T0UTNK8+BstXCHF
	tJEFKO5J8T0HyGbMhAjFNqFwL/d+fy1CgQ8rMli30Fh1O2ajIJ3c4zfaeLYytKcUGh+YSVjTb/f
	Dv/XC/ZO/TWqV5j5pcV8jxum2GYM2homucPhCbPWM=
X-Received: by 2002:a17:902:9897:b0:1e2:82fc:bf71 with SMTP id s23-20020a170902989700b001e282fcbf71mr1296405plp.22.1713930935691;
        Tue, 23 Apr 2024 20:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgSdtzrZUnBDlB/5t9CYlcaU1yJjdPtWZ7q9A2G3rYLw3S9Y2o9HHDb07alKkZ1waM2Madn5EeKEjJMNpAHkY=
X-Received: by 2002:a17:902:9897:b0:1e2:82fc:bf71 with SMTP id
 s23-20020a170902989700b001e282fcbf71mr1296382plp.22.1713930935374; Tue, 23
 Apr 2024 20:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com> <20240423113141.1752-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240423113141.1752-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:55:24 +0800
Message-ID: <CACGkMEvoOqcazXxAt6KwShwJxtn=Z-sF7-yZr+JcUGL3Vk=S7g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 6/8] virtio_net: rename stat tx_timeout to timeout
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we have this:
>
>     tx_queue_0_tx_timeouts
>
> This is used to record the tx schedule timeout.
> But this has two "tx". I think the below is enough.
>
>     tx_queue_0_timeouts
>
> So I rename this field.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8a4d22f5f5b1..51ce2308f4f5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -87,7 +87,7 @@ struct virtnet_sq_stats {
>         u64_stats_t xdp_tx;
>         u64_stats_t xdp_tx_drops;
>         u64_stats_t kicks;
> -       u64_stats_t tx_timeouts;
> +       u64_stats_t timeouts;
>  };
>
>  struct virtnet_rq_stats {
> @@ -111,7 +111,7 @@ static const struct virtnet_stat_desc virtnet_sq_stat=
s_desc[] =3D {
>         VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
>         VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
>         VIRTNET_SQ_STAT("kicks",        kicks),
> -       VIRTNET_SQ_STAT("tx_timeouts",  tx_timeouts),
> +       VIRTNET_SQ_STAT("timeouts",     timeouts),

Not sure if it is too late to do this as it is noticeable by the userspace.

Thanks

>  };
>
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] =3D {
> @@ -2691,7 +2691,7 @@ static void virtnet_stats(struct net_device *dev,
>                         start =3D u64_stats_fetch_begin(&sq->stats.syncp)=
;
>                         tpackets =3D u64_stats_read(&sq->stats.packets);
>                         tbytes   =3D u64_stats_read(&sq->stats.bytes);
> -                       terrors  =3D u64_stats_read(&sq->stats.tx_timeout=
s);
> +                       terrors  =3D u64_stats_read(&sq->stats.timeouts);
>                 } while (u64_stats_fetch_retry(&sq->stats.syncp, start));
>
>                 do {
> @@ -4639,7 +4639,7 @@ static void virtnet_tx_timeout(struct net_device *d=
ev, unsigned int txqueue)
>         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, txqueue);
>
>         u64_stats_update_begin(&sq->stats.syncp);
> -       u64_stats_inc(&sq->stats.tx_timeouts);
> +       u64_stats_inc(&sq->stats.timeouts);
>         u64_stats_update_end(&sq->stats.syncp);
>
>         netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, name:=
 %s, %u usecs ago\n",
> --
> 2.32.0.3.g01195cf9f
>

