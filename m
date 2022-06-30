Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1B0C43334
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 06:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A018440A6A;
	Thu, 30 Jun 2022 06:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A018440A6A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aB34Winu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FzRKuaEi3SKs; Thu, 30 Jun 2022 06:39:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EF2BF40926;
	Thu, 30 Jun 2022 06:39:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF2BF40926
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFFF9C0021;
	Thu, 30 Jun 2022 06:39:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 590ECC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C76760EF6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:39:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C76760EF6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aB34Winu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X9XCXor0eRRh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:39:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76B4F600C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76B4F600C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656571162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJ9PIxLLsVzCuVJJtdE0cxnl/Cjc0vCs0BsaA2nNYcE=;
 b=aB34Winu/D156bIStCjvVDN5cjEezUDmqIVIxb8fuDQv8Vr2QEBuxDTpH0aZmQDfZha2WF
 MtQVwWg2V4EnFdFb4oSkLD96f9bi+YGjA4AHs8gahfemgM26IXQyaG+71fx/1mKfAGkz2a
 X9uhlbD+RvF/ioPShPRPxh6iep179VA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-MdUZVomFOsiQIKfXWe_aOg-1; Thu, 30 Jun 2022 02:39:21 -0400
X-MC-Unique: MdUZVomFOsiQIKfXWe_aOg-1
Received: by mail-lf1-f70.google.com with SMTP id
 o7-20020a056512230700b004810a865709so6376240lfu.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 23:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pJ9PIxLLsVzCuVJJtdE0cxnl/Cjc0vCs0BsaA2nNYcE=;
 b=iP7yiEsk+cebqHF7lQpzIry6ifNBxNFWSOpns8k8Bp/ptwxWcgrSd8IFrSkT1EJ8kD
 5fIhrDCBmrlPOaI9kkI8HGsJGXAYsVZFs9QKK1oV7HYLhJO+nRGU6NAA5tCbu2DYuWKp
 rapR+rAEjhkicBG1RZwR5WKAoG+UkVo5uOXZxxcbQ4gQA1wnH5CFb0VveVq3vgha36jr
 9H35VDm8R8ZlW/TnHfhB7eJmhydgDwqp5SgkSu0gwsIJnBwVzNyPH5UjSZEzCd7zTF5S
 ULC/EH6UuPhQL40ZqNZE61M6JEz+bqz4I2HcI4FDmf1loAFdixwa+Hos0LgdVYGdysNH
 nDgQ==
X-Gm-Message-State: AJIora9UyS7FLw1ZzKXGbfxqN0ZdlnPfub6+HwQq7Vv5tRJ6fN7i32Yf
 p/hSWNo9LjpP9V8OyYBC/fIgFXbMWlxvAS+G5AnBEpL1PrN/JWfVUAoMYl9v9zY5PnPJn6Z/oQ0
 jRdoggJREhpqL+q2dWEhfTglOPFH7XlxSRnSo+jZEF4zSyJASB+jW+FBOyw==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr4440367lfa.124.1656571159803; 
 Wed, 29 Jun 2022 23:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tqG3rBVpPZppnWzT9+UoAeK5eCUmyrl/4NUFplfIBffY69P4EaE37IkoiuXbBcVcsUA6aouX0dtgCqbLTS49I=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr4440343lfa.124.1656571159618; Wed, 29
 Jun 2022 23:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220629065656.54420-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Jun 2022 14:39:08 +0800
Message-ID: <CACGkMEuM3rZwQ8dKUQovwpf+JVvp53SY=2ANVeKw746e3o0_xg@mail.gmail.com>
Subject: Re: [PATCH v11 02/40] virtio: struct virtio_config_ops add callbacks
 for queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm <kvm@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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

On Wed, Jun 29, 2022 at 2:57 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> reset can be divided into the following four steps (example):
>  1. transport: notify the device to reset the queue
>  2. vring:     recycle the buffer submitted
>  3. vring:     reset/resize the vring (may re-alloc)
>  4. transport: mmap vring to device, and enable the queue
>
> In order to support queue reset, add two callbacks(reset_vq,
> enable_reset_vq) in struct virtio_config_ops to implement steps 1 and 4.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_config.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b47c2e7ed0ee..ded51b0d4823 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -78,6 +78,16 @@ struct virtio_shm_region {
>   * @set_vq_affinity: set the affinity for a virtqueue (optional).
>   * @get_vq_affinity: get the affinity for a virtqueue (optional).
>   * @get_shm_region: get a shared memory region based on the index.
> + * @reset_vq: reset a queue individually (optional).
> + *     vq: the virtqueue
> + *     Returns 0 on success or error status
> + *     reset_vq will guarantee that the callbacks are disabled and synchronized.
> + *     Except for the callback, the caller should guarantee that the vring is
> + *     not accessed by any functions of virtqueue.
> + * @enable_reset_vq: enable a reset queue
> + *     vq: the virtqueue
> + *     Returns 0 on success or error status
> + *     If reset_vq is set, then enable_reset_vq must also be set.
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> @@ -104,6 +114,8 @@ struct virtio_config_ops {
>                         int index);
>         bool (*get_shm_region)(struct virtio_device *vdev,
>                                struct virtio_shm_region *region, u8 id);
> +       int (*reset_vq)(struct virtqueue *vq);
> +       int (*enable_reset_vq)(struct virtqueue *vq);

I wonder if a single op with a boolean parameter is sufficient here.

Thanks

>  };
>
>  /* If driver didn't advertise the feature, it will never appear. */
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
