Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3855684
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401890; cv=none; b=AamNJVPqMkDrXR8MQ6nA1G2U02rg04d8hx5V3NpdU6NswVKxRc1Kfym8gOdq59e49k6UoGMFzU/WOJ7bl3z/dUXRjluz9UhabQdejCqDV8UAVWXJTjMwPFtIk+RJS4Tht4zf5+M42sDAQ3SLzyX3YbJQpKFMBXijU4cJ79rOFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401890; c=relaxed/simple;
	bh=i7orZlqUt3DNSMN5clgSBt2A1xUqK233W6Rhf+3quPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHNJ3YNL7QHb5qjnnY3ymhSYR2drE/qcJ32BZzPHbBs/atlwGo9wU1hJbmXAXJyfSGRbNHWSPyewi26Ov5Xt++IsKFM46dFJG0qEcFOPhoH0OAnzDW414j1dVCD1atdlioGnwcxaCHyTG+YaeS+nk1GKru7+gvSDS0Q7hzVTBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHgcpHSF; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHgcpHSF"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4588840865
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 00:58:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coIz6GFhYLiJ for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Apr 2024 00:58:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1510240855
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1510240855
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eHgcpHSF
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1510240855
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 00:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713401886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEz8Ba2N42uxVER1hKipg4PtiWGzIt9uN4hOueYNQ8I=;
	b=eHgcpHSFtM8GTHpdzylX7kZXzZ6aor3aOcCSr/e74S4Gr8gUa1b3V0dMqSNkw2mL6IBgmw
	TeCArgR0xJZNl5XZCVFRqytXW0HcR+/EMQ2BC1f+9Q2+4W50py10cpz7kRdiVbdmx0c8CM
	SK4olIWCQV4wjyvjdRJK/sm6K7GIRYs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-iGzkxeClNRuBggx_9vAYLA-1; Wed, 17 Apr 2024 20:58:04 -0400
X-MC-Unique: iGzkxeClNRuBggx_9vAYLA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cf35636346so288346a12.3
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 17:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713401883; x=1714006683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEz8Ba2N42uxVER1hKipg4PtiWGzIt9uN4hOueYNQ8I=;
        b=MHgFoekvzP1duXrF6P0iXx/PenOIcpm0i/xF83DlqiVPDrH9p7Ps8FihbnAolLqfQU
         aHtt+OlBZsnAT6ET5VIbU09glHK8nN+eLSz1Y5xOhDPTJ9k42UL++EibUtCn7A/oJ0YE
         Dx4vzj3pRIwKxBTMCuelieqMnv9Y5RSG44oTK6ETfzuJTKOS/X8jVCSj0j07VVD0Ft9Q
         6Kb78A3TomqxAB0ZFaw7eb1GEdUq6QjiOfQ+gCH4lxsWXT5pIpC0Q5IGgKU1/S8lFw4B
         4vbpkWWd5tX5sCuoiS0CneASiftsZWLsZD0nQOGAClw1LDysgeuGLG568vtKYtJQCJtx
         bb4A==
X-Forwarded-Encrypted: i=1; AJvYcCVjCW/su2EoUsIxZWiBl7SwMN7yxerOZdKmaO3bKlI9DiGFqB/Augt3cZmovqiD8heisFZPfAAG5irpxhLO4AGq0Glx8qNnamCrjF6n021AqKf48a14zYddZg==
X-Gm-Message-State: AOJu0YxhizDTHeEezBDdpzeXrZcFIRUa0ibLDY/aqhk0Yso1vF9ysED3
	IHIGGHwngXsCiO0IyZ5JrryQiSi4b/xpXqZ3MmQkBfLkNIr2MiJH/WIikTOjkD9ytBrdOjpimiq
	tvvjfZxkFL9zZ44ELJRMFp9BoCSoyM9aTzIAYRLbDfwf5SBa1gL5MDUtu97oLocZEtR43oKHA37
	1BG+elebJEgz4YC23BQEsHHYdR3WA/SqR6GrSW82nqJtfV6oOgs3PZ9g==
X-Received: by 2002:a05:6a20:3cab:b0:1a9:9c20:6ca with SMTP id b43-20020a056a203cab00b001a99c2006camr1823514pzj.23.1713401883405;
        Wed, 17 Apr 2024 17:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgl758j2Btq3Dlb+sVtrCdaXysTD7w9b6JpUV2zn8FSoCMJ7LB4NF/74mUQsuz8dZ9ERKdhaDsbJaNLzhs5RU=
X-Received: by 2002:a05:6a20:3cab:b0:1a9:9c20:6ca with SMTP id
 b43-20020a056a203cab00b001a99c2006camr1823500pzj.23.1713401883114; Wed, 17
 Apr 2024 17:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240417052723-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 08:57:51 +0800
Message-ID: <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > Add the function vduse_alloc_reconnnect_info_mem
> > and vduse_alloc_reconnnect_info_mem
> > These functions allow vduse to allocate and free memory for reconnectio=
n
> > information. The amount of memory allocated is vq_num pages.
> > Each VQS will map its own page where the reconnection information will =
be saved
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index ef3c9681941e..2da659d5f4a8 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> >       int irq_effective_cpu;
> >       struct cpumask irq_affinity;
> >       struct kobject kobj;
> > +     unsigned long vdpa_reconnect_vaddr;
> >  };
> >
> >  struct vduse_dev;
> > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct=
 vduse_virtqueue *vq)
> >
> >       vq->irq_effective_cpu =3D curr_cpu;
> >  }
> > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > +{
> > +     unsigned long vaddr =3D 0;
> > +     struct vduse_virtqueue *vq;
> > +
> > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > +             /*page 0~ vq_num save the reconnect info for vq*/
> > +             vq =3D dev->vqs[i];
> > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
>
>
> I don't get why you insist on stealing kernel memory for something
> that is just used by userspace to store data for its own use.
> Userspace does not lack ways to persist data, for example,
> create a regular file anywhere in the filesystem.

Good point. So the motivation here is to:

1) be self contained, no dependency for high speed persist data
storage like tmpfs
2) standardize the format in uAPI which allows reconnection from
arbitrary userspace, unfortunately, such effort was removed in new
versions

If the above doesn't make sense, we don't need to offer those pages by VDUS=
E.

Thanks


>
>
>
> > +             if (vaddr =3D=3D 0)
> > +                     return -ENOMEM;
> > +
> > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > +{
> > +     struct vduse_virtqueue *vq;
> > +
> > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > +             vq =3D dev->vqs[i];
> > +
> > +             if (vq->vdpa_reconnect_vaddr)
> > +                     free_page(vq->vdpa_reconnect_vaddr);
> > +             vq->vdpa_reconnect_vaddr =3D 0;
> > +     }
> > +
> > +     return 0;
> > +}
> >
> >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >                           unsigned long arg)
> > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> >               mutex_unlock(&dev->lock);
> >               return -EBUSY;
> >       }
> > +     vduse_free_reconnnect_info_mem(dev);
> > +
> >       dev->connected =3D true;
> >       mutex_unlock(&dev->lock);
> >
> > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_co=
nfig *config,
> >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, config->vq_num)=
;
> >       if (ret)
> >               goto err_vqs;
> > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > +     if (ret < 0)
> > +             goto err_mem;
> >
> >       __module_get(THIS_MODULE);
> >
> >       return 0;
> >  err_vqs:
> >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor=
));
> > +err_mem:
> > +     vduse_free_reconnnect_info_mem(dev);
> >  err_dev:
> >       idr_remove(&vduse_idr, dev->minor);
> >  err_idr:
> > --
> > 2.43.0
>

