Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11470C433B4
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 14:10:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66B661439
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 14:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66B661439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 619A6404A0;
	Thu, 13 May 2021 14:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EOFqxFTBauwt; Thu, 13 May 2021 14:10:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8DB340437;
	Thu, 13 May 2021 14:10:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80CDAC000E;
	Thu, 13 May 2021 14:10:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A5A5C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C390400D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vt988JEIieUG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:10:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19B33400C4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620915024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cUgVX0TtQOw33OQHk7jduOTQRZ441iaMNO9LgK0Gtaw=;
 b=AHZx9IYhxb+Eoaxu8GKScAthgEP6V1hHaCuO72a+Y1SCfKBuKqtNG4usH2B1FRw9jl/qGb
 DdlXp3R6PXFZRxJdeLzv1oeff88go7L53Ok9umG2PDvAz7cW7mhJ3OUdQeozJO0LEoB7XH
 /37WToMzkH+8L4hcRCB+FY8NZTQoctA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-TZIFtXNyMh-t6aqj5s7XuA-1; Thu, 13 May 2021 10:10:23 -0400
X-MC-Unique: TZIFtXNyMh-t6aqj5s7XuA-1
Received: by mail-ed1-f71.google.com with SMTP id
 z12-20020aa7d40c0000b0290388179cc8bfso14638532edq.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 07:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cUgVX0TtQOw33OQHk7jduOTQRZ441iaMNO9LgK0Gtaw=;
 b=q03FEhhSFDvbGGRGkeJq11tzIwSaUQ6NIlyPGqZFQ3uKFdmvzlz8JDLC5EVIPiE4gb
 v34LMA/HFXEHAhLUtaUCRjQAi5AZL7fi64XVPV7Ygt6qtyn4W1SmwOJQhwC4+LY+XCUO
 0riiXMWSNuBYkDHhMBbpK+xq3RDoj+547F6FLHkS6h9aMzbKbkGyTRTVWw7tHjnwGj1P
 DTyyWhhJr/s+i6kQmQaZAP2NCiI9xbwZOPCZQqoJFKpypNWqBXCgdRm/D0iQ308M2wXc
 L7nES14jcaVF/0eB5wFBJmCMg6kMGYTCxN6RO92K8eQQmjFQrWBXi+//beCLAVvnLpjN
 cDDg==
X-Gm-Message-State: AOAM532fUiZYS52ZzFgSK3+hjv6/Xfq6mnPt02fGcJq8v7yYm6r1Xtto
 +ehR/uqFm6w8A1efamQw/98nlAud7wuLjb6h7wt0vdwYlWZ7NcNNVvuNFvgErKouZN7ClMExQtJ
 W36duyWga0npu9ZSyJuSjafa/kH5HFLwR6yaukhBoqg==
X-Received: by 2002:a05:6402:2753:: with SMTP id
 z19mr50413580edd.158.1620915021854; 
 Thu, 13 May 2021 07:10:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp3m8czj990oJcgrq3r1y1d2MyGwI6B6St58aGtioobv+NKtOs+1ULQ9LjfW982v9t9xMbEw==
X-Received: by 2002:a05:6402:2753:: with SMTP id
 z19mr50413547edd.158.1620915021631; 
 Thu, 13 May 2021 07:10:21 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id z4sm2390717edc.1.2021.05.13.07.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 07:10:20 -0700 (PDT)
Date: Thu, 13 May 2021 16:10:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 00/19] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210513141018.pqsmb5wqbjrbwwho@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
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
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

Hi Arseny,

On Sat, May 08, 2021 at 07:30:23PM +0300, Arseny Krasnov wrote:
>	This patchset implements support of SOCK_SEQPACKET for virtio
>transport.
>	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>do it, new bit for field 'flags' was added: SEQ_EOR. This bit is
>set to 1 in last RW packet of message.
>	Now as  packets of one socket are not reordered neither on vsock
>nor on vhost transport layers, such bit allows to restore original
>message on receiver's side. If user's buffer is smaller than message
>length, when all out of size data is dropped.
>	Maximum length of datagram is not limited as in stream socket,
>because same credit logic is used. Difference with stream socket is
>that user is not woken up until whole record is received or error
>occurred. Implementation also supports 'MSG_TRUNC' flags.
>	Tests also implemented.
>
>	Thanks to stsp2@yandex.ru for encouragements and initial design
>recommendations.
>
> Arseny Krasnov (19):
>  af_vsock: update functions for connectible socket
>  af_vsock: separate wait data loop
>  af_vsock: separate receive data loop
>  af_vsock: implement SEQPACKET receive loop
>  af_vsock: implement send logic for SEQPACKET
>  af_vsock: rest of SEQPACKET support
>  af_vsock: update comments for stream sockets
>  virtio/vsock: set packet's type in virtio_transport_send_pkt_info()
>  virtio/vsock: simplify credit update function API
>  virtio/vsock: defines and constants for SEQPACKET
>  virtio/vsock: dequeue callback for SOCK_SEQPACKET
>  virtio/vsock: add SEQPACKET receive logic
>  virtio/vsock: rest of SOCK_SEQPACKET support
>  virtio/vsock: enable SEQPACKET for transport
>  vhost/vsock: enable SEQPACKET for transport
>  vsock/loopback: enable SEQPACKET for transport
>  vsock_test: add SOCK_SEQPACKET tests
>  virtio/vsock: update trace event for SEQPACKET
>  af_vsock: serialize writes to shared socket
>
> drivers/vhost/vsock.c                        |  42 +-
> include/linux/virtio_vsock.h                 |   9 +
> include/net/af_vsock.h                       |   8 +
> .../events/vsock_virtio_transport_common.h   |   5 +-
> include/uapi/linux/virtio_vsock.h            |   9 +
> net/vmw_vsock/af_vsock.c                     | 417 +++++++++++------
> net/vmw_vsock/virtio_transport.c             |  25 +
> net/vmw_vsock/virtio_transport_common.c      | 129 ++++-
> net/vmw_vsock/vsock_loopback.c               |  11 +
> tools/testing/vsock/util.c                   |  32 +-
> tools/testing/vsock/util.h                   |   3 +
> tools/testing/vsock/vsock_test.c             |  63 +++
> 12 files changed, 594 insertions(+), 159 deletions(-)
>
> v8 -> v9:
> General changelog:
> - see per patch change log.
>

I reviewed this series and left some comments.

Before remove the RFC tag, please check that all the commit messages 
contains the right information.

Also, I recommend you take a look on how the other commits in the Linux 
tree are written because the commits in this series look like todo 
lists.
For RFC could be fine, but for the final version it would be better to 
rewrite them following the advice written here: 
Documentation/process/submitting-patches.rst

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
