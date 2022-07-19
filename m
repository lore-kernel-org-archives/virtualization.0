Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A13C43334
	for <virtualization@archiver.kernel.org>; Tue, 19 Jul 2022 12:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EEF1408EC;
	Tue, 19 Jul 2022 12:52:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6EEF1408EC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XTtaSh18
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M5vWjoqrfrCQ; Tue, 19 Jul 2022 12:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B73284086B;
	Tue, 19 Jul 2022 12:52:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B73284086B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A349C0033;
	Tue, 19 Jul 2022 12:52:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D816C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDF3160ACF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:52:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDF3160ACF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XTtaSh18
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zYVVb6cxgA4V
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:52:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2608060737
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2608060737
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658235161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYVq4WjdOQMHhc5px4YCUTqr6DUNRdDOEbVtXRDK/f8=;
 b=XTtaSh18bcXqskSvJx3fwmASYm6emq7D5u9hUo2krpgX18m2KjP2bdC9xQqSYt1WqiLbFf
 memkcAQkBJmaiRe18vD75HbkaNEKa2q4/KK+gT+VJPOc6Bzy2ebvy6edBjIJL6YN8yu0TM
 n/+AklEPdXu4LwFJkhO5eKFw7xMTrUg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-fU8UVfXDN9y6sMk3cyJQsw-1; Tue, 19 Jul 2022 08:52:37 -0400
X-MC-Unique: fU8UVfXDN9y6sMk3cyJQsw-1
Received: by mail-qv1-f70.google.com with SMTP id
 oo28-20020a056214451c00b004732e817c96so7389540qvb.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 05:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TYVq4WjdOQMHhc5px4YCUTqr6DUNRdDOEbVtXRDK/f8=;
 b=M+mFHMJLd6HAd93dnLLZKljYypNwoklGvFZTS64hcN14f6bz9BBcn5UavE/RXuHnth
 7xZAeQOtkM048RZZ96SglJKAtvcAudVYRQr1WnRKzQYKM+U7gO5awqMoRhzHGjgn7sjb
 rMpYbJ8HOndUzpBIBxQ+KOKgT5DYT/3tobjTWL68eRfrPDI8jl6Yvt20HwrGEwSThEae
 e2IbR91qK0yeNyK+oWS5iXi8JXGZOrXoE2DdqZyEaNAnR5+fi7xT9ArXR0tU0ZFnAHbn
 G/EWBsqx4YnDQTcwCsAPI/olqLZZagdOUkvsmbaOt+4D1YUwfeGhqUYRukvnE5c4YpD9
 DCiw==
X-Gm-Message-State: AJIora8Eo56dSO7rE/EFwZ+QTqb730I+YeyHrzOCiPsMlHtVqYrv4uBX
 GzwI8hyXgVYks28s1zVaVyzMSwPPkKvG/1QHahSJkGgAueNR9PhCmdPBguK+ZZU+ZC6ass8M1dK
 vuBVIQf9A8Z36+LogQd8behCAh0I2XJ0XpSg4J2XBhA==
X-Received: by 2002:a37:614:0:b0:6b5:cda7:694b with SMTP id
 20-20020a370614000000b006b5cda7694bmr13081909qkg.532.1658235157517; 
 Tue, 19 Jul 2022 05:52:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u9pkG+DbLrrLN376mRVwAbaPHBtJQ48OByRq4neWnlpWQY9teeIXv+aG4MfOrc28E2dEFUWw==
X-Received: by 2002:a37:614:0:b0:6b5:cda7:694b with SMTP id
 20-20020a370614000000b006b5cda7694bmr13081889qkg.532.1658235157281; 
 Tue, 19 Jul 2022 05:52:37 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 c26-20020a05620a269a00b006b5ba7b9a6fsm13373178qkp.35.2022.07.19.05.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 05:52:36 -0700 (PDT)
Date: Tue, 19 Jul 2022 14:52:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 3/3] vsock_test: POLLIN + SO_RCVLOWAT test.
Message-ID: <20220719125227.bktosg3yboeaeoo5@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <df70a274-4e69-ca1f-acba-126eb517e532@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <df70a274-4e69-ca1f-acba-126eb517e532@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel <kernel@sberdevices.ru>,
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

On Mon, Jul 18, 2022 at 08:19:06AM +0000, Arseniy Krasnov wrote:
>This adds test to check, that when poll() returns POLLIN and
>POLLRDNORM bits, next read call won't block.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 90 ++++++++++++++++++++++++++++++++
> 1 file changed, 90 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index dc577461afc2..8e394443eaf6 100644
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
>@@ -596,6 +597,90 @@ static void test_seqpacket_invalid_rec_buffer_server(const struct test_opts *opt
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
>+	/* Just empirically delay value. */
>+	sleep(4);

Why we need this sleep()?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
