Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5494D5A3
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GG+qMtkq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A56C882242
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 14:56:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A56C882242
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GG+qMtkq
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elfZW8jV7QeO
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Dec 2023 14:56:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4261982181
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 14:56:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4261982181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703170579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8eIz4f9p7CSrHkPxbwx9C5GZwRnjE0R1lz9iIAHGRA=;
	b=GG+qMtkqhxVK3AgBCwg/n7yLJborYqo5ju1ocL1hX19OPeDTGbWKpWachSvQNMyV1yF0qK
	0PEoDbIm8tVSWRQGZTQClugMhgd3b05OZiApQ7xdK29A01DgYLJhI6SXB/Sr3DxDdyfn27
	5MyRs9/28PvsPDyZNtUtGC9JqKev7fU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-Nf8dqOjqMKOsc1U3SJEsEg-1; Thu, 21 Dec 2023 09:56:15 -0500
X-MC-Unique: Nf8dqOjqMKOsc1U3SJEsEg-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dbdad6939e2so1027575276.0
        for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 06:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170575; x=1703775375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8eIz4f9p7CSrHkPxbwx9C5GZwRnjE0R1lz9iIAHGRA=;
        b=Kt4ulgxT1ZZgB4Mr9wGq87hC/UwAdCX97NrncAoJaSFwZjwyq13QCWe8oQIBk9t9me
         9EZd4aMKMsvbYySSZslTie/0KZ2id0G+azGHIWFruOX52DOOFCgrGOPmTYUQLaBy2QEU
         vkgeYkN4vLr0q7s2wokRz8CRFtm4nXMHVMfss0NBE2hn+G+m99YXg98ZaUvu7yAldwjb
         0OXvXsZWL2yp64o9kWvTEobE61D1T7SiXmiept3DuTbTHus2l6cDGUrp0Y/ly0VbbVup
         UWq4YfE5ZdDLBy4xfqACjga9ae9TfBz4Ee+ii5080QLZJjpqPITArNYlKADO3oiplKCB
         wkGw==
X-Gm-Message-State: AOJu0YymRJCuZeWfqSvjcM3jhAImZCsjNGAUBSW+K0crwmDz0Da9iplx
	OslnCSYqIbf/mVRM+lom52IBX0A8ue4PoLpOkPvEf3ASGnA/i8YPMDFUsZX9+Ftui+5M3KkDXT9
	eBvlOBNd4vmNK43lruR92i7uMQtgg67+aNlcqUyMRLOJimkoLBEl4MC+auA==
X-Received: by 2002:a25:d88b:0:b0:dbd:11:5dee with SMTP id p133-20020a25d88b000000b00dbd00115deemr1311073ybg.37.1703170575146;
        Thu, 21 Dec 2023 06:56:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8jOlzMv0iYcVNkFXFgLaDs5GWBuNPYA3j97IaAxPd2JpsSU5V8zCmy+j79KFLQR0AlsT/6eD/52Y8Bkd+cQQ=
X-Received: by 2002:a25:d88b:0:b0:dbd:11:5dee with SMTP id p133-20020a25d88b000000b00dbd00115deemr1311052ybg.37.1703170574842;
 Thu, 21 Dec 2023 06:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
 <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
 <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
 <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
 <CACGkMEuM7bXxsxHUs_SodiDQ2+akrLqqzWZBJSZEcnMASUkb+g@mail.gmail.com>
 <CAJaqyWeBVVcTZEzZK=63Ymk85wnRFd+_wK56UfEHNXBH-qy1Zg@mail.gmail.com>
 <70adc734331c1289dceb3bcdc991f3da7e4db2f0.camel@nvidia.com>
 <CAJaqyWeUHiZXMFkNBpinCsJAXojtPkGz+SjzUNDPx5W=qqON1w@mail.gmail.com> <c03eb2bb3ad76e28be2bb9b9e4dee4c3bc062ea7.camel@nvidia.com>
In-Reply-To: <c03eb2bb3ad76e28be2bb9b9e4dee4c3bc062ea7.camel@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 21 Dec 2023 15:55:38 +0100
Message-ID: <CAJaqyWevZX5TKpaLiJwu2nD7PHFsHg+TEZ=iPdWvrH4jyPV+cA@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	"mst@redhat.com" <mst@redhat.com>, "leon@kernel.org" <leon@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 3:38=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Thu, 2023-12-21 at 13:08 +0100, Eugenio Perez Martin wrote:
> > On Thu, Dec 21, 2023 at 12:52=E2=80=AFPM Dragos Tatulea <dtatulea@nvidi=
a.com> wrote:
> > >
> > > On Thu, 2023-12-21 at 08:46 +0100, Eugenio Perez Martin wrote:
> > > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, Dec 20, 2023 at 9:32=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 20, 2023 at 5:06=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 20, 2023 at 11:46=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dta=
tulea@nvidia.com> wrote:
> > > > > > > > >
> > > > > > > > > The virtio spec doesn't allow changing virtqueue addresse=
s after
> > > > > > > > > DRIVER_OK. Some devices do support this operation when th=
e device is
> > > > > > > > > suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSP=
END flag
> > > > > > > > > advertises this support as a backend features.
> > > > > > > >
> > > > > > > > There's an ongoing effort in virtio spec to introduce the s=
uspend state.
> > > > > > > >
> > > > > > > > So I wonder if it's better to just allow such behaviour?
> > > > > > >
> > > > > > > Actually I mean, allow drivers to modify the parameters durin=
g suspend
> > > > > > > without a new feature.
> > > > > > >
> > > > > >
> > > > > > That would be ideal, but how do userland checks if it can suspe=
nd +
> > > > > > change properties + resume?
> > > > >
> > > > > As discussed, it looks to me the only device that supports suspen=
d is
> > > > > simulator and it supports change properties.
> > > > >
> > > > > E.g:
> > > > >
> > > > > static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 i=
dx,
> > > > >                                   u64 desc_area, u64 driver_area,
> > > > >                                   u64 device_area)
> > > > > {
> > > > >         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > > > >         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> > > > >
> > > > >         vq->desc_addr =3D desc_area;
> > > > >         vq->driver_addr =3D driver_area;
> > > > >         vq->device_addr =3D device_area;
> > > > >
> > > > >         return 0;
> > > > > }
> > > > >
> > > >
> > > > So in the current kernel master it is valid to set a different vq
> > > > address while the device is suspended in vdpa_sim. But it is not va=
lid
> > > > in mlx5, as the FW will not be updated in resume (Dragos, please
> > > > correct me if I'm wrong). Both of them return success.
> > > >
> > > In the current state, there is no resume. HW Virtqueues will just get=
 re-created
> > > with the new address.
> > >
> >
> > Oh, then all of this is effectively transparent to the userspace
> > except for the time it takes?
> >
> Not quite: mlx5_vdpa_set_vq_address will save the vq address only on the =
SW vq
> representation. Only later will it will call into the FW to update the FW=
. Later
> means:
> - On DRIVER_OK state, when the VQs get created.
> - On .set_map when the VQs get re-created (before this series) / updated =
(after
> this series)
> - On .resume (after this series).
>
> So if the .set_vq_address is called when the VQ is in DRIVER_OK but not
> suspended those addresses will be set later for later.
>

Ouch, that is more in the line of my thoughts :(.

> > In that case you're right, we don't need feature flags. But I think it
> > would be great to also move the error return in case userspace tries
> > to modify vq parameters out of suspend state.
> >
> On the driver side or on the core side?
>

Core side.

It does not have to be part of this series, I meant it can be proposed
in a separate series and applied before the parent driver one.

> Thanks
> > Thanks!
> >
> >
> > > > How can we know in the destination QEMU if it is valid to suspend &
> > > > set address? Should we handle this as a bugfix and backport the
> > > > change?
> > > >
> > > > > >
> > > > > > The only way that comes to my mind is to make sure all parents =
return
> > > > > > error if userland tries to do it, and then fallback in userland=
.
> > > > >
> > > > > Yes.
> > > > >
> > > > > > I'm
> > > > > > ok with that, but I'm not sure if the current master & previous=
 kernel
> > > > > > has a coherent behavior. Do they return error? Or return succes=
s
> > > > > > without changing address / vq state?
> > > > >
> > > > > We probably don't need to worry too much here, as e.g set_vq_addr=
ess
> > > > > could fail even without suspend (just at uAPI level).
> > > > >
> > > >
> > > > I don't get this, sorry. I rephrased my point with an example earli=
er
> > > > in the mail.
> > > >
> > >
> >
>

