Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAD281357
	for <virtualization@lists.linux.dev>; Tue, 10 Jun 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545617; cv=none; b=o4OZXPbqfpXd4sjFcS0p/wTZM+wLQfmA/NHD2BPRYhcrMowz9FoskGXwYThZZ+99A0/CKsKSSF2tXCBx9wiR767yEHCDGxK1s9gknZ2G1zeObXX/9GUtNNaSUXzwlLk7/MSX5jHQfm3CDoN4lZ+7aNggwvH/wgLn4HT9VLunBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545617; c=relaxed/simple;
	bh=0DpUZ9KkrwL5L0LBxsRrJTljyTI0zyHeRhsfl1KdLQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPQE5Hx8C344Xhq4LuVrIEg2OtWRtWdG+ZOjpmF5aeZpqI6mrq5p9JUA5PzoIBp8U9MeB0BN4QCFTO4uDUpI//nOPghpysstsPDj+TE2Fe5obB05ysgxkMlRJT60sEOr/zy5an+VlYNBu9yNc8bKy19gdnxsrWhXvWlMEhBtrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4BjTzX9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4BjTzX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749545614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLr0XlGOIN+Wt+CCLv/Qc/6mxQSoqncCTsMpm4BEGzs=;
	b=K4BjTzX9SL3D1doyDasGcKjxgV6bDk4IQhKZrry8gHJIs56JWc5EWe1NkE0ryWyxmBK6Xm
	UmkAYQMsnHiwxjL47t2Z+6WWS8b4AVeIZW7uw9m8c6ivHOiRv1mjsuaLN2G59XVp5ro7dK
	B+A5m0MS+j/Woq6ZyuxNHQLqdJbK5LE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-gmD9Ot7fMLeLejrYlSe1-Q-1; Tue, 10 Jun 2025 04:53:33 -0400
X-MC-Unique: gmD9Ot7fMLeLejrYlSe1-Q-1
X-Mimecast-MFC-AGG-ID: gmD9Ot7fMLeLejrYlSe1-Q_1749545613
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-747d394f45fso3825051b3a.2
        for <virtualization@lists.linux.dev>; Tue, 10 Jun 2025 01:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749545612; x=1750150412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLr0XlGOIN+Wt+CCLv/Qc/6mxQSoqncCTsMpm4BEGzs=;
        b=DLF1qVkRCV2NnILYFzyEkEXtasip/2H60KELBWPblcH4pDH6YdccHWQqQx6SoxpRHJ
         wIbjiKTJUdJcGf15teR+vQ/D8TPztlLCG1HJc3MdjCeUzWWkEjLkpnTOryeaQeGEtroC
         DLodE8M9cYblAsg2J4mxG+TwZuE6tzNuPX+Lu4oGHI25NqGcSn8T4wVkCzfzRloHzRmB
         jKywuJmi6b3Ci6lcfGQE60/qS0+Q8+CZyCNPzcAVyHn2PkBXGcKbQZFSSeHevCkpAP+v
         x5yaX05Wapw2YhTDWxq5W0wMRlnfMmn8aTa0FtxWiUZHdO099C5fRzoTru31fliX3qNM
         3XUg==
X-Forwarded-Encrypted: i=1; AJvYcCWVW/L1bjiWrqEYxjXQi2HHMGJl+Cx90DJkfQsMM1YOhfbNccIBg/r1bz+BPvfv9JtagUUXdfYnzASBByWO3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPlKtyTs5LpI7/bj3YmgS2Qle/UH1e3rwmnIUq/4fhSIcBVXYZ
	j004GQCS+wXPc6O8lcIqQTYunDyPIZUmnFAJmt2WNVFrxENZtp4UkK6UZfvzd05ku5mkPyNxNVx
	Z0k2dPWkNp3+kHxwNJoCqk+nBxDfPL6vwVPP2lWv2chkQxIPHt1XrspBiTgf1C2KdoF2alvw+5A
	5ocJ6LKXHqKB/agONv20WdCtJKk5GhCMcuWNFg0gzPm68=
X-Gm-Gg: ASbGnct6kCDXL5iE5dlw03N/B8sPhzvlkkbUGmOCH0wj1vS2eWaQWWXQrX7lWLoTvn4
	QP5aSfSu42WrmTrBU2shN0qgTk+qejEUgMRdu2E4+Fi8aRUDyNRqGnlIsIV5AZyvrwy6gNBkU8U
	G5ErLk
X-Received: by 2002:a05:6a00:488b:b0:748:2eb7:8cc7 with SMTP id d2e1a72fcca58-7482eb793b6mr14576143b3a.21.1749545612510;
        Tue, 10 Jun 2025 01:53:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDtQATZhNUeHCayiq82Q3uWbh+a992wQoACyQuVqjg1uIut3p9JRqy80WxfvRLTLkZ3TwDx6H3hdyFEwqiPfI=
X-Received: by 2002:a05:6a00:488b:b0:748:2eb7:8cc7 with SMTP id
 d2e1a72fcca58-7482eb793b6mr14576134b3a.21.1749545612160; Tue, 10 Jun 2025
 01:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-3-eperezma@redhat.com>
 <CACGkMEuGC6NQmfUgXj1YVyURQ6-S2YT2qkAuYQGLpqVaV75kJg@mail.gmail.com> <CAJaqyWcvHx7kwcTceN2jazT0nKNo1r5zdzqWHqpxdna-kCS1RA@mail.gmail.com>
In-Reply-To: <CAJaqyWcvHx7kwcTceN2jazT0nKNo1r5zdzqWHqpxdna-kCS1RA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Jun 2025 16:53:20 +0800
X-Gm-Features: AX0GCFuqGQsBNSumlUewaUtQcwP98_Y_ku7R1josEfD_6XY6HQFkMkPp5R96B_Q
Message-ID: <CACGkMEu+s_4feR6X2MBOPQFjwULEkD933ZTbQnkG+GfZ9rqcMg@mail.gmail.com>
Subject: Re: [RFC 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HRUzh6TdJnt8WWvMypwj91VtV0Va6tadoiDRllG0xG4_1749545613
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 2:03=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Jun 9, 2025 at 3:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > The virtqueue group is the minimal set of virtqueues that must share =
an
> > > address space.  And the address space identifier could only be attach=
ed
> > > to a specific virtqueue group.  The virtqueue is attached to a
> > > virtqueue group for all the life of the device.
> > >
> > > During vDPA device allocation, the VDUSE device needs to report the
> > > number of virtqueue groups supported. At this moment only vhost_vdpa =
is
> > > able to do it.
> > >
> > > This helps to isolate the environments for the virtqueue that will no=
t
> > > be assigned directly. E.g in the case of virtio-net, the control
> > > virtqueue will not be assigned directly to guest.
> > >
> > > As we need to back the vq groups with a struct device for the file
> > > operations, let's keep this number as low as possible at the moment: =
2.
> > > We can back one VQ group with the vduse device and the other one with
> > > the vdpa device.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 44 ++++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/vduse.h         | 17 +++++++++++-
> > >  2 files changed, 59 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 6a9a37351310..6fa687bc4912 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -46,6 +46,11 @@
> > >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
> > >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> > >
> > > +/*
> > > + * Let's make it 2 for simplicity.
> > > + */
> > > +#define VDUSE_MAX_VQ_GROUPS 2
> > > +
> > >  #define IRQ_UNBOUND -1
> > >
> > >  struct vduse_virtqueue {
> > > @@ -114,6 +119,7 @@ struct vduse_dev {
> > >         u8 status;
> > >         u32 vq_num;
> > >         u32 vq_align;
> > > +       u32 ngroups;
> > >         struct vduse_umem *umem;
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > > @@ -592,6 +598,25 @@ static int vduse_vdpa_set_vq_state(struct vdpa_d=
evice *vdpa, u16 idx,
> > >         return 0;
> > >  }
> > >
> > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +       int ret;
> > > +
> > > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > > +               return 0;
> > > +
> > > +       msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > +       msg.req.vq_group.index =3D idx;
> >
> > Considering there will be a set_group_asid request, could the kernel
> > cache the result so we don't need to bother with requests from
> > userspace?
> >
>
> Yes we can, actually a previous version did it. But what's the use? It
> is not used in the dataplane, so we reduce complexity if we don't
> store it.

It helps to reduce the chance to wait for the userspace. I think it's safer=
.

For example, we cache device status as well, if needed userspace can
update the status via ioctl().

>
> What's more, in the case of the net device, the vq number -> vq group
> association can change in a reset as the CVQ is either the last one or
> #2 if MQ is negotiated. We need to code when to reset this
> association, so complexity grows even more. And the vq group are not
> asked by QEMU after that point anyway.

Yes, we can have an array. E.g simulator has something like:

        struct vhost_iotlb *iommu;

Thanks

