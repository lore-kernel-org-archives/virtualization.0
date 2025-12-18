Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163332E136
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047252; cv=none; b=mS5V0wgiD0Mjnt36dsT8bkvywqO1aUB31/hs6pIKwxor6MRJPsVr84LFgbYzmIdNa7eyoEZ7zoQiroe9cBq1NmSDHgTUPLwtKiDsSdA+EeDZosC3MlbUZRIHOeVIYxK2Q9qc4oAVeuyar1FhKt6VoPEkPkkvi2UWpeIhj2WzKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047252; c=relaxed/simple;
	bh=T8b8+tAkMooLTVNWwG4+7A9LR5808xj9NzrrZZ/STR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SriP1KXSIL6Lro//d2uf8xcTfrtHDtUVAJGSisGrZZiJcUNNMQ25nS2DE29iW/7LgpA9u1AaqT5zhSOajJoFJrpjgccxEJ3Kq0BosvNeFoJLtnIdNs8XpIE/DwGCDFMtlv3yYaqo6CxWiN3qfWhNPr27xg4lodnTrca7dFThXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TODX5743; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TODX5743"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766047249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGOj/+aXk/dXqz69CdtL1Yy4PX1T3JzRGhVinsH7XCc=;
	b=TODX5743gc4IryXSvO3CR5Zmb9S531WUPFAHio437nzOXb88V4KYg5Uezb8lQixPeG6feI
	R4mhq7L3Ei04tXZFc0TJFdrmHkz/kuL7MSu76hCjkwXeVLBbLgTVXhcO+PEOdW0MkAqsBr
	nsaQ51e9275gxyjklzoNF0wErnOb2xs=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-pQ_JuS2sN8-Fo8URwdy1nA-1; Thu, 18 Dec 2025 03:40:48 -0500
X-MC-Unique: pQ_JuS2sN8-Fo8URwdy1nA-1
X-Mimecast-MFC-AGG-ID: pQ_JuS2sN8-Fo8URwdy1nA_1766047248
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-645535ac027so586273d50.0
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 00:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766047248; x=1766652048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGOj/+aXk/dXqz69CdtL1Yy4PX1T3JzRGhVinsH7XCc=;
        b=QAeGqNKU7yiAAJ6YgFttUrOThdhWUmH0/XPzYXMRC3HmxMNDmnABGwLcdiC4lcFqHM
         q3IsRelY/4XyokU0ydv/TnW6W9A1KXPT3siiMdZ2dSk1RKzfhseuAswVlMcMI5A+lWqf
         YDaB/2fqZL2O1YCX46Cx6iTTgzJx2o1nlZk2QV0l1wC9YC+WwUD4CKEjEsvvfCsrUpOR
         ffKDCg5S4E5kndtJMNi8DeJATUYvf0hQxbxlBEA7ASBppHql52xt9KONwQa51jZ8lQ/m
         Flue4cFoPXOuZ8szHCHh05bSIe+nsIlO9TBLqP7mOJYCnD1X7hpaZOpZJJ9SaXX0lckY
         wzGw==
X-Forwarded-Encrypted: i=1; AJvYcCVCN5IFERbwxG7kgo2kl64VpnHloMT2+IF/Hbfl3T87zrve37dxEtxHUd+qFAlIPQlC5n/Xj7wceRcztSkScw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhFZvYgJMFM/wgNjAlqVsq1q1YT/wS3vI9tsouZJfUmRzWESo3
	amV8RJog/y0GBp881WwNu8zYqqmvrhWAaHfZeIdTPxrEf0Q5VFrR86ilzXPmAxnOCQolYIOz3vB
	Abr/lsJDDFKpiOJehTBTJ9Ob7fMp3jO+jXPXUU8RG76ohosIzBL9ZF++a6Q4l9JuY29Gxhff1PZ
	T4f0aA4HbhMPQhhjCYrAkWJJt4Q9pEhtxlmFlG+6YHpCE=
X-Gm-Gg: AY/fxX6TUDCghKQDatwroy1mONCD74tnkjNWetCyiAljqA218yPkzjbbrNcu95EcLf/
	IKjq1YQK709diPP04zAojXdfcpaa4UzOs1bER4b5uuFQAxI4g5NVujmJwR5JQzMKOPQwzaRVQ05
	JgyHw1hjowB7N/Y+QHPO6/EJTF8fIG0NfZieYLaWi9gfMAZeKsbOdv6CBZGXO8nHhD3Xs=
X-Received: by 2002:a05:690e:11c6:b0:645:5bda:5c45 with SMTP id 956f58d0204a3-6455bda5dd0mr12924900d50.36.1766047247708;
        Thu, 18 Dec 2025 00:40:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfKu1fU4sXtfcGQWPnXpVH7acGZX+fWHBY8C3NiA2Hs07pwyv0BE/pml8tUzZ3mNywpK5hvo/KzV8ktKzTc14=
X-Received: by 2002:a05:690e:11c6:b0:645:5bda:5c45 with SMTP id
 956f58d0204a3-6455bda5dd0mr12924892d50.36.1766047247374; Thu, 18 Dec 2025
 00:40:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217112414.2374672-1-eperezma@redhat.com> <20251217112414.2374672-7-eperezma@redhat.com>
 <CACGkMEsD9h34yAQxZnOnAGZpnxV2Up7ghxdrsfiWE0VY-OCM6w@mail.gmail.com>
In-Reply-To: <CACGkMEsD9h34yAQxZnOnAGZpnxV2Up7ghxdrsfiWE0VY-OCM6w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 18 Dec 2025 09:40:10 +0100
X-Gm-Features: AQt7F2q6VasrMNR03DupnWpZbDBLEbr7O6zp8Xut0-EVBCcVK5tXxXkG5O5FKYo
Message-ID: <CAJaqyWcCU5vabDVrFTKpyfz3=FQV9hmUpZzH5PuiSPHOjgvWGQ@mail.gmail.com>
Subject: Re: [PATCH v10 6/8] vduse: take out allocations from vduse_dev_alloc_coherent
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5Y7FrGJEygm2XQtrX9e_m2lPPUy6UG_qgoz255HOqSY_1766047248
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 6:45=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > The function vduse_dev_alloc_coherent will be called under rwlock in
> > next patches.  Make it out of the lock to avoid increasing its fail
> > rate.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/iova_domain.c |  7 ++-----
> >  drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
> >  drivers/vdpa/vdpa_user/vduse_dev.c   | 13 +++++++++++--
> >  3 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 309cd5a039d1..0ae52890518c 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -495,14 +495,13 @@ void vduse_domain_unmap_page(struct vduse_iova_do=
main *domain,
> >
> >  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> >                                   size_t size, dma_addr_t *dma_addr,
> > -                                 gfp_t flag)
> > +                                 void *orig)
> >  {
> >         struct iova_domain *iovad =3D &domain->consistent_iovad;
> >         unsigned long limit =3D domain->iova_limit;
> >         dma_addr_t iova =3D vduse_domain_alloc_iova(iovad, size, limit)=
;
> > -       void *orig =3D alloc_pages_exact(size, flag);
> >
> > -       if (!iova || !orig)
> > +       if (!iova)
> >                 goto err;
> >
> >         spin_lock(&domain->iotlb_lock);
> > @@ -519,8 +518,6 @@ void *vduse_domain_alloc_coherent(struct vduse_iova=
_domain *domain,
> >         return orig;
> >  err:
> >         *dma_addr =3D DMA_MAPPING_ERROR;
> > -       if (orig)
> > -               free_pages_exact(orig, size);
> >         if (iova)
> >                 vduse_domain_free_iova(iovad, iova, size);
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_u=
ser/iova_domain.h
> > index 42090cd1a622..86b7c7eadfd0 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > @@ -69,7 +69,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain=
 *domain,
> >
> >  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> >                                   size_t size, dma_addr_t *dma_addr,
> > -                                 gfp_t flag);
> > +                                 void *orig);
> >
> >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size=
_t size,
> >                                 dma_addr_t dma_addr, unsigned long attr=
s);
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index a278cff7a4fa..767abcb7e375 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -924,16 +924,24 @@ static void *vduse_dev_alloc_coherent(union virti=
o_map token, size_t size,
> >         if (!token.group)
> >                 return NULL;
> >
> > +       addr =3D alloc_pages_exact(size, flag);
> > +       if (!addr)
> > +               return NULL;
> > +
> >         vdev =3D token.group->dev;
> >         domain =3D vdev->domain;
> >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > -                                          (dma_addr_t *)&iova, flag);
> > +                                          (dma_addr_t *)&iova, addr);
> >         if (!addr)
> > -               return NULL;
> > +               goto err;
> >
> >         *dma_addr =3D (dma_addr_t)iova;
> >
> >         return addr;
> > +
> > +err:
> > +       free_pages_exact(addr, size);
> > +       return NULL;
> >  }
> >
> >  static void vduse_dev_free_coherent(union virtio_map token, size_t siz=
e,
> > @@ -950,6 +958,7 @@ static void vduse_dev_free_coherent(union virtio_ma=
p token, size_t size,
> >         domain =3D vdev->domain;
> >
> >         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> > +       free_pages_exact(vaddr, size);
>
> There looks like a double-free as there's another free_page_exact() in
> vduse_domain_free_coherent.
>

You're right, removing the duplicated one. Thanks!

