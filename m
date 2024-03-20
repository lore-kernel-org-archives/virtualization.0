Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A23A267
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927096; cv=none; b=NTn75+AB9c1uf2Ga28K/UFsmKIOj6fg7RsVWV5LiDDHpKJIaYFxn6eD9WjBZ5g9uMacI7xuqqM+MMSk6RdJEiBJ91dIebx5TWDQXvyNweHn6a6TBuvcN3AM5mrqKrPn1N9rIYZsh7Mw66TAUOUhK838F/lSKVP5ROFJFz3bkxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927096; c=relaxed/simple;
	bh=m3OuEhR/6MblZ2PmSzWxlYaPTpvH2hKzIR9TJDfxRHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtDa/o8RkXmRy5fP4lWUTj9zbIHRU33ht13j5B9KlZg3pJCaMWO/WhF6KcFjCx64ovMUdfqF+5bpWfgtbVGFJ9xoIJIwAqghWmJNIFn6JzVvrFnpoiPC7JBIq52dhCPV+r3rSAWw4ftTP0OOyQ6w7LuzzZfMJ7AjvbcAaZZOR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4OnhUbR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4OnhUbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710927093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcpPpj8COzr4sFGDjPc9DI4s95FhBo7rGSMdOcO4pRA=;
	b=Z4OnhUbRQjF+/gA+SQ7oKkvou1pvkvfcSWRfH+Rg40p2/aNf87gpprjs3miFf4qMDt1l55
	L1nYLmVLZNn7U5hpGYvkDz5rJig2Oyg7z+QSlnHi3bvc+HiaD3zvvQ922/+xGfRRVv5iY/
	BemE+HYOvSG1WjtSwlztuSMb5yYbk6o=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-6H9IvBALNBW9V4JnxvXB5w-1; Wed, 20 Mar 2024 05:31:31 -0400
X-MC-Unique: 6H9IvBALNBW9V4JnxvXB5w-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e6a7798bfdso4058483b3a.3
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 02:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710927090; x=1711531890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcpPpj8COzr4sFGDjPc9DI4s95FhBo7rGSMdOcO4pRA=;
        b=LOywfDT9N4VtwmAr5Mb/gJ/30r5UT448LenkBAIgc2v2v5ovHJk7INxJ7a15DW8LME
         VBAi4iE0UHKdjaMDarV/0cKUkEPiYzUosYBVDuX0uWtSYCuudu7k3glru+7BoADzbrae
         eQ6niugHAPxlx2xQYw3SMpNFhhe2lC9HMGQ4/sBW1LuH3+5uOjTmO9pcqCu5ZHlCdkD1
         L33zYHioXvIHWeCxNKhqFtVGiEBjxh7xGa8XTp2gXqTMYhDPPemd5ZC5jbdwcQLdw9oW
         BPAe6UP/CzFMJd+DvtgDMQ53RT1XnaeeMOI+v8AH9kjIERtdrOnCAelkSxCj3SXwU+li
         BI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3/qUOjQ4SC/J3GzjXsM744F8qI0LvKOx0Y780tFx97J0U0TvXVqA+BojYVDQCMNN8veQG8GrKSCivrpVmtZgcEUMcVMb/r8L2Bgz+Fu8=
X-Gm-Message-State: AOJu0Yy27EekVk5O1Fj5ezBDo52RjrssU1eq1orlFhJg6ihM/oDLED4C
	qtAvIQjHUAR8jAhQ7n0XUVxUtudKO3QtTi/VEhMomVqmqOpb+qHz/t7HeVf5TGf2J2lc68EYYlX
	h3p2zNsCQSWfF+Jg/QbaAug1PucjHVcWO49rOTkXXqcFy69/G3uG1zDnh9Z8R06AC5tlWMQaK96
	grguuXw6YVR7XLT2AiVhvrwW7nwDydyTE5waw/s6M=
X-Received: by 2002:a05:6a20:e01:b0:1a3:6f61:200d with SMTP id ej1-20020a056a200e0100b001a36f61200dmr4956851pzb.9.1710927090294;
        Wed, 20 Mar 2024 02:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8qe09t4g3HfkRiIbfxrA8Ju1f60Up1DuN2Huw8OLenlVMbWpJINYFcOydIKj7JhZrxkyZn+X3zIVTMeJ8+is=
X-Received: by 2002:a05:6a20:e01:b0:1a3:6f61:200d with SMTP id
 ej1-20020a056a200e0100b001a36f61200dmr4956832pzb.9.1710927089974; Wed, 20 Mar
 2024 02:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com> <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com> <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
 <1710487245.6843069-1-xuanzhuo@linux.alibaba.com> <CACGkMEspzDTZP1yxkBz17MgU9meyfCUBDxG8mjm=acXHNxAxhg@mail.gmail.com>
 <1710741592.205804-1-xuanzhuo@linux.alibaba.com> <20240319025726-mutt-send-email-mst@kernel.org>
 <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com>
In-Reply-To: <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 17:31:18 +0800
Message-ID: <CACGkMEtfZx3+PcR7pCKQ9feLSERX6W-UKR0iJWEXVt7Q7ssZNA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of
 multi parameters
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 5:22=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Mar 19, 2024 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Mon, Mar 18, 2024 at 01:59:52PM +0800, Xuan Zhuo wrote:
> > > On Mon, 18 Mar 2024 12:18:23 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Fri, Mar 15, 2024 at 3:26=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanzhu=
o@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > Now, we pass multi parameters to find_vqs. These paramete=
rs
> > > > > > > > > may work for transport or work for vring.
> > > > > > > > >
> > > > > > > > > And find_vqs has multi implements in many places:
> > > > > > > > >
> > > > > > > > >  arch/um/drivers/virtio_uml.c
> > > > > > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > > > > > > >  drivers/remoteproc/remoteproc_virtio.c
> > > > > > > > >  drivers/s390/virtio/virtio_ccw.c
> > > > > > > > >  drivers/virtio/virtio_mmio.c
> > > > > > > > >  drivers/virtio/virtio_pci_legacy.c
> > > > > > > > >  drivers/virtio/virtio_pci_modern.c
> > > > > > > > >  drivers/virtio/virtio_vdpa.c
> > > > > > > > >
> > > > > > > > > Every time, we try to add a new parameter, that is diffic=
ult.
> > > > > > > > > We must change every find_vqs implement.
> > > > > > > > >
> > > > > > > > > One the other side, if we want to pass a parameter to vri=
ng,
> > > > > > > > > we must change the call path from transport to vring.
> > > > > > > > > Too many functions need to be changed.
> > > > > > > > >
> > > > > > > > > So it is time to refactor the find_vqs. We pass a structu=
re
> > > > > > > > > cfg to find_vqs(), that will be passed to vring by transp=
ort.
> > > > > > > > >
> > > > > > > > > Because the vp_modern_create_avq() use the "const char *n=
ames[]",
> > > > > > > > > and the virtio_uml.c changes the name in the subsequent c=
ommit, so
> > > > > > > > > change the "names" inside the virtio_vq_config from "cons=
t char *const
> > > > > > > > > *names" to "const char **names".
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > > > > > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.intel=
.com>
> > > > > > > >
> > > > > > > > The name seems broken here.
> > > > > > >
> > > > > > > Email APP bug.
> > > > > > >
> > > > > > > I will fix.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > >
> > > > > > > > >  typedef void vq_callback_t(struct virtqueue *);
> > > > > > > > >
> > > > > > > > > +/**
> > > > > > > > > + * struct virtio_vq_config - configure for find_vqs()
> > > > > > > > > + * @cfg_idx: Used by virtio core. The drivers should set=
 this to 0.
> > > > > > > > > + *     During the initialization of each vq(vring setup)=
, we need to know which
> > > > > > > > > + *     item in the array should be used at that time. Bu=
t since the item in
> > > > > > > > > + *     names can be null, which causes some item of arra=
y to be skipped, we
> > > > > > > > > + *     cannot use vq.index as the current id. So add a c=
fg_idx to let vring
> > > > > > > > > + *     know how to get the current configuration from th=
e array when
> > > > > > > > > + *     initializing vq.
> > > > > > > >
> > > > > > > > So this design is not good. If it is not something that the=
 driver
> > > > > > > > needs to care about, the core needs to hide it from the API=
.
> > > > > > >
> > > > > > > The driver just ignore it. That will be beneficial to the vir=
tio core.
> > > > > > > Otherwise, we must pass one more parameter everywhere.
> > > > > >
> > > > > > I don't get here, it's an internal logic and we've already done=
 that.
> > > > >
> > > > >
> > > > > ## Then these must add one param "cfg_idx";
> > > > >
> > > > >  struct virtqueue *vring_create_virtqueue(struct virtio_device *v=
dev,
> > > > >                                          unsigned int index,
> > > > >                                          struct vq_transport_conf=
ig *tp_cfg,
> > > > >                                          struct virtio_vq_config =
*cfg,
> > > > > -->                                      uint cfg_idx);
> > > > >
> > > > >  struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev=
,
> > > > >                                       unsigned int index,
> > > > >                                       void *pages,
> > > > >                                       struct vq_transport_config =
*tp_cfg,
> > > > >                                       struct virtio_vq_config *cf=
g,
> > > > > -->                                      uint cfg_idx);
> > > > >
> > > > >
> > > > > ## The functions inside virtio_ring also need to add a new param,=
 such as:
> > > > >
> > > > >  static struct virtqueue *vring_create_virtqueue_split(struct vir=
tio_device *vdev,
> > > > >                                                       unsigned in=
t index,
> > > > >                                                       struct vq_t=
ransport_config *tp_cfg,
> > > > >                                                       struct virt=
io_vq_config,
> > > > > -->                                                   uint cfg_id=
x);
> > > > >
> > > > >
> > > > >
> > > >
> > > > I guess what I'm missing is when could the index differ from cfg_id=
x?
> > >
> > >
> > >  @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > >      During the initialization of each vq(vring setup), we need to kn=
ow which
> > >      item in the array should be used at that time. But since the ite=
m in
> > >      names can be null, which causes some item of array to be skipped=
, we
> > >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >      cannot use vq.index as the current id. So add a cfg_idx to let v=
ring
> > >      know how to get the current configuration from the array when
> > >      initializing vq.
> > >
> > >
> > > static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int =
nvqs,
> > >
> > >       ................
> > >
> > >       for (i =3D 0; i < nvqs; ++i) {
> > >               if (!names[i]) {
> > >                       vqs[i] =3D NULL;
> > >                       continue;
> > >               }
> > >
> > >               if (!callbacks[i])
> > >                       msix_vec =3D VIRTIO_MSI_NO_VECTOR;
> > >               else if (vp_dev->per_vq_vectors)
> > >                       msix_vec =3D allocated_vectors++;
> > >               else
> > >                       msix_vec =3D VP_MSIX_VQ_VECTOR;
> > >               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, callbacks[i],=
 names[i],
> > >                                    ctx ? ctx[i] : false,
> > >                                    msix_vec);
> > >
> > >
> > > Thanks.
> >
> >
> > Jason what do you think is the way to resolve this?
>
> I wonder which driver doesn't use a specific virtqueue in this case.
>
> And it looks to me, introducing a per-vq-config struct might be better
> then we have
>
> virtio_vqs_config {
>       unsigned int nvqs;
>       struct virtio_vq_config *configs;
> }
>
> So we don't need the cfg_idx stuff.

And actually, I'm also ok to have cfg_idx internally, it's better than
having an API which has a field that the user doesn't need to care
about.

Thanks

>
> Thanks
>
> >
> > > >
> > > > Thanks
> > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> >

