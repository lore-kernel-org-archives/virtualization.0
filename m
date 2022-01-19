Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB67C433EF
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 06:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAEC160E99;
	Wed, 19 Jan 2022 06:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfP8oiWZcgJZ; Wed, 19 Jan 2022 06:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2E6B360E90;
	Wed, 19 Jan 2022 06:37:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08066C0039;
	Wed, 19 Jan 2022 06:37:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64671C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53DF9825B9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jBKv2e7dz17r
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:37:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6AB682572
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:37:39 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V2FlLW3_1642574256; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2FlLW3_1642574256) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 19 Jan 2022 14:37:36 +0800
MIME-Version: 1.0
message-id: <1642574171.3526633-5-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 5/6] virtio: queue_reset: pci: support VIRTIO_F_RING_RESET
date: Wed, 19 Jan 2022 14:36:11 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEtz1cC83b1EVCexszNEj___zPqAUE+R8A2m0L+tMMZyig@mail.gmail.com>
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

On Wed, 19 Jan 2022 14:11:29 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Jan 19, 2022 at 10:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > This patch implements virtio pci support for QUEUE RESET.
> >
> > Performing reset on a queue is divided into three steps:
> >
> > 1. reset_vq: notify the hardware queue to reset
> > 2. del_reset_vq: delete the reset queue
> > 3. enable_reset_vq: re-enable the reset queue
> >
> > Between steps 1 and 2, generally call virtqueue_detach_unused_buf() to
> > recycle the buffer.
>
> I wonder if it's better to squash 1, 2 and
> virtqueue_detach_unused_buf() into a single helper.

Oh, that's a good note. The only trouble is that the caller has to provide a
callback to handle the reclaimed buffer.

Thanks.

>
> >
> > When deleting a vq, vp_del_vq() will be called to release all the memory
> > of the vq. But this does not affect the process of deleting vqs, because
> > that is based on the queue to release all the vqs. During this process,
> > the vq has been removed from the queue.
> >
> > When deleting vq, info and vq will be released, and I save msix_vec in
> > vp_dev->vqs[queue_index]. When re-enable, the current msix_vec can be
> > reused. And based on intx_enabled to determine which method to use to
> > enable this queue.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 54 ++++++++++++++++++++
> >  drivers/virtio/virtio_pci_common.h |  5 ++
> >  drivers/virtio/virtio_pci_modern.c | 81 ++++++++++++++++++++++++++++++
> >  include/linux/virtio_config.h      | 21 ++++++++
> >  4 files changed, 161 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 5afe207ce28a..615a5a5f757c 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -464,6 +464,60 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> >         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> >  }
> >
> > +#define VQ_IS_DELETED(vp_dev, idx) ((unsigned long)vp_dev->vqs[idx] & 1)
> > +#define VQ_RESET_MSIX_VEC(vp_dev, idx) ((unsigned long)vp_dev->vqs[idx] >> 2)
> > +#define VQ_RESET_MARK(msix_vec) ((void *)(long)((msix_vec << 2) + 1))
> > +
> > +int vp_del_reset_vq(struct virtio_device *vdev, u16 queue_index)
> > +{
> > +       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +       struct virtio_pci_vq_info *info;
> > +       u16 msix_vec;
> > +
> > +       if (VQ_IS_DELETED(vp_dev, queue_index))
> > +               return -EPERM;
> > +
> > +       info = vp_dev->vqs[queue_index];
> > +
> > +       msix_vec = info->msix_vector;
> > +
> > +       /* delete vq */
> > +       vp_del_vq(info->vq);
> > +
> > +       /* Mark the vq has been deleted, and save the msix_vec. */
> > +       vp_dev->vqs[queue_index] = VQ_RESET_MARK(msix_vec);
> > +
> > +       return 0;
> > +}
> > +
> > +struct virtqueue *vp_enable_reset_vq(struct virtio_device *vdev,
> > +                                    int queue_index,
> > +                                    vq_callback_t *callback,
> > +                                    const char *name,
> > +                                    const bool ctx)
> > +{
> > +       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +       struct virtqueue *vq;
> > +       u16 msix_vec;
> > +
> > +       if (!VQ_IS_DELETED(vp_dev, queue_index))
> > +               return ERR_PTR(-EPERM);
> > +
> > +       msix_vec = VQ_RESET_MSIX_VEC(vp_dev, queue_index);
> > +
> > +       if (vp_dev->intx_enabled)
> > +               vq = vp_setup_vq(vdev, queue_index, callback, name, ctx,
> > +                                VIRTIO_MSI_NO_VECTOR);
> > +       else
> > +               vq = vp_enable_vq_msix(vdev, queue_index, callback, name, ctx,
> > +                                      msix_vec);
> > +
> > +       if (IS_ERR(vq))
> > +               vp_dev->vqs[queue_index] = VQ_RESET_MARK(msix_vec);
> > +
> > +       return vq;
> > +}
> > +
> >  const char *vp_bus_name(struct virtio_device *vdev)
> >  {
> >         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > index 23f6c5c678d5..a92c99cc010e 100644
> > --- a/drivers/virtio/virtio_pci_common.h
> > +++ b/drivers/virtio/virtio_pci_common.h
> > @@ -115,6 +115,11 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> >                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
> >                 const char * const names[], const bool *ctx,
> >                 struct irq_affinity *desc);
> > +void vp_reset_vq(struct virtio_device *vdev, u16 queue_index);
> > +int vp_del_reset_vq(struct virtio_device *vdev, u16 queue_index);
> > +struct virtqueue *vp_enable_reset_vq(struct virtio_device *vdev, int queue_index,
> > +                                    vq_callback_t *callback, const char *name,
> > +                                    const bool ctx);
> >  const char *vp_bus_name(struct virtio_device *vdev);
> >
> >  /* Setup the affinity for a virtqueue:
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 5455bc041fb6..74e0b2b2f4dc 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
> >         if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
> >                         pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
> >                 __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> > +
> > +       if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> > +               __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> >  }
> >
> >  /* virtio config->finalize_features() implementation */
> > @@ -176,6 +179,78 @@ static void vp_reset(struct virtio_device *vdev)
> >         vp_disable_cbs(vdev);
> >  }
> >
> > +static int vp_modern_reset_vq(struct virtio_device *vdev, u16 queue_index)
> > +{
> > +       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +       struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > +       u16 msix_vec;
> > +
> > +       if (!virtio_has_feature(vdev, VIRTIO_F_RING_RESET))
> > +               return -ENOENT;
> > +
> > +       vp_modern_set_queue_reset(mdev, queue_index);
> > +
> > +       /* After write 1 to queue reset, the driver MUST wait for a read of
> > +        * queue reset to return 1.
> > +        */
> > +       while (vp_modern_get_queue_reset(mdev, queue_index) != 1)
> > +               msleep(1);
> > +
> > +       msix_vec = vp_dev->vqs[queue_index]->msix_vector;
> > +
> > +       /* Disable VQ callback. */
> > +       if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
> > +               disable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
>
> What happens if the irq is shared among virtqueues?
>
> > +
> > +       return 0;
> > +}
> > +
> > +static int vp_modern_del_reset_vq(struct virtio_device *vdev, u16 queue_index)
> > +{
> > +       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +       struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > +
> > +       if (!virtio_has_feature(vdev, VIRTIO_F_RING_RESET))
> > +               return -ENOENT;
> > +
> > +       /* check queue reset status */
> > +       if (vp_modern_get_queue_reset(mdev, queue_index) != 1)
> > +               return -EBUSY;
> > +
> > +       return vp_del_reset_vq(vdev, queue_index);
> > +}
> > +
> > +static struct virtqueue *vp_modern_enable_reset_vq(struct virtio_device *vdev,
> > +                                                  u16 queue_index,
> > +                                                  vq_callback_t *callback,
> > +                                                  const char *name,
> > +                                                  const bool *ctx)
> > +{
> > +       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +       struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > +       struct virtqueue *vq;
> > +       u16 msix_vec;
> > +
> > +       if (!virtio_has_feature(vdev, VIRTIO_F_RING_RESET))
> > +               return ERR_PTR(-ENOENT);
> > +
> > +       /* check queue reset status */
> > +       if (vp_modern_get_queue_reset(mdev, queue_index) != 1)
> > +               return ERR_PTR(-EBUSY);
> > +
> > +       vq = vp_enable_reset_vq(vdev, queue_index, callback, name, ctx);
> > +       if (IS_ERR(vq))
> > +               return vq;
> > +
> > +       vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
> > +
> > +       msix_vec = vp_dev->vqs[queue_index]->msix_vector;
> > +       if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
> > +               enable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
> > +
> > +       return vq;
> > +}
> > +
> >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> >  {
> >         return vp_modern_config_vector(&vp_dev->mdev, vector);
> > @@ -395,6 +470,9 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> >         .set_vq_affinity = vp_set_vq_affinity,
> >         .get_vq_affinity = vp_get_vq_affinity,
> >         .get_shm_region  = vp_get_shm_region,
> > +       .reset_vq        = vp_modern_reset_vq,
> > +       .del_reset_vq    = vp_modern_del_reset_vq,
> > +       .enable_reset_vq = vp_modern_enable_reset_vq,
> >  };
> >
> >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > @@ -413,6 +491,9 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
> >         .set_vq_affinity = vp_set_vq_affinity,
> >         .get_vq_affinity = vp_get_vq_affinity,
> >         .get_shm_region  = vp_get_shm_region,
> > +       .reset_vq        = vp_modern_reset_vq,
> > +       .del_reset_vq    = vp_modern_del_reset_vq,
> > +       .enable_reset_vq = vp_modern_enable_reset_vq,
> >  };
> >
> >  /* the PCI probing function */
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 4d107ad31149..6e94f7d0e153 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -74,6 +74,21 @@ struct virtio_shm_region {
> >   * @set_vq_affinity: set the affinity for a virtqueue (optional).
> >   * @get_vq_affinity: get the affinity for a virtqueue (optional).
> >   * @get_shm_region: get a shared memory region based on the index.
> > + * @reset_vq: reset a queue individually
> > + *     vdev: the device
> > + *     queue_index: the queue index
> > + *     returns 0 on success or error status
> > + * @del_reset_vq: del a reset queue
> > + *     vdev: the device
> > + *     queue_index: the queue index
> > + *     returns 0 on success or error status.
> > + * @enable_reset_vq: enable a reset queue
> > + *     vdev: the device
> > + *     queue_index: the queue index
> > + *     callback: callback for the virtqueue, NULL for vq that do not need a callback
> > + *     name: virtqueue names (mainly for debugging), NULL for vq unused by driver
> > + *     ctx: ctx
> > + *     returns vq on success or error status
> >   */
> >  typedef void vq_callback_t(struct virtqueue *);
> >  struct virtio_config_ops {
> > @@ -100,6 +115,12 @@ struct virtio_config_ops {
> >                         int index);
> >         bool (*get_shm_region)(struct virtio_device *vdev,
> >                                struct virtio_shm_region *region, u8 id);
> > +       int (*reset_vq)(struct virtio_device *vdev, u16 queue_index);
> > +       int (*del_reset_vq)(struct virtio_device *vdev, u16 queue_index);
> > +       struct virtqueue *(*enable_reset_vq)(struct virtio_device *vdev,
> > +                                            u16 queue_index,
> > +                                            vq_callback_t *callback,
> > +                                            const char *name, const bool *ctx);
> >  };
> >
> >  /* If driver didn't advertise the feature, it will never appear. */
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
