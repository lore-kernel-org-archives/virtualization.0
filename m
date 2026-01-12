Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A51350A19
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215381; cv=none; b=M/bpYUYIhNu9UIGDIbrdmUNdv8vI+0GwZuU+KSPqIqNPxzUe5U6hTstYrEqIp1Sx8vkLDZZNfYOSkZovHvUltUH4betEYSkdpb0XyC3zCFPiP6fg2sJkjNPRNzH18KECxQJAY+L3lEgY1lXxiNTtzrwS2FG89pATa8sWemfDqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215381; c=relaxed/simple;
	bh=nGiD7bw2cOMOtg26hDarR/W1rQ2KTZmr9SgL6IwuPvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gib9TqnwTeQ1ZUt/iWigoB2gAI7Ld9TX3087iOMZfE2uoOTjCKWMK+6eHQwMLVO1LJuDd0l/JVJEZHP52iEnfNxDFySoqYnMj4RQPy3uX241EGV14NIYZ+v4Q6d0Qes8zJWeBGY3BXvPSJHpZBQVbbspLwdXvu2VCr56ji2IEUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HH8HDd6Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH8HDd6Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768215375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkidxxhbJThge+ww1GsMvdCUGdlZhwic8/zcfvYMO6Q=;
	b=HH8HDd6ZJhQFAHj9dclsRDrCT1PGj3zKaiHeCTQwa9DQTsIKLtqOg09vdr/pgq87XTwiSj
	GWqO6u7Yp1B1ncVkp6M8/XSKkpAcFNvHlHgOzfnLDefwtV3ehcOTqx7G8F9gM5jvRO6eiB
	wgQR8HJAlnEjBeXWHdc8Tqp70iFKCGg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-YeZ7XwqvNvqhYhCAcZWLKA-1; Mon, 12 Jan 2026 05:56:14 -0500
X-MC-Unique: YeZ7XwqvNvqhYhCAcZWLKA-1
X-Mimecast-MFC-AGG-ID: YeZ7XwqvNvqhYhCAcZWLKA_1768215374
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7900ab6755fso96283287b3.0
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 02:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768215374; x=1768820174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UkidxxhbJThge+ww1GsMvdCUGdlZhwic8/zcfvYMO6Q=;
        b=fm0GHCRQ2MLdPNo/eW9E4PM8kyK1lPCDIkeRk7uGz9L5b/JMbzx5Bavyl+luYaueHT
         dv/nNw54giftVrfKBShRMQZ1hYh3BWjvEFXsfdk9TIu02N6n8+YI+B22fpWtibzUIlMo
         XrubN0zQxEjvyxaNs3qgay9mcIi0I03UQgb06A67ABLFwM53sIYgsK7igiJe7F5Cp08Q
         thY0IBfZOyTGPFogBEWwbpPRTxR2WgvKt3njiapUrs5GrFZI5PJF3mQIdEKucERgsbeB
         UsMoTbrWErcaEy4T41XsqRcq2LxXi6TrOO4NTvBGi1NUR3oHEPB1MM06faHxngUOY0m5
         8C1w==
X-Forwarded-Encrypted: i=1; AJvYcCW7+PHCOzNTQmO7igM4ca92qWB37Yn9+zURcNR+GhKPXp/Dx703CQ4sch3gS/1bqUqXu8+pMIU1Ka0t58qupQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSOXYdNiUzQWiyQNLWdte1A9bDJqCakbVQsLBJCpzTO3jzBI2Y
	SPwdF53vklZAXTZwOHi436eJEizkYaRqG3OE//0fQvJ37aMzMQRliSZ8OXbuIjrAPdaqch2hPBa
	r8Eu76qZSf5U/5pJW8TTfwXYFO7EPxXB0iO+ZNdaEZwcn8Wudb/Bg70Mbb3D3xPozWb29NfMaNk
	Evu16jdpgofS/pu2tdaFnyOpDAUuvt3VHY/g3fCkWzDGk=
X-Gm-Gg: AY/fxX7uH1MO0pKnCWjk7K97EyQeK5WSz9SqlHK+t07YjNrwCXZtbGDIfbgoVaaBOKe
	5O8hy0xNvNIJThTwEDWRkKCkBCuFDM2RdvaP2qbgGJqSpKHrm//LVxQqhGtGbXaBMFUbF1NIdL4
	g4OJ9ayRV9roJEH4Pu3ca0hMY55ZmeOPf8XqDcOJPa/0J4mp1vNOW2zMNFbEYOSOAPUQ==
X-Received: by 2002:a05:690e:140b:b0:644:7398:6682 with SMTP id 956f58d0204a3-64716ba3225mr14924809d50.30.1768215373759;
        Mon, 12 Jan 2026 02:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKmmfP3F70Is0/v7kJhGPMZ27JCX3KYWq+oBAh6b3Xob35HGfPNXGYsgs38iaQs2lGjoWd+Rm/VuuJUrkyi6A=
X-Received: by 2002:a05:690e:140b:b0:644:7398:6682 with SMTP id
 956f58d0204a3-64716ba3225mr14924797d50.30.1768215373459; Mon, 12 Jan 2026
 02:56:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-11-eperezma@redhat.com>
 <20260110185423-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260110185423-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 12 Jan 2026 11:55:37 +0100
X-Gm-Features: AZwV_QjhaocZzt9zvw1s3OjTsaGu-bKKM5hwp7iL5KtHWiJWxIiAdfgOpoaXTq0
Message-ID: <CAJaqyWeKGUL3UboZr8WZh8sUKrmKStbN1D6Jnr_Ex=y4hQjpcw@mail.gmail.com>
Subject: Re: [PATCH v11 10/12] vduse: merge tree search logic of IOTLB_GET_FD
 and IOTLB_GET_INFO ioctls
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZTF53-83jRtmEUyRofLMGjIhNCwCsZpuglxNEnJ88mM_1768215374
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 12:56=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jan 09, 2026 at 04:24:28PM +0100, Eugenio P=C3=A9rez wrote:
> > The next patch adds new ioctl with the ASID member per entry.  Abstract
> > these two so it can be build on top easily.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v11: New in v11
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 101 ++++++++++++++++-------------
> >  1 file changed, 55 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 675da1465e0e..bf437816fd7d 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1247,6 +1247,50 @@ static void vduse_vq_update_effective_cpu(struct=
 vduse_virtqueue *vq)
> >       vq->irq_effective_cpu =3D curr_cpu;
> >  }
> >
> > +static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
> > +                              struct vduse_iotlb_entry *entry,
> > +                              struct file **f, uint64_t *capability)
> > +{
> > +     int r =3D -EINVAL;
> > +     struct vhost_iotlb_map *map;
> > +     const struct vdpa_map_file *map_file;
> > +
> > +     if (entry->start > entry->last)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&dev->domain_lock);
> > +     if (!dev->domain)
> > +             goto out;
> > +
> > +     spin_lock(&dev->domain->iotlb_lock);
> > +     map =3D vhost_iotlb_itree_first(dev->domain->iotlb, entry->start,
> > +                                   entry->last);
> > +     if (map) {
> > +             if (f) {
> > +                     map_file =3D (struct vdpa_map_file *)map->opaque;
>
> map_file assigned value when f !=3D NULL here ...
>
> > +                     *f =3D get_file(map_file->file);
> > +             }
> > +             entry->offset =3D map_file->offset;
>
> but dereferenced unconditionally here.
>

Fixing in the next version, thanks!

> > +             entry->start =3D map->start;
> > +             entry->last =3D map->last;
> > +             entry->perm =3D map->perm;
> > +             if (capability) {
> > +                     *capability =3D 0;
> > +
> > +                     if (dev->domain->bounce_map && map->start =3D=3D =
0 &&
> > +                         map->last =3D=3D dev->domain->bounce_size - 1=
)
> > +                             *capability |=3D VDUSE_IOVA_CAP_UMEM;
> > +             }
> > +
> > +             r =3D 0;
> > +     }
> > +     spin_unlock(&dev->domain->iotlb_lock);
> > +
> > +out:
> > +     mutex_unlock(&dev->domain_lock);
> > +     return r;
> > +}
> > +
> >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >                           unsigned long arg)
> >  {
>

