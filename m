Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDBDC433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:09:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEC061A27
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEC061A27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02E1A82F06;
	Thu, 25 Mar 2021 10:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VSq4REUt2Yj8; Thu, 25 Mar 2021 10:09:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACBE982E95;
	Thu, 25 Mar 2021 10:09:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 904BDC000D;
	Thu, 25 Mar 2021 10:09:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 282C4C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16EAC40146
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d4YfjagV1mi5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71DBD400B8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616666961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHwyM01WyqgWKCfJirzSlimPQ/XDp3q0BkoluHcHB6k=;
 b=fOshzAmhyz3YZRsqQZEkv4kUhnpEHquOyfqHPcAb4c0gwkpzbI/prJ4NjirGaAbypRKrtQ
 TQo4teaffeHUp9SBBvb2ibETxRXKjC81l4upjvdlP2InB70FgbAs67DSDYpvbi5LchRpYY
 fDiqlGSHJrrqO5+D5aXWNr9phO2gGo4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Upea5oYSP0ejTswWPD19gQ-1; Thu, 25 Mar 2021 06:09:17 -0400
X-MC-Unique: Upea5oYSP0ejTswWPD19gQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 o9-20020a05600c4fc9b029010cea48b602so750349wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 03:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kHwyM01WyqgWKCfJirzSlimPQ/XDp3q0BkoluHcHB6k=;
 b=LKzPGdxjiik3rZffnRTKT2ROYsuuGfCC873tMq3gqyvIEhfPLmBZL2CGHElYzBTM7J
 W3S/L3GBNZlALVtJEXU8xrI81KNS9HsQqD7coNnS4QNA21IY/i78aF0NxE/VrXMonfSD
 uk9ccqUv149ERM+th24tToOgMwwiK8pH3hlnKsUEXW3y1qgfXLViA8bU2kH216f2l+FQ
 E0uebzBa6LmoAkataU6jjYk6ZF2DUJyawjbEaz2bCRKbg+9Y816AffYtobEeQeFmTU8Q
 hD7hjkxGkE9Hrq1X+PzqvPT1L8QFNQM1ktJHW0MYfBteBZJ4im+YH8XFSpEbZsCRBrxy
 c5DQ==
X-Gm-Message-State: AOAM533DN9m4bLB30mPT3k7uVMx7d5Lv4pagN03TBoBy4q8WOas24rHK
 CRNZmyQ1nmUD8k1dDeW++0bVrxOw5yAB+zQFyZhyNMVwzzUoCjBd0yHKVTLV8Z9pDnhqmI58pIx
 D9BtIGWYcnIGokQz6IKvs3DBLs8svwoc2D1TZML92BQ==
X-Received: by 2002:adf:a18a:: with SMTP id u10mr8019012wru.197.1616666956447; 
 Thu, 25 Mar 2021 03:09:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzyIyWOSmU8uyQs1/B6aVWJTTtn53k7n4EHV1c4wLdktCa9Xv2dMFQu8Wdv5ezJuNgAsU+aw==
X-Received: by 2002:adf:a18a:: with SMTP id u10mr8018978wru.197.1616666956222; 
 Thu, 25 Mar 2021 03:09:16 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s83sm6216998wms.16.2021.03.25.03.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 03:09:15 -0700 (PDT)
Date: Thu, 25 Mar 2021 11:09:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 13/22] virtio/vsock: add SEQPACKET receive logic
Message-ID: <20210325100913.7rewuc4wn7zwtrqf@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131316.2461284-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131316.2461284-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Tue, Mar 23, 2021 at 04:13:13PM +0300, Arseny Krasnov wrote:
>This modifies current receive logic for SEQPACKET support:
>1) Inserts 'SEQ_BEGIN' packet to socket's rx queue.
>2) Inserts 'RW' packet to socket's rx queue, but without merging with
>   buffer of last packet in queue.
>3) Performs check for packet and socket types on receive(if mismatch,
>   then reset connection).
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v6 -> v7:
> In 'virtio_transport_recv_pkt()', 'sock_put()' is added, when type of
> received packet does not match to the type of socket.
>
> net/vmw_vsock/virtio_transport_common.c | 64 +++++++++++++++++--------
> 1 file changed, 45 insertions(+), 19 deletions(-)


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
