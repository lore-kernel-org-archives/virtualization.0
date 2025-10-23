Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0762FC866
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209982; cv=none; b=oeckozEqnCIgFnGqw23ZbqiCwxDdXhvn4Xj+0nvTfBDHm3oWqtyGFrldZb6hDr4gvP+gjNEBPsTGq2V3MioFw1TjMau4F1k5mxUj6g6FI+7eNFa7TSTz63MeAu1fibgNpP3NpN0/RTKCpf3WsILlTvyGG4FAd7aR1O/EoCh/zmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209982; c=relaxed/simple;
	bh=1yh7dz9RMEY07pnAV8bIXHBaBIdaX34BtyPuiHNKE4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCW1nfMo3yYCrPYP64jT8fvwwu6PZc7HWL+Zj4cUSzsiyvlLy+muzHeTbODBEZBDX5azU4YicISTlSuAtaXMCpZlYZFVh1OJuqzo8LKo4WsNdutebuaav/4Rehmnokn6nL38K04qkortHOzOQXf+PdsK9gOpuxPNTs9ig7XSX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWd75QX0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWd75QX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761209979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSotLUDJ8zQ7Y8qeJ4UDmz0iyr64rlT9tToeWdRyEWE=;
	b=eWd75QX0V61fUhQpT0I8RndcWHaWhU/iBSD3y7iclwtnalUovd7PWOyvs0sj2XxK4kbcZR
	h39oFoY8v4JgKLu24CowZYPIQ6CU3qFyOdUpyBvt66P9HvjM9HSxQBOH3mqKq9t2/W5Tqx
	7dUGStjFRIM7zgCPTL4yfUHH/OUjTsg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-z4wpgTjbNPCH1OPIivdVfg-1; Thu, 23 Oct 2025 04:59:38 -0400
X-MC-Unique: z4wpgTjbNPCH1OPIivdVfg-1
X-Mimecast-MFC-AGG-ID: z4wpgTjbNPCH1OPIivdVfg_1761209978
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7849f67aa1cso6680157b3.1
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209978; x=1761814778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSotLUDJ8zQ7Y8qeJ4UDmz0iyr64rlT9tToeWdRyEWE=;
        b=qTz0ARGKc6H3ZgZYuQ+ESB2nhRZ7o55t+8iNqI9Wx5iI7Obml5kuOofUHfN4ncmvnC
         vhGAMm00Xa029uieQEjGkD3kxruUgxVqRxddRBbce0ERWjRBzE17vXJuHPOsUQhCaepH
         kF3JZ3ZV/LlLAbv8wZDC5HrPmw5n0RhKv/x25mb4nTRAc8MJPzHOvNpB2gOQGVxcgI6D
         9a1asNvY4Ext6rf8hFkGV5Bnt8+2EDm/rhqyDy1Hu25rC55T+zUiVqNHYtHPYCjxke27
         J3Kmmf04wvxuF2nmTIoNLOZRY9gt8JRbJwtwXVkkZJ6AaOT8sJeu2LBoOJfZiTM6JRxZ
         6iHg==
X-Forwarded-Encrypted: i=1; AJvYcCWzA/plMnS0NcPjWCAEtUui3SUzRTc0XG3nwE0MnVba/OOQwhE9TX7hTslT/RSXvhlgsLLL1tSNZmfa4FeH7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0bIJENpqYLhF+3KZpUePoc1LR4sXY2zIEnWEZFpd72gj1X0oV
	1g1y2crfHAhcg2C9S03BhbXyKqbshSV/bRavdMOQt3eSGhTFntnp5LxWoZxvmixAwu2vRI7NK4U
	AUuP6VWrzeOg5x9QsyjUijmMKepYmCOJ8zDU8atiRnL8kHRVo6WoMqO4dkk2s+THKHA9/tEIb5o
	Uw0Afmn5faf6Q0rNP9od//+9F55qnaFeijLsWHfgOEKvI=
X-Gm-Gg: ASbGncvVn/e1BIGdVIpwkjL6KLklqV4YFJlvAqREqv6z0VcxQq0gOU/GoPX9KfwZoAS
	Ljvd25TMKbu34Pwzngu5i0FN9qHBWhUXxS5RsjEJ7PnlI4hAOreBSTnudnNj/zW8gcuTdJAas8l
	zusgd7T1K+bHv2PR9q+Ng0YceEh4GshjN/ytQpc1nE/9Bi6V5+MOAvmWVsbktVRBHZfwAoDh+3H
	qFko8DEhMnLBvnnrUut1Ji/kN1FKI3l/FXGQnvmXh4=
X-Received: by 2002:a53:e03a:0:b0:63c:f0a0:d2b3 with SMTP id 956f58d0204a3-63e16191c9bmr14720514d50.32.1761209977677;
        Thu, 23 Oct 2025 01:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0wNsY0SpvLnxlePtE50ekByNXXN+BJMJDYzluYqiIyg9NsgvCz9tfdqcONap/vZPf8NLrMzM1lW1oyL54W3A=
X-Received: by 2002:a53:e03a:0:b0:63c:f0a0:d2b3 with SMTP id
 956f58d0204a3-63e16191c9bmr14720497d50.32.1761209977337; Thu, 23 Oct 2025
 01:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-2-eperezma@redhat.com>
 <20251010081923-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251010081923-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 23 Oct 2025 10:59:01 +0200
X-Gm-Features: AS18NWDXz0Atkh7F9Php1dpfKRFwMMy-_YZuCG3P0gsh7Sj928Na5Lf7nD8kKCs
Message-ID: <CAJaqyWeeJVM6VeYp4HUEe0ZZAi26Jgqw8WaEg6POoGcUOkk6Qw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] vduse: make domain_lock an rwlock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bVfO9WEwzBmehjWJbk_neDrjUL4fTYTEWhAfGblNlc8_1761209978
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 2:34=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>

...

>
>
> > @@ -2045,11 +2046,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> >       if (ret)
> >               return ret;
> >
> > -     mutex_lock(&dev->domain_lock);
> > +     write_lock(&dev->domain_lock);
> >       if (!dev->domain)
> >               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> >                                                 dev->bounce_size);
> > -     mutex_unlock(&dev->domain_lock);
> > +     write_unlock(&dev->domain_lock);
> >       if (!dev->domain) {
> >               put_device(&dev->vdev->vdpa.dev);
> >               return -ENOMEM;
>
>
> Let's look at this example:
>
> So now you are invoking this under an rw lock:
>
>
>
>
> struct vduse_iova_domain *
> vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
> {
>         struct vduse_iova_domain *domain;
>         struct file *file;
>         struct vduse_bounce_map *map;
>         unsigned long pfn, bounce_pfns;
>         int ret;
>
>         bounce_pfns =3D PAGE_ALIGN(bounce_size) >> BOUNCE_MAP_SHIFT;
>         if (iova_limit <=3D bounce_size)
>                 return NULL;
>
>         domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
>         if (!domain)
>                 return NULL;
>
>
> ...
>
>
>
> Which unless I am mistaken will produce a lockdep splat and deadlock.
>

Can you expand on this? All that code works with and without lockdep.

>
> So it looks like the previous version did not compile
> and this one looks DOA.  What's up?
>

In case it is useful, I forgot to enable some vendor vdpa drivers of
HW I don't have, and that was the reason why it didn't compile. But I
didn't send it without testing it of course.

> At this stage please include information about configs you
> tested, and how.
>
> And any locking changes should also be tested with lockdep enabled
> please.
>

This is the text I'm planning to include in the next series, please
let me know if you want me to expand:

Tested by creating a VDUSE device OVS with and without MQ, and live
migrating between two hosts back and forth while maintaining ping
alive in all the stages. All tested with and without lockdep.

