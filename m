Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DA5C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 06:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6DB3404D5;
	Tue, 28 Jun 2022 06:03:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6DB3404D5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ffzj+OEM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QeHjq4jSGk6v; Tue, 28 Jun 2022 06:03:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E93B240494;
	Tue, 28 Jun 2022 06:03:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E93B240494
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA0A0C0032;
	Tue, 28 Jun 2022 06:03:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9D32C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E06940494
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E06940494
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8BIPR1HT1q6v
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:03:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3321640483
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3321640483
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656396233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jojm8owdIPd57DqUsyTCYbMvjfqLhEZ7p337DessMhw=;
 b=ffzj+OEM9Ta5E0xLAb88n2sRBCj43ow2jFWL+kjSolfdmlmjCVxrF+SCCKH++AM/dITP6b
 htdBQhoO9BGWRxoUE3IJEfLfoS5u/ubvkCDTtQeOwgDvmqu7laUlW/DFhb6enE2K718I/o
 KmwalmMsJETNJGOyQAqB4gxm+9qX7CA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-LqMnuQ4ENrWU09vda510VA-1; Tue, 28 Jun 2022 02:03:51 -0400
X-MC-Unique: LqMnuQ4ENrWU09vda510VA-1
Received: by mail-lf1-f71.google.com with SMTP id
 y35-20020a0565123f2300b0047f70612402so5777199lfa.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 23:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jojm8owdIPd57DqUsyTCYbMvjfqLhEZ7p337DessMhw=;
 b=Z4J2T8Efjbc3XSKV1Lqo+Llz7KukuK9B5fqaBC5EessFcs3JVGZ//68a5mzDoq32ee
 oSeyciYmLGRkZEKIxHhOkatrLLY7Fh13oTW6k4zZlx3XoBtgdWGeCMsfF8FP6C3Q5aYI
 +rc7m/jSreK3L3wZYs3iLwhix494eg2VmTIN2qjKslq4fz+9iwh75X63d/0XU0FzD5Zd
 zw1o/SGsXY6URGuOyESw313iZFDD9mPc8L0Tx2QWGi1oCJkdIpwtk2Y/q5cFrh1jdlT7
 EqeMS4lQHEi/cfSmTt7M0QoA3JqjBUcWpKIjv/l9M1KS5KnaEGBc+Z9TcHiA5/FKH1bh
 xcSw==
X-Gm-Message-State: AJIora9DetdPMKROLdIYi/jideuBb8T26VT2FTKdM9OT6MaKM5wuu+9S
 cY0NC8x/dM7FuQPGAqsvktm0yHAC9nLCTNhDg98guOVpKJuYbJM/elhIYmTH3FqmpCyiKdOXvIh
 cdcu7jDYc5WMx798OekAwpns6Y8XWNUMTis2T61oogdp0OiEcEUBtjYQiVg==
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr11014880lfb.397.1656396229778; 
 Mon, 27 Jun 2022 23:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ttN7m3IIazB5XFNBYra5MYuT99xrYQLK1rinkFlncZPVZF3VEP4596me4R5XLWsBLm/x2c/ff8xAWx9m14eOo=
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr11014864lfb.397.1656396229558; Mon, 27
 Jun 2022 23:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220626090409.1011144-1-lulu@redhat.com>
 <20220626055420-mutt-send-email-mst@kernel.org>
 <CACLfguVMfqAiCVoNVr7J8ooQa35tNJOSK-XHqsdE3hdXsfOZ+A@mail.gmail.com>
 <20220627055826-mutt-send-email-mst@kernel.org>
 <CACGkMEugJQY-QsnekKHWSdaG0H03qFxdmu+O1tQKMge65bFmHw@mail.gmail.com>
 <20220628014642-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220628014642-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Jun 2022 14:03:38 +0800
Message-ID: <CACGkMEvt9QVvZb+gEuynazGmEM-j22QdiEH_V-oWD1=NZQS+5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vhost: Add rbtree vdpa_mem_tree to saved the
 counted mem
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cindy Lu <lulu@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Jun 28, 2022 at 1:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 28, 2022 at 11:54:27AM +0800, Jason Wang wrote:
> > On Mon, Jun 27, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 04:12:57PM +0800, Cindy Lu wrote:
> > > > On Sun, Jun 26, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Sun, Jun 26, 2022 at 05:04:08PM +0800, Cindy Lu wrote:
> > > > > > We count pinned_vm as follow in vhost-vDPA
> > > > > >
> > > > > > lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > > > > if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > > > > >          ret = -ENOMEM;
> > > > > >          goto unlock;
> > > > > > }
> > > > > > This means if we have two vDPA devices for the same VM the pages
> > > > > > would be counted twice. So we add a tree to save the page that
> > > > > > counted and we will not count it again.
> > > > > >
> > > > > > Add vdpa_mem_tree to saved the mem that already counted.
> > > > > > use a hlist to saved the root for vdpa_mem_tree.
> > > > > >
> > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > ---
> > > > > >  drivers/vhost/vhost.c | 63 +++++++++++++++++++++++++++++++++++++++++++
> > > > > >  drivers/vhost/vhost.h |  1 +
> > > > > >  2 files changed, 64 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > index 40097826cff0..4ca8b1ed944b 100644
> > > > > > --- a/drivers/vhost/vhost.c
> > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > @@ -32,6 +32,8 @@
> > > > > >  #include <linux/kcov.h>
> > > > > >
> > > > > >  #include "vhost.h"
> > > > > > +#include <linux/hashtable.h>
> > > > > > +#include <linux/jhash.h>
> > > > > >
> > > > > >  static ushort max_mem_regions = 64;
> > > > > >  module_param(max_mem_regions, ushort, 0444);
> > > > > > @@ -49,6 +51,14 @@ enum {
> > > > > >  #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
> > > > > >  #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
> > > > > >
> > > > > > +struct vhost_vdpa_rbtree_node {
> > > > > > +     struct hlist_node node;
> > > > > > +     struct rb_root_cached vdpa_mem_tree;
> > > > > > +     struct mm_struct *mm_using;
> > > > > > +};
> > > > > > +static DECLARE_HASHTABLE(vhost_vdpa_rbtree_hlist, 8);
> > > > > > +int vhost_vdpa_rbtree_hlist_status;
> > > > > > +
> > > > > >  #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
> > > > > >  static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
> > > > > >  {
> > > > >
> > > > > Are you trying to save some per-mm information here?
> > > > > Can't we just add it to mm_struct?
> > > > >
> > > > yes, this is a per-mm information, but I have checked with jason before,
> > > > seems it maybe difficult to change the mm_struct in upstream
> > > > so I add an to add a hlist  instead
> > > > Thanks
> > > > Cindy
> > >
> > > Difficult how?
> >
> > It is only useful for vDPA probably. Though it could be used by VFIO
> > as well, VFIO does pinning/accounting at the container level and it
> > has been there for years.
>
> Yes it's been there, I'm not sure this means it's perfect.
> Also, rdma guys might be interested too I guess?

It looks to me they plan to go to iommufd as well.

>
> > vDPA have an implicit "container" the
> > mm_struct, but the accounting is done per device right now.
> >
> > In the future, when vDPA switches to iommufd, it can be then solved at
> > iommufd level.
>
> So is it even worth fixing now?

Not sure, but I guess it's better. (Or we need to teach the libvirt to
have special care on this).

>
> > And if we do this in mm, it will bring extra overheads.
> >
> > Thanks
>
> Pointer per mm, not too bad ...

Unless we enable it unconditionally, it requires a lot of tree
operations at least.

Thanks

>
> > > You get more scrutiny if you try, for sure,
> > > and you need to need to generalize it enough that it looks
> > > useful outside the driver. But I guess that's good?
> > >
> > > > >
> > > > >
> > > > > > @@ -571,6 +581,51 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> > > > > >       dev->mm = NULL;
> > > > > >  }
> > > > > >
> > > > > > +struct rb_root_cached *vhost_vdpa_get_mem_tree(struct mm_struct *mm)
> > > > > > +{
> > > > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > > > +     struct rb_root_cached *vdpa_tree;
> > > > > > +     u32 key;
> > > > > > +
> > > > > > +     /* No hased table, init one */
> > > > > > +     if (vhost_vdpa_rbtree_hlist_status == 0) {
> > > > > > +             hash_init(vhost_vdpa_rbtree_hlist);
> > > > > > +             vhost_vdpa_rbtree_hlist_status = 1;
> > > > > > +     }
> > > > > > +
> > > > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > > > +                            key) {
> > > > > > +             if (rbtree_root->mm_using == mm)
> > > > > > +                     return &(rbtree_root->vdpa_mem_tree);
> > > > > > +     }
> > > > > > +     rbtree_root = kmalloc(sizeof(*rbtree_root), GFP_KERNEL);
> > > > > > +     if (!rbtree_root)
> > > > > > +             return NULL;
> > > > > > +     rbtree_root->mm_using = mm;
> > > > > > +     rbtree_root->vdpa_mem_tree = RB_ROOT_CACHED;
> > > > > > +     hash_add(vhost_vdpa_rbtree_hlist, &rbtree_root->node, key);
> > > > > > +     vdpa_tree = &(rbtree_root->vdpa_mem_tree);
> > > > > > +     return vdpa_tree;
> > > > > > +}
> > > > > > +
> > > > > > +void vhost_vdpa_relase_mem_tree(struct mm_struct *mm)
> > > > > > +{
> > > > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > > > +     u32 key;
> > > > > > +
> > > > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > > > +
> > > > > > +     /* No hased table, init one */
> > > > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > > > +                            key) {
> > > > > > +             if (rbtree_root->mm_using == mm) {
> > > > > > +                     hash_del(&rbtree_root->node);
> > > > > > +                     kfree(rbtree_root);
> > > > > > +             }
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > >  /* Caller should have device mutex */
> > > > > >  long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > >  {
> > > > > > @@ -605,6 +660,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > >       err = vhost_dev_alloc_iovecs(dev);
> > > > > >       if (err)
> > > > > >               goto err_cgroup;
> > > > > > +     dev->vdpa_mem_tree = vhost_vdpa_get_mem_tree(dev->mm);
> > > > > > +     if (dev->vdpa_mem_tree == NULL) {
> > > > > > +             err = -ENOMEM;
> > > > > > +             goto err_cgroup;
> > > > > > +     }
> > > > > >
> > > > > >       return 0;
> > > > > >  err_cgroup:
> > > > > > @@ -613,6 +673,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > >               dev->worker = NULL;
> > > > > >       }
> > > > > >  err_worker:
> > > > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > > > >       vhost_detach_mm(dev);
> > > > > >       dev->kcov_handle = 0;
> > > > > >  err_mm:
> > > > > > @@ -710,6 +771,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > > >               dev->worker = NULL;
> > > > > >               dev->kcov_handle = 0;
> > > > > >       }
> > > > > > +
> > > > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > > > >       vhost_detach_mm(dev);
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> > > > > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > > > > index d9109107af08..84de33de3abf 100644
> > > > > > --- a/drivers/vhost/vhost.h
> > > > > > +++ b/drivers/vhost/vhost.h
> > > > > > @@ -160,6 +160,7 @@ struct vhost_dev {
> > > > > >       int byte_weight;
> > > > > >       u64 kcov_handle;
> > > > > >       bool use_worker;
> > > > > > +     struct rb_root_cached *vdpa_mem_tree;
> > > > > >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> > > > > >                          struct vhost_iotlb_msg *msg);
> > > > > >  };
> > > > > > --
> > > > > > 2.34.3
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
