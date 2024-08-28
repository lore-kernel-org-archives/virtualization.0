Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D4158DDC
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837622; cv=none; b=FfU/B4oPHFiRVdtr3d+c/Tl/4DK4AexCB7lmf0wlZcp9dquRXrmgnoc7+jgzATX24TASOZ3+BUErAeW6/HrGIHdeClLqR3A3+iZeCGeJSKLHJGb4mA6ZUwlBmCzKl97EnBXiWVUK2pSC+vlBAejMMAbg2164fiiTLIuzaVIhsXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837622; c=relaxed/simple;
	bh=+n9XGtDtxdWnqHxyvsmdxD96dihzfjN3ukpEoNW+9QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swHLg5Rxj4jFhAgIFfWinTvlC3tWTZg77txe+qD6PTG1Bj7wFGws+8CKdn60Ktz2vYHUoMydrOkZ7BMCJBQNIGJZ2pD83toITajNfmK5q4sn251tDmXHRouIFVv6R4qATH6cvU+uzZTy2Oksvq7q45iOjDbLrLARpf4m37WYND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFFc2T1K; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFFc2T1K"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97C7060A6A
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 09:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oyPRoJGAYrwP for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Aug 2024 09:33:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B834A605F5
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B834A605F5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bFFc2T1K
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B834A605F5
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724837618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQ4oNDyVn9J8sj8wpWyPKSrzPW91AjXC5QSksehG4TY=;
	b=bFFc2T1KdHWm1onVuhz0ly/OSnBZRGqkMT6oqxqSqJb8F9qxQsPfsJ0AGmAChO0gAmwaIq
	ZerNJObvR8fLJ0PLOc9CCgt4ALyQqA+EpEh4NaLfayErOyskdcctzRq+y/dEK5M3rhPjbK
	fY5tNQZ/E8np/nCBc7edBGOxD7PGI90=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-cs49eBa6NsmoFNm_ERuQaA-1; Wed, 28 Aug 2024 05:33:36 -0400
X-MC-Unique: cs49eBa6NsmoFNm_ERuQaA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f3e7cbbceaso52866561fa.1
        for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 02:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837615; x=1725442415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ4oNDyVn9J8sj8wpWyPKSrzPW91AjXC5QSksehG4TY=;
        b=YV69vCIZHQj/M3qUzQOD7YfnKMGKRAOw0EasU+gNdZjb3vDMwsTWBwjs6NQkMKDkou
         kZUQrOBW3v7/ZM/rpfB/VB1fklUgSQ1Xqq4VvlOZtUZz91WSF+YfjxV4I3M6rgl1v+8w
         /5Fcm0kGHSCA85inD+aeTD8rPQqbAS4HPK9rxCRUKRNYgDtjohlKNuWwwGaCXAarqujS
         8c+2QyThBQHgu0tN2AZofswCrTYoTO2s6Hw2punHFDHV5MbnG/y2/eTD7hP1sTYiG3j/
         dA4B8xdUphNYfASRYEq0ZYDQAFdpB73WwxQuPamP/2PXJVBVQIxBT8e3X35i66Q7ePcu
         2R7w==
X-Forwarded-Encrypted: i=1; AJvYcCXbE3t9kBR93SpGw+pi+jbJwFuEUFnXblP4XmzR55VEZweNGT5Qm+R039CPK4pz62UqhIGe3izN47FjvZqHFw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzudVMjz44wwtCYBCC/lkX0i9Ml9IDJUuPA/gvTLbiqn0aS9U3W
	WMMgM2b32BNmLqhIfcDjwyx9/soSciSxVv9lOcXKMrwzbYvMgoWRMsPXrDWPudy4edMyHP4V6SC
	Istw2JrefOZ8CvqsN0NF857jDUIwgfReTZmZKIGVGfACNQJhrpHCHPGCGfc0Tj6239BO1OG7mbY
	3dJWgtKkr3FA44Y6Ud/K4PGQcuNoH0nsUxK4onojp7CjH+olZnXqnTbg==
X-Received: by 2002:a2e:a587:0:b0:2ef:23ec:9353 with SMTP id 38308e7fff4ca-2f4f57978c9mr107802351fa.38.1724837614947;
        Wed, 28 Aug 2024 02:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrN5y6fe+G0denXRynGJFeAbblpVQNTVMZ9VRtPCuXw+tfyWMRx1ywC6FP8mAaOPM4fAatzTTgMdjb0uQUv8Y=
X-Received: by 2002:a2e:a587:0:b0:2ef:23ec:9353 with SMTP id
 38308e7fff4ca-2f4f57978c9mr107802151fa.38.1724837614306; Wed, 28 Aug 2024
 02:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-3-lulu@redhat.com>
 <CACGkMEtQaJ+o2WXnWw8iCF=9q7kx+CyVnn_YUgbNEo-ontHRqA@mail.gmail.com>
In-Reply-To: <CACGkMEtQaJ+o2WXnWw8iCF=9q7kx+CyVnn_YUgbNEo-ontHRqA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 28 Aug 2024 17:32:57 +0800
Message-ID: <CACLfguUrEAEena_43od1MCyr+B9SJfx+Wj6XyL4b-yZasrkzrg@mail.gmail.com>
Subject: Re: [RFC 2/7] vhost: Add kthread support in function vhost_worker_queue()
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 at 10:36, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Added back the previously removed function vhost_worker_queue() and
> > renamed it to vhost_worker_queue_khtread(). The new vhost_worker_queue(=
)
> > will select the different mode based on the value of the parameter.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> It looks like a partial revert of some previous commit, please mention
> the commit id in the change log as least.
>
> So did for the following 3 or 4 patches.
>
> Thanks
>
sure, will add this
Thanks
cindy
> > ---
> >  drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++--
> >  drivers/vhost/vhost.h |  1 +
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index da701f6b3f2c..6261c9df468e 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -236,8 +236,8 @@ void vhost_poll_stop(struct vhost_poll *poll)
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_poll_stop);
> >
> > -static void vhost_worker_queue(struct vhost_worker *worker,
> > -                              struct vhost_work *work)
> > +static void vhost_worker_queue_task(struct vhost_worker *worker,
> > +                                   struct vhost_work *work)
> >  {
> >         if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> >                 /* We can only add the work to the list after we're
> > @@ -249,6 +249,32 @@ static void vhost_worker_queue(struct vhost_worker=
 *worker,
> >         }
> >  }
> >
> > +static void vhost_work_queue_kthread(struct vhost_worker *worker,
> > +                                    struct vhost_work *work)
> > +{
> > +       if (!worker)
> > +               return;
> > +
> > +       if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> > +               /* We can only add the work to the list after we're
> > +                * sure it was not in the list.
> > +                * test_and_set_bit() implies a memory barrier.
> > +                */
> > +               llist_add(&work->node, &worker->work_list);
> > +
> > +               wake_up_process(worker->task);
> > +       }
> > +}
> > +
> > +static void vhost_worker_queue(struct vhost_worker *worker,
> > +                              struct vhost_work *work)
> > +{
> > +       if (use_kthread) {
> > +               vhost_work_queue_kthread(worker, work);
> > +       } else {
> > +               vhost_worker_queue_task(worker, work);
> > +       }
> > +}
> >  bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work=
 *work)
> >  {
> >         struct vhost_worker *worker;
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index bb75a292d50c..c7f126fd09e8 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -27,6 +27,7 @@ struct vhost_work {
> >  };
> >
> >  struct vhost_worker {
> > +       struct task_struct      *task;
> >         struct vhost_task       *vtsk;
> >         struct vhost_dev        *dev;
> >         /* Used to serialize device wide flushing with worker swapping.=
 */
> > --
> > 2.45.0
> >
>

