Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18ED1ABED9
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736322009; cv=none; b=gNifAMW/Gq7bVrh83KtNAbkmh/00a8JWv3dSvL+9B9jc1lTS2oWtjGkFktJ65zfa6Wb2mppLKs+4+qLQZxJPPamZ6P7+5z2njZ2yNDFfUoSOKN6A+P68SxjZgVfuHe0nPktSRep1zbgZdattPf+vm6SYXFTB9ByGqpio3DdnO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736322009; c=relaxed/simple;
	bh=kZXl25nfFWRZ156iUqrQf8k8ZQQgE63W71cWuTMebRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8W7t3r5a+ky0Jjd+m08sAbwOd7KNulKLC6UKBEYsW4Q5tqsIiMzoGNrWFK541VsgX/0ALIzAnB7B4tiG6TRC3KcBPP1/lFd+s5NEmQ2Xu5Kyoe9eX8Xw2jYJRQb0Yzf6/PwH62Jh6hjEMf6BAVaaiXmxuf7yWqoJ3pgD2scG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrX8BoMY; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrX8BoMY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67F4E6069E
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 07:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zSGttGzOzGAp for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 07:40:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7FB06605A2
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FB06605A2
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GrX8BoMY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7FB06605A2
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 07:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736322004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRiLAMcY80WeK7MajdAzZCvNFuJtwb9jaSJlZhW8/IU=;
	b=GrX8BoMYCQKEYBUCMq9hpTtFS5iOcoa10AATIo0PsgiIw2QWzR2VSkqd6yl1vhyVtuVbVu
	KxTsbNM3hmfRXfDmAOQON0Hwthp+gEQarukYhKykUlnROxBVBu0OLL+3fKs9vTqupxbvEp
	d4l9MXL2ibFE8xHKsAjN7tQ1wENIGXk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-PQzQovGSPhKXMgpvHU15-Q-1; Wed, 08 Jan 2025 02:40:02 -0500
X-MC-Unique: PQzQovGSPhKXMgpvHU15-Q-1
X-Mimecast-MFC-AGG-ID: PQzQovGSPhKXMgpvHU15-Q
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso24381052a91.1
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Jan 2025 23:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736322002; x=1736926802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRiLAMcY80WeK7MajdAzZCvNFuJtwb9jaSJlZhW8/IU=;
        b=DAE0sr9CljbYn73rzSJf/A9aWrgGb7HBGYs66DikNg3q4kRuEOjuS5Lvi24jg8N2Jg
         3IcLGZ/3SPPhcdYPA7zoA90fDExN5117Atq8KRMnwvLek0EE6XJglyOg7sBj2h3Tq+7Q
         Y5puTa8kiqD/dA8gHdElyTkCGBZTEWyGpedqyWeE0Qa+OOUqgjytsPRLs4Zsdhtxo3/b
         aVVxl4jjWTd3+HPvhR1L/PMCpQWKIOk0WEegLiglFYoWs5iGfHLWEU6iBbtR1uy+zHRa
         ouIzR0IxH+mWZK48YT0d/BCsTnzT+IKPyNOzIbFjYSIel0ZZ6MDxB++cK7/enHSQPZ2N
         BIAA==
X-Forwarded-Encrypted: i=1; AJvYcCU26VXvl8w7csjkl+sTSObw3MdblJHZD8qigsrLrO/5SDKuXIIwPOUTV2hcEMDzjrY9Txa4IO1bixAT5CKxBQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yyl2HYXCwKnB9rIYYnrI1gvnMmTVFYynu+SUAOetWcTrTKcIkRL
	Ni51VXzyhDLiRKVMUnGKNdn024NmKvdWwch6NIM+1xjJZS57gNN0PPUpc1v74Jcv/oPf36I39Xv
	L9t5qFtrrFBeyyipwEwEAslp4Y8Xg3HdoPZnlKKBBsL1LKz04dSNFCKN8IDvTocJ3fn0+HmK+TX
	jyw51omklWVNmRJovy4O783WnrFjwrPM4Fc8EMEaXpO/9dWaimAY7Drg==
X-Gm-Gg: ASbGnctqklCKGgvJ8yYt3mktQOvhuywGVk5fVDf6irdZgA+cDmAvE9tkMWs8sM9IV8T
	8J3L1VAbZyFWm5dYnspPHs8XjpbirAEBEPdE3sN8=
X-Received: by 2002:a05:6a00:2908:b0:728:e745:23d8 with SMTP id d2e1a72fcca58-72d21ffab83mr3083094b3a.24.1736322001685;
        Tue, 07 Jan 2025 23:40:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdnsUUHo4MoHt26TfNW7e8VJxNZZsJ/umVVZ2UoiKS3JeJ5xt0Act67i2nSAwnjqlqptLKLf9nz7CUvhNbJoo=
X-Received: by 2002:a05:6a00:2908:b0:728:e745:23d8 with SMTP id
 d2e1a72fcca58-72d21ffab83mr3083065b3a.24.1736322001229; Tue, 07 Jan 2025
 23:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-4-lulu@redhat.com>
 <CACGkMEu29fZxNoyLOytScwFqFSFP+o3-ETSgG8u4Kgq_yEt6Gw@mail.gmail.com> <CACLfguWQ6q1wmKi5anF=2ofbDzWaTjgY27T9WO_Xtyh3FkVDYg@mail.gmail.com>
In-Reply-To: <CACLfguWQ6q1wmKi5anF=2ofbDzWaTjgY27T9WO_Xtyh3FkVDYg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Jan 2025 15:39:50 +0800
X-Gm-Features: AbW1kvZ3XdY5-P2kwC3YoDfIq6i9PSM0nU40ETthuxPqRIN4fuKVjfX9nYolz0k
Message-ID: <CACGkMEuGLDmYq6igW3U6dKGd0WYmtQgzNu6C02ae5ZRP0_Nq+w@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vhost: Add the cgroup related function
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SWArGk2hGaB59591V37xoU20Gp9EJa5I8LIuApWuYco_1736322002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 10:57=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Thu, Jan 2, 2025 at 11:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Reintroduce the previously removed functions vhost_attach_cgroups_wor=
k()
> > > and vhost_attach_cgroups() to support kthread mode. Rename
> > > vhost_attach_cgroups() to vhost_attach_task_to_cgroups(), and include
> > > the implementation of the old function vhost_dev_flush() in this
> > > new function.
> > >
> > > These function was removed in
> > > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 1feba29abf95..812dfd218bc2 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/kthread.h>
> > > +#include <linux/cgroup.h>
> > >  #include <linux/module.h>
> > >  #include <linux/sort.h>
> > >  #include <linux/sched/mm.h>
> > > @@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev=
)
> > >  }
> > >  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
> > >
> > > +struct vhost_attach_cgroups_struct {
> > > +       struct vhost_work work;
> > > +       struct task_struct *owner;
> > > +       int ret;
> > > +};
> > > +
> > > +static void vhost_attach_cgroups_work(struct vhost_work *work)
> > > +{
> > > +       struct vhost_attach_cgroups_struct *s;
> > > +
> > > +       s =3D container_of(work, struct vhost_attach_cgroups_struct, =
work);
> > > +       s->ret =3D cgroup_attach_task_all(s->owner, current);
> > > +}
> > > +
> > > +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> > > +{
> > > +       struct vhost_flush_struct flush;
> > > +       struct vhost_attach_cgroups_struct attach;
> > > +
> > > +       attach.owner =3D current;
> > > +
> > > +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> > > +       vhost_worker_queue(worker, &attach.work);
> > > +
> > > +       init_completion(&flush.wait_event);
> > > +       vhost_work_init(&flush.work, vhost_flush_work);
> > > +       vhost_worker_queue(worker, &flush.work);
> > > +       wait_for_completion(&flush.wait_event);
> > > +
> > > +       return attach.ret;
> > > +}
> >
> > This seems to be inconsistent with what you said above which is
> >
> > """
> > > These function was removed in
> > > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > """
> >
> > As 6e890c5d5021 had:
> >
> > static int vhost_attach_cgroups(struct vhost_dev *dev)
> > {
> >         struct vhost_attach_cgroups_struct attach;
> >
> >         attach.owner =3D current;
> >         vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> >         vhost_work_queue(dev, &attach.work);
> >         vhost_dev_flush(dev);
> >         return attach.ret;
> > }
> >
> > It seems current vhost_dev_flush() will still work or the open coding
> > of the flush logic needs to be explained.
> >
> > Thanks
> >
> the current vhost_dev_flush was changed to support xarray, So it does
> not work here , I will add more information here

Any reason it can't work here?

Thanks

> Thanks
> cindy
> > > +
> > >  /* Caller should have device mutex */
> > >  bool vhost_dev_has_owner(struct vhost_dev *dev)
> > >  {
> > > --
> > > 2.45.0
> > >
> >
>

