Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B974418
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349271; cv=none; b=GQken4k5B4hAzI5n58vXDVPGrgtLs1KThBLwjZoxfWG3suERdxhESGnrCriFs4ypPYTtFbdDfulFw3MBjqmrirf0b7lNdAyCrjGPl90YiSMw33knIBQI0eNg8O7t6ruoem0O3jjxapPxkvGbbmwyQEWi4t1VRpTO9fkNtHV6m6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349271; c=relaxed/simple;
	bh=fAjHmMPI9BjcKrbZj23D72c/rUSBc/IAX+hDIpozsB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2FGMW4kd4EATOTTo6uYwBizJwg5/71bGhchPCEeJQCE/3p3Ru0MSxa71SrJgjr8TKv8TiqsFa84kDjTetkBBxrnoQLM4ua/dtT1za4ZYGHoOUidUFrw5UYMg35cyt638R35FoKnu/wexZhps/alRAGgrLjy15ttUAW7OFRNvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcUJboQP; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcUJboQP"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4354C60A83
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 03:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lu2XDcSIoWwn for <virtualization@lists.linux-foundation.org>;
 Wed, 22 May 2024 03:41:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7B40B60874
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B40B60874
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QcUJboQP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B40B60874
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 03:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716349263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8S3Gid4+HHyOby23oKkItTJxpdYfB0tmiZc2RtKlOLQ=;
	b=QcUJboQP/0+KWyMu2WFuLlzkEyAe9MINSnSodaMYlZYzKnCcia6btcpDorP7UOxfPNMkY+
	8/+L8HERmMuDj0VG+yEFMtCEQOJk3NhQFEh1pt+6rP3XEzIcU3d/vrHorXiizvWd89OkBG
	JK8DG/5fi5ZdFuFnfuqYVtpFtoYcAnk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-nvK8wkAxPzyhLuPa2xz6gw-1; Tue, 21 May 2024 23:41:02 -0400
X-MC-Unique: nvK8wkAxPzyhLuPa2xz6gw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b399e49d85so12967623a91.0
        for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 20:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716349261; x=1716954061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S3Gid4+HHyOby23oKkItTJxpdYfB0tmiZc2RtKlOLQ=;
        b=FfBubDmPJhHcHHt4l0KIU/ljkxCAU7tNp0MjsccBk7QpRYvoqpbIX8YqsFH0ufNzZh
         6fDNZog9+D7IpABhwuRhSmkzNdjFSEyiSz9mO5ggOrBR0PVV69iCBDBcyATUNaMVGRX5
         AlhLtGSiPCGq/Agq9wi5g64kbDn2dUo2t2sbiJUiPgVXKy7D6vPDsTaqjeNS8Jihf2bY
         4rV1ZZ+/q9BleZ3SP5orG6E7zVII/6c9YZVbhBxYf9Frm4mIL+wBwM/b4500fivb/iDV
         5E+iBXVHdn16z10ADzEpMCwP6NH0K8AEdFXWtHVv/igdhFqeDe8PWowDhF5AmeQnJTnN
         YNxQ==
X-Gm-Message-State: AOJu0Yx/4Y3MWyShO1IXGLOW7HdSBKzcFV/81CWEIatsRbDOp2GceqRz
	l3Mn/1JXpdNV1MdXucoITbt9mzIvJ9bw5vC5JsPhRhaGZgL5SA1ovwakZESxmoRX4Rm3KaGbb2E
	E2KElBatkPSIzRWbDnMg7lS7SKClD9ikDGYD9g7091A9rCgBHMYVi4XUgeYnyVANlwasyYBNrsM
	BmtkawaIGOXhe+OlB6AcGJvSQ0C5NxqFyf4fdopk421LRAGS8qIM9eIg==
X-Received: by 2002:a17:90a:d608:b0:2b4:32ae:9932 with SMTP id 98e67ed59e1d1-2bd9f489a59mr924139a91.17.1716349260999;
        Tue, 21 May 2024 20:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyGlRV9Te14odh1WiHeDE1DeZgFbjBkjl9hPq8vAGxQEAtuBhP/TUWMA2lvNVxJdKHHffm6JzFMhfzwA8FnWY=
X-Received: by 2002:a17:90a:d608:b0:2b4:32ae:9932 with SMTP id
 98e67ed59e1d1-2bd9f489a59mr924124a91.17.1716349260637; Tue, 21 May 2024
 20:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
 <1716218462-84587-3-git-send-email-steven.sistare@oracle.com>
 <CACGkMEtfjHzdBBwgUWgRHDc5opekvgTuXp-_z4ku6L5cqOeAJA@mail.gmail.com> <b55cccfc-67b0-4f21-9070-127af6fd07a7@oracle.com>
In-Reply-To: <b55cccfc-67b0-4f21-9070-127af6fd07a7@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 May 2024 11:40:49 +0800
Message-ID: <CACGkMEu4WZnqcTPyq566X5aWL-mL1KSR7XWoTKq5AU0mSsB9_A@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] vduse: suspend
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:39=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 5/20/2024 10:30 PM, Jason Wang wrote:
> > On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> Support the suspend operation.  There is little to do, except flush to
> >> guarantee no workers are running when suspend returns.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>   drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
> >>   1 file changed, 24 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_us=
er/vduse_dev.c
> >> index 73c89701fc9d..7dc46f771f12 100644
> >> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> >> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> >> @@ -472,6 +472,18 @@ static void vduse_dev_reset(struct vduse_dev *dev=
)
> >>          up_write(&dev->rwsem);
> >>   }
> >>
> >> +static void vduse_flush_work(struct vduse_dev *dev)
> >> +{
> >> +       flush_work(&dev->inject);
> >> +
> >> +       for (int i =3D 0; i < dev->vq_num; i++) {
> >> +               struct vduse_virtqueue *vq =3D dev->vqs[i];
> >> +
> >> +               flush_work(&vq->inject);
> >> +               flush_work(&vq->kick);
> >> +       }
> >> +}
> >> +
> >>   static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 i=
dx,
> >>                                  u64 desc_area, u64 driver_area,
> >>                                  u64 device_area)
> >> @@ -724,6 +736,17 @@ static int vduse_vdpa_reset(struct vdpa_device *v=
dpa)
> >>          return ret;
> >>   }
> >>
> >> +static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
> >> +{
> >> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >> +
> >> +       down_write(&dev->rwsem);
> >> +       vduse_flush_work(dev);
> >> +       up_write(&dev->rwsem);
> >
> > Can this forbid the new work to be scheduled?
>
> Are you suggesting I return an error below if the dev is suspended?
> I can do that.

I mean the irq injection work can still be scheduled after vduse_vdpa_suspe=
nd().

>
> However, I now suspect this implementation of vduse_vdpa_suspend is not
> complete in other ways, so I withdraw this patch pending future work.
> Thanks for looking at it.

Ok.

Thanks

>
> - Steve
>
> > static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> >                                      struct work_struct *irq_work,
> >                                      int irq_effective_cpu)
> > {
> >          int ret =3D -EINVAL;
> >
> >          down_read(&dev->rwsem);
> >          if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> >                  goto unlock;
> >
> >          ret =3D 0;
> >          if (irq_effective_cpu =3D=3D IRQ_UNBOUND)
> >                  queue_work(vduse_irq_wq, irq_work);
> >          else
> >                  queue_work_on(irq_effective_cpu,
> >                        vduse_irq_bound_wq, irq_work);
> > unlock:
> >          up_read(&dev->rwsem);
> >
> >          return ret;
> > }
> >
> > Thanks
> >
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> >>   {
> >>          struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >> @@ -806,6 +829,7 @@ static const struct vdpa_config_ops vduse_vdpa_con=
fig_ops =3D {
> >>          .set_vq_affinity        =3D vduse_vdpa_set_vq_affinity,
> >>          .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >>          .reset                  =3D vduse_vdpa_reset,
> >> +       .suspend                =3D vduse_vdpa_suspend,
> >>          .set_map                =3D vduse_vdpa_set_map,
> >>          .free                   =3D vduse_vdpa_free,
> >>   };
> >> --
> >> 2.39.3
> >>
> >
>

