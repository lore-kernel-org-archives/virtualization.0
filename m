Return-Path: <SRS0=Cini=I5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E5C433DB
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 06:42:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9037E619C2
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 06:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9037E619C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 445A06085A;
	Wed, 31 Mar 2021 06:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lxdjkNq6C8d2; Wed, 31 Mar 2021 06:42:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2080600CA;
	Wed, 31 Mar 2021 06:42:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB544C000C;
	Wed, 31 Mar 2021 06:42:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6068C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 06:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AE4840175
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 06:42:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14qpLSNY7rMK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 06:42:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9889D4010B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 06:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617172964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TGL3q0WQXkcvDkZwQuL70y4prkcj4lly+0v0FBTwfHg=;
 b=G/hdAlChtKCylRnhOkpKziZ3UFKLT6mgVx/fuYfiTyWU8U8DMJrDhfGKRjFz0RVv/AIHWg
 /9DJRpVjzuEXQtOE6c6Gt5Lj9SVQVF1GL83DqqItjpgPyEZ2bN1efDB9i8TauL99IM6575
 rqhA6VtWSPu7SPk6IIM7GfWedC4RWRA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-N1Ox7AtKOjySUfDAArxYDQ-1; Wed, 31 Mar 2021 02:42:39 -0400
X-MC-Unique: N1Ox7AtKOjySUfDAArxYDQ-1
Received: by mail-wm1-f72.google.com with SMTP id k132so359962wma.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 23:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TGL3q0WQXkcvDkZwQuL70y4prkcj4lly+0v0FBTwfHg=;
 b=YMpW5+isf1ycq70+zUHcoAUPezWxBSR3IXz1xGHjeWPhqZxDEyGhQMlC2e7s00qTZV
 /IudIY0kcqUPnzCZyRwdnx8FrRp6RZMF9ItrXF5iFLvhdQW3bS4THbxIpFevUP0T45zl
 1sEMlS1/bN7pbREQi53b5GwOFGGZz2AnyPDsJqfmzY80k5XFxlt6OtIe2sz/Cvxu4d1g
 BRvbrqluv12X5BsndGev51GLpLwYibTfmrLRu5fTWIUIyJdDXI4TauNwRLqx8HtSxFNp
 hqpj6qgpZ5CU0xS8uJ+xLKI1CSHKlibdKZfgmkVR6CTCOksgmvemQ6GhB+cc4Cca1OJC
 T6kQ==
X-Gm-Message-State: AOAM531AmYTuy8ZeYGO97RTW4fxO/GbztRbp2+Dvui/wD+5TWwWYZ1+M
 TSbqF37DDp8qZrZFvTHyCvyivMKZy01xCvrQIGTOPGCgB697rYbHtbfYehoTbFy5v7QP31WDaKP
 8liy6RzRXiQ23O1k7GkO12W4Qw+VZBmtrlp/EXdV8Ag==
X-Received: by 2002:a05:600c:22c7:: with SMTP id
 7mr1668018wmg.85.1617172958868; 
 Tue, 30 Mar 2021 23:42:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9M4OWTOkQi9a/Zle+ApvuUltVpd7I1SrzC3+sdVlV0PMIK5pb7qpKG68hPhsUgcQP8k72eg==
X-Received: by 2002:a05:600c:22c7:: with SMTP id
 7mr1668002wmg.85.1617172958655; 
 Tue, 30 Mar 2021 23:42:38 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id o15sm2500094wra.93.2021.03.30.23.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 23:42:38 -0700 (PDT)
Date: Wed, 31 Mar 2021 08:42:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
Message-ID: <20210331064236.44h55kysvnfsxeee@steredhat>
References: <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
 <20210322190517-mutt-send-email-mst@kernel.org>
 <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
 <YFmsb6o82KOSml9u@stefanha-x1.localdomain>
 <CAP_N_Z9g3VUeLGtC0D0EGmHk7D1RxFQvUBMzLDMkct5b=t6x3A@mail.gmail.com>
 <20210330153231.duj6wqnekztdherp@steredhat>
 <CAP_N_Z8Z1hzWSoU3ezUDz0+_EkGjgRJVgsuDGvOcEe7MkTsHTQ@mail.gmail.com>
 <CAP_N_Z956yVDq1P38skH7EXNB-uD_P2tCV=sMYFkUqm2ru4ojw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z956yVDq1P38skH7EXNB-uD_P2tCV=sMYFkUqm2ru4ojw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>, asias@redhat.com,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 30, 2021 at 06:02:33PM -0700, Jiang Wang . wrote:
>Hi Stefano,
>
>I checked dgram code again. I think assigning transport for each packet
>is doable. The dgram will be similar to stream to have two transports.

Yeah, make sense.

>
>If there is no other problem, I can submit a Linux kernel patch to support
>nested dgram on VMCI first. Then it will be easier for virtio vsock.

Okay, I'll look to the patches when you will send.

>
>Also, I don't think we need to put anything related to this multiple-
>transport support in the spec.  Let me know if otherwise.

Agree, it's related to the implementation.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
