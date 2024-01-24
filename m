Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BAD17553
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081955; cv=none; b=HSYAv92wCEtoAQpnP322Fthn2E0TYJwZfvmXBk9EM4fqQ0LgKcQGIZ5MxLyBNOphgNoILJoRfFlyFGxh/VoI7m50eOJe9sAiLG+2JWoSpKjZhmZieD/8ocRXc+37yS39XViohR5qXfz6EbDu6QHA1leAhCq3JzV/DkBhkdn9zIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081955; c=relaxed/simple;
	bh=oyPADhSHwEU24RtFpATiv+amECQBJiGyb2+3W+A/YO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJYWy4s98hvsGcdaWhs5gRfrvxXwqBCEdWylI1rzgQxshoP0yg5Tr9p9PwWuOsx+z++/lThIg97Cmr5UhqyR2G0DeJDXuWvzya+Tm2h52JgnCSVBh7c7Wy8VWqps2c9/mutDXwCfFGVwxQZbAffTvNXvdeK/ToWf37ehb6L91yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln9CiWZD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln9CiWZD"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51005675963so2514699e87.0
        for <virtualization@lists.linux.dev>; Tue, 23 Jan 2024 23:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706081952; x=1706686752; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Bfuvk8oKuA+3Tc2xTLQDMirdliyrSB9iEQK+0MXno=;
        b=ln9CiWZDyM9BHN4t7FJHlex123OsoPQWLatV6xe929VJ7c7lykvDUPEkKtLYJ45WfJ
         n1K2RsG8/aIGysyjQFVIZS97jK80ZN7YmvVhGw9mRb3M5dmA2HjXAIAImiJ+D7TsXZw/
         TMmRGeJ9J++Ea/oX6LegEYXN8p/Gc5SSMoR44oQyQx60MHpyzznI8jgmedQyQAFq0s0n
         Gdi0gODoAPwttIOK6yVr2/iCDdgl1g/zODUtmaQoXZOGOFoOSUnnQcU0hsnZPrSRP8xI
         bVYyN7GOjMUIGmDrOICYkL8kntT/dQ2TAl1DLX70K2QKtRcMKrMhDDj/7EPhOPVqitBx
         EA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081952; x=1706686752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8Bfuvk8oKuA+3Tc2xTLQDMirdliyrSB9iEQK+0MXno=;
        b=o5vG1do+FH0JI3wdffENmTwKqjv89ryCvJLuaC3RMJy/kUkg3tTyA28wUNTappk7rM
         bMtZk/6BrHyHS2i60LgAlsURUJ/q9Stj7DSI4JUQ2l1hZmV+I0p1PHcGNo71FFNIrgVN
         vwAhhK7M2wDyT0KHGg7iB5lgTjEsR9n7UPCc8kk7/koRaB5gcIpiIeW3BXpZPy7g6UdC
         7b2bgLIcHIJeDu+VPPr1FYfz7PgE8ckbmsvF0xEyjGZYv6RqgzWU7RvRxNtGZnJ1aily
         LjA0tF2SNHWpbM3VbJrQmwNvD1E058JQR2A4UdoFIDzBK39gZT3lSsrAUodCZamEuumZ
         m4ng==
X-Gm-Message-State: AOJu0Yw0/Gda/AffXe8GhN80lt8LIk6XNy79pw75+5o21KB3QwkOr1YK
	J5ot6deBBUuFyokI8n0KnKbgB66l10+yQ7v0D25Edmy2kZHBkDq+5MQJe2w6u8pnVHzfef+Pzns
	P5IWoWwt9tNakI3bgTQKlewkPA6Y=
X-Google-Smtp-Source: AGHT+IHfBrI2fT2JfWR70NQTj2TLaC2gpW8mlbjz8KC+gHPggrkHLo1dlVDPBXSxm1k0FmOHVzCm0rSmMRlZiD6fJro=
X-Received: by 2002:ac2:5b4b:0:b0:510:1439:2bee with SMTP id
 i11-20020ac25b4b000000b0051014392beemr45089lfp.191.1706081951853; Tue, 23 Jan
 2024 23:39:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122110722.690223-1-yi.sun@unisoc.com> <20240122110722.690223-3-yi.sun@unisoc.com>
 <20240122154255.GA389442@fedora> <CALpufv0h-sQ4Qfp-Sxd7wME4onMNAMop_gi-np6Dk2R96sba0Q@mail.gmail.com>
 <20240123150924.GD484337@fedora>
In-Reply-To: <20240123150924.GD484337@fedora>
From: yi sun <sunyibuaa@gmail.com>
Date: Wed, 24 Jan 2024 15:38:35 +0800
Message-ID: <CALpufv385oK0+EqYZw1Mk8xxm1Av_jYfcPS0khBi=NSu7qCeHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, Yi Sun <yi.sun@unisoc.com>, axboe@kernel.dk, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I'm using virtio-mmio.

On Tue, Jan 23, 2024 at 11:09=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> Hi Michael,
> This could potentially affect other VIRTIO drivers too. Please see
> below.
>
> On Tue, Jan 23, 2024 at 11:27:40AM +0800, yi sun wrote:
> > On Mon, Jan 22, 2024 at 11:43=E2=80=AFPM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > >
> > > On Mon, Jan 22, 2024 at 07:07:22PM +0800, Yi Sun wrote:
> > > > Ensure no remaining requests in virtqueues before resetting vdev an=
d
> > > > deleting virtqueues. Otherwise these requests will never be complet=
ed.
> > > > It may cause the system to become unresponsive. So it is better to =
place
> > > > blk_mq_quiesce_queue() in front of virtio_reset_device().
> > >
> > > QEMU's virtio-blk device implementation completes all requests during
> > > device reset. Most device implementations have to do the same to avoi=
d
> > > leaving dangling requests in flight across device reset.
> > >
> > > Which device implementation are you using and why is it safe for the
> > > device is simply drop requests across device reset?
> > >
> > > Stefan
> >
> > Virtio-blk device implementation completes all requests during device r=
eset, but
> > this can only ensure that the device has finished using virtqueue. We s=
hould
> > also consider the driver's use of virtqueue.
> >
> > I caught such an example. Before del_vqs, the request had been processe=
d by
> > the device, but it had not been processed by the driver. Although I am
> > using kernel5.4,
> > I think this problem may also occur with the latest version of kernel.
> >
> > The debug code I added is as follows:
> > virtblk_freeze()
> > {
> >         vdev reset();
> >         quiesce queue();
> >         if (virtqueue->num_free !=3D 1024) //1024 is the init value.
> >                 BUG_ON(1);
> >         vdev del_vqs();
> > }
> >
> > BUG_ON triggered the dump, the analysis is as follows:
> >
> > There is one request left in request_queue.
> > crash_arm64> struct request ffffff81f0560000 | grep -e state -e __data_=
len
> >   __data_len =3D 20480,
> >   state =3D MQ_RQ_IN_FLIGHT,
> >
> > crash_arm64> vring_virtqueue.packed,last_used_idx,broken,vq 0xffffff808=
6f92900 |
> > grep -e num -e used_wrap_counter -e last_used_idx -e broken -e
> > num_free -e desc_state -e "desc =3D"
> >         num =3D 1024,
> >         desc =3D 0xffffff8085ff8000,
> >       used_wrap_counter =3D false,
> >       desc_state =3D 0xffffff8085610000,
> >   last_used_idx =3D 487,
> >   broken =3D false,
> >     num_free =3D 1017,
> >
> > Find desc based on last_used_idx. Through flags, we can know that the r=
equest
> > has been processed by the device, but it is still in flight state
> > because it has not
> > had time to run virtblk_done().
> > crash_arm> vring_packed_desc ffffff8085ff9e70
> > struct vring_packed_desc {
> >   addr =3D 10474619192,
> >   len =3D 20481,
> >   id =3D 667,
> >   flags =3D 2
> > }
> >
> > I'm using a closed source virtual machine, so I can't see the source
> > code for it,
> > but I'm guessing it's similar to qemu.
> >
> > After the device completes the request, we must also ensure that the dr=
iver can
> > complete the request in virtblk_done().
> >
>
> Okay, I think your approach of waiting for requests before
> virtio_device_reset() makes sense. blk_mq_complete_request() is async
> (might be deferred to an IPI or softirq) so it's not enough for
> virtblk_done() to run before virtio_device_reset() returns. There is no
> guarantee that virtblk_request_done() runs before virtio_device_reset()
> returns.
>
> A separate issue about virtio_device_reset():
>
> Are you using virtio-mmio? virtio-mmio's vm_reset() doesn't offer the
> same guarantees as virtio-pci's reset functions. virtio-pci guarantees
> that irqs sent by the device during the reset operation complete and the
> irq handlers run before virtio_device_reset() returns. virtio-mmio does
> not.
>
> (On top of this, virtio_device_reset() now has
> CONFIG_VIRTIO_HARDEN_NOTIFICATION which changes the semantics. Drivers
> cannot expect to complete any in-flight requests in
> virtio_device_reset() when complied with this config option.)
>
> Other drivers may be affected by these inconsistent
> virtio_device_reset() semantics. I haven't audited the code.
>
> Stefan
