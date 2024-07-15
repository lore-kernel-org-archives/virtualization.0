Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6101BF58
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059418; cv=none; b=aPKvfnmgY/0IVD6VZV6y1u9v5TiF2/yiXoKN1DQhXBn6xE91QTSt4nmm8GJW9l5zwVqCUlhFr3QsVOpmWIvEXohJgru1Cyrdqluf469SKlMHKyp0BG/4mG997S92NR/6b4NhKsQbxKeD/haMUFzf1DM/eOzta5vqGlrHDzkCwzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059418; c=relaxed/simple;
	bh=WwiRujX6MAUUmyIavp+bDMga5jpJYalx8NnaDKPs2nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NyMaDDu+Ux4cDjnyHHXqEdhyiKFvUGJM7a7K1CEBrCrQHWrrUKSD2JPx6S17/bt0pMvJ6QbwGam5dKxrmnX3Hi+62tKutneoj7hLCTaO0tr6RvPYL63FWjbp62oAtwN+O9xJrwshBI51bioPioMiPNx2Tsen5Tdeif4X3CjGMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zgq/i6MO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zgq/i6MO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721059415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQzTHcvy7rIISWd9N5iznAkcIpExB4iFhwW9JO+9a68=;
	b=Zgq/i6MO1O0gecPUvaiNYUHCXez95KEcVXwAxd0NuedK1KJ2B/79dipCyA9VDsT86ik3C5
	5qctf0z6SpLRDxpi/UNSmUWMp5v3X/K7ru5TbVyC5R8WcuM+aMWmSgcLMSNDNyrLOL3t76
	WxJgP8xGE9FdPwUc8D8Z+jXob5eSubY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-mk80n8BPMDqyrB533IoQcw-1; Mon, 15 Jul 2024 12:03:33 -0400
X-MC-Unique: mk80n8BPMDqyrB533IoQcw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42666ed2d5fso29511585e9.3
        for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 09:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721059412; x=1721664212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQzTHcvy7rIISWd9N5iznAkcIpExB4iFhwW9JO+9a68=;
        b=jQQq1XkFWeL/q/qkpWsppXcNbbzuHCMnpz3ZnvJ1VRKTpuhxdnu4ZuLFvez8xYiFkI
         zT94duXUIzw+uO8c7zNaL96fJgycCbbF23zhOjtqaobUNWjukXYcViFZgTTsDnV4Dev1
         yPKJA5DLZpUc854e1E31n5E9chmYxKBrsZ2V8nfQs1mmir4+O9OylVsd5KdoC3crLojU
         CAyWFa7zrBju00GWJT1heWO+wQ6w7CKQrOavJFkSdFev0+ZsYj0dMvsxobWrHDlHE7tA
         eJ/t5sVtgqKMgwXzPRWMk7zmVUIySr488dJf7EUQoCrPcpytq+U58eFS/pywB16jdRYq
         T1nw==
X-Forwarded-Encrypted: i=1; AJvYcCVmSY6Aj3FK3QufnzP9lDqrweojaR8lsokgx8CwqZRtpcTWCg9oNrqihyQ7cknViZVMdpGBFtWCrFsc813tA8fc4pSUJTidaOVAbT8QSMY=
X-Gm-Message-State: AOJu0YwLv5jENjivE/uUJH/ktH9I1KnFTXlRH4XT/bF+UpY5aHdfuhg9
	iVPoTeZn8h7lCFzwegl2adv6hv1sIHgA+hk1A/YlEtztc8aEK7RgAOa0XpOTK836VTc4Q1ceemf
	0TWQfbYpl9EUr9GuoMqISx8UAgAZcUy+v5SYP3ncBqZysjDfilM3MIFCCoRBvnu2P
X-Received: by 2002:a05:600c:310d:b0:426:629f:1556 with SMTP id 5b1f17b1804b1-427b88c2e8amr511455e9.31.1721059412653;
        Mon, 15 Jul 2024 09:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESdfYLQweNPfY1VGrdhD01jrKdhhF0qNRqfcsooulYbUS6vFKHA5l4BVKwugm9LlCeEvW1uA==
X-Received: by 2002:a05:600c:310d:b0:426:629f:1556 with SMTP id 5b1f17b1804b1-427b88c2e8amr511205e9.31.1721059412069;
        Mon, 15 Jul 2024 09:03:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f276c52sm127451465e9.22.2024.07.15.09.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:03:31 -0700 (PDT)
Date: Mon, 15 Jul 2024 18:03:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] test/vsock: add ioctl unsent bytes test
Message-ID: <5wa2u2eolzxqz2gxeoccazimd4ixpycgkv27cfdmjcpsn3ew2e@drkemucyuvda>
References: <20240626-ioctl_next-v3-0-63be5bf19a40@outlook.com>
 <20240626-ioctl_next-v3-3-63be5bf19a40@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240626-ioctl_next-v3-3-63be5bf19a40@outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 26, 2024 at 02:08:37PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Luigi Leonardi <luigi.leonardi@outlook.com>
>
>Introduce two tests, one for SOCK_STREAM and one for SOCK_SEQPACKET, which checks
>after a packet is delivered, that the number of unsent bytes is zero,
>using ioctl SIOCOUTQ.
>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> tools/testing/vsock/util.c       |  6 +--
> tools/testing/vsock/util.h       |  3 ++
> tools/testing/vsock/vsock_test.c | 85 ++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 91 insertions(+), 3 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 554b290fefdc..a3d448a075e3 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -139,7 +139,7 @@ int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_po
> }
>
> /* Connect to <cid, port> and return the file descriptor. */
>-static int vsock_connect(unsigned int cid, unsigned int port, int type)
>+int vsock_connect(unsigned int cid, unsigned int port, int type)
> {
> 	union {
> 		struct sockaddr sa;
>@@ -226,8 +226,8 @@ static int vsock_listen(unsigned int cid, unsigned int port, int type)
> /* Listen on <cid, port> and return the first incoming connection.  The remote
>  * address is stored to clientaddrp.  clientaddrp may be NULL.
>  */
>-static int vsock_accept(unsigned int cid, unsigned int port,
>-			struct sockaddr_vm *clientaddrp, int type)
>+int vsock_accept(unsigned int cid, unsigned int port,
>+		 struct sockaddr_vm *clientaddrp, int type)
> {
> 	union {
> 		struct sockaddr sa;
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index e95e62485959..fff22d4a14c0 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -39,6 +39,9 @@ struct test_case {
> void init_signals(void);
> unsigned int parse_cid(const char *str);
> unsigned int parse_port(const char *str);
>+int vsock_connect(unsigned int cid, unsigned int port, int type);
>+int vsock_accept(unsigned int cid, unsigned int port,
>+		 struct sockaddr_vm *clientaddrp, int type);

I'd mention in the commit description that you need these functions to 
be more generic. Maybe in the future we can re-use them where we share 
the same test for both SEQPACKET and STREAM.

The rest LGTM.

Thanks,
Stefano

> int vsock_stream_connect(unsigned int cid, unsigned int port);
> int vsock_bind_connect(unsigned int cid, unsigned int port,
> 		       unsigned int bind_port, int type);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f851f8961247..76bd17b4b291 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -20,6 +20,8 @@
> #include <sys/mman.h>
> #include <poll.h>
> #include <signal.h>
>+#include <sys/ioctl.h>
>+#include <linux/sockios.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1238,6 +1240,79 @@ static void test_double_bind_connect_client(const struct test_opts *opts)
> 	}
> }
>
>+#define MSG_BUF_IOCTL_LEN 64
>+static void test_unsent_bytes_server(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int client_fd;
>+
>+	client_fd = vsock_accept(VMADDR_CID_ANY, 1234, NULL, type);
>+	if (client_fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	recv_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_writeln("RECEIVED");
>+
>+	close(client_fd);
>+}
>+
>+static void test_unsent_bytes_client(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int ret, fd, sock_bytes_unsent;
>+
>+	fd = vsock_connect(opts->peer_cid, 1234, type);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (int i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_expectln("RECEIVED");
>+
>+	ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+	if (ret < 0) {
>+		if (errno == EOPNOTSUPP) {
>+			fprintf(stderr, "Test skipped\n");
>+		} else {
>+			perror("ioctl");
>+			exit(EXIT_FAILURE);
>+		}
>+	} else if (ret == 0 && sock_bytes_unsent != 0) {
>+		fprintf(stderr,
>+			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
>+			sock_bytes_unsent);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_stream_unsent_bytes_client(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_client(opts, SOCK_STREAM);
>+}
>+
>+static void test_stream_unsent_bytes_server(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_server(opts, SOCK_STREAM);
>+}
>+
>+static void test_seqpacket_unsent_bytes_client(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_client(opts, SOCK_SEQPACKET);
>+}
>+
>+static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
>+}
>+
> #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> /* This define is the same as in 'include/linux/virtio_vsock.h':
>  * it is used to decide when to send credit update message during
>@@ -1523,6 +1598,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_rcvlowat_def_cred_upd_client,
> 		.run_server = test_stream_cred_upd_on_low_rx_bytes,
> 	},
>+	{
>+		.name = "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes",
>+		.run_client = test_stream_unsent_bytes_client,
>+		.run_server = test_stream_unsent_bytes_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes",
>+		.run_client = test_seqpacket_unsent_bytes_client,
>+		.run_server = test_seqpacket_unsent_bytes_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.45.2
>
>
>

