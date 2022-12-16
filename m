Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDD1C4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 07:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFA1D40C97;
	Fri, 16 Dec 2022 07:27:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFA1D40C97
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cqC65dQF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oJw3w4xr-gvw; Fri, 16 Dec 2022 07:27:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65C0340569;
	Fri, 16 Dec 2022 07:27:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65C0340569
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B8D7C0032;
	Fri, 16 Dec 2022 07:27:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD619C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 07:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC0C541B56
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 07:27:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC0C541B56
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cqC65dQF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gOWRDilRNYlb
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 07:27:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E58141B55
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E58141B55
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671175619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPEjkfolOv6ztAu6aD/WZn2rd8mZZh/tttToGoLTS6A=;
 b=cqC65dQF9KHXbRczjZ23j+lqjwD9pBnHDXXf3+V8WheTp86uLv/YsnKDTUlSzjsPkQC1eF
 X3SsXpM9eV8uS/SHKdMev9JckGF5FC3lQkssuG+pI9IUSHMWGHaVE279MjXBr9bNFJDkox
 HnX0L2A5h7pO2dB5tqUlz0YCoWqUQiU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-WBukWhdOM5idm-Ovs2V_zA-1; Fri, 16 Dec 2022 02:26:57 -0500
X-MC-Unique: WBukWhdOM5idm-Ovs2V_zA-1
Received: by mail-oi1-f198.google.com with SMTP id
 b8-20020a056808010800b0035e342ff33aso460944oie.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 23:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IPEjkfolOv6ztAu6aD/WZn2rd8mZZh/tttToGoLTS6A=;
 b=t2g0u54fs0CTQPuikBiS9UkDyIHDoY5RhPzZC5xsIeiLXg7LAMRYBk8DhT2NIH9hdV
 L6GqSG71HSa6A6bmqG9w6feIEMeIsuqA1bKw4d73Vt8UacdqjWFUEkcSrBWE/Eypt2Vr
 MEbV3vEArh5y+CWkDmpsoAl9IOA+VRrYYS+0Q+oEHGZS4/+MLrcFd23Ols1enRYVFv7p
 Yqt8a0XIawL+DBg316kcB7jfYqxerkqCU6clv1yJIXZT6KkXMDyQvUZ3o5rAji6anRhX
 Znxf2YgEfBjMwS5/QR6cAlkcD2lE/VewMnHn38gzeHVXMSNAA0pb3KETilbP91mLPPlY
 b32Q==
X-Gm-Message-State: ANoB5pmCUViyhIFvkJG9AI9Yxol+x/opdygGi6dvD6/62stzOTYVdGt8
 tbVOdbVGAulsnhXdfwTkXQPPoe3j7w3EKlR4AnMEH67f5amvSL4Gi2swYR/rBrjljZso12/WSU2
 99pWsNS6Qq/ZWYcLNB0e6acb8EIlTQ5JI9p3bbHmYrTX66pp0io95V9gX7A==
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr348120oab.35.1671175617222; 
 Thu, 15 Dec 2022 23:26:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5OvsijG2TXiwv/QU3ULVD3ZpToieGkZY45BBePbQ7uOx0BJBOsOE53HatkWZtZEPx8gGf6bZNyBEXoLgyKqg8=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr348115oab.35.1671175616981; Thu, 15
 Dec 2022 23:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20221214163025.103075-1-sgarzare@redhat.com>
 <20221214163025.103075-7-sgarzare@redhat.com>
In-Reply-To: <20221214163025.103075-7-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 15:26:46 +0800
Message-ID: <CACGkMEuk0xNwthy4NgR1xPfEVt-EgtmZmfiacJprGgyvi3hVAA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] vdpa_sim: add support for user VA
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

On Thu, Dec 15, 2022 at 12:31 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> The new "use_va" module parameter (default: false) is used in
> vdpa_alloc_device() to inform the vDPA framework that the device
> supports VA.
>
> vringh is initialized to use VA only when "use_va" is true and the
> user's mm has been bound. So, only when the bus supports user VA
> (e.g. vhost-vdpa).
>
> vdpasim_mm_work_fn work is used to attach the kthread to the user
> address space when the .bind_mm callback is invoked, and to detach
> it when the device is reset.

One thing in my mind is that the current datapath is running under
spinlock which prevents us from using iov_iter (which may have page
faults).

We need to get rid of the spinlock first.

>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |   1 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 104 ++++++++++++++++++++++++++++++-
>  2 files changed, 103 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 07ef53ea375e..1b010e5c0445 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -55,6 +55,7 @@ struct vdpasim {
>         struct vdpasim_virtqueue *vqs;
>         struct kthread_worker *worker;
>         struct kthread_work work;
> +       struct mm_struct *mm_bound;
>         struct vdpasim_dev_attr dev_attr;
>         /* spinlock to synchronize virtqueue state */
>         spinlock_t lock;
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 36a1d2e0a6ba..6e07cedef30c 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -36,10 +36,90 @@ module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>                  "Maximum number of iotlb entries for each address space. 0 means unlimited. (default: 2048)");
>
> +static bool use_va;
> +module_param(use_va, bool, 0444);
> +MODULE_PARM_DESC(use_va, "Enable the device's ability to use VA");
> +
>  #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
>  #define VDPASIM_QUEUE_MAX 256
>  #define VDPASIM_VENDOR_ID 0
>
> +struct vdpasim_mm_work {
> +       struct kthread_work work;
> +       struct task_struct *owner;
> +       struct mm_struct *mm;
> +       bool bind;
> +       int ret;
> +};
> +
> +static void vdpasim_mm_work_fn(struct kthread_work *work)
> +{
> +       struct vdpasim_mm_work *mm_work =
> +               container_of(work, struct vdpasim_mm_work, work);
> +
> +       mm_work->ret = 0;
> +
> +       if (mm_work->bind) {
> +               kthread_use_mm(mm_work->mm);
> +#if 0
> +               if (mm_work->owner)
> +                       mm_work->ret = cgroup_attach_task_all(mm_work->owner,
> +                                                             current);
> +#endif
> +       } else {
> +#if 0
> +               //TODO: check it
> +               cgroup_release(current);
> +#endif
> +               kthread_unuse_mm(mm_work->mm);
> +       }
> +}
> +
> +static void vdpasim_worker_queue_mm(struct vdpasim *vdpasim,
> +                                   struct vdpasim_mm_work *mm_work)
> +{
> +       struct kthread_work *work = &mm_work->work;
> +
> +       kthread_init_work(work, vdpasim_mm_work_fn);
> +       kthread_queue_work(vdpasim->worker, work);
> +
> +       spin_unlock(&vdpasim->lock);
> +       kthread_flush_work(work);
> +       spin_lock(&vdpasim->lock);
> +}
> +
> +static int vdpasim_worker_bind_mm(struct vdpasim *vdpasim,
> +                                 struct mm_struct *new_mm,
> +                                 struct task_struct *owner)
> +{
> +       struct vdpasim_mm_work mm_work;
> +
> +       mm_work.owner = owner;
> +       mm_work.mm = new_mm;
> +       mm_work.bind = true;
> +
> +       vdpasim_worker_queue_mm(vdpasim, &mm_work);
> +

Should we wait for the work to be finished?

> +       if (!mm_work.ret)
> +               vdpasim->mm_bound = new_mm;
> +
> +       return mm_work.ret;
> +}
> +
> +static void vdpasim_worker_unbind_mm(struct vdpasim *vdpasim)
> +{
> +       struct vdpasim_mm_work mm_work;
> +
> +       if (!vdpasim->mm_bound)
> +               return;
> +
> +       mm_work.mm = vdpasim->mm_bound;
> +       mm_work.bind = false;
> +
> +       vdpasim_worker_queue_mm(vdpasim, &mm_work);
> +
> +       vdpasim->mm_bound = NULL;
> +}
>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>  {
>         return container_of(vdpa, struct vdpasim, vdpa);
> @@ -66,8 +146,10 @@ static void vdpasim_vq_notify(struct vringh *vring)
>  static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>  {
>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> +       bool va_enabled = use_va && vdpasim->mm_bound;
>
> -       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false, false,
> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
> +                         va_enabled,
>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>                           (struct vring_avail *)
>                           (uintptr_t)vq->driver_addr,
> @@ -96,6 +178,9 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
>  {
>         int i;
>
> +       //TODO: should we cancel the works?
> +       vdpasim_worker_unbind_mm(vdpasim);

We probably don't need this since it's the virtio level reset so we
need to keep the mm bound in this case. Otherwise we may break the
guest. It should be the responsibility of the driver to call
config_ops->unbind if it needs to do that.

Thanks


> +
>         spin_lock(&vdpasim->iommu_lock);
>
>         for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
> @@ -275,7 +360,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>
>         vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
>                                     dev_attr->ngroups, dev_attr->nas,
> -                                   dev_attr->name, false);
> +                                   dev_attr->name, use_va);
>         if (IS_ERR(vdpasim)) {
>                 ret = PTR_ERR(vdpasim);
>                 goto err_alloc;
> @@ -657,6 +742,19 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
>         return ret;
>  }
>
> +static int vdpasim_bind_mm(struct vdpa_device *vdpa, struct mm_struct *mm,
> +                          struct task_struct *owner)
> +{
> +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +       int ret;
> +
> +       spin_lock(&vdpasim->lock);
> +       ret = vdpasim_worker_bind_mm(vdpasim, mm, owner);
> +       spin_unlock(&vdpasim->lock);
> +
> +       return ret;
> +}
> +
>  static int vdpasim_dma_map(struct vdpa_device *vdpa, unsigned int asid,
>                            u64 iova, u64 size,
>                            u64 pa, u32 perm, void *opaque)
> @@ -744,6 +842,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .set_group_asid         = vdpasim_set_group_asid,
>         .dma_map                = vdpasim_dma_map,
>         .dma_unmap              = vdpasim_dma_unmap,
> +       .bind_mm                = vdpasim_bind_mm,
>         .free                   = vdpasim_free,
>  };
>
> @@ -776,6 +875,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>         .get_iova_range         = vdpasim_get_iova_range,
>         .set_group_asid         = vdpasim_set_group_asid,
>         .set_map                = vdpasim_set_map,
> +       .bind_mm                = vdpasim_bind_mm,
>         .free                   = vdpasim_free,
>  };
>
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
