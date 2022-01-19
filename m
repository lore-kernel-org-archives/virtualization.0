Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1A8C433F5
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 06:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89CBF60E91;
	Wed, 19 Jan 2022 06:33:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HoEnV56SLusi; Wed, 19 Jan 2022 06:33:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F47360AB5;
	Wed, 19 Jan 2022 06:33:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEF1BC0039;
	Wed, 19 Jan 2022 06:33:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DD61C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E0F160B00
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mqfCp9e1KHXS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:33:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32E3D60AB5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:33:29 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R861e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V2FlKu6_1642574006; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2FlKu6_1642574006) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 19 Jan 2022 14:33:26 +0800
MIME-Version: 1.0
message-id: <1642573990.2882423-3-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 4/6] virtio: queue_reset: pci: extract some functions for
 subsequent patches
date: Wed, 19 Jan 2022 14:33:10 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEsm15wuiscGYi2DJEU_9po7J_sUvX5FAW=eC-hv5u1ocQ@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Wed, 19 Jan 2022 14:04:51 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Jan 19, 2022 at 10:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Add a vq_enable_vq_msix() function to enable a vq alone.
> >
> > Move irq's processing logic into vp_del_vq(), so that this function can
> > handle a vq's del operation independently.
> >
> > In the subsequent patches that supports queue reset, I have the
> > need to delete/enable a vq separately.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 86 +++++++++++++++++++-----------
> >  1 file changed, 54 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index fdbde1db5ec5..5afe207ce28a 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -248,6 +248,17 @@ static void vp_del_vq(struct virtqueue *vq)
> >         struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
> >         unsigned long flags;
> >
> > +       if (vp_dev->per_vq_vectors) {
> > +               int v = vp_dev->vqs[vq->index]->msix_vector;
> > +
> > +               if (v != VIRTIO_MSI_NO_VECTOR) {
> > +                       int irq = pci_irq_vector(vp_dev->pci_dev, v);
> > +
> > +                       irq_set_affinity_hint(irq, NULL);
> > +                       free_irq(irq, vq);
> > +               }
> > +       }
> > +
> >         spin_lock_irqsave(&vp_dev->lock, flags);
> >         list_del(&info->node);
> >         spin_unlock_irqrestore(&vp_dev->lock, flags);
> > @@ -263,19 +274,9 @@ void vp_del_vqs(struct virtio_device *vdev)
> >         struct virtqueue *vq, *n;
> >         int i;
> >
> > -       list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
> > -               if (vp_dev->per_vq_vectors) {
> > -                       int v = vp_dev->vqs[vq->index]->msix_vector;
> > -
> > -                       if (v != VIRTIO_MSI_NO_VECTOR) {
> > -                               int irq = pci_irq_vector(vp_dev->pci_dev, v);
> > -
> > -                               irq_set_affinity_hint(irq, NULL);
> > -                               free_irq(irq, vq);
> > -                       }
> > -               }
> > +       list_for_each_entry_safe(vq, n, &vdev->vqs, list)
> >                 vp_del_vq(vq);
> > -       }
>
> I think we need a better subject of the patch and it's better to even
> split the patch into two.
>
> This part could be "move the per queue irq logic from vp_del_vqs to vp_del_vq".

OK.

>
> > +
> >         vp_dev->per_vq_vectors = false;
> >
> >         if (vp_dev->intx_enabled) {
> > @@ -310,6 +311,40 @@ void vp_del_vqs(struct virtio_device *vdev)
> >         vp_dev->vqs = NULL;
> >  }
> >
> > +static struct virtqueue *vp_enable_vq_msix(struct virtio_device *vdev,
> > +                                          int queue_index,
> > +                                          vq_callback_t *callback,
> > +                                          const char * const name,
> > +                                          bool ctx,
> > +                                          u16 msix_vec)
> > +{
> > +       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +       struct virtqueue *vq;
> > +       int err;
> > +
> > +       vq = vp_setup_vq(vdev, queue_index, callback, name, ctx, msix_vec);
> > +       if (IS_ERR(vq))
> > +               return vq;
> > +
> > +       if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
> > +               return vq;
> > +
> > +       /* allocate per-vq irq if available and necessary */
> > +       snprintf(vp_dev->msix_names[msix_vec],
> > +                sizeof *vp_dev->msix_names,
> > +                "%s-%s", dev_name(&vp_dev->vdev.dev), name);
> > +
> > +       err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> > +                         vring_interrupt, IRQF_NO_AUTOEN,
> > +                         vp_dev->msix_names[msix_vec], vq);
> > +       if (err) {
> > +               vp_del_vq(vq);
> > +               return ERR_PTR(err);
> > +       }
> > +
> > +       return vq;
> > +}
>
> And this deserves a separate patch as well.

OK

Thanks.

>
> Thanks
>
> > +
> >  static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> >                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
> >                 const char * const names[], bool per_vq_vectors,
> > @@ -319,6 +354,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> >         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >         u16 msix_vec;
> >         int i, err, nvectors, allocated_vectors, queue_idx = 0;
> > +       struct virtqueue *vq;
> >
> >         vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
> >         if (!vp_dev->vqs)
> > @@ -354,28 +390,14 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> >                         msix_vec = allocated_vectors++;
> >                 else
> >                         msix_vec = VP_MSIX_VQ_VECTOR;
> > -               vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
> > -                                    ctx ? ctx[i] : false,
> > -                                    msix_vec);
> > -               if (IS_ERR(vqs[i])) {
> > -                       err = PTR_ERR(vqs[i]);
> > -                       goto error_find;
> > -               }
> >
> > -               if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
> > -                       continue;
> > -
> > -               /* allocate per-vq irq if available and necessary */
> > -               snprintf(vp_dev->msix_names[msix_vec],
> > -                        sizeof *vp_dev->msix_names,
> > -                        "%s-%s",
> > -                        dev_name(&vp_dev->vdev.dev), names[i]);
> > -               err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> > -                                 vring_interrupt, IRQF_NO_AUTOEN,
> > -                                 vp_dev->msix_names[msix_vec],
> > -                                 vqs[i]);
> > -               if (err)
> > +               vq = vp_enable_vq_msix(vdev, queue_idx++, callbacks[i],
> > +                                      names[i], ctx ? ctx[i] : false, msix_vec);
> > +               if (IS_ERR(vq)) {
> > +                       err = PTR_ERR(vq);
> >                         goto error_find;
> > +               }
> > +               vqs[i] = vq;
> >         }
> >         return 0;
> >
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
