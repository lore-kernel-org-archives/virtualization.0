Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF799C3A5A7
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 06:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 271CD60640;
	Tue,  6 Dec 2022 06:59:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 271CD60640
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkD+P35r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mstMXkvEGU_q; Tue,  6 Dec 2022 06:59:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 57831607FE;
	Tue,  6 Dec 2022 06:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57831607FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24556C0033;
	Tue,  6 Dec 2022 06:59:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE224C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 06:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B931180DB4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 06:59:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B931180DB4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkD+P35r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ljSh9AGjB-WG
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 06:59:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9F8E80C81
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9F8E80C81
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 06:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670309975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZVXWtcezAuDTCzgOoeiquxdfJOiL8JgFiF/95l+Ohtk=;
 b=XkD+P35rrupSa/nvlXW6YZHGmgfqU7RHZDiZrh7PUjCG1caz8br+n8GdIGszDkqZpdZD5h
 1TBdtcp2kerDG7O96O/l/iI3rUVzhlF0sTF57rausX9aBZrypGhTSyBbbIZl/ott3RGnop
 KiYgZJ15vUlvJ1PzB+9GAbU4zLdDIT4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-atSdCONNPHuo2ar9OULDvg-1; Tue, 06 Dec 2022 01:59:34 -0500
X-MC-Unique: atSdCONNPHuo2ar9OULDvg-1
Received: by mail-ot1-f70.google.com with SMTP id
 bm9-20020a056830374900b0066e7ffcb95dso6616349otb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 22:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZVXWtcezAuDTCzgOoeiquxdfJOiL8JgFiF/95l+Ohtk=;
 b=sZCDc8S7krp+JPp5rEGGlZ7OWPsY9C0F+8k2SkbTKLDOKItv658v86XL2MPW9/QhwS
 C3ojMB5CvdDr9tirPDBO4cRkMFDZYVIbo4xbLp6wdd9aQbAPFpYST1C4/BEXG7cBwXB3
 oYThW7SFyquHLX3pSHXBpFlCTVUyzcGD/KwvkKZrcGwTo+QZMqAkOUbNiDxo7EH9ZyHq
 Mk6KXgRXOizJSZSeqTSkwNlfuKYn0OuEAgSCks/zvyQz1wtQMz0r/P9F1TwyDheCqXcg
 TnLA5qvWXgbmGKYWmX0o7N/QKqqOM2Vs3aZZ+5QSuQQFdr4+fx1IO7LEdXMW6MGQkR9w
 ImxA==
X-Gm-Message-State: ANoB5pm+9EMObyOl0MKG71pJ+F9u7FGU9ZNG7S6GvMQnAfOVxwTIUWQW
 TmwuLI+SCwOGASX0QzlJ8QrlBznmo49nffUmSHnU950M/UXukdzU+aC1lOdG6qllT4C+c1Q88FA
 +Hawr1j5QBFRfKPS3nVJjMPl3GPSY8EV0rD1TLIZcxR9Fl1lyy1ayxmeTUA==
X-Received: by 2002:a05:6808:2093:b0:35b:ded0:4164 with SMTP id
 s19-20020a056808209300b0035bded04164mr11181058oiw.280.1670309973782; 
 Mon, 05 Dec 2022 22:59:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5rvyTmeQpVvgJBn/MecdYq8NqoQO4tQChNa9R/rwEI12bb6rTrX/QSxo7SuCGcodGO/sWWyJO0Lb6IboY80lc=
X-Received: by 2002:a05:6808:2093:b0:35b:ded0:4164 with SMTP id
 s19-20020a056808209300b0035bded04164mr11181054oiw.280.1670309973522; Mon, 05
 Dec 2022 22:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20221205135130.2336-1-longpeng2@huawei.com>
In-Reply-To: <20221205135130.2336-1-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Dec 2022 14:59:22 +0800
Message-ID: <CACGkMEtdT5fG=ffbpQadkGmzHf6Ax-+L50LsriYqJaW++natMg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpasim: support doorbell mapping
To: "Longpeng(Mike)" <longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, eperezma@redhat.com, huangzhichao@huawei.com,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Mon, Dec 5, 2022 at 9:52 PM Longpeng(Mike) <longpeng2@huawei.com> wrote:
>
> From: Longpeng <longpeng2@huawei.com>
>
> Support doorbell mapping for vdpasim devices, then we can test the notify
> passthrough feature even if there's no real hardware on hand.
>
> Allocates a dummy page which is used to emulate the notify page of the device,
> all VQs share the same notify register  that initiated to 0xffff. A  periodic
> work will check whether there're requests need to process ( the value of the
> notify register is 0xffff or not ).
>
> This cap is disabled as default, users can enable it as follow:
>   modprobe vdpa_sim notify_passthrough=true
>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
> Changes v1->v2:
>   - support both kick mode and passthrough mode. [Jason]
>   - poll the notify register first. [Jason, Michael]
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 77 ++++++++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
>  2 files changed, 80 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 7438a89ce939..07096a04dabb 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/dma-map-ops.h>
> +#include <asm/set_memory.h>
>  #include <linux/vringh.h>
>  #include <linux/vdpa.h>
>  #include <linux/vhost_iotlb.h>
> @@ -36,9 +37,16 @@ module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>                  "Maximum number of iotlb entries for each address space. 0 means unlimited. (default: 2048)");
>
> +static bool notify_passthrough;
> +module_param(notify_passthrough, bool, 0444);
> +MODULE_PARM_DESC(notify_passthrough,
> +                "Enable vq notify(doorbell) area mapping. (default: false)");

I'm not sure if it's worth doing this, I think we can afford the cost
of periodic work (especially considering it's a simulator).

> +
>  #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
>  #define VDPASIM_QUEUE_MAX 256
>  #define VDPASIM_VENDOR_ID 0
> +#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
> +#define VDPASIM_NOTIFY_DEFVAL 0xffff
>
>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>  {
> @@ -246,6 +254,28 @@ static const struct dma_map_ops vdpasim_dma_ops = {
>  static const struct vdpa_config_ops vdpasim_config_ops;
>  static const struct vdpa_config_ops vdpasim_batch_config_ops;
>
> +static void vdpasim_notify_work(struct work_struct *work)
> +{
> +       struct vdpasim *vdpasim;
> +       u16 *val;
> +
> +       vdpasim = container_of(work, struct vdpasim, notify_work.work);
> +
> +       if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +               goto out;
> +
> +       if (!vdpasim->running)
> +               goto out;
> +
> +       val = (u16 *)vdpasim->notify;
> +       if (xchg(val, VDPASIM_NOTIFY_DEFVAL) != VDPASIM_NOTIFY_DEFVAL)
> +               schedule_work(&vdpasim->work);
> +
> +out:
> +       schedule_delayed_work(&vdpasim->notify_work,
> +                             msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> +}
> +
>  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>                                const struct vdpa_dev_set_config *config)
>  {
> @@ -287,6 +317,18 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>         set_dma_ops(dev, &vdpasim_dma_ops);
>         vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
>
> +       if (notify_passthrough) {
> +               INIT_DELAYED_WORK(&vdpasim->notify_work, vdpasim_notify_work);
> +
> +               vdpasim->notify = __get_free_page(GFP_KERNEL | __GFP_ZERO);
> +               if (!vdpasim->notify)
> +                       goto err_iommu;
> +#ifdef CONFIG_X86
> +               set_memory_uc(vdpasim->notify, 1);
> +#endif

I had the same question with version 1, any reason for having this
part uncacheable? It's a hint that we have bugs somewhere. Are we
missing ACCESS/ORDER_PLATFORM or other features?

> +               *(u16 *)vdpasim->notify = VDPASIM_NOTIFY_DEFVAL;

WRITE_ONCE()?

> +       }
> +
>         vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
>         if (!vdpasim->config)
>                 goto err_iommu;
> @@ -495,6 +537,18 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
>         return status;
>  }
>
> +static void vdpasim_set_notify_work(struct vdpasim *vdpasim, bool start)
> +{
> +       if (!notify_passthrough)
> +               return;

Only two callers for this function: one is start another is stop. If
we decide to get rid of notify_passthrough, I'd rather opencode the
schedule/cancel_delayed().

Thanks

> +
> +       if (start)
> +               schedule_delayed_work(&vdpasim->notify_work,
> +                                     msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> +       else
> +               cancel_delayed_work_sync(&vdpasim->notify_work);
> +}
> +
>  static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> @@ -502,12 +556,14 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>         spin_lock(&vdpasim->lock);
>         vdpasim->status = status;
>         spin_unlock(&vdpasim->lock);
> +       vdpasim_set_notify_work(vdpasim, status & VIRTIO_CONFIG_S_DRIVER_OK);
>  }
>
>  static int vdpasim_reset(struct vdpa_device *vdpa, bool clear)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>
> +       vdpasim_set_notify_work(vdpasim, false);
>         spin_lock(&vdpasim->lock);
>         vdpasim->status = 0;
>         vdpasim_do_reset(vdpasim);
> @@ -672,11 +728,24 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
>         return 0;
>  }
>
> +static struct vdpa_notification_area
> +vdpasim_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> +{
> +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +       struct vdpa_notification_area notify;
> +
> +       notify.addr = virt_to_phys((void *)vdpasim->notify);
> +       notify.size = PAGE_SIZE;
> +
> +       return notify;
> +}
> +
>  static void vdpasim_free(struct vdpa_device *vdpa)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>         int i;
>
> +       vdpasim_set_notify_work(vdpasim, false);
>         cancel_work_sync(&vdpasim->work);
>
>         for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
> @@ -693,6 +762,12 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>         vhost_iotlb_free(vdpasim->iommu);
>         kfree(vdpasim->vqs);
>         kfree(vdpasim->config);
> +       if (vdpasim->notify) {
> +#ifdef CONFIG_X86
> +               set_memory_wb(vdpasim->notify, 1);
> +#endif
> +               free_page(vdpasim->notify);
> +       }
>  }
>
>  static const struct vdpa_config_ops vdpasim_config_ops = {
> @@ -704,6 +779,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .get_vq_ready           = vdpasim_get_vq_ready,
>         .set_vq_state           = vdpasim_set_vq_state,
>         .get_vq_state           = vdpasim_get_vq_state,
> +       .get_vq_notification    = vdpasim_get_vq_notification,
>         .get_vq_align           = vdpasim_get_vq_align,
>         .get_vq_group           = vdpasim_get_vq_group,
>         .get_device_features    = vdpasim_get_device_features,
> @@ -737,6 +813,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>         .get_vq_ready           = vdpasim_get_vq_ready,
>         .set_vq_state           = vdpasim_set_vq_state,
>         .get_vq_state           = vdpasim_get_vq_state,
> +       .get_vq_notification    = vdpasim_get_vq_notification,
>         .get_vq_align           = vdpasim_get_vq_align,
>         .get_vq_group           = vdpasim_get_vq_group,
>         .get_device_features    = vdpasim_get_device_features,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 0e78737dcc16..0769ccbd3911 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -69,6 +69,9 @@ struct vdpasim {
>         bool running;
>         /* spinlock to synchronize iommu table */
>         spinlock_t iommu_lock;
> +       /* dummy notify page */
> +       unsigned long notify;
> +       struct delayed_work notify_work;
>  };
>
>  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> --
> 2.23.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
