Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66A2AEE0
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735513; cv=none; b=Rz3cVkvM9Pz9hN30Hx0jo4+/YTegv2wzZCc2J6MD6FHV6QqhQH8GAbZJFtD082VcnWeCBOrP/EHX+nSYcN083wdCxGqjM6eahDxh31DYBOMy5+HHJZu7RtlEJMsmyslNznMwXu4nMGTPvnT4MPB4R26ruSlKLkuf/n+gqw4Ca5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735513; c=relaxed/simple;
	bh=27Y0gK4L2Ir0MQmlP0rp2H+j3B9I6vSN5t7U4PlYxKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpjVB8mOi71Xl9JCaO1oUoyaEAitDhi2Unt76E20eqGfx+6E/x69JuXh48YeXXiVomoPBjpbXzccnQNLM8URxGTGZJUzgR7M8TFzLKwx3X86nD06T8LadGhHVhOOQt6z9UGDLvklKlF508xlLDpFasSbvY3UMMA5dz6k876L7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goPjVVfW; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goPjVVfW"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E063881297
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 02:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YW0BKcPPzsoV for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jan 2025 02:31:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E888A81298
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E888A81298
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=goPjVVfW
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E888A81298
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 02:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GD5D3g1MYQ6YHvDRRBZ1hnRcR9rg7HTZmwugqswcwaE=;
	b=goPjVVfWJyjymgBawWMx1y9LNPG4s9u8NUQfkJRxAT7pCQvJbtMcCEgsGkhYP8nnNz0Ten
	cRY7YrDTyJLdxthXeqXvCkHFuEtp60aQk+WdJlWLskWbZtPzj3vhyGt4D0RNWH3PYHKyRr
	508TlGeUp3GsHeI3LmrsfL6WZFA9X6o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-6tprnMDVMFyQabqg2hFA4g-1; Sun, 12 Jan 2025 21:31:47 -0500
X-MC-Unique: 6tprnMDVMFyQabqg2hFA4g-1
X-Mimecast-MFC-AGG-ID: 6tprnMDVMFyQabqg2hFA4g
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa622312962so364405866b.2
        for <virtualization@lists.linux-foundation.org>; Sun, 12 Jan 2025 18:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735506; x=1737340306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GD5D3g1MYQ6YHvDRRBZ1hnRcR9rg7HTZmwugqswcwaE=;
        b=PmbMvqBMgZfosxNSKPa5JmlIaLZaCy0wWJF3ca8GE9zgrwpQeR18J1g1/UOSlMVoZQ
         in9+H+v1tkJIu6+cxwmj/2dRDQs0b4ex6Se692pgnNtdEKZ/s7KbgUbzs3bnhGJ9a4j4
         OpcCG8EFiTkCNZRsdomnoa1v11FG9a9COvZj9FfclhrWIdBc30P8R2MYJ00pMCOaT+8d
         7Jyr/GSYum56zPJdaWdZK3cgddcASe1lYzymUYXLYIEdqth0PAsLrGbG0bNCNV/ekEBt
         q1X97Zp/TZKIeE/ObNxPRBQJrB8SVhOmOJP3tIN8HnxTrHrD7pVvzmhn6v5310h5b2Rn
         ZGSg==
X-Forwarded-Encrypted: i=1; AJvYcCXPF5mONcXy3F4uqS9pyT4uZg5ycrT+drBHyo4WIzB7Ln5y3w2x2s7nOpwcghia770y25poIbq6vRNHVpnwdA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyTHwchDH3cN41sn8kkn714ShyUom/w0PoS6qBtFBQPwSlq1U9+
	qNOQyzg0t6+4gACqdmr/Owj7H+5ACSNOG06hLRATFlwLTq+2yyBRUYWryUTEXOPZKVIKp08irvK
	pQXq/RKu5v4A9s9ygt1G9kth+Vz5EOUnx9uYuXxUjI1aevTNbk+35AxwYlhQ5Lyd4ww2NAcuexe
	89o/6+3v59+kVEfoCuNeCIvfan9dcD8WWC29VheVOyr1B+uyFCyoFhug==
X-Gm-Gg: ASbGncuMAY/S2dhzbM//in3Dty3YuvkunjGdi1YG9vfWUicljLDOwbHy9ZEGMkqN2Mq
	7fdz7jiJgPtJF0ssoDm26o9bXRKRRSWYa0HNq3Rg=
X-Received: by 2002:a17:906:6a22:b0:aa6:8ed8:a82d with SMTP id a640c23a62f3a-ab2ab5f52a3mr1560753566b.31.1736735506065;
        Sun, 12 Jan 2025 18:31:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV8pe7eInXvsrS3jw6Yxy6UMQZiOAUszXpoPhqezK3o9e/+/dYUX9B+9RVhWonAOcoDQcsOB/6rNtY6pFuulA=
X-Received: by 2002:a17:906:6a22:b0:aa6:8ed8:a82d with SMTP id
 a640c23a62f3a-ab2ab5f52a3mr1560752266b.31.1736735505767; Sun, 12 Jan 2025
 18:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-5-lulu@redhat.com>
 <foiitmbzkjjjbnz46sfy627jsfwkvya42zujxiigykzj2dluya@iumroiukvfld>
In-Reply-To: <foiitmbzkjjjbnz46sfy627jsfwkvya42zujxiigykzj2dluya@iumroiukvfld>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 13 Jan 2025 10:31:08 +0800
X-Gm-Features: AbW1kvbbiB_Bh_EjsWzsPUgcpcsdsFwxWoDelDB6yBhgsYzI5bQ7RGQ1GHdfzfc
Message-ID: <CACLfguX9KrGPwhefy9LJZ9h5Qv1msFcO7_naBDi4DqR2V3wgKg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] vhost: Add worker related functions to support kthread
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MOLGT1NdipN5dHTVFOcIouHCrKDn_ZRbW0ARQTbpjio_1736735506
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 10:35=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, Dec 30, 2024 at 08:43:51PM +0800, Cindy Lu wrote:
> >Restore the previously removed functions kthread_wakeup and
> >kthread_stop, and add two new function pointers to wake up and stop
> >the workers. The function vhost_worker_create will initialize these
> >pointers based on the value of inherit_owner.
> >
> >The functions vhost_worker_queue() and vhost_worker_destroy() will
> >use the function pointer in vhost_worker, which is initialized
> >according to the inherit_owner value.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 84 ++++++++++++++++++++++++++++++++++---------
> > drivers/vhost/vhost.h |  3 ++
> > 2 files changed, 71 insertions(+), 16 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 812dfd218bc2..ff17c42e2d1a 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
>
> [...]
>
> >@@ -736,27 +758,57 @@ static struct vhost_worker *vhost_worker_create(st=
ruct vhost_dev *dev)
> >       worker->dev =3D dev;
> >       snprintf(name, sizeof(name), "vhost-%d", current->pid);
> >
> >-      vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_kill=
ed,
> >-                               worker, name);
> >-      if (!vtsk)
> >-              goto free_worker;
> >-
> >       mutex_init(&worker->mutex);
> >       init_llist_head(&worker->work_list);
> >       worker->kcov_handle =3D kcov_common_handle();
> >-      worker->vtsk =3D vtsk;
> >+    /*
> >+     * If inherit_owner is true we use vhost_tasks to create
> >+     * the worker so all settings/limits like cgroups, NPROC,
> >+     * scheduler, etc are inherited from the owner.
> >+     * If false,we use kthreads and only attach to the same
> >+     * cgroups as the owner for compat with older kernels.
> >+     */
>
> This comment block seems to have incorrect indentation, perhaps you need
> to replace the spaces with at least one tab.
>
sure will do
Thanks
cindy
> >+      if (dev->inherit_owner) {
> >+              vtsk =3D vhost_task_create(vhost_run_work_list,
> >+                                       vhost_worker_killed, worker, nam=
e);
> >+              if (!vtsk)
> >+                      goto free_worker;
> >+
> >+              worker->vtsk =3D vtsk;
> >+              worker->worker_wakeup =3D vhost_task_wakeup_fn;
> >+              worker->worker_stop =3D vhost_task_stop_fn;
> >+
> >+              vhost_task_start(vtsk);
> >+              ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_3=
2b,
> >+                             GFP_KERNEL);
> >+              if (ret < 0)
> >+                      goto stop_worker;
> >+      } else {
> >+              task =3D kthread_create(vhost_run_work_kthread_list, work=
er,
> >+                                    "vhost-%d", current->pid);
> >+              if (IS_ERR(task)) {
> >+                      ret =3D PTR_ERR(task);
> >+                      goto free_worker;
> >+              }
> >+              worker->kthread_task =3D task;
> >+              worker->worker_wakeup =3D vhost_kthread_wakeup_fn;
> >+              worker->worker_stop =3D vhost_kthread_stop_fn;
> >
> >-      vhost_task_start(vtsk);
> >+              wake_up_process(task);
> >+              ret =3D xa_alloc(&dev->worker_xa, &id, worker,
> >xa_limit_32b,
> >+                             GFP_KERNEL);
> >+              if (ret < 0)
> >+                      goto stop_worker;
> >
> >-      ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> >-      if (ret < 0)
> >-              goto stop_worker;
> >-      worker->id =3D id;
> >+              ret =3D vhost_attach_task_to_cgroups(worker);
> >+              if (ret)
> >+                      goto stop_worker;
> >+      }
> >
> >+      worker->id =3D id;
> >       return worker;
> >-
> > stop_worker:
> >-      vhost_task_stop(vtsk);
> >+      worker->worker_stop(worker);
> > free_worker:
> >       kfree(worker);
> >       return NULL;
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index c650c4506c70..63b1da08a2b0 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -27,6 +27,7 @@ struct vhost_work {
> > };
> >
> > struct vhost_worker {
> >+      struct task_struct *kthread_task;
> >       struct vhost_task       *vtsk;
> >       struct vhost_dev        *dev;
> >       /* Used to serialize device wide flushing with worker swapping. *=
/
> >@@ -36,6 +37,8 @@ struct vhost_worker {
> >       u32                     id;
> >       int                     attachment_cnt;
> >       bool                    killed;
> >+      void (*worker_wakeup)(struct vhost_worker *worker);
> >+      void (*worker_stop)(struct vhost_worker *worker);
> > };
> >
> > /* Poll a file (eventfd or socket) */
> >--
> >2.45.0
> >
>

