Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75DAC07E9B
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 08:13:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DF5611ED
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 08:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DF5611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15FB2606CE;
	Tue, 20 Jul 2021 08:13:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gIoPMkqss4Xx; Tue, 20 Jul 2021 08:13:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C68116069D;
	Tue, 20 Jul 2021 08:13:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81456C0010;
	Tue, 20 Jul 2021 08:13:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7302AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 08:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 349EF400A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 08:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kupIks7uHYsO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 08:13:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2DF14035A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 08:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626768812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iR1FfPEi/dSZlfY2U/ypFz4NVPRyvseiKT4LAhvExgQ=;
 b=XO6S2pWnV11SZ6rNBRq3ZM2q5YJrIbK3E99jQ9SrkJmPZWOMgNZARt+qwOArnTxtzP9aUA
 X73Cc4iODam6yn6TJ1q3F4yulFmomKgSgMMCK1O7imsStgGvutwpwcICpiSTaBaZg4nlD0
 7ndU41E5Sype8MdossjJfi1DkpTitHI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-2n7wVtbbP7G6keE_aHhqJA-1; Tue, 20 Jul 2021 04:13:31 -0400
X-MC-Unique: 2n7wVtbbP7G6keE_aHhqJA-1
Received: by mail-ej1-f70.google.com with SMTP id
 u12-20020a17090617ccb029051ab3a0d553so6461472eje.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 01:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iR1FfPEi/dSZlfY2U/ypFz4NVPRyvseiKT4LAhvExgQ=;
 b=dnPBnZ2qq2NddTsLDVlmkc8Yt8fCilvn+2HflLJkoG6EAf0T3EByBdCTGt5ZDhRxIc
 z8Di/ZHHJ8th70jpuZqX7W8ap6oHNXGQZItUJGGr9Pn+rNRF24K4ymPWR5TgxqiVgZGx
 ZtW2iObmkbiiSST4PEsvZbwxAXXFfsFoACBRUcGoeFOpX8oe9uIRUCfIRBbt5TRdtzVf
 l7KpfSwWXSVqY/IfMxtZkO+QfoOAPBSI4zKFaSXqLk6dyT/HQ3zOg4cjcf3QoEAvuZr5
 +6B7Uhb6fYTwFBVNH7pO1Qtwz6c2gZg6e13p3furkXEKIW/UCgQTf00W69pkyuUmEHju
 bHbw==
X-Gm-Message-State: AOAM533Dji0dd/XOUqwblt3l9QLhaT4P7X090giO412PBxivRTXR2WFb
 9lnOyXH1bmC1ikdtAkUD8rWZ51YuPlTdA6LJ+pv98gtpycMOuESuEEOC8Ykt6lzcxwmAaSJ9pNa
 P/qiUkA2q8RCVvY/pirmyJsgZ+nnT9/x7nvDevzqe8A==
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr39516669eds.374.1626768810118; 
 Tue, 20 Jul 2021 01:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTElRn2REEtTessTQf5nVgqHL9zBooMet57C/pD7unDakj1dPrn3LW7+7oWhizoutwOC1gfQ==
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr39516657eds.374.1626768809987; 
 Tue, 20 Jul 2021 01:13:29 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id jw8sm6767787ejc.60.2021.07.20.01.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jul 2021 01:13:29 -0700 (PDT)
Date: Tue, 20 Jul 2021 10:13:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v1] vdpa/vdpa_sim: Use the negotiated features when
 calling vringh_init_iotlb
Message-ID: <20210720081327.6govoz2jjb6osxjt@steredhat>
References: <20210720052533.415991-1-elic@nvidia.com>
 <20210720065740.56udn3ndebzvu26o@steredhat>
 <20210720071435.GA4647@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210720071435.GA4647@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jul 20, 2021 at 10:14:35AM +0300, Eli Cohen wrote:
>On Tue, Jul 20, 2021 at 08:57:40AM +0200, Stefano Garzarella wrote:
>> On Tue, Jul 20, 2021 at 08:25:33AM +0300, Eli Cohen wrote:
>> > When calling vringh_init_iotlb(), use the negotiated features which
>> > might be different than the supported features.
>> >
>> > Fixes: 2c53d0f64c06f ("vdpasim: vDPA device simulator")
>> > Signed-off-by: Eli Cohen <elic@nvidia.com>
>> > ---
>> > v0 --> v1:
>> > Update "Fixes" line
>> >
>> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
>> > 1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > index 14e024de5cbf..89a474c7a096 100644
>> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > @@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>> > {
>> > 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>> >
>> > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>> > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
>> > 			  VDPASIM_QUEUE_MAX, false,
>> > 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
>> > 			  (struct vring_avail *)
>> > @@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
>> > 	vq->device_addr = 0;
>> > 	vq->cb = NULL;
>> > 	vq->private = NULL;
>> > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>> > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
>>
>> vdpasim_vq_reset() is called while resetting the device in vdpasim_reset()
>> where we also set `vdpasim->features = 0` after resetting the vqs, so maybe
>> it's better to use the supported features here, since the negotiated ones
>> are related to the previous instance.
>>
>
>I don't think using supported features is valid. Better to make sure
>vringh_init_iotlb() is called after the features have been negotiated.
>

I think the vringh_init_iotlb() call in vdpasim_vq_reset() is just used 
to clean up the `struct vringh`, then it will be initialized in 
vdpasim_queue_ready() when features have already been negotiated.

Maybe here we can pass 0 (to the features parameter) if we don't want to 
use the features supported by the device.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
