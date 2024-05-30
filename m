Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4A15B153
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065009; cv=none; b=Uqd+bSOSnNnX+0IkBL1VnH8a/6EKSUcN40bePgLq36qaTGUv23dExEgOI8UPmYCmdc96Okj1McD0UptxdNYYgQc0s7LsbBXfN4wuZ7q7YeR85g0nnXK8XZijKDEQUsv9Q7rccp2gD0ARvcxLvaZGn0ndtdcfXFXw5Roe3Id6870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065009; c=relaxed/simple;
	bh=mVHva8M32IxDEuPKEKgHcF5zqbOYLYjPtVGp80CqZ68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amnSK3M77UGjQTYJkTs1scwYbT0LeJMaxbBxIOHT8ojVbM1escxnIauODZOcfwHxw0njFaLlsRvzJF3et/g6gkckHbBadAPuHRk48BKYVRZPsD9gsbP8rjyJwLS75LwrshETFggPLAp7VEu5gevpT5A5nesjbmlewPsh8+g8164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/LCCiuA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/LCCiuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717065006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXuu0VhYv/Sqtsmj/xee9XrMd/ZRARenPycPxIhwC84=;
	b=G/LCCiuA2T41HAuHVieZymegU6tGYjFLTKArSRVruAaw/uEqDDR51nYCyLfRZ6CXTCxkTD
	ajf3NCUgDHgUTtZMq1iCV8vthFB4+5X7R4q6WDLiTTpE6nfdenpJrfbKPMkYJQi/HMXIXs
	QJDGMndDmxKbvnjHygwAvUV/vi6qyAA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-tUDfWMYRNw2H9OhNO0bkRw-1; Thu, 30 May 2024 06:30:04 -0400
X-MC-Unique: tUDfWMYRNw2H9OhNO0bkRw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1a23d1382so694529a91.0
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 03:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717065004; x=1717669804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXuu0VhYv/Sqtsmj/xee9XrMd/ZRARenPycPxIhwC84=;
        b=S0GZs6hfNnu12YgkqELRUYIGrRboPlN1JnE/NL5ow4h8FyPe3n27AfZ/78OMAEkRyP
         udWqUD+3Eq0qUAJp/pF7GF9xCP9dxk2Br0ydL3RbDs4C/LMMcolhTlrwd4p4dw/crL1o
         ybIOvFHd0AYHiMftgSZBKn0p/dd0mX0KIS0lBVUH3bPumkw9v4KqLk6lubxs8ONx+Sht
         6aTBqiJXxruRB7HcbUZf04zUK1+dr8+a185AiLM4mRww2RLe1dJZu7O16AED5FIfVvIS
         opKYlCEtzVPqyUIaOuLbN4MDQr8njPRrRyYF9dwKRD8Y1DmJ149wZMKDZJQUSsHZxRRJ
         KJGA==
X-Forwarded-Encrypted: i=1; AJvYcCU4oIuXDvhQP25ryeVxhr0bk7BO48s5rDCDoFXrwL0mxTVuKkuTiPP7U5DdqV0MUfpyZ28rCyIhLk/yJ+ElIcV3MA56X7Xozw3Rz4xdDMo=
X-Gm-Message-State: AOJu0Yz8lZS/8HXnfwx25Y3N9cIpvCPj4b5vRmDIJ9mOAoNfB40j0Jx+
	nJNVnE965NSFj11gowfGHzxJs5lpNpV9IEmGZJ+fKpf1pCziNnUuoqCrrZEOupjZpgEX+QNIlG4
	r2umLq2H+ZsTtnilTW8aV5YqHGSO/zMq6Jndme3Qn3BTIPV4ojd2F10n6zP1OOH2FLgYGDG12QV
	r1l/Cv5FUiIfalghJ2fHA1d150AjcN2C2EW4F5qlg=
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id 98e67ed59e1d1-2c1aabe9d88mr2621233a91.0.1717065003794;
        Thu, 30 May 2024 03:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA7U478P9i05qqxnNKG+nvSy+yQhk/wrEg2bbs8tGfMLiA4XTvaTHtx1q3ccmrbRhBHVyV89R4f4eHnf4hT+E=
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id
 98e67ed59e1d1-2c1aabe9d88mr2621210a91.0.1717065003379; Thu, 30 May 2024
 03:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530020531-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 18:29:51 +0800
Message-ID: <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
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

On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > This patch synchronize operstate with admin state per RFC2863.
> >
> > This is done by trying to toggle the carrier upon open/close and
> > synchronize with the config change work. This allows propagate status
> > correctly to stacked devices like:
> >
> > ip link add link enp0s3 macvlan0 type macvlan
> > ip link set link enp0s3 down
> > ip link show
> >
> > Before this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ......
> > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 q=
disc noqueue state UP mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > After this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ...
> > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500=
 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - rebase
> > - add ack/review tags
>
>
>
>
>
> > ---
> >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-------------
> >  1 file changed, 63 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 4a802c0ea2cb..69e4ae353c51 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -433,6 +433,12 @@ struct virtnet_info {
> >       /* The lock to synchronize the access to refill_enabled */
> >       spinlock_t refill_lock;
> >
> > +     /* Is config change enabled? */
> > +     bool config_change_enabled;
> > +
> > +     /* The lock to synchronize the access to config_change_enabled */
> > +     spinlock_t config_change_lock;
> > +
> >       /* Work struct for config space updates */
> >       struct work_struct config_work;
> >
>
>
> But we already have dev->config_lock and dev->config_enabled.
>
> And it actually works better - instead of discarding config
> change events it defers them until enabled.
>

Yes but then both virtio-net driver and virtio core can ask to enable
and disable and then we need some kind of synchronization which is
non-trivial.

And device enabling on the core is different from bringing the device
up in the networking subsystem. Here we just delay to deal with the
config change interrupt on ndo_open(). (E.g try to ack announce is
meaningless when the device is down).

Thanks

