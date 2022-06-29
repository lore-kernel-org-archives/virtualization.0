Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C47C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 09:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3061419CB;
	Wed, 29 Jun 2022 09:54:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3061419CB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CgU+UBWL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8WLxa6InVtr9; Wed, 29 Jun 2022 09:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 876A8419C0;
	Wed, 29 Jun 2022 09:54:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 876A8419C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ACF3C0039;
	Wed, 29 Jun 2022 09:54:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92A0DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 09:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 549CF41A20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 09:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 549CF41A20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cUzZGCQ5NTZ3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 09:54:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6A99419C0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6A99419C0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656496471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=36O/Gzs2sswpRmDBZoRkMoKcl0+wQgegUageWIRbuPE=;
 b=CgU+UBWLDpssjh37zGHL/x3fOOXneLCWps/C+jlUvyr8oiWASfUOzLO0NIv5TZbytJNdQA
 Y56cy3XeZAPMirfeAlgImE4SeyFXETE3A9cfrT/cPCeCaNTSnGIFGxw4CxDCly1SxJsc1b
 DhgZNIzWwbhb9AkP9LNITYfcDrkdlG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-XJPDhBiZOdepP1eDQurOLQ-1; Wed, 29 Jun 2022 05:54:29 -0400
X-MC-Unique: XJPDhBiZOdepP1eDQurOLQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 e24-20020a05600c219800b003a0471b1904so5319934wme.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 02:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=36O/Gzs2sswpRmDBZoRkMoKcl0+wQgegUageWIRbuPE=;
 b=54JVExXv+2Z3MKiasXenfNrByh41CMm7lt3aTg+//v9DHlxpbzOD6sWdpQHMnvOmlU
 a2tiQXwR6JyMqqsB3ubgdRbDHfR4uOOtbi9yeh4peYE1qG/BCucRhWvclk9zljc8qm35
 hbsqeGxKxJh/UGNzNGGkf/zFtxdMdKv39J9gCzpzHf4lwrXsy2HiS7xBtlfPbvmPRpZH
 ZS06IKWS7upltA9Dujjo3OODUmMXPAvCbHq5J1HmkGqhJvXH06Lfwgu11kBZ91Tbcwwz
 63YTrJ7eoB0YdudKZNhzXOf2e3HLLcTlZTqmkjPcxxf9p7pFveQuHJLSD7lJvaWW1NGX
 6Rsg==
X-Gm-Message-State: AJIora/sTiMcttSLDyVGqUZfoxRjHBHMdelbPbarKP4NrXPa/h7HBEWX
 R1eKGuntJWdpv9mqnBnZcrUJZ5FJobEg7D/twKXrnY/nDYjp2UUthz/78+OH3kLdy1Tr8qiw8gR
 zer4bR5+f4ztFQJS5zSCBXW8Qo2w+wktdM4VgTgkjeA==
X-Received: by 2002:a05:600c:d0:b0:39c:5927:3fa7 with SMTP id
 u16-20020a05600c00d000b0039c59273fa7mr2675271wmm.36.1656496467953; 
 Wed, 29 Jun 2022 02:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sKqYhDGRn42oJUC9GK4iLPx/KWw+hJS0QGL/AKJfgjnQJxjz/dRnaJ+S5h9tADAL8A2HvpdQ==
X-Received: by 2002:a05:600c:d0:b0:39c:5927:3fa7 with SMTP id
 u16-20020a05600c00d000b0039c59273fa7mr2675239wmm.36.1656496467655; 
 Wed, 29 Jun 2022 02:54:27 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 190-20020a1c19c7000000b003a04912351fsm2684729wmz.17.2022.06.29.02.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 02:54:27 -0700 (PDT)
Date: Wed, 29 Jun 2022 05:54:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 5/6] vduse: Support registering userspace memory for IOTLB
Message-ID: <20220629055241-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-6-xieyongji@bytedance.com>
 <20220629043539-mutt-send-email-mst@kernel.org>
 <CACycT3sAcH-b40hORjSOQb67jZ0Fd-fxdzmZNwt=4iZdX6gLeA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3sAcH-b40hORjSOQb67jZ0Fd-fxdzmZNwt=4iZdX6gLeA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jun 29, 2022 at 05:26:04PM +0800, Yongji Xie wrote:
> On Wed, Jun 29, 2022 at 4:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 04:25:40PM +0800, Xie Yongji wrote:
> > > Introduce two ioctls: VDUSE_IOTLB_REG_UMEM and
> > > VDUSE_IOTLB_DEREG_UMEM to support registering
> > > and de-registering userspace memory for IOTLB
> > > in virtio-vdpa case.
> > >
> > > Now it only supports registering userspace memory
> > > for IOTLB as bounce buffer.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 138 +++++++++++++++++++++++++++++
> > >  include/uapi/linux/vduse.h         |  28 ++++++
> > >  2 files changed, 166 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index c47a5d9765cf..7b2ea7612da9 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/uio.h>
> > >  #include <linux/vdpa.h>
> > >  #include <linux/nospec.h>
> > > +#include <linux/sched/mm.h>
> > >  #include <uapi/linux/vduse.h>
> > >  #include <uapi/linux/vdpa.h>
> > >  #include <uapi/linux/virtio_config.h>
> > > @@ -64,6 +65,13 @@ struct vduse_vdpa {
> > >       struct vduse_dev *dev;
> > >  };
> > >
> > > +struct vduse_iotlb_mem {
> > > +     unsigned long iova;
> > > +     unsigned long npages;
> > > +     struct page **pages;
> > > +     struct mm_struct *mm;
> > > +};
> > > +
> > >  struct vduse_dev {
> > >       struct vduse_vdpa *vdev;
> > >       struct device *dev;
> > > @@ -95,6 +103,8 @@ struct vduse_dev {
> > >       u8 status;
> > >       u32 vq_num;
> > >       u32 vq_align;
> > > +     struct vduse_iotlb_mem *iotlb_mem;
> > > +     struct mutex mem_lock;
> > >  };
> > >
> > >  struct vduse_dev_msg {
> > > @@ -917,6 +927,100 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > >       return ret;
> > >  }
> > >
> > > +static int vduse_dev_dereg_iotlb_mem(struct vduse_dev *dev,
> > > +                                  u64 iova, u64 size)
> > > +{
> > > +     int ret;
> > > +
> > > +     mutex_lock(&dev->mem_lock);
> > > +     ret = -ENOENT;
> > > +     if (!dev->iotlb_mem)
> > > +             goto unlock;
> > > +
> > > +     ret = -EINVAL;
> > > +     if (dev->iotlb_mem->iova != iova || size != dev->domain->bounce_size)
> > > +             goto unlock;
> > > +
> > > +     vduse_domain_remove_user_bounce_pages(dev->domain);
> > > +     unpin_user_pages(dev->iotlb_mem->pages, dev->iotlb_mem->npages);
> >
> > I notice you don't mark the pages dirty. This is going to be a problem.
> >
> 
> Thanks for pointing out this, I will use unpin_user_pages_dirty_lock() instead.
> 
> > > +     atomic64_sub(dev->iotlb_mem->npages, &dev->iotlb_mem->mm->pinned_vm);
> > > +     mmdrop(dev->iotlb_mem->mm);
> > > +     vfree(dev->iotlb_mem->pages);
> > > +     kfree(dev->iotlb_mem);
> > > +     dev->iotlb_mem = NULL;
> > > +     ret = 0;
> > > +unlock:
> > > +     mutex_unlock(&dev->mem_lock);
> > > +     return ret;
> > > +}
> > > +
> > > +static int vduse_dev_reg_iotlb_mem(struct vduse_dev *dev,
> > > +                                u64 iova, u64 uaddr, u64 size)
> > > +{
> > > +     struct page **page_list = NULL;
> > > +     struct vduse_iotlb_mem *mem = NULL;
> > > +     long pinned = 0;
> > > +     unsigned long npages, lock_limit;
> > > +     int ret;
> > > +
> > > +     if (size != dev->domain->bounce_size ||
> > > +         iova != 0 || uaddr & ~PAGE_MASK)
> > > +             return -EINVAL;
> > > +
> > > +     mutex_lock(&dev->mem_lock);
> > > +     ret = -EEXIST;
> > > +     if (dev->iotlb_mem)
> > > +             goto unlock;
> > > +
> > > +     ret = -ENOMEM;
> > > +     npages = size >> PAGE_SHIFT;
> > > +     page_list = vmalloc(array_size(npages,
> > > +                         sizeof(struct page *)));
> >
> > Is this basically trying to do a vmalloc with userspace-controlled size?
> > That's an easy DOS vector.
> >
> 
> We already checked the size before. The size must equal to (64MB >>
> PAGE_SHIFT) now.

That's not a small amount. Can this be accounted e.g. through cgroups at least?

> > > +     mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > > +     if (!page_list || !mem)
> > > +             goto unlock;
> > > +
> > > +     mmap_read_lock(current->mm);
> > > +
> > > +     lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> > > +     if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
> > > +             goto out;
> > > +
> > > +     pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
> > > +                             page_list, NULL);
> > > +     if (pinned != npages) {
> > > +             ret = pinned < 0 ? pinned : -ENOMEM;
> > > +             goto out;
> > > +     }
> >
> >
> > This is a popular approach but it's problematic if multiple
> > devices try to pin the same page.
> 
> Do you mean the data would be corrupted if multiple devices use the
> same page as bounce buffer? This is indeed a problem.

No i mean you decrement the lock twice. Question is can two bounce
buffers share a page?

> > Can this happen here?
> >
> 
> I think we can't prevent this case now. I will do it in v2.
> 
> > > +
> > > +     ret = vduse_domain_add_user_bounce_pages(dev->domain,
> > > +                                              page_list, pinned);
> > > +     if (ret)
> > > +             goto out;
> > > +
> > > +     atomic64_add(npages, &current->mm->pinned_vm);
> > > +
> > > +     mem->pages = page_list;
> > > +     mem->npages = pinned;
> > > +     mem->iova = iova;
> > > +     mem->mm = current->mm;
> > > +     mmgrab(current->mm);
> > > +
> > > +     dev->iotlb_mem = mem;
> > > +out:
> > > +     if (ret && pinned > 0)
> > > +             unpin_user_pages(page_list, pinned);
> > > +
> > > +     mmap_read_unlock(current->mm);
> > > +unlock:
> > > +     if (ret) {
> > > +             vfree(page_list);
> > > +             kfree(mem);
> > > +     }
> > > +     mutex_unlock(&dev->mem_lock);
> > > +     return ret;
> > > +}
> > > +
> > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >                           unsigned long arg)
> > >  {
> > > @@ -943,6 +1047,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >               if (entry.start > entry.last)
> > >                       break;
> > >
> > > +             if (domain->bounce_map && dev->iotlb_mem) {
> > > +                     ret = -EEXIST;
> > > +                     if (entry.start >= 0 &&
> > > +                         entry.last < domain->bounce_size)
> > > +                             break;
> > > +
> > > +                     if (entry.start < domain->bounce_size)
> > > +                             entry.start = domain->bounce_size;
> > > +             }
> > > +
> > >               spin_lock(&domain->iotlb_lock);
> > >               map = vhost_iotlb_itree_first(domain->iotlb,
> > >                                             entry.start, entry.last);
> > > @@ -1102,6 +1216,28 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >               ret = 0;
> > >               break;
> > >       }
> > > +     case VDUSE_IOTLB_REG_UMEM: {
> > > +             struct vduse_iotlb_umem umem;
> > > +
> > > +             ret = -EFAULT;
> > > +             if (copy_from_user(&umem, argp, sizeof(umem)))
> > > +                     break;
> > > +
> > > +             ret = vduse_dev_reg_iotlb_mem(dev, umem.iova,
> > > +                                           umem.uaddr, umem.size);
> > > +             break;
> > > +     }
> > > +     case VDUSE_IOTLB_DEREG_UMEM: {
> > > +             struct vduse_iotlb_umem umem;
> > > +
> > > +             ret = -EFAULT;
> > > +             if (copy_from_user(&umem, argp, sizeof(umem)))
> > > +                     break;
> > > +
> > > +             ret = vduse_dev_dereg_iotlb_mem(dev, umem.iova,
> > > +                                             umem.size);
> > > +             break;
> > > +     }
> > >       default:
> > >               ret = -ENOIOCTLCMD;
> > >               break;
> > > @@ -1114,6 +1250,7 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
> > >  {
> > >       struct vduse_dev *dev = file->private_data;
> > >
> > > +     vduse_dev_dereg_iotlb_mem(dev, 0, dev->domain->bounce_size);
> > >       spin_lock(&dev->msg_lock);
> > >       /* Make sure the inflight messages can processed after reconncection */
> > >       list_splice_init(&dev->recv_list, &dev->send_list);
> > > @@ -1176,6 +1313,7 @@ static struct vduse_dev *vduse_dev_create(void)
> > >               return NULL;
> > >
> > >       mutex_init(&dev->lock);
> > > +     mutex_init(&dev->mem_lock);
> > >       spin_lock_init(&dev->msg_lock);
> > >       INIT_LIST_HEAD(&dev->send_list);
> > >       INIT_LIST_HEAD(&dev->recv_list);
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index c201b7a77c2c..1b17391e228f 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -227,6 +227,34 @@ struct vduse_iotlb_info {
> > >  /* Get IOTLB information, e.g. bounce buffer size */
> > >  #define VDUSE_IOTLB_GET_INFO    _IOR(VDUSE_BASE, 0x18, struct vduse_iotlb_info)
> > >
> > > +/**
> > > + * struct vduse_iotlb_umem - userspace memory configuration
> > > + * @uaddr: start address of userspace memory, it must be aligned to page size
> > > + * @iova: IOVA of userspace memory, it must be equal to bounce iova returned
> > > + *        by VDUSE_IOTLB_GET_INFO now
> > > + * @size: size of userspace memory, it must be equal to bounce size returned
> > > + *        by VDUSE_IOTLB_GET_INFO now
> > > + * @reserved: for future use, needs to be initialized to zero
> >
> > You should check that it's 0 in that case, otherwise userspace
> > will conveniently forget.
> >
> 
> OK, I will fix it.
> 
> Thanks,
> Yongji

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
