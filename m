Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F1CC433FE
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 04:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D379A40647;
	Wed, 16 Feb 2022 04:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uAZSPIJEPm3G; Wed, 16 Feb 2022 04:14:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 09A984010E;
	Wed, 16 Feb 2022 04:14:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D02D7C001A;
	Wed, 16 Feb 2022 04:14:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 809C1C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 626B8813B6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E9mwyY54vsBH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7178E80C52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644984858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vZzXDlkg8qpp836DOF70vnwiHmJbthJI/zN4W9Z2xN8=;
 b=EzdNMmtv5Rd/qO95LWSBe5maMaYMu6wMmHd8lLeXFREnlEwQpCWUNF0ydUfPaDdcXdjeuk
 K0Dpk/5DbGS6MfBCnHOCV49yRUd+2kWWmhfnkURhPBniwYYMem330KktIAolqONJOCfDNs
 2Fx75dqlUHkcCXt6FcAbNuGMS23bSVk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-eStY3edHM72Wqa2n9eyRCw-1; Tue, 15 Feb 2022 23:14:16 -0500
X-MC-Unique: eStY3edHM72Wqa2n9eyRCw-1
Received: by mail-lj1-f197.google.com with SMTP id
 p10-20020a2ea4ca000000b0023c8545494fso466282ljm.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 20:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vZzXDlkg8qpp836DOF70vnwiHmJbthJI/zN4W9Z2xN8=;
 b=tyzFfSc8kndorZV75VmqfTw9306KBd0/HiG9ci4J8lgIuto1ud3QMl6ZyyKTZKyCbV
 euKtD5cgpoTs0LNbdOb+oLosYjUh+sxFPunD1z5hTOxENh3jt45tUVukS46m5su6F7CG
 4hLwapieZ7a1S1uU12BS7NTR+p69KYCAuDyYkUe2KRkdCJtfaQDBYB07a3lPayk7VxTk
 ASxBRoWfTZsdYWXBb6WOB0QNmkgQasAE639ry406CGOwfFlb8touTx1UP4LqxyvfBpYq
 gFVR9DKHQoQedvdb7RCQjUFj0Bh+hetCvt3t4dks69CXEzWsilm9vMWStTfALN1rnPSR
 JFhQ==
X-Gm-Message-State: AOAM5330wSennC4jrA8j5AUUznSI0b/chCX+ENI/5SuufkhemjPG4RF3
 Pa5bLavkyWU7LI9PQXGFTSkI1Yo20L/4MBV3bfj550j8g3FlHrDlopKCK04SNoZRN9eCaINf4yJ
 HzpFYhTyP3Ok6XeXy4ficnfMMgnjdCokQhUHcEAdxw4LqM4t7bk6rbu96mA==
X-Received: by 2002:ac2:5052:0:b0:443:1466:54d1 with SMTP id
 a18-20020ac25052000000b00443146654d1mr695782lfm.348.1644984855372; 
 Tue, 15 Feb 2022 20:14:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCAG1I3PjRcaajqL3n64IiD74nD8SpMkMRtyRZkpOu/QbR/KwjGOeEPPB35QpIuFZlxJwaBkCDwPf6m6r5XE8=
X-Received: by 2002:ac2:5052:0:b0:443:1466:54d1 with SMTP id
 a18-20020ac25052000000b00443146654d1mr695771lfm.348.1644984855160; Tue, 15
 Feb 2022 20:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-20-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-20-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Feb 2022 12:14:04 +0800
Message-ID: <CACGkMEsdySbtHN4SNSmX8sD6Y7S=dj3oxq5a3EBhRG1qUeT24A@mail.gmail.com>
Subject: Re: [PATCH v5 19/22] virtio: add helper virtio_set_max_ring_num()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Feb 14, 2022 at 4:15 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Added helper virtio_set_max_ring_num() to set the upper limit of ring
> num when creating a virtqueue.
>
> Can be used to limit ring num before find_vqs() call. Or change ring num
> when re-enable reset queue.

Do we have a chance that RX and TX may want different ring size? If
yes, it might be even better to have per vq limit via find_vqs()?

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c  |  6 ++++++
>  include/linux/virtio.h        |  1 +
>  include/linux/virtio_config.h | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1a123b5e5371..a77a82883e44 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -943,6 +943,9 @@ static struct virtqueue *vring_create_virtqueue_split(
>         size_t queue_size_in_bytes;
>         struct vring vring;
>
> +       if (vdev->max_ring_num && num > vdev->max_ring_num)
> +               num = vdev->max_ring_num;
> +
>         /* We assume num is a power of 2. */
>         if (num & (num - 1)) {
>                 dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
> @@ -1692,6 +1695,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
>         size_t ring_size_in_bytes, event_size_in_bytes;
>
> +       if (vdev->max_ring_num && num > vdev->max_ring_num)
> +               num = vdev->max_ring_num;
> +
>         ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
>
>         ring = vring_alloc_queue(vdev, ring_size_in_bytes,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 1153b093c53d..45525beb2ec4 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -127,6 +127,7 @@ struct virtio_device {
>         struct list_head vqs;
>         u64 features;
>         void *priv;
> +       u16 max_ring_num;
>  };
>
>  static inline struct virtio_device *dev_to_virtio(struct device *_dev)
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index cd7f7f44ce38..d7cb2d0341ee 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -200,6 +200,36 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>         return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
>  }
>
> +/**
> + * virtio_set_max_ring_num - set max ring num
> + * @vdev: the device
> + * @num: max ring num. Zero clear the limit.
> + *
> + * When creating a virtqueue, use this value as the upper limit of ring num.
> + *
> + * Returns 0 on success or error status
> + */
> +static inline
> +int virtio_set_max_ring_num(struct virtio_device *vdev, u16 num)
> +{

Having a dedicated helper for a per device parameter usually means the
use cases are greatly limited. For example, this seems can only be
used when DRIVER_OK is not set?

And in patch 17 this function is called even if we only modify the RX
size, this is probably another call for a more flexible API as I
suggest like exporting vring allocation/deallocation helper and extend
find_vqs()?

Thanks


> +       if (!num) {
> +               vdev->max_ring_num = num;
> +               return 0;
> +       }
> +
> +       if (!virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +               if (!is_power_of_2(num)) {
> +                       num = __rounddown_pow_of_two(num);
> +
> +                       if (!num)
> +                               return -EINVAL;
> +               }
> +       }
> +
> +       vdev->max_ring_num = num;
> +       return 0;
> +}
> +
>  static inline
>  struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
>                                         vq_callback_t *c, const char *n)
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
