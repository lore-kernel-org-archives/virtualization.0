Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752AB663
	for <virtualization@lists.linux.dev>; Sun, 10 Aug 2025 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754821133; cv=none; b=d7hSRWzsuyzYTtvTwoHwZA6ZgknWfU8i4fkZO+tQUBzXKrxtnOoAk+iVyn2RxGW0OoKVc/v2lF4H86fYLxCLVYPwReSjKcPcFugEeFwW4bgcOFIvd+YBEBqqwcLAoKwNlmhfnKMhivVQ1Ei5aAFJwiy23aE9TS0kAdDMzy9FPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754821133; c=relaxed/simple;
	bh=kPiyXZ2e4XXm2+ZgHWDD9letI2XCK7Rr9ZtefVy2dzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dmdwiypx0K6PbwIOFyKRkoCjqZtjcDQZiCvdTqVA4VT1dWnjKqEfTJix7enK9+QsE+7yBvysytldpXhnFGpTeUuaTfQV6lxMjpEA8OslHXoWwrvdG1edjo7H2spOI7xDQZQBPVBoeqlYL2z6OhIZF5L7FxOP8cZT5TUcS3G0OAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoFh88eB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoFh88eB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754821130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPiyXZ2e4XXm2+ZgHWDD9letI2XCK7Rr9ZtefVy2dzg=;
	b=aoFh88eB+Q89+Y0bvn99j2ykoOrdGPt7tWsGram6ZOGuS5J/Jt0dhyARLPgd+yziEZ00eo
	mYKNLECI1yonkg3lx17qacAspDtosNdKG5N4YSjkTENGQ97DFobOxg0o2c23z6Drtd5tU5
	Bz5MzmAHxWOR3cgTO1w2q/QRHNR0/1k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-cqC__KXyMUe3R1uGsIshaQ-1; Sun, 10 Aug 2025 06:18:48 -0400
X-MC-Unique: cqC__KXyMUe3R1uGsIshaQ-1
X-Mimecast-MFC-AGG-ID: cqC__KXyMUe3R1uGsIshaQ_1754821127
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3211b736a11so7688112a91.0
        for <virtualization@lists.linux.dev>; Sun, 10 Aug 2025 03:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754821127; x=1755425927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPiyXZ2e4XXm2+ZgHWDD9letI2XCK7Rr9ZtefVy2dzg=;
        b=qKk3jFYzMQm0auOqSpwgJw7/aKTuvboMKIEYDwbKpQahy9IFXWIIwJgQH9tWdctsjQ
         HK9NzbXXuRLpwR4YA/edjjPPMzsNibrjIWTMrLzWHtpQAC6dNZ52Pz7ZkLb3OnorgH6B
         75iVm1pumAywjf9DdRB5NeFG94md4ksUAHlQ/59bheaH2Ju8b+HXxyZcM0vfSfDmJGLl
         2oLhSdHfpfNP4wfEZNXGZDu4mQ4Dk3K/+fIXXZhyZ8trZDipKPw/bUH7zckprVu5UFqg
         AXNr+ZAhE2QwwtUwLMl2KdiKDJm+4IfFkL/cEjkmnNuIQL0b/lPbzsCBP/Hp+0/SIg6/
         X1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuAXhGB+4RMP+gsrfJNx4ioT7qZnUNVN+OvH7zRjYMRLfsnDsdmv8eyxIWvTjz4LMTC7bYcuD+jNYBn7Wwrw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yytmu2BWo4vmIoEOhJ0K5h/B72Nq+IumVHZ9UqfKVtL6FmFXqP3
	X5QJOWzq8IEXEytZjjB29NvDdJlBqFARJYU3FORSZNsgvIReT0miw3Y6sDHHBCAEPBC1rCL6ML3
	ZAmlwevoBGP58bZKYfbzqCGeHi+/lArqCKMbb8uDANtj/VfDXv2lB/fXsMKBAVjSftX+7hvd7df
	YAIgfVEcQ6AkbVV7EuxoYn2cBgw8calS8HKqh6+KAgjPM=
X-Gm-Gg: ASbGncscE5BIkhfbEIWw/sxG9fJc9PG6ufL44MRId99gjEGKGeu8naTg8dhwbllIyRR
	ECO+NgI1FmNwqSlIuDhGTjyKajEfJKD+T8NIEYFSt4tSgiMAxXWReXkiEpx9zCgivHgty3rQu4q
	e4iTaqD1rLweQ9HFcjkMD7
X-Received: by 2002:a17:90b:3912:b0:31e:f3b7:49d2 with SMTP id 98e67ed59e1d1-32183899525mr14684498a91.0.1754821127281;
        Sun, 10 Aug 2025 03:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0fVBMxJ59N53Gaxmyy37OKmMJbvC5IFc3fBjBnBSbQn/4zi2E8Jo3gZ7goVYswjuyRbT7vtLFfz8g3PBTRCE=
X-Received: by 2002:a17:90b:3912:b0:31e:f3b7:49d2 with SMTP id
 98e67ed59e1d1-32183899525mr14684467a91.0.1754821126855; Sun, 10 Aug 2025
 03:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-2-eperezma@redhat.com>
 <CACGkMEsw2taXgW11na2CFK6W03c=x=wMn3iwNZPypgPkeSU06Q@mail.gmail.com>
 <CACGkMEvinV7Zd+xddnxcerFbw_c+RZypkeD5HaN8=g6+peZvMQ@mail.gmail.com>
 <CAJaqyWeetDsdoDzVrN-n0+jr97MBPeHdTxeM3ttmNUeLK702VA@mail.gmail.com>
 <CACGkMEvbxZsmPPHgfst89FCbZamBPLt8V=K-eepa4s3muFuM4A@mail.gmail.com>
 <CAJaqyWerLAL44w-mnwaohZh+duzHqPS3BO-sJDoEHZDN5RLY1g@mail.gmail.com> <CACGkMEvsvFzKUF6w0T4juUFcDbm67YoFFwNDw82K6kogB-1yRA@mail.gmail.com>
In-Reply-To: <CACGkMEvsvFzKUF6w0T4juUFcDbm67YoFFwNDw82K6kogB-1yRA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Sun, 10 Aug 2025 12:18:10 +0200
X-Gm-Features: Ac12FXwtjED04DT8sjJMyWyO9bALrxlsb89TiDaofyKYFnnAHJ0EUE-cORz85uM
Message-ID: <CAJaqyWeteUcvzTbcf2ShatX8QLCVCEgs-dgy19ir=W3LJE3y1A@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZbF0RYnCC-1Jl5mfJ4AcZ66hBcLcXgiBkcR1yetfExc_1754821127
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 2:50=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Aug 7, 2025 at 6:56=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eper=
ezma@redhat.com> wrote:
> > > > > > >
> > > > > > > This allows to define all functions checking the API version =
set by the
> > > > > > > userland device.
> > > > > > >
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > >
> > > > > > It might be worth clarifying how it works.
> > > > > >
> > > > > > For example,
> > > > > >
> > > > > > 1) would VDUSE behave differently or if it's just some new ioct=
ls
> > > >
> > > > I'd like to test more in-depth, but a device can just bump the vers=
ion
> > > > ID and then implement the replies to the vduse messages. No need to
> > > > implement new ioctls. If the VDUSE device sets 0 in either number o=
f
> > > > ASID or vq groups, the kernel assumes 1.
> > >
> > > Right, this is the way we use now and I think maybe we can document
> > > this somewhere.
> > >
> > > >
> > > > But you have a very good point here, I think it is wise to evaluate
> > > > the shortcut of these messages in the VDUSE kernel module. If a VDU=
SE
> > > > device only has one vq group and one ASID, it can always return gro=
up
> > > > 0 and asid 0 for everything, and fail every try to ser asid !=3D 0.
> > >
> > > Yes, and vhost-vDPA needs to guard against the misconfiguration.
> > >
> > > > This
> > > > way, the update is transparent for the VDUSE device, and future
> > > > devices do not need to implement the reply of these. What do you
> > > > think?
> > >
> > > This should work.
> > >
> > > >
> > > > > > 2) If VDUSE behave differently, do we need a ioctl to set the A=
PI
> > > > > > version for backward compatibility?
> > > > >
> > > > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > > > >
> > > > > I think we need to think if it complicates the migration compatib=
ility or not.
> > > > >
> > > >
> > > > Do you mean migration as "increase the VDUSE version number", not "=
VM
> > > > live migration from vduse version 0 to vduse version 1", isn't it? =
The
> > > > second should not have any problem but I haven't tested it.
> > >
> > > I mean if we bump the version, we can't migrate from version 1 to
> > > version 0. Or we can offload this to the management (do we need to
> > > extend the vdpa tool for this)?
> > >
> >
> > I just noticed I left this unreplied. But I still do not get what
> > migrate means here :).
> >
> > If migrate means to run current VDUSE devices on kernel with this
> > series applied these devices don't set V1 API so they have one vq
> > group, and one asid. I'm actually testing this with my libfuse+VDUSE
> > modifications that don't use V1 at all. Adding this explanation to the
> > patch as it is a very good point indeed.
>
> Right.
>
> >
> > If it means to migrate a guest from using a V1 VDUSE device to a V0
> > device "it should work", as it is just a backend implementation
> > detail.
>
> For example src is the VDUSE with multiqueue support (v1) but dest
> doesn't have this support (v0). I think the qemu should fail to launch
> in dest.
>
> > If we migrate from or to a vdpa device backed by hardware, for
> > example, one of the devices does not even have the concept of VDUSE
> > API version.
> >
> > In the case of net, it does not work at the moment because the only
> > way to set features like mq are through the shadow CVQ.
>
> I think you mean qemu should fail, I'm not sure this is friendly to libvi=
rt.
>

No, I think QEMU should not transmit vdpa backend properties not
visible to the guest, so we don't get an explosion of properties that
are hard to get. Expanding on this, QEMU is not even able to know if
it is talking with VDUSE, vdpa_sim, or a vdpa device backed by
hardware. And I think we don't want QEMU to have this information. So
sending the VDUSE version implies removing a lot of useful
abstractions.

In the case of net, the destination QEMU should fail if it is not able
to restore the device state. At this moment this implies to have at
least two ASID if the net device has CVQ, and that CVQ is in its own
ASID, but that may not be true in the future.

But QEMU does not check if that is the case migrating between two
vdpa_net_sim if one supports ASID but the other doesn't. And this is
only a requirement for net, not for other vdpa devices.

So if we want to develop it, I think it is independent of this series.

[...]

