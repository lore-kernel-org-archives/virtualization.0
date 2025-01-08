Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A441A256B
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305222; cv=none; b=c1e3CbmAQpXgsa/AnKdHkJ11KouCQ5s3jkRH+3tHu+vBq54nGgQdKR2MvtkMUarMZkIMBfC4IhsvGUcIYZ9naG0/B9GrpERnH0iiCTbSa9ziHZkYNp1qxM7Q6cZBKLHlkZbFeroAvSuJXllQGCYY4XoYcbg+O+3aNKpXXle2HgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305222; c=relaxed/simple;
	bh=Dciqjvlx2H/R6YN5xtBjgCX46H21JuTpbwkAJGiEdAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYP5lYffIYHxh8Z/C1yBYQNUHmPHhydjf4XkmuIgd/JfOdRJNEQ2sUtrIYIIJ5qiSlqumvWLiii6NLVEB1rtzBdS5v0wRB30Ab2rvMLfFh+1dOYGlNzcsIcq+zmH76vZ0F+1P+KGkW6wDZvv7z86iKyKr5we4SjAWbZsYnxYR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDD6O45W; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDD6O45W"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2AF6F4046C
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 03:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A2jqVyQqWD1E for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 03:00:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 26DC44044E
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26DC44044E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDD6O45W
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26DC44044E
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 03:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736305216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V79OcuD49cIJZohEbmJe69JuNmGmHHtDUlNMPt0oqHY=;
	b=SDD6O45WSgsYvubW04ZNXJOuq9XtfBCojBn/E1mX2og6UFhCeYkm1HyAC8pVyGsaW8fbGC
	LhRv9sowh/bjeIwZI81f4DUHzymBzwHIu8SnhwNc5nvSWBu2/JKE3EnMgf7dRaAtwPyA0B
	1mVt130Y+Cxg7MY8injVhDDV7xJ+tsA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Gccn6AFxNFKhY5MFaPP44w-1; Tue, 07 Jan 2025 22:00:15 -0500
X-MC-Unique: Gccn6AFxNFKhY5MFaPP44w-1
X-Mimecast-MFC-AGG-ID: Gccn6AFxNFKhY5MFaPP44w
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa6704ffcaeso636814166b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Jan 2025 19:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305214; x=1736910014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V79OcuD49cIJZohEbmJe69JuNmGmHHtDUlNMPt0oqHY=;
        b=lFqx0MSywSR4uM/gey7Dt/OJFO2UzrvN8q+oI4EjB5x+iNgAKylLrTNl4m4H+DMxVr
         u8lPpKDle5ND/eA52joUmih7QVssX2Dep+RLwBLEsZHUHPD2AGvNL9ADxNfbwXEdjCf5
         dCQUv9Ept9OETEb07wz5K2XtLJDYoVwIvJzED/8fRfYc4YPpC+6ce3XOsmpWW/RmsBeh
         C7ESNjsYeZhh4ZFZl4YuqhyKndPZIEiEMdDB4Ou+uCnixU94iMRa2Tu2ajFhZiEodPoW
         25Q1M46y4ZmwVMrt4ACy5Y///H4j21HpiAb5FPOWYohOMdS24uGyFd6uGE/FBfz36JJi
         G5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUxws3RKyG4G47dX0u15tSWcuNcNQ7em1ofs8ItGSprWfjPmvSiwpZ2+VqEEFbQQOCtQBy7b9tkvRsQRdJyHw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw0jsPUt13nVVdzdRbQXoYMjyYQOXfc8OqSdrrWLtEKiD7Z/yfP
	/flEvbwWwqqBGr2VDzTDPCv3H9yEgS2ska+ORXsmz7MQVS5YYnWA66h9jxYrwBVFDC/NWFO2Mna
	XMDyss1PBhOKyex+hG5ypmFpxS/KoBIIiT0e7ooxrJMMrx8C+7iaMQfpOK2w/6RAf2D/bT8LLDp
	pxfVgIm6732Xyh/Op8NljcStIk0shVlra9jWN9UzdlZ9zC6uysr75jjA==
X-Gm-Gg: ASbGncvz2XHWrgW7XrI99vFoAsqVcI6fIAfPw4Ojcmc160XfafdGquMzK3gpNlb6Z/c
	luAZXK6jAy686Kfh9eH1FnnepDXVaE8syV3lXlws=
X-Received: by 2002:a17:907:3da8:b0:aae:ce4c:ca40 with SMTP id a640c23a62f3a-ab2ab740698mr70740866b.32.1736305214140;
        Tue, 07 Jan 2025 19:00:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgP52S4qE/N+6vyL1S81I9hJPIsqy66nodr1Pp2Y+yokSkk63j2GOn+8boM7mJWTzOpreQfQRZbVEpr6TCCdE=
X-Received: by 2002:a17:907:3da8:b0:aae:ce4c:ca40 with SMTP id
 a640c23a62f3a-ab2ab740698mr70739566b.32.1736305213805; Tue, 07 Jan 2025
 19:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-3-lulu@redhat.com>
 <CACGkMEuA_O5bgwLNz47sWJTQGqqOvq==_vNnhqrH-eGtbg-Fuw@mail.gmail.com>
In-Reply-To: <CACGkMEuA_O5bgwLNz47sWJTQGqqOvq==_vNnhqrH-eGtbg-Fuw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 8 Jan 2025 10:59:37 +0800
X-Gm-Features: AbW1kvbzKsocE9MoY2y3BpGkLVoAP0F5ST9KJOD7MBCiRYxaH_6OoiW7WzjZjUo
Message-ID: <CACLfguVFHV2HZoAzOfpSvYZL0a3ehGqnJiwnnZqjctDGYAxDPA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] vhost: Add the vhost_worker to support kthread
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OUtWxUYnKv1SvJ5HC92kOvCfw-LQob3qQk-C4YYHufI_1736305214
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:19=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the previously removed function vhost_worker() back to support the
> > kthread and rename it to vhost_run_work_kthread_list.
> >
> > The old function vhost_worker() was changed to support tasks in
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > and to support multiple workers per device using xarray in
> > commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray"=
).
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> I think we need to tweak the title as this patch just brings back the
> kthread worker?
>
> Other than that,
>
sure will do
Thanks
cindy
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
> > ---
> >  drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index eaddbd39c29b..1feba29abf95 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >         __vhost_vq_meta_reset(vq);
> >  }
> >
> > +static int vhost_run_work_kthread_list(void *data)
> > +{
> > +       struct vhost_worker *worker =3D data;
> > +       struct vhost_work *work, *work_next;
> > +       struct vhost_dev *dev =3D worker->dev;
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
> > +               node =3D llist_del_all(&worker->work_list);
> > +               if (!node)
> > +                       schedule();
> > +
> > +               node =3D llist_reverse_order(node);
> > +               /* make sure flag is seen after deletion */
> > +               smp_wmb();
> > +               llist_for_each_entry_safe(work, work_next, node, node) =
{
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
> >         struct vhost_worker *worker =3D data;
> > --
> > 2.45.0
> >
>

