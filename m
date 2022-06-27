Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17211C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 10:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 916BD83DEE;
	Mon, 27 Jun 2022 10:01:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 916BD83DEE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WjnT3nZ0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id awJYk04S-OmF; Mon, 27 Jun 2022 10:01:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3524837AC;
	Mon, 27 Jun 2022 10:01:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3524837AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0011C0039;
	Mon, 27 Jun 2022 10:01:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89364C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 10:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 638C741904
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 10:01:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 638C741904
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WjnT3nZ0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gDSTcIBZ27ES
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 10:01:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BC9A415BA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BC9A415BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656324088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfIYzOFq9+jwXTV0OEEFxQKh2b4fXVCS3UReweWTk08=;
 b=WjnT3nZ0TJW/DocrYhkxmD1ysgBXs7SfBNp9jPUZWfAYjX1hAgHYsQ4sdIWURUaA/4EZkc
 o71lfUC9VXHeXTIC3aQFlAAklA3R9AqgpEhM6Q8fVhcRgTgmVwVSqCorCQeiQivjxmg0P9
 /iXoNYm5MYa/rolOddVPmeuggkwwIus=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-pl1z_j70MES1kCxzZ2fJ6A-1; Mon, 27 Jun 2022 06:01:27 -0400
X-MC-Unique: pl1z_j70MES1kCxzZ2fJ6A-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg6-20020a05600c3c8600b003a03d5d19e4so4264292wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 03:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XfIYzOFq9+jwXTV0OEEFxQKh2b4fXVCS3UReweWTk08=;
 b=nxJzXF1YzP7KaBw3wPRLJdKqbjcJZhNicVkAVwys7fi1YGc0kyfAYEdiEBUQYaUNoW
 oRkeZq+mjaN/QyYy6FehjHeqeTXp6E5yYUBjOvL+oTcfuV1dgjsQz5rOXuUHpBNZn8g/
 ZyEZKZmnKOSLPaIQEXF7QCtt+uTQCP8Q9aIvxHvmjlVUdpWteLkhVxcSt+P/MfSm5wmp
 suvv2Lw1+7+eHmPLDytaCCEqObFQb89AJQJ6LeJVp88dzbVjMIxRKEy7HBxhcK8QgUT+
 xELnAhijvAPwOg92mk1JmEDgeempvTUOLarcF9NOFuMXs0xJmdsBsfOKQc7lePwHhF1a
 SP7Q==
X-Gm-Message-State: AJIora+hHuS9jcU9XMa0Em4fKe1dl/7AU5V42RQQlEHXaHhl7c28fxwF
 1wWamXsTk1lhz7C5l9ZZUjySRpArXGL0Q+9zJrn77h1FO1yCurgloxGVwx04QCVqYiQB4JGiEDM
 fZ0xE0daxFZZP8D9dh48wzuTXgvBXj+iHnDxdXpNtVw==
X-Received: by 2002:adf:d20e:0:b0:21b:9bf8:75e with SMTP id
 j14-20020adfd20e000000b0021b9bf8075emr11372947wrh.416.1656324086148; 
 Mon, 27 Jun 2022 03:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u71NWi+QLUpjcQmtx2VVGYmH07xgw2ZqtlMg5pGrYX9gCttKo+VrvS67vS2J5YcclFCLqr9Q==
X-Received: by 2002:adf:d20e:0:b0:21b:9bf8:75e with SMTP id
 j14-20020adfd20e000000b0021b9bf8075emr11372921wrh.416.1656324085841; 
 Mon, 27 Jun 2022 03:01:25 -0700 (PDT)
Received: from redhat.com ([2.54.45.90]) by smtp.gmail.com with ESMTPSA id
 c17-20020a05600c0ad100b003973ea7e725sm23047559wmr.0.2022.06.27.03.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 03:01:25 -0700 (PDT)
Date: Mon, 27 Jun 2022 06:01:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v3 1/2] vhost: Add rbtree vdpa_mem_tree to saved the
 counted mem
Message-ID: <20220627055826-mutt-send-email-mst@kernel.org>
References: <20220626090409.1011144-1-lulu@redhat.com>
 <20220626055420-mutt-send-email-mst@kernel.org>
 <CACLfguVMfqAiCVoNVr7J8ooQa35tNJOSK-XHqsdE3hdXsfOZ+A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACLfguVMfqAiCVoNVr7J8ooQa35tNJOSK-XHqsdE3hdXsfOZ+A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
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

On Mon, Jun 27, 2022 at 04:12:57PM +0800, Cindy Lu wrote:
> On Sun, Jun 26, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Jun 26, 2022 at 05:04:08PM +0800, Cindy Lu wrote:
> > > We count pinned_vm as follow in vhost-vDPA
> > >
> > > lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > >          ret = -ENOMEM;
> > >          goto unlock;
> > > }
> > > This means if we have two vDPA devices for the same VM the pages
> > > would be counted twice. So we add a tree to save the page that
> > > counted and we will not count it again.
> > >
> > > Add vdpa_mem_tree to saved the mem that already counted.
> > > use a hlist to saved the root for vdpa_mem_tree.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/vhost.c | 63 +++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/vhost/vhost.h |  1 +
> > >  2 files changed, 64 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 40097826cff0..4ca8b1ed944b 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -32,6 +32,8 @@
> > >  #include <linux/kcov.h>
> > >
> > >  #include "vhost.h"
> > > +#include <linux/hashtable.h>
> > > +#include <linux/jhash.h>
> > >
> > >  static ushort max_mem_regions = 64;
> > >  module_param(max_mem_regions, ushort, 0444);
> > > @@ -49,6 +51,14 @@ enum {
> > >  #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
> > >  #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
> > >
> > > +struct vhost_vdpa_rbtree_node {
> > > +     struct hlist_node node;
> > > +     struct rb_root_cached vdpa_mem_tree;
> > > +     struct mm_struct *mm_using;
> > > +};
> > > +static DECLARE_HASHTABLE(vhost_vdpa_rbtree_hlist, 8);
> > > +int vhost_vdpa_rbtree_hlist_status;
> > > +
> > >  #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
> > >  static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
> > >  {
> >
> > Are you trying to save some per-mm information here?
> > Can't we just add it to mm_struct?
> >
> yes, this is a per-mm information, but I have checked with jason before,
> seems it maybe difficult to change the mm_struct in upstream
> so I add an to add a hlist  instead
> Thanks
> Cindy

Difficult how? You get more scrutiny if you try, for sure,
and you need to need to generalize it enough that it looks
useful outside the driver. But I guess that's good?

> >
> >
> > > @@ -571,6 +581,51 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> > >       dev->mm = NULL;
> > >  }
> > >
> > > +struct rb_root_cached *vhost_vdpa_get_mem_tree(struct mm_struct *mm)
> > > +{
> > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > +     struct rb_root_cached *vdpa_tree;
> > > +     u32 key;
> > > +
> > > +     /* No hased table, init one */
> > > +     if (vhost_vdpa_rbtree_hlist_status == 0) {
> > > +             hash_init(vhost_vdpa_rbtree_hlist);
> > > +             vhost_vdpa_rbtree_hlist_status = 1;
> > > +     }
> > > +
> > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > +                            key) {
> > > +             if (rbtree_root->mm_using == mm)
> > > +                     return &(rbtree_root->vdpa_mem_tree);
> > > +     }
> > > +     rbtree_root = kmalloc(sizeof(*rbtree_root), GFP_KERNEL);
> > > +     if (!rbtree_root)
> > > +             return NULL;
> > > +     rbtree_root->mm_using = mm;
> > > +     rbtree_root->vdpa_mem_tree = RB_ROOT_CACHED;
> > > +     hash_add(vhost_vdpa_rbtree_hlist, &rbtree_root->node, key);
> > > +     vdpa_tree = &(rbtree_root->vdpa_mem_tree);
> > > +     return vdpa_tree;
> > > +}
> > > +
> > > +void vhost_vdpa_relase_mem_tree(struct mm_struct *mm)
> > > +{
> > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > +     u32 key;
> > > +
> > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > +
> > > +     /* No hased table, init one */
> > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > +                            key) {
> > > +             if (rbtree_root->mm_using == mm) {
> > > +                     hash_del(&rbtree_root->node);
> > > +                     kfree(rbtree_root);
> > > +             }
> > > +     }
> > > +}
> > > +
> > >  /* Caller should have device mutex */
> > >  long vhost_dev_set_owner(struct vhost_dev *dev)
> > >  {
> > > @@ -605,6 +660,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > >       err = vhost_dev_alloc_iovecs(dev);
> > >       if (err)
> > >               goto err_cgroup;
> > > +     dev->vdpa_mem_tree = vhost_vdpa_get_mem_tree(dev->mm);
> > > +     if (dev->vdpa_mem_tree == NULL) {
> > > +             err = -ENOMEM;
> > > +             goto err_cgroup;
> > > +     }
> > >
> > >       return 0;
> > >  err_cgroup:
> > > @@ -613,6 +673,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > >               dev->worker = NULL;
> > >       }
> > >  err_worker:
> > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > >       vhost_detach_mm(dev);
> > >       dev->kcov_handle = 0;
> > >  err_mm:
> > > @@ -710,6 +771,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > >               dev->worker = NULL;
> > >               dev->kcov_handle = 0;
> > >       }
> > > +
> > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > >       vhost_detach_mm(dev);
> > >  }
> > >  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > index d9109107af08..84de33de3abf 100644
> > > --- a/drivers/vhost/vhost.h
> > > +++ b/drivers/vhost/vhost.h
> > > @@ -160,6 +160,7 @@ struct vhost_dev {
> > >       int byte_weight;
> > >       u64 kcov_handle;
> > >       bool use_worker;
> > > +     struct rb_root_cached *vdpa_mem_tree;
> > >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> > >                          struct vhost_iotlb_msg *msg);
> > >  };
> > > --
> > > 2.34.3
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
