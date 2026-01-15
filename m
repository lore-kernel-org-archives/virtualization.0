Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA022EAB72
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466657; cv=none; b=r1YIMYgI7rMGgYklHBdPluxDj0kEtKBbumOnhiGbKCBKQY7JZbgtCOjkEkJFBT1PotkuTJQbyqcmQ6Bi7y84vlDsj+GAdeZkxSSXel70/yJCoEx1nDQmV13W+NZo87Vt832QOSkW3w7rvNPnCmL9a7KeARh+zfQzTGjCrlWILzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466657; c=relaxed/simple;
	bh=qztr4yN9cDU2fYa+YAsxuBk5uaNmtfnLDjdgd2TKv5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mccqM+hHQg/F5onwdtKphX80HG83a3HVmDYvcDdW9j9U/Itpe01flIk74jUdXGbU4r63bgZR3c/+9SIO0Xby4Ef7Vq1agifob5zSUPOgIyC3Rv2VVKO9g7o/xd0Tym1y9y3KGHy8GN5HJnRnyNlDjGTmKMp2Hhbun9Pbo+RygGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5we6ePK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5we6ePK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768466655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bvAtymdtyG51JQ1U1ePnSZyVkW4snaVL8Aa76RL2IA=;
	b=Y5we6ePK7f1jn5TJ+XFS/UBqgu6eaoKXslqgfYGePd6a84BmJzhG1JcMGjCF19y/uV4cGu
	gG9ytLUjbniVZxo66gQY0L9rqPBqOqWVztN3Auz+I0z/VfWdQWYhKWtbalZ6VO68K0PVCE
	AYzEUvIPlHVyw8i9T6jm6xVEbOtUIVY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-pDWR6V43NESiIE24VEgIhw-1; Thu, 15 Jan 2026 03:44:13 -0500
X-MC-Unique: pDWR6V43NESiIE24VEgIhw-1
X-Mimecast-MFC-AGG-ID: pDWR6V43NESiIE24VEgIhw_1768466652
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43102ac1da8so572966f8f.2
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 00:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466652; x=1769071452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bvAtymdtyG51JQ1U1ePnSZyVkW4snaVL8Aa76RL2IA=;
        b=nefxryBbtl808D6a5/7j/KuCoLYY5xnc0fP458jnDP/6gogHR3mjXlW3jEO6sXAdbT
         6o4CdlR/PoIdpxLSX9gW/lnkoNqAKm9ctZIltzLSMGM26yA2qj7L+zS9ZfgCdfvIQFZn
         aINVVEPTrVscgz8uxydzRLSs/Sz0P67NDbI+RTWveNnvpec1n6zucexPcjw8IuVde5rS
         JVw1hm1YF5FKjoYf75BZ/vUQUyI3cNQ4ip126NovsoaVkwyLTyKJZfG1K5r3nDqdg/cN
         gGdKWSuz1oBoHNgfz8QmgiVvarp0miJHRT0dA3Ivp3HDCvoRdsCP/QUHHV0jKPxb6l5C
         c3dg==
X-Forwarded-Encrypted: i=1; AJvYcCUXKQgf1ElKcflDRLjp5TIU5XVzRFQU3K43RoA4rje+5rzDNFzPAEvaao0x+uKVSQQEdTT53EyZJZL4JE3fLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2ujd12i/tP9S2PhUBa42QAD8XK31qc4Q2l6D5jNIw+5lGBujJ
	8egl6nHvpSDNXJpdIAGBTRUMSFID3Y5r1vj/tjGZKjzPUuL7RVsiWIjArUfP8VaR7jUxhFpKYxQ
	mb+KIGNJ1XPcfQ49bRWfS+BOXE0dndZkmeWIPBji9U2X/AUr99kFoQAjZ76T9ZfnVIqsS
X-Gm-Gg: AY/fxX5lN5FcRt2AUor/fnqSeeZHxinLIy9MjkvTCxuJLXguusnDsTq52n8kEPp7CYU
	fLLbkeAAnJK87aRfx1zm9rB/2xZgx6MzptxtlPhi4TUTb8nqbhKSbco9rcadVP5CEdM36JbkZd+
	jAFTK/p8vMu9S+TiBMVy/uhkbaqnK4vYVHnPqfysVN+/8+JxlkTK/CVyfmRm6FbqWvYsLuoRQzO
	nwjhfHgigLgjQ/DczT++xTnQEGcz1M3WQq5Lyd9WFFX3rKD5UyuZOwLoqr5iQqnFXzJk2gh0x+G
	iy7H/Ub3tWJzb2W9MlXpprb1P++U80RoB0hRAk/1yW8j+kohiKK1mT36OT0XUwpoWlOM2VicmwB
	rzvVshGvdqW6Y7dL6/RhVoKbAFvFOPw==
X-Received: by 2002:a5d:5885:0:b0:430:fdb8:8516 with SMTP id ffacd0b85a97d-4342c54ad96mr6607902f8f.35.1768466652253;
        Thu, 15 Jan 2026 00:44:12 -0800 (PST)
X-Received: by 2002:a5d:5885:0:b0:430:fdb8:8516 with SMTP id ffacd0b85a97d-4342c54ad96mr6607865f8f.35.1768466651778;
        Thu, 15 Jan 2026 00:44:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6535ddsm4460853f8f.15.2026.01.15.00.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:44:11 -0800 (PST)
Date: Thu, 15 Jan 2026 03:44:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v12 09/13] vduse: take out allocations from
 vduse_dev_alloc_coherent
Message-ID: <20260115034348-mutt-send-email-mst@kernel.org>
References: <20260114184839.926884-1-eperezma@redhat.com>
 <20260114184839.926884-10-eperezma@redhat.com>
 <CACGkMEuMsz8ao0btTixZ=Lh7GadyxdOtu4HQeF=c7=TTirmV+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuMsz8ao0btTixZ=Lh7GadyxdOtu4HQeF=c7=TTirmV+A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rVWZZgZQ2XY8qwGC_XrieiJHWzMgyMQB6uS_Z2qbwNM_1768466652
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 15, 2026 at 04:22:49PM +0800, Jason Wang wrote:
> On Thu, Jan 15, 2026 at 2:49 AM Eugenio Pérez <eperezma@redhat.com> wrote:
> >
> > The function vduse_dev_alloc_coherent will be called under rwlock in
> > next patches.  Make it out of the lock to avoid increasing its fail
> > rate.
> >
> > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > ---
> > v12:
> > * Avoid free_pages_exact(NULL, size) in case vduse_domain_alloc_coherent
> >   fails (MST).
> >
> > v11: Remove duplicated call to free_pages_exact (Jason).
> > ---
> >  drivers/vdpa/vdpa_user/iova_domain.c | 24 +++++++-----------------
> >  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++---
> >  drivers/vdpa/vdpa_user/vduse_dev.c   | 17 +++++++++++------
> >  3 files changed, 20 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> > index 309cd5a039d1..0a9f668467a8 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -493,17 +493,15 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
> >         vduse_domain_free_iova(iovad, dma_addr, size);
> >  }
> >
> > -void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> > -                                 size_t size, dma_addr_t *dma_addr,
> > -                                 gfp_t flag)
> > +dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> > +                                      size_t size, void *orig)
> >  {
> >         struct iova_domain *iovad = &domain->consistent_iovad;
> >         unsigned long limit = domain->iova_limit;
> >         dma_addr_t iova = vduse_domain_alloc_iova(iovad, size, limit);
> > -       void *orig = alloc_pages_exact(size, flag);
> >
> > -       if (!iova || !orig)
> > -               goto err;
> > +       if (!iova)
> > +               return DMA_MAPPING_ERROR;
> >
> >         spin_lock(&domain->iotlb_lock);
> >         if (vduse_iotlb_add_range(domain, (u64)iova, (u64)iova + size - 1,
> > @@ -514,17 +512,12 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> >         }
> >         spin_unlock(&domain->iotlb_lock);
> >
> > -       *dma_addr = iova;
> > +       return iova;
> >
> > -       return orig;
> >  err:
> > -       *dma_addr = DMA_MAPPING_ERROR;
> > -       if (orig)
> > -               free_pages_exact(orig, size);
> > -       if (iova)
> > -               vduse_domain_free_iova(iovad, iova, size);
> > +       vduse_domain_free_iova(iovad, iova, size);
> >
> > -       return NULL;
> > +       return DMA_MAPPING_ERROR;
> >  }
> >
> >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
> > @@ -533,7 +526,6 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
> >         struct iova_domain *iovad = &domain->consistent_iovad;
> >         struct vhost_iotlb_map *map;
> >         struct vdpa_map_file *map_file;
> > -       phys_addr_t pa;
> >
> >         spin_lock(&domain->iotlb_lock);
> >         map = vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
> > @@ -545,12 +537,10 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
> >         map_file = (struct vdpa_map_file *)map->opaque;
> >         fput(map_file->file);
> >         kfree(map_file);
> > -       pa = map->addr;
> >         vhost_iotlb_map_free(domain->iotlb, map);
> >         spin_unlock(&domain->iotlb_lock);
> >
> >         vduse_domain_free_iova(iovad, dma_addr, size);
> > -       free_pages_exact(phys_to_virt(pa), size);
> >  }
> >
> >  static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
> > index 081f06c52cdc..e50e55d1396f 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > @@ -65,9 +65,8 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
> >                              dma_addr_t dma_addr, size_t size,
> >                              enum dma_data_direction dir, unsigned long attrs);
> >
> > -void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> > -                                 size_t size, dma_addr_t *dma_addr,
> > -                                 gfp_t flag);
> > +dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> > +                                      size_t size, void *orig);
> >
> >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
> >                                 dma_addr_t dma_addr, unsigned long attrs);
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 0e3cf5128ad0..6dba1f3224d9 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -916,23 +916,27 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
> >  {
> >         struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> > -       unsigned long iova;
> >         void *addr;
> >
> >         *dma_addr = DMA_MAPPING_ERROR;
> >         if (!token.group)
> >                 return NULL;
> >
> > -       vdev = token.group->dev;
> > -       domain = vdev->domain;
> > -       addr = vduse_domain_alloc_coherent(domain, size,
> > -                                          (dma_addr_t *)&iova, flag);
> > +       addr = alloc_pages_exact(size, flag);
> >         if (!addr)
> >                 return NULL;
> >
> > -       *dma_addr = (dma_addr_t)iova;
> > +       vdev = token.group->dev;
> > +       domain = vdev->domain;
> > +       *dma_addr = vduse_domain_alloc_coherent(domain, size, addr);
> > +       if (*dma_addr == DMA_MAPPING_ERROR)
> > +               goto err;
> >
> >         return addr;
> > +
> > +err:
> > +       free_pages_exact(addr, size);
> > +       return NULL;
> >  }
> 
> I think the code tries to hide the iova domain specific things (e.g
> mappings and DMA_MAPPING_ERROR) from vduse core. Could we find a way
> to stick to that?
> 
> Thanks


what do you suggest more spefically though?

> >
> >  static void vduse_dev_free_coherent(union virtio_map token, size_t size,
> > @@ -949,6 +953,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
> >         domain = vdev->domain;
> >
> >         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> > +       free_pages_exact(vaddr, size);
> >  }
> >
> >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
> > --
> > 2.52.0
> >

