Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984DEC4332F
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 02:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2011D40B23;
	Tue, 29 Nov 2022 02:59:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2011D40B23
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CHxB9MIf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QzZj1BJcrSSU; Tue, 29 Nov 2022 02:59:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 964D8403A7;
	Tue, 29 Nov 2022 02:59:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 964D8403A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68CC8C0033;
	Tue, 29 Nov 2022 02:59:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FE99C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 02:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13E6681B53
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 02:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13E6681B53
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CHxB9MIf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U2FZ3zh92lSl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 02:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61E7281366
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61E7281366
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 02:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669690789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jICdvc9DXcnwskTHg4NcjxqsN06Ny3H6HZZrLEpXAiY=;
 b=CHxB9MIfv7tUb8YJpAWa1Q5WI+yczisvSEsdpoS8c58ZXML4eTT7lKSwNAYyn+9iT8/XFq
 d51CFlKEs58MuoNGuHLkInYU3z9Pl2wyx0hpwwJ9hQU7PorGgGtU0vvokj+cE36algrXtP
 QEpXSwm5iG0IslFjOIWokrdSGWiyiUI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-JVNrf8RCNYKti25P3K1lfQ-1; Mon, 28 Nov 2022 21:59:47 -0500
X-MC-Unique: JVNrf8RCNYKti25P3K1lfQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 s16-20020a056808009000b0035b227aa390so4690983oic.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 18:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jICdvc9DXcnwskTHg4NcjxqsN06Ny3H6HZZrLEpXAiY=;
 b=fnAWP5To4mwrdUBDc7qQPQY0tRuvj5R3U2QaGnGgRv+ssXjA/rnY7h6ku1wd6+BRkY
 1xttFYyzakzAu6h1JcvBuyeGTakSWuG/vd5S3bwuov33h+l680tEqzvATJD8sUZADmZD
 JJT4tpU9/bRq2eeTJdfiPipnJKrmGcZnW2cjxMh6OIaQg9kY85KRTH+S10z57dLEg6Bk
 KDecEggLrCBEQeBNjXSYORbzEWzWnLTvXz8WWUKM7fRMmXqo07HWzFmgMAB6Y1D4AyWe
 TuPqNUe3DmFBmvFEFzatY9oLVHsDo5DCDzB59pIZ7/Ibwetc7wrbrud506Ju3AfgSl8l
 95lA==
X-Gm-Message-State: ANoB5pnw4jfWwWino9yBlfqxZERXzsUGNAKVkB07TFxBu16YsZTqzYkJ
 ZSForI6tFSogKObfPLgNB+hu3VBAjnIQMqDnh5Do9S3icLzQpEfhmN0yWtbHwXlBMbIp5JZvNsh
 JHqQPXDu+Ktw+2rxeMnSPTEUkp+6eUrFseFrFtYkz5pRZSmoJtnNC0Vz0MA==
X-Received: by 2002:aca:906:0:b0:354:68aa:9c59 with SMTP id
 6-20020aca0906000000b0035468aa9c59mr28156755oij.35.1669690787158; 
 Mon, 28 Nov 2022 18:59:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6CVNwUgwdj4oC+9mc6XrKlb7k1ISyHQEbQFZggMlCP7aWq/QQQWHqA/iMa/W0aTsOefe6aRq2cy/DzsDKEZSA=
X-Received: by 2002:aca:906:0:b0:354:68aa:9c59 with SMTP id
 6-20020aca0906000000b0035468aa9c59mr28156741oij.35.1669690786942; Mon, 28 Nov
 2022 18:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20221128155717.2579992-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20221128155717.2579992-1-harshit.m.mogalapalli@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Nov 2022 10:59:36 +0800
Message-ID: <CACGkMEuPe_Q1+F47YXdi2=L5bO4JB9+cRB0mn4eZKF6O4N3=Aw@mail.gmail.com>
Subject: Re: [PATCH v3] vduse: Validate vq_num in vduse_validate_config()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: error27@gmail.com, harshit.m.mogalapalli@gmail.com,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Eli Cohen <elic@nvidia.com>
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

On Mon, Nov 28, 2022 at 11:57 PM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Add a limit to 'config->vq_num' which is user controlled data which
> comes from an vduse_ioctl to prevent large memory allocations.
>
> Micheal says  - This limit is somewhat arbitrary.
> However, currently virtio pci and ccw are limited to a 16 bit vq number.
> While MMIO isn't it is also isn't used with lots of VQs due to
> current lack of support for per-vq interrupts.
> Thus, the 0xffff limit on number of VQs corresponding
> to a 16-bit VQ number seems sufficient for now.
>
> This is found using static analysis with smatch.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v1->v2: Change title of the commit and description, add a limit to
>         vq_num.
>
> v2->v3: Improve commit message to include reason for setting limit to
>         0xffff
>
> Only compile and boot tested.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 35dceee3ed56..31017ebc4d7c 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
>         if (config->config_size > PAGE_SIZE)
>                 return false;
>
> +       if (config->vq_num > 0xffff)
> +               return false;
> +
>         if (!device_is_allowed(config->device_id))
>                 return false;
>
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
