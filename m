Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478E63A1
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlpHFSmR"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53CA64016B
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 02:03:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53CA64016B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlpHFSmR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XKYPGeqoek0X
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Dec 2023 02:03:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1AA154013B
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 02:03:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1AA154013B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703124200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVgqAvwwX5PZ+K0StsYhb5ohbh7FF/syTZKMQDbQ9v4=;
	b=FlpHFSmRxISlxdC4imaprHhmFqKZce5fhdrYcJG5zeNt5zUUr13BPs5vKUnVDqwIod9bPw
	dGvyAe+DqWJdSqvM99IiFoCXqKj+fopdsKNYpgiPHqn2b5nlG/WL1DjWIJxjKSIprXOQHO
	XeqUiKgearbMNEN0p0j4hGUG3SND7O8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-sQPBweJUOzmUM9GJKQwmPQ-1; Wed, 20 Dec 2023 21:03:17 -0500
X-MC-Unique: sQPBweJUOzmUM9GJKQwmPQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d289e2b084so352528b3a.2
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 18:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703124196; x=1703728996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVgqAvwwX5PZ+K0StsYhb5ohbh7FF/syTZKMQDbQ9v4=;
        b=kVLcAaIZgAaEwcFY4BLIoYuLNp3GCfEAvzs0twc5nGIgbZLS1MpTO9nGCDwMhwhf2h
         rTtlLDz41oExL6lJvYgFLDR7tLWBpEVRd4GkyKEnC4jgDZ0nB4/auOlnSbm75xcTazIo
         W51T/sAmuBiJ7gjHOFjCLTPg2UM2ExB5Grc78OGzo0DA32qZj/CEXpuuyFabTrSknPnV
         d/qJl2ixJAunSrJhLSM4ml2z2AyvUHyAwHCb6lSLFE+Bz8xUqyurocBL1ZzugHZzqi8G
         f9fM2hrwe+rYeoGcqddxA5kiqIqFmgdfgv2ku/LO+0oglpobQDII8olphUXTxDz/kPin
         wYBw==
X-Gm-Message-State: AOJu0Yzxw7UBuK6hK/oa7buX9lHa1KBJKx8jQgjjs0QvOAx3ahIkdv0D
	9tVhuD27NWGlsvUB0+xIDeMy9WfHGKaTvbyEpfW4gfrA7pX4w0V8tmEyuHk4SZ3bnxgff1f5hiY
	DHooA5JJgduzJh2SU1WLZnJ9ryhiZO8KYNWynooHWrrL+UbfuD90tUGH/og==
X-Received: by 2002:a05:6a00:708:b0:6d9:46f4:4226 with SMTP id 8-20020a056a00070800b006d946f44226mr2361719pfl.20.1703124196283;
        Wed, 20 Dec 2023 18:03:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/KGKYSCtd/fkWAWhBJnYkjiak2fMrNDbFAXlC8oYYs9VT364GRHf9AqL3ddt2MNKwq9lVLHfwyUtJQ0JG1u4=
X-Received: by 2002:a05:6a00:708:b0:6d9:46f4:4226 with SMTP id
 8-20020a056a00070800b006d946f44226mr2361704pfl.20.1703124196001; Wed, 20 Dec
 2023 18:03:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
 <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
 <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com> <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
In-Reply-To: <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 10:03:05 +0800
Message-ID: <CACGkMEuM7bXxsxHUs_SodiDQ2+akrLqqzWZBJSZEcnMASUkb+g@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 9:32=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Dec 20, 2023 at 5:06=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Dec 20, 2023 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> > > >
> > > > The virtio spec doesn't allow changing virtqueue addresses after
> > > > DRIVER_OK. Some devices do support this operation when the device i=
s
> > > > suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
> > > > advertises this support as a backend features.
> > >
> > > There's an ongoing effort in virtio spec to introduce the suspend sta=
te.
> > >
> > > So I wonder if it's better to just allow such behaviour?
> >
> > Actually I mean, allow drivers to modify the parameters during suspend
> > without a new feature.
> >
>
> That would be ideal, but how do userland checks if it can suspend +
> change properties + resume?

As discussed, it looks to me the only device that supports suspend is
simulator and it supports change properties.

E.g:

static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
                                  u64 desc_area, u64 driver_area,
                                  u64 device_area)
{
        struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
        struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];

        vq->desc_addr =3D desc_area;
        vq->driver_addr =3D driver_area;
        vq->device_addr =3D device_area;

        return 0;
}

>
> The only way that comes to my mind is to make sure all parents return
> error if userland tries to do it, and then fallback in userland.

Yes.

> I'm
> ok with that, but I'm not sure if the current master & previous kernel
> has a coherent behavior. Do they return error? Or return success
> without changing address / vq state?

We probably don't need to worry too much here, as e.g set_vq_address
could fail even without suspend (just at uAPI level).

Thanks

>

