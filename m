Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91B1624FC
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361504; cv=none; b=fM5bk77/kKDwfrx2JbMhVppwOhsT87itF6RxMZ/F0i55LkJdXVC6eIGpWsp2aiFBe24fYgbNqVIl+x4Qh5snOuMHv9MYTIFpyx4DTxNyBqagNmHyEujPBbvFoonq5xQwnpuwPw41iUJkDPxyb998jBkI1K3vd23fcmMXrSV9yuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361504; c=relaxed/simple;
	bh=ROt/kKCekqAhb6NgtR+HvYeVGgTyqwp4jif/BNvDLrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxBzBVEXG9y6La/Dj4dzqImihIHQzXK3Ra7PA4a0ukax1sCrlmQQHVYbZfLdq+PGHYLCAE5/tYeW9VN/dTC5kBrDQ5yUEfQm5ArEIh6JKH6VEpFEgWMpjMIyNfcoMf0obCU0LTcCoMuU0GXsentVfyyeciq99GR2WvDdahX5dkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMvkdCoe; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMvkdCoe"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F0D860881
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mdW27oDAvVZn for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 01:45:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 51B0560831
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51B0560831
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YMvkdCoe
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 51B0560831
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9lqHCtMZZ5R8IZL9yYVIqfG02lS0lhbZnyZNMXSQMM=;
	b=YMvkdCoe3vPJjNYuFw4/0eMNdcAQRgoqulYl34A0Iro/J20HrrF3HIUFep8fb8WXNCw0Ja
	GGCaKy12bT0FHbVb1g27PPlrtTmTwROy5R+gfCSQwPfadS9wsDJ9Ah1+bMyOEan2q3fDMS
	8/0sKUIz3xh6rsJWUuNqq+RDiwJ2mWk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-qz9aTUGcML-6ggyCFPOIZw-1; Sun, 23 Feb 2025 20:44:56 -0500
X-MC-Unique: qz9aTUGcML-6ggyCFPOIZw-1
X-Mimecast-MFC-AGG-ID: qz9aTUGcML-6ggyCFPOIZw_1740361495
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so8357270a91.2
        for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 17:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361495; x=1740966295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9lqHCtMZZ5R8IZL9yYVIqfG02lS0lhbZnyZNMXSQMM=;
        b=IcRBkI9J7ohdG0aQus6LxQF1QcPYe1iqnX19iTb1GEDF0dd68IY5jZ0XH7vp6NAwRp
         49I2CNaiQtzWcv8/vcHWGf48AMbERTt41Az+59HrD8KIAA4zm/JFE8/dQgZHxyapvkee
         XSEFZ9QR0BTom/1eMOYFETR6HeOupyp6nfxGxxy9FpLYZ1gsvMm8zyXCMpR28QZ9z39Q
         eKkWL547rrZWpBwUb+JiKTRJScZPZkzCH0I5MGOcHvti/ndxgnXwO8vYNi99fsKoGYuC
         NlvkyeUE0QeYa1B9/sAAFpt/ximhTvDfMY3ri12rslYenoB6kBjO9oxc4PzeSp1vZ+lT
         k7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUceazzMDWYV+POHWjNOgwLGUqRErO0UXKZdEtPWARiCgAZyXlJ1jw6ac29wCbA1EdobYDJapaXOqqCR1HMRA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywf1UP4xAb7xz+qPS3XTv8X+8VRMZ5lHtq2OOCIJ1qd7sW41Rrz
	paH9b+TejDbsDr1wqnk1+mJAN2xAglhSXd9XE8ayx6/JAekampAWt99B1XfDVAzQhG7YqhPU1lj
	qq0u9rntnUN+mmxs+Sdn23794UbMC3Zmla+Ugjql1pz11f/cw0JhlSi54NSGAJhpsnDj71xmCF+
	Bfwhh2G6yuy1h/hm9Kpdq1mpHQHkTIeVwTRL5l38EcFW4zYT3aYCII5Q==
X-Gm-Gg: ASbGncvFMlcYAnlBTEk0DG2vAGvVGUXgTxLOCMAIs5WNrPll4Ufe0ha3LZyqpq1+cxe
	9QUqkn37EGIXbGr1RjS9G7YiPOgR8DRGBCOdK5okdLzN7uSdjmtq1oefnrmvlcPC+I2o6zw+7Jw
	==
X-Received: by 2002:a17:90b:2d4d:b0:2ee:f550:3848 with SMTP id 98e67ed59e1d1-2fce7699f42mr18043520a91.5.1740361495063;
        Sun, 23 Feb 2025 17:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH03WEjLmvDoT5qvup32c+sEHKZnDhkRywH5c7qogJFIwKUMBOIb7mTmJ6KFgxZ4ezoRXFO9NnnD5eX1vnbi9I=
X-Received: by 2002:a17:90b:2d4d:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-2fce7699f42mr18043491a91.5.1740361494616; Sun, 23 Feb 2025
 17:44:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-5-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:44:42 +0800
X-Gm-Features: AWEUYZmHdhB41i3YJOmI8KaWVoLC4HBbRpKYemT6ZzkL8YZHj56ZsQVVWWGRtl0
Message-ID: <CACGkMEvhiq2FWKZwPmemCMq-tcS=HG1MCs8Yyoj_EdOdPBQBHQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] vhost: introduce worker ops to support multiple
 thread models
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KKLqkoJkgEYe67NBj0XzC33FMNM-2xuMkKhiJLAB9mM_1740361495
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This commit restores the previously removed functions kthread_wakeup and
> kthread_stop, and introduces a new ops structure to handle worker wakeup,
> stop, and creation. The function vhost_worker_create initializes these
> ops pointers based on the inherit_owner value.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Patch looks good but I have some some nits:

It might be better to have a separate patch to introduce the ops then
doing the kthread stuff on top.

> ---
>  drivers/vhost/vhost.c | 115 +++++++++++++++++++++++++++++++++++-------
>  drivers/vhost/vhost.h |  12 +++++
>  2 files changed, 110 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index adbb957c8b5f..d8c0ea118bb1 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *w=
orker,
>                  * test_and_set_bit() implies a memory barrier.
>                  */
>                 llist_add(&work->node, &worker->work_list);
> -               vhost_task_wake(worker->vtsk);
> +               worker->ops->wakeup(worker);
>         }
>  }
>
> @@ -697,7 +697,7 @@ static void vhost_worker_destroy(struct vhost_dev *de=
v,
>
>         WARN_ON(!llist_empty(&worker->work_list));
>         xa_erase(&dev->worker_xa, worker->id);
> -       vhost_task_stop(worker->vtsk);
> +       worker->ops->stop(worker);
>         kfree(worker);
>  }
>
> @@ -720,42 +720,123 @@ static void vhost_workers_free(struct vhost_dev *d=
ev)
>         xa_destroy(&dev->worker_xa);
>  }
>
> +static void vhost_task_wakeup_fn(struct vhost_worker *worker)
> +{
> +       return vhost_task_wake(worker->vtsk);
> +}
> +
> +static void vhost_kthread_wakeup_fn(struct vhost_worker *worker)
> +{
> +       wake_up_process(worker->kthread_task);
> +}
> +
> +static void vhost_task_stop_fn(struct vhost_worker *worker)
> +{
> +       return vhost_task_stop(worker->vtsk);
> +}
> +
> +static void vhost_kthread_stop_fn(struct vhost_worker *worker)
> +{
> +       kthread_stop(worker->kthread_task);
> +}
> +
> +static int vhost_task_worker_create_fn(struct vhost_worker *worker,
> +                                      struct vhost_dev *dev, const char =
*name)
> +{
> +       struct vhost_task *vtsk;
> +       u32 id;
> +       int ret;
> +
> +       vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_kill=
ed,
> +                                worker, name);
> +       if (!vtsk)
> +               return -ENOMEM;
> +
> +       worker->vtsk =3D vtsk;
> +       vhost_task_start(vtsk);
> +       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> +       if (ret < 0) {
> +               vhost_task_stop_fn(worker);
> +               return ret;
> +       }
> +       worker->id =3D id;
> +       return 0;
> +}
> +
> +static int kthread_worker_create_fn(struct vhost_worker *worker,

Let's have a consistent name, e.g vhost_kthread_worker_create.

> +                                   struct vhost_dev *dev, const char *na=
me)
> +{
> +       struct task_struct *task;
> +       u32 id;
> +       int ret;
> +
> +       task =3D kthread_create(vhost_run_work_kthread_list, worker, "%s"=
, name);
> +       if (IS_ERR(task))
> +               return PTR_ERR(task);
> +
> +       worker->kthread_task =3D task;
> +       wake_up_process(task);
> +       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> +       if (ret < 0)
> +               goto stop_worker;
> +
> +       ret =3D vhost_attach_task_to_cgroups(worker);
> +       if (ret)
> +               goto stop_worker;
> +
> +       worker->id =3D id;
> +       return 0;
> +
> +stop_worker:
> +       vhost_kthread_stop_fn(worker);
> +       return ret;
> +}
> +
> +static const struct vhost_worker_ops vhost_task_ops =3D {
> +       .create =3D vhost_task_worker_create_fn,

I think we can get rid of the fn suffix as "fn".

> +       .stop =3D vhost_task_stop_fn,
> +       .wakeup =3D vhost_task_wakeup_fn,
> +};
> +
> +static const struct vhost_worker_ops kthread_ops =3D {
> +       .create =3D kthread_worker_create_fn,
> +       .stop =3D vhost_kthread_stop_fn,
> +       .wakeup =3D vhost_kthread_wakeup_fn,
> +};
> +
>  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  {
>         struct vhost_worker *worker;
> -       struct vhost_task *vtsk;
>         char name[TASK_COMM_LEN];
>         int ret;
> -       u32 id;
> +       const struct vhost_worker_ops *ops =3D
> +               dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
>
>         worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>         if (!worker)
>                 return NULL;
>
>         worker->dev =3D dev;
> +       worker->ops =3D ops;
>         snprintf(name, sizeof(name), "vhost-%d", current->pid);
>
> -       vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_kill=
ed,
> -                                worker, name);
> -       if (!vtsk)
> -               goto free_worker;
> -
>         mutex_init(&worker->mutex);
>         init_llist_head(&worker->work_list);
>         worker->kcov_handle =3D kcov_common_handle();
> -       worker->vtsk =3D vtsk;
> -
> -       vhost_task_start(vtsk);
> +       /*
> +        * If inherit_owner is true we use vhost_tasks to create
> +        * the worker so all settings/limits like cgroups, NPROC,
> +        * scheduler, etc are inherited from the owner. If false,
> +        * we use kthreads and only attach to the same cgroups
> +        * as the owner for compat with older kernels.
> +        */

Is this better to move this to the definition of the inherit_owner?

>
> -       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> +       ret =3D ops->create(worker, dev, name);
>         if (ret < 0)
> -               goto stop_worker;
> -       worker->id =3D id;
> +               goto free_worker;
>
>         return worker;
>
> -stop_worker:
> -       vhost_task_stop(vtsk);
>  free_worker:
>         kfree(worker);
>         return NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index c650c4506c70..029c203147be 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -26,7 +26,18 @@ struct vhost_work {
>         unsigned long           flags;
>  };
>
> +struct vhost_worker;
> +struct vhost_dev;
> +
> +struct vhost_worker_ops {
> +       int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
> +                     const char *name);
> +       void (*stop)(struct vhost_worker *worker);
> +       void (*wakeup)(struct vhost_worker *worker);
> +};
> +
>  struct vhost_worker {
> +       struct task_struct *kthread_task;
>         struct vhost_task       *vtsk;
>         struct vhost_dev        *dev;
>         /* Used to serialize device wide flushing with worker swapping. *=
/
> @@ -36,6 +47,7 @@ struct vhost_worker {
>         u32                     id;
>         int                     attachment_cnt;
>         bool                    killed;
> +       const struct vhost_worker_ops *ops;
>  };
>
>  /* Poll a file (eventfd or socket) */
> --
> 2.45.0
>

Thanks

