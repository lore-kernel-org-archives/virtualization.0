Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F14CC25B0C
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 11:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A2D940931;
	Mon,  8 Aug 2022 11:14:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A2D940931
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g5INBvX+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCC0OXR1EMOa; Mon,  8 Aug 2022 11:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84E4940121;
	Mon,  8 Aug 2022 11:14:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84E4940121
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DA59C0033;
	Mon,  8 Aug 2022 11:14:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F75C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24FFC40609
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:14:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24FFC40609
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pm8EQxIsTAv9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:14:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54F0C40121
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54F0C40121
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659957265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yY0JFPsIeaqtqI4iFArqAoOxJZBsLvWKUrWCsvYe/Bc=;
 b=g5INBvX+6CvKAqjWw2DupmWSeLQhrfClfnREWRG+f5r64a4dVFAIFqEeJ71jRvItmTqlWz
 6ZI1n/LaDmtHQij4QY0n6vdF46VILNDzhHeAaDasqvJtHMkfbh/va1a+2c2A9gNBgPwG8n
 vQ7HYvUsRJIvtubc2cunhBPo7YpCmr4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-7zUBPSUZNmC8ADP_5q5Mzw-1; Mon, 08 Aug 2022 07:14:24 -0400
X-MC-Unique: 7zUBPSUZNmC8ADP_5q5Mzw-1
Received: by mail-qv1-f69.google.com with SMTP id
 dc13-20020a056214174d00b0047b6f9a1a9aso69406qvb.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 04:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=yY0JFPsIeaqtqI4iFArqAoOxJZBsLvWKUrWCsvYe/Bc=;
 b=6asxDFuwW6A0NIGuCfWLm4vzuF3B5m/APNfWigXuCvSiuaI+SmSjVDfgfZ3fELA4in
 LlZWMWyHko5ladi2Uqppi+0Rq0wydmKgvl+O9k4EqruRxNx7FhHSpl5JhSWb3WRhtbBY
 ngXY19piKYIBhHZNrw7oLDdUt438GBsG+CRyOhPyx82+7bWsYVKG7dU42BYPkBr7nFCs
 uM1hA2XEV6LKVFepJIiZxqh6g3jQ5je0SzzAt5JU3NioWCRTSh9SSq5Gcnly9OoglB3t
 4xsTmq720T6gw7iibyPzjy2+xxLSNCp3EJPoZP5pziCUbzToNnbFW00CTS4441ZWy1q0
 D3mg==
X-Gm-Message-State: ACgBeo2bHvXIXigI4jaHlhSNdn4rLivFvkS0nN0ldIhYVaeMJuLe1abE
 tuCWqcFl/EsmlB5l8fPMnnI9b+ZKiLZIK+HnqjmOHwZz4gYStrvKY8OCAzi9+eh8jUk08YJUBGT
 kYHqGMXzjtr8aIZMrGtOkZxiOlZCgo194Av3oY/DmJg==
X-Received: by 2002:a37:9602:0:b0:6b8:753c:729d with SMTP id
 y2-20020a379602000000b006b8753c729dmr13647138qkd.83.1659957263906; 
 Mon, 08 Aug 2022 04:14:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR639ZIMRG4InAc+BbR2p/NP4CtcHRuLRLUW7+Hgtww1NkwTDOVGrJ0yy9vLlJVxPTxPb1lKOQ==
X-Received: by 2002:a37:9602:0:b0:6b8:753c:729d with SMTP id
 y2-20020a379602000000b006b8753c729dmr13647106qkd.83.1659957263654; 
 Mon, 08 Aug 2022 04:14:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 n1-20020ac86741000000b00342f932c47csm1906952qtp.46.2022.08.08.04.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 04:14:22 -0700 (PDT)
Date: Mon, 8 Aug 2022 13:14:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 9/9] vsock_test: POLLIN + SO_RCVLOWAT test
Message-ID: <20220808111412.iywihoyszvswomlb@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <1f50d595-cd37-ad61-f165-5632162dc682@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <1f50d595-cd37-ad61-f165-5632162dc682@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Wed, Aug 03, 2022 at 02:07:58PM +0000, Arseniy Krasnov wrote:
>This adds test to check,that when poll() returns POLLIN,POLLRDNORM bits,
>next read call won't block.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 107 +++++++++++++++++++++++++++++++
> 1 file changed, 107 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index dc577461afc2..920dc5d5d979 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -18,6 +18,7 @@
> #include <sys/socket.h>
> #include <time.h>
> #include <sys/mman.h>
>+#include <poll.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -596,6 +597,107 @@ static void test_seqpacket_invalid_rec_buffer_server(const struct test_opts *opt
> 	close(fd);
> }
>
>+static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>+{
>+#define RCVLOWAT_BUF_SIZE 128
>+	int fd;
>+	int i;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Send 1 byte. */
>+	send_byte(fd, 1, 0);
>+
>+	control_writeln("SRVSENT");
>+
>+	/* Wait until client is ready to receive rest of data. */
>+	control_expectln("CLNSENT");
>+
>+	for (i = 0; i < RCVLOWAT_BUF_SIZE - 1; i++)
>+		send_byte(fd, 1, 0);
>+
>+	/* Keep socket in active state. */
>+	control_expectln("POLLDONE");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
>+{
>+	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
>+	char buf[RCVLOWAT_BUF_SIZE];
>+	struct pollfd fds;
>+	ssize_t read_res;
>+	short poll_flags;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>+			&lowat_val, sizeof(lowat_val))) {

A small checkpatch warning that you can fix since you have to resend:

CHECK: Alignment should match open parenthesis
#76: FILE: tools/testing/vsock/vsock_test.c:645:
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
+			&lowat_val, sizeof(lowat_val))) {

total: 0 errors, 0 warnings, 1 checks, 125 lines checked

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
