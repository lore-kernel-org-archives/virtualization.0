Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387782136F
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxdhiCdX"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BCE41405A0
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 09:16:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCE41405A0
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QxdhiCdX
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eONwqW_3H2Rj
	for <virtualization@lists.linux-foundation.org>;
	Wed, 22 Nov 2023 09:16:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7DE6C40272
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 09:16:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DE6C40272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700644584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvqBK0UZREQjTEFtoe+8dwMEyfkRZhPHhHrOq6zH23k=;
	b=QxdhiCdX+e0UpV1YnY6TtkSow4lX4tk6dqXpuVpQEwF4jiY0B7v8eLSl4uhEIHcCJoHYRJ
	+k04dECEeNXJorWvZDjBhJ4zIBT/ha8l+s8SEJ5D8TMvKi4r2eOMTMr2Giz3zja8kkALPq
	JLDwCzkOhUtgeH+fKnwOjwQLmcz6aWA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-VvdZ2kRNNhGnbdNYV3mEHA-1; Wed, 22 Nov 2023 04:16:22 -0500
X-MC-Unique: VvdZ2kRNNhGnbdNYV3mEHA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5cbab2450c5so24386147b3.3
        for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 01:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700644582; x=1701249382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvqBK0UZREQjTEFtoe+8dwMEyfkRZhPHhHrOq6zH23k=;
        b=oNR3SeLNRKA+0DmAq4NvU9LoKI9AMO6HX5fA68P1TF+bxV0aLsFVud28tukHvrIFJm
         e0+dL2qoyHsKQcBFIeC5wkJmVrrw6kR9BMD0xSn6wx7hvRnmrosQ3OT/ot4JcqMhK6WO
         DGl9nqe146lc0FI2AuL1/8r+EhzShF7hAwuqvrG0dloQVX/35GEvnjXgBb/RXvTqCg1s
         Pon3mNJ0sNLvZHfkrAlbp+YlwUFjoKd4Uuus6zeKrtJfn3UtoCW02OazHxyjkNDVOHIN
         sHuXGSc8gge+C4Z4e/Z9OadWPAHRlxvbS8gGXPEdeDU5zl1zWMW5XETqaZCYekY76A71
         SazQ==
X-Gm-Message-State: AOJu0YwIquqOcD4t11skXuUcVPQocmhqQLw3JnjQCCLV2uVKBCPsV2L5
	H9WQuVIOrOXVNck4+FUVTTaCAvtnEPFRFrIaaaUoF8jjAUuNMOZnGQZyrQiJFoukgg/SvvnG+LR
	C+jggtmEG8+CVQLkQnFyklZgbk+XMT7t8G34xLgl37A==
X-Received: by 2002:a25:e812:0:b0:daf:81e5:d2fa with SMTP id k18-20020a25e812000000b00daf81e5d2famr1645679ybd.33.1700644582098;
        Wed, 22 Nov 2023 01:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgjChf8tYk5WRQhvlQx17JS9JtaEmIgWhz74vAPdVRs7d7DxN/bnfe4x0/ngk4fEhGpNP7Bw==
X-Received: by 2002:a25:e812:0:b0:daf:81e5:d2fa with SMTP id k18-20020a25e812000000b00daf81e5d2famr1645672ybd.33.1700644581817;
        Wed, 22 Nov 2023 01:16:21 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id qd24-20020ad44818000000b0065b21b232bfsm4711765qvb.138.2023.11.22.01.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:16:21 -0800 (PST)
Date: Wed, 22 Nov 2023 10:16:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com, Bogdan Marcynkov <bmarcynk@redhat.com>
Subject: Re: [PATCH net v1] vsock/test: fix SEQPACKET message bounds test
Message-ID: <zoq32fkokk2ygtiabxgf74xu6vkfdynrlfzdqguh67qlogzd7j@qfd57sgudzpw>
References: <20231121211642.163474-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231121211642.163474-1-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 22, 2023 at 12:16:42AM +0300, Arseniy Krasnov wrote:
>Tune message length calculation to make this test work on machines
>where 'getpagesize()' returns >32KB. Now maximum message length is not
>hardcoded (on machines above it was smaller than 'getpagesize()' return
>value, thus we get negative value and test fails), but calculated at
>runtime and always bigger than 'getpagesize()' result. Reproduced on
>aarch64 with 64KB page size.

It was reported to me by Bogdan, so we can add:

Reported-by: Bogdan Marcynkov <bmarcynk@redhat.com>

>
>Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> tools/testing/vsock/vsock_test.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)

The fix LGTM and it worked on aarch64 machine.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks for the fast fix!
Stefano

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f5623b8d76b7..691e44c746bf 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -353,11 +353,12 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> }
>
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
>-#define MAX_MSG_SIZE (32 * 1024)
>+#define MAX_MSG_PAGES 4
>
> static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> {
> 	unsigned long curr_hash;
>+	size_t max_msg_size;
> 	int page_size;
> 	int msg_count;
> 	int fd;
>@@ -373,7 +374,8 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>
> 	curr_hash = 0;
> 	page_size = getpagesize();
>-	msg_count = SOCK_BUF_SIZE / MAX_MSG_SIZE;
>+	max_msg_size = MAX_MSG_PAGES * page_size;
>+	msg_count = SOCK_BUF_SIZE / max_msg_size;
>
> 	for (int i = 0; i < msg_count; i++) {
> 		size_t buf_size;
>@@ -383,7 +385,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> 		/* Use "small" buffers and "big" buffers. */
> 		if (i & 1)
> 			buf_size = page_size +
>-					(rand() % (MAX_MSG_SIZE - page_size));
>+					(rand() % (max_msg_size - page_size));
> 		else
> 			buf_size = 1 + (rand() % page_size);
>
>@@ -429,7 +431,6 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> 	unsigned long remote_hash;
> 	unsigned long curr_hash;
> 	int fd;
>-	char buf[MAX_MSG_SIZE];
> 	struct msghdr msg = {0};
> 	struct iovec iov = {0};
>
>@@ -457,8 +458,13 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> 	control_writeln("SRVREADY");
> 	/* Wait, until peer sends whole data. */
> 	control_expectln("SENDDONE");
>-	iov.iov_base = buf;
>-	iov.iov_len = sizeof(buf);
>+	iov.iov_len = MAX_MSG_PAGES * getpagesize();
>+	iov.iov_base = malloc(iov.iov_len);
>+	if (!iov.iov_base) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
> 	msg.msg_iov = &iov;
> 	msg.msg_iovlen = 1;
>
>@@ -483,6 +489,7 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> 		curr_hash += hash_djb2(msg.msg_iov[0].iov_base, recv_size);
> 	}
>
>+	free(iov.iov_base);
> 	close(fd);
> 	remote_hash = control_readulong();
>
>-- 
>2.25.1
>

