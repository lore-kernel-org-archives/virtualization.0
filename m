Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054F261389
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233186; cv=none; b=I5uwCY3lk8ypjDaPQ2aw+yFRhblHP83syK26EM2nxwoqNvsd6pSSLtUPui1wsR8qcvopujQN/X8cTHSo+OPTSMdNAl14eFnwut/S3HeYPnwuTpWabtdqFMejijBkUZ8rzmbOzmiQshFAYRvhlB+OFrkHe2lkH6CTaqpQ1hNqnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233186; c=relaxed/simple;
	bh=uPpZZxMf34MjghpZtlEufZPaYCSS3j9kbC9t6YttDGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R/l3pi3O8YVXRafV4DxgwqiNZtTlipNG4oA5Bl4cvxAWFJcEzVHTu0diwl6WqOhleSUl6mZdwzdQQCBdhzwOIvbKdGAZbmUJaJG+eVN5P7S8FfPrCrkr3EBECF2veMyG6ilQ2smgPXV6l851MKvs7g/NX0E6VzwsKYr5xhaWBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjV+Ba5i; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjV+Ba5i"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EC9840B5E
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 10:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqrhidcLkfuq for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Apr 2025 10:59:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 66A9040B4C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66A9040B4C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NjV+Ba5i
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 66A9040B4C
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745233182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVl17+DIhdQKB5hKQKjqnZV/7Ux7S0MiBzai4RYraAo=;
	b=NjV+Ba5iqJawpKu/hk1N2jAjt3Ds5YdLr5O1K4mZo22afDGC/QHM1M2echYP7xEfIi+kKF
	JWkwUf5mkUKt7toi2t/C5UrwLjMM7ZnyX1nR2hdSB+3vOGwu3BYAwn5mtGVCKZK5fAremd
	3AmSUZToEkCFwyqTi+vrF1NdmdgtRV0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-De1KnnMcN3aMdx-QDcUUbA-1; Mon, 21 Apr 2025 06:59:41 -0400
X-MC-Unique: De1KnnMcN3aMdx-QDcUUbA-1
X-Mimecast-MFC-AGG-ID: De1KnnMcN3aMdx-QDcUUbA_1745233180
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-86d3515b032so442991241.2
        for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745233180; x=1745837980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVl17+DIhdQKB5hKQKjqnZV/7Ux7S0MiBzai4RYraAo=;
        b=QvLWcesqzumvP2+6qE342yP6Oe9iE2rnXy0UMsVx4nWjJh/uVGvX+XPCvDgAPRiFTi
         bpJLCpNJ5GGR037TXsAm8KnoRA7/HR2PXjJPYoGaOv6UFhoRnf/RwaxTvpe/YHnz9zTv
         txvKS9Hu/IyjQPyOEbkZ55CqDn6ss7SIDjIeX8voIpWy36hNRdfkic8nlwq8O3RDKdsU
         RZyTiETge1Ud+rJ7kASVbTcDt1ksGPZ9uM+r5y94RVSLE+DgPRNxYQnPyQ+69wVkzsk0
         l4qD04F7xfPFKN2i3XsK57hRsKliI5cC4uVys87n+OHN8CrqYR6f4mvHNw6oMKKAFTYJ
         33EA==
X-Forwarded-Encrypted: i=1; AJvYcCWgxP4xNXMoVmalbiujhj+V/uAarBJ2UU11m1BP6IfuJJ1+WZBlAOpIeNYb2e97VZR8ZgufDBZ30iS5GXpxkA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyYj9ZvbMpUUBP9JsD47KAu5b0CCbKUacOlFlixLlg+/PwwsS8B
	qvYc/k5lgDIAgxkm1LWuqnIVDyxSx1bhNnjZMJZMnoLV//sBVIYcjPQqY+oi/eBw+VEgIzcIsvC
	zPtraUk09c45TYpLj+lR0Gzg4dlcokNE3vWAjhr/ars9X+DwNwN4H67Uy1sgRZwkJl/m8f6Dslf
	CH7/A=
X-Gm-Gg: ASbGncvvh6DzXCNGAP0RWS+M5IJ7k81zZct2WD5Z3GPk4V+HTzVbFyqnKa5b1f1c/4V
	tz+XUgPIRxtS5NTpgWyTX/hApWjxStUg6KlBkK20BcWrYTZC/sJrONz5lJ4kCprwRbu2yLqv8KS
	AYkM/KhlrQYL0NPDrk0hF8Z7v6qGPe/9Lb3A51hI/dMTFagRW2D7X3GuI3S5haudiQY15ZJKncs
	ScHbqwnvkyAihIgbdkge6Lsh60aQACfBra1mxId8nExzFPmGU8czhdtMIbATdAhs6erpj5LFrLU
	ag==
X-Received: by 2002:a05:6122:1791:b0:526:483:95fd with SMTP id 71dfb90a1353d-529255099femr7267944e0c.10.1745233180618;
        Mon, 21 Apr 2025 03:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+Ga+p67ZBPcoJxP2RVNKC3Q+2U8jBxD/W2ry20b9xTbJ0FUlhUWa12DS5U5nxkuEf6T8ikw==
X-Received: by 2002:a05:6122:1791:b0:526:483:95fd with SMTP id 71dfb90a1353d-529255099femr7267938e0c.10.1745233180298;
        Mon, 21 Apr 2025 03:59:40 -0700 (PDT)
Received: from redhat.com ([45.140.184.92])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922c3a570sm1396339e0c.28.2025.04.21.03.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 03:59:39 -0700 (PDT)
Date: Mon, 21 Apr 2025 06:59:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 2/4] vhost: Reintroduce kthread mode support in vhost
Message-ID: <20250421065847-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-3-lulu@redhat.com>
 <CACGkMEtCxn7rZfvo9_nUwC1TwqJ+5F2XDdU89rz=iyO3U0pCEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtCxn7rZfvo9_nUwC1TwqJ+5F2XDdU89rz=iyO3U0pCEQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3LBW10wgUD5Yl0MdyuVnqpy6z5M0artx9JnVCV1tsCU_1745233180
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Apr 21, 2025 at 11:39:14AM +0800, Jason Wang wrote:
> On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> >
> > This patch reintroduces kthread mode support in vhost,
> > It also introduces struct vhost_worker_ops to abstract
> > worker create/stop/wakeup operations.
> >
> > * Bring back the original vhost_worker() implementation,
> >   and renamed to vhost_run_work_kthread_list().
> >
> > * Add cgroup support for the kthread
> >
> > * Introduce struct vhost_worker_ops:
> >   - Encapsulates create / stop / wake‑up callbacks.
> >   - vhost_worker_create() selects the proper ops according to
> >     inherit_owner.
> >
> > This partially reverts or improves upon:
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 188 ++++++++++++++++++++++++++++++++++++++----
> >  drivers/vhost/vhost.h |  12 +++
> >  2 files changed, 182 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 250dc43f1786..be97028a8baf 100644
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
> > @@ -242,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
> >                  * test_and_set_bit() implies a memory barrier.
> >                  */
> >                 llist_add(&work->node, &worker->work_list);
> > -               vhost_task_wake(worker->vtsk);
> > +               worker->ops->wakeup(worker);
> >         }
> >  }
> >
> > @@ -388,6 +389,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >         __vhost_vq_meta_reset(vq);
> >  }
> >
> > +static int vhost_run_work_kthread_list(void *data)
> > +{
> > +       struct vhost_worker *worker = data;
> > +       struct vhost_work *work, *work_next;
> > +       struct vhost_dev *dev = worker->dev;
> > +       struct llist_node *node;
> > +
> > +       kthread_use_mm(dev->mm);
> > +
> > +       for (;;) {
> > +               /* mb paired w/ kthread_stop */
> > +               set_current_state(TASK_INTERRUPTIBLE);
> > +
> > +               if (kthread_should_stop()) {
> > +                       __set_current_state(TASK_RUNNING);
> > +                       break;
> > +               }
> > +               node = llist_del_all(&worker->work_list);
> > +               if (!node)
> > +                       schedule();
> > +
> > +               node = llist_reverse_order(node);
> > +               /* make sure flag is seen after deletion */
> > +               smp_wmb();
> > +               llist_for_each_entry_safe(work, work_next, node, node) {
> > +                       clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > +                       __set_current_state(TASK_RUNNING);
> > +                       kcov_remote_start_common(worker->kcov_handle);
> > +                       work->fn(work);
> > +                       kcov_remote_stop();
> > +                       cond_resched();
> > +               }
> > +       }
> > +       kthread_unuse_mm(dev->mm);
> > +
> > +       return 0;
> > +}
> > +
> >  static bool vhost_run_work_list(void *data)
> >  {
> >         struct vhost_worker *worker = data;
> > @@ -582,6 +621,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
> > +       s = container_of(work, struct vhost_attach_cgroups_struct, work);
> > +       s->ret = cgroup_attach_task_all(s->owner, current);
> > +}
> > +
> > +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> > +{
> > +       struct vhost_attach_cgroups_struct attach;
> > +       int saved_cnt;
> > +
> > +       attach.owner = current;
> > +
> > +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> > +       vhost_worker_queue(worker, &attach.work);
> > +
> > +       mutex_lock(&worker->mutex);
> > +
> > +       /*
> > +        * Bypass attachment_cnt check in __vhost_worker_flush:
> > +        * Temporarily change it to INT_MAX to bypass the check
> > +        */
> > +       saved_cnt = worker->attachment_cnt;
> > +       worker->attachment_cnt = INT_MAX;
> > +       __vhost_worker_flush(worker);
> > +       worker->attachment_cnt = saved_cnt;
> 
> I wonder if it's easier to re-introduce the flush that was used before
> vhost kthread to avoid the tricks here. We can have flush ops for
> example.
> 
> Thanks

Nah we do not need ops, __vhost_worker_flush is just an internal
function. Refactor it so we can call the part without the check.

-- 
MST

