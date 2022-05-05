Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955EAC433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 07:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25CCD40362;
	Thu,  5 May 2022 07:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id obY2hMvijZM3; Thu,  5 May 2022 07:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7AFFB40319;
	Thu,  5 May 2022 07:47:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48E53C0039;
	Thu,  5 May 2022 07:47:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEA1BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E62DE60C1A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:47:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AzrP2mN4B-la
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:47:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.133.74])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A017C60AA0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651736830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j+el8V1xMUirJQUv2r3o0pzphH83zFlz8WJOJ63XP1Q=;
 b=NV1yqCOI+nr6oWpxY+/RTL5kcd3iEZuPbuI1JA5oh63p5P9c9TA5S18zXyQGONptPMyOLB
 bKxK1Dt3KOSPTO3NYPSMa4M7i3UeMS7dQCfXGZZgFnVWUX35Nn8YXIRiHto9fU4P45Xa9t
 DcSx03qElRnM7SKxxaM5Y1NpSEd52YY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-iRDmivSLPiS9frV9ImpQag-1; Thu, 05 May 2022 03:47:01 -0400
X-MC-Unique: iRDmivSLPiS9frV9ImpQag-1
Received: by mail-lj1-f197.google.com with SMTP id
 y7-20020a2e95c7000000b0024f29bcd594so1126926ljh.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 00:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j+el8V1xMUirJQUv2r3o0pzphH83zFlz8WJOJ63XP1Q=;
 b=2hIdPBg6o8kfm5NOSlv3xtMi1vyV/TZBjTyxwWe3iLe9CT+YbYAFboj+oAiNVrCLwW
 GOTfNUIWaS6lPKSaQ67bqLl+NMzwiitpvc2sw/Xzg7PG9m940t/5AqlYaP/EG9JsESqb
 za/eGGQRk+kpwUG1P5HXqz9aARedIFZXxkFjXPNnANgdXH1s0MgN8JWwdCPRZ9n87Dwk
 7n4tFXBoVbu9/jvfPRGSub80mZvFALihSPKOVkP4dSzRSJ22uVsZ5QPpbknbfuPO/e20
 JOnIMLXJT78DyJk/JOWoSLcdjadau1ZdiTJtp+tt4kj3FsRENHBo/Y7X1SeZBUb7YW6V
 b+iQ==
X-Gm-Message-State: AOAM533h5hyK3h+musDZZJ1pqVbQm6n0tnEcDHko0/fxhHzfsFf5D9Ab
 L2JNnZxpylIUcaAahbGMH/pbp0xO9WubHns0l7EE0qyKvuw7pdhL4OBHVcjcYE/Qj+rBJrYYApl
 1Y3dN1xBNLLOPoZWrGup9O3rMjS1qw0rIyz94Wd+TspfJ/B3fsoqveD9cBQ==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr16864514lfv.257.1651736819938; 
 Thu, 05 May 2022 00:46:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo3YA6g05X5pjwguq4bRI8kfZwD9pTqEzAjIvoSY4GZJXUuPL2nx0FsFK/zLQo8qSKYRPgS/lBOpjBIzD0OgM=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr16864505lfv.257.1651736819762; Thu, 05
 May 2022 00:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220504081117.40-1-xieyongji@bytedance.com>
In-Reply-To: <20220504081117.40-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 May 2022 15:46:48 +0800
Message-ID: <CACGkMEvdVFP2GkTy2Vxe44xZ+6BOU3FM5WccuHe-32FN1Pm=7A@mail.gmail.com>
Subject: Re: [PATCH] vringh: Fix maximum number check for indirect descriptors
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: fam.zheng@bytedance.com, rusty <rusty@rustcorp.com.au>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>
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

On Wed, May 4, 2022 at 4:12 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> We should use size of descriptor chain to check the maximum
> number of consumed descriptors in indirect case.

AFAIK, it's a guard for loop descriptors.

> And the
> statistical counts should also be reset to zero each time
> we get an indirect descriptor.

What might happen if we don't have this patch?

>
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
> ---
>  drivers/vhost/vringh.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 14e2043d7685..c1810b77a05e 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -344,12 +344,13 @@ __vringh_iov(struct vringh *vrh, u16 i,
>                         addr = (void *)(long)(a + range.offset);
>                         err = move_to_indirect(vrh, &up_next, &i, addr, &desc,
>                                                &descs, &desc_max);
> +                       count = 0;

Then it looks to me we can detect a loop indirect descriptor chain?

Thanks

>                         if (err)
>                                 goto fail;
>                         continue;
>                 }
>
> -               if (count++ == vrh->vring.num) {
> +               if (count++ == desc_max) {
>                         vringh_bad("Descriptor loop in %p", descs);
>                         err = -ELOOP;
>                         goto fail;
> @@ -410,6 +411,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
>                         if (unlikely(up_next > 0)) {
>                                 i = return_from_indirect(vrh, &up_next,
>                                                          &descs, &desc_max);
> +                               count = 0;
>                                 slow = false;
>                         } else
>                                 break;
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
