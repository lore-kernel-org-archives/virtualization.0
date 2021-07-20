Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0039DC07E9B
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 06:57:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9466113B
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 06:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9466113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F42882438;
	Tue, 20 Jul 2021 06:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7exN6Zc4gLna; Tue, 20 Jul 2021 06:57:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0836281CE1;
	Tue, 20 Jul 2021 06:57:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7287C001A;
	Tue, 20 Jul 2021 06:57:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AED3C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 06:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49DB940360
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 06:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pV1yQCK5vceZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 06:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33E6540351
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 06:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626764265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aATh9Mp3JsAAK9AMXlEVTfSs9zkYB1yHocq5Q1WegPs=;
 b=VSB4Hu0tuinhYnu225tabittNwlQKIIs0FXTNvI6FqD59mSHU/zqU+31UVvRMV6NcqM78F
 1fy8kF/8lqBRLxpEg0dihkZLKlUva2+OTO1IRp6hsYCfi5QoYO46Prs1qRjMfOOPT+i6kQ
 sN2p3DxfkQkEZrhdKyg4HgU04ysAYI0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-mWg4xoNXPGCFTy2facOi4g-1; Tue, 20 Jul 2021 02:57:44 -0400
X-MC-Unique: mWg4xoNXPGCFTy2facOi4g-1
Received: by mail-ed1-f71.google.com with SMTP id
 v4-20020a50a4440000b02903ab1f22e1dcso10454771edb.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 23:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aATh9Mp3JsAAK9AMXlEVTfSs9zkYB1yHocq5Q1WegPs=;
 b=S6xye2Vb31pBoiG1ZLt32bY9YRjL9eaUZny4wWXYo9gshAyJXKKfq+azjr82ZP6jnB
 S1VeafOpVKsianPPIDKs9As3xrP9KpOg2Nrf4wxTrM7MKJp8HXHxXru1JSzYJDhLLnGF
 ZQEPlrh7l/B0AZocPQavIvUImtGflBBH9d9NrKHGu5XQDqMY2O9OTQ5Lsbw9YRBwsMHK
 fAvOXRqnAtJ/N3ZFFfIr+5iHSaaOx3u9ky7b30ay9LrX45+ayO27M32DOqx5DuFZpqdF
 MTADTSIXP3LSvMzluVoO1rmwva7UVm/UgVAhbys5fzMiQlnBr1EStMksr1yk+Eri1O5s
 wzmQ==
X-Gm-Message-State: AOAM531dGol9ItFcVOknV29LNPduObPkaHUgP2H+ZhL65Dk3pI06wSCY
 Fut0Pv45Sah4YZoWULMRghCirHgZNY9wTXDlUpSKhG7CdliXwgANPApBAFvWu3UdDjFEOdB9955
 1ZdRukHOx8fo6Wtf/qGtECGb+yLvVj0exXzlAjLwWIA==
X-Received: by 2002:a17:906:7716:: with SMTP id
 q22mr7514347ejm.457.1626764263338; 
 Mon, 19 Jul 2021 23:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC2Gfso/vjpaol40WZv9MdPLMw4mV1khcxPxWldef29NHXVpjb0R8LIGdlpTHVyJ2RezcO/Q==
X-Received: by 2002:a17:906:7716:: with SMTP id
 q22mr7514338ejm.457.1626764263190; 
 Mon, 19 Jul 2021 23:57:43 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id q9sm6758618ejf.70.2021.07.19.23.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jul 2021 23:57:42 -0700 (PDT)
Date: Tue, 20 Jul 2021 08:57:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v1] vdpa/vdpa_sim: Use the negotiated features when
 calling vringh_init_iotlb
Message-ID: <20210720065740.56udn3ndebzvu26o@steredhat>
References: <20210720052533.415991-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210720052533.415991-1-elic@nvidia.com>
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

On Tue, Jul 20, 2021 at 08:25:33AM +0300, Eli Cohen wrote:
>When calling vringh_init_iotlb(), use the negotiated features which
>might be different than the supported features.
>
>Fixes: 2c53d0f64c06f ("vdpasim: vDPA device simulator")
>Signed-off-by: Eli Cohen <elic@nvidia.com>
>---
>v0 --> v1:
>Update "Fixes" line
>
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 14e024de5cbf..89a474c7a096 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> {
> 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
>-	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>+	vringh_init_iotlb(&vq->vring, vdpasim->features,
> 			  VDPASIM_QUEUE_MAX, false,
> 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> 			  (struct vring_avail *)
>@@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
> 	vq->device_addr = 0;
> 	vq->cb = NULL;
> 	vq->private = NULL;
>-	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>+	vringh_init_iotlb(&vq->vring, vdpasim->features,

vdpasim_vq_reset() is called while resetting the device in 
vdpasim_reset() where we also set `vdpasim->features = 0` after 
resetting the vqs, so maybe it's better to use the supported features 
here, since the negotiated ones are related to the previous instance.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
