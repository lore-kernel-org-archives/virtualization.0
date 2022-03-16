Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E55BC433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 08:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9829561067;
	Wed, 16 Mar 2022 08:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIYPqCH2TMmN; Wed, 16 Mar 2022 08:51:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2E4A660FDD;
	Wed, 16 Mar 2022 08:51:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2BEEC0012;
	Wed, 16 Mar 2022 08:51:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5993BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4643561062
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:51:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UEEFXVr0BlRP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:51:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CEAD60FDD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647420682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WMlu3K6eKY9U4Sitc08oOJDaydm2FxICxmkEb7WkAjg=;
 b=MX2+1iTrJ17PSfSkT7aTUfMz8DdO5ObOHm0UFGlgG7KxRmhLXqyQyw7ShcyBHw1M1h0+BJ
 dRZjVXmfQDFQkGuiuUaN1BcMPrqcW32JUA/xMAlXfG60waRkz7tW5cSTcPnVKCTY+inyor
 qMs6t/+XuyK8pDEcdw7zIsXYNrDqa3U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-eNxckouVMWS9qdRJf1kx3w-1; Wed, 16 Mar 2022 04:51:21 -0400
X-MC-Unique: eNxckouVMWS9qdRJf1kx3w-1
Received: by mail-qk1-f199.google.com with SMTP id
 q24-20020a05620a0c9800b0060d5d0b7a90so1071959qki.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 01:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WMlu3K6eKY9U4Sitc08oOJDaydm2FxICxmkEb7WkAjg=;
 b=0MIU6KP2efQASCPhjXq3UU9AIJ3RjEPQwdFx9fr1wXW6ZaVx3xjXJvFPGOSRn+GBxi
 6Wn86DVFuB9XFl9B53FBsPf5GMT+w5H4/jx2V6xIB73oGMvoIuDOno5GEaaPVk/S4rsa
 3nziE5JhXjch/rzcOPEcpm6AzP9KRbbqc+SB1Db8kwpcult1kM7pQnXrrxkSBZJFTsx8
 5k0XHc8s8bELVdh6zvT1JdQqVPt9FQF7yKPrmD0yq5zMIlg0l94ENghnxVh5ZwTTZiNn
 5wllXtI/Ui+nKoC1yzISMMXujDP2qf0ZwbKMJtIiqnOVEloAx9UTZkSgO+kVHRkf8b42
 21lg==
X-Gm-Message-State: AOAM533a2NQHoslqcpXDuHNheYD3YDjwdbhHYMfulLfgHmX8R1u04bH+
 PEK3ln8PLKrM10bvw8I1PSx8YSmFg8xsnlMmlHdEJaqu+NLmgx2EsVmoSOkoHDGkLAjs/xYKFed
 w9NkSMMbQhZRU7bbp6HQbOfka9bfffM4dFeYCo+FIvw==
X-Received: by 2002:a05:622a:13c7:b0:2de:6f6e:2fe7 with SMTP id
 p7-20020a05622a13c700b002de6f6e2fe7mr25263103qtk.198.1647420680815; 
 Wed, 16 Mar 2022 01:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuAi0JfY/QXj6XW5ZULZlBNrdNUKgIdO1Q5oMPbc2+3FSG4vHPDg4XW/kGbXoPQVPYst4s7Q==
X-Received: by 2002:a05:622a:13c7:b0:2de:6f6e:2fe7 with SMTP id
 p7-20020a05622a13c700b002de6f6e2fe7mr25263088qtk.198.1647420680549; 
 Wed, 16 Mar 2022 01:51:20 -0700 (PDT)
Received: from sgarzare-redhat (host-212-171-187-184.retail.telecomitalia.it.
 [212.171.187.184]) by smtp.gmail.com with ESMTPSA id
 bm1-20020a05620a198100b0047bf910892bsm641043qkb.65.2022.03.16.01.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 01:51:19 -0700 (PDT)
Date: Wed, 16 Mar 2022 09:51:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 1/2] af_vsock: SOCK_SEQPACKET receive timeout test
Message-ID: <20220316085113.jlkj7cflzg77akmm@sgarzare-redhat>
References: <1474b149-7d4c-27b2-7e5c-ef00a718db76@sberdevices.ru>
 <2bc15104-37e6-088a-1699-dc27d0e2dadf@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <2bc15104-37e6-088a-1699-dc27d0e2dadf@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
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

On Wed, Mar 16, 2022 at 07:27:45AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Test for receive timeout check: connection is established,
>receiver sets timeout, but sender does nothing. Receiver's
>'read()' call must return EAGAIN.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> v1 -> v2:
> 1) Check amount of time spent in 'read()'.

The patch looks correct to me, but since it's an RFC and you have to 
send another version anyway, here are some minor suggestions :-)

>
> tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++
> 1 file changed, 79 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 2a3638c0a008..6d7648cce5aa 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -16,6 +16,7 @@
> #include <linux/kernel.h>
> #include <sys/types.h>
> #include <sys/socket.h>
>+#include <time.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -391,6 +392,79 @@ static void test_seqpacket_msg_trunc_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static time_t current_nsec(void)
>+{
>+	struct timespec ts;
>+
>+	if (clock_gettime(CLOCK_REALTIME, &ts)) {
>+		perror("clock_gettime(3) failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	return (ts.tv_sec * 1000000000ULL) + ts.tv_nsec;
>+}
>+
>+#define RCVTIMEO_TIMEOUT_SEC 1
>+#define READ_OVERHEAD_NSEC 250000000 /* 0.25 sec */
>+
>+static void test_seqpacket_timeout_client(const struct test_opts *opts)
>+{
>+	int fd;
>+	struct timeval tv;
>+	char dummy;
>+	time_t read_enter_ns;
>+	time_t read_overhead_ns;
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
>+	tv.tv_usec = 0;
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
>+		perror("setsockopt 'SO_RCVTIMEO'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	read_enter_ns = current_nsec();
>+
>+	if ((read(fd, &dummy, sizeof(dummy)) != -1) ||
>+	    (errno != EAGAIN)) {

Here we can split in 2 checks like in patch 2, since if read() return 
value is >= 0, errno is not set.

>+		perror("EAGAIN expected");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	read_overhead_ns = current_nsec() - read_enter_ns -
>+			1000000000ULL * RCVTIMEO_TIMEOUT_SEC;
>+
>+	if (read_overhead_ns > READ_OVERHEAD_NSEC) {
>+		fprintf(stderr,
>+			"too much time in read(2) with SO_RCVTIMEO: %lu ns\n",
>+			read_overhead_ns);

What about printing also the expected overhead?

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("WAITDONE");
>+	close(fd);
>+}
>+
>+static void test_seqpacket_timeout_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("WAITDONE");
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -431,6 +505,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_msg_trunc_client,
> 		.run_server = test_seqpacket_msg_trunc_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET timeout",
>+		.run_client = test_seqpacket_timeout_client,
>+		.run_server = test_seqpacket_timeout_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
