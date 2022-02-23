Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF15BC433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 02:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 425894055E;
	Wed, 23 Feb 2022 02:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UTmI0f8zUsxD; Wed, 23 Feb 2022 02:18:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CF017403D8;
	Wed, 23 Feb 2022 02:18:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82AECC001A;
	Wed, 23 Feb 2022 02:18:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8899C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83AB360EEF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 24hxGvJOPH_Y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:18:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABF3160071
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645582729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8m71796WnjJoiReMnJ7ljU9ui0Y+8xJ7kZ3cxcWFtwU=;
 b=UxxgCIXg3tzS/HRx6pktJSUOuGNfhl0w48VoGovQL7ARiRyvq77t+8D6zUscZYZqFuKsLs
 zIVDiRycnP4PEQxYLBIYxvY20aZEXtCfSEqZdi6a3N07DT76Z5UDjuV+0zvmxhD7uyAOXS
 dgJbNbuTTM81LWmFjXTPdXiCMqVoc0Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-haAmjNZqPZCzCsEWnQUQAw-1; Tue, 22 Feb 2022 21:18:48 -0500
X-MC-Unique: haAmjNZqPZCzCsEWnQUQAw-1
Received: by mail-lj1-f198.google.com with SMTP id
 20-20020a05651c009400b002462f08f8d2so4990331ljq.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8m71796WnjJoiReMnJ7ljU9ui0Y+8xJ7kZ3cxcWFtwU=;
 b=oifovlaJjEGm1o5JOeKupRnUDpCVSgkAVCketgUrDuvOKFkoQbsSJMSsYk4NCOz/YL
 pAVS+YvwiJQmCLc/9RzhbS0gkj/9sYf/Plk9vhuf8EohM6+IXHDCsn3EF9lxVvSICBk1
 jwC8bGw9NnIRYvIjpXNp/nWdzm8KMjUdnATWraHc2I2rv6RsosHDUUHwWWB7Sv6WEY8M
 D/p1ju7qus8rO5waTD8BlAXtmxnIV6ra5PetHUkoc5Hh+BWx0bWOrXBWOEjN2yUYz3HK
 NvSkb1gBzFp+TcfhxvJXknUIe3dd+Z9gf8qComPVq5F2uk8ZSeHg5IKaVj3Q4iQukSYI
 66mA==
X-Gm-Message-State: AOAM533uljU/l7CLWFS1eo+QoKFCbFvpsf6ZFzPKdFFhjnmeQd6R7Ly1
 r/Dzd/elbGfaOsvmZ/tfnmiGhE4JYY6pX45MAyb3mOwbaiYdJegQl3cxr5mqRmW2SE8VKhqpZ8+
 LFbIB/X4ZLG0dK2ViEWZ4U3tLLFs1/Tak0bfHpBPfgrb6vcLos7pKUAcK2Q==
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr18560076lfd.190.1645582726514; 
 Tue, 22 Feb 2022 18:18:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyk+Ofc0anUJN/HPT2fed7XHNU7yqVKhjlHv7XCMSt3esMXU6S0MVe6i/BWgb1hDC6Q3LfOqTD2YEQE/UiKZBE=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr18560067lfd.190.1645582726315; Tue, 22
 Feb 2022 18:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20220222154847.597414-1-hch@lst.de>
In-Reply-To: <20220222154847.597414-1-hch@lst.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 10:18:35 +0800
Message-ID: <CACGkMEukgGNg-NKc_Qn+oGM1Stygk-6VTFrd1wR-h_5CK41D=w@mail.gmail.com>
Subject: Re: [PATCH] vhost: use bvec_kmap_local in {get,put}u16_iotlb
To: Christoph Hellwig <hch@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>,
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

On Tue, Feb 22, 2022 at 11:49 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vringh.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 14e2043d76852..0f22a83fd09af 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1173,7 +1173,7 @@ static inline int getu16_iotlb(const struct vringh *vrh,
>                                u16 *val, const __virtio16 *p)
>  {
>         struct bio_vec iov;
> -       void *kaddr, *from;
> +       void *kaddr;
>         int ret;
>
>         /* Atomic read is needed for getu16 */
> @@ -1182,10 +1182,9 @@ static inline int getu16_iotlb(const struct vringh *vrh,
>         if (ret < 0)
>                 return ret;
>
> -       kaddr = kmap_atomic(iov.bv_page);
> -       from = kaddr + iov.bv_offset;
> -       *val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)from));
> -       kunmap_atomic(kaddr);
> +       kaddr = bvec_kmap_local(&iov);
> +       *val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)kaddr));
> +       kunmap_local(kaddr);
>
>         return 0;
>  }
> @@ -1194,7 +1193,7 @@ static inline int putu16_iotlb(const struct vringh *vrh,
>                                __virtio16 *p, u16 val)
>  {
>         struct bio_vec iov;
> -       void *kaddr, *to;
> +       void *kaddr;
>         int ret;
>
>         /* Atomic write is needed for putu16 */
> @@ -1203,10 +1202,9 @@ static inline int putu16_iotlb(const struct vringh *vrh,
>         if (ret < 0)
>                 return ret;
>
> -       kaddr = kmap_atomic(iov.bv_page);
> -       to = kaddr + iov.bv_offset;
> -       WRITE_ONCE(*(__virtio16 *)to, cpu_to_vringh16(vrh, val));
> -       kunmap_atomic(kaddr);
> +       kaddr = bvec_kmap_local(&iov);
> +       WRITE_ONCE(*(__virtio16 *)kaddr, cpu_to_vringh16(vrh, val));
> +       kunmap_local(kaddr);
>
>         return 0;
>  }
> --
> 2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
