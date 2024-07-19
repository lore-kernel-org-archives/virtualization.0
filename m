Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526423A0
	for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351991; cv=none; b=ESPgIPrOp3iDkXQ1bK0idAB9IalAziTTn1nZPtn6wIMTqymgBonMUESwwOdnpLE/bHx/z8kxYwc4s3T2SaeYjG4mYBPLJPi6bofL/cQjgcG8QmMgOWJH0rfaWfUt/vvrDGa4wHEESotQ/pQaVsf6YyICtMMn/LcvT6b83lGPRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351991; c=relaxed/simple;
	bh=93QVP4WJoS9Hpv2j9SWPhGJjYy+NR2J0K6SXL1NRHxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ill2yyjPrALBz7SVcPNywgAYAi8dmfnAjrwzpW4MLpfYtP52Zt9rAt/mp3cViWW7qtOT3fDPYhIwj8DhwEfTBCuFo50M/wshY7rje4SlfLyCS6vXRXgqJ843emKRUT9I/4qgGcQxCLhtGNWKElP0cckDD6QB2aPsjwtAU9dpnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9jYEYUA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9jYEYUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721351988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwmop9WL4f0jJYAYbZ5p9p7R5dVY3Lpor/+2jEVRnP0=;
	b=H9jYEYUAt03F3GOZPrAfeMp/DLE9rLbZHSJr0SEXCBGhGJndkPfGXISQ0gOrb/yybTC7rs
	jT7HK018KyRgM6IKnnp5ptslC7LkR05lG3WO7ZSOSCb669NuGc9So1qm9m1xs4dV4k76Ov
	y9/Dwmai/dlUnkJC73pvtkix0yd5QSg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-FoS--FWRO9eDa6NkUC5onQ-1; Thu, 18 Jul 2024 21:19:47 -0400
X-MC-Unique: FoS--FWRO9eDa6NkUC5onQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-368448dfe12so137540f8f.1
        for <virtualization@lists.linux.dev>; Thu, 18 Jul 2024 18:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721351986; x=1721956786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwmop9WL4f0jJYAYbZ5p9p7R5dVY3Lpor/+2jEVRnP0=;
        b=RzZ1BtSPDZlR48KZgL5ft4MF5yBzjwL8ETUD2DUpEIhxtkMqGNtcPwTzsyQ2msZwiV
         MHihZ4LXx/EJvXRJmQ0OCHCiwBbqxMb+FQXDuWDjmALIRQsseHLGMjYJ2vzXoAL+IdJ/
         hRSlx2P3iRxYo2yrvNsKl7vchgj6/cFyY7oc8b86flbDYwIgA+6TvvYqyyKyE9jpLT/P
         aXuaTmkv4hXMKgs5u2wcb74u3xGhcnLRxakA4PwGQK6pvgOKVH8D72G0hBTaEuSnUGtU
         fq3ooMeZFpEsiqCIjHaFQ48ITuK34fLvE6rPZUVOZbAKdz+sTYzBFPqsG7d0JDXYqDc+
         0ytg==
X-Forwarded-Encrypted: i=1; AJvYcCUuWfIYXw/5ITc6fJa3aJc2xEBeTAb8+u2cydvXNnx5SBfoPV25r2ANwU/IWbjIOYr//hf7V2KpYF8c595/nitW6X5Lod/yfdsQ+56rvAk=
X-Gm-Message-State: AOJu0Yx6dAgaLnLFgIWxNLShxFyBzCC7VapbIY/zLyc7fRd8oHFiHEjN
	K/b7FHjTHQg3gV7eBClg4bexPnqObdjDR3DXuX+sK/oLv0QHYtyvQSmVqUVopUEoZ1pIL45J21x
	+3ohD3j0M0pevOK+i6bkY/rg2SQESPIZMxy9CT8AYa3bd3vX0Ym5RgcEQUTCO1Kep
X-Received: by 2002:a5d:69ca:0:b0:360:7856:fa62 with SMTP id ffacd0b85a97d-36873ed7d99mr569850f8f.15.1721351985999;
        Thu, 18 Jul 2024 18:19:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Rox38d1XVqs4VIGXwyGyO0EsaiwHZh55nSHLLk1r/xY/5ex8srk4eo3DwsusIcXSuOqn2Q==
X-Received: by 2002:a5d:69ca:0:b0:360:7856:fa62 with SMTP id ffacd0b85a97d-36873ed7d99mr569841f8f.15.1721351985275;
        Thu, 18 Jul 2024 18:19:45 -0700 (PDT)
Received: from redhat.com (mob-5-90-112-15.net.vodafone.it. [5.90.112.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3b800sm35187425e9.5.2024.07.18.18.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 18:19:44 -0700 (PDT)
Date: Thu, 18 Jul 2024 21:19:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240718211816-mutt-send-email-mst@kernel.org>
References: <20240709080214.9790-1-jasowang@redhat.com>
 <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org>
 <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
 <CACGkMEvDiQHfLaBRoaFtpYJHKTqicqbrpeZWzat43YveTa9Wyg@mail.gmail.com>
 <20240717015904-mutt-send-email-mst@kernel.org>
 <CACGkMEtntsAyddgrtxrbQe407dZkitac4ogC7cASF=iYgsum_A@mail.gmail.com>
 <CACGkMEsd63vH3J5m_4srO3ww2MWGOPc31L4171PfQ7uersN7PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsd63vH3J5m_4srO3ww2MWGOPc31L4171PfQ7uersN7PQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 19, 2024 at 09:02:29AM +0800, Jason Wang wrote:
> On Wed, Jul 17, 2024 at 2:53 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jul 17, 2024 at 2:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Jul 17, 2024 at 09:19:02AM +0800, Jason Wang wrote:
> > > > On Wed, Jul 10, 2024 at 11:03 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Tue, Jul 9, 2024 at 9:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > > > > > This patch synchronize operstate with admin state per RFC2863.
> > > > > > >
> > > > > > > This is done by trying to toggle the carrier upon open/close and
> > > > > > > synchronize with the config change work. This allows propagate status
> > > > > > > correctly to stacked devices like:
> > > > > > >
> > > > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > > > ip link set link enp0s3 down
> > > > > > > ip link show
> > > > > > >
> > > > > > > Before this patch:
> > > > > > >
> > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > ......
> > > > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > > >
> > > > > > > After this patch:
> > > > > > >
> > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > ...
> > > > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > >
> > > > > > I think that the commit log is confusing. It seems to say that
> > > > > > the issue fixed is synchronizing state with hardware
> > > > > > config change.
> > > > > > But your example does not show any
> > > > > > hardware change. Isn't this example really just
> > > > > > a side effect of setting carrier off on close?
> > > > >
> > > > > The main goal for this patch is to make virtio-net follow RFC2863. The
> > > > > main thing that is missed is to synchronize the operstate with admin
> > > > > state, if we do this, we get several good results, one of the obvious
> > > > > one is to allow virtio-net to propagate status to the upper layer, for
> > > > > example if the admin state of the lower virtio-net is down it should
> > > > > be propagated to the macvlan on top, so I give the example of using a
> > > > > stacked device. I'm not we had others but the commit log is probably
> > > > > too small to say all of it.
> > > >
> > > > Michael, any more comments on this?
> > > >
> > > > Thans
> > >
> > >
> > > Still don't get it, sorry.
> > > > > > > This is done by trying to toggle the carrier upon open/close and
> > > > > > > synchronize with the config change work.
> > > What does this sentence mean? What is not synchronized with config
> > > change that needs to be?
> >
> > I meant,
> >
> > 1) maclvan depends on the linkwatch to transfer operstate from the
> > lower device to itself.
> > 2) ndo_open()/close() will not trigger the linkwatch so we need to do
> > it by ourselves in virtio-net to make sure macvlan get the correct
> > opersate
> > 3) consider config change work can change the state so ndo_close()
> > needs to synchronize with it
> >
> > Thanks
> 
> Michael, are you fine with the above or I miss something there?
> 
> Thanks


I don't understand 3. config change can always trigger.
what I do not like is all these reads from config space
that now trigger on open/close. previously we did
read
- on probe
- after probe, if config changed


and that made sense.

-- 
MST

