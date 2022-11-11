Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F9CC433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 06:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 640B6408F6;
	Fri, 11 Nov 2022 06:34:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 640B6408F6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EE+OqeTw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b0_JBj7CtqZW; Fri, 11 Nov 2022 06:34:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9A5A840932;
	Fri, 11 Nov 2022 06:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A5A840932
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67FA2C0032;
	Fri, 11 Nov 2022 06:34:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2003C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 06:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A947060AD5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 06:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A947060AD5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EE+OqeTw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vUrV1hKCHsYm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 06:34:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C15FD60A74
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C15FD60A74
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 06:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668148478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1SBdufX+flggeoNplMAMsXncPCQnRWs3FUbWH+qL6Q=;
 b=EE+OqeTwxEEMcaiwWhRW3b0ubC5QyJuh9PEOR1BprqXC4NwRnAL6/kUaXPXBLq54oqthg2
 ZVnOyNrm01szBjSQK3dr9RSQ8E/X3gRg6BTfHIe0ZgeQaSiJFKnOuFIy4AzxTdfmiIW+8M
 AVS9wwso4VycirJliG8fry3aYJt8mCw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-lLKctXiqM_6iRGzwptNmzg-1; Fri, 11 Nov 2022 01:34:36 -0500
X-MC-Unique: lLKctXiqM_6iRGzwptNmzg-1
Received: by mail-ed1-f70.google.com with SMTP id
 b14-20020a056402278e00b004621a2642d7so2998425ede.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 22:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X1SBdufX+flggeoNplMAMsXncPCQnRWs3FUbWH+qL6Q=;
 b=ydRGpMwMItwLCu1ZSlHshGGxH62RX0uquNSiLDiRiweprB02RlpGrFwYDjedW8V+LC
 Xn6SSgyYzOopIfd4FHejd/MUwvq0mMrhWngtbQ7Kq86vIxsILd0H6p/N46SO69cpiQaf
 DCPE61rdkDGD/utz6123VOTQQcxIjBdt580CLMwyZVJJSQcny2U7pCNbsGG32F+0LngV
 N2JoDENN+MDLrJp1chcnDO9iezyfep5k8itQj+ypCBkcIfqBa0ooPz/m3UFc/AWOUGVW
 VwAVDGS7ZJPPbZDYHWHIDmS+zNAK2O2CW9AmnmkDS2XTuSFWLbBT+18YpJbVcf1OzdbJ
 XOBQ==
X-Gm-Message-State: ANoB5plsI+d6mw1/EsDNPEJ4ZhF76dICJ6XEkjvwscBd1MejvCoy1spg
 xAJwAypTV5DzVjtBr2UkTnJthYbAjqRNiF8Wxu3NG/Ea9OE16kGtGH1wH/HPWvD0Wi2upoqRQzD
 J347iLPynK7EZILxXmTGkUvuKCL0t8chUV4DetAzLQvtzfaQhofoQVGksQA==
X-Received: by 2002:a17:906:1441:b0:7ad:b97e:283a with SMTP id
 q1-20020a170906144100b007adb97e283amr708010ejc.567.1668148475740; 
 Thu, 10 Nov 2022 22:34:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7NURk90dJe46Y9VlLLQA0NXmHgm4YuMHmbjfycuMXqhT190gmtbUwNycASbJRMQpVacAQLU0NRwhmuJexXjhM=
X-Received: by 2002:a17:906:1441:b0:7ad:b97e:283a with SMTP id
 q1-20020a170906144100b007adb97e283amr708001ejc.567.1668148475547; Thu, 10 Nov
 2022 22:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20221110141335.62171-1-sgarzare@redhat.com>
In-Reply-To: <20221110141335.62171-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Nov 2022 14:34:22 +0800
Message-ID: <CACGkMEvmumcokt4UpazGKWfOeLDrh+kaLEWywQtPF0dJfW-kUw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: fix vringh initialization in
 vdpasim_queue_ready()
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Thu, Nov 10, 2022 at 10:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> When we initialize vringh, we should pass the features and the
> number of elements in the virtqueue negotiated with the driver,
> otherwise operations with vringh may fail.
>
> This was discovered in a case where the driver sets a number of
> elements in the virtqueue different from the value returned by
> .get_vq_num_max().
>
> In vdpasim_vq_reset() is safe to initialize the vringh with
> default values, since the virtqueue will not be used until
> vdpasim_queue_ready() is called again.
>
> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..b20689f8fe89 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>  {
>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
> -       vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> -                         VDPASIM_QUEUE_MAX, false,
> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>                           (struct vring_avail *)
>                           (uintptr_t)vq->driver_addr,
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
