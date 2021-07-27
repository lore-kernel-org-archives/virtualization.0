Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A588C4338F
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 08:00:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9078611ED
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 07:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9078611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 908084035F;
	Tue, 27 Jul 2021 07:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tb2Bw08IP93D; Tue, 27 Jul 2021 07:59:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F3FC440332;
	Tue, 27 Jul 2021 07:59:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA455C0010;
	Tue, 27 Jul 2021 07:59:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3A84C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 07:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EC0940332
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 07:59:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fxq2H_jos4wa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 07:59:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43AAA402BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627372793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/EIq4hrAP0Ac0pX1HeyNfiwT/0BIOEO0auXFwtqoKwk=;
 b=RzWYwwJW0HI5LovkIL/n3eKTaJxruFQFZsnR+6nAOLc2j7Rglx9g3B3OO8/iwDMO3JJluO
 bF9JqQ1V+P0JXy/QYLC698r4I7KJ8h8D419mWyLo6CPGB4Ma8XiPupjqQ/cqL7TbSRhrfT
 0m1snXyA+r3o2E6pOolbXbCf7ywX2q0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-rY1VPSERPS-igj2ATym2xw-1; Tue, 27 Jul 2021 03:59:52 -0400
X-MC-Unique: rY1VPSERPS-igj2ATym2xw-1
Received: by mail-ej1-f71.google.com with SMTP id
 yl23-20020a17090693f7b029051a448bab28so2805619ejb.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 00:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/EIq4hrAP0Ac0pX1HeyNfiwT/0BIOEO0auXFwtqoKwk=;
 b=F+03ia1G57la+ar6JVgHxPPZNDCmGpfHo7tDM2a1ycuMH8Jcv9tJfWxHTkd7BkxYju
 DV3RoIRGf8V8Wprh0KE/fjsV0GNbU3wSR1KdGQZUF3/zOJ04hIZ7oq24z32upnqhTFJF
 XuWLQb/hZnYrJM+rp03HYheM38UGFj00sWC/R/jgBFF5IBP/626+vJro4hizMs7FuxbT
 3yufPayhOWMxbMmhClX85stcmrt0KZtQG0aiCvOzqQs65JxJqkmXXIKqDIi1JYLhSCsl
 CeIdUMIxNbPHkUkXOQuUU5faBIfDxiUh9K1gI+JbrXNymD3PY9l1cfmZQQd+zQ4Q7/O4
 sXNw==
X-Gm-Message-State: AOAM5333+gFhE4v3AG3i6hLq+AvrDXOr0DexNIN3JBK78olYJ5VprPNQ
 WRWsbRBZwlgJf40EEKYf1Yv8NzCxdsIHxOCu0jdao8tiOIcSMN9fxXg+1sXit0p9Wt5k1SUIiDV
 AUyBaM1F0FlRALjYpNDKsG/iQwbVMNPdJCrDLZh2TMg==
X-Received: by 2002:a05:6402:12c3:: with SMTP id
 k3mr11211302edx.11.1627372791441; 
 Tue, 27 Jul 2021 00:59:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlCvS56tYgLWOzqJ8Wh70Fht2s02iJ7M5DydMmq9uVJaSBBqYQBS2qw7251aRYo+dt+iun8A==
X-Received: by 2002:a05:6402:12c3:: with SMTP id
 k3mr11211285edx.11.1627372791319; 
 Tue, 27 Jul 2021 00:59:51 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id i14sm613214eja.91.2021.07.27.00.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jul 2021 00:59:50 -0700 (PDT)
Date: Tue, 27 Jul 2021 09:59:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 0/7] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210727075948.yl4w3foqa6rp4obg@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Jul 26, 2021 at 07:31:33PM +0300, Arseny Krasnov wrote:
>	This patchset implements support of MSG_EOR bit for SEQPACKET
>AF_VSOCK sockets over virtio transport.
>	Idea is to distinguish concepts of 'messages' and 'records'.
>Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>etc. It has fixed maximum length, and it bounds are visible using
>return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>Current implementation based on message definition above.
>	Record has unlimited length, it consists of multiple message,
>and bounds of record are visible via MSG_EOR flag returned from
>'recvmsg()' call. Sender passes MSG_EOR to sending system call and
>receiver will see MSG_EOR when corresponding message will be processed.
>	To support MSG_EOR new bit was added along with existing
>'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
>works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
>is used to mark 'MSG_EOR' bit passed from userspace.

At this point it's probably better to rename the old flag, so we stay 
compatible.

What happens if one of the two peers does not support MSG_EOR handling, 
while the other does?

I'll do a closer review in the next few days.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
