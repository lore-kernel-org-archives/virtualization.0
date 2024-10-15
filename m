Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D31D12FE
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983073; cv=none; b=UkvFRaIYu3pHandmiOTVmCThPLK3y3YGemd0xOFxubh1pgUpy/uu1L8Pe1mO1bXPwx7Wba4qkAlLOr4SWbA+mrMbneljUrrWMXR5ToB3kYCQuzzUXx4mwTQzgXtHPLy/1YgwTV5j3Gz/e+g/cWrDKWJWxiuOWvma2xhU2EPZRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983073; c=relaxed/simple;
	bh=7fMVbDZrXTcbhw9XihCX+Md2qAZQzyvDBBbiJB2EPk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8OtyBmf3zCkGm74qAIXhYmbN5SHXNFAmmbwnfrlimXmy6n8jXB8SfYc/LG6EpcnpKVcear279bgMIOypOD/Ne9To3IgRFt3s1EAKexM1cGRDMuVq/RUPoePiy06A7VNqJF4pglFP6190ORgu5Mz6B3CHLXPSAkFtNF2rXh/GBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daL2OFJY; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daL2OFJY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ECC960880
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 09:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9hztiOq6Wem for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 09:04:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 25C886087A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25C886087A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=daL2OFJY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 25C886087A
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728983068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPZWp2QENGOV9PvuYQ/gAGVXqsAfZLS4ikjAsuIINLk=;
	b=daL2OFJY95Isl65nNTE6AvqEh+3S0qlQX/hQ3tttq/zJRv2LE3gLhawAB1s9E8vuxBi0uq
	skNa8DeIqYqB8SAKoEUHWHVZZIutjd5rs5QbiFpDA+I/+zg5kBGSQL1y2QjSQmQbF/K0qk
	wPTEP4TJC0TvOEhR01ORn2OtIRE/DIA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-R6pBb6BHMYi1ZUEcXL8aOg-1; Tue, 15 Oct 2024 05:04:27 -0400
X-MC-Unique: R6pBb6BHMYi1ZUEcXL8aOg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a0c259715so154419166b.0
        for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 02:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983066; x=1729587866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPZWp2QENGOV9PvuYQ/gAGVXqsAfZLS4ikjAsuIINLk=;
        b=spV2A1+7i5QDCgLqxioQMdhv4rLrOLlhRzM+Al7QN4575CKNKeSVE8ii8d0qahP3lv
         QaqwjVHXRs25NrDHi+qU1t5mujjLcmgfND/RUbUcsZv1hiizfvW5xM6nExld1xiuBIKi
         8EJ5dXx7DEGEHUzUAdPQguSkty5c/MZLBKR/p0eTn+IOh8Zvvf8EhkMjhAkgnDargHXF
         81fthWKlHJVnrUEbJCUwm6Jsx/r8DGT3zuak1A8l059tln1ycJHX7zce/Lyutly8GN2n
         0o4Q2mCSiSPHHVjfryG5AgDWIFSxRxpFHmhKDQ0ujTeWQcllYGe5179Z826p8Vk90Nlz
         Eu2A==
X-Forwarded-Encrypted: i=1; AJvYcCXff2aQexgn5Dpz+5VB/dswCifpfjXLzQcco89vzaTIhzRcvVlT1WQj3xPN0hifCb/iApJedEQPS/+70IPbng==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx3RANjuy5o2L5UEFpQhzJ9nyocNUSaJ5z9/emmIUpifH5r8P5y
	TGiUUwiifOMzzfbHDSPOg24FxGu8/WwYwyDVQZVGx5JREYOYGadpVzCqW8gC/rXxp9KNKCE+xrn
	hBlx2ad3jiL9ncFCvmTYPTOi/TrURcTmP5s5LhAI/PLnSIodIcfG6T7US30n2+21hZXfAGMDLlr
	Fp32lBcAqEM/NHgxr0NqMDiAiXDNw3kgzqUEBhZY7YOyPdiMuCzrRyKQ==
X-Received: by 2002:a17:907:d24:b0:a9a:6ab:c93b with SMTP id a640c23a62f3a-a9a06abcce7mr616542766b.62.1728983065818;
        Tue, 15 Oct 2024 02:04:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWjbz9r9M+/Ac/E+vPMTxas+1oH2xSN088iR867d/PS9LzToNr3uZfixPxdwXnafTcGC+TKwWE1WtUmHZt0Lo=
X-Received: by 2002:a17:907:d24:b0:a9a:6ab:c93b with SMTP id
 a640c23a62f3a-a9a06abcce7mr616539866b.62.1728983065368; Tue, 15 Oct 2024
 02:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-5-lulu@redhat.com>
 <dd03e6d2-54e6-487c-8aa8-8a760213a42a@oracle.com>
In-Reply-To: <dd03e6d2-54e6-487c-8aa8-8a760213a42a@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 17:03:47 +0800
Message-ID: <CACLfguX-pHYpwQZA3QjT+P5Ev-7bPFede=7sBZJzZkE-QsPKxg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] vhost: Add the vhost_worker to support kthread
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 at 06:56, Mike Christie <michael.christie@oracle.com> w=
rote:
>
> On 10/3/24 8:58 PM, Cindy Lu wrote:
> > Add back the previously removed vhost_worker function to support the kt=
hread
> > and rename it vhost_run_work_kthread_list.
> >
> > The old function vhost_worker was change to support task in
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > change to xarray in
> > commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray"=
)
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fed6671c1ffb..349499139f4f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -418,6 +418,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >       __vhost_vq_meta_reset(vq);
> >  }
> >
> > +static int vhost_run_work_kthread_list(void *data)
> > +{
> > +     struct vhost_worker *worker =3D data;
> > +     struct vhost_work *work, *work_next;
> > +     struct vhost_dev *dev =3D worker->dev;
> > +     struct llist_node *node;
> > +
> > +     kthread_use_mm(dev->mm);
> > +
> > +     for (;;) {
> > +             /* mb paired w/ kthread_stop */
> > +             set_current_state(TASK_INTERRUPTIBLE);
> > +
> > +             if (kthread_should_stop()) {
> > +                     __set_current_state(TASK_RUNNING);
> > +                     break;
> > +             }
> > +             node =3D llist_del_all(&worker->work_list);
> > +             if (!node)
> > +                     schedule();
> > +
> > +             node =3D llist_reverse_order(node);
> > +             /* make sure flag is seen after deletion */
> > +             smp_wmb();
> > +             llist_for_each_entry_safe(work, work_next, node, node) {
> > +                     clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > +                     __set_current_state(TASK_RUNNING);
> > +                     kcov_remote_start_common(worker->kcov_handle);
> > +                     work->fn(work);
> > +                     kcov_remote_stop();
> > +                     cond_resched();
> > +             }
> > +     }
> > +     kthread_unuse_mm(dev->mm);
> > +
> > +     return 0;
> > +}
> I think there is a lot of unneeded code duplication where in the function=
s
> you are adding there's only 1-3 lines different. To fix this I think we
> could:
>
Thank you mike=EF=BC=8C I will try this and provide a new version
thanks
cindy
>
> 1. Go really invasive and modify copy_process and its helpers so they tak=
e
> a task_struct instead of using "current". We can then just pass in "curre=
nt"
> or kthreadd. We can then use most of the existing vhost code. We just
> need a per vhost_worker check/field for the mm and cgroup use like:
>
> vhost_task_fn():
> {
> ...
>         /* The mm would be passed in during creation for the kthread case=
 */
>         if (vtsk->mm)
>                 kthread_use_mm(vtsk->mm);
>
> Or
>
> 2. Go hacky and in the vhost code, when we get a VHOST_SET_OWNER call cre=
ate
> a tmp kthread. The tmp kthread would then call the existing vhost_worker_=
create
> function. The resulting vhost_task would inherit the kthreadd settings li=
ke we
> want. We then just need a per vhost_worker check/field for the mm and cgr=
oup use
> like above.
>
> Or
>
> 3. There doesn't seem to be a lot of differences in the functions you are
> adding. In the function above the only differences are the mm calls and k=
thread
> should stop. In the destroy functions it's kthread_stop. In the queue fun=
ction its
> wake_up_process. In create its kthread_create, stop and the cgroup functi=
ons.
>
> I think we could add just some callouts on the vhost_task or vhost_worker=
 for stop,
> wakeup and use mm. For create we would do something like
>
> vhost_worker_create()
> ....
>         worker =3D kzalloc();
>
>         if (inherit from caller) {
>                 worker->stop =3D vhost_task_stop;
>                 worker->wakeup =3D vhost_task_wakeup;
>
>                 worker->vtsk =3D vhost_task_create();
>         } else {
>                 worker->stop =3D vhost_kthread_stop;
>                 worker->wakeup =3D vhost_kthread_wakeup;
>
>                 worker->tsk =3D kthread->create();
>                 vhost_kthread_setup_cgroups();
>         }
> ...
> }
>
> vhost_worker_destroy()
> {
>         if (!worker)
>                 return;
>
>         WARN_ON(!llist_empty(&worker->work_list));
>         xa_erase(&dev->worker_xa, worker->id);
>         worker->stop(worker);
>         kfree(worker);
> }
>
>

