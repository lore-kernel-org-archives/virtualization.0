Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382532248A8
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013369; cv=none; b=b1MBHgJXAlUhibfXH6UI+ifkAuYtacEVoMxKBzwa0zXmRFA8rQsxEnpPgunZcthZX91gPjKR+kK/nsl6U5m+C6qUFu9vaRZ6+ncjMj7fkdeLv9IzQQiZ8jILwbJsllomMBSYSGu6hhi0FEpKK5c5UtvbAoqO2ZJ3HDE7YY7NMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013369; c=relaxed/simple;
	bh=AIcU3qGQw0vyLqEK981tZMF9Tv1Bj8Bx9LH29b6ile8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyrVu2+ll8lcOYQ0Z9e4Vj0p8AAzk2PI7BhbcUwQ6/Iuo55Rpy40yXKuuLzYhVkAYvPk+YpBiJhYgKGyK0mCIyR52rBrJid89nOWQugsFo6i4kClOHp9wfq6Pz/F+vXczHVP00ZcQloHWi8wM1hy7Fci3oPQm4c/4ylaUthhrp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDhx3DDZ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDhx3DDZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0BB1406F2
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 08:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rhPwyuMA5Q9I for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Apr 2025 08:09:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E4FB1406EF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4FB1406EF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RDhx3DDZ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4FB1406EF
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 08:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744013365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25iyDw7sQyJUYeKPA+oSXr49j9oc0JtsKm/C1RWwbCM=;
	b=RDhx3DDZutqlVjm5RYjKiw+8eJmbVacuIRVMNYXCd25eWYsasBd/y/J+uasY0qNFvxt7iS
	cNULM1vXMPy45ak6/7Kgmd9p5B/hXTGmeMM9LIC1XGMQ1MSRmyNaqBqJy68TstYE8AhjJR
	HLOE2WDlfrAG2dHFmoeUv8QD81YcF3s=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-D7ZhjXbXPP6LIyeg58LuYg-1; Mon, 07 Apr 2025 04:09:23 -0400
X-MC-Unique: D7ZhjXbXPP6LIyeg58LuYg-1
X-Mimecast-MFC-AGG-ID: D7ZhjXbXPP6LIyeg58LuYg_1744013363
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70267bb7ed8so48279117b3.1
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Apr 2025 01:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744013363; x=1744618163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25iyDw7sQyJUYeKPA+oSXr49j9oc0JtsKm/C1RWwbCM=;
        b=klrP0Ex2w+5W1mSJdDg7iScbT1THKme4wJeqxlbbwBNOAobfDeGLbdQ24GsY26cAFm
         GZ4OQHd/IcK1/Qn+zvGHV56dyPsuFB6Qt8gUwRRSBqwXKuY2dwt/u+/6jLikqnh1rFqz
         Yhd5SByxC8iAujBNX+EVw48p5qg2IX0KLBwZHc73RX77WhAGDObKo9imhVAPHtS6wtRF
         zI6Wn8fkaUFdTb67jap/jvz1FlSgsB11HbHVzLv+C46Xh5MeVOaWR2Qk6WcdMWw10V/Z
         LAiSasBiUsguYiV5VgZIykZHAggEK2J8SIWqcwvf5cOSW4aSwv1c+kk6ePxAo2XY0Uth
         fioA==
X-Forwarded-Encrypted: i=1; AJvYcCUYucB44pwBaDaXjMYJ8a8sGLyQoXPg6se8JLr9uCok8NG+5fkMR3w2AZo4Dri76zSKYg+EB+Gc11RVnTD3QQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyQQN82/Rsy+rtazEikGG0fC8Scv9fI+9GJMMrAvU31o/AXf/mQ
	DqP0sYVUClga8fZg6pvUyS5+39WnTldlRW5uvZ8PZCAle+2bchBNN3nXQrxb4eoZDi1ar5kyWTI
	DEIN16mDwf0vdh+76CSfxjow3VxgU2YyXm3+2mf3LmlXMIfU9UnFvjtHeS417k8SVZonyxB6liu
	4JDzfqky9/MpSN+tRSwC9ToyhRjedGOczpeWp2ZUQEil9sYwNBCV93Pw==
X-Gm-Gg: ASbGncvEwa1iOjKpC+65b7nIhc4EELHe/L5aaaCZ3QNHQ6isMgDDQfwp8nJVXYRcECD
	+YdsDRCJ+D05l1ozwMCR+WIPhhELQbbiu9YzgAnk/dD9op68MuOYkUHuDpFaN5ti95TT8rrc=
X-Received: by 2002:a05:690c:7011:b0:6fb:a4e6:7d52 with SMTP id 00721157ae682-703e1625d65mr224051487b3.35.1744013362959;
        Mon, 07 Apr 2025 01:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb7hTIHt+NuAmVBBXpHYp02iOd0Zq7ltlx2Dmrw3wGkGid4PjxSlXl7aFHxqXXb8FYdr8XlOdtIB0TH3sudVc=
X-Received: by 2002:a05:690c:7011:b0:6fb:a4e6:7d52 with SMTP id
 00721157ae682-703e1625d65mr224051167b3.35.1744013362628; Mon, 07 Apr 2025
 01:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-5-lulu@redhat.com>
 <3hsgi4a2kj5fg65zz7q463ypxbstf2x73avupayyrexjonkheo@utoyktego6as> <CACLfguV5v8Pm9=+0jkDnZFLp-MiyoYT=cFsA2rqeVgNJ2O7zvQ@mail.gmail.com>
In-Reply-To: <CACLfguV5v8Pm9=+0jkDnZFLp-MiyoYT=cFsA2rqeVgNJ2O7zvQ@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 7 Apr 2025 10:09:11 +0200
X-Gm-Features: ATxdqUGcClEaKZlXIh_kQkwLsnROHag_isA2bwLbYX3EtHi3Lr3hxio_8weYAPw
Message-ID: <CAGxU2F5mCHdByvcuj8SOiXCj+MtD5=GM4yEprpeiDU8ZZAVsLw@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QBvZ0MOHtNdbwiTEWkpFsOPJPU8_V2xlvNL6fbP0-YI_1744013363
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Apr 2025 at 05:14, Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
> > >Abstract vhost worker operations (create/stop/wakeup) into an ops
> > >structure to prepare for kthread mode support.
> > >
> > >Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >---
> > > drivers/vhost/vhost.c | 63 ++++++++++++++++++++++++++++++------------=
-
> > > drivers/vhost/vhost.h | 11 ++++++++
> > > 2 files changed, 56 insertions(+), 18 deletions(-)
> > >
> > >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > >index 20571bd6f7bd..c162ad772f8f 100644
> > >--- a/drivers/vhost/vhost.c
> > >+++ b/drivers/vhost/vhost.c
> > >@@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker=
 *worker,
> > >                * test_and_set_bit() implies a memory barrier.
> > >                */
> > >               llist_add(&work->node, &worker->work_list);
> > >-              vhost_task_wake(worker->vtsk);
> > >+              worker->ops->wakeup(worker);
> > >       }
> > > }
> > >
> > >@@ -706,7 +706,7 @@ static void vhost_worker_destroy(struct vhost_dev =
*dev,
> > >
> > >       WARN_ON(!llist_empty(&worker->work_list));
> > >       xa_erase(&dev->worker_xa, worker->id);
> > >-      vhost_task_stop(worker->vtsk);
> > >+      worker->ops->stop(worker);
> > >       kfree(worker);
> > > }
> > >
> > >@@ -729,42 +729,69 @@ static void vhost_workers_free(struct vhost_dev =
*dev)
> > >       xa_destroy(&dev->worker_xa);
> > > }
> > >
> > >+static void vhost_task_wakeup(struct vhost_worker *worker)
> > >+{
> > >+      return vhost_task_wake(worker->vtsk);
> > >+}
> > >+
> > >+static void vhost_task_do_stop(struct vhost_worker *worker)
> > >+{
> > >+      return vhost_task_stop(worker->vtsk);
> > >+}
> > >+
> > >+static int vhost_task_worker_create(struct vhost_worker *worker,
> > >+                                  struct vhost_dev *dev, const char *=
name)
> > >+{
> > >+      struct vhost_task *vtsk;
> > >+      u32 id;
> > >+      int ret;
> > >+
> > >+      vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_ki=
lled,
> > >+                               worker, name);
> > >+      if (IS_ERR(vtsk))
> > >+              return PTR_ERR(vtsk);
> > >+
> > >+      worker->vtsk =3D vtsk;
> > >+      vhost_task_start(vtsk);
> > >+      ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GF=
P_KERNEL);
> > >+      if (ret < 0) {
> > >+              vhost_task_do_stop(worker);
> > >+              return ret;
> > >+      }
> >
> > In the final code, xa_alloc() is duplicated among the functions that
> > create ktrhead or task, might it make sense to leave it out and do it i=
n
> > vhost_worker_create() ?
> >
> > Thanks,
> > Stefano
> >
> Thanks a lot Stefano. I previously tried moving xa_alloc() out, but
> that made the code strange.
> I think keeping xa_alloc() in the create_ops function completes the
> job in  a single function, and maybe it could be used in some other
> functions in the future

Sure, if you tried, and it doesn't add benefits, that's perfectly fine
to ignore this suggestion! ;-)

Thanks,
Stefano

> thanks
> cindy
>
> > >+      worker->id =3D id;
> > >+      return 0;
> > >+}
> > >+
> > >+static const struct vhost_worker_ops vhost_task_ops =3D {
> > >+      .create =3D vhost_task_worker_create,
> > >+      .stop =3D vhost_task_do_stop,
> > >+      .wakeup =3D vhost_task_wakeup,
> > >+};
> > >+
> > > static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev=
)
> > > {
> > >       struct vhost_worker *worker;
> > >-      struct vhost_task *vtsk;
> > >       char name[TASK_COMM_LEN];
> > >       int ret;
> > >-      u32 id;
> > >+      const struct vhost_worker_ops *ops =3D &vhost_task_ops;
> > >
> > >       worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> > >       if (!worker)
> > >               return NULL;
> > >
> > >       worker->dev =3D dev;
> > >+      worker->ops =3D ops;
> > >       snprintf(name, sizeof(name), "vhost-%d", current->pid);
> > >
> > >-      vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_ki=
lled,
> > >-                               worker, name);
> > >-      if (IS_ERR(vtsk))
> > >-              goto free_worker;
> > >-
> > >       mutex_init(&worker->mutex);
> > >       init_llist_head(&worker->work_list);
> > >       worker->kcov_handle =3D kcov_common_handle();
> > >-      worker->vtsk =3D vtsk;
> > >-
> > >-      vhost_task_start(vtsk);
> > >-
> > >-      ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GF=
P_KERNEL);
> > >+      ret =3D ops->create(worker, dev, name);
> > >       if (ret < 0)
> > >-              goto stop_worker;
> > >-      worker->id =3D id;
> > >+              goto free_worker;
> > >
> > >       return worker;
> > >
> > >-stop_worker:
> > >-      vhost_task_stop(vtsk);
> > > free_worker:
> > >       kfree(worker);
> > >       return NULL;
> > >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > >index 19bb94922a0e..98895e299efa 100644
> > >--- a/drivers/vhost/vhost.h
> > >+++ b/drivers/vhost/vhost.h
> > >@@ -26,6 +26,16 @@ struct vhost_work {
> > >       unsigned long           flags;
> > > };
> > >
> > >+struct vhost_worker;
> > >+struct vhost_dev;
> > >+
> > >+struct vhost_worker_ops {
> > >+      int (*create)(struct vhost_worker *worker, struct vhost_dev *de=
v,
> > >+                    const char *name);
> > >+      void (*stop)(struct vhost_worker *worker);
> > >+      void (*wakeup)(struct vhost_worker *worker);
> > >+};
> > >+
> > > struct vhost_worker {
> > >       struct vhost_task       *vtsk;
> > >       struct vhost_dev        *dev;
> > >@@ -36,6 +46,7 @@ struct vhost_worker {
> > >       u32                     id;
> > >       int                     attachment_cnt;
> > >       bool                    killed;
> > >+      const struct vhost_worker_ops *ops;
> > > };
> > >
> > > /* Poll a file (eventfd or socket) */
> > >--
> > >2.45.0
> > >
> >
>

