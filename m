Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77A6CCA479
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 06:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4800E60BFD;
	Tue, 28 Jun 2022 06:07:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4800E60BFD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XnwKKGnm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o3DlVcxxbWBS; Tue, 28 Jun 2022 06:07:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9323B60B71;
	Tue, 28 Jun 2022 06:07:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9323B60B71
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69D12C0032;
	Tue, 28 Jun 2022 06:07:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9690EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7611E4037C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:07:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7611E4037C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XnwKKGnm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UjQtBd_mVe2x
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:07:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8E8E4027A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8E8E4027A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656396458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/ohXfoyTxXbbZ4JXPTRZWXDX41bqJBMWZuEwckjalc=;
 b=XnwKKGnmaQkgytkm/gfXnQveWEykNFI0NDv9NqNzYeWXHkMJrmNUMc8yhm/IzSkh4KWDyk
 XHR6ZIhgO6qkmk3mhjFEXMPsU7IwYnRl9Nt3Zsl41WTeEJvNG2UQSLz98+JNABhDgSy8wL
 u0Ld1Fue4FusKbWH3rr8+d3KDF4fvtQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-Z7PQWx9cN4GPMoqRcMJ7tw-1; Tue, 28 Jun 2022 02:07:37 -0400
X-MC-Unique: Z7PQWx9cN4GPMoqRcMJ7tw-1
Received: by mail-wm1-f72.google.com with SMTP id
 e24-20020a05600c219800b003a0471b1904so3444831wme.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 23:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4/ohXfoyTxXbbZ4JXPTRZWXDX41bqJBMWZuEwckjalc=;
 b=ouM4svoil3pkqTGlLapLsh/S3/+DbN7xHf0UxxewSUH8l2cRDAyQomghjT7Ez2q18q
 IQ2S2eqMBdZ+cWfpnWEoEsVXg9syjJy9RzCdfHJ0aEPwj/e7iV/bfkFWaHLQQurIl4qI
 DQGe2LYc1D9SWdccdYcyFmai4QTFWskkSbD7C29T02jr5RPyRNENNaH7Ms9VqDhc7vRS
 KIRQCEuWcufwIircILF1ch4O0DLIEOAw8ZneQFME+YGk0YAITkOvth8TFBRFNkiAF7H3
 ZcwotOUcvldkUOzKijY89HhXwLMko9YbLyGFlldwwT0SFhnIpXU3HibfANt7+K+mVUpN
 ajOg==
X-Gm-Message-State: AJIora/bfY332+3sfcJ1DIro4J3YqgMs2KJSx7EgcFXgbFa+YVzj6/N8
 5jhyCf2f4jAzKKSRp8PPwT8Dir2vlBf6uiiCXa/2spVbGty4Bi+oFIeCoXHCtm4g1KkehAmXKcN
 AiIN/mkrnhUoGy3f31OFLchz357CSMoSLaRGdKXyS2w==
X-Received: by 2002:a05:600c:4f03:b0:3a0:55a2:bb4 with SMTP id
 l3-20020a05600c4f0300b003a055a20bb4mr773151wmq.181.1656396456020; 
 Mon, 27 Jun 2022 23:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tnKDdkDZ3kiiEnkoZfMNpkuN3upCNoU9G4kzO0+7iWrkAtWlJT4hm3GqrGeWyQF/DE2dYdXg==
X-Received: by 2002:a05:600c:4f03:b0:3a0:55a2:bb4 with SMTP id
 l3-20020a05600c4f0300b003a055a20bb4mr773131wmq.181.1656396455786; 
 Mon, 27 Jun 2022 23:07:35 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 z22-20020a05600c221600b003a0499df21asm7127532wml.25.2022.06.27.23.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 23:07:35 -0700 (PDT)
Date: Tue, 28 Jun 2022 02:07:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 1/2] vhost: Add rbtree vdpa_mem_tree to saved the
 counted mem
Message-ID: <20220628020622-mutt-send-email-mst@kernel.org>
References: <20220626090409.1011144-1-lulu@redhat.com>
 <20220626055420-mutt-send-email-mst@kernel.org>
 <CACLfguVMfqAiCVoNVr7J8ooQa35tNJOSK-XHqsdE3hdXsfOZ+A@mail.gmail.com>
 <20220627055826-mutt-send-email-mst@kernel.org>
 <CACGkMEugJQY-QsnekKHWSdaG0H03qFxdmu+O1tQKMge65bFmHw@mail.gmail.com>
 <20220628014642-mutt-send-email-mst@kernel.org>
 <CACGkMEvt9QVvZb+gEuynazGmEM-j22QdiEH_V-oWD1=NZQS+5g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvt9QVvZb+gEuynazGmEM-j22QdiEH_V-oWD1=NZQS+5g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Tue, Jun 28, 2022 at 02:03:38PM +0800, Jason Wang wrote:
> On Tue, Jun 28, 2022 at 1:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 11:54:27AM +0800, Jason Wang wrote:
> > > On Mon, Jun 27, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 27, 2022 at 04:12:57PM +0800, Cindy Lu wrote:
> > > > > On Sun, Jun 26, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Sun, Jun 26, 2022 at 05:04:08PM +0800, Cindy Lu wrote:
> > > > > > > We count pinned_vm as follow in vhost-vDPA
> > > > > > >
> > > > > > > lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > > > > > if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > > > > > >          ret = -ENOMEM;
> > > > > > >          goto unlock;
> > > > > > > }
> > > > > > > This means if we have two vDPA devices for the same VM the pages
> > > > > > > would be counted twice. So we add a tree to save the page that
> > > > > > > counted and we will not count it again.
> > > > > > >
> > > > > > > Add vdpa_mem_tree to saved the mem that already counted.
> > > > > > > use a hlist to saved the root for vdpa_mem_tree.
> > > > > > >
> > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vhost/vhost.c | 63 +++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  drivers/vhost/vhost.h |  1 +
> > > > > > >  2 files changed, 64 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > > index 40097826cff0..4ca8b1ed944b 100644
> > > > > > > --- a/drivers/vhost/vhost.c
> > > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > > @@ -32,6 +32,8 @@
> > > > > > >  #include <linux/kcov.h>
> > > > > > >
> > > > > > >  #include "vhost.h"
> > > > > > > +#include <linux/hashtable.h>
> > > > > > > +#include <linux/jhash.h>
> > > > > > >
> > > > > > >  static ushort max_mem_regions = 64;
> > > > > > >  module_param(max_mem_regions, ushort, 0444);
> > > > > > > @@ -49,6 +51,14 @@ enum {
> > > > > > >  #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
> > > > > > >  #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
> > > > > > >
> > > > > > > +struct vhost_vdpa_rbtree_node {
> > > > > > > +     struct hlist_node node;
> > > > > > > +     struct rb_root_cached vdpa_mem_tree;
> > > > > > > +     struct mm_struct *mm_using;
> > > > > > > +};
> > > > > > > +static DECLARE_HASHTABLE(vhost_vdpa_rbtree_hlist, 8);
> > > > > > > +int vhost_vdpa_rbtree_hlist_status;
> > > > > > > +
> > > > > > >  #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
> > > > > > >  static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
> > > > > > >  {
> > > > > >
> > > > > > Are you trying to save some per-mm information here?
> > > > > > Can't we just add it to mm_struct?
> > > > > >
> > > > > yes, this is a per-mm information, but I have checked with jason before,
> > > > > seems it maybe difficult to change the mm_struct in upstream
> > > > > so I add an to add a hlist  instead
> > > > > Thanks
> > > > > Cindy
> > > >
> > > > Difficult how?
> > >
> > > It is only useful for vDPA probably. Though it could be used by VFIO
> > > as well, VFIO does pinning/accounting at the container level and it
> > > has been there for years.
> >
> > Yes it's been there, I'm not sure this means it's perfect.
> > Also, rdma guys might be interested too I guess?
> 
> It looks to me they plan to go to iommufd as well.
> 
> >
> > > vDPA have an implicit "container" the
> > > mm_struct, but the accounting is done per device right now.
> > >
> > > In the future, when vDPA switches to iommufd, it can be then solved at
> > > iommufd level.
> >
> > So is it even worth fixing now?
> 
> Not sure, but I guess it's better. (Or we need to teach the libvirt to
> have special care on this).

It already has to for existing kernels.  Let's just move to iommufd
faster then?

> >
> > > And if we do this in mm, it will bring extra overheads.
> > >
> > > Thanks
> >
> > Pointer per mm, not too bad ...
> 
> Unless we enable it unconditionally, it requires a lot of tree
> operations at least.
> 
> Thanks

Not sure I understand.

> >
> > > > You get more scrutiny if you try, for sure,
> > > > and you need to need to generalize it enough that it looks
> > > > useful outside the driver. But I guess that's good?
> > > >
> > > > > >
> > > > > >
> > > > > > > @@ -571,6 +581,51 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> > > > > > >       dev->mm = NULL;
> > > > > > >  }
> > > > > > >
> > > > > > > +struct rb_root_cached *vhost_vdpa_get_mem_tree(struct mm_struct *mm)
> > > > > > > +{
> > > > > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > > > > +     struct rb_root_cached *vdpa_tree;
> > > > > > > +     u32 key;
> > > > > > > +
> > > > > > > +     /* No hased table, init one */
> > > > > > > +     if (vhost_vdpa_rbtree_hlist_status == 0) {
> > > > > > > +             hash_init(vhost_vdpa_rbtree_hlist);
> > > > > > > +             vhost_vdpa_rbtree_hlist_status = 1;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > > > > +                            key) {
> > > > > > > +             if (rbtree_root->mm_using == mm)
> > > > > > > +                     return &(rbtree_root->vdpa_mem_tree);
> > > > > > > +     }
> > > > > > > +     rbtree_root = kmalloc(sizeof(*rbtree_root), GFP_KERNEL);
> > > > > > > +     if (!rbtree_root)
> > > > > > > +             return NULL;
> > > > > > > +     rbtree_root->mm_using = mm;
> > > > > > > +     rbtree_root->vdpa_mem_tree = RB_ROOT_CACHED;
> > > > > > > +     hash_add(vhost_vdpa_rbtree_hlist, &rbtree_root->node, key);
> > > > > > > +     vdpa_tree = &(rbtree_root->vdpa_mem_tree);
> > > > > > > +     return vdpa_tree;
> > > > > > > +}
> > > > > > > +
> > > > > > > +void vhost_vdpa_relase_mem_tree(struct mm_struct *mm)
> > > > > > > +{
> > > > > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > > > > +     u32 key;
> > > > > > > +
> > > > > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > > > > +
> > > > > > > +     /* No hased table, init one */
> > > > > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > > > > +                            key) {
> > > > > > > +             if (rbtree_root->mm_using == mm) {
> > > > > > > +                     hash_del(&rbtree_root->node);
> > > > > > > +                     kfree(rbtree_root);
> > > > > > > +             }
> > > > > > > +     }
> > > > > > > +}
> > > > > > > +
> > > > > > >  /* Caller should have device mutex */
> > > > > > >  long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > > >  {
> > > > > > > @@ -605,6 +660,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > > >       err = vhost_dev_alloc_iovecs(dev);
> > > > > > >       if (err)
> > > > > > >               goto err_cgroup;
> > > > > > > +     dev->vdpa_mem_tree = vhost_vdpa_get_mem_tree(dev->mm);
> > > > > > > +     if (dev->vdpa_mem_tree == NULL) {
> > > > > > > +             err = -ENOMEM;
> > > > > > > +             goto err_cgroup;
> > > > > > > +     }
> > > > > > >
> > > > > > >       return 0;
> > > > > > >  err_cgroup:
> > > > > > > @@ -613,6 +673,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > > >               dev->worker = NULL;
> > > > > > >       }
> > > > > > >  err_worker:
> > > > > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > > > > >       vhost_detach_mm(dev);
> > > > > > >       dev->kcov_handle = 0;
> > > > > > >  err_mm:
> > > > > > > @@ -710,6 +771,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > > > >               dev->worker = NULL;
> > > > > > >               dev->kcov_handle = 0;
> > > > > > >       }
> > > > > > > +
> > > > > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > > > > >       vhost_detach_mm(dev);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> > > > > > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > > > > > index d9109107af08..84de33de3abf 100644
> > > > > > > --- a/drivers/vhost/vhost.h
> > > > > > > +++ b/drivers/vhost/vhost.h
> > > > > > > @@ -160,6 +160,7 @@ struct vhost_dev {
> > > > > > >       int byte_weight;
> > > > > > >       u64 kcov_handle;
> > > > > > >       bool use_worker;
> > > > > > > +     struct rb_root_cached *vdpa_mem_tree;
> > > > > > >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> > > > > > >                          struct vhost_iotlb_msg *msg);
> > > > > > >  };
> > > > > > > --
> > > > > > > 2.34.3
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
