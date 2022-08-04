Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94199C19F29
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 01:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F384060B16;
	Thu,  4 Aug 2022 01:53:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F384060B16
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fdwa3Vay
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqbS5OmxnY3A; Thu,  4 Aug 2022 01:53:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 58A8E60B13;
	Thu,  4 Aug 2022 01:53:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58A8E60B13
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E489C0033;
	Thu,  4 Aug 2022 01:53:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3AFFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 01:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3583410E9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 01:53:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3583410E9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fdwa3Vay
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xGabHz8Qnt1C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 01:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E880410DC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E880410DC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 01:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659577981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsI/NhjU6yMBNdeLq/0YK3Gb8vQgw9K6id4Hte5Tdgs=;
 b=Fdwa3VayeSgGZUBY2aTiN1XqG6Boo550J1b7YIVZa5WVNFuZLiVzUHXjji+EaV3jIqRpgn
 OQ49+VUfWywJU47HlcQvqtBOkqD6bwu5da/IgBStPTAkibgQGXpo8ykCA396izax6FAh+6
 Hc6K1FqEPn7WGRgr1Pg9nKa1zG1Ay/M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-ts-ULeyANjiF3JoQxuY1Dw-1; Wed, 03 Aug 2022 21:53:00 -0400
X-MC-Unique: ts-ULeyANjiF3JoQxuY1Dw-1
Received: by mail-lj1-f199.google.com with SMTP id
 z7-20020a2ebe07000000b0025e5c7d6a2eso2031492ljq.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Aug 2022 18:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AsI/NhjU6yMBNdeLq/0YK3Gb8vQgw9K6id4Hte5Tdgs=;
 b=N+PEPucsZqyXy7WBMcgBsRWQMhm54dQ08z0Qqx0JvMNDvhjLnnYBkh7l6pcU9n0tXX
 mO3lk4NePwKZKBPJ8cGpJd3VMs9jNwPAlAR7JhLKEnzTfp5jB3u5xgb63Yp7obdfJEh0
 T2CNNqvpbT+WEdj4+RnRF3qQpN2+QIrTzQhoXdOwBT+jfhqTOwgSFQUb9Zc587aKAdbR
 xPTL1F4Tqh/1Dnb6cW47Cmyy3/+O+GwMBYYM6iJMlQUyL2S+bh9uScTvvG2lafrq5X+d
 zDpxPEjmc10SpBa+SOwOdCggiBNcEyoXYUI0v/k8159mnXr3EJz3438lUzuvgd4BZRo9
 Bp5A==
X-Gm-Message-State: AJIora/w1XWgBrhkGPWCcN6GRk2Zl8nhv3pxBz043WeOGVfd6Ibtw7z6
 MEYxBAo+/T16UuxBj8pBYlP9VtRUVC+h29V8PGksR8AkORhqtv18fi5XxC5jlsla1HOGIsfkY7A
 vblylvtEYbiisuf7F3bDynmSIO4GgQIwmT+GOMQR8sP9aNV/b64IBuQ5IVg==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr9319858lfa.124.1659577979002; 
 Wed, 03 Aug 2022 18:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6TmHP+7QTxMF41xeroeqy88xlUwsR9qDN6TweJlkm4FZvP2FssJD9lRjXMdhGjKQNkhOQ5YjYGJbofOIPROE=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr9319851lfa.124.1659577978710; Wed, 03
 Aug 2022 18:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <780fba4c-458f-0abc-ae48-4cf806401228@virtuozzo.com>
In-Reply-To: <780fba4c-458f-0abc-ae48-4cf806401228@virtuozzo.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Aug 2022 09:52:47 +0800
Message-ID: <CACGkMEtLutWVnG_SHbP9+K851k4ZN3hdtZGxaYpbAz3wzEvSGA@mail.gmail.com>
Subject: Re: memory locking in vhost-vdpa
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: den@virtuozzo.com,
 virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Thu, Aug 4, 2022 at 1:46 AM Andrey Zhadchenko
<andrey.zhadchenko@virtuozzo.com> wrote:
>
> Hi!
>
> Recently I sent vhost-blk patchset and Stefano suggested to instead join
> efforts on developing vdpa-blk.
> I played with it a bit and looks like vdpa itself pins the whole guest
> memory. Is there a way to control it or reduce pinned amount to the
> device pages?
> Looks like even vdpa-sim requires all memory to be pinned [1]. Pinning
> this much will surely impact guest density.

It depends on the parent.

When allocating the vDPA device, the parent can clams it supports
virtual address then pinning is avoided:

/**
 * __vdpa_alloc_device - allocate and initilaize a vDPA device
 * This allows driver to some prepartion after device is
 * initialized but before registered.
...
 * @use_va: indicate whether virtual address must be used by this device
 */

The only user so far is VDUSE which is a software parent in the
userspace with a customized swiotlb for kernel drivers.

Simulator came before this feature so we stick to the pinning method,
technically we can switch to use the va mode, but it might have some
performance impact (mostly the copy_from|to_user()).

This option might be useful for hardware parent if PRI or device page
fault is supported in the future.

Thanks

>
> Kind regards,
> Andrey
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1868535
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
