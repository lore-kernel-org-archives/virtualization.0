Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0414C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 03:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B91380C3F;
	Wed,  9 Nov 2022 03:24:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B91380C3F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rigx1i/2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QFwNmtOp-tYY; Wed,  9 Nov 2022 03:24:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BCF980BF8;
	Wed,  9 Nov 2022 03:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BCF980BF8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB6CEC0033;
	Wed,  9 Nov 2022 03:24:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 146FFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E26E560AAC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:24:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E26E560AAC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rigx1i/2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HpOCwcTZBqmU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:24:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B953600CA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B953600CA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667964277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F1qirjMG3kZUXL8rp78PkVsEriIi9ata3YC3IMmDFgo=;
 b=Rigx1i/2Ku9x3DLO5JOv66QoRAjFAwSu3neFsFQP7BdHMOqVhaPvr6OhOmOTdFtYqXCjG8
 Vsx7rRBBKheMAVSShyfO8qKpYM+iMbfvvDYGK5gdiS2bkkwCIIkqQAVVBv3FFIia1vSjV7
 xhwEL7dH2PAnBcJMIYO1JbuKUThpkLw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-312-xdg8KgWHNeSrAS3GPjLasw-1; Tue, 08 Nov 2022 22:24:36 -0500
X-MC-Unique: xdg8KgWHNeSrAS3GPjLasw-1
Received: by mail-ot1-f70.google.com with SMTP id
 s5-20020a9d7585000000b0066c7a3ddf59so7784511otk.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 19:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F1qirjMG3kZUXL8rp78PkVsEriIi9ata3YC3IMmDFgo=;
 b=GaFxGJdAFl/81dwWnCLykMqvShmkjwM0lRuR5YFo+fdpBGsFrurn1lEjCt/6mfUEhJ
 RzaAoWZy1F9Zty0FWzwy3gEx3LUaokVpWdyZHH+79cBp3VYvRBlJHYCmTIiWu6J2pShe
 Y4l9nhh43Jy+fH0Ib+A+QpY0fHpdE7xViDyruiYvmKDVTrVdoJaK9OOUPHg0Xy0P0vGM
 4ra/iUKsGZtHSUiJ/nhoHG4liJnq0tqwVZH8qlyjVfo5hi+5pI1VRfnKx3+oB74fUhqA
 jgP97hec2UU/5hPhSSfQmmYlXzOr1yc5ir6PikdvQkraUlhzUjWaNEQF3D+q7y9uP7Xj
 eYjA==
X-Gm-Message-State: ACrzQf2qqgpcQuEh+KS9bHOH6C0dPXetjDTMgDP5RfK4NVMXU5IcOcik
 ZTdSaiF4UfVI1IoFTazOSBURbv9dLgJvZQgCJmeTfU6pVtL0KgXCA4R4vRp4PUJx65jx8dqmlY9
 34/i7N1ZTf4zUDcwiz/z27gQFrOzzYn/YRLh60zJRyv8d9/hyqjK3RWc4tw==
X-Received: by 2002:a4a:2ccf:0:b0:49e:b502:3a2b with SMTP id
 o198-20020a4a2ccf000000b0049eb5023a2bmr9788968ooo.57.1667964275439; 
 Tue, 08 Nov 2022 19:24:35 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4TS8SZHDk+F11XcIXyOjWg7x3CStUwgN7DXqTHrvfbCTUgELD600O6A1TkWZj32gJcP6VoqsHMRgJlXrNy6A0=
X-Received: by 2002:a4a:2ccf:0:b0:49e:b502:3a2b with SMTP id
 o198-20020a4a2ccf000000b0049eb5023a2bmr9788965ooo.57.1667964275202; Tue, 08
 Nov 2022 19:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20221108103437.105327-1-sgarzare@redhat.com>
 <20221108103437.105327-2-sgarzare@redhat.com>
In-Reply-To: <20221108103437.105327-2-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Nov 2022 11:24:23 +0800
Message-ID: <CACGkMEu+T1zX0XQbe2NR24MBC1LfV6ECv6vOm7ofrvqCJZ4avA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vringh: fix range used in iotlb_translate()
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

On Tue, Nov 8, 2022 at 6:34 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> vhost_iotlb_itree_first() requires `start` and `last` parameters
> to search for a mapping that overlaps the range.
>
> In iotlb_translate() we cyclically call vhost_iotlb_itree_first(),
> incrementing `addr` by the amount already translated, so rightly
> we move the `start` parameter passed to vhost_iotlb_itree_first(),
> but we should hold the `last` parameter constant.
>
> Let's fix it by saving the `last` parameter value before incrementing
> `addr` in the loop.
>
> Fixes: 9ad9c49cfe97 ("vringh: IOTLB support")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vringh.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 11f59dd06a74..828c29306565 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1102,7 +1102,7 @@ static int iotlb_translate(const struct vringh *vrh,
>         struct vhost_iotlb_map *map;
>         struct vhost_iotlb *iotlb = vrh->iotlb;
>         int ret = 0;
> -       u64 s = 0;
> +       u64 s = 0, last = addr + len - 1;
>
>         spin_lock(vrh->iotlb_lock);
>
> @@ -1114,8 +1114,7 @@ static int iotlb_translate(const struct vringh *vrh,
>                         break;
>                 }
>
> -               map = vhost_iotlb_itree_first(iotlb, addr,
> -                                             addr + len - 1);
> +               map = vhost_iotlb_itree_first(iotlb, addr, last);
>                 if (!map || map->start > addr) {
>                         ret = -EINVAL;
>                         break;
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
