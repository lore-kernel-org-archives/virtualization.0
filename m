Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5553612D
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720493794; cv=none; b=jFYrocQsHC9rJ4+S8Usy03p8c5eik3lBIjwRYqwzhC/QXoJIZX12PKfaaXnW13qylgh9R9M/ZdnGltMc/3U9MB6UaHv/2oEVYMfa0sWJnkdvp7GGjko2t/3op2NLa1RldjIWaR3Y+vYMOLEk74uYvGLqmbb4cVzAlkRR4dJtw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720493794; c=relaxed/simple;
	bh=N+XTVxs+QnQqIh4zTMz3kJHiUrAHsvw06NWUYsO9IOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKg3T4elfPK2yIe9wbZw8ANuOPUchRou8hID4VQTDh1OtZ+SHT2rP8IESEEKccJ+bES+AmTYARtmuylZDiK2HtvlXZbY7ZVxnH2BMy3cUKmQ8UQBAV8rN4ON4DzfeUdT1oKBe0lnKRJJGqBtTQblHGE4CU5LKcuSsv5/Ys7PgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ho9m8mxu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ho9m8mxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720493791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTng96XdisraOc8AWV9UDvrNuZOXIjZnrGjTq93nz8I=;
	b=Ho9m8mxuRhK5VQ/F+rulaFobKbiF6Ph+a9r89iEqUD8iMUEdlHd4K/p1PVjww+tvQHnKfr
	8ryy/Lsrkl6wujI/gH5wEhfwMXCmln9sf5ngCyMR8YnlyErhTYh+OjAQEFxb+Tf+LwfUL8
	POw/8oNuBHwtN+DjAkGhcINsFR++ToA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-4qDiUuQSM_SiPY8R0gWhzA-1; Mon, 08 Jul 2024 22:56:29 -0400
X-MC-Unique: 4qDiUuQSM_SiPY8R0gWhzA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70afe95d6d5so3133436b3a.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 19:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720493788; x=1721098588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTng96XdisraOc8AWV9UDvrNuZOXIjZnrGjTq93nz8I=;
        b=gsu4CA3W3yRF01R3VjDA/owf3xnVBvS3jb091fV0S2bFTfTbsYCoUe+9d3D4XqmTMs
         A3L75FMTzaw+kTZalBjNkMcjagg1s2WZneLGlliIK1ecDKAIixXsWz8pJ5DXqBh6KYrr
         KPqudR2RukEVyh68MSmS2KI0crnpvZa4pokk43w3bqclH7wpbMyQloo+0WmPvfwZPmJk
         5T9ny0EPTbIybfGQljMq61PH5ionciCcavkA5bu9uuE0uMTW8YGog8IgrW+g28seqrhF
         b5GJ7tAZn1AUVCXomy/8uiSnlavbRdosqmK8DZ9SffW9t8VIBXTk88/HLvFWEUfS0xhE
         u9xg==
X-Forwarded-Encrypted: i=1; AJvYcCXEkzH51JHLwCgFjGZOqj3PZg7TDz3IU9dXw/6YHBxEfWpCQnnBrqwFdMiZ3DJPkW3eErdME3FIl4J12PE2Hrb86vKZdJQtJi/p9fmzmwk=
X-Gm-Message-State: AOJu0YxmNT819cebHj7r2myamOaGuqHFMXrltQ9jYDyQRzD/iupps1Fc
	UdaL2vo+CrtbSCP5Rnhdinc3eaHxPEqrLKjLZh43/Zvjw3w+WSv4oMpG9cDeCpIwOtm10tcgk4h
	cQOHG9fpoS+tNul+EsLYn53HhUf25tQA30ejFttkZ+xCmW35E/V0aTkfIHToREc5ZSabXwgf0E3
	F6R1auaPMg4ciHRvVNB/4orZbYM0Ye704ga2l6TI4=
X-Received: by 2002:a05:6a00:b87:b0:705:9b04:71b with SMTP id d2e1a72fcca58-70b43664bd9mr1571100b3a.31.1720493788355;
        Mon, 08 Jul 2024 19:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhK9BmZSJsOmkhsPkGQ5uDjeC+binYH7qnVpn/VZV9HKetBL5xdgRnxqJtOc7yRx6VH3Mw8noAj+9wLv0Ezd8=
X-Received: by 2002:a05:6a00:b87:b0:705:9b04:71b with SMTP id
 d2e1a72fcca58-70b43664bd9mr1571084b3a.31.1720493787880; Mon, 08 Jul 2024
 19:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240705112821.144819-1-sgarzare@redhat.com> <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
 <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
 <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com> <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
In-Reply-To: <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Jul 2024 10:56:16 +0800
Message-ID: <CACGkMEuqiAx-a0sPJf0Xpvmr=5wbzbuOr0-w+9ZcwQMTWFU1rw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 4:15=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> Hi Cindy, Jason,
>
> On Mon, Jul 08, 2024 at 03:59:34PM GMT, Jason Wang wrote:
> >On Mon, Jul 8, 2024 at 3:06=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >>
> >> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> =
wrote:
> >> >
> >> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
> >> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
> >> > >> The vDPA block simulator always allocated a 128 MiB ram-disk, but=
 some
> >> > >> filesystems (e.g. XFS) may require larger minimum sizes (see
> >> > >> https://issues.redhat.com/browse/RHEL-45951).
> >> > >>
> >> > >> So to allow us to test these filesystems, let's add a module para=
meter
> >> > >> to control the size of the simulated virtio-blk devices.
> >> > >> The value is mapped directly to the `capacity` field of the virti=
o-blk
> >> > >> configuration space, so it must be expressed in sector numbers of=
 512
> >> > >> bytes.
> >> > >>
> >> > >> The default value (0x40000) is the same as the previous value, so=
 the
> >> > >> behavior without setting `capacity` remains unchanged.
> >> > >>
> >> > >> Before this patch or with this patch without setting `capacity`:
> >> > >>   $ modprobe vdpa-sim-blk
> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 M=
B/128 MiB)
> >> > >>
> >> > >> After this patch:
> >> > >>   $ modprobe vdpa-sim-blk capacity=3D614400
> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 M=
B/300 MiB)
> >> > >>
> >> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > >
> >> > >What a hack. Cindy was working on adding control over config
> >> > >space, why can't that be used?
> >> >
> >> > If it can be used easily with virtio-blk device too, it will be grea=
t.
> >> > @Cindy do you plan to support that changes for a virtio-blk device t=
oo?
> >> >
> >> Hi Stefano
> >> I plan to add support to change the vdpa device's configuration after
> >> it is created.
> >
> >I think for Stefano's case, we can just implement it via provisioning
> >parameters?
>
> Yep, I think we don't need to change it after creation, but specifying
> while creating should be enough.
>
> So, IIUC we can already do it, implementing something similar to
> vdpasim_net_setup_config() to call during vdpasim_blk_dev_add(), right?

Right.

>
> What about when we have `shared_backend` set to true for the
> vdpa_sim_blk.ko? In this case the backend is supposed to be shared
> between all the devices to test live migration.

This seems to be another topic.

>
> Maybe we can just change the size of the shared ramdisk to be reflected
> to all devices.
>
> Suggestions?

Could we specify the path to tmpfs or others during provisioning
instead?  It seems more general (but more work).

>
> @Cindy do you want to work on this for blk as well?
> If you don't have time, I'll look at it when I can allocate some time.
>
> >
> >Thanks

Thanks

> >
> >> In the first step, I want to use the vdpa tool to add
> >> support for changing the MAC address for the network device. the next
> >> step will also add MTU settings etc
> >> here is the link
> >> https://lore.kernel.org/all/20240708064820.88955-1-lulu@redhat.com/T/#=
t
> >>
>
> I'll take a look, thanks for ccing me!
>
> Stefano
>
> >> in the device part, the device needs to implement its function of
> >> int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *de=
v,
> >>        const struct vdpa_dev_set_config *config);
> >> the configuration will be passed by struct vdpa_dev_set_config. I'm
> >> not sure if this kind of design is suitable for you? Really thanks and
> >> any comments are welcome
> >> thanks
> >> Cindy
> >>
> >>
> >> > In the mean time, for the simulator I thought that this change was f=
ine.
> >> > It's just used for testing and debugging...
> >> >
> >> > My main question is how to use that when we have `shared_backend` se=
t to
> >> > true, since we use that setting to test for example live migration. =
In
> >> > that case, how do we handle the size of the shared ramdisk between
> >> > devices?
> >> >
> >> > Thanks,
> >> > Stefano
> >> >
> >>
> >
>

