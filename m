Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8C1B948
	for <virtualization@lists.linux.dev>; Wed, 17 Jul 2024 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199205; cv=none; b=X6jrERfu2k0oPTR80DoU7mpiTakYks9u/3K91WgT5/Io16Tlv/T2cmokDCBoMDV22ujo8od0OhgNXWs8O39NBoJQ+4Kg+kXmwEq8qSqQOleZhut7yI14Ir83MQXybtQM9HX5/kF1J2Gsa5VZ5wOgwJx+zDeNzt9kaIfaw1dzL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199205; c=relaxed/simple;
	bh=uic/llVqAcebDBQyOtbh1hqN6xjJJmHzOFUf5hsJaeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0dNtmvWz3O8rxYknj/Ht9MwMiHELXrR6PiFgZtx9ib9jT7HG2De/SFgc52nujs3QH7PYXDkUdyFfkzBlm8yYaqZUJAQp63qIcEvZQxNANFJAPyBGoxnso3cA1Zsiigv2VxYfwrRX1cCIlW2XKAtKL/45EWz5zxL8gQiZuwwII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEyzfCwt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEyzfCwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721199202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3wUHZxtL7ge8mhgj3gN0VcPUpLkTBbNSymS6wzbPTc=;
	b=XEyzfCwts3AtCWQSgCr6+CjZq/ALBveraoMOsAE3VcodSTrorfmJXPo12TujiEttGSwY/L
	fKJwQqbekZ7r2tg6KmJE2YJQYdNLos7aYFP5yvA3La8ciJXP+uBxoaKRM1etVBhtijNaVd
	a1/6QHN1XO4OldMMWf+ujhmY8xbnodA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-LpQzUNd6OB2Jv4fLOPy7yw-1; Wed, 17 Jul 2024 02:53:20 -0400
X-MC-Unique: LpQzUNd6OB2Jv4fLOPy7yw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb50fbebd9so422084a91.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 23:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721199199; x=1721803999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3wUHZxtL7ge8mhgj3gN0VcPUpLkTBbNSymS6wzbPTc=;
        b=kOha6ZG+fihjv8W441LfKHkOevhXoRlW1yEfvCQdbuIXttWMgJLnfrW3vhbFIjQTEz
         0dK1njxeJ1aXnJABznvKwk/JRkyUCJwVB8EI/nyV09cPS6RRQlNi1KcuFJZlTgUMz+Tf
         n1N8G2G+4Efvm18biE0Nm5BumydSlY06M0z0bS92+h2IS3uGhWajwOAoTSSSPRRz493M
         lrZy2+zhJI2o773mhv037vulYjmKT2OLFAxHB1R0TRm6uRsuUQwa+Dgyj96mLSxLEK8v
         3B7KzXSiuUaMFMNy/mTUb76xaFPoy1ok8njf2BotGDUYD4EIF3yF85KPvqnqf68LRdnz
         rlhg==
X-Forwarded-Encrypted: i=1; AJvYcCUwRcR4lHIHAIyOvka185ca3GqeIdxkF2H+M6weO8Ri2VRIhI/dnbuqqfaic9WMEVyHKHUK4EhFaRIiSilHckeKsNuCitkVY3864LUoJr8=
X-Gm-Message-State: AOJu0YzDsI4s6N2njY1pl68a/arr0DGRk5Yj/ETd3wIAn+PmY5sCuYhS
	xj3pFfmgI8JO7K4MRmfdu4nWHANgvxQFjfmTfUpKbiGPATIxT0Oc4Ns7x1I5PfwQgj0lOJH61fQ
	DEbWfgpY7B9PG3VzZQH1/c3/MnjzS4ZxfGoHTkhJMo3Wpc42awBEWyokYNM5ArzEnMCgTR4dxnE
	SlhfJiDsE13c6rHO14i2xcI4D6JkV8ZkfJwIpqihA=
X-Received: by 2002:a17:90b:1403:b0:2ca:d1dc:47e2 with SMTP id 98e67ed59e1d1-2cb52932383mr569036a91.33.1721199199374;
        Tue, 16 Jul 2024 23:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8jCLQ6um85ikfqpsMh6S5Hr0/9SWrMBmLpya6//pJpEdr011a67n7T3S3/Qgfa2EU+bKqVpScjxBtk7rsJA0=
X-Received: by 2002:a17:90b:1403:b0:2ca:d1dc:47e2 with SMTP id
 98e67ed59e1d1-2cb52932383mr569015a91.33.1721199198891; Tue, 16 Jul 2024
 23:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240709080214.9790-1-jasowang@redhat.com> <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org> <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
 <CACGkMEvDiQHfLaBRoaFtpYJHKTqicqbrpeZWzat43YveTa9Wyg@mail.gmail.com> <20240717015904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240717015904-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Jul 2024 14:53:00 +0800
Message-ID: <CACGkMEtntsAyddgrtxrbQe407dZkitac4ogC7cASF=iYgsum_A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 17, 2024 at 09:19:02AM +0800, Jason Wang wrote:
> > On Wed, Jul 10, 2024 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Tue, Jul 9, 2024 at 9:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > > >
> > > > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > > > This patch synchronize operstate with admin state per RFC2863.
> > > > >
> > > > > This is done by trying to toggle the carrier upon open/close and
> > > > > synchronize with the config change work. This allows propagate st=
atus
> > > > > correctly to stacked devices like:
> > > > >
> > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > ip link set link enp0s3 down
> > > > > ip link show
> > > > >
> > > > > Before this patch:
> > > > >
> > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state =
DOWN mode DEFAULT group default qlen 1000
> > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > ......
> > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu =
1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > >
> > > > > After this patch:
> > > > >
> > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state =
DOWN mode DEFAULT group default qlen 1000
> > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > ...
> > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mt=
u 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1=
000
> > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > I think that the commit log is confusing. It seems to say that
> > > > the issue fixed is synchronizing state with hardware
> > > > config change.
> > > > But your example does not show any
> > > > hardware change. Isn't this example really just
> > > > a side effect of setting carrier off on close?
> > >
> > > The main goal for this patch is to make virtio-net follow RFC2863. Th=
e
> > > main thing that is missed is to synchronize the operstate with admin
> > > state, if we do this, we get several good results, one of the obvious
> > > one is to allow virtio-net to propagate status to the upper layer, fo=
r
> > > example if the admin state of the lower virtio-net is down it should
> > > be propagated to the macvlan on top, so I give the example of using a
> > > stacked device. I'm not we had others but the commit log is probably
> > > too small to say all of it.
> >
> > Michael, any more comments on this?
> >
> > Thans
>
>
> Still don't get it, sorry.
> > > > > This is done by trying to toggle the carrier upon open/close and
> > > > > synchronize with the config change work.
> What does this sentence mean? What is not synchronized with config
> change that needs to be?

I meant,

1) maclvan depends on the linkwatch to transfer operstate from the
lower device to itself.
2) ndo_open()/close() will not trigger the linkwatch so we need to do
it by ourselves in virtio-net to make sure macvlan get the correct
opersate
3) consider config change work can change the state so ndo_close()
needs to synchronize with it

Thanks

