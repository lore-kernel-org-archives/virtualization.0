Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F370EC433F5
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 07:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89E1A41603;
	Tue, 10 May 2022 07:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NnCmXT-C7Kvy; Tue, 10 May 2022 07:44:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CFE00415EA;
	Tue, 10 May 2022 07:44:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 916F1C0039;
	Tue, 10 May 2022 07:44:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFFEAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 07:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BADEC415EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 07:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D6cNTttVkXqH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 07:44:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D8B1415EA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652168653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BlIci0CNep+wUrkQW4AUVcPk7iMZk76yZupgc0VUTvc=;
 b=b+gAYjso4wJJMAMbbV11ly1IrDrkVA8rcdEojwndQNGO2ZXXavuFyiyu/jaC7PmwbeRZBl
 rCkLXKARXjzcYBWsX3xZNPmTYhAFP9m70qxa5lqED1I+NKV8IzupZZtrZMT1NbfWD6VLYZ
 BkDBNcIQwTzI8gSzVkRDEL8DQzFXzVc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-INqmF9fFOEqsv0J_sxApbg-1; Tue, 10 May 2022 03:44:10 -0400
X-MC-Unique: INqmF9fFOEqsv0J_sxApbg-1
Received: by mail-lf1-f71.google.com with SMTP id
 x36-20020a056512132400b0044b07b24746so6904290lfu.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 00:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BlIci0CNep+wUrkQW4AUVcPk7iMZk76yZupgc0VUTvc=;
 b=NMsu9p8obQ1QBB+GcHrQhZvs2Wsbx//4Cn2NRy9NAcCBu8KrE79FKfRj7WmLwYPD6U
 EErpS4SH2H6IbQnbjBmoZZ3jFo12QYRtDFvTnSr7PxwKD2i2fEMuWvz4hVq6VG1t0+np
 whF1yOaP0/2pOpWK6pfAYmB6Wfbb522IVP0Q5p6lfvzB3Oc5+G+hYTXg6mFP1kgRL8ke
 ipOPV9S87KeZLEow5CTngaytUYvrR4q02VDVTAXrK1EL4d/4lpQIYUMTGgj51M3EzKXZ
 jvtYvqzdWOonA8DKcJqkOO6GCXyoTE9G9u4gwVz1WxF15RgTuzV6+IIyxwzXxRRXsi9/
 8m2g==
X-Gm-Message-State: AOAM530bYG0sumqECcHKxgvD9Og2XRVqOjoE0z06199JwGW84lvqvaF9
 zOsloUtkATv/1NIbIfOPiAlnNLTJz7Vecjf7rVZa47+rb1E0QCEwP6gKfvbnyzw+UZW4ug7dBny
 RGBLFskJQOe8avS8FIeFfiQsuXjMMze9FWrAfGMju27X5a2rvGua/TnAs4g==
X-Received: by 2002:a2e:9698:0:b0:24f:14da:6a59 with SMTP id
 q24-20020a2e9698000000b0024f14da6a59mr13648649lji.73.1652168648566; 
 Tue, 10 May 2022 00:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygBKTQ1tWgHWbzhGASQpmN3PyPzyFzMva5OVPLIN/NuPJga8PT9LebRImJkl5usaxcBpwgh5iqnPLxiNqYoO8=
X-Received: by 2002:a2e:9698:0:b0:24f:14da:6a59 with SMTP id
 q24-20020a2e9698000000b0024f14da6a59mr13648637lji.73.1652168648340; Tue, 10
 May 2022 00:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220505100910.137-1-xieyongji@bytedance.com>
In-Reply-To: <20220505100910.137-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 May 2022 15:43:57 +0800
Message-ID: <CACGkMEv3Ofbu7OOTB9vN2Lt85TD44LipjoPm26KEq3RiKJU0Yw@mail.gmail.com>
Subject: Re: [PATCH v2] vringh: Fix loop descriptors check in the indirect
 cases
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

On Thu, May 5, 2022 at 6:08 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> We should use size of descriptor chain to test loop condition
> in the indirect case. And another statistical count is also introduced
> for indirect descriptors to avoid conflict with the statistical count
> of direct descriptors.
>
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
> ---
>  drivers/vhost/vringh.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 14e2043d7685..eab55accf381 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -292,7 +292,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
>              int (*copy)(const struct vringh *vrh,
>                          void *dst, const void *src, size_t len))
>  {
> -       int err, count = 0, up_next, desc_max;
> +       int err, count = 0, indirect_count = 0, up_next, desc_max;
>         struct vring_desc desc, *descs;
>         struct vringh_range range = { -1ULL, 0 }, slowrange;
>         bool slow = false;
> @@ -349,7 +349,12 @@ __vringh_iov(struct vringh *vrh, u16 i,
>                         continue;
>                 }
>
> -               if (count++ == vrh->vring.num) {
> +               if (up_next == -1)
> +                       count++;
> +               else
> +                       indirect_count++;
> +
> +               if (count > vrh->vring.num || indirect_count > desc_max) {
>                         vringh_bad("Descriptor loop in %p", descs);
>                         err = -ELOOP;
>                         goto fail;
> @@ -411,6 +416,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
>                                 i = return_from_indirect(vrh, &up_next,
>                                                          &descs, &desc_max);
>                                 slow = false;
> +                               indirect_count = 0;

Do we need to reset up_next to -1 here?

Thanks

>                         } else
>                                 break;
>                 }
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
