Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4865AC432BE
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:35:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0040610A1
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0040610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8D6C400F5;
	Mon,  9 Aug 2021 09:35:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WLj-tPBQyzdK; Mon,  9 Aug 2021 09:35:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1763F4014B;
	Mon,  9 Aug 2021 09:35:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBD05C001A;
	Mon,  9 Aug 2021 09:35:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C168AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFD294025C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G3fMMVg74W2i
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:35:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB39740253
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628501722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Tv0kjTCVgxpOvHTEMYRQlsZZsBU9cyUmKv2pNcZ0e0=;
 b=IVSBE6DVRLK93NyU0weIjk4cZl50wVzpt+XK33dFFFIUVguoyPF+3RgNl9PGjy9w4L5Pjl
 Bghm+TCld2uYTRYTw/k0KNZR3Gxjic5OMa5Qc1dkM94NQga3O2dHUvQAhKCJgDJMDHFMmz
 vy1iv6iWlaFWVow81vvHBk47tzxR8SQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-PZb85lC6NUy-u9bWEvrRBQ-1; Mon, 09 Aug 2021 05:35:21 -0400
X-MC-Unique: PZb85lC6NUy-u9bWEvrRBQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 ju25-20020a17090798b9b029058c24b55273so4372432ejc.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 02:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4Tv0kjTCVgxpOvHTEMYRQlsZZsBU9cyUmKv2pNcZ0e0=;
 b=E94YPOJNk5sjWfJL857g5YyP24uqVuKUDXKu2ICUN29tXfVbMBCpNbBQVZ3eBxdl5g
 P6Jh+PKRqtRIOcvk5BsjoV/LNW5IA28lE8LZWtOvTqJ3UF2LfNm7TtktEK6LDRTkq/8W
 S2ub0QeFvnEHf/V42CUmrBnFwsgUbUBIQSchyAIWLn4Pt6rg/juSM5nyvQO4KgCeTxkK
 VhvttfYFaw72oto4ylc3l+VlE7YQQM2tyzMagIxiI2D/uXZgvUxunB4eACstUY41nIMA
 YxnG8iJXLC5R08ZSWmGqU3c9ZTTq/eAUGS1cSzIVRE3Ry//HMyqeiiRgbeTUNLYueljK
 JSeA==
X-Gm-Message-State: AOAM530AjNmSFqWXh3rtZixayVdRV9hhj5L29Fka3RNQox6pQaiyPPIa
 yrhSnlFkVdr31PieLO+iECvAvDdIqvzxJE0B/KCwwi8enFjh6/5CwbKQNJnYl3kVX+7tJAJd8sl
 8Gadvujv/kGYGP4BPKRhx5YmBjZ/XQeP4gUX4UG1fsg==
X-Received: by 2002:a05:6402:40f:: with SMTP id
 q15mr28914628edv.86.1628501720188; 
 Mon, 09 Aug 2021 02:35:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqjrR2JbhBrAphG3azaWBJivxnibKmK9EpGnoId0wNXXlF4JFGlUTQ7NovvMWOQh+3rP5rZA==
X-Received: by 2002:a05:6402:40f:: with SMTP id
 q15mr28914617edv.86.1628501720032; 
 Mon, 09 Aug 2021 02:35:20 -0700 (PDT)
Received: from redhat.com ([2.55.145.148])
 by smtp.gmail.com with ESMTPSA id i11sm7800159edu.97.2021.08.09.02.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 02:35:19 -0700 (PDT)
Date: Mon, 9 Aug 2021 05:35:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH] vdpa_sim: Fix incorrect size passed to alloc_iova()
Message-ID: <20210809053449-mutt-send-email-mst@kernel.org>
References: <20210809060257.99-1-xieyongji@bytedance.com>
 <20210809090435.e5dpn4fw75rjwtw5@steredhat>
 <CACycT3s9ZKGhXquuVBiOEmEELCMgqVw1no7JpA8_J3maCKKqxA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3s9ZKGhXquuVBiOEmEELCMgqVw1no7JpA8_J3maCKKqxA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Aug 09, 2021 at 05:18:13PM +0800, Yongji Xie wrote:
> On Mon, Aug 9, 2021 at 5:04 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Mon, Aug 09, 2021 at 02:02:57PM +0800, Xie Yongji wrote:
> > >The size passed to alloc_iova() should be the size of
> > >page frames to allocate rather than size in bytes.
> > >
> > >Fixes: 4080fc106750 ("vdpa_sim: use iova module to allocate IOVA addresses")
> > >Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > >---
> > > drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
> > > 1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > >index 14e024de5cbf..1ccf615221fe 100644
> > >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > >@@ -137,7 +137,8 @@ static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
> > >       int ret;
> > >
> > >       /* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
> > >-      iova = alloc_iova(&vdpasim->iova, size, ULONG_MAX - 1, true);
> > >+      iova = alloc_iova(&vdpasim->iova, size >> iova_shift(&vdpasim->iova),
> > >+                        ULONG_MAX - 1, true);
> > >       if (!iova)
> > >               return DMA_MAPPING_ERROR;
> > >
> > >--
> > >2.11.0
> > >
> >
> > We invoked init_iova_domain() with granularity = 1, so it should be
> > correct to use the size in bytes.
> >
> 
> Oh, yes. I missed the byte granularity.
> 
> Thanks,
> Yongji

Ok pls post with corrected description and dropped Fixes tag.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
