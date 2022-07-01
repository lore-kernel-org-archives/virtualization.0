Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8510ACCA479
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 06:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FC8A60759;
	Fri,  1 Jul 2022 06:31:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FC8A60759
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bU69NfJk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5M_5S0oegOde; Fri,  1 Jul 2022 06:31:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A1543600B8;
	Fri,  1 Jul 2022 06:31:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1543600B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8196CC0035;
	Fri,  1 Jul 2022 06:31:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 701AAC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BDF760759
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:31:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BDF760759
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rAX9BMPdAoQf
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:31:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DC8B600B8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DC8B600B8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656657090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t4mq0djcD9YM3JASrOeZhnSSARiulyBSa0GkqeNjlYw=;
 b=bU69NfJkl5wzR+EZzFFH60Ir/vJFkdIgIPJSQ/qMrTms5mUlkH+afpUGD7tFdhF6h9cNY2
 U9G5BLTc1b7pd3N11TT8o1x+oqy7DJFnQyX43CGUnOb/9rbmRWVKZQM15mR8nw5RFxUtml
 pXN6tL60gxtp4xpxuQuDE/cCTTRG9w8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-t-Utz2zwOMmYi_m3GqWTzA-1; Fri, 01 Jul 2022 02:31:27 -0400
X-MC-Unique: t-Utz2zwOMmYi_m3GqWTzA-1
Received: by mail-ed1-f69.google.com with SMTP id
 z13-20020a056402274d00b004357fcdd51fso1085649edd.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 23:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t4mq0djcD9YM3JASrOeZhnSSARiulyBSa0GkqeNjlYw=;
 b=OXbXHRCLLRCIV5DqWSAy02jLF1WLQKv8ksNQxMgICyuOCKduuAPdZ4kgD/pjmFKi9O
 j5WuoDx0Op6pgPqfzKrFy/i47FnGhMrSj4XV+59I+kuVwrkfZrrUP6SwTTBQtyoTvgP9
 hWIbAuIx17x0N75vLfbwF6Oou/zL0bM+B/7HokYUo97FaTH1GprdcmhILM0d+gF2PCF7
 WeAEkcmPGnO8rNYnunRPvIZI2+GBcoxWKcDi3q15do/V8i1ZCJALOzxz7H4SQnFJrt8q
 kBT0+NdrjAF0n4gC+BnJ45MvraTpKVSsk06S6dn1apFfX2AzVBnmp5hJRGmgRwsjClyY
 WT8g==
X-Gm-Message-State: AJIora8WcR9j12IPq6d2+WH5UgBoUaNr5WkYSqRReEkaZfu2cD3UKn8+
 DKPXmt+9h91MAC/gJWbvjC7mnD/RMN4ek/YcQEqVbgfGTCNSwOD79lBbbuBiOi5uuC7DEZ/MTUS
 ikPxSZ5PkX+qmwyxsXCEVJMlqxe+Ii+iDJCoNdPGQog==
X-Received: by 2002:a17:907:2704:b0:72a:596f:8b9f with SMTP id
 w4-20020a170907270400b0072a596f8b9fmr7711911ejk.761.1656657086007; 
 Thu, 30 Jun 2022 23:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uBC6Csq0KK3mHQr921uHGRsVzPm9YamAGsOXqm/7tt8aIzVOGmGN35oK+8gpDy+vr5kzch1Q==
X-Received: by 2002:a17:907:2704:b0:72a:596f:8b9f with SMTP id
 w4-20020a170907270400b0072a596f8b9fmr7711894ejk.761.1656657085791; 
 Thu, 30 Jun 2022 23:31:25 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 ia10-20020a170907a06a00b0070b7875aa6asm9874051ejc.166.2022.06.30.23.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 23:31:25 -0700 (PDT)
Date: Fri, 1 Jul 2022 02:31:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
Message-ID: <20220701022950-mutt-send-email-mst@kernel.org>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
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

On Wed, Jun 29, 2022 at 02:56:41PM +0800, Xuan Zhuo wrote:
> This patch allows the new introduced
> __virtqueue_break()/__virtqueue_unbreak() to break/unbreak the
> virtqueue.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I wonder how this interacts with the hardening patches.
Jason?

> ---
>  drivers/virtio/virtio_ring.c | 24 ++++++++++++++++++++++++
>  include/linux/virtio.h       |  3 +++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 5ec43607cc15..7b02be7fce67 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2744,6 +2744,30 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>  
> +/*
> + * This function should only be called by the core, not directly by the driver.
> + */
> +void __virtqueue_break(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +	WRITE_ONCE(vq->broken, true);
> +}
> +EXPORT_SYMBOL_GPL(__virtqueue_break);
> +
> +/*
> + * This function should only be called by the core, not directly by the driver.
> + */
> +void __virtqueue_unbreak(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +	WRITE_ONCE(vq->broken, false);
> +}

I don't think these "Pairs" comments have any value.


> +EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
> +
>  bool virtqueue_is_broken(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 1272566adec6..dc474a0d48d1 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -138,6 +138,9 @@ bool is_virtio_device(struct device *dev);
>  void virtio_break_device(struct virtio_device *dev);
>  void __virtio_unbreak_device(struct virtio_device *dev);
>  
> +void __virtqueue_break(struct virtqueue *_vq);
> +void __virtqueue_unbreak(struct virtqueue *_vq);
> +
>  void virtio_config_changed(struct virtio_device *dev);
>  #ifdef CONFIG_PM_SLEEP
>  int virtio_device_freeze(struct virtio_device *dev);
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
