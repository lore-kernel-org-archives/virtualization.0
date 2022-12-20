Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D59C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 10:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E69240890;
	Tue, 20 Dec 2022 10:38:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E69240890
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XcyauHfe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DfdawAtmN8u6; Tue, 20 Dec 2022 10:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A106740879;
	Tue, 20 Dec 2022 10:38:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A106740879
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 190D8C0035;
	Tue, 20 Dec 2022 10:38:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7DB0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30C8460B4E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:38:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30C8460B4E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XcyauHfe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C2MTS-vcFi3P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:38:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BE4960A9E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BE4960A9E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671532714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGyKBGNxgSsLzO3pKUHqDVQ10lAuvdMbzCBmDzDMwWg=;
 b=XcyauHfe71i4+bKomEIxCppm38XAShBaBPnIyYi/ddqjDNTuqh/Aj5YBol0aLR3trUg2Tb
 J+5K9Cvk6XnfUg1FW0bG6T6Mp+VKZpxu7Y53y8uKa5zB0vAZkOMKC3zVgI0NlecRxX3X6T
 FJLpHl9iXWgcfeySnAk+GHV8skLYFHE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-116-KBIb6DoVOXObjIKetD9ASw-1; Tue, 20 Dec 2022 05:38:33 -0500
X-MC-Unique: KBIb6DoVOXObjIKetD9ASw-1
Received: by mail-wm1-f69.google.com with SMTP id
 v188-20020a1cacc5000000b003cf76c4ae66so7858366wme.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 02:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGyKBGNxgSsLzO3pKUHqDVQ10lAuvdMbzCBmDzDMwWg=;
 b=QlBhxezjn70cHG2pKKMMMaLeDh4N2KLEqu6QIKsmE2nE5OKv7DYAt0UgyTlvs40ZdU
 IiI41F5l3inSieomCXEOHcxCEyeWezIHDDZagQnpcOukpFSKLsdmU6pqUuX7v08wzSyq
 j/WDyqXAHEuhAXKwD7InL7qBJd6aQrWazpvqq9wDrFgoZqnW+c2HNyf56RXPGNU7hHZS
 rzFDqGSqLgQTb1An9RqSpYhQUTvbkZZNrZD4JgWnTt5wBZrPA6dD8kYu6w5bU0upZuwq
 Jxrm57UNUcq25R00clJ16qTxB35lhfM8W6LPjLwgQDE0IlCjorfcS9CKAMKcl+EUlbkB
 bexg==
X-Gm-Message-State: ANoB5plFmfJbCZA8UOTmEIjYr1oYKdeIGOsJv7QKypYVWOmDvS4BnMoZ
 GCCdQ75Hhv3lb9nlHD3ImSORjQIu4wQ8z2XbR/R+45cNeRhBVq5srxTz8rAukrLnQmDyuWk6eaA
 tI6CmJMGtWl3lHGrlUglQkNvvv+1OexgEjZB3Rp2zRQ==
X-Received: by 2002:a5d:6a0c:0:b0:242:4bbe:2d20 with SMTP id
 m12-20020a5d6a0c000000b002424bbe2d20mr27326560wru.42.1671532710892; 
 Tue, 20 Dec 2022 02:38:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6khTwIwEcU2qnc4GKFKF5TXghb3TA4wdU4AkUtOMeLLbU1Z1pmd4Etf27CLPRLnoQwbbImWA==
X-Received: by 2002:a5d:6a0c:0:b0:242:4bbe:2d20 with SMTP id
 m12-20020a5d6a0c000000b002424bbe2d20mr27326542wru.42.1671532710621; 
 Tue, 20 Dec 2022 02:38:30 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 s13-20020a5d510d000000b00241e5b917d0sm14621347wrt.36.2022.12.20.02.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 02:38:30 -0800 (PST)
Date: Tue, 20 Dec 2022 11:38:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 0/4] vsock: update tools and error handling
Message-ID: <20221220103824.w7xcwsg3o2mls7cs@sgarzare-redhat>
References: <e04f749e-f1a7-9a1d-8213-c633ffcc0a69@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <e04f749e-f1a7-9a1d-8213-c633ffcc0a69@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Tue, Dec 20, 2022 at 07:16:38AM +0000, Arseniy Krasnov wrote:
>Patchset consists of two parts:
>
>1) Kernel patch
>One patch from Bobby Eshleman. I took single patch from Bobby:
>https://lore.kernel.org/lkml/d81818b868216c774613dd03641fcfe63cc55a45
>.1660362668.git.bobby.eshleman@bytedance.com/ and use only part for
>af_vsock.c, as VMCI and Hyper-V parts were rejected.
>
>I used it, because for SOCK_SEQPACKET big messages handling was broken -
>ENOMEM was returned instead of EMSGSIZE. And anyway, current logic which
>always replaces any error code returned by transport to ENOMEM looks
>strange for me also(for example in EMSGSIZE case it was changed to
>ENOMEM).
>
>2) Tool patches
>Since there is work on several significant updates for vsock(virtio/
>vsock especially): skbuff, DGRAM, zerocopy rx/tx, so I think that this
>patchset will be useful.
>
>This patchset updates vsock tests and tools a little bit. First of all
>it updates test suite: two new tests are added. One test is reworked
>message bound test. Now it is more complex. Instead of sending 1 byte
>messages with one MSG_EOR bit, it sends messages of random length(one
>half of messages are smaller than page size, second half are bigger)
>with random number of MSG_EOR bits set. Receiver also don't know total
>number of messages. Message bounds control is maintained by hash sum
>of messages length calculation. Second test is for SOCK_SEQPACKET - it
>tries to send message with length more than allowed. I think both tests
>will be useful for DGRAM support also.
>
>Third thing that this patchset adds is small utility to test vsock
>performance for both rx and tx. I think this util could be useful as
>'iperf'/'uperf', because:
>1) It is small comparing to 'iperf' or 'uperf', so it very easy to add
>   new mode or feature to it(especially vsock specific).
>2) It allows to set SO_RCVLOWAT and SO_VM_SOCKETS_BUFFER_SIZE option.
>   Whole throughtput depends on both parameters.
>3) It is located in the kernel source tree, so it could be updated by
>   the same patchset which changes related kernel functionality in vsock.
>
>I used this util very often to check performance of my rx zerocopy
>support(this tool has rx zerocopy support, but not in this patchset).
>
>Here is comparison of outputs from three utils: 'iperf', 'uperf' and
>'vsock_perf'. In all three cases sender was at guest side. rx and
>tx buffers were always 64Kb(because by default 'uperf' uses 8K).
>
>iperf:
>
>   [ ID] Interval           Transfer     Bitrate
>   [  5]   0.00-10.00  sec  12.8 GBytes  11.0 Gbits/sec sender
>   [  5]   0.00-10.00  sec  12.8 GBytes  11.0 Gbits/sec receiver
>
>uperf:
>
>   Total     16.27GB /  11.36(s) =    12.30Gb/s       23455op/s
>
>vsock_perf:
>
>   tx performance: 12.301529 Gbits/s
>   rx performance: 12.288011 Gbits/s
>
>Results are almost same in all three cases.

Thanks for checking this!

>
>Patchset was rebased and tested on skbuff v8 patch from Bobby Eshleman:
>https://lore.kernel.org/netdev/20221215043645.3545127-1-bobby.eshleman@bytedance.com/

I reviewed all the patches, in the last one there is just to update the 
README, so I think it is ready for net-next (when it will re-open).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
