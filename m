Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA67BC4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 05:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A41D4044D;
	Fri, 16 Dec 2022 05:49:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A41D4044D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NcPjp5g8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BMJ9sKU--T5C; Fri, 16 Dec 2022 05:49:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7C31540327;
	Fri, 16 Dec 2022 05:49:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C31540327
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45753C0033;
	Fri, 16 Dec 2022 05:49:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 769F8C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A11A812D3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:49:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A11A812D3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NcPjp5g8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qjr9qVTr1DeG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:49:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EB6E812C8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EB6E812C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671169770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aIxBk+Msm4O13sjTb1QciX+1tHIiARlRWZY6qhgTpxM=;
 b=NcPjp5g8+wYRBRj/1EBtG+ZZD/iLcpUFJsXkefcfcvDp1A5Dtg96TQKzLV1OSVJDMNcX/m
 vJfbhvZlYCcxm95OpHB8Y1zhqLmjTt8GHWBphE8fsYkTb02Q8NNyhvlWdG5amiHZ9zRuHe
 TBAM3BZ551Nhjgd31QHPYeiwBoqBkzU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-173-5uXye_dYPvSfR51AhU28OQ-1; Fri, 16 Dec 2022 00:49:29 -0500
X-MC-Unique: 5uXye_dYPvSfR51AhU28OQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 r65-20020acaf344000000b0035a1d791805so401943oih.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 21:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aIxBk+Msm4O13sjTb1QciX+1tHIiARlRWZY6qhgTpxM=;
 b=SCOMQkI+tQ3U81M9gg7G+T90QkzinzmQf9cK1vYYdD82B8I6Mg315I4SI3jU74RAFa
 51hLWaHHI993dEZKxMOuUTaO3Ncvq7Rdjwc1P06HEaeKiS6e8icaw0gMzYl58ELr+Bpv
 JpHwBseKh2rogykOM4p5aRiGE3r/vx19bdEK27T771zDPURs5j5U1nbVnYCxBgC2uWCh
 Mj2zNFMFqOtMaxnT4hySd/IEtLUorbn0GQvyl42ldB1JgEOq79vHxCDVXKtgCn92iivE
 ryWSsuEbAT+phfPLY1pvWuPby21yXht/zc/AMhP7sS4p4WQcmXI2qtlheOdD9bUDq3oq
 UM9Q==
X-Gm-Message-State: ANoB5plFnM5GGAJ6ApF7za/XBc6lQp5n0SQt3Fy20vE2B027cr4CsGRA
 jI+y2Vm5qlY85DWRmalp4uDdQ2kvRqoFVcQqS/TUQBBe2iPx+08Smqe6O4MeSZM920dr9Me3Vyt
 BZW+G+y2xFBN8NWeQ/H22ZhsoqYsWyiXpoq9XlgP0o13hljQ9zKWtyLQ1Jw==
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr32532769ooo.93.1671169768089; 
 Thu, 15 Dec 2022 21:49:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7iVK4I0QZcV+xcZthATyPM9UgivZsjcVVMMo/iGffHKjvMHCvCJbHlwV7vNPss8IAsBwI4mYfnX3KBfB6bpFM=
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr32532762ooo.93.1671169767681; Thu, 15
 Dec 2022 21:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-4-xieyongji@bytedance.com>
In-Reply-To: <20221205090243.791-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 13:49:16 +0800
Message-ID: <CACGkMEtsk0R=NXNHaOzHgG+t9g8w5zmqt+J1KdXRGZQcFXWEkA@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] vduse: Delay iova domain creation
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Delay creating iova domain until the vduse device is binded
> to vdpa bus.

s/binded/registered/

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> This is a preparation for adding sysfs interface to support
> specifying bounce buffer size for the iova domain.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 75 +++++++++++++++++++++---------
>  1 file changed, 53 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index ed06c7afd484..bd1ba6c33e09 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -112,6 +112,8 @@ struct vduse_dev {
>         u32 vq_align;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
> +       unsigned int bounce_size;
> +       struct mutex domain_lock;
>  };
>
>  struct vduse_dev_msg {
> @@ -427,7 +429,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>         struct vduse_iova_domain *domain = dev->domain;
>
>         /* The coherent mappings are handled in vduse_dev_free_coherent() */
> -       if (domain->bounce_map)
> +       if (domain && domain->bounce_map)
>                 vduse_domain_reset_bounce_map(domain);
>
>         down_write(&dev->rwsem);
> @@ -1045,6 +1047,9 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
>                 goto unlock;
>
>         ret = -EINVAL;
> +       if (!dev->domain)
> +               goto unlock;
> +
>         if (dev->umem->iova != iova || size != dev->domain->bounce_size)
>                 goto unlock;
>
> @@ -1071,7 +1076,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
>         unsigned long npages, lock_limit;
>         int ret;
>
> -       if (!dev->domain->bounce_map ||
> +       if (!dev->domain || !dev->domain->bounce_map ||
>             size != dev->domain->bounce_size ||
>             iova != 0 || uaddr & ~PAGE_MASK)
>                 return -EINVAL;
> @@ -1145,7 +1150,6 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 struct vduse_iotlb_entry entry;
>                 struct vhost_iotlb_map *map;
>                 struct vdpa_map_file *map_file;
> -               struct vduse_iova_domain *domain = dev->domain;
>                 struct file *f = NULL;
>
>                 ret = -EFAULT;
> @@ -1156,8 +1160,13 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 if (entry.start > entry.last)
>                         break;
>
> -               spin_lock(&domain->iotlb_lock);
> -               map = vhost_iotlb_itree_first(domain->iotlb,
> +               mutex_lock(&dev->domain_lock);
> +               if (!dev->domain) {
> +                       mutex_unlock(&dev->domain_lock);
> +                       break;
> +               }
> +               spin_lock(&dev->domain->iotlb_lock);
> +               map = vhost_iotlb_itree_first(dev->domain->iotlb,
>                                               entry.start, entry.last);
>                 if (map) {
>                         map_file = (struct vdpa_map_file *)map->opaque;
> @@ -1167,7 +1176,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                         entry.last = map->last;
>                         entry.perm = map->perm;
>                 }
> -               spin_unlock(&domain->iotlb_lock);
> +               spin_unlock(&dev->domain->iotlb_lock);
> +               mutex_unlock(&dev->domain_lock);
>                 ret = -EINVAL;
>                 if (!f)
>                         break;
> @@ -1319,8 +1329,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                                  sizeof(umem.reserved)))
>                         break;
>
> +               mutex_lock(&dev->domain_lock);
>                 ret = vduse_dev_reg_umem(dev, umem.iova,
>                                          umem.uaddr, umem.size);
> +               mutex_unlock(&dev->domain_lock);
>                 break;
>         }
>         case VDUSE_IOTLB_DEREG_UMEM: {
> @@ -1334,15 +1346,15 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 if (!is_mem_zero((const char *)umem.reserved,
>                                  sizeof(umem.reserved)))
>                         break;
> -
> +               mutex_lock(&dev->domain_lock);
>                 ret = vduse_dev_dereg_umem(dev, umem.iova,
>                                            umem.size);
> +               mutex_unlock(&dev->domain_lock);
>                 break;
>         }
>         case VDUSE_IOTLB_GET_INFO: {
>                 struct vduse_iova_info info;
>                 struct vhost_iotlb_map *map;
> -               struct vduse_iova_domain *domain = dev->domain;
>
>                 ret = -EFAULT;
>                 if (copy_from_user(&info, argp, sizeof(info)))
> @@ -1356,18 +1368,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                                  sizeof(info.reserved)))
>                         break;
>
> -               spin_lock(&domain->iotlb_lock);
> -               map = vhost_iotlb_itree_first(domain->iotlb,
> +               mutex_lock(&dev->domain_lock);
> +               if (!dev->domain) {
> +                       mutex_unlock(&dev->domain_lock);
> +                       break;
> +               }
> +               spin_lock(&dev->domain->iotlb_lock);
> +               map = vhost_iotlb_itree_first(dev->domain->iotlb,
>                                               info.start, info.last);
>                 if (map) {
>                         info.start = map->start;
>                         info.last = map->last;
>                         info.capability = 0;
> -                       if (domain->bounce_map && map->start == 0 &&
> -                           map->last == domain->bounce_size - 1)
> +                       if (dev->domain->bounce_map && map->start == 0 &&
> +                           map->last == dev->domain->bounce_size - 1)
>                                 info.capability |= VDUSE_IOVA_CAP_UMEM;
>                 }
> -               spin_unlock(&domain->iotlb_lock);
> +               spin_unlock(&dev->domain->iotlb_lock);
> +               mutex_unlock(&dev->domain_lock);
>                 if (!map)
>                         break;
>
> @@ -1390,7 +1408,10 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
>  {
>         struct vduse_dev *dev = file->private_data;
>
> -       vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> +       mutex_lock(&dev->domain_lock);
> +       if (dev->domain)
> +               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> +       mutex_unlock(&dev->domain_lock);
>         spin_lock(&dev->msg_lock);
>         /* Make sure the inflight messages can processed after reconncection */
>         list_splice_init(&dev->recv_list, &dev->send_list);
> @@ -1647,6 +1668,7 @@ static struct vduse_dev *vduse_dev_create(void)
>
>         mutex_init(&dev->lock);
>         mutex_init(&dev->mem_lock);
> +       mutex_init(&dev->domain_lock);
>         spin_lock_init(&dev->msg_lock);
>         INIT_LIST_HEAD(&dev->send_list);
>         INIT_LIST_HEAD(&dev->recv_list);
> @@ -1696,7 +1718,8 @@ static int vduse_destroy_dev(char *name)
>         idr_remove(&vduse_idr, dev->minor);
>         kvfree(dev->config);
>         vduse_dev_deinit_vqs(dev);
> -       vduse_domain_destroy(dev->domain);
> +       if (dev->domain)
> +               vduse_domain_destroy(dev->domain);
>         kfree(dev->name);
>         vduse_dev_destroy(dev);
>         module_put(THIS_MODULE);
> @@ -1802,11 +1825,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>         if (!dev->name)
>                 goto err_str;
>
> -       dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> -                                         VDUSE_BOUNCE_SIZE);
> -       if (!dev->domain)
> -               goto err_domain;
> -
> +       dev->bounce_size = VDUSE_BOUNCE_SIZE;
>         dev->config = config_buf;
>         dev->config_size = config->config_size;
>
> @@ -1836,8 +1855,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  err_dev:
>         idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> -       vduse_domain_destroy(dev->domain);
> -err_domain:
>         kfree(dev->name);
>  err_str:
>         vduse_dev_destroy(dev);
> @@ -2004,9 +2021,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         if (ret)
>                 return ret;
>
> +       mutex_lock(&dev->domain_lock);
> +       if (!dev->domain)
> +               dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> +                                                 dev->bounce_size);
> +       mutex_unlock(&dev->domain_lock);
> +       if (!dev->domain) {
> +               put_device(&dev->vdev->vdpa.dev);
> +               return -ENOMEM;
> +       }
> +
>         ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
> +               mutex_lock(&dev->domain_lock);
> +               vduse_domain_destroy(dev->domain);
> +               dev->domain = NULL;
> +               mutex_unlock(&dev->domain_lock);
>                 return ret;
>         }
>
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
