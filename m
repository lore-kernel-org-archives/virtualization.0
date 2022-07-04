Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236B7C43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 19:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D49A60FF4;
	Mon,  4 Jul 2022 19:06:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D49A60FF4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JpzxlYJc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0EZg6MTELt7Z; Mon,  4 Jul 2022 19:06:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC58C606ED;
	Mon,  4 Jul 2022 19:06:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC58C606ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A90D5C0032;
	Mon,  4 Jul 2022 19:06:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4531C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 19:06:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADC478144E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 19:06:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADC478144E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JpzxlYJc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jiHj7rKVvots
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 19:06:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E79F281417
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E79F281417
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 19:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656961606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WfXQYFuDfrhz+WVvDK9xALG3EwqA/PP/d2XZNB+VRI8=;
 b=JpzxlYJcBXvQeiEKNcgxUdfUDvudYZ9qwlzyXZAjsca34CTi/gBUjqqfB9lJYLIxA8InDf
 Yt3qEMY4qbe9WPOLn+Q4M5zwoR8vTDmNkj9fHcQkxBp1A7fhI9Ufo1l2YADDegXmxm1c7r
 BR7SQhfCbr1VrJYohaSdSRW2TZ60o00=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-GemFiDLQPeOEhECR2aYrTQ-1; Mon, 04 Jul 2022 15:06:45 -0400
X-MC-Unique: GemFiDLQPeOEhECR2aYrTQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 r12-20020a05640251cc00b00435afb01d7fso7689162edd.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 12:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WfXQYFuDfrhz+WVvDK9xALG3EwqA/PP/d2XZNB+VRI8=;
 b=ZgmqdqyvjU48210RZ0TkLVUGXiCVPUcbtZnopRUuHRNLcPVEV9Q59yV7c5rgXdOV9A
 uUZee8onquqjuJkONRhnk7Fbqg5QqzwJ8I/ixdzqPL/aoH/+vHB9B/nIGxrQ53LZAU4V
 A1pYbWKPgIVZ+a4QZvOA6KNvvdw4BtcZzvjbURJXeeB6OqjeqvE8ojoTAU1wEvaHkhp1
 2WRrOn0IpSMgsVFbWIIYOJCXo8lBa0aN2VbB9oZCnTQ5dZ9Canh1CUlcuBLYHm7GrSrJ
 89t2jaHcmvp01ON97gpu6CXvD6rXDH/K9oH6OI8nHkUHraHae8iHRbnVsz2VcZJgA6z9
 Q+QA==
X-Gm-Message-State: AJIora+KyZVRgVBocgGfYb/f6ZCHmODRNe5Z+ANutNBGr2G+j+mh/B2M
 PQOcWzQWNspI/vO1QxAjpmceruRwL+D+xy2n++ny2+smTA33jC0+kZeCaj9pwh48LpN5/B715Tv
 bZpI3yAsDi+QreMeGGM+2cCyNi+Codv2k3A8JV1yUug==
X-Received: by 2002:a05:6402:3299:b0:435:787f:8058 with SMTP id
 f25-20020a056402329900b00435787f8058mr40166314eda.79.1656961604067; 
 Mon, 04 Jul 2022 12:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vWnqDzKiOpdp5G+XIpdRs68Qb1jnMF3TCK3ipZgd7GJIvgSLARSQkr3ouFOBVGku1LmxOrsw==
X-Received: by 2002:a05:6402:3299:b0:435:787f:8058 with SMTP id
 f25-20020a056402329900b00435787f8058mr40166301eda.79.1656961603881; 
 Mon, 04 Jul 2022 12:06:43 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 f19-20020a170906825300b0071160715917sm14659992ejx.223.2022.07.04.12.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 12:06:43 -0700 (PDT)
Date: Mon, 4 Jul 2022 15:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 3/6] virtio_test: call __virtio_unbreak_device
Message-ID: <20220704150450-mutt-send-email-mst@kernel.org>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <20220704171701.127665-4-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220704171701.127665-4-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Jul 04, 2022 at 07:16:58PM +0200, Stefano Garzarella wrote:
> Commit 8b4ec69d7e09 ("virtio: harden vring IRQ") initialize vq->broken
> to true, so we need to call __virtio_unbreak_device() before starting
> to use it.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

I think this shouldn't be necessary with latest master.

> ---
>  tools/virtio/linux/virtio.h | 2 ++
>  tools/virtio/virtio_test.c  | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
> index 363b98228301..feb720d4304f 100644
> --- a/tools/virtio/linux/virtio.h
> +++ b/tools/virtio/linux/virtio.h
> @@ -66,4 +66,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  				      const char *name);
>  void vring_del_virtqueue(struct virtqueue *vq);
>  
> +void __virtio_unbreak_device(struct virtio_device *dev);
> +
>  #endif
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 23f142af544a..765e64895dab 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -177,6 +177,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  	long long spurious = 0;
>  	const bool random_batch = batch == RANDOM_BATCH;
>  
> +	__virtio_unbreak_device(&dev->vdev);
>  	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>  	assert(r >= 0);
>  	if (!reset_n) {
> -- 
> 2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
