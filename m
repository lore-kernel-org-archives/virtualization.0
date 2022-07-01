Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5950ACCA480
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 06:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C970F600C6;
	Fri,  1 Jul 2022 06:29:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C970F600C6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SS1HgDTI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U0sgdWWA1D1j; Fri,  1 Jul 2022 06:29:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3534F600B8;
	Fri,  1 Jul 2022 06:29:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3534F600B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13C91C0035;
	Fri,  1 Jul 2022 06:29:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40A0FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AF8581426
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:28:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AF8581426
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SS1HgDTI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qeBbyxWrLNvD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53A29813E3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53A29813E3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656656936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ep21GC3WWMrq7ZTqF7foficvymTnhxBLuGKtrZfIeyk=;
 b=SS1HgDTIFVH2zgSXAMsjs2vhgS3F3OCBjq033wDVLO7BHQhtoLmlerdi1uvPEh5NRF87CZ
 fvW6D/it5hbG4HEeNY05+qdqDFPDq0vuvLmTYCmaXnbPRDAfUPm/xAXJKmU1stg5IMTT/f
 +giqnl3ym/jg1Dwn1r1yaj9V0ilhs2Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495--Ke5utV5NFylcfzHPrRKrg-1; Fri, 01 Jul 2022 02:28:55 -0400
X-MC-Unique: -Ke5utV5NFylcfzHPrRKrg-1
Received: by mail-ej1-f70.google.com with SMTP id
 kv9-20020a17090778c900b007262b461ecdso350270ejc.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 23:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ep21GC3WWMrq7ZTqF7foficvymTnhxBLuGKtrZfIeyk=;
 b=c/s7VLppTnzrmKS6FnN8HYBML5Jt/17DDRuTvEdziJb5dLbB1oDBycE+l7Tujfsf6y
 d2KDcze7FaEZSrqTfCuLA598luBW/ypHqv9c9Si9ZbJxeTERHRBptRBk/dcDXXY97VaB
 IFn4AcPkYaxvmajGy3ebDO83Zu/CoO8pX3pgSYt5CLeD8YzOiUJE9Pxmbs+zxaHPNKeT
 Zv8BXeF7ACoaFVzuta09hS7mxVB78HO/A2FZli6FMHJeuV57YDrDlpXeVZ9ydbK5qZo8
 PxrU//Y4yS6XPrO0V+vjE/zNcEfJBW7rjZ031UuJQ84JN5eXM9waL8tW840MI/DYklh8
 h77g==
X-Gm-Message-State: AJIora9byC+VSw/wKGXFv1BAKUcYSefw25Q2gvoCItChTbRgrcRu/cq6
 tjAmZ75eS12cL2n0asDiLWWZiXazDMnsba8KtGt8VnNIqCyVRX2ZDpYqJlheA5BWokzA4XDX3vv
 GG55H4xRbplPWAzWKtJX6vIHbmRTDtHX+rPo4l9r5Ag==
X-Received: by 2002:a17:907:a428:b0:726:c9f6:cb72 with SMTP id
 sg40-20020a170907a42800b00726c9f6cb72mr12254049ejc.663.1656656933871; 
 Thu, 30 Jun 2022 23:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slJK/GfjvEb+V/KlSodwyGrJY9IlEvcE76Gj4Vrg2HN6t0BznA8dFZxHAHBftC/lU4lpUOHg==
X-Received: by 2002:a17:907:a428:b0:726:c9f6:cb72 with SMTP id
 sg40-20020a170907a42800b00726c9f6cb72mr12254030ejc.663.1656656933627; 
 Thu, 30 Jun 2022 23:28:53 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 a23-20020aa7d757000000b00437df2444f5sm3589564eds.11.2022.06.30.23.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 23:28:53 -0700 (PDT)
Date: Fri, 1 Jul 2022 02:28:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 02/40] virtio: struct virtio_config_ops add callbacks
 for queue_reset
Message-ID: <20220701022728-mutt-send-email-mst@kernel.org>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220629065656.54420-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
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

On Wed, Jun 29, 2022 at 02:56:18PM +0800, Xuan Zhuo wrote:
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
> + *	vq: the virtqueue
> + *	Returns 0 on success or error status
> + *	reset_vq will guarantee that the callbacks are disabled and synchronized.
> + *	Except for the callback, the caller should guarantee that the vring is
> + *	not accessed by any functions of virtqueue.
> + * @enable_reset_vq: enable a reset queue
> + *	vq: the virtqueue
> + *	Returns 0 on success or error status
> + *	If reset_vq is set, then enable_reset_vq must also be set.
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> @@ -104,6 +114,8 @@ struct virtio_config_ops {
>  			int index);
>  	bool (*get_shm_region)(struct virtio_device *vdev,
>  			       struct virtio_shm_region *region, u8 id);
> +	int (*reset_vq)(struct virtqueue *vq);
> +	int (*enable_reset_vq)(struct virtqueue *vq);
>  };

The names need some tweaking.
I came up with
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);


>  /* If driver didn't advertise the feature, it will never appear. */
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
