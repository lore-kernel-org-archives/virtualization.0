Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FEDC32771
	for <virtualization@archiver.kernel.org>; Fri, 16 Sep 2022 00:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5C1A83F45;
	Fri, 16 Sep 2022 00:46:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5C1A83F45
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=cLx8a1wY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aqtQI2vG7ics; Fri, 16 Sep 2022 00:46:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C629B83EBD;
	Fri, 16 Sep 2022 00:46:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C629B83EBD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E1CEC0033;
	Fri, 16 Sep 2022 00:46:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9005C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 00:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9746783F40
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 00:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9746783F40
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o2JfPHkra_gS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 00:46:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C161C83EBD
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C161C83EBD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 00:45:59 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id e17so29384923edc.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 17:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=fgvuqsUTyWyuOvAIEgrlM+1FJPr0CKG3fXPQsUY/0fA=;
 b=cLx8a1wYzET6txnhpQe08LOWhlT2HAaOoEZ6Xivw5dltqJhG5nNtCsQ0KD4vzbdN/N
 M82otOxiqyjLzN6gYqig2MI5FbZiP8z/0epchRNXhz2xKF3VEO1kQL63JnCk2PL1qzA5
 u+z6KZrKuPKZBB2U97Xd4bX1iduraXZLJTgpCJi9YqQywjVI4rFnF3emhLFEJZGYHZkK
 N4d8835lZypHOoMBHcS7ibvuIYSsuk7Oh325nGuCtxDtjHnyoq6VjbC63Gi5hgNGISxP
 gM//Fi7GrxIdxZOyYkYFViPXPlR8mQ6+TPCywflwoun6XLbrkoGSgD55COpAvGSOUudr
 +adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=fgvuqsUTyWyuOvAIEgrlM+1FJPr0CKG3fXPQsUY/0fA=;
 b=prrQjjw5NtILr7FQ8GaCQs/RW8yMHCF+ObVVe9flKA7YhyUzO+TVaVB4tsb1OF/y6f
 yELvE/PCSW83TrjS+SIJ/MH2xp3xbIWm0muwSAbese3Qt1dkZF3617CMOsDyOJVGQ2wJ
 HuZiboVk5eDnHOfncSoRogLbgNtsyUHOWRGfi8xn7FAfY+/Z0wZQtP+ybfTWh76h1IbP
 34lUhGzXBnPvq3YVzmGU7Bh1yw2IyDQdkjFpLzdeRZF4+HdsiSBO7MOsqo8YMu0a0+Gq
 2xJnulUNMBOKInRZsFxvR7PZ2CHP1zbXaQIFAk4kGICiYDSpxawtbzRnJ4kf+M5gX1Vt
 FAOw==
X-Gm-Message-State: ACrzQf19jkrbNfk9mgFemEMYnD1L6a3qLk5BDDTvFpSd7r35E5yZVBe+
 bIviB3D4ka3Ye9K3POHfqF8V5yg6UdecEq7mtYg=
X-Google-Smtp-Source: AMsMyM765GVM5HcFPB43/QMjNSuBYxWMcW2k/CHvmEVg52f2dnJANqGDzrkFWPFpWGtgqCTEqMLOAuL9dBQOLX2/gkY=
X-Received: by 2002:a05:6402:194e:b0:452:5f30:7b03 with SMTP id
 f14-20020a056402194e00b004525f307b03mr1990017edz.124.1663289157743; Thu, 15
 Sep 2022 17:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <YyMJBkId0c1lvrrO@kili>
In-Reply-To: <YyMJBkId0c1lvrrO@kili>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 15 Sep 2022 17:45:46 -0700
Message-ID: <CAPaKu7SCZuX_agp3WUWkra63w6=+ZMyLSSqk9tZyB+B75sVo7w@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: fix shift wrapping bug in
 virtio_gpu_fence_event_create()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
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

On Thu, Sep 15, 2022 at 4:14 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The ->ring_idx_mask variable is a u64 so static checkers, Smatch in
> this case, complain if the BIT() is not also a u64.
>
> drivers/gpu/drm/virtio/virtgpu_ioctl.c:50 virtio_gpu_fence_event_create()
> warn: should '(1 << ring_idx)' be a 64 bit type?
>
> Fixes: cd7f5ca33585 ("drm/virtio: implement context init: add virtio_gpu_fence_event")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 3b1701607aae..14eedb75f8a8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -47,7 +47,7 @@ static int virtio_gpu_fence_event_create(struct drm_device *dev,
>         struct virtio_gpu_fence_event *e = NULL;
>         int ret;
>
> -       if (!(vfpriv->ring_idx_mask & (1 << ring_idx)))
> +       if (!(vfpriv->ring_idx_mask & (1ULL << ring_idx)))
BIT_ULL(ring_indx)?

>                 return 0;
>
>         e = kzalloc(sizeof(*e), GFP_KERNEL);
> --
> 2.35.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
