Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C51EC433F5
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 03:15:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D643B611ED
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 03:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D643B611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE7E360AD3;
	Wed, 15 Sep 2021 03:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DVfb-xLp2NlT; Wed, 15 Sep 2021 03:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA70E605FE;
	Wed, 15 Sep 2021 03:15:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4E46C0011;
	Wed, 15 Sep 2021 03:15:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD25C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F55980E58
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lBB4iNrZonQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:15:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87A8180E45
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631675731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdHxAa7/lQ/I5V8NSxbPwJQDAGqjmPDYkTCRXZf6UNg=;
 b=CED3z7oQpqTcVKMEO2TY2uUO7zPs2/gEtplt90Wm21+o6J/Ja4Z77nvig9OuBICn1B5qiF
 Amctgk5R58OGO6zyY+HyVH6XVmGodz3UueSbAtYe7OVobglskrPE9tIl/828DrMxSwPIHk
 /TknvYmRy3leGX3DdtU38KXRUYKUqYA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-6XQY5j4NMkuReuMH45l60g-1; Tue, 14 Sep 2021 23:15:30 -0400
X-MC-Unique: 6XQY5j4NMkuReuMH45l60g-1
Received: by mail-lj1-f198.google.com with SMTP id
 q12-20020a2e750c000000b001e9c3bfbc31so748480ljc.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 20:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MdHxAa7/lQ/I5V8NSxbPwJQDAGqjmPDYkTCRXZf6UNg=;
 b=pImt0GzLe58eeTtUJjPcD6kJllndqlVt8B5MFp4bIGEvjQYsJQ5xNhWC7LuQXFwvHt
 1N/xtqjke48CxmpuRLUfwS5Ii3Mldk8mugVOjqSgnt7qPI9KZ2LjFd7CAnV5wNHJV+g9
 3J40qrs0KqvutzYXFH/lebCzjyhPm5sjJybvmeqkohxDAwKQSNiKTGi5WFzC1r7inpPJ
 FbqwEJ4I7xSaH2pasQSl2svyNTi8BcpJuWLCbtgLXvd89STpr/WGYzn/ILubK4o+7zUA
 3NHmkRAEv9IU5QCXMUYh1HY8cYKGSnBFuEX9EZRRQV8WpCh6EEponPoDtel6+MffjiHH
 5bLQ==
X-Gm-Message-State: AOAM532z+Cay2H7Fn3YUvnJo2tyUolljGlyNQ5uHlDW7DXaRmCPP/qO3
 82AWTHgnXHCxMXag6LHg/iTNEMXh+nGqeJYr94z9ugnKMI+B9Qu1ftT7nv2MHO30uDERfQCVEqw
 QduBdR8IZRdJ8B7eO6IArL/vo0217lsPtd7zhAp3DkIxN6CROlWIVJTlnVQ==
X-Received: by 2002:ac2:5fb2:: with SMTP id s18mr15797968lfe.580.1631675728663; 
 Tue, 14 Sep 2021 20:15:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOWebtitCYjyxtAyGX0jw2ePNu8oM0DZ0BiSI/eEATAwx5xPtlwRoQhzVA/obVzSWHMuJClMVRYPxPGPHuhiY=
X-Received: by 2002:ac2:5fb2:: with SMTP id s18mr15797960lfe.580.1631675728504; 
 Tue, 14 Sep 2021 20:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <42c5a09aacae346449bcc7b7b54d63f9d265e622.1631621507.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <42c5a09aacae346449bcc7b7b54d63f9d265e622.1631621507.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Sep 2021 11:15:17 +0800
Message-ID: <CACGkMEtHDWOqVOmbEPb_zmfucKo2aE1UBaQZaP_FtKowYcBm3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] vdpa: fix typo
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Sep 14, 2021 at 8:26 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  include/linux/vdpa.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 3972ab765de1..a896ee021e5f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -257,7 +257,7 @@ struct vdpa_config_ops {
>         struct vdpa_notification_area
>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>         /* vq irq is not expected to be changed once DRIVER_OK is set */
> -       int (*get_vq_irq)(struct vdpa_device *vdv, u16 idx);
> +       int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
>
>         /* Device ops */
>         u32 (*get_vq_align)(struct vdpa_device *vdev);
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
