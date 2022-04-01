Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9995EC433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Apr 2022 04:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36841404B7;
	Fri,  1 Apr 2022 04:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XWJkLi2xNEV; Fri,  1 Apr 2022 04:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7A90640126;
	Fri,  1 Apr 2022 04:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B415C001D;
	Fri,  1 Apr 2022 04:24:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7EEAC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 04:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8167284483
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 04:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_C-4U0Lgemq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 04:24:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5400C84480
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 04:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648787091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ngfjwdhVZSu9Mc3F7Z2MPp/um/FKqEmWpTPRXSs708=;
 b=KNSy7sxg3b8OPznzRvBR5AbvghRoddpfAefQDLC2NYZsPShgquVXVad5OLrO2GKrBVAdwG
 TwyXSkCv+V4R7HPRkDH7C1wzg3klxTpQpWEOFqDBl6QwV5j9BPMpb7xZ9ZC0Yof4Zt/pqB
 Qq1gfgdAeWdCQMJ0cUW96uwn9p2RTFQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-aGXqXydIMeO-jBRgpfwj5Q-1; Fri, 01 Apr 2022 00:24:48 -0400
X-MC-Unique: aGXqXydIMeO-jBRgpfwj5Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 u29-20020ac251dd000000b0044a245bcc1aso709392lfm.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 21:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2ngfjwdhVZSu9Mc3F7Z2MPp/um/FKqEmWpTPRXSs708=;
 b=S12nfTNwIrGmZIm5Mc0w+9RxH3vC6xD70jFKPZxW/irFgbZspA2FoBCd9Dl3Vo+X9Z
 o1UirN3oS/fvFiQUlGwd4RIf8MB7tvBPTp+sJuz2Bf6cYFdkcVXPEW5JvYsdpTstSzga
 5y9oYFspc9iZf43lFvvG4VWk7/ZkFGZ4BDek3RpyOXwSYVBVYUm56jTnON4N3PBc1vgQ
 RLjdansCHu0egWOgbqai25tfGI3Sf5PtkixwIfxdvNQHJt0Z8m+SwQaoMx9jR1cj8/XR
 2uRiIla2JRlT0c18ncCokKoxINjTstrav9SLfDzAyNXBrLKFhsMGjijWvhm48yRjojLt
 Khhw==
X-Gm-Message-State: AOAM533Yw+IFEXSAyRxWHYXj5b8RLnZqA5SMw1l59k+snub0U3YAKH71
 lrzsbac4CbyjNzkOtTmsXtbce19B56P6tjDQNeaSvMc6NhWR+IbNJ2zNIF25Weh244/cq9Dcbw1
 GopDEH6LX7YVqj5qxS9iwdqjYr8VBWpzBLJKFpbv/pU8MN2zSiQfnN6WBfQ==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr12490039lfa.210.1648787087299; 
 Thu, 31 Mar 2022 21:24:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9R2mzN/stqtfZWnKEocfbmqN5IU2O2NX6QZ4/iAncqxL9S9h+PhStfyraQ1/OGqGXcE8DbSQ65e20i4S9MOA=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr12490018lfa.210.1648787086976; Thu, 31
 Mar 2022 21:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220330180436.24644-1-gdawar@xilinx.com>
 <20220330180436.24644-16-gdawar@xilinx.com>
In-Reply-To: <20220330180436.24644-16-gdawar@xilinx.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Apr 2022 12:24:35 +0800
Message-ID: <CACGkMEvL3rFaw9WP2ARmEkY4t-VppJ73NnapdUgwO=vCZ_Eg6A@mail.gmail.com>
Subject: Re: [PATCH v2 15/19] vhost-vdpa: support ASID based IOTLB API
To: Gautam Dawar <gautam.dawar@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: tanuj.kamde@amd.com, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 pabloc@xilinx.com, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, eperezma <eperezma@redhat.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Gautam Dawar <gdawar@xilinx.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 Martin Porter <martinpo@xilinx.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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

On Thu, Mar 31, 2022 at 2:17 AM Gautam Dawar <gautam.dawar@xilinx.com> wrote:
>
> This patch extends the vhost-vdpa to support ASID based IOTLB API. The
> vhost-vdpa device will allocated multiple IOTLBs for vDPA device that
> supports multiple address spaces. The IOTLBs and vDPA device memory
> mappings is determined and maintained through ASID.
>
> Note that we still don't support vDPA device with more than one
> address spaces that depends on platform IOMMU. This work will be done
> by moving the IOMMU logic from vhost-vDPA to vDPA device driver.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>
> ---
>  drivers/vhost/vdpa.c  | 109 ++++++++++++++++++++++++++++++++++--------
>  drivers/vhost/vhost.c |   2 +-
>  2 files changed, 91 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6c7ee0f18892..1f1d1c425573 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -28,7 +28,8 @@
>  enum {
>         VHOST_VDPA_BACKEND_FEATURES =
>         (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2) |
> -       (1ULL << VHOST_BACKEND_F_IOTLB_BATCH),
> +       (1ULL << VHOST_BACKEND_F_IOTLB_BATCH) |
> +       (1ULL << VHOST_BACKEND_F_IOTLB_ASID),
>  };
>
>  #define VHOST_VDPA_DEV_MAX (1U << MINORBITS)
> @@ -57,12 +58,20 @@ struct vhost_vdpa {
>         struct eventfd_ctx *config_ctx;
>         int in_batch;
>         struct vdpa_iova_range range;
> +       u32 batch_asid;
>  };
>
>  static DEFINE_IDA(vhost_vdpa_ida);
>
>  static dev_t vhost_vdpa_major;
>
> +static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
> +{
> +       struct vhost_vdpa_as *as = container_of(iotlb, struct
> +                                               vhost_vdpa_as, iotlb);
> +       return as->id;
> +}
> +
>  static struct vhost_vdpa_as *asid_to_as(struct vhost_vdpa *v, u32 asid)
>  {
>         struct hlist_head *head = &v->as[asid % VHOST_VDPA_IOTLB_BUCKETS];
> @@ -75,6 +84,16 @@ static struct vhost_vdpa_as *asid_to_as(struct vhost_vdpa *v, u32 asid)
>         return NULL;
>  }
>
> +static struct vhost_iotlb *asid_to_iotlb(struct vhost_vdpa *v, u32 asid)
> +{
> +       struct vhost_vdpa_as *as = asid_to_as(v, asid);
> +
> +       if (!as)
> +               return NULL;
> +
> +       return &as->iotlb;
> +}
> +
>  static struct vhost_vdpa_as *vhost_vdpa_alloc_as(struct vhost_vdpa *v, u32 asid)
>  {
>         struct hlist_head *head = &v->as[asid % VHOST_VDPA_IOTLB_BUCKETS];
> @@ -83,6 +102,9 @@ static struct vhost_vdpa_as *vhost_vdpa_alloc_as(struct vhost_vdpa *v, u32 asid)
>         if (asid_to_as(v, asid))
>                 return NULL;
>
> +       if (asid >= v->vdpa->nas)
> +               return NULL;
> +
>         as = kmalloc(sizeof(*as), GFP_KERNEL);
>         if (!as)
>                 return NULL;
> @@ -94,6 +116,17 @@ static struct vhost_vdpa_as *vhost_vdpa_alloc_as(struct vhost_vdpa *v, u32 asid)
>         return as;
>  }
>
> +static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
> +                                                     u32 asid)
> +{
> +       struct vhost_vdpa_as *as = asid_to_as(v, asid);
> +
> +       if (as)
> +               return as;
> +
> +       return vhost_vdpa_alloc_as(v, asid);
> +}
> +
>  static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>  {
>         struct vhost_vdpa_as *as = asid_to_as(v, asid);
> @@ -692,6 +725,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>         struct vhost_dev *dev = &v->vdev;
>         struct vdpa_device *vdpa = v->vdpa;
>         const struct vdpa_config_ops *ops = vdpa->config;
> +       u32 asid = iotlb_to_asid(iotlb);
>         int r = 0;
>
>         r = vhost_iotlb_add_range_ctx(iotlb, iova, iova + size - 1,
> @@ -700,10 +734,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>                 return r;
>
>         if (ops->dma_map) {
> -               r = ops->dma_map(vdpa, 0, iova, size, pa, perm, opaque);
> +               r = ops->dma_map(vdpa, asid, iova, size, pa, perm, opaque);
>         } else if (ops->set_map) {
>                 if (!v->in_batch)
> -                       r = ops->set_map(vdpa, 0, iotlb);
> +                       r = ops->set_map(vdpa, asid, iotlb);
>         } else {
>                 r = iommu_map(v->domain, iova, pa, size,
>                               perm_to_iommu_flags(perm));
> @@ -725,17 +759,24 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
>  {
>         struct vdpa_device *vdpa = v->vdpa;
>         const struct vdpa_config_ops *ops = vdpa->config;
> +       u32 asid = iotlb_to_asid(iotlb);
>
>         vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1);
>
>         if (ops->dma_map) {
> -               ops->dma_unmap(vdpa, 0, iova, size);
> +               ops->dma_unmap(vdpa, asid, iova, size);
>         } else if (ops->set_map) {
>                 if (!v->in_batch)
> -                       ops->set_map(vdpa, 0, iotlb);
> +                       ops->set_map(vdpa, asid, iotlb);
>         } else {
>                 iommu_unmap(v->domain, iova, size);
>         }
> +
> +       /* If we are in the middle of batch processing, delay the free
> +        * of AS until BATCH_END.
> +        */
> +       if (!v->in_batch && !iotlb->nmaps)
> +               vhost_vdpa_remove_as(v, asid);
>  }
>
>  static int vhost_vdpa_va_map(struct vhost_vdpa *v,
> @@ -943,19 +984,38 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>         struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
>         struct vdpa_device *vdpa = v->vdpa;
>         const struct vdpa_config_ops *ops = vdpa->config;
> -       struct vhost_vdpa_as *as = asid_to_as(v, 0);
> -       struct vhost_iotlb *iotlb = &as->iotlb;
> +       struct vhost_iotlb *iotlb = NULL;
> +       struct vhost_vdpa_as *as = NULL;
>         int r = 0;
>
> -       if (asid != 0)
> -               return -EINVAL;
> -
>         mutex_lock(&dev->mutex);
>
>         r = vhost_dev_check_owner(dev);
>         if (r)
>                 goto unlock;
>
> +       if (msg->type == VHOST_IOTLB_UPDATE ||
> +           msg->type == VHOST_IOTLB_BATCH_BEGIN) {
> +               as = vhost_vdpa_find_alloc_as(v, asid);

I wonder if it's better to mandate the ASID to [0, dev->nas),
otherwise user space is free to use arbitrary IDs which may exceeds
the #address spaces that is supported by the device.

Thanks

> +               if (!as) {
> +                       dev_err(&v->dev, "can't find and alloc asid %d\n",
> +                               asid);
> +                       return -EINVAL;
> +               }
> +               iotlb = &as->iotlb;
> +       } else
> +               iotlb = asid_to_iotlb(v, asid);
> +
> +       if ((v->in_batch && v->batch_asid != asid) || !iotlb) {
> +               if (v->in_batch && v->batch_asid != asid) {
> +                       dev_info(&v->dev, "batch id %d asid %d\n",
> +                                v->batch_asid, asid);
> +               }
> +               if (!iotlb)
> +                       dev_err(&v->dev, "no iotlb for asid %d\n", asid);
> +               return -EINVAL;
> +       }
> +
>         switch (msg->type) {
>         case VHOST_IOTLB_UPDATE:
>                 r = vhost_vdpa_process_iotlb_update(v, iotlb, msg);
> @@ -964,12 +1024,15 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>                 vhost_vdpa_unmap(v, iotlb, msg->iova, msg->size);
>                 break;
>         case VHOST_IOTLB_BATCH_BEGIN:
> +               v->batch_asid = asid;
>                 v->in_batch = true;
>                 break;
>         case VHOST_IOTLB_BATCH_END:
>                 if (v->in_batch && ops->set_map)
> -                       ops->set_map(vdpa, 0, iotlb);
> +                       ops->set_map(vdpa, asid, iotlb);
>                 v->in_batch = false;
> +               if (!iotlb->nmaps)
> +                       vhost_vdpa_remove_as(v, asid);
>                 break;
>         default:
>                 r = -EINVAL;
> @@ -1057,9 +1120,17 @@ static void vhost_vdpa_set_iova_range(struct vhost_vdpa *v)
>
>  static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
>  {
> +       struct vhost_vdpa_as *as;
> +       u32 asid;
> +
>         vhost_dev_cleanup(&v->vdev);
>         kfree(v->vdev.vqs);
> -       vhost_vdpa_remove_as(v, 0);
> +
> +       for (asid = 0; asid < v->vdpa->nas; asid++) {
> +               as = asid_to_as(v, asid);
> +               if (as)
> +                       vhost_vdpa_remove_as(v, asid);
> +       }
>  }
>
>  static int vhost_vdpa_open(struct inode *inode, struct file *filep)
> @@ -1095,12 +1166,9 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>         vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
>                        vhost_vdpa_process_iotlb_msg);
>
> -       if (!vhost_vdpa_alloc_as(v, 0))
> -               goto err_alloc_as;
> -
>         r = vhost_vdpa_alloc_domain(v);
>         if (r)
> -               goto err_alloc_as;
> +               goto err_alloc_domain;
>
>         vhost_vdpa_set_iova_range(v);
>
> @@ -1108,7 +1176,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>
>         return 0;
>
> -err_alloc_as:
> +err_alloc_domain:
>         vhost_vdpa_cleanup(v);
>  err:
>         atomic_dec(&v->opened);
> @@ -1233,8 +1301,11 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>         int minor;
>         int i, r;
>
> -       /* Only support 1 address space and 1 groups */
> -       if (vdpa->ngroups != 1 || vdpa->nas != 1)
> +       /* We can't support platform IOMMU device with more than 1
> +        * group or as
> +        */
> +       if (!ops->set_map && !ops->dma_map &&
> +           (vdpa->ngroups > 1 || vdpa->nas > 1))
>                 return -EOPNOTSUPP;
>
>         v = kzalloc(sizeof(*v), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d1e58f976f6e..5022c648d9c0 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1167,7 +1167,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>                                 ret = -EINVAL;
>                                 goto done;
>                         }
> -                       offset = sizeof(__u16);
> +                       offset = 0;
>                 } else
>                         offset = sizeof(__u32);
>                 break;
> --
> 2.30.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
