Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BF19B5A7
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 02:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305068; cv=none; b=P9C8fR5rb/QYeMt22X3U4Yah2/NwNaRBjJMDkyseaXM+w3aFXshXuDQhHTpZP5axOWlp/VRTidNAMSXaIa+8aypvOHK3RYqRRgsLYSxXilJ2NnkwQ1uDUL/suy6wRmWwaX40QXLdI6jAJ8EcClRxMuGMZNqco22Rft/BlVAjWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305068; c=relaxed/simple;
	bh=sHvuZIdbeJegOmhd71Ge7UzOuAL01BQvI6jcWgi4ktk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXTPnCn85nvcQf7I3UlMlPIBHnoM5SJDnrvsaJa0XkWDP4IKpYksg8fqLG9EWfXZ94UQII+g6bFQjDXg1zez2MP/TWUppn/+IvfK26igsPNDUDeiUM9fXbFMx376ZOO2XSyxoG8JqCwMaQ8hzbQfSsNlx+TMB3cbL2jQWewbHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLTpF307; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLTpF307"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C33D401A3
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 02:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLfBmjJ49yUr for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 02:57:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1ED544017A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1ED544017A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLTpF307
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1ED544017A
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 02:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736305064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cnOHVG02IznAe7LlU1y6kbZH/WfJVV7zpJZ7lUn+8I=;
	b=YLTpF3074QV6JkMs+soZrZtkIq3vpQkyR91IpyB4k5b4aLXXtUt0R6LGE/d6fdmSJXv3sz
	9B8lHvoHp7IH3NNX9fad9e4MquoRexYPdnZmB6A6Gv5tObpANPrn/uvIzh9SgJ5QVAI5C4
	DO//Vf6P0CH76iyEVdKSPli2OrOILlk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-rrvYcmCJOaCxpn64GCIYcQ-1; Tue, 07 Jan 2025 21:57:40 -0500
X-MC-Unique: rrvYcmCJOaCxpn64GCIYcQ-1
X-Mimecast-MFC-AGG-ID: rrvYcmCJOaCxpn64GCIYcQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aaf9d0f4e0eso488058966b.3
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Jan 2025 18:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305059; x=1736909859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cnOHVG02IznAe7LlU1y6kbZH/WfJVV7zpJZ7lUn+8I=;
        b=f38nyVIpHLBtnChG+NwjVEOpD+FI4I/5hIdbD6esGygnhvc9jW6R/3ozJmEqU0br3U
         smFqj8s70wrjGQDuOQFqsq2zv+A1/5ubwk7vjUwDaSRL/PP14uM1H2i0kThqEraHXTjy
         /lGDVUYEEht0Oh5GxPpXR1sCeSTyrB0V8terOk79l+7wEV9vBSdJxmVpEYD/O/ceBqcD
         X7KRsbgeKXyCZqb8rAxtRuUT97JwFTMqG0yDGSEXNO17mPApZTKlCtUe/b+6nZi/i8ut
         SDiKvLQonPdwF2tr/sa+SQf54iKpSbbhCBeJcGoz3DrEezfKtK4Wl+N9AyoXBN72Wdiv
         0GAA==
X-Forwarded-Encrypted: i=1; AJvYcCVZeRUWW8ni15LXzGz8lJZQ9ikxHxChcB7ax3aLcmzXTRVF7+FA2VJhRsEdIKuT9H9Xtx38Ib+dPbK9KZPPtA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yyckdom/333r3alWzQUvFe6lpd/X91RbeX6AnlF5KzkOhsuj8BQ
	l67GqFFDrN8R2AdFcQoa3PXGLpufZpHfmQm0WtROHflThZVJB+p5RR7EQbOlArCg7nx+JuY7Y/r
	Zou7OwRkUVlCBFO8dujRdWrkExIT1tlegeoATASHDiBlYeVqZtb45/RKc5wHWcE3JK2BNEfQ0Q2
	JUvilpKyihrQZkKiHEvlc5ajf7xR6FcKcl3Ic43d/tMsIYa2sxmUJ5mA==
X-Gm-Gg: ASbGnctE6tl5+YMH/WYmOkk57mG4Gy0cPL+5csdPMT0fSY+VasdCIpToCv2Mf61OhRp
	39SEzwKdybJslKtFkh8X483ZWkKdyYb3Nb9vComE=
X-Received: by 2002:a17:907:3e02:b0:aaf:ab6f:da49 with SMTP id a640c23a62f3a-ab2abc918cbmr76971166b.39.1736305059678;
        Tue, 07 Jan 2025 18:57:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqCuzRuABNRCXnnbuc+CQ5gQPv1i8FaV+q0mVz5zA94KQZADBZrJH8FkV7qGXqFBThQ4qqRUDX6I8J60CrLyc=
X-Received: by 2002:a17:907:3e02:b0:aaf:ab6f:da49 with SMTP id
 a640c23a62f3a-ab2abc918cbmr76969666b.39.1736305059388; Tue, 07 Jan 2025
 18:57:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-4-lulu@redhat.com>
 <CACGkMEu29fZxNoyLOytScwFqFSFP+o3-ETSgG8u4Kgq_yEt6Gw@mail.gmail.com>
In-Reply-To: <CACGkMEu29fZxNoyLOytScwFqFSFP+o3-ETSgG8u4Kgq_yEt6Gw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 8 Jan 2025 10:57:01 +0800
X-Gm-Features: AbW1kvaikX7u2IKF2_-xCzowI1S4aMKft9ae65Nw2XLy-bJsC-qZ2LImiVUZODk
Message-ID: <CACLfguWQ6q1wmKi5anF=2ofbDzWaTjgY27T9WO_Xtyh3FkVDYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vhost: Add the cgroup related function
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BwCdGBetRZeF-ho_QIUAxU27d2VGe92jPWzWkbqGMvg_1736305060
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Reintroduce the previously removed functions vhost_attach_cgroups_work(=
)
> > and vhost_attach_cgroups() to support kthread mode. Rename
> > vhost_attach_cgroups() to vhost_attach_task_to_cgroups(), and include
> > the implementation of the old function vhost_dev_flush() in this
> > new function.
> >
> > These function was removed in
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 1feba29abf95..812dfd218bc2 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/kthread.h>
> > +#include <linux/cgroup.h>
> >  #include <linux/module.h>
> >  #include <linux/sort.h>
> >  #include <linux/sched/mm.h>
> > @@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
> >
> > +struct vhost_attach_cgroups_struct {
> > +       struct vhost_work work;
> > +       struct task_struct *owner;
> > +       int ret;
> > +};
> > +
> > +static void vhost_attach_cgroups_work(struct vhost_work *work)
> > +{
> > +       struct vhost_attach_cgroups_struct *s;
> > +
> > +       s =3D container_of(work, struct vhost_attach_cgroups_struct, wo=
rk);
> > +       s->ret =3D cgroup_attach_task_all(s->owner, current);
> > +}
> > +
> > +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> > +{
> > +       struct vhost_flush_struct flush;
> > +       struct vhost_attach_cgroups_struct attach;
> > +
> > +       attach.owner =3D current;
> > +
> > +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> > +       vhost_worker_queue(worker, &attach.work);
> > +
> > +       init_completion(&flush.wait_event);
> > +       vhost_work_init(&flush.work, vhost_flush_work);
> > +       vhost_worker_queue(worker, &flush.work);
> > +       wait_for_completion(&flush.wait_event);
> > +
> > +       return attach.ret;
> > +}
>
> This seems to be inconsistent with what you said above which is
>
> """
> > These function was removed in
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> """
>
> As 6e890c5d5021 had:
>
> static int vhost_attach_cgroups(struct vhost_dev *dev)
> {
>         struct vhost_attach_cgroups_struct attach;
>
>         attach.owner =3D current;
>         vhost_work_init(&attach.work, vhost_attach_cgroups_work);
>         vhost_work_queue(dev, &attach.work);
>         vhost_dev_flush(dev);
>         return attach.ret;
> }
>
> It seems current vhost_dev_flush() will still work or the open coding
> of the flush logic needs to be explained.
>
> Thanks
>
the current vhost_dev_flush was changed to support xarray, So it does
not work here , I will add more information here
Thanks
cindy
> > +
> >  /* Caller should have device mutex */
> >  bool vhost_dev_has_owner(struct vhost_dev *dev)
> >  {
> > --
> > 2.45.0
> >
>

