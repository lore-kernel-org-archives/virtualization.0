Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8926B75C
	for <virtualization@lists.linux.dev>; Mon,  1 Sep 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711667; cv=none; b=cgh54+9bvK8+SuXSX3qLLoQdk/rKUMctGjODavQPccbDMOFelePLNdwFzkkgasKSl2neAhfJP3ciaAGQ8VBrX0cGYXWFdANVEFQ+MhaNr9wI9q4I4bnZMohH6G4z735RuEAPV+KtY9lGPMb6a/TbRuLbrl+lXtCJk5Hz6mtbvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711667; c=relaxed/simple;
	bh=rCQntznBOWf2Inr+Q/6BajRWkn60e+i2NmXc+MaYtyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuzIdK76lSEg/D5XEbK96RSiTnRn0one8/PF1gKcptAo8WGkH0wYw5FLNdPTuBwb1aIoibrAYPC2OeEeNwqpT0vsBf1unEUTvuvnf+ZwEbdeJzmn7k/tv3SM2Yyw9fHEA0SGQgqyiKiFTrCpYcKzazmZ8iucLjMDwG4MyEKNKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVC5DeR+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVC5DeR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756711663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSUiWIPMhwHs96b7ABTVTbCkzVoFmMpEwSL1Ss/Y85c=;
	b=EVC5DeR+xRGQwqIEkplYtXVFa78/CW9uNjAd7MUo3iXVstT7jM/rCRCLZyAjHWynUhW4I1
	XmMgDpApMt4v8j+dQ4rEG/oRabynH/qs9nvndrHYbOQ+i/vima2/90KCZ5fQdRkHQKOeeg
	Id+tHCsoDjXUwpIi7v5Fl5BapyF8mlw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-PQu8eYD3NXq1l61plK7iew-1; Mon, 01 Sep 2025 03:27:42 -0400
X-MC-Unique: PQu8eYD3NXq1l61plK7iew-1
X-Mimecast-MFC-AGG-ID: PQu8eYD3NXq1l61plK7iew_1756711661
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47173afd90so5825382a12.1
        for <virtualization@lists.linux.dev>; Mon, 01 Sep 2025 00:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756711661; x=1757316461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSUiWIPMhwHs96b7ABTVTbCkzVoFmMpEwSL1Ss/Y85c=;
        b=vcTAIHn/AY+JzhCYVo7QgIZP1xvQJdPp1DrTW1GoTUCohfldJf0OvwVEQix/9oW7Sw
         DYtTokIuVvQgGWRdWoura3u4sLGJ9crQOR9xWyNZsnPaC4+U11P/giNjh7TjPWUFkrG6
         JBKN6UVRJdVJYzqpfKW/RhGRMPw9oBgYwj2yNOWaReaggEiGpsxQVIXGBebdg/31FiSx
         YyRXXqHr3itImXyIYQa4fjy1rgDFgIBeSebQSUvQxCYMsPy15E0Q9CUfu8q8U79m170O
         GNu3iu4vN5+16Q++KzOpc7kJO3eXuq+p8GZygpVYkeGVBCaYaaYLFm8s61Fpb5i9bfeU
         OOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQxzU5AsMrD4Cycin9ttUl7orPRMkTj/EJ+qmHoL0/yuqdHb3EOvD5FoRwTFiNH73aWUFnarCsZEBrGI3nUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyAnbebIfevc2mUxg3Xj+P+8dZC4vfYx6VJeoOX0rN7ACa01Em
	u/xiLtg4lkSpivwJwm9081grDWX8Xz802DXodPZVLFpm1OliCion8V8cdnOfBPF+ZCCrBmj45T2
	H4vqa+QOkefc9kVj3U7WV5/BlNmvS93PceUdo4m08d2d80iT7Dpl0q+HS6YhLSXs+RYk7RXdjM0
	quwnaDSFvCKrDj/mc6bEu7PDDyv0OTLfYfM/PjhSYfRAY=
X-Gm-Gg: ASbGncsYCJMLD4abc309Y/3ZBigymn1GUUMrYGY2HOv6smfE5N4K8lbSQLyBkROsjHR
	IWpZDjuLxE+ioQXhTV7a+KwZpDdo9NyOPx1hwSFTtpnxpvcOaFLA0vuBlsggN5cFcCd+drH/NIJ
	p84LJZrOmoF+J3+oh1XRY=
X-Received: by 2002:a05:6a20:3d82:b0:243:a3a1:9d96 with SMTP id adf61e73a8af0-243d6dd4f41mr9903702637.6.1756711660940;
        Mon, 01 Sep 2025 00:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJtQGCGbWY0bZdwpI+00f79bdidShp27UJNhnAdSujPUnIi4MoiPXZPPtyTIJ4UkjyEYRD082Miv9aaGATcW4=
X-Received: by 2002:a05:6a20:3d82:b0:243:a3a1:9d96 with SMTP id
 adf61e73a8af0-243d6dd4f41mr9903675637.6.1756711660568; Mon, 01 Sep 2025
 00:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-4-eperezma@redhat.com>
 <CACGkMEvUQeA8bgvMthjSAa4u0o3u7Sq3PDoRXTADa9e=c8G7uw@mail.gmail.com>
In-Reply-To: <CACGkMEvUQeA8bgvMthjSAa4u0o3u7Sq3PDoRXTADa9e=c8G7uw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 1 Sep 2025 09:27:03 +0200
X-Gm-Features: Ac12FXwi-r7BfyYjc6Q_xkFKdMIpOyNdxDR-K3Gu6jhRooSOBB_LbDXz5uoGhI8
Message-ID: <CAJaqyWeNhEFK9Fh53sTNUENQqZJbeX1oiFc4AaSPDXtE0hNYFA@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: return internal vq group struct as map token
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3bT451RWaXF_g_bAGiCVZQudMcctVgcapWduCxOsrGo_1756711661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:26=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Return the internal struct that represents the vq group as virtqueue ma=
p
> > token, instead of the device.  This allows the map functions to access
> > the information per group.
> >
> > At this moment all the virtqueues share the same vq group, that only
> > can point to ASID 0.  This change prepares the infrastructure for actua=
l
> > per-group address space handling
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v3:
> > * Make the vq groups a dynamic array to support an arbitrary number of
> >   them.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++------
> >  include/linux/virtio.h             |  6 ++--
> >  2 files changed, 46 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 0f4e36dd167e..cdb3dc2b5e3f 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/uio.h>
> >  #include <linux/vdpa.h>
> >  #include <linux/nospec.h>
> > +#include <linux/virtio.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sched/mm.h>
> >  #include <uapi/linux/vduse.h>
> > @@ -84,6 +85,10 @@ struct vduse_umem {
> >         struct mm_struct *mm;
> >  };
> >
> > +struct vduse_vq_group_int {
> > +       struct vduse_dev *dev;
> > +};
>
> Nit: I don't get the meaning of the "int" suffix.
>

It means "internal", but I don't think it is a great name so I'm ok
with changing it.

