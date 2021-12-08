Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2795C433FE
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 04:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 928D960EFF;
	Wed,  8 Dec 2021 04:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-o0zGR_hCYS; Wed,  8 Dec 2021 04:24:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5AB6060EF6;
	Wed,  8 Dec 2021 04:24:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14E43C002F;
	Wed,  8 Dec 2021 04:24:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B558C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6423F41D8E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JiHZyCvk00kr
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:24:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77C1A41D8D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638937456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnkeec58MbvU+mMJ3s+6/jmIYG3nDgFfteK0w/klgc8=;
 b=I8ShHuJWecM0T6/Z6SckjNoXc8Rr6tA6QRdVUFGRQG6dHDbnXBNNAv26mvoxEjs117pIRT
 KOF+wy86BCS1LzM6ocQJQ9+0QurSbdrw9sg6eO+7ErS76vk/1HaqdMEbDbGH+UoWO3bh+h
 dSX1yuMSt5Bk80TzTwk0NUpi6UOVRwE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-gjQaJyXDPkKzlootJ_62jQ-1; Tue, 07 Dec 2021 23:24:15 -0500
X-MC-Unique: gjQaJyXDPkKzlootJ_62jQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 t9-20020a056512068900b00417ba105469so552554lfe.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 20:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hnkeec58MbvU+mMJ3s+6/jmIYG3nDgFfteK0w/klgc8=;
 b=hBo/gODWhPZV09CdXouYGsZeeatMhlYxtbymEwQ1zoUWHKFv2s2CpqDfWXiVeLt8L6
 P/zrOPaOUbCixEGnY3gwzMjVvurI66NsXwSNVTDafu5obuoD3PiCR9CGzfKAPQgmxVsu
 n87AI6IEEsiCcViKdDpJXFcei/L1xOnE90WZrK4Fy/Cb9WMM6Z7kWqOxdRAVv8Jiv1vr
 ukeAylq3quUW3AkTMH3pERIBnR5PgVDqP8DJ/zU2KAqzrY8f1XR8t9v+M4HU/R1BJMN0
 qy8965D2Rg7mzQ8lS3cMNE5RVIIPwGEdUwgxGkplZ8pDTtrUFuRfuXHgx1viEsJd0qjh
 ry/A==
X-Gm-Message-State: AOAM533Dr3uDXgWYRxwI+87k+/cA/PI8e3xWo3VFKXBj5FJ30NJ69VOu
 6+p8GcR8dG0Iq968HzhE1/koi7i6mwhplDLwsSgxIaRrYhuYsuXEXVxzzuercW96jQowVRDIZVB
 T1ZCMVSG1dE/V/tmO0UEBnGBhKka3L7wATG7WusW2okYs5UBkzw+T/0VEaA==
X-Received: by 2002:a2e:b742:: with SMTP id k2mr47717009ljo.107.1638937453528; 
 Tue, 07 Dec 2021 20:24:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXBQhZIWJ2mKjBeEXvEJ+Z6rREz17GcGHg85bnccKQVzrnxg0n0UvNDUoskUxyeTOvEpr4ldqQWQWb+dL+jYg=
X-Received: by 2002:a2e:b742:: with SMTP id k2mr47716983ljo.107.1638937453292; 
 Tue, 07 Dec 2021 20:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20211207025117.23551-1-michael.christie@oracle.com>
In-Reply-To: <20211207025117.23551-1-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 12:24:02 +0800
Message-ID: <CACGkMEtHm-6pBAdc=ZuXggMwdZ9X1ysnZjUxQFzyBaWtyP5SHg@mail.gmail.com>
Subject: Re: [PATCH V5 00/12] vhost: multiple worker support
To: Mike Christie <michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-scsi@vger.kernel.org, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, Dec 7, 2021 at 10:51 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> The following patches apply over linus's tree and the user_worker
> patchset here:
>
> https://lore.kernel.org/virtualization/20211129194707.5863-1-michael.christie@oracle.com/T/#t

It looks to me it gets some acks, maybe we need to nudge the
maintainer to merge that? This may simplify the review.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
