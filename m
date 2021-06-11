Return-Path: <SRS0=zOA3=LF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE39C48BE5
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 12:25:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698C461357
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 12:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698C461357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A88383BAA;
	Fri, 11 Jun 2021 12:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rC1D1266DKoB; Fri, 11 Jun 2021 12:25:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AC04883B71;
	Fri, 11 Jun 2021 12:25:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75F22C000D;
	Fri, 11 Jun 2021 12:25:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01D05C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 12:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E409B83B74
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 12:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UvrH8bm5nrKv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 12:25:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C72D83B71
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 12:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623414338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+saQX1pFifHAMfA75K26b9IDNQxzW3sh1B/T8sEy8xE=;
 b=P7fQO0LHTp9kcgF1zZ03nFMXrCEGkvVSqBQ2+eQeadktk4YT+AXvOV3Jn0iWv6h0Aq+Fey
 +czm6UqcoV0B0xZ6fiiq9bW/sq/EUfXyyQKvHS/4djoiJs5vc2PHd0UZ+9reC+weuNF4wm
 Xaq8QI2ow7pO6ACiZDmJSHCAcCrcaAQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-LMB_LU0hNQWLuLVSdD_Nzw-1; Fri, 11 Jun 2021 08:25:37 -0400
X-MC-Unique: LMB_LU0hNQWLuLVSdD_Nzw-1
Received: by mail-ej1-f69.google.com with SMTP id
 br12-20020a170906d14cb02904311c0f32adso1084927ejb.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 05:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+saQX1pFifHAMfA75K26b9IDNQxzW3sh1B/T8sEy8xE=;
 b=dhmB3HFsAwuS2ByKJTWwhlJJp48yKtZ7QVNnocM2RaH+TtDpiHhJvudUDezXgUBIXn
 7tyIiCpBhj/FyDtxuPIuZXc7zZWRPVImwIPxqYlc2ha2InqXQF4tbgYOyMqeOZlTjiND
 KUqe4Q+Z4OrRpkcAt77ghuxQ2fjXHoOj8U5/QJpBNoWfpMmv4SbakkaQKYq65HP2250i
 WiTQz+g9vjaLg/qweF/NKKA+ouCbJ/1jeqjZNsqLZkZPnJM+d1hPeSy1Im5R0LENXcFQ
 QweWmDOQYzmc9mMxSz5VUFHxGVElPENAduCfU8tseN30YR1lBSef3FcudIIvlsnh5M74
 oWzA==
X-Gm-Message-State: AOAM530hGDpi3TiaT59V5vWSfc7+W6nl1AZCg6vnUmur8rrdJcKrV8aM
 +y8Ce5TkR/O1T6d00hFz+RpHdfGmmKtut5FoqyWmHq1H45s0jpNhnFbRcnde8CYu3nULIW6hTpv
 4y/9csS41itbwWVWUjDOv9OWOke5Hf3Z97PmtkEu7Ww==
X-Received: by 2002:a17:906:2b04:: with SMTP id a4mr3391582ejg.6.1623414336107; 
 Fri, 11 Jun 2021 05:25:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPbmShTD8/mzWY6bPdx7L57uktKQ4wfEOyzzKRXT1hmYodewrqYPlF9qdrHraWuNSTa7EpDQ==
X-Received: by 2002:a17:906:2b04:: with SMTP id a4mr3391574ejg.6.1623414335924; 
 Fri, 11 Jun 2021 05:25:35 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id x15sm2111520edd.6.2021.06.11.05.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 05:25:35 -0700 (PDT)
Date: Fri, 11 Jun 2021 14:25:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v11 00/18] virtio/vsock: introduce SOCK_SEQPACKET support
Message-ID: <20210611122533.cy4jce4vxhhou5ms@steredhat>
References: <20210611110744.3650456-1-arseny.krasnov@kaspersky.com>
 <59b720a8-154f-ad29-e7a9-b86b69408078@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <59b720a8-154f-ad29-e7a9-b86b69408078@kaspersky.com>
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

Hi Arseny,

On Fri, Jun 11, 2021 at 02:17:00PM +0300, Arseny Krasnov wrote:
>
>On 11.06.2021 14:07, Arseny Krasnov wrote:
>> 	This patchset implements support of SOCK_SEQPACKET for virtio
>> transport.
>> 	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>> do it, new bit for field 'flags' was added: SEQ_EOR. This bit is
>> set to 1 in last RW packet of message.
>> 	Now as  packets of one socket are not reordered neither on vsock
>> nor on vhost transport layers, such bit allows to restore original
>> message on receiver's side. If user's buffer is smaller than message
>> length, when all out of size data is dropped.
>> 	Maximum length of datagram is limited by 'peer_buf_alloc' value.
>> 	Implementation also supports 'MSG_TRUNC' flags.
>> 	Tests also implemented.
>>
>> 	Thanks to stsp2@yandex.ru for encouragements and initial design
>> recommendations.
>>
>>  Arseny Krasnov (18):
>>   af_vsock: update functions for connectible socket
>>   af_vsock: separate wait data loop
>>   af_vsock: separate receive data loop
>>   af_vsock: implement SEQPACKET receive loop
>>   af_vsock: implement send logic for SEQPACKET
>>   af_vsock: rest of SEQPACKET support
>>   af_vsock: update comments for stream sockets
>>   virtio/vsock: set packet's type in virtio_transport_send_pkt_info()
>>   virtio/vsock: simplify credit update function API
>>   virtio/vsock: defines and constants for SEQPACKET
>>   virtio/vsock: dequeue callback for SOCK_SEQPACKET
>>   virtio/vsock: add SEQPACKET receive logic
>>   virtio/vsock: rest of SOCK_SEQPACKET support
>>   virtio/vsock: enable SEQPACKET for transport
>>   vhost/vsock: enable SEQPACKET for transport
>>   vsock/loopback: enable SEQPACKET for transport
>>   vsock_test: add SOCK_SEQPACKET tests
>>   virtio/vsock: update trace event for SEQPACKET
>>
>>  drivers/vhost/vsock.c                              |  56 ++-
>>  include/linux/virtio_vsock.h                       |  10 +
>>  include/net/af_vsock.h                             |   8 +
>>  .../trace/events/vsock_virtio_transport_common.h   |   5 +-
>>  include/uapi/linux/virtio_vsock.h                  |   9 +
>>  net/vmw_vsock/af_vsock.c                           | 464 ++++++++++++------
>>  net/vmw_vsock/virtio_transport.c                   |  26 ++
>>  net/vmw_vsock/virtio_transport_common.c            | 179 +++++++-
>>  net/vmw_vsock/vsock_loopback.c                     |  12 +
>>  tools/testing/vsock/util.c                         |  32 +-
>>  tools/testing/vsock/util.h                         |   3 +
>>  tools/testing/vsock/vsock_test.c                   | 116 ++++++
>>  12 files changed, 730 insertions(+), 190 deletions(-)
>>
>>  v10 -> v11:
>>  General changelog:
>>   - now data is copied to user's buffer only when
>>     whole message is received.
>>   - reader is woken up when EOR packet is received.
>>   - if read syscall was interrupted by signal or
>>     timeout, error is returned(not 0).
>>
>>  Per patch changelog:
>>   see every patch after '---' line.
>So here is new version for review with updates discussed earlier :)

Thanks, I'll review next week, but I suggest you again to split in two 
series, since patchwork (and netdev maintainers) are not happy with a 
series of 18 patches.

If you still prefer to keep them together during development, then 
please use the RFC tag.

Also did you take a look at the FAQ for netdev that I linked last time?
I don't see the net-next tag...

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
