Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BCC36403D
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976360; cv=none; b=Dw+aaEauj8NF38vW/YYBd1JgI7Ggcx8FvuhGHXUkyPPRq2hZyAZML8frkDnj+tLlhji/NLozFLR6V4W04/RfE9rxick0CGSsFrY6vkZa0yXSCg2Jyg9Zeh//oW5o6pLMlPjKCKwqRzgZzrlyGltzugzBtVvvS07A7+0JYeQML2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976360; c=relaxed/simple;
	bh=AhO0W3QqPyvRX+DZ7rtuWNPWm1Y+nD8N2kgT7qXsPh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JEFisNJdPtZuOIYtKM6Yg1fguoLUZVmNtvNCQquBOsWswSezMItprzfh6QnDBX3A7pu1BnjqRyPSKIeMKJK+SjeXDC5/t7dAxCe8QIc6wk/uN1MEKVIe6YUls3AfVCT/BJ599D3dnWp4MW8F4eyhxeaFYwhIGeoVR5keWi88+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UenxCe//; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UenxCe//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767976356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEreNKulSbEm1+LE8N+VyJH3RewoJdVfa+9kn/ikLWM=;
	b=UenxCe//1c7fPa3OzQ3G48dlzxO9aoRW4WoPoDk0LIbSzCMslQRsSGm82MFPV6ulwEFg+F
	dJ7zlzE0yd0jE8MLXCriO+TqrSqhblxvGwxLihM1HuihuNxmq22r9rWa6WQfPnHi35aumB
	NWfBxgui+8ClwLW7/IRjJi5k8xUc5xk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-WDMxQJXoO5mwfKvaF4npfw-1; Fri, 09 Jan 2026 11:32:33 -0500
X-MC-Unique: WDMxQJXoO5mwfKvaF4npfw-1
X-Mimecast-MFC-AGG-ID: WDMxQJXoO5mwfKvaF4npfw_1767976352
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6505cbe401aso4789655a12.0
        for <virtualization@lists.linux.dev>; Fri, 09 Jan 2026 08:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976352; x=1768581152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEreNKulSbEm1+LE8N+VyJH3RewoJdVfa+9kn/ikLWM=;
        b=DAJlUH84z5t8OkgaB0wIvO5K/TBHBIVOQzlyVMMTpv8UooZDvpPXxvPRQibJw9OENC
         4Va7WrmHofp27ZACBvPbGd4CvlRmc/FCeyK47N/inaYixxE9B4NPRKymBX15RrRkS/0Q
         LMQ2adnz67ciqDCGrlHbBDRNBpdqjx4VAzB7O5cQmVebFcVJa3Y/Y+h2P2wmzeXcjTHh
         R/HFSZe5Md6j+scvn5mV/WQHHt8HWRaifOC6YoZEwtM0SphFFUMB7sZgNMhzEywoY5pg
         iy5Km7r+MUC8MwmEW5TDcbvc+d4/xcheYO8HKnRI3artNh1Ai4fJtpEhhAFc64knScHB
         JTDw==
X-Forwarded-Encrypted: i=1; AJvYcCV9w9EORNvwGAu/6lKaIocD/Qr2L1nJUHTjdPHQsZLXyzIfwWB1JFAuL2aDGJQKvcEjKB6i+6pg4w6zyQsetg==@lists.linux.dev
X-Gm-Message-State: AOJu0YywnYucH9zBmdMOhYIOOyFWcQXy1dah4iW8I9wsJYQZ4DYlJVPD
	oTBZ0EHVYVJc+HqKM0v6/bqmZqkdTquFa+CyWZkpEhUwcWNJV1Sx6wnz7DvyOOSiMnJsnJUWGJC
	aEqDtLRrAfIxAOnHwny3Pl3rKn96I1NVTrSa9mkJK9XgEVblzw2ixwUYNBZV6zum/5qaL
X-Gm-Gg: AY/fxX4R84cnIfN3gMvOrYPpgC0RCBGYYXzlb2NgXxorOhzjidu6y8gb+Rlvii0zzil
	dRyQZoMCphtG9iTtQXMrMdx5sLYh3u6s7Q7i7YsLcmUWevZzfIxMBwuQojtCcb1U+gmGAJ3kKGv
	NEG6jDkXQi92putarX0CK4FBdB+MIE7Xa7/8iMBKXkGBHWSWucKhYJKcUKXIdStLQmwvVZrRBP2
	IqndwLK7avCdrPooG0H3VJbETvVQZhp45YS4CxAhieDLphLGLx3hgY/R6OCOU7Sid5zW2EppmCq
	qLTjXWnGfhPqcrP1TR94hOJZGoh/S0hldfY3eeY/m2ZeeyZvvHuKP4TgqLO9BLEiTuuWkTqjp4e
	wpyzT8YDUVCKWP6Y=
X-Received: by 2002:a05:6402:5214:b0:649:afbf:ce4c with SMTP id 4fb4d7f45d1cf-65097dd19d0mr10206800a12.3.1767976351964;
        Fri, 09 Jan 2026 08:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh9F6wrxt+tH3YONGJ8MMPHym5YuR5cSOU8k+Xh+56gOqWbHHpSyrYloIioAY7C+cjecCrrw==
X-Received: by 2002:a05:6402:5214:b0:649:afbf:ce4c with SMTP id 4fb4d7f45d1cf-65097dd19d0mr10206768a12.3.1767976351430;
        Fri, 09 Jan 2026 08:32:31 -0800 (PST)
Received: from sgarzare-redhat ([193.207.176.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c0asm10815163a12.9.2026.01.09.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:32:30 -0800 (PST)
Date: Fri, 9 Jan 2026 17:32:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vsock/test: Add test for a linear and non-linear skb
 getting coalesced
Message-ID: <aWEqjjE1vb_t35lQ@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-2-26f97bb9a99b@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260108-vsock-recv-coalescence-v1-2-26f97bb9a99b@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0OzvOkipTcDIvSQ8is7yp0HCeblVKI7KwIc2-178FfQ_1767976352
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 08, 2026 at 10:54:55AM +0100, Michal Luczaj wrote:
>Loopback transport can mangle data in rx queue when a linear skb is
>followed by a small MSG_ZEROCOPY packet.

Can we describe a bit more what the test is doing?

>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c          |  5 +++
> tools/testing/vsock/vsock_test_zerocopy.c | 67 +++++++++++++++++++++++++++++++
> tools/testing/vsock/vsock_test_zerocopy.h |  3 ++
> 3 files changed, 75 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bbe3723babdc..21c8616100f1 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2403,6 +2403,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_accepted_setsockopt_client,
> 		.run_server = test_stream_accepted_setsockopt_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_ZEROCOPY coalescence corruption",

This is essentially a regression test for virtio transport, so I'd add 
virtio in the test name.

>+		.run_client = test_stream_msgzcopy_mangle_client,
>+		.run_server = test_stream_msgzcopy_mangle_server,
>+	},
> 	{},
> };
>
>diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
>index 9d9a6cb9614a..6735a9d7525d 100644
>--- a/tools/testing/vsock/vsock_test_zerocopy.c
>+++ b/tools/testing/vsock/vsock_test_zerocopy.c
>@@ -9,11 +9,13 @@
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <unistd.h>
> #include <poll.h>
> #include <linux/errqueue.h>
> #include <linux/kernel.h>
>+#include <linux/sockios.h>
> #include <errno.h>
>
> #include "control.h"
>@@ -356,3 +358,68 @@ void test_stream_msgzcopy_empty_errq_server(const struct test_opts *opts)
> 	control_expectln("DONE");
> 	close(fd);
> }
>+
>+#define GOOD_COPY_LEN	128	/* net/vmw_vsock/virtio_transport_common.c */

I think we don't need this, I mean we can eventually just send a single 
byte, no?

>+
>+void test_stream_msgzcopy_mangle_client(const struct test_opts *opts)
>+{
>+	char sbuf1[PAGE_SIZE + 1], sbuf2[GOOD_COPY_LEN];
>+	struct pollfd fds;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_zerocopy_check(fd);
>+
>+	memset(sbuf1, '1', sizeof(sbuf1));
>+	memset(sbuf2, '2', sizeof(sbuf2));
>+
>+	send_buf(fd, sbuf1, sizeof(sbuf1), 0, sizeof(sbuf1));
>+	send_buf(fd, sbuf2, sizeof(sbuf2), MSG_ZEROCOPY, sizeof(sbuf2));
>+
>+	fds.fd = fd;
>+	fds.events = 0;
>+
>+	if (poll(&fds, 1, -1) != 1 || !(fds.revents & POLLERR)) {
>+		perror("poll");
>+		exit(EXIT_FAILURE);
>+	}

Should we also call vsock_recv_completion() or we don't care about the 
result?

If we need it, maybe we can factor our the poll + 
vsock_recv_completion().

>+
>+	close(fd);
>+}
>+
>+static void recv_verify(int fd, char *buf, unsigned int len, char pattern)
>+{
>+	recv_buf(fd, buf, len, 0, len);
>+
>+	while (len--) {
>+		if (*buf++ != pattern) {
>+			fprintf(stderr, "Incorrect data received\n");
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+}
>+
>+void test_stream_msgzcopy_mangle_server(const struct test_opts *opts)
>+{
>+	char rbuf[PAGE_SIZE + 1];
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait, don't race the (buggy) skbs coalescence. */
>+	vsock_ioctl_int(fd, SIOCINQ, PAGE_SIZE + 1 + GOOD_COPY_LEN);

This is cool, another option is to add a barrier here (and after the 
poll), but yeah, this should be even better.

Thanks,
Stefano

>+
>+	recv_verify(fd, rbuf, PAGE_SIZE + 1, '1');
>+	recv_verify(fd, rbuf, GOOD_COPY_LEN, '2');
>+
>+	close(fd);
>+}
>diff --git a/tools/testing/vsock/vsock_test_zerocopy.h b/tools/testing/vsock/vsock_test_zerocopy.h
>index 3ef2579e024d..d46c91a69f16 100644
>--- a/tools/testing/vsock/vsock_test_zerocopy.h
>+++ b/tools/testing/vsock/vsock_test_zerocopy.h
>@@ -12,4 +12,7 @@ void test_seqpacket_msgzcopy_server(const struct test_opts *opts);
> void test_stream_msgzcopy_empty_errq_client(const struct test_opts *opts);
> void test_stream_msgzcopy_empty_errq_server(const struct test_opts 
> *opts);
>
>+void test_stream_msgzcopy_mangle_client(const struct test_opts *opts);
>+void test_stream_msgzcopy_mangle_server(const struct test_opts *opts);
>+
> #endif /* VSOCK_TEST_ZEROCOPY_H */
>
>-- 
>2.52.0
>

