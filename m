Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F02C54EBC
	for <virtualization@archiver.kernel.org>; Thu, 12 Jan 2023 11:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7999E60BD3;
	Thu, 12 Jan 2023 11:53:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7999E60BD3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KX5wLBYV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9kfyC1m-C5Wb; Thu, 12 Jan 2023 11:53:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01B7260B8B;
	Thu, 12 Jan 2023 11:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01B7260B8B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8F83C0033;
	Thu, 12 Jan 2023 11:53:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0C1AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 11:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7818640522
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 11:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7818640522
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KX5wLBYV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jr0axXkPjMhk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 11:53:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1A114014D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1A114014D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673524396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyJSmAogOeE+1RjDXK5+T0HTt5s0oNcRZLZKfpmWmn0=;
 b=KX5wLBYVHPl3B9ASnd+Ncw7AG1NlpPqD/tfNEJUjsFtivaxNfJohKSz4z6lVxe5G1NVJwa
 zemlmXQmWrW0CTDjPvyNsUqTlB/r4pPnflITDR7g4DfFBwzE9gZcY+bJQRMH1us420epH+
 eHR39g1NDeMopn1P5u8fCyqbKl+cIaU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-yZEKNkMUOHG3e_6jpIRFww-1; Thu, 12 Jan 2023 06:53:15 -0500
X-MC-Unique: yZEKNkMUOHG3e_6jpIRFww-1
Received: by mail-wm1-f69.google.com with SMTP id
 m38-20020a05600c3b2600b003d23f8c6ebdso2727562wms.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 03:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lyJSmAogOeE+1RjDXK5+T0HTt5s0oNcRZLZKfpmWmn0=;
 b=Yzt8eP2aUPvA6ojNPybRxdgZPq6bIHHJYFnkDQnmK8v4J5zswYqFoE+EhbBK+iGomO
 Vy+DZcCSY83odBMeFWToEBwcEQ3Ldsk3fj9aFpqP3GGp+wPDXSYv0627Re2idWf3D0cg
 xKSFEhFpAQoaeGmLK1TlmUSYkCg39a1+a2fZc+68gHWK6aSWcGd8tO/3N0FRuQeHhQPK
 Q7dLTiuLXvvq2ZpvgHQy91BJqKFflEXPw4rvoclEF+dp1jkPYdLUJ/wtf8McEuo0Jpg3
 yQP5w/k2cQ6LSVA/6WBEKSHltWg0dqvtBqUN3brAJu4MBBsMxqK/+a23zKH7r6ScIy2U
 o+rg==
X-Gm-Message-State: AFqh2koVYY1JItmzHNwZOXtaUzXkQe1vlkzspayTv3iQoRBjqN1vFTUD
 TzGi27IxXzStWuUy5bnKUFUktrpnOC5iyQdOZ2nwcCEaoC5Ij1RPflqCkcS8smn+pUPMTFJEK67
 M+CmxfCeAeirRf6P50lVOm4oZ+UZWRDPt2W45QdMD8Q==
X-Received: by 2002:a05:600c:3509:b0:3c6:e60f:3f6f with SMTP id
 h9-20020a05600c350900b003c6e60f3f6fmr54279419wmq.38.1673524394394; 
 Thu, 12 Jan 2023 03:53:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv1gWBXnztIeY5tQuHUJyJiOwiORB6jFEhumLrrLcD/6LIUNVgj0usCCc1/aMThJhAKnz2ybA==
X-Received: by 2002:a05:600c:3509:b0:3c6:e60f:3f6f with SMTP id
 h9-20020a05600c350900b003c6e60f3f6fmr54279395wmq.38.1673524394071; 
 Thu, 12 Jan 2023 03:53:14 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-183.dyn.eolo.it.
 [146.241.113.183]) by smtp.gmail.com with ESMTPSA id
 l36-20020a05600c1d2400b003d9fb59c16fsm9261122wms.11.2023.01.12.03.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jan 2023 03:53:13 -0800 (PST)
Message-ID: <455b49a98c98edb1512ba2365adc76ac78a2b71b.camel@redhat.com>
Subject: Re: [PATCH net-next v7 4/4] test/vsock: vsock_perf utility
From: Paolo Abeni <pabeni@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 "edumazet@google.com"
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Date: Thu, 12 Jan 2023 12:53:12 +0100
In-Reply-To: <0a9464eb-ad31-426b-1f30-c19d77281308@sberdevices.ru>
References: <0a9464eb-ad31-426b-1f30-c19d77281308@sberdevices.ru>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>
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

On Tue, 2023-01-10 at 10:18 +0000, Arseniy Krasnov wrote:
> This adds utility to check vsock rx/tx performance.
> 
> Usage as sender:
> ./vsock_perf --sender <cid> --port <port> --bytes <bytes to send>
> Usage as receiver:
> ./vsock_perf --port <port> --rcvlowat <SO_RCVLOWAT>
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  tools/testing/vsock/Makefile     |   3 +-
>  tools/testing/vsock/README       |  34 +++
>  tools/testing/vsock/vsock_perf.c | 427 +++++++++++++++++++++++++++++++
>  3 files changed, 463 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/vsock/vsock_perf.c
> 
> diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
> index f8293c6910c9..43a254f0e14d 100644
> --- a/tools/testing/vsock/Makefile
> +++ b/tools/testing/vsock/Makefile
> @@ -1,8 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -all: test
> +all: test vsock_perf
>  test: vsock_test vsock_diag_test
>  vsock_test: vsock_test.o timeout.o control.o util.o
>  vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
> +vsock_perf: vsock_perf.o
>  
>  CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
>  .PHONY: all test clean
> diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
> index 4d5045e7d2c3..84ee217ba8ee 100644
> --- a/tools/testing/vsock/README
> +++ b/tools/testing/vsock/README
> @@ -35,3 +35,37 @@ Invoke test binaries in both directions as follows:
>                         --control-port=$GUEST_IP \
>                         --control-port=1234 \
>                         --peer-cid=3
> +
> +vsock_perf utility
> +-------------------
> +'vsock_perf' is a simple tool to measure vsock performance. It works in
> +sender/receiver modes: sender connect to peer at the specified port and
> +starts data transmission to the receiver. After data processing is done,
> +it prints several metrics(see below).
> +
> +Usage:
> +# run as sender
> +# connect to CID 2, port 1234, send 1G of data, tx buf size is 1M
> +./vsock_perf --sender 2 --port 1234 --bytes 1G --buf-size 1M
> +
> +Output:
> +tx performance: A Gbits/s
> +
> +Output explanation:
> +A is calculated as "number of bits to send" / "time in tx loop"
> +
> +# run as receiver
> +# listen port 1234, rx buf size is 1M, socket buf size is 1G, SO_RCVLOWAT is 64K
> +./vsock_perf --port 1234 --buf-size 1M --vsk-size 1G --rcvlowat 64K
> +
> +Output:
> +rx performance: A Gbits/s
> +total in 'read()': B sec
> +POLLIN wakeups: C
> +average in 'read()': D ns
> +
> +Output explanation:
> +A is calculated as "number of received bits" / "time in rx loop".
> +B is time, spent in 'read()' system call(excluding 'poll()')
> +C is number of 'poll()' wake ups with POLLIN bit set.
> +D is B / C, e.g. average amount of time, spent in single 'read()'.
> diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
> new file mode 100644
> index 000000000000..a72520338f84
> --- /dev/null
> +++ b/tools/testing/vsock/vsock_perf.c
> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vsock_perf - benchmark utility for vsock.
> + *
> + * Copyright (C) 2022 SberDevices.
> + *
> + * Author: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> + */
> +#include <getopt.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <time.h>
> +#include <stdint.h>
> +#include <poll.h>
> +#include <sys/socket.h>
> +#include <linux/vm_sockets.h>
> +
> +#define DEFAULT_BUF_SIZE_BYTES	(128 * 1024)
> +#define DEFAULT_TO_SEND_BYTES	(64 * 1024)
> +#define DEFAULT_VSOCK_BUF_BYTES (256 * 1024)
> +#define DEFAULT_RCVLOWAT_BYTES	1
> +#define DEFAULT_PORT		1234
> +
> +#define BYTES_PER_GB		(1024 * 1024 * 1024ULL)
> +#define NSEC_PER_SEC		(1000000000ULL)
> +
> +static unsigned int port = DEFAULT_PORT;
> +static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
> +static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
> +
> +static void error(const char *s)
> +{
> +	perror(s);
> +	exit(EXIT_FAILURE);
> +}

For the records, I suggested to use the existing error() libcall, see
man 3 error.

Not a big deal. This can be merged as-is, and you can follow-up, it you
find it useful.

Cheers,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
