Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A2329E76
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210056; cv=none; b=CBmQWPyU4+mzb8DLMq4yErZEZZA3iHUxu4w7Y1CuFD5JaYvPsfzenb/Nccgt80VQf51uMUpoHtBtlVTz9ICPE3zl/j972YpCV7fxwjfVcgv+lUOcn3EDjH3OkN+ah+26qQouuG2i1oKfFbqXUjwa66FrdF+kNwYUwKI+CTMaa3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210056; c=relaxed/simple;
	bh=9Y/o4BFWRX+MFK3cxBtFHx8aWH4WzUPjC2atua8kZ7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjKd/VKBP5yEiMoit2yIwsuZStJv8tjcaqJVb7T3aBFwSN54JGV1zhPLFFSAEUhGBs+oVyKvxOoObkXFzyy8xqTWjjo+xopILp2D/Ph/c7zha99YTyAMBWUrJ+SFvyIb8ml8lP1PS0pVW0TMwvjNzGRYvSCNfHjeFzZYqhw+Luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X06Hl+K/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X06Hl+K/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768210053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joUA+NIycoHmA9pJswCQKYFsSC0TOGJ+MjRJBe9+5Qw=;
	b=X06Hl+K/jM0xMJTehkAc4f3SgJzi+7JXTD2xBmeEvEfWQ2nYn07cf2SpqDcJm743OhpKst
	xOzAAHCaDsppKQF/1k9F2dkZmK/ILCf3EKReuxX/qVOKWcn9Z+kntQZkYFRJJ2wrw0FGPq
	DXRtO3yo32uFGVILH1jPffPz/cnj1k8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-PU-Fw985PvS5s4vmHKJ6lg-1; Mon, 12 Jan 2026 04:27:32 -0500
X-MC-Unique: PU-Fw985PvS5s4vmHKJ6lg-1
X-Mimecast-MFC-AGG-ID: PU-Fw985PvS5s4vmHKJ6lg_1768210051
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78fb85eddf1so82335037b3.3
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 01:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210051; x=1768814851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=joUA+NIycoHmA9pJswCQKYFsSC0TOGJ+MjRJBe9+5Qw=;
        b=wvhxWZDd1u7aizl3czNtZ4jTzqWa/lXfwiRBwkVnKsYkrejzYPyZpckuRja4ZwX6h3
         dkIgQ4krhQjKrN7CspNAxYkeydUV+dtXoPaWPPbDQ4pjjogBlHoHL9GM9BCRtYkE7Vqa
         3rU3Gg6UqZU9x0mkxByx/Jq9ibTsxJ7KCIVIg+b1qtz9zFdalBrpn9iFgkYdXJgAH6PI
         feqWjZiGf4H4sqezQ+2Ow7zdPTL08ckWKNY8xfV1asCL5Okod7oMPgXEtrEWr198uy7/
         eQtQvxOILKUVhR0EIPUm1qogQl/lOuGHyLyy0gadODw5TH7SiG3JKjMPWpin+QLP/v+I
         bTdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiM5DmPPuaY2DcbiBHta7ayGbzMGjChvr4KQUk9gkStDxgbViNoW7Dpq0tCP/G1XUdknGYV8Cy1rK1fUT3jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoqLMwY1x0LxoQUISCa1EZdJXzJnsFSDiV3K+0e4ZiS6on1okW
	7gwlDfUeAopPPQ1q0jFzPOrn7oaPhYv+w6Yrnttp3lOtW0D56dWRx361mJ1PaWH4CcdaSb2eMAv
	0UcCWK2m7uAxvYp4gRyHtrglOxzScimpjwXXy62KpTjpGdY4O2BoF9OdunDdSZRy/i8xiG2Ag3i
	sOywrDlk6mUcJUZ6pVVSyyoLEEwlAGvQ+8xzrf266OYxs=
X-Gm-Gg: AY/fxX644uV3G1i+Z8lQhc3T3l8CqGNa67yQ0Ux/l7t1CPfp/9xQHB7lbdw79sydixv
	tFCiGQElTnUBvjLw8G4YU9XIQGZv3uBi9YeONf35Pap8ve6ZmKrta6SJB8tTm/zbyb04h+57eaB
	7MRt2rFIugM3e+PI1yGnF7YiugQHpQ9Ko7wVi9jn8r+ZAxmVV+oQxlntE1YeZMzXa0VQ==
X-Received: by 2002:a05:690c:d09:b0:78c:5bb4:1d4c with SMTP id 00721157ae682-790b5800025mr325092407b3.39.1768210051492;
        Mon, 12 Jan 2026 01:27:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgnkAFchPEYFhM6wE1IpjTF+Se0KVO9jBwe7csQ8qFksXKc63H7XZrkTnZhVkqUK7G8bRnf7szSob4Lv2KfBE=
X-Received: by 2002:a05:690c:d09:b0:78c:5bb4:1d4c with SMTP id
 00721157ae682-790b5800025mr325092247b3.39.1768210051160; Mon, 12 Jan 2026
 01:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-10-eperezma@redhat.com>
 <20260110185006-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260110185006-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 12 Jan 2026 10:26:54 +0100
X-Gm-Features: AZwV_Qg6cZNN3EX3jEjlnxsCl1uPK4REsbSDBDE6dCHSkp2m5R9PcQebYkOO_30
Message-ID: <CAJaqyWePwTftOkoycpcKreAAbentzt0oEdRwNUzq0DbF46y+Xw@mail.gmail.com>
Subject: Re: [PATCH v11 09/12] vduse: take out allocations from vduse_dev_alloc_coherent
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jlUy73-UeAAcbDEiC59o8SVen0Oy7GGfNd_xRuqd8uU_1768210051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 12:54=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jan 09, 2026 at 04:24:27PM +0100, Eugenio P=C3=A9rez wrote:
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 82ee476d45e0..675da1465e0e 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -923,16 +923,24 @@ static void *vduse_dev_alloc_coherent(union virti=
o_map token, size_t size,
> >       if (!token.group)
> >               return NULL;
> >
> > +     addr =3D alloc_pages_exact(size, flag);
> > +     if (!addr)
> > +             return NULL;
> > +
>
> So addr has allocated pages here ...
>
>
> >       vdev =3D token.group->dev;
> >       domain =3D vdev->domain;
> >       addr =3D vduse_domain_alloc_coherent(domain, size,
> > -                                        (dma_addr_t *)&iova, flag);
> > +                                        (dma_addr_t *)&iova, addr);
>
> and then is overwritten here ...
>
> >       if (!addr)
> > -             return NULL;
> > +             goto err;
>
> except on error where we go to err ...
>
> >
> >       *dma_addr =3D (dma_addr_t)iova;
> >
> >       return addr;
> > +
> > +err:
> > +     free_pages_exact(addr, size);
>
> only to try and free NULL. will leak the original pages, will it not.
>

Right, I missed that in the conversion. I'll change the function
vduse_domain_alloc_coherent so it returns dma_addr instead of orig,
making all the code simpler. Thanks!

> > +     return NULL;
> >  }
> >
> >  static void vduse_dev_free_coherent(union virtio_map token, size_t siz=
e,
>

