Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19B1D86DC
	for <virtualization@lists.linux.dev>; Mon, 28 Oct 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123107; cv=none; b=TphdZmpr4YBpst8na8SxeCQRdNximahZTlkTpRWImg0mHMwpJYfucQ2UCEieQvgJbYooJByUTuPpPa9UDW5CS0aFZCLcf4MmOHvMf8X+7sYmH6xx3hzXxNi+6oIVpsCMX5FQK96rzKYXoW/LXamNQA48LzmUHPbMID7cfnVi1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123107; c=relaxed/simple;
	bh=aEs7wkOs/9Tmtuzmg6k86fkOGprpHMB9+QFgot8mjSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XmEIeuZ4wncfl6XuqBGed0O6V3HdaB9P73mplrWssMUbbslE/tfMATMH65P/jUco7jJ09sjZj7AkgMbtM63g1mJpjEBqRAQR+7LUz3UUA3T3ZnBbGgOPdUM6/o5aIs2VbKwLEwbbEFjoYVYg5Vv15xvrkRZMqrQme77ZWSVDlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8E/nrLd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8E/nrLd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730123104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2vGL1SVZq+LgfXtvaR3j6jeveiqx6XHBU95MSTDGVg4=;
	b=R8E/nrLdNWpdV4zj5A+b01n1WtNxzPvYWT0w8DJxryUSrDHKRCKjRPgoTzTbkUnq678iCs
	RMulzLpsadg7SEfvUt/ODJq19pp7HBxojqi9Q395xdeYs1rxh9ck6i4fKpju95oAjYaSaW
	WJsQTqA7Ukb4ODOmOFXtPKxszaoV1qo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-6e0NEZ0WN6Kt6VFNlIRATA-1; Mon, 28 Oct 2024 09:44:58 -0400
X-MC-Unique: 6e0NEZ0WN6Kt6VFNlIRATA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b15d3cd6dcso823414285a.0
        for <virtualization@lists.linux.dev>; Mon, 28 Oct 2024 06:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123098; x=1730727898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vGL1SVZq+LgfXtvaR3j6jeveiqx6XHBU95MSTDGVg4=;
        b=qHH0qSCFkRuIkQRBV4y8KTb2PoxZqb6oscQRTyPn9I6BiUEB11toDdcNYpRC8vSRMn
         ZJjefQmTRuu17YkjdjKo7mtHbsC7dESzrSpqel/eEZqUlWD7j0kXP8cQvHP7eThvR1dG
         IWYma8Op6u8/7dwGoDlU6E3Nj1jH+IHIDQP6tj6TAH282lNLVUDl+zwToey0nOWaamWD
         dinsQEts8JXs3MwmMamTPuqTyYc9y4N1pOIuo/zVxfjT+HMS9iUwn+on2r/2JEHlXgsh
         5Vf9TPb7BOIFKLfYbrmFnsNPteq7BWmO1cFrGl5hZCB7xc/OhzZ63zVOrhooKimPYs/h
         a8lQ==
X-Gm-Message-State: AOJu0Yz2J8ItXBIx0Y1uP6JvuzMaTsmKAm6Jw0mzuiblH/K+JMMhIPKv
	kmsDHOwVm+oK0Ce3tbkyOi9marDqtaKvhIkrl27kpBLDO6LohHBRm9DTz8njB61EJkVwgKBRlnJ
	Ejf7AfeOS9mld5E33CETqR/MB4dUxqr0ASy9udJwvRKWFO1aMI2kYXYRp5CKrtbS7
X-Received: by 2002:a05:620a:1a1c:b0:7b1:44f1:cb6d with SMTP id af79cd13be357-7b193f3f2d4mr1447474985a.42.1730123097798;
        Mon, 28 Oct 2024 06:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYDCoi09rdBp6AbuPJnFmwQMjbUbwDykG7M6wD0fUANXJfHN4wHVrUUk5Lqyj/Lt6o3xbXOQ==
X-Received: by 2002:a05:620a:1a1c:b0:7b1:44f1:cb6d with SMTP id af79cd13be357-7b193f3f2d4mr1447469985a.42.1730123097245;
        Mon, 28 Oct 2024 06:44:57 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17973d8bdsm32521456d6.18.2024.10.28.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:44:56 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:44:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v3] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <s5mhlz5szowwse52t6u44u3despluqb2ucudmmolx55vmtvs2l@eptqoed2qwmv>
References: <20241025154124.732008-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241025154124.732008-1-kshk@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Oct 25, 2024 at 10:41:24AM -0500, Konstantin Shkolnyy wrote:
>This happens on 64-bit big-endian machines.
>SO_RCVLOWAT requires an int parameter. However, instead of int, the test
>uses unsigned long in one place and size_t in another. Both are 8 bytes
>long on 64-bit machines. The kernel, having received the 8 bytes, doesn't
>test for the exact size of the parameter, it only cares that it's >=
>sizeof(int), and casts the 4 lower-addressed bytes to an int, which, on
>a big-endian machine, contains 0. 0 doesn't trigger an error, SO_RCVLOWAT
>returns with success and the socket stays with the default SO_RCVLOWAT = 1,
>which results in vsock_test failures, while vsock_perf doesn't even notice
>that it's failed to change it.
>
>Fixes: b1346338fbae ("vsock_test: POLLIN + SO_RCVLOWAT test")
>Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
>Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
>
>Notes:
>    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.
>Changes for v3:
>- fix the same problem in vsock_perf and update commit message
>Changes for v2:
>- add "Fixes:" lines to the commit message

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> tools/testing/vsock/vsock_perf.c | 6 +++---
> tools/testing/vsock/vsock_test.c | 4 ++--
> 2 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index 4e8578f815e0..22633c2848cc 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -133,7 +133,7 @@ static float get_gbps(unsigned long bits, time_t ns_delta)
> 	       ((float)ns_delta / NSEC_PER_SEC);
> }
>
>-static void run_receiver(unsigned long rcvlowat_bytes)
>+static void run_receiver(int rcvlowat_bytes)
> {
> 	unsigned int read_cnt;
> 	time_t rx_begin_ns;
>@@ -163,7 +163,7 @@ static void run_receiver(unsigned long rcvlowat_bytes)
> 	printf("Listen port %u\n", port);
> 	printf("RX buffer %lu bytes\n", buf_size_bytes);
> 	printf("vsock buffer %lu bytes\n", vsock_buf_bytes);
>-	printf("SO_RCVLOWAT %lu bytes\n", rcvlowat_bytes);
>+	printf("SO_RCVLOWAT %d bytes\n", rcvlowat_bytes);
>
> 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>
>@@ -439,7 +439,7 @@ static long strtolx(const char *arg)
> int main(int argc, char **argv)
> {
> 	unsigned long to_send_bytes = DEFAULT_TO_SEND_BYTES;
>-	unsigned long rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
>+	int rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
> 	int peer_cid = -1;
> 	bool sender = false;
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f851f8961247..30857dd4ca97 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -833,7 +833,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>
> static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> {
>-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
>+	int lowat_val = RCVLOWAT_BUF_SIZE;
> 	char buf[RCVLOWAT_BUF_SIZE];
> 	struct pollfd fds;
> 	short poll_flags;
>@@ -1282,7 +1282,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
> static void test_stream_credit_update_test(const struct test_opts *opts,
> 					   bool low_rx_bytes_test)
> {
>-	size_t recv_buf_size;
>+	int recv_buf_size;
> 	struct pollfd fds;
> 	size_t buf_size;
> 	void *buf;
>-- 
>2.34.1
>

