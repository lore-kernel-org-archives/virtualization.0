Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244A4EB2B
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872073; cv=none; b=PWF+cAsHCrq7iGYwpXXhTLB5DQsutY3wXPESbAFWhHO5hCJvNE+Mr4Cse3O1Mls1qWsDilDrC5tf1l7OYPgpW8si0R7KVqKjTwlGfDTF6XXvPHDyku88+AznpM9MtG043u+9U+BleW2uG1J8m+/bQVpLGvyjnMrGbPayu9iVHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872073; c=relaxed/simple;
	bh=Q7qq9TpLHXbiRmyngYdWJcra7kmlcDHD89XeuynC+YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fdkl6lztc8YnIpHg2vRsY65xJj6l6ipHbZjxy14jmOXxca9lpokJy+s5YXFVjH+Ri4Tlb0/luU4lrBxueK7jxlaQ3rGMDyzeml5a1WEQXohyVRg/9+cpRM9XfFKF7yskphKs/glMpx2KnHIr6VuNHYUvgoUUkYZcolR+5jIx200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5ZC6C4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5ZC6C4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMWB+k5AtlGl2iX/M3MX2kWjllYDfPs71Gjiz22BUTs=;
	b=a5ZC6C4rX6rDc1PPbs8tgEQWcQevNPlUUe9ZsGZRaJqAZJcfXRgIpjrAFO1Sl2Keg5UBj7
	Wgd7jD3AQpJCBrv0Q1hJA3N1/4JlygSr0JvMzt3QZHX+NtIVHG9UMNTPRvJQh0sqCdmPzE
	5958Eh/zRTS8vbUrLHBiFasPKNVchxI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-aSMn8eaTM16RdYGKgTtQDg-1; Thu, 20 Jun 2024 04:27:49 -0400
X-MC-Unique: aSMn8eaTM16RdYGKgTtQDg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c7c3069f37so812564a91.0
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 01:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872069; x=1719476869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMWB+k5AtlGl2iX/M3MX2kWjllYDfPs71Gjiz22BUTs=;
        b=JfcZ4Ewx3JQ36Y/+d0AGzoZpo4jEGvgcQHMJpeopopqDCEwJ4B8qvjkvlLBWFCHX4t
         ChpKhaxN8NQFk+kKMbKpeTnjEGj+Rh8GjtHzb7U+FWLzBQG11Tgl72e5k2ELfA+V5zoB
         yRnqHEC1RgrULBIRy/XjOgyJo4boKNY+COH0cbEkopcIIlRhg79cQl8Iasjy3X4i3zQT
         uqD8Opc0dSqnFjzdiHxCVB9q4unz+bpuXrtfW8lyBIrAQp5+tZkcdsFdvNCPbGUL8v4o
         bWU2n6PkvKFR/BdXdPafS2oxnqLOZsY3en8Dulk44NIfUuwcT8erdxkksjOGnjSEKmWr
         uDgA==
X-Forwarded-Encrypted: i=1; AJvYcCVKNK9dxI0ln8JYgyqjH+wtwdu8MilOmIcPYLXZaSlXNK8bSruo2yjibkLl+2Htn1xA+33FrqB+0CNoZxBpckKTiM2nK3v9WS1mNB6spBk=
X-Gm-Message-State: AOJu0YxhjUvPE6dON3+x2sSg3ifPub6SCID+b9Tush8EnRJ+5hzIZ4CQ
	OUxBquxfelFtoVyAJiXdZDzubLD+rOcgfjfRry3WkoHO/n1om5kSpZAPwCgKD43rHyssshkyX60
	7XdX1iwqSWD7Jcwxj1UIO26njwwasJzIIa7ZllNrGHiqbRPNtghV4KGORdU5wIf5pSnkk6dpnYi
	0zAg8/yEQxDgaSzjEqS3QJoEAgOkbIuntutfkEdiI=
X-Received: by 2002:a17:90a:c243:b0:2c7:700e:e2bf with SMTP id 98e67ed59e1d1-2c7b5cbdb3amr4852569a91.20.1718872068662;
        Thu, 20 Jun 2024 01:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGkq3SOyzSmbVDgjJyAR8QpUMzNvxVjXrDvqED4Wna271/5in8lNaeBdfhxp367xX9ZvVXbF3oe3N/NiCLIpk=
X-Received: by 2002:a17:90a:c243:b0:2c7:700e:e2bf with SMTP id
 98e67ed59e1d1-2c7b5cbdb3amr4852549a91.20.1718872068289; Thu, 20 Jun 2024
 01:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
 <20240530090742-mutt-send-email-mst@kernel.org> <CACGkMEsYRCJ96=sja9pBo_mnPsp75Go6E-wmm=-QX0kaOu4RFQ@mail.gmail.com>
 <CACGkMEu2vb8njbNHExWnDAG_pFjsLkYChgNerH4LAQ7pbYyEcg@mail.gmail.com> <20240620014550-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620014550-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:27:36 +0800
Message-ID: <CACGkMEvEySbG74u0_FGh7TathQoNijqR3TDxVSO6q8EQT6Xzsg@mail.gmail.com>
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

On Thu, Jun 20, 2024 at 1:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 06, 2024 at 08:22:13AM +0800, Jason Wang wrote:
> > On Fri, May 31, 2024 at 8:18=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, May 30, 2024 at 9:09=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, May 30, 2024 at 06:29:51PM +0800, Jason Wang wrote:
> > > > > On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > > > > > This patch synchronize operstate with admin state per RFC2863=
.
> > > > > > >
> > > > > > > This is done by trying to toggle the carrier upon open/close =
and
> > > > > > > synchronize with the config change work. This allows propagat=
e status
> > > > > > > correctly to stacked devices like:
> > > > > > >
> > > > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > > > ip link set link enp0s3 down
> > > > > > > ip link show
> > > > > > >
> > > > > > > Before this patch:
> > > > > > >
> > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast st=
ate DOWN mode DEFAULT group default qlen 1000
> > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > ......
> > > > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> =
mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > > >
> > > > > > > After this patch:
> > > > > > >
> > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast st=
ate DOWN mode DEFAULT group default qlen 1000
> > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > ...
> > > > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN=
> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default ql=
en 1000
> > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > > >
> > > > > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > > Changes since V1:
> > > > > > > - rebase
> > > > > > > - add ack/review tags
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++---=
----------
> > > > > > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> > > > > > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > > > > > >       /* The lock to synchronize the access to refill_enabled=
 */
> > > > > > >       spinlock_t refill_lock;
> > > > > > >
> > > > > > > +     /* Is config change enabled? */
> > > > > > > +     bool config_change_enabled;
> > > > > > > +
> > > > > > > +     /* The lock to synchronize the access to config_change_=
enabled */
> > > > > > > +     spinlock_t config_change_lock;
> > > > > > > +
> > > > > > >       /* Work struct for config space updates */
> > > > > > >       struct work_struct config_work;
> > > > > > >
> > > > > >
> > > > > >
> > > > > > But we already have dev->config_lock and dev->config_enabled.
> > > > > >
> > > > > > And it actually works better - instead of discarding config
> > > > > > change events it defers them until enabled.
> > > > > >
> > > > >
> > > > > Yes but then both virtio-net driver and virtio core can ask to en=
able
> > > > > and disable and then we need some kind of synchronization which i=
s
> > > > > non-trivial.
> > > >
> > > > Well for core it happens on bring up path before driver works
> > > > and later on tear down after it is gone.
> > > > So I do not think they ever do it at the same time.
> > >
> > > For example, there could be a suspend/resume when the admin state is =
down.
> > >
> > > >
> > > >
> > > > > And device enabling on the core is different from bringing the de=
vice
> > > > > up in the networking subsystem. Here we just delay to deal with t=
he
> > > > > config change interrupt on ndo_open(). (E.g try to ack announce i=
s
> > > > > meaningless when the device is down).
> > > > >
> > > > > Thanks
> > > >
> > > > another thing is that it is better not to re-read all config
> > > > on link up if there was no config interrupt - less vm exits.
> > >
> > > Yes, but it should not matter much as it's done in the ndo_open().
> >
> > Michael, any more comments on this?
> >
> > Please confirm if this patch is ok or not. If you prefer to reuse the
> > config_disable() I can change it from a boolean to a counter that
> > allows to be nested.
> >
> > Thanks
>
> I think doing this in core and re-using config_lock is a cleaner approach=
 for sure, yes.
>
> For remove we do not need stacking. But yes we need it for freeze.
>
> I am not sure how will a counter work. Let's see the patch.
>
>
> It might be easier, besides config_enabled, to add config_disabled,
> document that  config_enabled is controlled by core,
> config_disabled by driver.
> And we'd have 2 APIs virtio_config_disable_core and
> virtio_config_disable_driver.
>
>
> But I leave that decision in your capable hands.

Let me try to switch to using a counter for config_enabled first.

Thanks

>
>
>
> > >
> > > Thanks
> > >
> > > >
> > > > --
> > > > MST
> > > >
>

