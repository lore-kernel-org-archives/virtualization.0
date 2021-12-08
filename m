Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90483C433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 04:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20A9E40965;
	Wed,  8 Dec 2021 04:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBr11Px8g_NA; Wed,  8 Dec 2021 04:09:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 89D03400C7;
	Wed,  8 Dec 2021 04:09:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CAA9C001E;
	Wed,  8 Dec 2021 04:09:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B38FC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36557408FA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D96ZjEwV5cyt
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:09:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CF86401A0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638936567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vj6SZJIYiS00fnwnMek5uYVUq8OZMiUnrKXwQGLzqU8=;
 b=HU/HEVxnK9l1kVYt+OYaY02XlqSjQKeR56JRpyADJdnJ7b67AxScTgbPk9FWpwkd6kAMi3
 T8fFFtCCTHSGNfCTGrYywK+QbL7coyqAKEDwDm1sFHlfkEbzFlEYU52VFw2zBLQ0tE/xeH
 LSB5B80SU4XUBNXH1XcYCkhrXLVozF0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-555-WJ9XdAtzPy27uKDX4kd8Hg-1; Tue, 07 Dec 2021 23:09:26 -0500
X-MC-Unique: WJ9XdAtzPy27uKDX4kd8Hg-1
Received: by mail-lf1-f72.google.com with SMTP id
 u20-20020a056512129400b0040373ffc60bso518608lfs.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 20:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vj6SZJIYiS00fnwnMek5uYVUq8OZMiUnrKXwQGLzqU8=;
 b=LnRh1NKXLLNsOXrSdGyEy5VqouqTcmFYrUGrIUnWzeaat8HjS0ALzKp/MZhn5+WTJO
 A2l/WF8qTkrfSbvicqj9Yzq9suJPW9Uue+e1gDhXA6DM9xeQfdZVd+09SIPwv6UV4IDL
 TnDDVYeotRI1zs6C6MkvhF9ktFbGi22JjjSIWUk42Arck+5yFid//CuFKliIn/xW6+X4
 uHEEppompg+LxPnaBffI+ttjBS+vl86i0D9x+H1Oa2Yf2vlqHnpiAycSuVSN48QgVkS0
 WdnfC8EJbAmE9n+3MbfjA71udZHfjhSRweeVnfkhQudjDATzwkjLkZf6kbiFP0WBHRKo
 2Uxw==
X-Gm-Message-State: AOAM531GuiD8u6oXiy5Cb50v36F90FhOVwWWKFeuVde19W7l+KwFqUV3
 J08nDnAm0RMqnqjm3ETOvrPqgKgNwVcRNeUZaePrZYrswEETkICA8+YoS16Iqw4IS5uObU9Q7+n
 iLTnsRZTU8gVCbgxr99ah8IsS86BF2Wtev4YhhlfT5UXB0PWmn8RzFfD4iA==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr46272601lfe.84.1638936565107; 
 Tue, 07 Dec 2021 20:09:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0KgmLGuiU10Or4fsIYKOeKO/pjhHlczbQCTPT+G4O8RQWngp0GoIeGd9cXSlFD1lvfreYTlwpFINR+vQ9HU8=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr46272583lfe.84.1638936564907; 
 Tue, 07 Dec 2021 20:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-8-michael.christie@oracle.com>
In-Reply-To: <20211207024510.23292-8-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 12:09:13 +0800
Message-ID: <CACGkMEujVcX20+FpfmA6ab=gnx4NQ5FcdsT6Q4snMKyF3pYJig@mail.gmail.com>
Subject: Re: [PATCH 7/7] vhost-test: drop flush after vhost_dev_cleanup
To: Mike Christie <michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Ryabinin <arbn@yandex-team.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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

On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> The flush after vhost_dev_cleanup is not needed because:
>
> 1. It doesn't do anything. vhost_dev_cleanup will stop the worker thread
> so the flush call will just return since the worker has not device.
>
> 2. It's not needed. The comment about jobs re-queueing themselves does
> not look correct because handle_vq does not requeue work.

Similar to the previous patch, I wonder if it's the credit from
vhost_dev_cleanup().

Thanks

>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/test.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index d4f63068d762..57e24eceff27 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -158,9 +158,6 @@ static int vhost_test_release(struct inode *inode, struct file *f)
>         vhost_test_flush(n);
>         vhost_dev_stop(&n->dev);
>         vhost_dev_cleanup(&n->dev);
> -       /* We do an extra flush before freeing memory,
> -        * since jobs can re-queue themselves. */
> -       vhost_test_flush(n);
>         kfree(n);
>         return 0;
>  }
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
