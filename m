Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39C3C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 02:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C738405A4;
	Mon, 21 Mar 2022 02:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KWRQUy3J49Hm; Mon, 21 Mar 2022 02:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E2C5940101;
	Mon, 21 Mar 2022 02:56:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A54DFC001A;
	Mon, 21 Mar 2022 02:56:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE9B4C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 02:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7B1260D76
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 02:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O47yKNaJeggw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 02:55:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 550CE60B83
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 02:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647831357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NO2jMNKPbBxPcOjWsAxlUEBqWe3bFA7aWl8mJ0qi/hQ=;
 b=SJERbUuEW5pbPy1o+b79ZcejzhI67aS3uqPNU6GyVjK11PNYkJOvb7C7nCF3+qUmCiK4tV
 4Gtqg8HsSayYBsIDwTCcheo6DWWH5QWJdN7rHKuJc5+g/v3zydHRPslVXE1Y2SaVcgiWn6
 xSpRUSdTRJwtrV6DU3LoZLjXhdUwVrs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-lSk-XQ6eO7uXbOsA--9GQg-1; Sun, 20 Mar 2022 22:55:55 -0400
X-MC-Unique: lSk-XQ6eO7uXbOsA--9GQg-1
Received: by mail-lf1-f71.google.com with SMTP id
 f27-20020ac251bb000000b004486c507f80so3410190lfk.10
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 19:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NO2jMNKPbBxPcOjWsAxlUEBqWe3bFA7aWl8mJ0qi/hQ=;
 b=JBQqkYXmXlnXl764Im7DQjU7CG4zvNVM3Vx4RXL7gG3Sg85LOD40StLj/EsxCHsbTf
 CaEoO749+aK8UscyZWlpusBWV8YjPCxFvz1KvqAZ53EfL6436x96o9ikMTodk6AcWV2p
 YA3Bn94JtUgdvMqdlyOjJ2n24hgkl26OqY7JGMAunfX5mromkZHpw5UAr0u9dX5l1+A2
 hePNh0omqJgIQfnIzLy3gNKwMB+OSk4hYZBbgkNd4B8PShBU/J8wpvtf+NungQIQ0EbU
 H00830EDYPGcbwyViCfjbgzVjlFTST86YlvnNC1vdh4aPYlsMxdy/BzCxPunpZehrT/l
 +hwA==
X-Gm-Message-State: AOAM533vUW8xLnkKr0QQmgfIqtl1Wlj8G5jcT5IKWIkiJMV1bjvtFRQZ
 MYHeOWXBKppMeJbihZtX+RqbaJEyfjOw1R3ItSXqANBLOPotjbO9ZmcdY3qatOWCMRDogIsYIdP
 x1K6COgm8OZ4vu3umueTo3x1oUABWvPdG+a59YhZpriXSpjHwHxwZj5Gz+g==
X-Received: by 2002:a2e:824e:0:b0:249:7e3d:c862 with SMTP id
 j14-20020a2e824e000000b002497e3dc862mr4913448ljh.97.1647831354091; 
 Sun, 20 Mar 2022 19:55:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn4DYJfL7k43PA+Q+9rNfsf0PxiZcBUxbi0IZnQ1UxD/sDF7hmUd0d6p8+yDx5iXE6+RNwYtqAi0iA6OLkqTs=
X-Received: by 2002:a2e:824e:0:b0:249:7e3d:c862 with SMTP id
 j14-20020a2e824e000000b002497e3dc862mr4913431ljh.97.1647831353900; Sun, 20
 Mar 2022 19:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220320074449.4909-1-mail@anirudhrb.com>
In-Reply-To: <20220320074449.4909-1-mail@anirudhrb.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Mar 2022 10:55:42 +0800
Message-ID: <CACGkMEtRrmXP-xjggRRSeoJT=9JTAXktPnZdvK-KYbKr4Zxc8g@mail.gmail.com>
Subject: Re: [PATCH v2] vhost: handle error while adding split ranges to iotlb
To: Anirudh Rayabharam <mail@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Sun, Mar 20, 2022 at 3:45 PM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
>
> vhost_iotlb_add_range_ctx() handles the range [0, ULONG_MAX] by
> splitting it into two ranges and adding them separately. The return
> value of adding the first range to the iotlb is currently ignored.
> Check the return value and bail out in case of an error.
>
> Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>
> v2:
> - Add "Fixes:" tag and "Reviewed-by:".
>
> v1:
> https://lore.kernel.org/kvm/20220312141121.4981-1-mail@anirudhrb.com/
>
> ---
>  drivers/vhost/iotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> index 40b098320b2a..5829cf2d0552 100644
> --- a/drivers/vhost/iotlb.c
> +++ b/drivers/vhost/iotlb.c
> @@ -62,8 +62,12 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
>          */
>         if (start == 0 && last == ULONG_MAX) {
>                 u64 mid = last / 2;
> +               int err = vhost_iotlb_add_range_ctx(iotlb, start, mid, addr,
> +                               perm, opaque);
> +
> +               if (err)
> +                       return err;
>
> -               vhost_iotlb_add_range_ctx(iotlb, start, mid, addr, perm, opaque);
>                 addr += mid + 1;
>                 start = mid + 1;
>         }
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
