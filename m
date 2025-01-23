Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487F2914
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597259; cv=none; b=iJAHLMhBGcVBPNJwCnIjKijnhXRZw9IRqTg3cYVLu5LkEl/QaZ2LBzdsKmSQ31VlgN9Y/m6jT9Dfi6XIZCOBLaHxhAdGFgJvCTVEFhkUvN/NOKIXL2RFrjTZUsqrg9+FiNiPl+D1bjYNdhNrZUK7ECiamZZ4kj9trOhzD5DebXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597259; c=relaxed/simple;
	bh=HICTabMxq+4bACHrozjEZ1JCBz3+qyVeyhqVA1T0+JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PY82pDD63PbZFkLaKeHbQ4VlBG8uQMOtkuyYRy/N9a5NveE6fAlUv8TjYSQN7SdGkVs7ZmLSRL/k8/JBhHXqMsQ+dneV8/PTkhqeNX5OS4VE5aRSOZWWE6Jp6+N/mqBwIgOzM0cNldNbB35S/5w0uAFcIXw4pX8GpQ17Z2/biO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gInBgUuD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gInBgUuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737597256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7WRvHfOaSmf9g/U2UGfz1vS373vK910kBiD8lUXhZE=;
	b=gInBgUuDsgQVWBVaI5l3/Q7lAfuH4C8IdwzMIZUn72EyiMsb+SmzslwIuTXn6+1J6vyKoa
	oVamvNl7vqwcV1wt0OxQkXJ3eQfsA6Mt9SWPo3G6RXT96Gzkl/THU36fDQ06SF2N+N9x7M
	XH24//qOQZMYcCiMhtwILxTk+w2vtgc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-J7FZ9wa6NVSuMvRr8rp-7w-1; Wed, 22 Jan 2025 20:54:13 -0500
X-MC-Unique: J7FZ9wa6NVSuMvRr8rp-7w-1
X-Mimecast-MFC-AGG-ID: J7FZ9wa6NVSuMvRr8rp-7w
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2163a2a1ec2so12445055ad.1
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 17:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737597253; x=1738202053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7WRvHfOaSmf9g/U2UGfz1vS373vK910kBiD8lUXhZE=;
        b=Hrp2YRz5y6OUC/2OQ9YkHevt4QJMMbU6I9ORXkXuMtSgu2aqTerBQVz5nV4sS4AIyG
         /OZg5Ow3XbO1/0+hZB0Iw+bNDcqXFtvGNSjTCmMV9VTVAvWAG30kV7WUhN/+mzQamS7t
         HnF0j1jnc7Y9vP8qXfn++rk06pRCGAxxZdmI7gn+AOw1br9R/HtO9VyR6KEEZu+eaY05
         V96pgxU0s110PlQQGriA7ZCMfgQdD0QfWV9nuPgFVE50Nso3GDQdbZmaqvgpUiAQXxR3
         hw0YrQ75MJ9DM6A/5ZpWWIWvJmb7oODCYtxsx+kTquXeo3+aW6RR1UM4XEeX4B109EQK
         cyvg==
X-Forwarded-Encrypted: i=1; AJvYcCX56yAkANJQR8pyt/PziSlxDXaa9cGSd/YVIS2U34zZBTwZmjawJWytjqp8Esa7gjIdWk56dZwGxzC964jTEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcJMSQE/kOkL9K2jVrGSHqDpTyT3X8PvsRg6Opjz2yqAu12IJa
	+vLwy5xXGywKlhNDkF/KtOq60vMPc9QJqfOd9TbFETLqTgg+u/kNdfKGpHvjB/lyN8+DbUhX4pa
	A9CheS7jkd1zoIHlb9CYpXQh9Vu74GomZ7uejf2bkvSsjth1aZhzHyzCTX+G98fEAeDz43Ahuxf
	L/jW3FnZ7HOttlPo8UqNW/K8+rPCooIk1C6SwLa84=
X-Gm-Gg: ASbGncueUyAlIfsWa1lP1qfhQwzqSefWXQout5HAyEicP4ffmXZjD2TbUZFikQJzUVc
	ZLBibnG0wHAPbmdAoEmgP1ZBXuTJSNT4+tmBYD+unMKRhxeKv4A==
X-Received: by 2002:a05:6a21:9990:b0:1e3:e836:8aea with SMTP id adf61e73a8af0-1eb2147cfafmr38010321637.14.1737597252709;
        Wed, 22 Jan 2025 17:54:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5UjCOpTOpJgTwtO6dQYgAcTuI3a6WlAWgI8abssAbb6K+PknnhUkt7goChkuDc1BN5Kr6VB29GQnvjA0GnPw=
X-Received: by 2002:a05:6a21:9990:b0:1e3:e836:8aea with SMTP id
 adf61e73a8af0-1eb2147cfafmr38010284637.14.1737597252213; Wed, 22 Jan 2025
 17:54:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122163154.1225353-1-eperezma@redhat.com> <20250122163154.1225353-4-eperezma@redhat.com>
In-Reply-To: <20250122163154.1225353-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 09:54:01 +0800
X-Gm-Features: AbW1kvaYx-oVwcnYkB9codxxf4o542tEJqePf1r-xRNtdIuynDdxg59Gjw-ARVY
Message-ID: <CACGkMEvgPAJcZW0EUuOK7byo2djOavT8Cai83=tH_dFJaVSY8Q@mail.gmail.com>
Subject: Re: [RFC 3/5] virtiofs: Move stack sg to fuse_req
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, 
	Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qjt78EMJF3kv9K2j9ofXTQ4y03c-SJrDGmHmBJaB1ng_1737597253
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> We need to move the map and unmap out of virtiofs queue lock.  We need to
> store the unmap sgs to call virtqueue_unmap_sgs, so use the request
> itself.
>
> TODO: We need to store the forget sgs too.  In my tests it is not called
> so we're safe.  Find a way to force-call it.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  fs/fuse/fuse_i.h    |  7 +++++++
>  fs/fuse/virtio_fs.c | 45 +++++++++++++++++++++------------------------
>  2 files changed, 28 insertions(+), 24 deletions(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f2860..e57664daa761 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -18,6 +18,7 @@
>  #include <linux/mount.h>
>  #include <linux/wait.h>
>  #include <linux/list.h>
> +#include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
>  #include <linux/mm.h>
>  #include <linux/backing-dev.h>
> @@ -434,6 +435,12 @@ struct fuse_req {
>  #if IS_ENABLED(CONFIG_VIRTIO_FS)
>         /** virtio-fs's physically contiguous buffer for in and out args =
*/
>         void *argbuf;
> +
> +       /** virtio-fs's pre-mapped stuff */
> +       struct scatterlist sg_inline_data[6]; /* optimization for short r=
equests */
> +       struct scatterlist *sg;
> +       unsigned int out_sgs;
> +       unsigned int in_sgs;
>  #endif

As this touches FUSE, I think we need to do a careful benchmark just
for this patch to make sure no regression is introduced.

A dumb question (know little about FUSE), if this is only used by
virtio-fs, could we find a way to embed fuse_req in a virtio-fs
dedicated req structure?

>
>         /** fuse_mount this request belongs to */
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 82afe78ec542..1344c5782a7c 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1377,14 +1377,10 @@ static int virtio_fs_enqueue_req(struct virtio_fs=
_vq *fsvq,
>  {
>         /* requests need at least 4 elements */
>         struct scatterlist *stack_sgs[6];
> -       struct scatterlist stack_sg[ARRAY_SIZE(stack_sgs)];
>         struct scatterlist **sgs =3D stack_sgs;
> -       struct scatterlist *sg =3D stack_sg;
>         struct virtqueue *vq;
>         struct fuse_args *args =3D req->args;
>         unsigned int argbuf_used =3D 0;
> -       unsigned int out_sgs =3D 0;
> -       unsigned int in_sgs =3D 0;
>         unsigned int total_sgs;
>         unsigned int i;
>         int ret;
> @@ -1392,11 +1388,13 @@ static int virtio_fs_enqueue_req(struct virtio_fs=
_vq *fsvq,
>         struct fuse_pqueue *fpq;
>
>         /* Does the sglist fit on the stack? */
> +       /* TODO replace magic 6 by a macro */
> +       req->sg =3D req->sg_inline_data;
>         total_sgs =3D sg_count_fuse_req(req);
> -       if (total_sgs > ARRAY_SIZE(stack_sgs)) {
> +       if (total_sgs > 6) {
>                 sgs =3D kmalloc_array(total_sgs, sizeof(sgs[0]), gfp);
> -               sg =3D kmalloc_array(total_sgs, sizeof(sg[0]), gfp);
> -               if (!sgs || !sg) {
> +               req->sg =3D kmalloc_array(total_sgs, sizeof(req->sg[0]), =
gfp);
> +               if (!sgs || !req->sg) {
>                         ret =3D -ENOMEM;
>                         goto out;
>                 }
> @@ -1408,26 +1406,25 @@ static int virtio_fs_enqueue_req(struct virtio_fs=
_vq *fsvq,
>                 goto out;
>
>         /* Request elements */
> -       sg_init_one(&sg[out_sgs++], &req->in.h, sizeof(req->in.h));
> -       out_sgs +=3D sg_init_fuse_args(&sg[out_sgs], req,
> -                                    (struct fuse_arg *)args->in_args,
> -                                    args->in_numargs, args->in_pages,
> -                                    req->argbuf, &argbuf_used);
> +       sg_init_one(&req->sg[req->out_sgs++], &req->in.h, sizeof(req->in.=
h));
> +       req->out_sgs +=3D sg_init_fuse_args(&req->sg[req->out_sgs], req,
> +                                         (struct fuse_arg *)args->in_arg=
s,
> +                                         args->in_numargs, args->in_page=
s,
> +                                         req->argbuf, &argbuf_used);
>
>         /* Reply elements */
>         if (test_bit(FR_ISREPLY, &req->flags)) {
> -               sg_init_one(&sg[out_sgs + in_sgs++],
> +               sg_init_one(&req->sg[req->out_sgs + req->in_sgs++],
>                             &req->out.h, sizeof(req->out.h));
> -               in_sgs +=3D sg_init_fuse_args(&sg[out_sgs + in_sgs], req,
> -                                           args->out_args, args->out_num=
args,
> -                                           args->out_pages,
> -                                           req->argbuf + argbuf_used, NU=
LL);
> +               req->in_sgs +=3D sg_init_fuse_args(&req->sg[req->out_sgs =
+ req->in_sgs], req,
> +                                                args->out_args, args->ou=
t_numargs,
> +                                                args->out_pages,
> +                                                req->argbuf + argbuf_use=
d, NULL);
>         }
>
> -       WARN_ON(out_sgs + in_sgs !=3D total_sgs);
> -
>         for (i =3D 0; i < total_sgs; i++)
> -               sgs[i] =3D &sg[i];
> +               sgs[i] =3D &req->sg[i];
> +       WARN_ON(req->out_sgs + req->in_sgs !=3D total_sgs);
>
>         spin_lock(&fsvq->lock);
>
> @@ -1438,7 +1435,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_v=
q *fsvq,
>         }
>
>         vq =3D fsvq->vq;
> -       ret =3D virtqueue_add_sgs(vq, sgs, out_sgs, in_sgs, req, GFP_ATOM=
IC);
> +       ret =3D virtqueue_add_sgs(vq, sgs, req->out_sgs, req->in_sgs, req=
, GFP_ATOMIC);
>         if (ret < 0) {
>                 spin_unlock(&fsvq->lock);
>                 goto out;
> @@ -1467,10 +1464,10 @@ static int virtio_fs_enqueue_req(struct virtio_fs=
_vq *fsvq,
>                 kfree(req->argbuf);
>                 req->argbuf =3D NULL;
>         }
> -       if (sgs !=3D stack_sgs) {
> +       if (ret < 0 && req->sg !=3D req->sg_inline_data)
> +               kfree(req->sg);
> +       if (sgs !=3D stack_sgs)
>                 kfree(sgs);
> -               kfree(sg);
> -       }
>
>         return ret;
>  }
> --
> 2.48.1
>

Thanks

