Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966938F97
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863135; cv=none; b=cfrrmpFma2fUsPUmf5cWgLlVWoduSR/SaCgmcdtdt+pUGE7g2OFxRBeulUM5eM/0hOy11zyByGIp/M1czleuiCR1UykquvMAnLSd14NazC6+U1r3XPq7G/mLdICSWmfCbb84hMGKQnSxcPYla6QERweEJsnxsyMTbLZLjGm+klM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863135; c=relaxed/simple;
	bh=8nJowE8rTy0MhaM+MZo8vpg8qKpOU8NEAABYQmu5KJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=klACts/lgq/zJ7HxDxkE9ndhdi9CoJoR5DX2yKZ9lxEjYlQa70c/dlYCuERBFw20GEFhBCQcChc0UCwZ+SrvzVHgfIPgCGDHYt3sB3EWvjswaXvP5qMCH2okOz+t/2XYYTP7cB088BZvMvQxfpaNN6wKIxporIdLHWiS3WpQp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCEUtSnF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCEUtSnF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718863131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pgz7erBbsqlQUnBT2bXs/f7YsXgZpwLUVpf5Ft0epH4=;
	b=TCEUtSnF9h77VG7kz8CJwxFcCTRie/IPmQ3NN7cIi+YNILV0YXP6lzqWUOG7UYuYzWxzI2
	P0w8IQATOIsAMjg233DoUJOWJP8vN3XT3G90YSUrjMI4uxNh1XX5fD9/fJ1Yp7tXjk3FOK
	+lnVVbvZbnU54S5vV7sToz3Mfequ7I4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-z_6INUtdPq-uMLUxNjY-nQ-1; Thu, 20 Jun 2024 01:58:49 -0400
X-MC-Unique: z_6INUtdPq-uMLUxNjY-nQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ec3cb4354bso2780561fa.3
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 22:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718863128; x=1719467928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pgz7erBbsqlQUnBT2bXs/f7YsXgZpwLUVpf5Ft0epH4=;
        b=wjO1r6wdOJmRksLh9M8Ypim5x2moGIF4x4kxzfuBKHHajNLCuuU1d5huBvFTCFFV8H
         3B54z++P/QAtTH8UFQbEJTt/SGhjuCYBpZrA7P6KPshwXhkZcsZj3cMFCRor/KstQdys
         H15H5QkMDknLuk1xS/SxVjYqB5d2x3HF4CYdvu3nG5jGcNAABRe0sLcSeIRb/UzDlQFA
         mONX+zwouQu8225VwZCe9uvgmdLTLIgHprj2E8J0q3BsLt2/fQk8wHFnGfytN47OARDh
         rW0HksOIFDr70hwK935XUTa+lyvRUUntqMvH2NvWsQhFUHeIzSqAEnm/tne/iPed5BCJ
         NKKA==
X-Forwarded-Encrypted: i=1; AJvYcCWsJxWeUc5nrXje4XjpbKy9din8s1ou2XQltVDyV2sXsUua/SdaZEyEJgIg41NMzvmLdyIGBqKUFbmd2tCeRdwSrSQZzTj8B8SxiTTZpTc=
X-Gm-Message-State: AOJu0YyAKYvHCJRMruGFOjSN6s8Wh9KkOF54XmQJKmBN054ODQ8CZ4JF
	8kXT8wlm0fTlP7Lr55OfYzFBy/Y995AYA0xgPxrqA1yNiNE/dtg/xmdBGgi/o2dJ8J9YB0WlVhT
	rj4kKkrcjsh1Ts/HT5ipiwe0S5ucdAszQTpIi6ubmUzorMQ6VFGYPZu485bWa1FuO
X-Received: by 2002:a05:651c:1a1f:b0:2ec:4086:ea71 with SMTP id 38308e7fff4ca-2ec4086ec13mr24198201fa.5.1718863128277;
        Wed, 19 Jun 2024 22:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu735F2hiNtWMCvbhFdAxvjx0gml4MZariwxa2PfPBAR+wDRwgyU1ehJS0l7lqMFPWf3q9Wg==
X-Received: by 2002:a05:651c:1a1f:b0:2ec:4086:ea71 with SMTP id 38308e7fff4ca-2ec4086ec13mr24197881fa.5.1718863126499;
        Wed, 19 Jun 2024 22:58:46 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbe89005asm8053445a12.10.2024.06.19.22.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 22:58:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 01:58:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH net-next V2] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240620014550-mutt-send-email-mst@kernel.org>
References: <20240530032055.8036-1-jasowang@redhat.com>
 <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
 <20240530090742-mutt-send-email-mst@kernel.org>
 <CACGkMEsYRCJ96=sja9pBo_mnPsp75Go6E-wmm=-QX0kaOu4RFQ@mail.gmail.com>
 <CACGkMEu2vb8njbNHExWnDAG_pFjsLkYChgNerH4LAQ7pbYyEcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu2vb8njbNHExWnDAG_pFjsLkYChgNerH4LAQ7pbYyEcg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 06, 2024 at 08:22:13AM +0800, Jason Wang wrote:
> On Fri, May 31, 2024 at 8:18 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, May 30, 2024 at 9:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, May 30, 2024 at 06:29:51PM +0800, Jason Wang wrote:
> > > > On Thu, May 30, 2024 at 2:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > > > > This patch synchronize operstate with admin state per RFC2863.
> > > > > >
> > > > > > This is done by trying to toggle the carrier upon open/close and
> > > > > > synchronize with the config change work. This allows propagate status
> > > > > > correctly to stacked devices like:
> > > > > >
> > > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > > ip link set link enp0s3 down
> > > > > > ip link show
> > > > > >
> > > > > > Before this patch:
> > > > > >
> > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > ......
> > > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > >
> > > > > > After this patch:
> > > > > >
> > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > ...
> > > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > >
> > > > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > > Changes since V1:
> > > > > > - rebase
> > > > > > - add ack/review tags
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-------------
> > > > > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > > > > >       /* The lock to synchronize the access to refill_enabled */
> > > > > >       spinlock_t refill_lock;
> > > > > >
> > > > > > +     /* Is config change enabled? */
> > > > > > +     bool config_change_enabled;
> > > > > > +
> > > > > > +     /* The lock to synchronize the access to config_change_enabled */
> > > > > > +     spinlock_t config_change_lock;
> > > > > > +
> > > > > >       /* Work struct for config space updates */
> > > > > >       struct work_struct config_work;
> > > > > >
> > > > >
> > > > >
> > > > > But we already have dev->config_lock and dev->config_enabled.
> > > > >
> > > > > And it actually works better - instead of discarding config
> > > > > change events it defers them until enabled.
> > > > >
> > > >
> > > > Yes but then both virtio-net driver and virtio core can ask to enable
> > > > and disable and then we need some kind of synchronization which is
> > > > non-trivial.
> > >
> > > Well for core it happens on bring up path before driver works
> > > and later on tear down after it is gone.
> > > So I do not think they ever do it at the same time.
> >
> > For example, there could be a suspend/resume when the admin state is down.
> >
> > >
> > >
> > > > And device enabling on the core is different from bringing the device
> > > > up in the networking subsystem. Here we just delay to deal with the
> > > > config change interrupt on ndo_open(). (E.g try to ack announce is
> > > > meaningless when the device is down).
> > > >
> > > > Thanks
> > >
> > > another thing is that it is better not to re-read all config
> > > on link up if there was no config interrupt - less vm exits.
> >
> > Yes, but it should not matter much as it's done in the ndo_open().
> 
> Michael, any more comments on this?
> 
> Please confirm if this patch is ok or not. If you prefer to reuse the
> config_disable() I can change it from a boolean to a counter that
> allows to be nested.
> 
> Thanks

I think doing this in core and re-using config_lock is a cleaner approach for sure, yes.

For remove we do not need stacking. But yes we need it for freeze.

I am not sure how will a counter work. Let's see the patch.


It might be easier, besides config_enabled, to add config_disabled,
document that  config_enabled is controlled by core,
config_disabled by driver.
And we'd have 2 APIs virtio_config_disable_core and
virtio_config_disable_driver.


But I leave that decision in your capable hands.



> >
> > Thanks
> >
> > >
> > > --
> > > MST
> > >

