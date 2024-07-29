Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250B7E1
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233153; cv=none; b=uMBsa3JdtrdXQiR56fdmxFNex96b6TfPUMGuox3PyrsTkEFMq85KagthxXX5hTsy2VD9yU/XVK/qcxDd/tVj1bTwk+b4DuVOlCKagLLIPzCsngbT0y/j/pcvRGKa+x1SAsZi4tgAvLhrpCxpGsHic0F4sdUAydMml0FFpOdkqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233153; c=relaxed/simple;
	bh=jiTzv8gRgGpp3NZNmEDT+uK7ips7GKPiBDsoF41jvNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYx7rxGQpyrvYFrq6duD8WhfX9u8Op2iDyFtqZ8bLIzf+v24czJesXrg14QZ0wDbQMflZGdUHzsxxEAZJj5Esab/w+ihfXtf8Cz/bDSMeAVV4nlh4ySOTIDl5oQ0ylV2OvFxl4+BrsV1PilONTDn/7nbFm2rLY2R9P2CmW07/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+EBVEWi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+EBVEWi"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cf93dc11c6so947478a91.1
        for <virtualization@lists.linux.dev>; Sun, 28 Jul 2024 23:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722233151; x=1722837951; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT3+lq1z1ZjHF+rQzFZqGRDbKroE3rXEn1/7JfMa1Lw=;
        b=A+EBVEWi/McSLr4VpuzSCgw9hOwut3X8V+R4phiEUlu5k3OYXSm7OBX+Sv8d3rJziQ
         2sb58IztrJOIGxFr1lFI89cCvdFLLKANmElW2c+8TrA2RkUEyfUpGgK9kQW4HkPENu1f
         Ujg+9RNMlXhCUDxGmI+cKpWPKYg/JJIyjzti+oujez/xYKjS5v+urocxEgI/GUrEY7TP
         gHWBjbEC/dib2uUG45spfptCk2QCaqgGO2b6YO7trxCeel8Is9QmUUEW8NLUGMqHKpk+
         SCHuaUWqHcs9mdXk2hFCC1+RUFbEGuVVjMAtUxVyRYL2LIp8kYz/1m8TmDtn/DSx4BVe
         0s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722233151; x=1722837951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT3+lq1z1ZjHF+rQzFZqGRDbKroE3rXEn1/7JfMa1Lw=;
        b=q0aK+NdyCoCJmjC26uXsZVESJPgu8NuSRApBB9BmlW+n60chbiyUsrLlcdxoLyqpoy
         9jgJWQnDPxOdfOitb6bxj2c6OdTF3rXBDVJJsXeVUzTYCXEyb9RPQRSz8Wrx5tn7jsEL
         KTiQuiaDS9HHSpETqv47bHte4lMylXWbLP1xiXY4BKvgSjAwUx3kSP6b9rA2TXycBXyj
         a/lLAZAXEw1am8rckIEA2GR8PR9KsGoPQUILWJKpQyC2NtI1BFUpQiqHphsmTbeqOsfo
         MXZFM405962KlpBCVh4xIytWHcm+ptmDiF7FMnOk8hGIFdVpveD/oQR5H2M2Q39/6c9W
         w6lg==
X-Forwarded-Encrypted: i=1; AJvYcCX+YjUAJ44DOTVMne5SjnwynRtYvVUgH0OEgU0NRU0w9+vB9+PHFXyJXY4mDqsiwwYKQlveR74RE3wJA1rv1F3QpRL5M5smCC+8hQDeIMM=
X-Gm-Message-State: AOJu0YxMkGJjzV9HWa64OiK4cfXAM5Trf6QHn024o09MoRll5rNcpvvQ
	LQDC6JgxAeiX6oaXyOaB2YkoMHyVp31r7V92uB9WB0SxKncIQHI2
X-Google-Smtp-Source: AGHT+IEdEQUKUD1f/Ydw97yQv/cLZoGHfR7AP2bCzE4mGmm+B40OT2kvmDxGJpFvjolmsy7BX38Y3Q==
X-Received: by 2002:a17:90a:ae17:b0:2cf:28c1:4cc2 with SMTP id 98e67ed59e1d1-2cf7e1ac75cmr8202569a91.3.1722233150582;
        Sun, 28 Jul 2024 23:05:50 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb75de01dsm9612607a91.36.2024.07.28.23.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 23:05:50 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: jasowang@redhat.com
Cc: 21cnbao@gmail.com,
	42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	cl@linux.com,
	eperezma@redhat.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	linux-mm@kvack.org,
	lstoakes@gmail.com,
	maxime.coquelin@redhat.com,
	mhocko@suse.com,
	mst@redhat.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH RFC 1/5] vpda: try to fix the potential crash due to misusing __GFP_NOFAIL
Date: Mon, 29 Jul 2024 18:05:29 +1200
Message-Id: <20240729060529.93243-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEs49KckODWSpe7VPfTeshogni0_eOdkMO0b7zW2A5YX2w@mail.gmail.com>
References: <CACGkMEs49KckODWSpe7VPfTeshogni0_eOdkMO0b7zW2A5YX2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Jul 29, 2024 at 3:42 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jul 25, 2024 at 3:00 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Thu, Jul 25, 2024 at 6:08 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 25-07-24 10:50:45, Barry Song wrote:
> > > > On Thu, Jul 25, 2024 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Wed 24-07-24 20:55:40, Barry Song wrote:
> > > [...]
> > > > > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > index 791d38d6284c..eff700e5f7a2 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > > > > @@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
> > > > > >  {
> > > > > >       struct vduse_bounce_map *map;
> > > > > >       unsigned long i, count;
> > > > > > +     struct page **pages = NULL;
> > > > > >
> > > > > >       write_lock(&domain->bounce_lock);
> > > > > >       if (!domain->user_bounce_pages)
> > > > > >               goto out;
> > > > > > -
> > > > > >       count = domain->bounce_size >> PAGE_SHIFT;
> > > > > > +     write_unlock(&domain->bounce_lock);
> > > > > > +
> > > > > > +     pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL);
> > > > > > +     for (i = 0; i < count; i++)
> > > > > > +             pages[i] = alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> > > > >
> > > > > AFAICS vduse_domain_release calls this function with
> > > > > spin_lock(&domain->iotlb_lock) so dropping &domain->bounce_lock is not
> > > > > sufficient.
> > > >
> > > > yes. this is true:
> > > >
> > > > static int vduse_domain_release(struct inode *inode, struct file *file)
> > > > {
> > > >         struct vduse_iova_domain *domain = file->private_data;
> > > >
> > > >         spin_lock(&domain->iotlb_lock);
> > > >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > > >         vduse_domain_remove_user_bounce_pages(domain);
> > > >         vduse_domain_free_kernel_bounce_pages(domain);
> > > >         spin_unlock(&domain->iotlb_lock);
> > > >         put_iova_domain(&domain->stream_iovad);
> > > >         put_iova_domain(&domain->consistent_iovad);
> > > >         vhost_iotlb_free(domain->iotlb);
> > > >         vfree(domain->bounce_maps);
> > > >         kfree(domain);
> > > >
> > > >         return 0;
> > > > }
> > > >
> > > > This is quite a pain. I admit I don't have knowledge of this driver, and I don't
> > > > think it's safe to release two locks and then reacquire them. The situation is
> > > > rather complex. Therefore, I would prefer if the VDPA maintainers could
> > > > take the lead in implementing a proper fix.
> > >
> > > Would it be possible to move all that work to a deferred context?
> >
> > My understanding is that we need to be aware of both the iotlb_lock and
> > bounce_lock to implement the correct changes. As long as we still need
> > to acquire these two locks in a deferred context, there doesn't seem to
> > be any difference.
> >
> > I can do the memory pre-allocation before spin_lock(&domain->iotlb_lock),
> > but I have no knowledge whether the "count" will change after I make
> > the preallocation.
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c
> > b/drivers/vdpa/vdpa_user/iova_domain.c
> > index 791d38d6284c..7ec87ef33d42 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -544,9 +544,12 @@ static int vduse_domain_release(struct inode
> > *inode, struct file *file)
> >  {
> >         struct vduse_iova_domain *domain = file->private_data;
> >
> > +      struct page **pages;
> > +      spin_lock(&domain->iotlb_lock); maybe also + bounce_lock?
> > +      count = domain->bounce_size >> PAGE_SHIFT;
> > +      spin_unlock(&domain->iotlb_lock);
>
> We probably don't need any lock here as bounce_size won't be changed .
>
> > +
> > +       preallocate_count_pages(pages, count);
> > +
> > ....
> >         spin_lock(&domain->iotlb_lock);
> >         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> > -       vduse_domain_remove_user_bounce_pages(domain);
> > +       vduse_domain_remove_user_bounce_pages(domain, pages);
> >         vduse_domain_free_kernel_bounce_pages(domain);
> >         spin_unlock(&domain->iotlb_lock);
> >         put_iova_domain(&domain->stream_iovad);
>
> This seems to work.

Thanks, Jason. I personally have no knowledge of vDPA. Could you please help
review and test the patch below?

From 1f3cae091159bfcaffdb4a999a4a8e37db2eacf1 Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Wed, 24 Jul 2024 20:55:40 +1200
Subject: [PATCH RFC v2] vpda: try to fix the potential crash due to misusing
 __GFP_NOFAIL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
__GFP_NOFAIL without direct reclamation may just result in a busy
loop within non-sleepable contexts.

static inline struct page *
__alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
                                                struct alloc_context *ac)
{
        ...
        /*
         * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
         * we always retry
         */
        if (gfp_mask & __GFP_NOFAIL) {
                /*
                 * All existing users of the __GFP_NOFAIL are blockable, so warn
                 * of any new users that actually require GFP_NOWAIT
                 */
                if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
                        goto fail;
                ...
        }
        ...
fail:
        warn_alloc(gfp_mask, ac->nodemask,
                        "page allocation failure: order:%u", order);
got_pg:
        return page;
}

Let's move the memory allocation out of the atomic context and use
the normal sleepable context to get pages.

[RFC]: This has only been compile-tested; I'd prefer if the VDPA maintainers
handles it.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 21 ++++++++++++++++-----
 drivers/vdpa/vdpa_user/iova_domain.h |  3 ++-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 13 ++++++++++++-
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 791d38d6284c..014809ac2b7c 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -283,7 +283,7 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 	return ret;
 }
 
-void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
+void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain, struct page **pages)
 {
 	struct vduse_bounce_map *map;
 	unsigned long i, count;
@@ -294,15 +294,16 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 
 	count = domain->bounce_size >> PAGE_SHIFT;
 	for (i = 0; i < count; i++) {
-		struct page *page = NULL;
+		struct page *page = pages[i];
 
 		map = &domain->bounce_maps[i];
-		if (WARN_ON(!map->bounce_page))
+		if (WARN_ON(!map->bounce_page)) {
+			put_page(page);
 			continue;
+		}
 
 		/* Copy user page to kernel page if it's in use */
 		if (map->orig_phys != INVALID_PHYS_ADDR) {
-			page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
 			memcpy_from_page(page_address(page),
 					 map->bounce_page, 0, PAGE_SIZE);
 		}
@@ -543,10 +544,19 @@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
 static int vduse_domain_release(struct inode *inode, struct file *file)
 {
 	struct vduse_iova_domain *domain = file->private_data;
+	struct page **pages = NULL;
+	unsigned long count, i;
+
+	if (domain->user_bounce_pages) {
+		count = domain->bounce_size >> PAGE_SHIFT;
+		pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL);
+		for (i = 0; i < count; i++)
+			pages[i] = alloc_page(GFP_KERNEL | __GFP_NOFAIL);
+	}
 
 	spin_lock(&domain->iotlb_lock);
 	vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
-	vduse_domain_remove_user_bounce_pages(domain);
+	vduse_domain_remove_user_bounce_pages(domain, pages);
 	vduse_domain_free_kernel_bounce_pages(domain);
 	spin_unlock(&domain->iotlb_lock);
 	put_iova_domain(&domain->stream_iovad);
@@ -554,6 +564,7 @@ static int vduse_domain_release(struct inode *inode, struct file *file)
 	vhost_iotlb_free(domain->iotlb);
 	vfree(domain->bounce_maps);
 	kfree(domain);
+	kfree(pages);
 
 	return 0;
 }
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index f92f22a7267d..db0b793d86db 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -74,7 +74,8 @@ void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 				       struct page **pages, int count);
 
-void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain);
+void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain,
+					   struct page **pages);
 
 void vduse_domain_destroy(struct vduse_iova_domain *domain);
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7ae99691efdf..df7c1b6f1350 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1030,6 +1030,8 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 				u64 iova, u64 size)
 {
+	struct page **pages = NULL;
+	unsigned long count, i;
 	int ret;
 
 	mutex_lock(&dev->mem_lock);
@@ -1044,13 +1046,22 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
 		goto unlock;
 
-	vduse_domain_remove_user_bounce_pages(dev->domain);
+	if (dev->domain->user_bounce_pages) {
+		count = dev->domain->bounce_size >> PAGE_SHIFT;
+		pages = kmalloc_array(count, sizeof(*pages),
+				      GFP_KERNEL | __GFP_NOFAIL);
+		for (i = 0; i < count; i++)
+			pages[i] = alloc_page(GFP_KERNEL | __GFP_NOFAIL);
+	}
+
+	vduse_domain_remove_user_bounce_pages(dev->domain, pages);
 	unpin_user_pages_dirty_lock(dev->umem->pages,
 				    dev->umem->npages, true);
 	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
 	mmdrop(dev->umem->mm);
 	vfree(dev->umem->pages);
 	kfree(dev->umem);
+	kfree(pages);
 	dev->umem = NULL;
 	ret = 0;
 unlock:
-- 
2.34.1

>
> Thanks
>
> >
> >
> > > --
> > > Michal Hocko
> > > SUSE Labs
> >

Thanks
Barry

