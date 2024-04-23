Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7DD17C66
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841819; cv=none; b=TyAIt3z/gLYP4vKju6y7WoyAHO4TJrr4TVzyczUGDqz2yCGX8+UvXTVUWOEZUb6QBD0O39uwjb/lJPiv665m3AfAv8RgURpmAcBgVCCOPbjfhg8lt9c2qPdoIy7vnF5Oq7jK7wrgLCmP+VEY29EbfEcLB7ZPoYwNo9fBq0Z7Vls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841819; c=relaxed/simple;
	bh=wXNHc5PiarQzMsw9YBToa7rRkxIOn05fejmLy8UMDd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sa+7AxsBla0hdkeoyFMZjGim7HOc2xxe6IBCufnfxLr4SZLhO9nKh3WEJvsKSAbb8lygMLeu0jo9QmNtBc4nFaJ14eok7wOkBqXEWocPtyxQQ1cQ+6gW9Azo+CIvAmgFSgKOiGB/WdLdCVIGo+9zRQo9x0NP+lpn1YYKRzaZfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jM07YvYq; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM07YvYq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC35981EAB
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 03:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GhTBSkpgGGdo for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Apr 2024 03:10:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 53E2F81E71
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53E2F81E71
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jM07YvYq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 53E2F81E71
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713841814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGOzBYTBEU4Vx1BmqOXWbqCplxuBx3Gn5FBEe57Uzsg=;
	b=jM07YvYqQEsqVGmd4rz5il0XTf50QZN+QGJWXeULPnFPHFKFnVr5DQpBuczqtf4UUB3Wfw
	vtW0x6dN6lWd5OqaX1bVS7Ycw+pCSepgEW3CPd65YcTPr03A/Zo2h5ij/CvnfevZEe85M8
	maEMXFrq9Pnd/mGbLX/9z367CubOPJ8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-XIr-nuzkPQujtEhxauTwfA-1; Mon, 22 Apr 2024 23:10:12 -0400
X-MC-Unique: XIr-nuzkPQujtEhxauTwfA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a7dad5cdfeso6692326a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 20:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713841811; x=1714446611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGOzBYTBEU4Vx1BmqOXWbqCplxuBx3Gn5FBEe57Uzsg=;
        b=iyZQbkrb+zV+FfKo40+exwPQOikqc4qNlcWqxjwXczy2+IYGvrPQ9WP/Oxxh4ZsfOx
         Xyvc8PU/GlUwgLnzp7IBEdcykoaGIvjUF0AMmjnzz39HlBt5wl9mv4YWdWMINhtBwzAX
         E7YDBTXp0AdANhKJAKp+6JOhB2/ilBRbnqcKuTncdqvYfQrBltI16UeaawhbV1NtLfw7
         ujfP/SeV9YpylUL6+rkAMwp8dicXVVKtVLWGaBhAVXE4LQ3whJ9Zzltq9nT8zpOvZnlM
         EIzJLsLMZ+V10YOcRYJZ75174bhSlfD4dPAckGxZDffja1cFF0U5NNFRwACEdscgP94q
         vzjw==
X-Forwarded-Encrypted: i=1; AJvYcCXLSK844RiKvG12ck6kAJIvGU9ReBs5zVMt34QqK1kIVZdGknUan5xtBjdBRyVWRHEYyMBHvdrsgZ4pxgufgYJblxwiOEGyQ+mD22Pm82VX3mgRE5zh4tH6sw==
X-Gm-Message-State: AOJu0YxILYKxvnA5YyMWC6dxKWMkphHMWUDHTS8dnX4E7nOvXDWapo2Y
	4w+1NJlk6ufEwSGiSgCjJhCJ+qiDUhSS4oyjN/PK5PyXhOvPonwFFWqXBlINN+zUzlpnAV3QsVW
	COxM+/aiJtgwd1Zm990AXYGduWsayQiBhR81Kt1h0CMVZfl82iJqdlojJ8+2NuHCbWfxMLtqE5e
	u2WUnp4U349+uyUWIDjDOwpLmIcgbysRyD2vfq9DHOozdwd2lfTVPPiQ==
X-Received: by 2002:a17:90a:d990:b0:2ab:ca7d:658b with SMTP id d16-20020a17090ad99000b002abca7d658bmr10112314pjv.4.1713841811371;
        Mon, 22 Apr 2024 20:10:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgWUZxEIFiEErm5ahPVsmlGOlQL1BmJvl5wL68pDzSmIyeZFBW5KI0sV7sfwyMQHO929OZbhQnJ8VHOn5ptBY=
X-Received: by 2002:a17:90a:d990:b0:2ab:ca7d:658b with SMTP id
 d16-20020a17090ad99000b002abca7d658bmr10112304pjv.4.1713841811015; Mon, 22
 Apr 2024 20:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org> <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240422160348-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Apr 2024 11:09:59 +0800
Message-ID: <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > and vduse_alloc_reconnnect_info_mem
> > > > These functions allow vduse to allocate and free memory for reconne=
ction
> > > > information. The amount of memory allocated is vq_num pages.
> > > > Each VQS will map its own page where the reconnection information w=
ill be saved
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 40 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > >       int irq_effective_cpu;
> > > >       struct cpumask irq_affinity;
> > > >       struct kobject kobj;
> > > > +     unsigned long vdpa_reconnect_vaddr;
> > > >  };
> > > >
> > > >  struct vduse_dev;
> > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(st=
ruct vduse_virtqueue *vq)
> > > >
> > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > >  }
> > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > > > +{
> > > > +     unsigned long vaddr =3D 0;
> > > > +     struct vduse_virtqueue *vq;
> > > > +
> > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > +             vq =3D dev->vqs[i];
> > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > >
> > >
> > > I don't get why you insist on stealing kernel memory for something
> > > that is just used by userspace to store data for its own use.
> > > Userspace does not lack ways to persist data, for example,
> > > create a regular file anywhere in the filesystem.
> >
> > Good point. So the motivation here is to:
> >
> > 1) be self contained, no dependency for high speed persist data
> > storage like tmpfs
>
> No idea what this means.

I mean a regular file may slow down the datapath performance, so
usually the application will try to use tmpfs and other which is a
dependency for implementing the reconnection.

>
> > 2) standardize the format in uAPI which allows reconnection from
> > arbitrary userspace, unfortunately, such effort was removed in new
> > versions
>
> And I don't see why that has to live in the kernel tree either.

I can't find a better place, any idea?

Thanks

>
> > If the above doesn't make sense, we don't need to offer those pages by =
VDUSE.
> >
> > Thanks
> >
> >
> > >
> > >
> > >
> > > > +             if (vaddr =3D=3D 0)
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > > > +{
> > > > +     struct vduse_virtqueue *vq;
> > > > +
> > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > +             vq =3D dev->vqs[i];
> > > > +
> > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > +             vq->vdpa_reconnect_vaddr =3D 0;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > >
> > > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > >                           unsigned long arg)
> > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> > > >               mutex_unlock(&dev->lock);
> > > >               return -EBUSY;
> > > >       }
> > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > +
> > > >       dev->connected =3D true;
> > > >       mutex_unlock(&dev->lock);
> > > >
> > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_de=
v_config *config,
> > > >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, config->vq_=
num);
> > > >       if (ret)
> > > >               goto err_vqs;
> > > > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > > > +     if (ret < 0)
> > > > +             goto err_mem;
> > > >
> > > >       __module_get(THIS_MODULE);
> > > >
> > > >       return 0;
> > > >  err_vqs:
> > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->m=
inor));
> > > > +err_mem:
> > > > +     vduse_free_reconnnect_info_mem(dev);
> > > >  err_dev:
> > > >       idr_remove(&vduse_idr, dev->minor);
> > > >  err_idr:
> > > > --
> > > > 2.43.0
> > >
>

