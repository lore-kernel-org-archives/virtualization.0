Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3917BEBF
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745206773; cv=none; b=t1I+lnAMA9+eqSmJSaUoqsSElvJatoYmeIvPlR/NfnCvttMHuu9RlIhWMQCnr6vd4b1rtktwYo9teeT7i8WLTveLCHaQSfqYqq+tUYQYaoxTYGmIvKR5woBhnL8l4FKZbFHeVu3co73stT2DVxqUyRrXrIvvxH8yHA8Nu3fKOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745206773; c=relaxed/simple;
	bh=6oxFYPmLwuDaxdcExAaX5wiW2PfBY9E69djTpc+P7Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbLpCxFaTvV66bMY/jEYDDJmVMlVgKiYRoYp/ceV5XK0Ilvpa6iTZkmx3RWq9yoPtSskdRhoHh2vlJDOf4+40Zqh77XJSX3jk935T/s4bqZ2m9Cy9PRDMOCzie+E52ChAe5dkeOOwmwmBj7y0OlDwni2Q4NYDaZe0K8dRUE4YFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iss+bv5k; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iss+bv5k"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D02C9406E1
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWO1_dzjoWD4 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Apr 2025 03:39:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2D6F840356
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D6F840356
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Iss+bv5k
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2D6F840356
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745206769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5BnKrW/+iLpSyZ/tIFzeeGvAiccvF/rn1UPOilvOg0=;
	b=Iss+bv5knbtsZaqebY8K9DNz6UZVx5rDGDx1uZZvggHb1nfC9Ttn1tL8hIhrZo7uVjBOFT
	2hwSFtTt7fEQ+VKfBPNxi1+M5+xgp0jXth6sTUv5NtclFUDDgW0Zn1KnMdjtnPttgqOg34
	L3xy8Ac+UynBRLk+hZB6KYuWZqz5C6I=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-zjdex544Nb6mbPUN1ogrRg-1; Sun, 20 Apr 2025 23:39:28 -0400
X-MC-Unique: zjdex544Nb6mbPUN1ogrRg-1
X-Mimecast-MFC-AGG-ID: zjdex544Nb6mbPUN1ogrRg_1745206767
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-896c1845cb9so3159043a12.1
        for <virtualization@lists.linux-foundation.org>; Sun, 20 Apr 2025 20:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745206767; x=1745811567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5BnKrW/+iLpSyZ/tIFzeeGvAiccvF/rn1UPOilvOg0=;
        b=N2vSG95xGFHQ251BisTbiY/RGhF8ZokXOH99m/Zhz9bm6024Isk+WOR/WGKW4SgqKn
         iLF8ksM5IGZH0OUvLNFwsz2dF7DPTjz3mK1OutHqdVHfub5BKwyTp6tmiC33XWYc05ck
         frjQgpeCgrUimv2KfZz1pdvAcdLaOCNWb1hXipvROGbJREWIl8WWJg3sNIBCrFRi/xUT
         T2Is5a27XmjUMo8cbZFVOQMk77tT6sO8TJ5wrVlT4KQ3vZH4rvfGx6MDPinTiHPreHT7
         kwZmyW8WYggngehPlbKPZRo4dBkMqI8JD/4IiZhOHwJEDc1QX725jnoO1MbObqMXcPOQ
         yA/g==
X-Forwarded-Encrypted: i=1; AJvYcCVMYReICK2xFKz8i4qD4mQ6vS8kNK4cHhav5e1qNZ422WzpNtK+KNVOuxCEi07mUh/akFwXu4HiEEmqQjVfEg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxisnAB1zmXzZWeNhZ6DbeHdh25dpGfi4D/U4Spf9gXmEV+i9+Y
	lhPgXIkXJ5lCJGnFap5wUY3x3f5pFkiRUou1XhLXTiGyUMAtTPOxQoYLTqiWKca088ZY4nenjWX
	AkqFFN2paSwOEA2V6H+GEXzkIryymbndcwiIX0Lf3bvNigplkKQuFjK6FqGHEAay5FhpFcaMTOV
	gl/f5jDC4GGLAoQMq1j1Z2rVZ0S2oEeAE9NwCHU6nQCo1sFT67U43qSg==
X-Gm-Gg: ASbGnctRdLwLlmak+awsWUh37RzDe6BUewRdnNqwITQhrNPOREqMqZ4hcT+nthmEjV/
	kJpGxJ6kN/S+eeuv5fGrmAjIDB7Fl1cPN21HCcj/rXbQoJLlojREZS7Rw17E8RlUqisupiQ==
X-Received: by 2002:a17:90b:3d47:b0:2f9:d0cd:3403 with SMTP id 98e67ed59e1d1-3087c37c06emr13653786a91.16.1745206767042;
        Sun, 20 Apr 2025 20:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEIrGzGPwpjGKHQC1F/RF3H9cL/pjElpuRMFvFA29JaCU37Nr1gUW4xh8WpYSPiB50aHILQd2VfjJS8pLlvAM=
X-Received: by 2002:a17:90b:3d47:b0:2f9:d0cd:3403 with SMTP id
 98e67ed59e1d1-3087c37c06emr13653758a91.16.1745206766608; Sun, 20 Apr 2025
 20:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-3-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:39:14 +0800
X-Gm-Features: ATxdqUEsTuLK2yRKipuFBGShT8e-kODU4mIJ9z2UVs1nOfSu0ypFzVw0B46MNuM
Message-ID: <CACGkMEtCxn7rZfvo9_nUwC1TwqJ+5F2XDdU89rz=iyO3U0pCEQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] vhost: Reintroduce kthread mode support in vhost
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hmTyTcLOn2o9G4m0zRP44_0I1saeZ-XUlepWUKP5lbI_1745206767
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> This patch reintroduces kthread mode support in vhost,
> It also introduces struct vhost_worker_ops to abstract
> worker create/stop/wakeup operations.
>
> * Bring back the original vhost_worker() implementation,
>   and renamed to vhost_run_work_kthread_list().
>
> * Add cgroup support for the kthread
>
> * Introduce struct vhost_worker_ops:
>   - Encapsulates create / stop / wake=E2=80=91up callbacks.
>   - vhost_worker_create() selects the proper ops according to
>     inherit_owner.
>
> This partially reverts or improves upon:
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 188 ++++++++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h |  12 +++
>  2 files changed, 182 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 250dc43f1786..be97028a8baf 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> +#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
> @@ -242,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *w=
orker,
>                  * test_and_set_bit() implies a memory barrier.
>                  */
>                 llist_add(&work->node, &worker->work_list);
> -               vhost_task_wake(worker->vtsk);
> +               worker->ops->wakeup(worker);
>         }
>  }
>
> @@ -388,6 +389,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>         __vhost_vq_meta_reset(vq);
>  }
>
> +static int vhost_run_work_kthread_list(void *data)
> +{
> +       struct vhost_worker *worker =3D data;
> +       struct vhost_work *work, *work_next;
> +       struct vhost_dev *dev =3D worker->dev;
> +       struct llist_node *node;
> +
> +       kthread_use_mm(dev->mm);
> +
> +       for (;;) {
> +               /* mb paired w/ kthread_stop */
> +               set_current_state(TASK_INTERRUPTIBLE);
> +
> +               if (kthread_should_stop()) {
> +                       __set_current_state(TASK_RUNNING);
> +                       break;
> +               }
> +               node =3D llist_del_all(&worker->work_list);
> +               if (!node)
> +                       schedule();
> +
> +               node =3D llist_reverse_order(node);
> +               /* make sure flag is seen after deletion */
> +               smp_wmb();
> +               llist_for_each_entry_safe(work, work_next, node, node) {
> +                       clear_bit(VHOST_WORK_QUEUED, &work->flags);
> +                       __set_current_state(TASK_RUNNING);
> +                       kcov_remote_start_common(worker->kcov_handle);
> +                       work->fn(work);
> +                       kcov_remote_stop();
> +                       cond_resched();
> +               }
> +       }
> +       kthread_unuse_mm(dev->mm);
> +
> +       return 0;
> +}
> +
>  static bool vhost_run_work_list(void *data)
>  {
>         struct vhost_worker *worker =3D data;
> @@ -582,6 +621,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>
> +struct vhost_attach_cgroups_struct {
> +       struct vhost_work work;
> +       struct task_struct *owner;
> +       int ret;
> +};
> +
> +static void vhost_attach_cgroups_work(struct vhost_work *work)
> +{
> +       struct vhost_attach_cgroups_struct *s;
> +
> +       s =3D container_of(work, struct vhost_attach_cgroups_struct, work=
);
> +       s->ret =3D cgroup_attach_task_all(s->owner, current);
> +}
> +
> +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> +{
> +       struct vhost_attach_cgroups_struct attach;
> +       int saved_cnt;
> +
> +       attach.owner =3D current;
> +
> +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> +       vhost_worker_queue(worker, &attach.work);
> +
> +       mutex_lock(&worker->mutex);
> +
> +       /*
> +        * Bypass attachment_cnt check in __vhost_worker_flush:
> +        * Temporarily change it to INT_MAX to bypass the check
> +        */
> +       saved_cnt =3D worker->attachment_cnt;
> +       worker->attachment_cnt =3D INT_MAX;
> +       __vhost_worker_flush(worker);
> +       worker->attachment_cnt =3D saved_cnt;

I wonder if it's easier to re-introduce the flush that was used before
vhost kthread to avoid the tricks here. We can have flush ops for
example.

Thanks

