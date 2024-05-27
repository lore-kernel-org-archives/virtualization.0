Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD21FBA
	for <virtualization@lists.linux.dev>; Mon, 27 May 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781148; cv=none; b=SChLRVEyY8b8oDLOTFb8JbQR6E8sGF1zvZMdGQH7Vywsau2nkY4UIJ0KCJMjoflWJPqqbQ3cKGH6ZEpxBs4POHWk4m6RbwZt+CAUbrLR/k4nR74F2y917WfCFMxjj++04jtSx1qJwWmlp1FuqHhfziVWQWmcxWPOwKPaD/lQMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781148; c=relaxed/simple;
	bh=fdj7qcTBnfmjPivAlTmVXqQmhx2raXN5Bmy44kdZv6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fruncp7ZefMS5AIy8T3GfZDo/kiNpr+RDcP+nGqjAtVqkWCZCqFe4zNtkHD6glHYyUDqQYo8Mebr6G7t9yyfkWM/3+0mAhtfABb4vLLHWmmHai47aWmJ0c21BBGBWDpGphwv7lujBmyD+wUlF2v39opz7uBYV7Bu9ywGyFadheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/nVkCoO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/nVkCoO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716781145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JcK820oahZByDVbNCRHJXrV2NxV94VFprz1qwfAJfA=;
	b=S/nVkCoOk/rmABHK8GRbKyxxSvW434Hd+tnue6xN69yN8ui9gZ6V1WLDHwUgKs1Hzfuitg
	diBel08H+Vlw2/s9njEPg0qNIebvVxiIsnOBF9mXOatF/1wnYe7JjfsMyIDJInA+UX3BL+
	11Xn/9UvDABe4rWEF3atIC9t1pjdkI0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-3MzvehqlNwmYz9j53NfQYg-1; Sun, 26 May 2024 23:39:03 -0400
X-MC-Unique: 3MzvehqlNwmYz9j53NfQYg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f44b428f7eso30446975ad.0
        for <virtualization@lists.linux.dev>; Sun, 26 May 2024 20:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716781142; x=1717385942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JcK820oahZByDVbNCRHJXrV2NxV94VFprz1qwfAJfA=;
        b=EA14waoM5LJyon5R5NYd0WH7jpXT8oLjafv0FXEznNDUab2MunBpgD3U4e2tRa5Wps
         vLy9IrCJICSOtJNImmQeyLS2/KN+eDZYpaipB6K7wqB7rBmv74oPplnaTdOlGKe/opEW
         qBWUzx7czJbSeD0F+j1s75J8E/deY5ENrS/KiGKfZyf0dtoNtcFp8+QFPq36Ax8yNBnV
         CqnefT5KoaAMezvup0wQiy5NQz37TdPK80BzV5PVkUUP6frF+dDf4IbvfpgWFiSsW7+p
         yx20+Speb4iMCZRprS3ChqvIQ6yyhMLgdLR25d3xwu86Jc/Zqkk0LTiVgmvcw1p4mg8L
         AAmw==
X-Forwarded-Encrypted: i=1; AJvYcCUe1s0t5QNhFXELPMqF7uCEuV03pShpkY1JAyXa2w/YeK/j7adxWxksAmwJTMJ4PBmw15RK0gjiB0JpJrHIZdtsjgN3mKF3vJvIrJlkLcc=
X-Gm-Message-State: AOJu0YwCN5FHrtnpWluGDaeeIaVjhbQMJ4+mGRBkJGJspfpMc1e9otjU
	6lilsHDcLNla8TeiFrkHKShtFyCF6FjY3mR7KnaOox0Rr47ym5wNPZbV//pj9O29xVivhfUPooZ
	KaCz6nC2jvxjs/810ON9fG7pf+B08CgVwR47hR/PgJJp83tBtGFlox8khZbxG4nvTTgLJsSlNLf
	Z7bphwyyZY39e1ijXVqsGNAkVO/suHYLZDYNuzVFY=
X-Received: by 2002:a17:902:c404:b0:1f4:8faa:cd5e with SMTP id d9443c01a7336-1f48faad33bmr37000485ad.30.1716781142033;
        Sun, 26 May 2024 20:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGksnTdLTpRZS7DCpHp2eNh1LCkUpAnxjqyRVIr2Kuz/YTy9VuQVPjxTNnHPSFE1E1LPaoruVC43jLFjLONHes=
X-Received: by 2002:a17:902:c404:b0:1f4:8faa:cd5e with SMTP id
 d9443c01a7336-1f48faad33bmr37000265ad.30.1716781141626; Sun, 26 May 2024
 20:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <1716431200.2626963-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1716431200.2626963-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 May 2024 11:38:49 +0800
Message-ID: <CACGkMEsKgwgATiuiA4_DcrwtoGp4XT__GakKVYNJ=EcOOG9zew@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] virtnet_net: prepare for af-xdp
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 10:27=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Any comments for this.
>
> Thanks.

Will have a look.

Btw, does Michael happy with moving files into a dedicated directory?

Thanks

>
> On Wed,  8 May 2024 16:05:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > This patch set prepares for supporting af-xdp zerocopy.
> > There is no feature change in this patch set.
> > I just want to reduce the patch num of the final patch set,
> > so I split the patch set.
> >
> > #1-#3 add independent directory for virtio-net
> > #4-#7 do some refactor, the sub-functions will be used by the subsequen=
t commits
> >
> > Thanks.
> >
> > Xuan Zhuo (7):
> >   virtio_net: independent directory
> >   virtio_net: move core structures to virtio_net.h
> >   virtio_net: add prefix virtnet to all struct inside virtio_net.h
> >   virtio_net: separate virtnet_rx_resize()
> >   virtio_net: separate virtnet_tx_resize()
> >   virtio_net: separate receive_mergeable
> >   virtio_net: separate receive_buf
> >
> >  MAINTAINERS                                   |   2 +-
> >  drivers/net/Kconfig                           |   9 +-
> >  drivers/net/Makefile                          |   2 +-
> >  drivers/net/virtio/Kconfig                    |  12 +
> >  drivers/net/virtio/Makefile                   |   8 +
> >  drivers/net/virtio/virtnet.h                  | 246 ++++++++
> >  .../{virtio_net.c =3D> virtio/virtnet_main.c}   | 534 ++++++----------=
--
> >  7 files changed, 452 insertions(+), 361 deletions(-)
> >  create mode 100644 drivers/net/virtio/Kconfig
> >  create mode 100644 drivers/net/virtio/Makefile
> >  create mode 100644 drivers/net/virtio/virtnet.h
> >  rename drivers/net/{virtio_net.c =3D> virtio/virtnet_main.c} (94%)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>

