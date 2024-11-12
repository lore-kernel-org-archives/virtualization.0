Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1146520BB44
	for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401448; cv=none; b=R6mIruBq2AU47OKKJWxv5ZL/7JdUzEItg2DXR82MTWDN8DVzkZh4HfgTYUQzsvXCrradPAF1aHaZ+EJPGleyFULGNDe7+iOsxhyru1gyA8Bt8Z6zyk+YPMRb/8y+8YRzy2Y54abgroiG7lkHBYHGjMNTzC3dS20tQe7smkcFOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401448; c=relaxed/simple;
	bh=luoFRSWcfvkfY1Y/zBf3awig2dLMcz5WWZVKScK/OSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lBHflI48oGfxcRKNZRe24Ja3+y52JiOPz/WxpuntWMx3HKY8FdS/P6+3AMwRdYl8DWHMH9w6NtWaW3BQOu4YBYP38Em5ylL6TzA00MNLHQ+ZE/MmBK1IUvB0IzjTW5vssOJQUNZiGJo0JXNQzY9fjktUaqYH5RgRSe+bazdGBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da4yR2Y/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da4yR2Y/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731401444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nXJbGAvBHX1lqtvBc3YXqwLY83vC6FhyFyUNvjUgI8=;
	b=Da4yR2Y/b9LNu6rWfAtFQQWA9RNoV6V+QlThZqNtqZ/eVvS8A5j0eqL1GQkNHf4ew7+B0v
	e+fnTKlsL+q53yrHLnpea+XocUetWl3Z4PLsxu9qPOU1vqRnjbR21GHF1/jBYbTLglSIVN
	Z0yLku2X76fFwHFEkyrQEFAInWtXIVE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-sVUdqXSBO9-BS3O5ZNz-Iw-1; Tue, 12 Nov 2024 03:50:43 -0500
X-MC-Unique: sVUdqXSBO9-BS3O5ZNz-Iw-1
X-Mimecast-MFC-AGG-ID: sVUdqXSBO9-BS3O5ZNz-Iw
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c936f71759so4067848a12.2
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 00:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401442; x=1732006242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nXJbGAvBHX1lqtvBc3YXqwLY83vC6FhyFyUNvjUgI8=;
        b=Kj9o0oeqQefeEWe24vk8RJZaLrW/a/mmuWy2luyCqqH0HWFBYBein2jPWFZVpIBWv0
         4KtnqQ6m97kTO6MyudCAgBWT6cBs5HwJ+1sRMxJ9zoa+CkO2H7yBhdPzle1mdyKVOo6q
         8kgHmCBLqDn9mh/0P7NRMv05uTO/fyrwb69wz00hhjq3qZB/0VJJslSNQwTk2umlT7ME
         FT1P6H3UHNEIX8DkKyJ/NwxiFPBdRIpAsi0kvRLb8AQjflsnj3Ay+vVyKzPTf/7oIdLT
         7X4qTOMJRL1a+QxN2HvtC9mDbqhGpyNTQ26RS0iweLe63m2okfEGAEVRWMA9WYwAR2hk
         HQmA==
X-Gm-Message-State: AOJu0Yzi2JEOjl+/mWemEtWguHrZ0No3qxMJ3jTPkp2O14NHJefOCEBo
	rVda7CbIKvYVwvYlkgUuQZhk1Yw5S5usvtQdAEbmadR8tq3JuC/njvf71519bNCmljtW8AOwN1m
	s+pij8xf4S7wDdjDw/UwjBEIx9rx7gPyUKXJLf+w1W9Tjac5/gq2qtGKlZkV6cSwpGlKR1rXvgn
	w=
X-Received: by 2002:a50:935a:0:b0:5ce:fb4a:6aaf with SMTP id 4fb4d7f45d1cf-5cf0a3247c3mr9930449a12.20.1731401441874;
        Tue, 12 Nov 2024 00:50:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsLia/7hEIlYxDqgzc5l9QRSITxhqmo24fGLrFFIlS4C3vrg9AnfPGQp34D8VxeyfudIbKIA==
X-Received: by 2002:a50:935a:0:b0:5ce:fb4a:6aaf with SMTP id 4fb4d7f45d1cf-5cf0a3247c3mr9930421a12.20.1731401441149;
        Tue, 12 Nov 2024 00:50:41 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d7dasm5806136a12.13.2024.11.12.00.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:50:40 -0800 (PST)
Date: Tue, 12 Nov 2024 09:50:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v5 2/3] vsock/test: fix parameter types in
 SO_VM_SOCKETS_* calls
Message-ID: <vkhtpmsywr5rmahhugqf6vpltrab35cmf5i3j7tlss64tncoxy@kohxvui2dmlc>
References: <20241108011726.213948-1-kshk@linux.ibm.com>
 <20241108011726.213948-3-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241108011726.213948-3-kshk@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OkS2Rb8EO3IsfRJisPsAInHRmhFg0UemN9zSgrVfAnI_1731401442
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 07, 2024 at 07:17:25PM -0600, Konstantin Shkolnyy wrote:
>Change parameters of SO_VM_SOCKETS_* to unsigned long long as documented
>in the vm_sockets.h, because the corresponding kernel code requires them
>to be at least 64-bit, no matter what architecture. Otherwise they are
>too small on 32-bit machines.
>
>Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
>Fixes: 685a21c314a8 ("test/vsock: add big message test")
>Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
>Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
> tools/testing/vsock/vsock_perf.c |  4 ++--
> tools/testing/vsock/vsock_test.c | 22 +++++++++++++++++-----
> 2 files changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index 22633c2848cc..8e0a6c0770d3 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -33,7 +33,7 @@
>
> static unsigned int port = DEFAULT_PORT;
> static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
>-static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
>+static unsigned long long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
> static bool zerocopy;
>
> static void error(const char *s)
>@@ -162,7 +162,7 @@ static void run_receiver(int rcvlowat_bytes)
> 	printf("Run as receiver\n");
> 	printf("Listen port %u\n", port);
> 	printf("RX buffer %lu bytes\n", buf_size_bytes);
>-	printf("vsock buffer %lu bytes\n", vsock_buf_bytes);
>+	printf("vsock buffer %llu bytes\n", vsock_buf_bytes);
> 	printf("SO_RCVLOWAT %d bytes\n", rcvlowat_bytes);
>
> 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 7fd25b814b4b..c7af23332e57 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -429,7 +429,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>
> static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> {
>-	unsigned long sock_buf_size;
>+	unsigned long long sock_buf_size;
> 	unsigned long remote_hash;
> 	unsigned long curr_hash;
> 	int fd;
>@@ -634,7 +634,8 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
>
> static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
> {
>-	unsigned long sock_buf_size;
>+	unsigned long long sock_buf_size;
>+	size_t buf_size;
> 	socklen_t len;
> 	void *data;
> 	int fd;
>@@ -655,13 +656,20 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>
> 	sock_buf_size++;
>
>-	data = malloc(sock_buf_size);
>+	/* size_t can be < unsigned long long */
>+	buf_size = (size_t) sock_buf_size;
>+	if (buf_size != sock_buf_size) {
>+		fprintf(stderr, "Returned BUFFER_SIZE too large\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	data = malloc(buf_size);
> 	if (!data) {
> 		perror("malloc");
> 		exit(EXIT_FAILURE);
> 	}
>
>-	send_buf(fd, data, sock_buf_size, 0, -EMSGSIZE);
>+	send_buf(fd, data, buf_size, 0, -EMSGSIZE);
>
> 	control_writeln("CLISENT");
>
>@@ -1360,6 +1368,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	int recv_buf_size;
> 	struct pollfd fds;
> 	size_t buf_size;
>+	unsigned long long sock_buf_size;
> 	void *buf;
> 	int fd;
>
>@@ -1371,8 +1380,11 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
>
> 	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
>
>+	/* size_t can be < unsigned long long */
>+	sock_buf_size = buf_size;
>+
> 	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>-		       &buf_size, sizeof(buf_size))) {
>+		       &sock_buf_size, sizeof(sock_buf_size))) {
> 		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> 		exit(EXIT_FAILURE);
> 	}
>-- 
>2.34.1
>

