Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE554723
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511137; cv=none; b=ZGj1x/rEMvaYaMy6D1RYTFm/tH4M2bIMtrglt++sWaw/2NiyQtWmfYEurOqeVbDt/zJm/uGh9r1w7/rNp7xtNgFdr1Pnt6xvRlv7IEMsZLLBlshCbcg+ZejA/qN0qLUYN/ZvUazsxoRXowjABHWo/fbrZph4uo2xc2SbzerBQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511137; c=relaxed/simple;
	bh=tGikjumrTmudqXSLn2oIbcGO+dakZooSKitvvlYxbFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7KB59EuVhq8dymFHW3EG5AqOSG/gRGJvmWNYEHE+cvXBwQD1olHRGleHVPtp55wfHJvOgv04hsstf5uT12sU0InwfnxjbhcV7bK3yb2kCEl7dgVCRr9NuVgIwRSGekx395OhsBN6jZmhu4HkarlQjsZgHPqoW8y/RK1FXcgHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls+sxAR9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls+sxAR9"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af6a315b491so4859375a12.1
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 19:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751511135; x=1752115935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lo9px2O8dxCxStsMAy6k8t9n1UAlivRa8eyuw8Vbn2g=;
        b=ls+sxAR9X9eqW1BEguaS2Bgzk3VlTMJPoH63BZ9YFzQWvrvSKeUGovqiO71522ewud
         vj2CYvgR1Wnn3xn0LHKRRMWY/ZBlmc8qJIXgyf9XY4q2Q6ccEBVwemQ2+bkWX4wdWyOg
         6S1Zqg8O1r2k8CuX2mf9NBFhhbWAHZSyAJtyOIieKpN8rRvjn+mSjmaROmA/ySTgRsyE
         apf4ivuxtL6avcZQ+/GRjBxml+Hjb7l8fJK3s644kIoNCvbT/cHa9B0ShonZTk09mx9q
         dr6MchH0/arEqWmvctvHnyYWbVcQD3Jw1q9IJSrvd70vAvqKnYBnqbboWAhpwxFPrlwn
         ivoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751511135; x=1752115935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lo9px2O8dxCxStsMAy6k8t9n1UAlivRa8eyuw8Vbn2g=;
        b=EVoG62GjLyHnKu9eyhnn749OsujBz/C18YxrYkKuzUE/TPugxmn5EoO55YhyL9mm/q
         nPGt/eGW2ooK4vKQYN+w1ZljYA6b19nM5e9gsQgrWb0QlJtOj5QZKspBVq/2waAKqQGq
         tlXbT4a/g9Kk70qWNeZ2ZqvoRl+gAxuDK6d37BJ48SzOFTTVmHosd0Dt1LjlkNiab6Bl
         MniutQW/Zy+ZSsDDGc3UJZX0YlDPzP4w/+P/DHj9h5ezqcyD14ZQBTGILetBEOlXRU8s
         n67AT738Dov+yMjyPcUOArma408swXf0YeKWxhRmjPOe0tGAQPEeIbizn52q1Z7aMdTn
         WV9g==
X-Forwarded-Encrypted: i=1; AJvYcCXmqcymJcox9Pqc4LhZuBSDdskWbH/lPEt5Y6zXUfrvXu7sqY/AhhcaCihxRDzGiZcT4+/oO43Gd5OqXz1AdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlG/rkvlfuDN/9/BKiRw+22wDUHOJt4xC0br9h+kJ0GxiyVKjL
	gAoqAEBmADYaUQMKoCNdqeNh9PILz2GLsy4tjvXyV7KLHJP3dDKBg+CB
X-Gm-Gg: ASbGncu1Y89+daXDpPQnQpej7MBU9Gbs9khYWZL44DW4idvA+EGrvZQYyUD00ODwusd
	tebMWoS8VTsQNNYSxHGd7CKYEHQYri/uz4C5mT3BN4ty0NoWJ6eAzTQ/mpvNDZZsiBmxJ6y4f23
	UC2L/0+X03AO6FQQFN6awPUKbQT44sHb/Ijvu7v4KjJ53WdKRIb6wkPwraAWMLZehMKuAsDdOso
	tacwBDKBvVwLmHtBAoi5fm9VJmLbIr47IfHGuQJPdWqueACUWcc/i5G1YVBiPzEr0oFxMJFM8Bl
	EgASkO+suXppRnkTysO8lvtVi3xPlKEJ1FExyXxFqEw5mOCjbwzCARuPvAedV5//Id0KfBv3byH
	6Zv7hfbfH
X-Google-Smtp-Source: AGHT+IGzteSmePiYOjnty3CvF79a8fsJyFKLo1CJyDiGjPDyKnKRc/syqMP+iX0JDQKDqfuzEdxWrA==
X-Received: by 2002:a17:90b:28cb:b0:313:f83a:e473 with SMTP id 98e67ed59e1d1-31a9d5ebad2mr2484943a91.15.1751511134907;
        Wed, 02 Jul 2025 19:52:14 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc8ffb5sm949110a91.46.2025.07.02.19.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 19:52:14 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	decui@microsoft.com,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	leonardi@redhat.com,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RESEND PATCH net-next v4 4/4] test/vsock: Add ioctl SIOCINQ tests
Date: Thu,  3 Jul 2025 10:51:56 +0800
Message-Id: <20250703025156.844532-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <qe45fgoj32f4lyfpqvor2iyse6rdzhhkji7g5snnyqw4wuxa7s@mu4eghcet6sn>
References: <qe45fgoj32f4lyfpqvor2iyse6rdzhhkji7g5snnyqw4wuxa7s@mu4eghcet6sn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend: forgot to reply all...

> On Mon, Jun 30, 2025 at 03:57:27PM +0800, Xuewei Niu wrote:
> >Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.
> >
> >The client waits for the server to send data, and checks if the SIOCINQ
> >ioctl value matches the data size. After consuming the data, the client
> >checks if the SIOCINQ value is 0.
> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >---
> > tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
> > 1 file changed, 80 insertions(+)
> >
> >diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> >index f669baaa0dca..1f525a7e0098 100644
> >--- a/tools/testing/vsock/vsock_test.c
> >+++ b/tools/testing/vsock/vsock_test.c
> >@@ -1305,6 +1305,56 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> > 	close(fd);
> > }
> >
> >+static void test_unread_bytes_server(const struct test_opts *opts, int type)
> >+{
> >+	unsigned char buf[MSG_BUF_IOCTL_LEN];
> >+	int client_fd;
> >+
> >+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
> >+	if (client_fd < 0) {
> >+		perror("accept");
> >+		exit(EXIT_FAILURE);
> >+	}
> >+
> >+	for (int i = 0; i < sizeof(buf); i++)
> >+		buf[i] = rand() & 0xFF;
> >+
> >+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
> >+	control_writeln("SENT");
> >+
> >+	close(client_fd);
> >+}
> >+
> >+static void test_unread_bytes_client(const struct test_opts *opts, int type)
> >+{
> >+	unsigned char buf[MSG_BUF_IOCTL_LEN];
> >+	int fd;
> >+	int sock_bytes_unread;
> >+
> >+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
> >+	if (fd < 0) {
> >+		perror("connect");
> >+		exit(EXIT_FAILURE);
> >+	}
> >+
> >+	control_expectln("SENT");
> >+	/* The data has arrived but has not been read. The expected is
> >+	 * MSG_BUF_IOCTL_LEN.
> >+	 */
> >+	if (!vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread,
> 
> I know that TIOCINQ is the same of SIOCINQ, but IMO is confusing, why 
> not using SIOCINQ ?

I tried to use `SIOCINQ` but got:

```
vsock_test.c: In function 'test_unread_bytes_client':
vsock_test.c:1344:34: error: 'SIOCINQ' undeclared (first use in this function); did you mean 'TIOCINQ'?
 1344 |         if (!vsock_ioctl_int(fd, SIOCINQ, &sock_bytes_unread,
      |                                  ^~~~~~~
      |                                  TIOCINQ
vsock_test.c:1344:34: note: each undeclared identifier is reported only once for each function it appears in
```

I just followed the compiler suggestion, and replaced it with `TIOCINQ`.
Following your comments, I found that `SIOCINQ` is defined in `linux/sockios.h`, as documented in [1].
The documentation suggests that we can use `FIONREAD` alternatively.
In order to avoid confusion, I'd like to choose `SIOCINQ`.

1: https://man7.org/linux/man-pages/man7/unix.7.html

Thanks,
Xuewei
 
> The rest LGTM.
> 
> Thanks,
> Stefano
> 
> >+			     MSG_BUF_IOCTL_LEN)) {
> >+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
> >+		goto out;
> >+	}
> >+
> >+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> >+	/* All data has been consumed, so the expected is 0. */
> >+	vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
> >+
> >+out:
> >+	close(fd);
> >+}
> >+
> > static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> > {
> > 	test_unsent_bytes_client(opts, SOCK_STREAM);
> >@@ -1325,6 +1375,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
> > 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
> > }
> >
> >+static void test_stream_unread_bytes_client(const struct test_opts *opts)
> >+{
> >+	test_unread_bytes_client(opts, SOCK_STREAM);
> >+}
> >+
> >+static void test_stream_unread_bytes_server(const struct test_opts *opts)
> >+{
> >+	test_unread_bytes_server(opts, SOCK_STREAM);
> >+}
> >+
> >+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
> >+{
> >+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
> >+}
> >+
> >+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
> >+{
> >+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
> >+}
> >+
> > #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> > /* This define is the same as in 'include/linux/virtio_vsock.h':
> >  * it is used to decide when to send credit update message during
> >@@ -2051,6 +2121,16 @@ static struct test_case test_cases[] = {
> > 		.run_client = test_stream_nolinger_client,
> > 		.run_server = test_stream_nolinger_server,
> > 	},
> >+	{
> >+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
> >+		.run_client = test_stream_unread_bytes_client,
> >+		.run_server = test_stream_unread_bytes_server,
> >+	},
> >+	{
> >+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
> >+		.run_client = test_seqpacket_unread_bytes_client,
> >+		.run_server = test_seqpacket_unread_bytes_server,
> >+	},
> > 	{},
> > };
> >
> >-- 
> >2.34.1
> >
