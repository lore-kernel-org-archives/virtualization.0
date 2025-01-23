Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3F201100
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617651; cv=none; b=S67gMDIL1k0EFsd0vHGcRhFYO2pjh2/TXh1LnGEbYGzct1l8BdTm02GuKiaLkyBv0cfhFaiUvfjDDnIWkXeJtjUzENuK1Qm6cZ0m7oZ2+PmMUvQwGNzm6Di/r4sXZ6ey623HSW2rHHrl8EaEDL4KlTj0o8ul0zDAWGoGekwrxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617651; c=relaxed/simple;
	bh=2dGuyGchfh3E6MHVDhtYFz65Pw/ikJlgAIs/GintMQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTfx7EAqU4rG/XberAf8jVa/0NwfP26YYLCJqoOMqnPIaqEL2ayo2Hn5pigcylx12pfvOWIer/nqP+eG4Qhwzb+hncbU0uAZRJVFp2CTStJ5KHMUhCI2XiavsNGnAXttvyuCpfF8gPdbWeUyCfuqVqpMCBU8kaOshS5wA7QrOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3AyDQ7v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3AyDQ7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737617648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/o5kY1iXBTWSkjsJ8GgX9mtxulcqnYFPpf7klRo1BNk=;
	b=X3AyDQ7vofkFrbOsbuLzlxfj/SW86Ovw+3vttRpunUbh6NtNVcO/iDK7aMQWJVx5EC5vo6
	34M5ZuSk3Vaaz5LEavt9dBGmgfk+QRWuavZfZcJE5oVrTApXZ87P43fhzKXPvHbowVJWNb
	F1DUAx0aksOCD7MhTlFcyEmX+6ntpm4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-qeBQBzi9OgO_Tp7vathh8g-1; Thu, 23 Jan 2025 02:34:06 -0500
X-MC-Unique: qeBQBzi9OgO_Tp7vathh8g-1
X-Mimecast-MFC-AGG-ID: qeBQBzi9OgO_Tp7vathh8g
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e54e14f7cbcso1764786276.1
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 23:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737617646; x=1738222446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/o5kY1iXBTWSkjsJ8GgX9mtxulcqnYFPpf7klRo1BNk=;
        b=noioKWIrJ8EYB6lWZCxgWFFzb+xUoPIrPJHcB3z0XesJpNGU7EqdHS5gQLmGcAWzJ1
         IAmAiq4AO1ZGI7rcIyypaBBVjr1/TOypajDYig8apsoL6YBuppHkUECdrHHNZjtbkyxK
         1+eNIAZzQY6BFFBIVrOgUzjKsBhn/jwmhdrcRZoy9LQDQlktjLn9klGz6el19KuE/Fmh
         ag7QQD5hdUNvPPt4Y0N4nBys/PG+eT3f6ykNhHs2XyMcCSrg/Ad86TAfg7sLCv7TmdBL
         F9gvho1BFT9f+hQgj04xMYXhp7cijixP4IyUy/kO9kg2El2UeourkyK48htXVNNxpSxk
         Iu9A==
X-Forwarded-Encrypted: i=1; AJvYcCVMy20tZaeOWqq2/FcaTOL0ZtiwLAC07+LTU0voZ8hQ/IscSPHjke/GxMO06gyIF4hqZbk9FPu/Iq+rSN7LXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyPTAa6nLKCj451ZTFv0gEtg0VZKlVwgQZqQTMJVYt6DVTN7tk
	yY6DhnK5SsvyusqX20f3A+QAmbDaQgw5JatXSONnTOnrO8qp6OkF19lAz1kDJJ5WQ6eRytCphVQ
	3kT+wecworF+3OmJGBPxzuXFlc77Xpi3tGVSafV3CmK2ZnviGUGYTsGWJ6+JhgQzQ3o57umRnBC
	KkaXkrdDQ7r4Onoij3D3QrJGIzJyQ02QfFRV/dL1I=
X-Gm-Gg: ASbGncs2/mDPQZQosE5PhRqLEDgfj+NbtnYCfDtJlAsHvKZw48Lh+VNcolzv7kcTWgA
	GQ+u4X9Ik8Rz8cgvuXCnOlgLavtKYK4supGUFHOEeIlp2GfM4zw==
X-Received: by 2002:a05:6902:2502:b0:e58:124d:ebdf with SMTP id 3f1490d57ef6-e582587134fmr1858331276.17.1737617645955;
        Wed, 22 Jan 2025 23:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9HeLeFh6hEK4cDs91T1wLQv0hQaLGG7RLbZ2CGUPBB6tjWyHhKXplbc5pCzaYiBBijstFT3noQuv7HvaIT7U=
X-Received: by 2002:a05:6902:2502:b0:e58:124d:ebdf with SMTP id
 3f1490d57ef6-e582587134fmr1858318276.17.1737617645668; Wed, 22 Jan 2025
 23:34:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122163154.1225353-1-eperezma@redhat.com> <20250122163154.1225353-4-eperezma@redhat.com>
 <CACGkMEvgPAJcZW0EUuOK7byo2djOavT8Cai83=tH_dFJaVSY8Q@mail.gmail.com>
In-Reply-To: <CACGkMEvgPAJcZW0EUuOK7byo2djOavT8Cai83=tH_dFJaVSY8Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 23 Jan 2025 08:33:29 +0100
X-Gm-Features: AbW1kvYeg33litEtRfMgeLKErvp65PAOLLeMhXDkdjiQs2joMcEfu3qceEylaiE
Message-ID: <CAJaqyWdoLEtNL5vO7qG7bzDUM3mTCrZUeRM0Lg-9+TJc59p2XQ@mail.gmail.com>
Subject: Re: [RFC 3/5] virtiofs: Move stack sg to fuse_req
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, 
	Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9rsfd9NHgA6hZ2DE4EdPNMpyS9OEnWD8pjzQWGjVsEY_1737617646
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:54=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jan 23, 2025 at 12:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> >
> > We need to move the map and unmap out of virtiofs queue lock.  We need =
to
> > store the unmap sgs to call virtqueue_unmap_sgs, so use the request
> > itself.
> >
> > TODO: We need to store the forget sgs too.  In my tests it is not calle=
d
> > so we're safe.  Find a way to force-call it.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  fs/fuse/fuse_i.h    |  7 +++++++
> >  fs/fuse/virtio_fs.c | 45 +++++++++++++++++++++------------------------
> >  2 files changed, 28 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 74744c6f2860..e57664daa761 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -18,6 +18,7 @@
> >  #include <linux/mount.h>
> >  #include <linux/wait.h>
> >  #include <linux/list.h>
> > +#include <linux/scatterlist.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/mm.h>
> >  #include <linux/backing-dev.h>
> > @@ -434,6 +435,12 @@ struct fuse_req {
> >  #if IS_ENABLED(CONFIG_VIRTIO_FS)
> >         /** virtio-fs's physically contiguous buffer for in and out arg=
s */
> >         void *argbuf;
> > +
> > +       /** virtio-fs's pre-mapped stuff */
> > +       struct scatterlist sg_inline_data[6]; /* optimization for short=
 requests */
> > +       struct scatterlist *sg;
> > +       unsigned int out_sgs;
> > +       unsigned int in_sgs;
> >  #endif
>
> As this touches FUSE, I think we need to do a careful benchmark just
> for this patch to make sure no regression is introduced.
>

Sure, I can do it. But the struct already has a virtiofs field (argbuf).

> A dumb question (know little about FUSE), if this is only used by
> virtio-fs, could we find a way to embed fuse_req in a virtio-fs
> dedicated req structure?
>

I guess FUSE can ask virtiofs to allocate the struct for sure.

> >
> >         /** fuse_mount this request belongs to */
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 82afe78ec542..1344c5782a7c 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -1377,14 +1377,10 @@ static int virtio_fs_enqueue_req(struct virtio_=
fs_vq *fsvq,
> >  {
> >         /* requests need at least 4 elements */
> >         struct scatterlist *stack_sgs[6];
> > -       struct scatterlist stack_sg[ARRAY_SIZE(stack_sgs)];
> >         struct scatterlist **sgs =3D stack_sgs;
> > -       struct scatterlist *sg =3D stack_sg;
> >         struct virtqueue *vq;
> >         struct fuse_args *args =3D req->args;
> >         unsigned int argbuf_used =3D 0;
> > -       unsigned int out_sgs =3D 0;
> > -       unsigned int in_sgs =3D 0;
> >         unsigned int total_sgs;
> >         unsigned int i;
> >         int ret;
> > @@ -1392,11 +1388,13 @@ static int virtio_fs_enqueue_req(struct virtio_=
fs_vq *fsvq,
> >         struct fuse_pqueue *fpq;
> >
> >         /* Does the sglist fit on the stack? */
> > +       /* TODO replace magic 6 by a macro */
> > +       req->sg =3D req->sg_inline_data;
> >         total_sgs =3D sg_count_fuse_req(req);
> > -       if (total_sgs > ARRAY_SIZE(stack_sgs)) {
> > +       if (total_sgs > 6) {
> >                 sgs =3D kmalloc_array(total_sgs, sizeof(sgs[0]), gfp);
> > -               sg =3D kmalloc_array(total_sgs, sizeof(sg[0]), gfp);
> > -               if (!sgs || !sg) {
> > +               req->sg =3D kmalloc_array(total_sgs, sizeof(req->sg[0])=
, gfp);
> > +               if (!sgs || !req->sg) {
> >                         ret =3D -ENOMEM;
> >                         goto out;
> >                 }
> > @@ -1408,26 +1406,25 @@ static int virtio_fs_enqueue_req(struct virtio_=
fs_vq *fsvq,
> >                 goto out;
> >
> >         /* Request elements */
> > -       sg_init_one(&sg[out_sgs++], &req->in.h, sizeof(req->in.h));
> > -       out_sgs +=3D sg_init_fuse_args(&sg[out_sgs], req,
> > -                                    (struct fuse_arg *)args->in_args,
> > -                                    args->in_numargs, args->in_pages,
> > -                                    req->argbuf, &argbuf_used);
> > +       sg_init_one(&req->sg[req->out_sgs++], &req->in.h, sizeof(req->i=
n.h));
> > +       req->out_sgs +=3D sg_init_fuse_args(&req->sg[req->out_sgs], req=
,
> > +                                         (struct fuse_arg *)args->in_a=
rgs,
> > +                                         args->in_numargs, args->in_pa=
ges,
> > +                                         req->argbuf, &argbuf_used);
> >
> >         /* Reply elements */
> >         if (test_bit(FR_ISREPLY, &req->flags)) {
> > -               sg_init_one(&sg[out_sgs + in_sgs++],
> > +               sg_init_one(&req->sg[req->out_sgs + req->in_sgs++],
> >                             &req->out.h, sizeof(req->out.h));
> > -               in_sgs +=3D sg_init_fuse_args(&sg[out_sgs + in_sgs], re=
q,
> > -                                           args->out_args, args->out_n=
umargs,
> > -                                           args->out_pages,
> > -                                           req->argbuf + argbuf_used, =
NULL);
> > +               req->in_sgs +=3D sg_init_fuse_args(&req->sg[req->out_sg=
s + req->in_sgs], req,
> > +                                                args->out_args, args->=
out_numargs,
> > +                                                args->out_pages,
> > +                                                req->argbuf + argbuf_u=
sed, NULL);
> >         }
> >
> > -       WARN_ON(out_sgs + in_sgs !=3D total_sgs);
> > -
> >         for (i =3D 0; i < total_sgs; i++)
> > -               sgs[i] =3D &sg[i];
> > +               sgs[i] =3D &req->sg[i];
> > +       WARN_ON(req->out_sgs + req->in_sgs !=3D total_sgs);
> >
> >         spin_lock(&fsvq->lock);
> >
> > @@ -1438,7 +1435,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs=
_vq *fsvq,
> >         }
> >
> >         vq =3D fsvq->vq;
> > -       ret =3D virtqueue_add_sgs(vq, sgs, out_sgs, in_sgs, req, GFP_AT=
OMIC);
> > +       ret =3D virtqueue_add_sgs(vq, sgs, req->out_sgs, req->in_sgs, r=
eq, GFP_ATOMIC);
> >         if (ret < 0) {
> >                 spin_unlock(&fsvq->lock);
> >                 goto out;
> > @@ -1467,10 +1464,10 @@ static int virtio_fs_enqueue_req(struct virtio_=
fs_vq *fsvq,
> >                 kfree(req->argbuf);
> >                 req->argbuf =3D NULL;
> >         }
> > -       if (sgs !=3D stack_sgs) {
> > +       if (ret < 0 && req->sg !=3D req->sg_inline_data)
> > +               kfree(req->sg);
> > +       if (sgs !=3D stack_sgs)
> >                 kfree(sgs);
> > -               kfree(sg);
> > -       }
> >
> >         return ret;
> >  }
> > --
> > 2.48.1
> >
>
> Thanks
>

