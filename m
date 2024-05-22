Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7C6BB5B
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349200; cv=none; b=C96GWKNZd4z5DOGTIXDLxM10nXoEdgYgkw3McfHnlUaGMOd7IVrGmBSiRGftR5R+fMi/UMa3ZLzTzxxus7pbgPnQ21HE1+fgNKJ+RXiSj+vTbHXrq+pXz2P/FUq+23Qa5oYFKoR2oIYFyWSH8A7TCQffY1GtBSJTR320pJfKmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349200; c=relaxed/simple;
	bh=rsad/eQ6DWGheNrhJpEzrqphxiW82XXKQz+YNf64b9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJPzEEWhrNNW9ov4dRsqVeMT6U0jRbBlR5dVPrejtd2pUPNgUECupPZLZfb+yeIjFc4TdEXrexwqcageWuvX+E0AjfSDEheiIgZzMw0AakKkGlRVWUZ4W30tNmvryOsqATDLQMozvgIYd923CbZEg0b3oQt4lSQ75TgkbeHXlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqdJs16o; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqdJs16o"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 736A740178
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 03:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jGVBNdULkT2S for <virtualization@lists.linux-foundation.org>;
 Wed, 22 May 2024 03:39:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2438E4015C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2438E4015C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gqdJs16o
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2438E4015C
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 03:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716349195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahfb/G0D4ZbkGUdB/34uH7SDNYvGMH6beGMeu1yJFi4=;
	b=gqdJs16oELEWpN82uY28xO1QvpVaT+wgQGSDQBkdMx5LfNahvSGkM3UM85rBXYaQe/Hm9K
	zjZxOPZY5izu4ik3iM9dx7dNG2v3j1Rqy3Son3KyZXSEwf+boK17aRS5y94lYNj4l7bMrm
	WwQa7Goo3cH2VJprF8jPDxAB0m4Qqzs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-19tNWeyDM9eH8j-zCSAKNw-1; Tue, 21 May 2024 23:39:54 -0400
X-MC-Unique: 19tNWeyDM9eH8j-zCSAKNw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b4330e57b6so13289342a91.2
        for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 20:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716349193; x=1716953993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahfb/G0D4ZbkGUdB/34uH7SDNYvGMH6beGMeu1yJFi4=;
        b=Buy696HLLkjVWRN8t90GnjnvZjYU6Y+4OppcEVrL2qXCg1AurK/0cdq4T5whAamopv
         LKFLEP1ZoMyxQquBF8BgnoLt+KkwAMJpMLVemK2YAYAdRojn5RIfs6r6pPae82I0m1So
         mLMkQCSOJzbA/8pE8XZ0XVw4wmv6euXU2WqdGOjGfnCN81/shNV5DCBThkuB0Eg6Xe/S
         kRkzLJkGW0cWuLyNm3F14s+rNUhWK1Y3jbi7Fzkiew5m/rU98FHFSfYbRIxVOCrXyUdW
         jE2sFuQbHwHDpghArmULuQ2x3lHX4I+SQFYb2tTOcu9yy8r3ULPRy0+IYXi9g30rIsY/
         /9RQ==
X-Gm-Message-State: AOJu0YwvvAEcb4j4NnfNOPGOrMsmRT1hXvA3iGzOVJYpICxRmJLFLn9V
	r5JPnHgiyZz1VfhFIOeSbn+vOYWkbovz0xgA53NMm3f0I1QD4+fgmKwkKOoY3NWjv5YPiHn8BDp
	M1WCWoSN7x4cQWCrXqifh2ksMEgn0kAVuHYmafCT7mxqPsYSIgfZhEITd496DrxkrvgAG0rTiQG
	FQU8YiU6sSWWZLnApGHjWtSiGY5uPZPQ3TlI4tcc/Zj6jtltr6GI5hpA==
X-Received: by 2002:a17:90a:2ca1:b0:2b6:c4d7:fc31 with SMTP id 98e67ed59e1d1-2bd9f5bc52emr1191156a91.40.1716349192785;
        Tue, 21 May 2024 20:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8sphTEf2DYNIvycHgNVTAqOYPL463d5Bg/hLWjrc2NJXKaACBiVW4Y6g7W/u0hk1gVqaiG+1JL0LQ1v/2zrA=
X-Received: by 2002:a17:90a:2ca1:b0:2b6:c4d7:fc31 with SMTP id
 98e67ed59e1d1-2bd9f5bc52emr1191138a91.40.1716349192371; Tue, 21 May 2024
 20:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
 <1716218462-84587-4-git-send-email-steven.sistare@oracle.com>
 <CACGkMEur=CoU1GgxNdweu-SfuutSN-a+LaHLkdtoWYJMnE+LOg@mail.gmail.com> <46f91e76-6f88-4f83-8854-10baed4e82c9@oracle.com>
In-Reply-To: <46f91e76-6f88-4f83-8854-10baed4e82c9@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 May 2024 11:39:41 +0800
Message-ID: <CACGkMEtVt+W4jmBxaXAytreXjJUHxmo+zzAw0wsrLw97pJmW-A@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] vdpa_sim: flush workers on suspend
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
> On 5/20/2024 10:32 PM, Jason Wang wrote:
> > On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> Flush to guarantee no workers are running when suspend returns.
> >> Add a lock to enforce ordering between clearing running, flushing,
> >> and posting new work in vdpasim_kick_vq.  It must be a spin lock
> >> because vdpasim_kick_vq may be reached va eventfd_write.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 16 ++++++++++++++--
> >>   drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
> >>   2 files changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/=
vdpa_sim.c
> >> index 8ffea8430f95..67ed49d95bf0 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> @@ -322,7 +322,7 @@ static u16 vdpasim_get_vq_size(struct vdpa_device =
*vdpa, u16 idx)
> >>                  return VDPASIM_QUEUE_MAX;
> >>   }
> >>
> >> -static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> >> +static void vdpasim_do_kick_vq(struct vdpa_device *vdpa, u16 idx)
> >>   {
> >>          struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >>          struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> >> @@ -337,6 +337,15 @@ static void vdpasim_kick_vq(struct vdpa_device *v=
dpa, u16 idx)
> >>                  vdpasim_schedule_work(vdpasim);
> >>   }
> >>
> >> +static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> >> +{
> >> +       struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >> +
> >> +       spin_lock(&vdpasim->kick_lock);
> >> +       vdpasim_do_kick_vq(vdpa, idx);
> >> +       spin_unlock(&vdpasim->kick_lock);
> >> +}
> >> +
> >>   static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
> >>                                struct vdpa_callback *cb)
> >>   {
> >> @@ -520,8 +529,11 @@ static int vdpasim_suspend(struct vdpa_device *vd=
pa)
> >>          struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >>
> >>          mutex_lock(&vdpasim->mutex);
> >> +       spin_lock(&vdpasim->kick_lock);
> >>          vdpasim->running =3D false;
> >> +       spin_unlock(&vdpasim->kick_lock);
> >>          mutex_unlock(&vdpasim->mutex);
> >> +       kthread_flush_work(&vdpasim->work);
> >>
> >>          return 0;
> >>   }
> >> @@ -537,7 +549,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa=
)
> >>          if (vdpasim->pending_kick) {
> >>                  /* Process pending descriptors */
> >>                  for (i =3D 0; i < vdpasim->dev_attr.nvqs; ++i)
> >> -                       vdpasim_kick_vq(vdpa, i);
> >> +                       vdpasim_do_kick_vq(vdpa, i);
> >>
> >>                  vdpasim->pending_kick =3D false;
> >>          }
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/=
vdpa_sim.h
> >> index bb137e479763..5eb6ca9c5ec5 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >> @@ -75,6 +75,7 @@ struct vdpasim {
> >>          bool pending_kick;
> >>          /* spinlock to synchronize iommu table */
> >>          spinlock_t iommu_lock;
> >> +       spinlock_t kick_lock;
> >
> > It looks to me this is not initialized?
>
> Yup, I lost that line while fiddling with different locking schemes.
> Thanks, will fix in V4.
>
> @@ -236,6 +236,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_att=
r
> *dev_attr,
>
>          mutex_init(&vdpasim->mutex);
>          spin_lock_init(&vdpasim->iommu_lock);
> +       spin_lock_init(&vdpasim->kick_lock);
>
> With that fix, does this patch earn your RB?

Yes.

Thanks

>
> - Steve
>
> >>   };
> >>
> >>   struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> >> --
> >> 2.39.3
> >>
> >
>

