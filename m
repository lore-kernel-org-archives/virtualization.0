Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDDAC6FA82
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 15:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ED8F408CB;
	Wed, 21 Sep 2022 15:08:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5ED8F408CB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iXwIAMIZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nJc9CHNI2vkh; Wed, 21 Sep 2022 15:08:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 80895408CA;
	Wed, 21 Sep 2022 15:08:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80895408CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54F2AC0033;
	Wed, 21 Sep 2022 15:08:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1431C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C69C8136F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:08:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C69C8136F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iXwIAMIZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d2ZS1pojC0lU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:08:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C81981368
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C81981368
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663772926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ptp1oLSt177eSTGNW8YxvUlUM4rs67KrLKfl9pj1Lys=;
 b=iXwIAMIZtd1F+2omRf5mhg+42DheRLbxGcX2NBPrfqqGiGgePj2TAZqid8EYSBNq7mzZDT
 LL3ZDp3tVWo3egM3nc1s3k2KlSV9+7eokMLR7sELWEWf6v02VMGcd6CDW55qRuVKoV0IHa
 L5uIX/9Z5lw0yWLWrzzlF8rlzohiapc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-tO0414CVPqWxOvY4VL9jzw-1; Wed, 21 Sep 2022 11:08:45 -0400
X-MC-Unique: tO0414CVPqWxOvY4VL9jzw-1
Received: by mail-qt1-f198.google.com with SMTP id
 s21-20020a05622a1a9500b0035bb9e79172so4401945qtc.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=Ptp1oLSt177eSTGNW8YxvUlUM4rs67KrLKfl9pj1Lys=;
 b=ymNSHIhNdXZr3lwZpUHChUN+NlMq2rPtKWqabzbRAmiUJHdnjjo8BtYKEeaxdAeb5j
 9I7QuV5KD6naMcplpTvW3RSw2BwWnLjggtjig61w4AOgJCN/AGwV4CO4f8/9U920Iybq
 Nbck15wAIPaB6dXogrzp4s+08xwrNpYtcBBZwZndhNHIgzMO7/w5Ol59NHUCngyMD2xT
 bsx9Z4SLjU4hncaWDQFqfX5T8l0pz3PjiNDGkqWJ6mBXFKnon9iSrazMb9wWkjamjepg
 I4a4+NUgHIFuRkvOSw2m1eZv6HeRQUPEmLVihOaxMoNQKcwhOt9HiGvG48/SMP/h0Fd1
 7I9A==
X-Gm-Message-State: ACrzQf3aYhGJdydqf8yHFN08tQ2N19kXpppzKU1rwQXBhXnGa2jNx0E6
 0P4/bkyP/+fY5PJN/6EdxIUr8COvHldNWrt7OvNX2bqO4HvcSuDWaMoGICPNSwNzbRyLWOQUMIT
 LpuqEBUGYC1JuByBSxitH4usFVWAbYWrxODoFhODC
X-Received: by 2002:ac8:7d85:0:b0:35b:f5b1:63df with SMTP id
 c5-20020ac87d85000000b0035bf5b163dfmr23884641qtd.113.1663772924832; 
 Wed, 21 Sep 2022 08:08:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4EexL7l8DWx+8oreUyHWUiCWf8NA2huyVubxlwg6z5TXJwF+130R2NsOA173MiJm0z6yEZRA==
X-Received: by 2002:ac8:7d85:0:b0:35b:f5b1:63df with SMTP id
 c5-20020ac87d85000000b0035bf5b163dfmr23884597qtd.113.1663772924537; 
 Wed, 21 Sep 2022 08:08:44 -0700 (PDT)
Received: from localhost ([217.138.198.196]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac857c7000000b0035bbb6268e2sm2041812qta.67.2022.09.21.08.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Sep 2022 08:08:44 -0700 (PDT)
Date: Wed, 21 Sep 2022 11:08:43 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Daniil Lunev <dlunev@google.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <Yyso+9ChDJQUf9B1@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <Yylvvm3zVgqpqDrm@infradead.org>
 <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
 <YymkSDsFVVg1nbDP@infradead.org>
 <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Sarthak Kukreti <sarthakkukreti@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-ext4@vger.kernel.org, Evan Green <evgreen@google.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Tue, Sep 20 2022 at  5:48P -0400,
Daniil Lunev <dlunev@google.com> wrote:

> > There is no such thing as WRITE UNAVAILABLE in NVMe.
> Apologize, that is WRITE UNCORRECTABLE. Chapter 3.2.7 of
> NVM Express NVM Command Set Specification 1.0b
> 
> > That being siad you still haven't actually explained what problem
> > you're even trying to solve.
> 
> The specific problem is the following:
> * There is an thinpool over a physical device
> * There are multiple logical volumes over the thin pool
> * Each logical volume has an independent file system and an
>   independent application running over it
> * Each application is potentially allowed to consume the entirety
>   of the disk space - there is no strict size limit for application
> * Applications need to pre-allocate space sometime, for which
>   they use fallocate. Once the operation succeeded, the application
>   assumed the space is guaranteed to be there for it.
> * Since filesystems on the volumes are independent, filesystem
>   level enforcement of size constraints is impossible and the only
>   common level is the thin pool, thus, each fallocate has to find its
>   representation in thin pool one way or another - otherwise you
>   may end up in the situation, where FS thinks it has allocated space
>   but when it tries to actually write it, the thin pool is already
>   exhausted.
> * Hole-Punching fallocate will not reach the thin pool, so the only
>   solution presently is zero-writing pre-allocate.
> * Not all storage devices support zero-writing efficiently - apart
>   from NVMe being or not being capable of doing efficient write
>   zero - changing which is easier said than done, and would take
>   years - there are also other types of storage devices that do not
>   have WRITE ZERO capability in the first place or have it in a
>   peculiar way. And adding custom WRITE ZERO to LVM would be
>   arguably a much bigger hack.
> * Thus, a provisioning block operation allows an interface specific
>   operation that guarantees the presence of the block in the
>   mapped space. LVM Thin-pool itself is the primary target for our
>   use case but the argument is that this operation maps well to
>   other interfaces which allow thinly provisioned units.

Thanks for this overview. Should help level-set others.

Adding fallocate support has been a long-standing dm-thin TODO item
for me. I just never got around to it. So thanks to Sarthak, you and
anyone else who had a hand in developing this.

I had a look at the DM thin implementation and it looks pretty simple
(doesn't require a thin-metadata change, etc).  I'll look closer at
the broader implementation (block, etc) but I'm encouraged by what I'm
seeing.

Mike

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
