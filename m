Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897C137E
	for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350966; cv=none; b=sza/xkQppytypmkhQ8CGKuwNHGZbXkK3glCUQCCvt22vWwX8/xueVyV0LBKXhdU8tiGMvjoxkgnSY4OWFgG9knyOYmlPdDKguKILDxfbGBk5F1NPbNywO5Poja7I89/qGiGpI5ig+6oqksnOFx4yjoOeqAGsYyra+13i0xxt9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350966; c=relaxed/simple;
	bh=ssP1jVPg8sd9HM1MFutiAyB41wofOCNUt/B8SWda9hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ksb2NJCLlfpSYjv0jltS0hS/XxMCfHFp4IkmnL44dySfm3oDYfVDsBWtHwi54DZtnaAWys5hHp2PHtcDWGwziZ9W26iozTgaOrcl/JhqVbDcL4Zf9fDWH0gmCWeVstWWRtfiwsrOaRzw0BVKISK8/npaiNFrEq86cAi92LyU0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdJDWT3o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdJDWT3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721350964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRSaE06iHm1lpAkfBSdbhgUw/gaP3pFzc6w4e5ilsgk=;
	b=UdJDWT3oidicJhvnxmXIY0OncVvJJHNLezb2WoiHQasA08qpDVaufmjgar3GAn6CaA/EXX
	ycoq4NN0l40WTofJcpWA4PgZXOsRVB1Dlu1mgPCRZIDycHqh/jJwAMnkn4bI3DFZ+EOt1H
	jE7++9sx+OnAU76N46eo0PBMe6RYMos=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-n-Ftg3v8Nv2w4GK6ZSMfWA-1; Thu, 18 Jul 2024 21:02:42 -0400
X-MC-Unique: n-Ftg3v8Nv2w4GK6ZSMfWA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb685d5987so988619a91.2
        for <virtualization@lists.linux.dev>; Thu, 18 Jul 2024 18:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350962; x=1721955762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRSaE06iHm1lpAkfBSdbhgUw/gaP3pFzc6w4e5ilsgk=;
        b=r5lj2E/8dcPIVyR/j9qvwTgiUYP3JIaXk2xons7u/pzA2k7JAApUm36AmXxgt6DbIG
         o/8o6rimOjTsdmzExJTKKVy0DHwCWw/IgjhK9tyDZtpXUcphzm7U6WJzy22jkhHArzKg
         R1iuoKtFivyEwXwENSPaUuAqAVuNn7/82u9NfEdA7X8HMpolwlQjgdt7RTMPAVzgTbnD
         ow7626uqZDzwzlAd9Sc/t9XEoj1Yzb9FxR87cfgRJY/uxwPiipOPPWODluofvS8aP2Ty
         a1GJ4rmOunESXWnl7kWwB6gVyCly+FYZtySYoB+WvrFfldkzn9cvQcTxuNhLusII1jke
         8Krw==
X-Forwarded-Encrypted: i=1; AJvYcCWRuG1ASi0ZrvDKU0OY4ODH3+h6w6jMObnBkQ4w00Q/IMIoISTz3zpBAhN7ovkg+sHkrcLjENNLyt3onqabqXBLK6+Ji+qq+nzBI7AB3sg=
X-Gm-Message-State: AOJu0Yz+sxyipGUyCdzooME9WHgvbkqf/dMhXGWxIvhmWX5URIX1E6jg
	hukkUcUwyTs8U8qT8/CpJJ/Ka/HfN90+9NTbF3E4u9lBcmF7dWQe2zTQGqetjc/hYw2pjrRnuF/
	9V8n2KqZ/N6MDh0QkR/qM1UZjwE76MBlev3qpSVnNN4ABSsZccP/N51147pm0nuD54cfzVYoLYh
	xfBn+DfsjQzi0USWftZHS7DaSWYwiisDQEixb/BWs=
X-Received: by 2002:a17:90b:70b:b0:2c9:5c63:29f4 with SMTP id 98e67ed59e1d1-2cb773360eemr2375424a91.25.1721350961720;
        Thu, 18 Jul 2024 18:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO4PmCb6HCsLcpCTX7+pQS+hbt8McQL9YjmzCLoXlpXD9+R3TxIFIRGIBhygHbZmPLDNFndBQeKcYJI+L2igo=
X-Received: by 2002:a17:90b:70b:b0:2c9:5c63:29f4 with SMTP id
 98e67ed59e1d1-2cb773360eemr2375398a91.25.1721350961206; Thu, 18 Jul 2024
 18:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240709080214.9790-1-jasowang@redhat.com> <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org> <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
 <CACGkMEvDiQHfLaBRoaFtpYJHKTqicqbrpeZWzat43YveTa9Wyg@mail.gmail.com>
 <20240717015904-mutt-send-email-mst@kernel.org> <CACGkMEtntsAyddgrtxrbQe407dZkitac4ogC7cASF=iYgsum_A@mail.gmail.com>
In-Reply-To: <CACGkMEtntsAyddgrtxrbQe407dZkitac4ogC7cASF=iYgsum_A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Jul 2024 09:02:29 +0800
Message-ID: <CACGkMEsd63vH3J5m_4srO3ww2MWGOPc31L4171PfQ7uersN7PQ@mail.gmail.com>
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

On Wed, Jul 17, 2024 at 2:53=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jul 17, 2024 at 2:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Jul 17, 2024 at 09:19:02AM +0800, Jason Wang wrote:
> > > On Wed, Jul 10, 2024 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Tue, Jul 9, 2024 at 9:28=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > > > > This patch synchronize operstate with admin state per RFC2863.
> > > > > >
> > > > > > This is done by trying to toggle the carrier upon open/close an=
d
> > > > > > synchronize with the config change work. This allows propagate =
status
> > > > > > correctly to stacked devices like:
> > > > > >
> > > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > > ip link set link enp0s3 down
> > > > > > ip link show
> > > > > >
> > > > > > Before this patch:
> > > > > >
> > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast stat=
e DOWN mode DEFAULT group default qlen 1000
> > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > ......
> > > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mt=
u 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > >
> > > > > > After this patch:
> > > > > >
> > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast stat=
e DOWN mode DEFAULT group default qlen 1000
> > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > ...
> > > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> =
mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen=
 1000
> > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > >
> > > > > I think that the commit log is confusing. It seems to say that
> > > > > the issue fixed is synchronizing state with hardware
> > > > > config change.
> > > > > But your example does not show any
> > > > > hardware change. Isn't this example really just
> > > > > a side effect of setting carrier off on close?
> > > >
> > > > The main goal for this patch is to make virtio-net follow RFC2863. =
The
> > > > main thing that is missed is to synchronize the operstate with admi=
n
> > > > state, if we do this, we get several good results, one of the obvio=
us
> > > > one is to allow virtio-net to propagate status to the upper layer, =
for
> > > > example if the admin state of the lower virtio-net is down it shoul=
d
> > > > be propagated to the macvlan on top, so I give the example of using=
 a
> > > > stacked device. I'm not we had others but the commit log is probabl=
y
> > > > too small to say all of it.
> > >
> > > Michael, any more comments on this?
> > >
> > > Thans
> >
> >
> > Still don't get it, sorry.
> > > > > > This is done by trying to toggle the carrier upon open/close an=
d
> > > > > > synchronize with the config change work.
> > What does this sentence mean? What is not synchronized with config
> > change that needs to be?
>
> I meant,
>
> 1) maclvan depends on the linkwatch to transfer operstate from the
> lower device to itself.
> 2) ndo_open()/close() will not trigger the linkwatch so we need to do
> it by ourselves in virtio-net to make sure macvlan get the correct
> opersate
> 3) consider config change work can change the state so ndo_close()
> needs to synchronize with it
>
> Thanks

Michael, are you fine with the above or I miss something there?

Thanks

