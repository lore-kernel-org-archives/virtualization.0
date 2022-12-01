Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A53C43217
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 09:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E138A40C45;
	Thu,  1 Dec 2022 09:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E138A40C45
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ef+3veNn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n-52_bVajELu; Thu,  1 Dec 2022 09:46:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F01440393;
	Thu,  1 Dec 2022 09:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F01440393
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52403C0032;
	Thu,  1 Dec 2022 09:46:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFDDFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B51C84185B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B51C84185B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ef+3veNn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rDq-j_iNujrm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:45:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B20E141858
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B20E141858
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669887956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0jFiCUY0VXNcy859wsO8NBTioywcuSZZtPBsENMWnSA=;
 b=Ef+3veNnnylOe0CXr1djbs6ZINvFCuH4CxtbVhiLjc6xNOPemiOh+/AyMghx30kZGJ8X6n
 R1qTe69f+eYbuFQQtdHiv7yPnT29NiF6/HjJMCOPiCBVwT3XTJl9nZByJoY3RWLQVcH7Mu
 a8ytjrHLRWWQo2Agf+e8bm3u2XTI/Sg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-FJbUaM89MTWxT7Xi1CTiGA-1; Thu, 01 Dec 2022 04:45:55 -0500
X-MC-Unique: FJbUaM89MTWxT7Xi1CTiGA-1
Received: by mail-wr1-f69.google.com with SMTP id
 e19-20020adfa453000000b0024209415034so239971wra.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 01:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jFiCUY0VXNcy859wsO8NBTioywcuSZZtPBsENMWnSA=;
 b=0Sf75vPpf8kPcVEpzHHftLH0Er9qEZY3lSbfCXz4ZhRkMeNn26Ry7iVMgIEAUwKQxz
 4cUt6n3upKKicSsfTUY/Hh9eB3NgwqldHjLyjzS+tA59wUO6iLEWWBWHblJ7Kd1L7N0C
 ud9Sz/drsXNsNe4oRSPNXfxy3PPHvXdJQ2+fxqy6TvYYlV0HtNiiHgBQqs7tKQUroC+i
 rh+OLoeEVpliJEkg1J/0i4il0uqU+7+TlAT8nDMDYJSnFMPiC1T+lMHFYNWIoLBorc/l
 M3mbPc/0qPubew7rLlpnRpVn72uoYM9VhPYhVdXdfp7lmRpRjRnauok/yXdzKRdQSvfc
 vp9Q==
X-Gm-Message-State: ANoB5pn7iM51SceWh2j6XuuYTZnAEk5DyLgYpArIyXo3whsAVRbcAN1r
 JJGBrcZIDPuDa1TkWUKmj1H/YZXFFK7f2M9UJm5XitsqkgfsuS9UIiySdhW2qg3UaqV/Rvr17VV
 8P2zjQGk+d4CrLOpGWWIMRGSYOgIr6YjG5r1kDnAT3Q==
X-Received: by 2002:a5d:5709:0:b0:241:d71c:5dde with SMTP id
 a9-20020a5d5709000000b00241d71c5ddemr32282794wrv.678.1669887954216; 
 Thu, 01 Dec 2022 01:45:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5nW23nrN+fFkGvbidJKQkIpQeOg7U4YOPGmwbwBTJo0vjWdvoPfPZAVrz0Zpx4X0wkQ8bdVg==
X-Received: by 2002:a5d:5709:0:b0:241:d71c:5dde with SMTP id
 a9-20020a5d5709000000b00241d71c5ddemr32282770wrv.678.1669887953965; 
 Thu, 01 Dec 2022 01:45:53 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 jb17-20020a05600c54f100b003d070272f25sm4660834wmb.8.2022.12.01.01.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 01:45:53 -0800 (PST)
Date: Thu, 1 Dec 2022 10:45:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 5/6] test/vsock: add big message test
Message-ID: <20221201094541.gj7zthelbeqhsp63@sgarzare-redhat>
References: <9d96f6c6-1d4f-8197-b3bc-8957124c8933@sberdevices.ru>
 <2634ad7f-b462-5c69-8aa1-2f200a6beb20@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <2634ad7f-b462-5c69-8aa1-2f200a6beb20@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Bobby Eshleman <bobby.eshleman@gmail.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
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

On Fri, Nov 25, 2022 at 05:13:06PM +0000, Arseniy Krasnov wrote:
>This adds test for sending message, bigger than peer's buffer size.
>For SOCK_SEQPACKET socket it must fail, as this type of socket has
>message size limit.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 69 ++++++++++++++++++++++++++++++++
> 1 file changed, 69 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 12ef0cca6f93..a8e43424fb32 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -569,6 +569,70 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>+{
>+	unsigned long sock_buf_size;
>+	ssize_t send_size;
>+	socklen_t len;
>+	void *data;
>+	int fd;
>+
>+	len = sizeof(sock_buf_size);
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (getsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       &sock_buf_size, &len)) {
>+		perror("getsockopt");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	sock_buf_size++;
>+
>+	data = malloc(sock_buf_size);
>+	if (!data) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	send_size = send(fd, data, sock_buf_size, 0);
>+	if (send_size != -1) {
>+		fprintf(stderr, "expected 'send(2)' failure, got %zi\n",
>+			send_size);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (errno != EMSGSIZE) {
>+		fprintf(stderr, "expected EMSGSIZE in 'errno', got %i\n",
>+			errno);
>+		exit(EXIT_FAILURE);
>+	}

We should make sure that this is true for all transports, but since now 
only virtio-vsock supports it, we should be okay.

>+
>+	control_writeln("CLISENT");
>+
>+	free(data);
>+	close(fd);
>+}
>+
>+static void test_seqpacket_bigmsg_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("CLISENT");
>+
>+	close(fd);
>+}
>+
> #define BUF_PATTERN_1 'a'
> #define BUF_PATTERN_2 'b'
>
>@@ -851,6 +915,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_poll_rcvlowat_client,
> 		.run_server = test_stream_poll_rcvlowat_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET big message",
>+		.run_client = test_seqpacket_bigmsg_client,
>+		.run_server = test_seqpacket_bigmsg_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
