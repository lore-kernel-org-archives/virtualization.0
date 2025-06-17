Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF02EB5C6
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173687; cv=none; b=VWiw7egXLGcEkLmynRIAVlMs8PsFP4ZrMttFcXt+iJDT3ll/7nzWyQM6inlHKYAdCy56Y1kGzgzu+tqvLdsnY3OyvSpJSax2Fq23dUcSfpMfz0GFjEn5vMEUHRamUqUdLPGCJzCDoPfW+iwmHsk6pdwbthxbi2zdaxsHMwRXNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173687; c=relaxed/simple;
	bh=D7Sm7Z8o9wrG2DILp1d81NcnEtOVz1w8yhboj0jyHxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DeoqMLX2vBncy72m4z166OtsfW6pnhVGBcZAsxBXofaXOBFCYdGF643bnoqX3rRIRYREd3gO6F1QfkoVsSiNahmVcm9nA2OItrO9dPPDMEqFy76Nt22tRVa5W28HnJbhkM/2XY5skI4rL14RsOAPnnk16zT7DQSEZ+48fhs925M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZrobwjA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZrobwjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750173684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6CNZp4Yl2H/9Cdj6XouU0nprVFIEoQUBC+80peSkJR8=;
	b=ZZrobwjAWAPCtHLGu6diheYMtWyVh3NZBR9BWpnxeMykGzFpr0iyRpXZkftWGlrxIvnKiE
	72sYIZahYAxEW28eh5pRS+5CHEWORalaacnhX6dDdoJqnf5fWkLhvXMImetWHGscbn3f4Q
	WAP4cvZHDbbL1LkBuUIK4Bsb90CGpkU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-PUqyI1s3PVWD_Rw1aEeOyA-1; Tue, 17 Jun 2025 11:21:22 -0400
X-MC-Unique: PUqyI1s3PVWD_Rw1aEeOyA-1
X-Mimecast-MFC-AGG-ID: PUqyI1s3PVWD_Rw1aEeOyA_1750173681
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4535011d48eso12276155e9.3
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 08:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750173681; x=1750778481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CNZp4Yl2H/9Cdj6XouU0nprVFIEoQUBC+80peSkJR8=;
        b=hQp2bAM7DD14GolGCTBTJ55AX2zrTnDGo8G3VBcK6kNYtTaDCD5BxoDnHJkBJEB1b+
         JtkS4XqxtCbyOggZwCK3yKG/BWmay9Ja8H/QWIRC+RTl2HDKje/wKGu7N6Ey+wzPPwns
         Ncz73WddOc4EDwdWdCatWFb/+uEOrGu5YXhQ7KH8NTH6ap8ZOLEfw7tG5A1Xxna04kVC
         V4MM/GyHgLEmyF6Qkl3d4QCShvyk4R+4zmtDfccMLj1AVNqai7Gnkdecjhq9uweyu3SS
         7bo90VxH07GLwh7D2IOlbBY3L6+8HgCba96Eo+bkZ0Rcf+HJFPEtX2VgqV58lSqFqt5b
         8VLw==
X-Forwarded-Encrypted: i=1; AJvYcCUg/XEFfTBtxUM63Jb5nmyDZVZVU5Itn8ln4igbbmo/RDTG3kAfgYndMXiWQXWqYZAvdJRtvGiVBZy1U/JY2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZlE8IxcyUV3J28Z2cH0WNVzkLW1v1Rqv87d3vWjX1vcjEnON6
	KzHX7RR7MBUHlhdqFUEeRg54P/6c6G11M6cSLEHvW/sM2twe2CNqmnlPHQJHq20ynOOu+zQv89r
	CT/hJefnzFsaMyntKK/Mh4+VVzNK4p7UbC2k9XPnZKyt6FivlYML6N3he84ho9ZWv0XNO
X-Gm-Gg: ASbGncs59bYzph+XDsaFMfCkGoW/YrLJom/TQNDN/1i1HhOFsYl7q8U90EvGus9DzCK
	2zVUeyRWYUU7CwaIsNgu2hWJcCoAxa/X86b8EC/tlzq5jVkRPcsgkg2cKWsWyZynTNQroDFA2dg
	wvYUK6TjEp5/aWWDYrws2dadcfWR9LiQv/ynhHuW+8DN4nnl+EB7F0mBeE34mXrcty5svEWLwwp
	ucqORloqUKOdinQiC9fhjme6idyFCVK5lilQHdaCT5XlC8xOhy9JXhwke/bqjLhq1Btv0D03bKW
	vrif+pQFVhHEIgVgt3UyaIMEoK7k
X-Received: by 2002:a05:600c:1e02:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-4533c9dbbfemr141095155e9.0.1750173681394;
        Tue, 17 Jun 2025 08:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOqu3b57WklFuqqnAtvsRHZ0LJvT+ZbOW6XRYMLwqjSK0FduBdtkCovgyUALJLzqgQ/aP+vg==
X-Received: by 2002:a05:600c:1e02:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-4533c9dbbfemr141094715e9.0.1750173680915;
        Tue, 17 Jun 2025 08:21:20 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e195768sm180099565e9.0.2025.06.17.08.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:21:20 -0700 (PDT)
Date: Tue, 17 Jun 2025 17:21:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v3 3/3] test/vsock: Add ioctl SIOCINQ tests
Message-ID: <fnznqsbg56rfk7szjcprpo4mxy7e4patmj2u5yxbtj33dlj34w@7t5xylskewa5>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
 <20250617045347.1233128-4-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250617045347.1233128-4-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wVWgDXby4B4cSiHqnFsQTEc4PvsTkbhGPg8S2U8l_qc_1750173681
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jun 17, 2025 at 12:53:46PM +0800, Xuewei Niu wrote:
>Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.
>
>The client waits for the server to send data, and checks if the SIOCINQ
>ioctl value matches the data size. After consuming the data, the client
>checks if the SIOCINQ value is 0.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/vsock_test.c | 82 ++++++++++++++++++++++++++++++++
> 1 file changed, 82 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f669baaa0dca..66bb9fde7eca 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1305,6 +1305,58 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> 	close(fd);
> }
>
>+static void test_unread_bytes_server(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int client_fd;
>+
>+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
>+	if (client_fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (int i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_writeln("SENT");
>+	control_expectln("RECEIVED");
>+
>+	close(client_fd);
>+}
>+
>+static void test_unread_bytes_client(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int ret, fd;
>+	int sock_bytes_unread;
>+
>+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SENT");
>+	/* The data has arrived but has not been read. The expected is
>+	 * MSG_BUF_IOCTL_LEN.
>+	 */
>+	ret = ioctl_int(fd, TIOCINQ, &sock_bytes_unread, MSG_BUF_IOCTL_LEN);
>+	if (ret) {

Since we are returning a value !=0 only if EOPNOTSUPP, I think we can 
just return a bool when the ioctl is supported or not, like for 
vsock_wait_sent().

>+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
>+		goto out;
>+	}
>+
>+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	// All date has been consumed, so the expected is 0.

s/date/data

Please follow the style of the file (/* */ for comments)

>+	ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
>+	control_writeln("RECEIVED");

Why we need this control barrier here?

Thanks,
Stefano

>+
>+out:
>+	close(fd);
>+}
>+
> static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> {
> 	test_unsent_bytes_client(opts, SOCK_STREAM);
>@@ -1325,6 +1377,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
> 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
> }
>
>+static void test_stream_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_STREAM);
>+}
>+
>+static void test_stream_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_STREAM);
>+}
>+
>+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
>+}
>+
>+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
>+}
>+
> #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> /* This define is the same as in 'include/linux/virtio_vsock.h':
>  * it is used to decide when to send credit update message during
>@@ -2051,6 +2123,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_nolinger_client,
> 		.run_server = test_stream_nolinger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
>+		.run_client = test_stream_unread_bytes_client,
>+		.run_server = test_stream_unread_bytes_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
>+		.run_client = test_seqpacket_unread_bytes_client,
>+		.run_server = test_seqpacket_unread_bytes_server,
>+	},
> 	{},
> };
>
>-- 
>2.34.1
>

