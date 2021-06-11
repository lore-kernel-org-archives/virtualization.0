Return-Path: <SRS0=zOA3=LF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2A9C48BE5
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 14:58:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5FA613B3
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 14:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5FA613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65D3840536;
	Fri, 11 Jun 2021 14:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4lrN50gs5cZo; Fri, 11 Jun 2021 14:58:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE5C540160;
	Fri, 11 Jun 2021 14:58:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B83F4C000D;
	Fri, 11 Jun 2021 14:58:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D6BAC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 14:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4973A606D6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 14:58:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zwAv4SOprT5f
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 14:58:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DAD3860670
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623423484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7t9i6rMyWuByO+c/GmhouwKqq18hXtoe9jqv+4wd88=;
 b=D2D9iKVipWG05fdEziT0x+MeUKnbmFQMUb1L32mjhw97HXCRQO6q1ghVJAI8ZMF2mBEuU+
 cQxS3l/CPhMFejC3SvIlNJP9TvxzB212h0pl60wQEj1KIlS7CTrjvq08CY7d92KZZC9CrV
 ZZSIwePFWDFnghrXcKsBoYs83ju+1g8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-fL7sxlqQMUSR4ENm4nBB3w-1; Fri, 11 Jun 2021 10:58:01 -0400
X-MC-Unique: fL7sxlqQMUSR4ENm4nBB3w-1
Received: by mail-ej1-f72.google.com with SMTP id
 n19-20020a1709067253b029043b446e4a03so1237954ejk.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 07:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t7t9i6rMyWuByO+c/GmhouwKqq18hXtoe9jqv+4wd88=;
 b=ip1x/o1kITB6ivH+x7aj8pJg6W+BUghQN6OO/mF7efgU+itRk/H0t0Nm7QwgpDVbND
 +RSx7MdebcGioOui/vqiVVFbWKKGArW2OffmDDGcot2AM6bENtUKWGVOAJKimfY2UlTE
 wHRjaNkh/Vh7Xa4Px6EjjZ1VvVKH8GWMCCre+bui95mQ6E3f/L73piwgrvfBrRbigIcc
 ErvdfosXmENYt491VnqqAzh375Vwp9FLtw7P1t0Fszxuz1jS/BaPtz10zB0AsDjOwbLI
 fyPpyiNlIf9CZNTB+LU4pCrlmB+xn5J/wGPI5FHPWjgKixRTmMbeEBX8D068W+cykq5R
 j1CQ==
X-Gm-Message-State: AOAM530dNIGTSPkrOaNpRoET3d73TjQ8GmdhkzUqZvSf9uE0/bRKVXXI
 h3w3JgD0XoMv2K/pzqIj3rbX7uHzDfINn1O/8AmObwPh583UKbatsICdbj4MMplCUk+VLuHiHUC
 iEKMdCY54jqpEyk4/HiL9rTcWzWUJld13Ur/WBBFH6A==
X-Received: by 2002:a17:906:5a9a:: with SMTP id
 l26mr4120580ejq.490.1623423479993; 
 Fri, 11 Jun 2021 07:57:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8VqZfIaLC40HefRlsycmNOXzMhFAN1j/Qj/MysEFnXaFHjn+zcDKs93tZTDyfEUtgXzDS+g==
X-Received: by 2002:a17:906:5a9a:: with SMTP id
 l26mr4120562ejq.490.1623423479766; 
 Fri, 11 Jun 2021 07:57:59 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id o4sm2647440edc.94.2021.06.11.07.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 07:57:59 -0700 (PDT)
Date: Fri, 11 Jun 2021 16:57:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v11 00/18] virtio/vsock: introduce SOCK_SEQPACKET support
Message-ID: <20210611145756.lfi7dwvxqwjhkctr@steredhat>
References: <20210611110744.3650456-1-arseny.krasnov@kaspersky.com>
 <59b720a8-154f-ad29-e7a9-b86b69408078@kaspersky.com>
 <20210611122533.cy4jce4vxhhou5ms@steredhat>
 <10a64ff5-86df-85f3-5cf2-2fa7e8ddc294@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <10a64ff5-86df-85f3-5cf2-2fa7e8ddc294@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Fri, Jun 11, 2021 at 05:39:01PM +0300, Arseny Krasnov wrote:
>
>On 11.06.2021 15:25, Stefano Garzarella wrote:
>> Hi Arseny,
>>
>> On Fri, Jun 11, 2021 at 02:17:00PM +0300, Arseny Krasnov wrote:
>>> On 11.06.2021 14:07, Arseny Krasnov wrote:
>>>> 	This patchset implements support of SOCK_SEQPACKET for virtio
>>>> transport.
>>>> 	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>>>> do it, new bit for field 'flags' was added: SEQ_EOR. This bit is
>>>> set to 1 in last RW packet of message.
>>>> 	Now as  packets of one socket are not reordered neither on vsock
>>>> nor on vhost transport layers, such bit allows to restore original
>>>> message on receiver's side. If user's buffer is smaller than message
>>>> length, when all out of size data is dropped.
>>>> 	Maximum length of datagram is limited by 'peer_buf_alloc' value.
>>>> 	Implementation also supports 'MSG_TRUNC' flags.
>>>> 	Tests also implemented.
>>>>
>>>> 	Thanks to stsp2@yandex.ru for encouragements and initial design
>>>> recommendations.
>>>>
>>>>  Arseny Krasnov (18):
>>>>   af_vsock: update functions for connectible socket
>>>>   af_vsock: separate wait data loop
>>>>   af_vsock: separate receive data loop
>>>>   af_vsock: implement SEQPACKET receive loop
>>>>   af_vsock: implement send logic for SEQPACKET
>>>>   af_vsock: rest of SEQPACKET support
>>>>   af_vsock: update comments for stream sockets
>>>>   virtio/vsock: set packet's type in virtio_transport_send_pkt_info()
>>>>   virtio/vsock: simplify credit update function API
>>>>   virtio/vsock: defines and constants for SEQPACKET
>>>>   virtio/vsock: dequeue callback for SOCK_SEQPACKET
>>>>   virtio/vsock: add SEQPACKET receive logic
>>>>   virtio/vsock: rest of SOCK_SEQPACKET support
>>>>   virtio/vsock: enable SEQPACKET for transport
>>>>   vhost/vsock: enable SEQPACKET for transport
>>>>   vsock/loopback: enable SEQPACKET for transport
>>>>   vsock_test: add SOCK_SEQPACKET tests
>>>>   virtio/vsock: update trace event for SEQPACKET
>>>>
>>>>  drivers/vhost/vsock.c                              |  56 ++-
>>>>  include/linux/virtio_vsock.h                       |  10 +
>>>>  include/net/af_vsock.h                             |   8 +
>>>>  .../trace/events/vsock_virtio_transport_common.h   |   5 +-
>>>>  include/uapi/linux/virtio_vsock.h                  |   9 +
>>>>  net/vmw_vsock/af_vsock.c                           | 464 ++++++++++++------
>>>>  net/vmw_vsock/virtio_transport.c                   |  26 ++
>>>>  net/vmw_vsock/virtio_transport_common.c            | 179 +++++++-
>>>>  net/vmw_vsock/vsock_loopback.c                     |  12 +
>>>>  tools/testing/vsock/util.c                         |  32 +-
>>>>  tools/testing/vsock/util.h                         |   3 +
>>>>  tools/testing/vsock/vsock_test.c                   | 116 ++++++
>>>>  12 files changed, 730 insertions(+), 190 deletions(-)
>>>>
>>>>  v10 -> v11:
>>>>  General changelog:
>>>>   - now data is copied to user's buffer only when
>>>>     whole message is received.
>>>>   - reader is woken up when EOR packet is received.
>>>>   - if read syscall was interrupted by signal or
>>>>     timeout, error is returned(not 0).
>>>>
>>>>  Per patch changelog:
>>>>   see every patch after '---' line.
>>> So here is new version for review with updates discussed earlier :)
>> Thanks, I'll review next week, but I suggest you again to split in two
>> series, since patchwork (and netdev maintainers) are not happy with a
>> series of 18 patches.
>>
>> If you still prefer to keep them together during development, then
>> please use the RFC tag.
>>
>> Also did you take a look at the FAQ for netdev that I linked last 
>> time?
>> I don't see the net-next tag...
>
>I didn't use next tag because two patches from first seven(which was
>
>considered to be sent to netdev) - 0004 and 0006
>
>were changed in this patchset(because of last ideas about queueing
>
>whole message). So i removed R-b line and now there is no sense to
>
>use net-next tag for first patches. When it will be R-b - i'll send it 

Okay, in that case better to use RFC tag.

>to
>
>netdev with such tag and we can continue discussing second part
>
>of patches(virtio specific).

Don't worry for now. You can do it for the next round, but I think all 
the patches will go through netdev and would be better to split in 2 
series, both of them with net-next tag.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
