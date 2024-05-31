Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7D6AB9
	for <virtualization@lists.linux.dev>; Fri, 31 May 2024 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114696; cv=none; b=ZoZA63h0B+mstk/w5uv9U+64jFLZMWmdxH+iKM3ARsnJ4Wbz8jaBj7jfcvqX6smcMKTnjltKlTWEWONjutNQU4Oz4Np9bwTumW+Cxfjw2a+GOQ4bpd9jG3kz81Wg0d5VWuErRKNUTm+47W10nIgTidCAfg5+0hq97pYnW/tMKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114696; c=relaxed/simple;
	bh=KNXVkfWiz4Q50vCls1kWwILJ5qinN5zXnC4J+4f1Haw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/lkQDLOtv6DPx2JYKGdvIatf8h39GSZ3OTM5ZONa1F9VZHu2KMb0JWG9oSKwdFzNd/+ut2hpg0K1FeNf5jPgqCPzy8kVxixP2oDt/+EYrbkDxn5A2Ebi1FvyVj2Mpug9kP8oFzrAL7yiSJLLnkcTpMM67pL1StBmdW8gVQlLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJrJEChX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJrJEChX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717114694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jGk8SEMK5Bvtc/9k59FnMjRJyI8k1VJ2cg/HKGkhc4=;
	b=EJrJEChXPnVsS+OcqArUM4mqrFgU4x0z+c8JDI4QIQEjB3J0eLXicJeGHij14WxnPClZpN
	eJCuiJKMGVBnkgX7bfKIVQdstrINo7TWYhkNidWjRLxK50ZksI5qWYEVHLAErfteEmAVs3
	3mFK94jM5NTKPMooN5J9kmYdgwG5Wno=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-_v_sH825NIKQcGLJX7lkjA-1; Thu, 30 May 2024 20:18:13 -0400
X-MC-Unique: _v_sH825NIKQcGLJX7lkjA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2bf5e099692so1368560a91.0
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 17:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717114692; x=1717719492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jGk8SEMK5Bvtc/9k59FnMjRJyI8k1VJ2cg/HKGkhc4=;
        b=VeUqqehz+3HVfmVYbGsJpcIif2spKq4xgLKSlwYyMVv9z8ExhsK8PORBBYQ9qlYBPN
         kfoP7C77ppV/1ugVWhVnPsGmqbKb1cRqdlhNQqWdIA90m6Oxu0Wpuj/a1heBAfSre0ZI
         aifbl+P++OqsurA9fl1BP3Xa34v9pDZXW1Kt855RonBKs8qrnxRC5bjDMFmkjJfhSUGX
         cxoOAADkkC8W0fnHX0ZT4a+ay6MZgVOxHTPb0UgFeD5HlNDDV2vgtqpiRxYM35UGXUS0
         f5OjRLU0JbanJOoZYidoovJOAp7IASq1OMiMXjunpxpusvHDT1OBRfTHKp+5YRW64ObC
         QoMw==
X-Forwarded-Encrypted: i=1; AJvYcCW+cnIrJEfBa0Ftlwv8qkhI06Ebm9aPBnse6vbqndLE37FE8atRZFdfRYZzqnhqapD6egvSKNZPKwv4wfMYg11gdqsZEpkLVC/o9/b7ol8=
X-Gm-Message-State: AOJu0YxONQulYsgqjBu6nrKKCJkJOXuhjIHQuQf3PQNJNwhnG+fxPoZF
	ZMJy/kQhGSqNNbCtPIk6KPgo1Q8uQ8EBI9mrNXT1lXWBgZmJFQ0zqN2Pw+HrS5T7zWIAouUT0WR
	bn2FhSXasOEVewSuN98z17vPxcVRbL1teajJoPXlO1D9TIMRcrLuu3ogCIcYut9EMUjz4fvqacS
	MU6NvCSspUJhKv64wNvSPzC3AxWlrbeCGfF5/3BYs=
X-Received: by 2002:a17:90a:e28d:b0:2b9:e009:e47a with SMTP id 98e67ed59e1d1-2c1acc3d22cmr4688031a91.10.1717114691895;
        Thu, 30 May 2024 17:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGtxuo6Bp6PN93cBewrcbzjLxTqiGmrfw4AWkEQU+ceUU0PXzAO9ChgAQ0Le5dYGJn1ZxgaARLQjE0Gw2KYLs=
X-Received: by 2002:a17:90a:e28d:b0:2b9:e009:e47a with SMTP id
 98e67ed59e1d1-2c1acc3d22cmr4687990a91.10.1717114691232; Thu, 30 May 2024
 17:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com> <20240530090742-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530090742-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 May 2024 08:18:00 +0800
Message-ID: <CACGkMEsYRCJ96=sja9pBo_mnPsp75Go6E-wmm=-QX0kaOu4RFQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2] virtio-net: synchronize operstate with admin
 state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 9:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, May 30, 2024 at 06:29:51PM +0800, Jason Wang wrote:
> > On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > > This patch synchronize operstate with admin state per RFC2863.
> > > >
> > > > This is done by trying to toggle the carrier upon open/close and
> > > > synchronize with the config change work. This allows propagate stat=
us
> > > > correctly to stacked devices like:
> > > >
> > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > ip link set link enp0s3 down
> > > > ip link show
> > > >
> > > > Before this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ......
> > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 15=
00 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > After this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ...
> > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu =
1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 100=
0
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > > Changes since V1:
> > > > - rebase
> > > > - add ack/review tags
> > >
> > >
> > >
> > >
> > >
> > > > ---
> > > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++---------=
----
> > > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > > >       /* The lock to synchronize the access to refill_enabled */
> > > >       spinlock_t refill_lock;
> > > >
> > > > +     /* Is config change enabled? */
> > > > +     bool config_change_enabled;
> > > > +
> > > > +     /* The lock to synchronize the access to config_change_enable=
d */
> > > > +     spinlock_t config_change_lock;
> > > > +
> > > >       /* Work struct for config space updates */
> > > >       struct work_struct config_work;
> > > >
> > >
> > >
> > > But we already have dev->config_lock and dev->config_enabled.
> > >
> > > And it actually works better - instead of discarding config
> > > change events it defers them until enabled.
> > >
> >
> > Yes but then both virtio-net driver and virtio core can ask to enable
> > and disable and then we need some kind of synchronization which is
> > non-trivial.
>
> Well for core it happens on bring up path before driver works
> and later on tear down after it is gone.
> So I do not think they ever do it at the same time.

For example, there could be a suspend/resume when the admin state is down.

>
>
> > And device enabling on the core is different from bringing the device
> > up in the networking subsystem. Here we just delay to deal with the
> > config change interrupt on ndo_open(). (E.g try to ack announce is
> > meaningless when the device is down).
> >
> > Thanks
>
> another thing is that it is better not to re-read all config
> on link up if there was no config interrupt - less vm exits.

Yes, but it should not matter much as it's done in the ndo_open().

Thanks

>
> --
> MST
>

