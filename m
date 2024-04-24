Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C724C6D
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919469; cv=none; b=mJiZYwaUBPplxKwbWfuWtbL/zTlwrFCnX2PVgo9ppwehQeiO4JbcDj2kwq4G9/TTXNTHgnMLCvFye+IHQLEgEsWwqxL9JyiIHtpQtKcDLa+J+qaG7cxwjAOhDNSB/KCyk/k01FlEKX5OP3Q9hYNHUnIB/AJrB9wDef81LYJO3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919469; c=relaxed/simple;
	bh=Vec3AELdicTqN0afSgEb3GoinhUyJSmXLRWU37K2U8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfuJ7WE+odwnBJeY8xOUgzjTaNUOi4X0V1/0xgvJJd9jpAGufSZo76OwfNkWJZ0EtvzGDzk+oJOVQSo7BcDx+Bc6aQAiG3KUfPOHh10o25qEZ3ifEdcV5eiYrHUofYNgejmGaRQGZDKQ1o0XcgV4gZQleSGV12g5q6Vcnngb4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUD0FRpO; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUD0FRpO"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD38340273
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 00:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MVkgInYRbrG5 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Apr 2024 00:44:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5E9184026B
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E9184026B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CUD0FRpO
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5E9184026B
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 00:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713919464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sqcm0DKufT9EZxiM+0OzeY88Sk4DHeOhk+mWIf/p4wo=;
	b=CUD0FRpOBREHVvKTziLOVF0fwiZLSGMs2gG/8/+vxPUSda6frTNjaBGyp9Qmx2EjRYHCCN
	l5n1/zhp1pYIOoUG7MOldhfv/NF5dwjq3HKT3/A3zqLprOizHC1NWFWvmflnC9B0e3U6Ez
	ZesGc6ELp/cLhZ/B5MdaQUN0ivbV/ig=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-xW7PRQcRPwewFRNLydtPAg-1; Tue, 23 Apr 2024 20:44:22 -0400
X-MC-Unique: xW7PRQcRPwewFRNLydtPAg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2abc5b4f3c7so6887178a91.0
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 17:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713919461; x=1714524261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqcm0DKufT9EZxiM+0OzeY88Sk4DHeOhk+mWIf/p4wo=;
        b=qMOsGSyBcx1EkiXV7bWsRK/nUu6QBwdWAnJ+mNbPl/K6hoK5plA3RMLjhA8gnf90jh
         5fKANIDyO8l75z2t/9aKQgM/Smv2RVI3s2AY/tuvZjsglB63kXsi0wU2i8IUiZjmOhCd
         /GIfxsUuCno+H8BKVEyyJ9n69aNzItzMEfq8Y6ux2DrF7e3bFY5VYSLe7n3tSwGLeZR6
         obRzfRBq+OMke+bLZXT3ZXRSjqbRrmnNg1n6CVGKp7cuu5NTS4PmTMSEJuNWl/jWQlGR
         rRugIgj3zBElfG+C5dE9kYUSZDmTZrMISuXzi6/Na1XO5KD+VC0SiXK2n0IMKXOl/9Fd
         vmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXAeFNx+GEDIkJdxPwerfc3cFfnNHf4Pob9JgGhAowHiQCO0lxgnjhgqZswciFAh8ODywhadXT+Kti5QAUxwJeRcvozr/UrQupMEQEoO+kc0621ribR/Ad+A==
X-Gm-Message-State: AOJu0YwjBXBZZj+NZQo3h2Ajyf12u01qr2SuygKFRQ5r/n0Ar+ih/0IH
	8gLyeq9ZoZkOqq7jxcVs/PoWoh3iNmMBUKmtQFKMvqlyeza5N0DDtdv9zWw07lirOARFiHLSv36
	+wvhVO1b9KYWgnSb4+sDcmdhjoOTDLBnsaPfqa/mDgpkT/9z0YEAUPCnmR7j3F4RD9amtf2GHO/
	BHERVUoLMbz00IGtnyOZz7NH5EossH3eA+9rNtj0xS0qlaFl54NdHXYQ==
X-Received: by 2002:a17:90b:1103:b0:2a3:be59:e969 with SMTP id gi3-20020a17090b110300b002a3be59e969mr862697pjb.47.1713919461467;
        Tue, 23 Apr 2024 17:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0Gh2nYGbLqjL1EPBd4oIGhOxCQSJxaQwomV1RaYRhZ6h2DmJHdl+zUN+m5ZFLbiPKeZu77uBcGISXFd7KILg=
X-Received: by 2002:a17:90b:1103:b0:2a3:be59:e969 with SMTP id
 gi3-20020a17090b110300b002a3be59e969mr862684pjb.47.1713919461083; Tue, 23 Apr
 2024 17:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org> <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org> <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240423043538-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 08:44:10 +0800
Message-ID: <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > These functions allow vduse to allocate and free memory for rec=
onnection
> > > > > > information. The amount of memory allocated is vq_num pages.
> > > > > > Each VQS will map its own page where the reconnection informati=
on will be saved
> > > > > >
> > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++=
++++++++
> > > > > >  1 file changed, 40 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/=
vdpa_user/vduse_dev.c
> > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > >       int irq_effective_cpu;
> > > > > >       struct cpumask irq_affinity;
> > > > > >       struct kobject kobj;
> > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > >  };
> > > > > >
> > > > > >  struct vduse_dev;
> > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cp=
u(struct vduse_virtqueue *vq)
> > > > > >
> > > > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > > > >  }
> > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *d=
ev)
> > > > > > +{
> > > > > > +     unsigned long vaddr =3D 0;
> > > > > > +     struct vduse_virtqueue *vq;
> > > > > > +
> > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > > > +             vq =3D dev->vqs[i];
> > > > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > > > >
> > > > >
> > > > > I don't get why you insist on stealing kernel memory for somethin=
g
> > > > > that is just used by userspace to store data for its own use.
> > > > > Userspace does not lack ways to persist data, for example,
> > > > > create a regular file anywhere in the filesystem.
> > > >
> > > > Good point. So the motivation here is to:
> > > >
> > > > 1) be self contained, no dependency for high speed persist data
> > > > storage like tmpfs
> > >
> > > No idea what this means.
> >
> > I mean a regular file may slow down the datapath performance, so
> > usually the application will try to use tmpfs and other which is a
> > dependency for implementing the reconnection.
>
> Are we worried about systems without tmpfs now?

Yes.

>
>
> > >
> > > > 2) standardize the format in uAPI which allows reconnection from
> > > > arbitrary userspace, unfortunately, such effort was removed in new
> > > > versions
> > >
> > > And I don't see why that has to live in the kernel tree either.
> >
> > I can't find a better place, any idea?
> >
> > Thanks
>
>
> Well anywhere on github really. with libvhost-user maybe?
> It's harmless enough in Documentation
> if you like but ties you to the kernel release cycle in a way that
> is completely unnecessary.

Ok.

Thanks

>
> > >
> > > > If the above doesn't make sense, we don't need to offer those pages=
 by VDUSE.
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > > > +             if (vaddr =3D=3D 0)
> > > > > > +                     return -ENOMEM;
> > > > > > +
> > > > > > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > > > > > +     }
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *de=
v)
> > > > > > +{
> > > > > > +     struct vduse_virtqueue *vq;
> > > > > > +
> > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > +             vq =3D dev->vqs[i];
> > > > > > +
> > > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > > +             vq->vdpa_reconnect_vaddr =3D 0;
> > > > > > +     }
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > >
> > > > > >  static long vduse_dev_ioctl(struct file *file, unsigned int cm=
d,
> > > > > >                           unsigned long arg)
> > > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> > > > > >               mutex_unlock(&dev->lock);
> > > > > >               return -EBUSY;
> > > > > >       }
> > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > +
> > > > > >       dev->connected =3D true;
> > > > > >       mutex_unlock(&dev->lock);
> > > > > >
> > > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vdus=
e_dev_config *config,
> > > > > >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, config-=
>vq_num);
> > > > > >       if (ret)
> > > > > >               goto err_vqs;
> > > > > > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > > > > > +     if (ret < 0)
> > > > > > +             goto err_mem;
> > > > > >
> > > > > >       __module_get(THIS_MODULE);
> > > > > >
> > > > > >       return 0;
> > > > > >  err_vqs:
> > > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), de=
v->minor));
> > > > > > +err_mem:
> > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > >  err_dev:
> > > > > >       idr_remove(&vduse_idr, dev->minor);
> > > > > >  err_idr:
> > > > > > --
> > > > > > 2.43.0
> > > > >
> > >
>

