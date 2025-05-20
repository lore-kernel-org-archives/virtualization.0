Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B4D25D8E2
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731071; cv=none; b=J3QVB6d6E6XaCQo/v15rGnT3fUSlrshi2ymkJs94gXw+9nUrawms+gvKxhhN6edHIezeGJWyOVEHhtfkV2GhNM/asYkyNPnAlOGLgImtNSI/Gtf2T/il4ArQkBCfPdH72NBupshiie1me28DzY8+3nwHYsQjlg+0jB10lRbgWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731071; c=relaxed/simple;
	bh=zotR65AwVsN1R6gTerMNJvK5LH8OmDOyCFKEesqrLiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J0vXUg0HquONRU0rB4IofKFdmIYgbMjY0ddLipbhW05dhcH9PSoOEsT3zSvo+acNpiMu040uTxm5EY/FW/NDEb0Ki+vWbea9H9l4nfW+04Sf5Id5PDc/0faQXAJD7J9fW2ZDMRgLIHSszxGzWjWHIOinRlBWewUhwx5XrSLqX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZgVEijk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZgVEijk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747731068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EOR3BGvukeRG/xgG5qyMBebhNmPVVYRJCDBQXWKeXAs=;
	b=EZgVEijkHj1Gxj0g1XUbVHli5jjLlEJiDsf/tevNaSuBinEM8rPD5kII+Z6lMmmv6JWDlZ
	5fxUDFgFayx+RPydXGpH2Tf4enhf0X/TmpiXDCOQ4NorIRtTbTWaTLKdd4q65Gq1N3ttC1
	1uIsgk3u+t9RkCmVnoNP8/O8V+EdkWc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-GDZ6YKOXOiC9-2X8zq2Yqg-1; Tue, 20 May 2025 04:51:07 -0400
X-MC-Unique: GDZ6YKOXOiC9-2X8zq2Yqg-1
X-Mimecast-MFC-AGG-ID: GDZ6YKOXOiC9-2X8zq2Yqg_1747731066
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-60180ea7852so3946990a12.3
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 01:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747731066; x=1748335866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOR3BGvukeRG/xgG5qyMBebhNmPVVYRJCDBQXWKeXAs=;
        b=vU5q7B3PyoYNyfQ/L4bNjPq+L66tcxwVo305gqMTwbqNUNH8p99c+uN1jMpaoLQ45R
         M93yzN+EiJ4tz1ad7IlQbxAGgQQQFi1mN7d+kM7KST412OH49CkZaKtvJdCa34NpC35A
         ozPXjzmFBuxo8AjZyIsWymbB1Tk95MqZaIETxOLNRvqsC+hDTbXas2fqa4ln/hhmmAQ2
         OadbUwaXD2UBxSK9InUyvZ4RiIReWte8voZLTv5ulDClFja3T6KW+UhVfHIJgmNkv4YK
         mlWlRo29Tj+F+691wNLr3yyULooYjusFtg0C9No21ZqsvlkwdLC8MsUYykVttwrWjbAp
         F8eA==
X-Forwarded-Encrypted: i=1; AJvYcCXmd40xUNZA9rK7eHqhTp+D47GFxAWySCGbcXugXC+wb3mfB4dPn4wgF2W1bxYAMQtdr/V9jIQzyolBRqJrIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyDOGdbx4agL00xUSrx088Woi/jnnLk7Ng0YpfblJVrVDMSote
	8T7pvxSUA4Iw/+9/uO7s4SY/6fuco0Fy6ST1GzpQk/n2s5NcFdRQnYRMDrCOVQ6AFUsbXyH2l5K
	r/bIMG9bOFKTAWQjwxWWtqvhHaUEuB9MdkX8Rg4Bpxm0IXKt07rrBNLQE4w8HTdZmsKlf
X-Gm-Gg: ASbGncun/tv31+dRTIR0KcM3hJevjqwFrseoRLkhcnfvwn2kizpKDadPIRtagrWUMeA
	Uod8U2twlykdbhaGsMnX8D+QY6UQhd0Eybn2DB/lNVS252LNAjXpJLD66pwGldLuaMHlRmfZNA/
	pxwqTXoUQinF00UbBFQCKP9LTXLix6u55xHxUGxvWEATFHdpzRjLWammxqyfp1VQEu5LOQK8o79
	uaeY/tWHopHJgleMR4OcMafUvVzAYJ0qGHxfkTCbrCsRE9n09q2SKI4k01p/Z29gWdkcoLv0nQu
	BFlfVGSV904C9xXdgm6L311vzWA8AMNw6nCJtv+ey45KBiPizGxM9Ry+RlXR
X-Received: by 2002:a17:907:2682:b0:ad5:2b4e:bb7b with SMTP id a640c23a62f3a-ad52d49e2ddmr1403356966b.15.1747731065653;
        Tue, 20 May 2025 01:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaI2ZCuVLkAOsu1YOAu/YmFtpemfCLgNGxHNGFSR/RD5XYMAMIGPJvHO7fGqKwrsdrpyBvDA==
X-Received: by 2002:a17:907:2682:b0:ad5:2b4e:bb7b with SMTP id a640c23a62f3a-ad52d49e2ddmr1403353566b.15.1747731065012;
        Tue, 20 May 2025 01:51:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06e098sm708890366b.59.2025.05.20.01.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:51:04 -0700 (PDT)
Date: Tue, 20 May 2025 10:51:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, fupan.lfp@antgroup.com, pabeni@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	stefanha@redhat.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH 3/3] test/vsock: Add ioctl SIOCINQ tests
Message-ID: <66nlxrh4spcyhp666gqhovnevnnarq2a56fxgkffijnwiartrt@622gumoesmde>
References: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
 <20250519070649.3063874-4-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250519070649.3063874-4-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ny32aGKdSFubdvSEFffOhnCL4OzgOoXr8zrlweymqPA_1747731066
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 19, 2025 at 03:06:49PM +0800, Xuewei Niu wrote:
>This patch adds two tests for ioctl SIOCINQ for SOCK_STREAM and
>SOCK_SEQPACKET. The client waits for the server to send data, and checks if
>the return value of the SIOCINQ is the size of the data. Then, consumes the
>data and checks if the value is 0.

We recently fixed the SIOCOUTQ test, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fd7ad6f36af36f30a06d165eff3780cb139fa79

Should we do the same here?

>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/vsock_test.c | 102 +++++++++++++++++++++++++++++++
> 1 file changed, 102 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d0f6d253ac72..8b3fb88e2877 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1282,6 +1282,78 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
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
>+	// The data have come in but is not read, the expected value is
>+	// MSG_BUF_IOCTL_LEN.
>+	ret = ioctl(fd, SIOCINQ, &sock_bytes_unread);
>+	if (ret < 0) {
>+		if (errno == EOPNOTSUPP) {
>+			fprintf(stderr,
>+				"Test skipped, SIOCINQ not supported.\n");
>+			goto out;
>+		} else {
>+			perror("ioctl");
>+			exit(EXIT_FAILURE);
>+		}
>+	} else if (ret == 0 && sock_bytes_unread != MSG_BUF_IOCTL_LEN) {
>+		fprintf(stderr,
>+			"Unexpected 'SIOCOUTQ' value, expected %d, got %i\n",
>+			MSG_BUF_IOCTL_LEN, sock_bytes_unread);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	// The data is consumed, so the expected is 0.
>+	ret = ioctl(fd, SIOCINQ, &sock_bytes_unread);
>+	if (ret < 0) {
>+		// Don't ignore EOPNOTSUPP since we have already checked it!
>+		perror("ioctl");
>+		exit(EXIT_FAILURE);
>+	} else if (ret == 0 && sock_bytes_unread != 0) {
>+		fprintf(stderr,
>+			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
>+			sock_bytes_unread);
>+		exit(EXIT_FAILURE);
>+	}
>+	control_writeln("RECEIVED");
>+
>+out:
>+	close(fd);
>+}
>+
> static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> {
> 	test_unsent_bytes_client(opts, SOCK_STREAM);
>@@ -1302,6 +1374,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
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
>@@ -1954,6 +2046,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unsent_bytes_client,
> 		.run_server = test_seqpacket_unsent_bytes_server,
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

Please, append new test at the end, so we will not change test IDs.

Thanks,
Stefano

> 	{
> 		.name = "SOCK_STREAM leak accept queue",
> 		.run_client = test_stream_leak_acceptq_client,
>-- 
>2.34.1
>

