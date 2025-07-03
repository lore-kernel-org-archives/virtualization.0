Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20415291C3C
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528279; cv=none; b=sUy01T9gQK+p/cuNpzkk+kQhtFO1szGYkM+b1NzsAqfwnETxZvIVQC358Ax5trs7hQN2bMhYEvwVOigo1x5lMt20Vpm6fREhfJZjFJ4d4SSD1ZFOJ4cgg5rfE3/NcCBTwFfvF6J4xp+QAroF6F4xG/364aWwdQvdkQJg6SEpwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528279; c=relaxed/simple;
	bh=StvLRgHy/q4MiDD/Ld5bixXQfpbBBkt3bw8PICCm5Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LP18ENT4GSGg3354z5RkvG+Nro+1hM+EQo/N1vWTNCQvuifoFLut9fRlIvm2Bg3fFp2GjfpLOHZFeec0HiVDv4nCD8VGXJ9e5QNIKLiJF9LB6BTVGoEEgG+TXINFUCY+peBG+i5UwOEDeEn4rbewe3MOvJV8vqn19lorMeGC7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbQA1CA6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbQA1CA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751528277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZTrVaT8ExVLM/STBg1Lk/y2I9eHgVWaLY1rsqDq9sg=;
	b=TbQA1CA6EGgfvjv9vKajAHKRcyqsoVo1BE3vrYkig3PP70V0A11ODITBwn1LTFg3ALM/Or
	v/1ql3EZptchjEPAOzc0SQQ/r0xJ9rGwIhWPODpiCf7sVa64mDZ5QFs4YgfFY8hZEIXqDA
	kW553E3TYkmWzlRS+0C9S74SxykNGc0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-QCLR1vBENvyyDbjbyMLOdA-1; Thu, 03 Jul 2025 03:37:55 -0400
X-MC-Unique: QCLR1vBENvyyDbjbyMLOdA-1
X-Mimecast-MFC-AGG-ID: QCLR1vBENvyyDbjbyMLOdA_1751528274
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so29569155e9.1
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 00:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751528274; x=1752133074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZTrVaT8ExVLM/STBg1Lk/y2I9eHgVWaLY1rsqDq9sg=;
        b=J5TqAbNwEi+B4EuKK6Htc8ULdMgBnKLrEweYVJnUxCLfYi8GKF5sihy3P1IOjKrGn+
         kXzqZYhNtQnOyBvBlHBos0mFXSn1t+y5/I/RKUHMCvWUZdArsgiWzalH0uYUInPW2Q4E
         yUkpWEjfE5WQvJJ/oFRr8+U/pU/Cj9iVXqwJ2bG+bpZnU1hNCpbbOI8KEHCgJLzEz0Hf
         yjur4PXMube8V+WBCC+mkDb5mIpkk9uomGoIa6NPZHiWV5qOqNVlGEbV2FY6lWRqz9Ud
         H3JzXhGhYQbMULIbgfgfPE7RFFMhAxXwtAdphhjtfiXuMCmS7bXu1RceTmeX0Br8ulCG
         j8uw==
X-Forwarded-Encrypted: i=1; AJvYcCVggUdAiOLHiqYr4J7D6en1UMqHHpjjdd9E3XxkqmIwPaisKs3/AdWeRmw4MeM7NEmxYg6IHbszbIIv4DP+Ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuHuAmOxPoDqUgYwIY11x52QbZjWGwM0fsXVu6NMu2FJxs87/3
	HrdNj9nskVWk/0Jqn0rPOEUG51Hk5fHbQUNOaduWbU+D8yGCqQaIPXwB3zan7AbeOCjlg+4FKG5
	mN0qAZ6JGU9spTJS3qrH0+/yOH+oXy5Svfw8DZvznkH8UxyE5bIm6S0+xF0oS7h6fcasL
X-Gm-Gg: ASbGncuCY8/1tz9Lb2hoE5khcB3YDiSUYNMlyaL8mn2CRxcodKRY4i7EJBlkh/z0HOx
	sQHGktEpbfHhybfZ2SduQ41C5BkZkid2zeQWR9Y0pvIc/IBjTChMsocaX9yvY4QdBiRkSBxGnPu
	Cww/3R2m+FyS8VQcINHTvUXouVfhQ3xmMkREU24lASVjrhR0M0+7rL+BlseHUdBwnFtzK270JQb
	m51UBPTy+yU/CYXIlhggnDuSYPjQ2JTfugP2dQ66Ywo3pR4eOGI1GilN+AUXI2DJ0O2UpPcTJjN
	iIeGlAvWJNHKXRrBn+EE7fdMD0w=
X-Received: by 2002:a05:600c:4e90:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-454a373b017mr56578685e9.33.1751528274003;
        Thu, 03 Jul 2025 00:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsDaSQWiaSZmXwr5L45BCRF7nAnAPxMzvbScBf83o6qhxxyDbo0YcmqHWPrAZw9H/yhOS6hg==
X-Received: by 2002:a05:600c:4e90:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-454a373b017mr56578155e9.33.1751528273226;
        Thu, 03 Jul 2025 00:37:53 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99a35f9sm18458115e9.27.2025.07.03.00.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 00:37:52 -0700 (PDT)
Date: Thu, 3 Jul 2025 09:37:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, decui@microsoft.com, fupan.lfp@antgroup.com, 
	jasowang@redhat.com, kvm@vger.kernel.org, leonardi@redhat.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [RESEND PATCH net-next v4 4/4] test/vsock: Add ioctl SIOCINQ
 tests
Message-ID: <7cnmlbupia4urmb2ikyomhaayppqgfddmb7u3umgz62jnzcy2p@x6dsvkhfnqze>
References: <qe45fgoj32f4lyfpqvor2iyse6rdzhhkji7g5snnyqw4wuxa7s@mu4eghcet6sn>
 <20250703025156.844532-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250703025156.844532-1-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sqSAhwuGKYJZArKsiLonRR2FNgWY-gwOrcUb-ADCw_4_1751528274
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 03, 2025 at 10:51:56AM +0800, Xuewei Niu wrote:
>Resend: forgot to reply all...
>
>> On Mon, Jun 30, 2025 at 03:57:27PM +0800, Xuewei Niu wrote:
>> >Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.
>> >
>> >The client waits for the server to send data, and checks if the SIOCINQ
>> >ioctl value matches the data size. After consuming the data, the client
>> >checks if the SIOCINQ value is 0.
>> >
>> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>> >---
>> > tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
>> > 1 file changed, 80 insertions(+)
>> >
>> >diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> >index f669baaa0dca..1f525a7e0098 100644
>> >--- a/tools/testing/vsock/vsock_test.c
>> >+++ b/tools/testing/vsock/vsock_test.c
>> >@@ -1305,6 +1305,56 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
>> > 	close(fd);
>> > }
>> >
>> >+static void test_unread_bytes_server(const struct test_opts *opts, int type)
>> >+{
>> >+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>> >+	int client_fd;
>> >+
>> >+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
>> >+	if (client_fd < 0) {
>> >+		perror("accept");
>> >+		exit(EXIT_FAILURE);
>> >+	}
>> >+
>> >+	for (int i = 0; i < sizeof(buf); i++)
>> >+		buf[i] = rand() & 0xFF;
>> >+
>> >+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>> >+	control_writeln("SENT");
>> >+
>> >+	close(client_fd);
>> >+}
>> >+
>> >+static void test_unread_bytes_client(const struct test_opts *opts, int type)
>> >+{
>> >+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>> >+	int fd;
>> >+	int sock_bytes_unread;
>> >+
>> >+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
>> >+	if (fd < 0) {
>> >+		perror("connect");
>> >+		exit(EXIT_FAILURE);
>> >+	}
>> >+
>> >+	control_expectln("SENT");
>> >+	/* The data has arrived but has not been read. The expected is
>> >+	 * MSG_BUF_IOCTL_LEN.
>> >+	 */
>> >+	if (!vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread,
>>
>> I know that TIOCINQ is the same of SIOCINQ, but IMO is confusing, why
>> not using SIOCINQ ?
>
>I tried to use `SIOCINQ` but got:
>
>```
>vsock_test.c: In function 'test_unread_bytes_client':
>vsock_test.c:1344:34: error: 'SIOCINQ' undeclared (first use in this function); did you mean 'TIOCINQ'?
> 1344 |         if (!vsock_ioctl_int(fd, SIOCINQ, &sock_bytes_unread,
>      |                                  ^~~~~~~
>      |                                  TIOCINQ
>vsock_test.c:1344:34: note: each undeclared identifier is reported only once for each function it appears in
>```
>
>I just followed the compiler suggestion, and replaced it with `TIOCINQ`.
>Following your comments, I found that `SIOCINQ` is defined in `linux/sockios.h`, as documented in [1].
>The documentation suggests that we can use `FIONREAD` alternatively.
>In order to avoid confusion, I'd like to choose `SIOCINQ`.

Yep, I'd also use SIOCINQ.

Thanks,
Stefano

>
>1: https://man7.org/linux/man-pages/man7/unix.7.html
>
>Thanks,
>Xuewei
>
>> The rest LGTM.
>>
>> Thanks,
>> Stefano
>>
>> >+			     MSG_BUF_IOCTL_LEN)) {
>> >+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
>> >+		goto out;
>> >+	}
>> >+
>> >+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>> >+	/* All data has been consumed, so the expected is 0. */
>> >+	vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
>> >+
>> >+out:
>> >+	close(fd);
>> >+}
>> >+
>> > static void test_stream_unsent_bytes_client(const struct test_opts *opts)
>> > {
>> > 	test_unsent_bytes_client(opts, SOCK_STREAM);
>> >@@ -1325,6 +1375,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
>> > 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
>> > }
>> >
>> >+static void test_stream_unread_bytes_client(const struct test_opts *opts)
>> >+{
>> >+	test_unread_bytes_client(opts, SOCK_STREAM);
>> >+}
>> >+
>> >+static void test_stream_unread_bytes_server(const struct test_opts *opts)
>> >+{
>> >+	test_unread_bytes_server(opts, SOCK_STREAM);
>> >+}
>> >+
>> >+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
>> >+{
>> >+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
>> >+}
>> >+
>> >+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
>> >+{
>> >+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
>> >+}
>> >+
>> > #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
>> > /* This define is the same as in 'include/linux/virtio_vsock.h':
>> >  * it is used to decide when to send credit update message during
>> >@@ -2051,6 +2121,16 @@ static struct test_case test_cases[] = {
>> > 		.run_client = test_stream_nolinger_client,
>> > 		.run_server = test_stream_nolinger_server,
>> > 	},
>> >+	{
>> >+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
>> >+		.run_client = test_stream_unread_bytes_client,
>> >+		.run_server = test_stream_unread_bytes_server,
>> >+	},
>> >+	{
>> >+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
>> >+		.run_client = test_seqpacket_unread_bytes_client,
>> >+		.run_server = test_seqpacket_unread_bytes_server,
>> >+	},
>> > 	{},
>> > };
>> >
>> >--
>> >2.34.1
>> >
>

