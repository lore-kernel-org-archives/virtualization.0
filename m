Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845D1C54EBE
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 09:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0011B40A45;
	Tue, 10 Jan 2023 09:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0011B40A45
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bp8NhIqf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K0DqUldOA-O0; Tue, 10 Jan 2023 09:37:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2ED5B400A6;
	Tue, 10 Jan 2023 09:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ED5B400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05683C0033;
	Tue, 10 Jan 2023 09:37:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50D61C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 09:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AE0B60F98
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 09:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AE0B60F98
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bp8NhIqf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hwt5_fqh9A_r
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 09:37:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33C8F60F9F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 33C8F60F9F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673343424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3IoltaMTP/SoP1SsfQmBngAKvER3lkKce2svsoNj6DA=;
 b=Bp8NhIqfz73pT/03p684KQt+KC+aY27Q22aj9Kp/HwC5/rgz23R4FeHFlceznSYCapLiFY
 Zn+ljdRmJgwezJ2QzlIkIaGUEKeDZ+S2HMIjuwegt9HNcAOuZpitU0pbXUr8tkVV0CWUty
 8fp7sIGEBM4f8sKl2VHapyiqVNAznYc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-mJ57QxNTO8Sk60KgymzwLw-1; Tue, 10 Jan 2023 04:37:02 -0500
X-MC-Unique: mJ57QxNTO8Sk60KgymzwLw-1
Received: by mail-qv1-f69.google.com with SMTP id
 jh2-20020a0562141fc200b004c74bbb0affso6651755qvb.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 01:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3IoltaMTP/SoP1SsfQmBngAKvER3lkKce2svsoNj6DA=;
 b=EtONUuItzRWBqw2q94Y2yafj2mlwTwoLDTa7OR2c8e7SAolmrWKxWnvrMCGIHcY9eC
 eYk6eXevXzVW6bObdkQ3s+h9dh2x17z5L3/NZ9pvYIVQCz+s+LScyWCBMj9w/3flFBJQ
 HgJrBS0KI0xYR92RkPTjPRriFCw2/uXSPCjMT/MrwiCzi0Fe73ZBge99tj3CpHow8Dl3
 EdvjYbCiFtyI2mqUtWn5fYT3fnCLZB1TWdMuFOWFEFhC/Pil/UdvrvwDadF3qzBH57Y4
 qkrJs4Pp0tNx72dJTpPierktj7ZPB7fHsv0fPcmVt+dlh3kkI2jDqNFVEcZvpi0ivnin
 weKw==
X-Gm-Message-State: AFqh2krwE9yeB/wNHFok5FPUPuYFizvCEsKLA2fdZCIlqd2kFRo3fJE8
 BqVpRK/Tg/vrhr4cNMYhnfVVmlWTIxOsswHkG6OiyYZyrSWn4HS5ocJ8vth1rLISGPxoZ90Z/jC
 n9RKvUOgJE7QGyHLcKiKWc6SG7r9CP2v3PIJa+HeN2w==
X-Received: by 2002:ac8:541a:0:b0:3a7:e809:1fe3 with SMTP id
 b26-20020ac8541a000000b003a7e8091fe3mr93226484qtq.49.1673343421731; 
 Tue, 10 Jan 2023 01:37:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsR1BdhvAmGlOEi2PUL/5w7kE1LT1nDkO0+hG84MErLiDislP8Se/e0fBns75Zu9jlSfYhxjg==
X-Received: by 2002:ac8:541a:0:b0:3a7:e809:1fe3 with SMTP id
 b26-20020ac8541a000000b003a7e8091fe3mr93226466qtq.49.1673343421423; 
 Tue, 10 Jan 2023 01:37:01 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-128.dyn.eolo.it.
 [146.241.120.128]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8668d000000b003a6a4744432sm5830178qtp.87.2023.01.10.01.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jan 2023 01:37:00 -0800 (PST)
Message-ID: <5c8b538bcc9ac75027f41c21e810d3707a2e1ec7.camel@redhat.com>
Subject: Re: [PATCH net-next v6 4/4] test/vsock: vsock_perf utility
From: Paolo Abeni <pabeni@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 "edumazet@google.com"
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Date: Tue, 10 Jan 2023 10:36:58 +0100
In-Reply-To: <eaf9598f-27eb-8df0-1dea-b4c5623adba1@sberdevices.ru>
References: <eaf9598f-27eb-8df0-1dea-b4c5623adba1@sberdevices.ru>
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

Hi,

sorry for the late feedback, a couple of notes below...

On Sun, 2023-01-08 at 20:43 +0000, Arseniy Krasnov wrote:
> This adds utility to check vsock rx/tx performance.
> 
> Usage as sender:
> ./vsock_perf --sender <cid> --port <port> --bytes <bytes to send>
> Usage as receiver:
> ./vsock_perf --port <port> --rcvlowat <SO_RCVLOWAT>
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/Makefile     |   3 +-
>  tools/testing/vsock/README       |  34 +++
>  tools/testing/vsock/vsock_perf.c | 441 +++++++++++++++++++++++++++++++
>  3 files changed, 477 insertions(+), 1 deletion(-)
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
> index 000000000000..ccd595462b40
> --- /dev/null
> +++ b/tools/testing/vsock/vsock_perf.c
> @@ -0,0 +1,441 @@
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
> +static inline time_t current_nsec(void)

Minor nit: you should avoid 'static inline' functions in c files,
'static' would suffice and will allow the compiler to do a better job.

> +{
> +	struct timespec ts;
> +
> +	if (clock_gettime(CLOCK_REALTIME, &ts)) {
> +		perror("clock_gettime");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	return (ts.tv_sec * NSEC_PER_SEC) + ts.tv_nsec;
> +}
> +
> +/* From lib/cmdline.c. */
> +static unsigned long memparse(const char *ptr)
> +{
> +	char *endptr;
> +
> +	unsigned long long ret = strtoull(ptr, &endptr, 0);
> +
> +	switch (*endptr) {
> +	case 'E':
> +	case 'e':
> +		ret <<= 10;
> +	case 'P':
> +	case 'p':
> +		ret <<= 10;
> +	case 'T':
> +	case 't':
> +		ret <<= 10;
> +	case 'G':
> +	case 'g':
> +		ret <<= 10;
> +	case 'M':
> +	case 'm':
> +		ret <<= 10;
> +	case 'K':
> +	case 'k':
> +		ret <<= 10;
> +		endptr++;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void vsock_increase_buf_size(int fd)
> +{
> +	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
> +		       &vsock_buf_bytes, sizeof(vsock_buf_bytes))) {
> +		perror("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> +		       &vsock_buf_bytes, sizeof(vsock_buf_bytes))) {
> +		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> +		exit(EXIT_FAILURE);

You use the above pattern frequently, but you could replace both
libcall with a single error() call.

Thanks,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
