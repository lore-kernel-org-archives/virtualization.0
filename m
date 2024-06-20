Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00581A8C19
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878852; cv=none; b=mhJ5cOZWD5SzjIyGS00ScIJOI8qFkDXt6EYXvcMtVobKEFGxm+F6EbIoaXgySGygyFO8yBIaEsfshHYuPdT4R4sv4hBb76Nw9MPYuCDSZIYrWnybgDLaYq7P8aXyibxF6s+BrMQuXJ4kkVH9s+frORdmp8u75pMI1vIDgK4AFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878852; c=relaxed/simple;
	bh=gczrT+YOeWocMYEIaimWNIgFEdYSuxh7hjUrL4u+IW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kjhp3DDBhQi2idPm3UdeCFF/6zquZ8mK47+LEtWRTw6fXjDhi8Pa5wrRgatVD1n7hLo4kgVksGkSzs092wUcDTacgIfOvKALfV4kPVGqri3vsrPhvq9lkl2Nww672DxW3YtAovuAXHpwx/+AZca++QRgTQfzlvkbWSKxT1OmsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPzPpDzf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPzPpDzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3r9ncjkOVFhOAZFNXHCnpm8+Pr1541j01m64f/aGCoY=;
	b=WPzPpDzfvCRNkikZDXG2LTNKF4BVFfRccHhetTBOTDRxONrzOzOo6M8GFTq335fmKwkFfn
	EqsPK0bInXiS5UoCjKM7HDYeD0alOw+i1QXYJcLmbMgWK6x9ljUeHh+gGI6tNgiGm9W/HN
	Y7FaoFyv2pSSX08Xe3E8CH5iNOg18/k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-9byi7JbWOq6rjP4JeaTLqg-1; Thu, 20 Jun 2024 06:20:48 -0400
X-MC-Unique: 9byi7JbWOq6rjP4JeaTLqg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42180d2a0d6so1251475e9.1
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 03:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878847; x=1719483647;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doeZzZgMg0C1MhSn62H08XIInC3nAwcvpGw3Aktx0Zk=;
        b=ojJt/S0hawXMNs9AttEK0kr7MyXczyo28/OwsoqnU7YBfvD0t156ZeIG2yrn13Whdu
         SqSu7lci4p6sVPVAuucVOKQng6vepMR4mBGzu6Be6jBkL73NkQVLnj2LhaF9XQ1mTU95
         9ipf9P5nmg/KDlOU0QuPopSQkf4shsE+FogTWmmVx3aKzzkquhFv44vGWyF0GZyxK3QD
         f7gr3zsJ+T6AdMMP2/9w57IKFURp4R//3Qq2krwwEUUDi92ihHCXEZVUgmL+D3G2uJen
         ohvWp6YLeJiIqRzlS3983uWmTTF5ml36YOy7B6o5hxF0VzWWmIlnnUs5mUeCeg5VTf9V
         2/aA==
X-Forwarded-Encrypted: i=1; AJvYcCUvBmyCLtkUK+98KexKtGoF39PR+voY6EZQi/voxtJDg0b8UpfSCCK6e40gdH90WZYCcRv7cqiXKSnlGzTyaLdKiZLCeQxct8P5MHswAJE=
X-Gm-Message-State: AOJu0Yw34PrFa4Cv6cEaRSGB9LAe9+/yr7e5sGiNhARxCsouVqpPYJGr
	R4oa1uWDz9nrryVtjLd/mfyp+m3lF59g+xILsXTHNWcOgG/VjKH6Fcum4XcfhaP5w1eU7b77Zo2
	hQMeoKsCj0Lxrr3eTF87sKd573xx9cqdC7wpLRljrVlAAQUyRMsbwHlvRcTMZ1l6G
X-Received: by 2002:a05:600c:511d:b0:423:445:4aad with SMTP id 5b1f17b1804b1-42475016e88mr35681385e9.0.1718878846926;
        Thu, 20 Jun 2024 03:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV4/Rcl9kCDoWNGsxPLqkw/FELky+0wJBIrIbAGOmhEFKuOljMvUlHhojAQKG12CMNKPEYRw==
X-Received: by 2002:a05:600c:511d:b0:423:445:4aad with SMTP id 5b1f17b1804b1-42475016e88mr35681245e9.0.1718878846575;
        Thu, 20 Jun 2024 03:20:46 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0b7:b110::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208e08sm20779235e9.35.2024.06.20.03.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:20:46 -0700 (PDT)
Message-ID: <3554649e61063491cc3a04222c7dff68d46c2f99.camel@redhat.com>
Subject: Re: [PATCH net-next v6 07/10] virtio_net: xsk: rx: support fill
 with xsk buffer
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
  Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>,  virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Date: Thu, 20 Jun 2024 12:20:44 +0200
In-Reply-To: <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
	 <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> @@ -1032,6 +1034,53 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>  =09}
>  }
> =20
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +=09sg->dma_address =3D addr;
> +=09sg->length =3D len;
> +}
> +
> +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> +=09=09=09=09   struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +=09struct xdp_buff **xsk_buffs;
> +=09dma_addr_t addr;
> +=09u32 len, i;
> +=09int err =3D 0;

Minor nit: the reverse xmas tree order is based on the full line len,
should be:
=09int err =3D 0;
=09u32 len, i;

[...]
> @@ -2226,6 +2281,7 @@ static bool try_fill_recv(struct virtnet_info *vi, =
struct receive_queue *rq,
>  =09=09u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
>  =09}
> =20
> +=09oom =3D err =3D=3D -ENOMEM;
>  =09return !oom;

Minor nit: 'oom' is used only in the above to lines. You could drop
such variable and just:
=09return err !=3D -ENOMEM;

Please _do not_ repost just for the above, but please include such
changes if you should repost for other reasons.

Also try to include a detailed changelog in each patch after the tag
area and a '---' separator, it will simplify the review process.

Thanks,

Paolo

