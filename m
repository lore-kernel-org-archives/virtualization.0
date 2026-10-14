Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9E54DAFE
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990374; cv=none; b=CBGrphrxJ7c8ZN7fSJw4XxeNjIHuP0fWXz5hmpKAH6m3MDIH7KCmzCWlYCvsSb/+i/S+2oQ05HEDiqhPx9101uDSWzLjnF6mC+hh0+UEvYzKODAatdiNOvnBDTvk8Y2OvDBraUS5zL3GfYok1sK5iXDsUGcCCLVzbV6wfmhQnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990374; c=relaxed/simple;
	bh=soNI6GgkharquAstotbRK5nopE01Or39jiaVcdpi6Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R6Glbo2KUuyTieghFrWKKuEeotNzLlK3FfAqEujzHZto//zqbL5up74jdEyuqrc43QmhmIM72BdKx8gMx+f85qZB7dtrNlqb90JNztDMSyVM0QlXnlNCzIlhjaa1rzFXbKPkXY2fQ+jIrTltVOmjMSzGBbQmfaW+yza+Ujiksxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grU0O5pa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grU0O5pa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791990370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MlJtI51pruw2RMBHRkQEZjnzeHmSsE6g8ymfOHInCb4=;
	b=grU0O5paRNWbRztway7HsUf9058kpS1eq+0k+8xgH/pCNax16xxZzBy6019ory+jWrEU6f
	LNSeUqitozeWtXu8iTBTA4QJXCu433Q2/9gv+68mCRVttkMSokjcjG6S2g3CuHe1zN4QYe
	DqW2PH1CMs1hBKNliI+c04YoDGBhHAw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-1VaI-FSiPE-qW19ZCs8HXw-1; Wed, 14 Oct 2026 15:06:07 +0000
X-MC-Unique: 1VaI-FSiPE-qW19ZCs8HXw-1
X-Mimecast-MFC-AGG-ID: 1VaI-FSiPE-qW19ZCs8HXw_1791990366
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c430f0f01so478882f8f.1
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791990366; x=1792595166;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MlJtI51pruw2RMBHRkQEZjnzeHmSsE6g8ymfOHInCb4=;
        b=JJwBtL7beoZpDpUxASZWccOsZq2mWkwt7Kn+GX0cSvQzVCz9qGn4CfVhTMZb0Qz1bB
         Dod+Opj07qoLJRQuLtcURkhQij2O9SJGKKIXYC+s7/SXb5Z95/fQSVJYkeUKkiaGacua
         Zlr0ciACONW/r+x/lJSDy2u39WZP4JQenukzUSJ9Sb5RgZT1jhfjLp6JqG29rha5WmuS
         4eNdONtTDQWFzacSl+r7+tDkrSaJiQoYvS5h8LjQFfs27qv2cSjASLbtdCtAStVfU9Ye
         Y4LMH3WLUEFzIzq9rydpLbPb4p172aW0kOXptIIkYQpuQ5/+pFqLF1yV9wpZWpfwWBCN
         RjIw==
X-Forwarded-Encrypted: i=1; AKwUvBwILzzv8bqfyonMQNoHNaZFQAvxhxh3flwalNmYOMNWSN07A7pntrlfQRnu1CoKAE9uxx9qK3MhzfQk+MR7LA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLTyy+vSmRZRzf0UJ6WtI5zeu+NQfsQ2DbYmyza/P1gn+O4Llgw
	9AOuX5kPoTSaf8Q719MjIrAKio7lL0//5BDSyEl+laHqvLJZyzk+8BhrMTjJ5ZlEHnsno8SDbz+
	WngfIo17dB6bwbX4Uqq3fB/EpchR+TMNsvh+NWbkvCcO/E8m87t74/TYn63dpopdtyj0y
X-Gm-Gg: AYBFou020IziKJBoooS3iH1llayH2Dart7h+wTpB/wSGO4ak6dy+7K4018gWmQKbr3B
	3AdCvPT1/Cc4SZoe3w8dadWnBom1PLsECG79mumfQa4KCiV/188htf4bhKwgkcv/dwGt56JaTU0
	L7oVoPs7e91XWxRu6kd1somGhzrpz28MV1cu2ySH3BX6HEvCN9S6Uz9WyUmh7r4gnXipCn0YXab
	bgnA9hWkf+tT+9a975gaVaFm5ATz3nRGWj66Fh+iWAXMghqeui1Xwu9S2RqASOcW6lmnWOpanB8
	KWy4haRIi7FQOKiBRrj9ah6vqb1cyQXp+QR+VJRDzPfObl2RsDYARHE+I4H2r/nOOPL6T1Xky2R
	JNuG13w==
X-Received: by 2002:a5d:5a08:0:b0:488:7b66:140c with SMTP id ffacd0b85a97d-48dbaae719amr23579236f8f.28.1791990366272;
        Wed, 14 Oct 2026 08:06:06 -0700 (PDT)
X-Received: by 2002:a5d:5a08:0:b0:488:7b66:140c with SMTP id ffacd0b85a97d-48dbaae719amr23579162f8f.28.1791990365719;
        Wed, 14 Oct 2026 08:06:05 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.157.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0acb1ebsm12875830f8f.44.2026.10.14.08.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:06:04 -0700 (PDT)
Date: Wed, 14 Oct 2026 17:05:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] vsock/test: cover SO_INQ
Message-ID: <as-Z4hSXYQw4ZPHy@sgarzare-redhat>
References: <20261012235524.41468-1-devnexen@gmail.com>
 <20261012235524.41468-3-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261012235524.41468-3-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cPXc0-MeKfMphpvAlJzXZ8_1YHXSbOAJc6Y64-kN6VM_1791990366
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Oct 13, 2026 at 12:55:24AM +0100, David Carlier wrote:
>Check the SCM_INQ value after a partial receive, after draining the
>queue and at EOF, that no cmsg is sent while the option is off, and
>that out of range values and SOCK_SEQPACKET are rejected.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> tools/testing/vsock/vsock_test.c | 191 +++++++++++++++++++++++++++++++
> 1 file changed, 191 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index b4ff9f946565..00bb68c00c07 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2429,6 +2429,188 @@ static void test_stream_collapse_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define SO_INQ_BUF_LEN 64
>+#define SO_INQ_CHUNK_LEN 16
>+
>+static int so_inq_set(int fd, int val)
>+{
>+	return setsockopt(fd, SOL_SOCKET, SO_INQ, &val, sizeof(val));
>+}
>+
>+/* Receive @len bytes and return the SCM_INQ value, or -1 if the kernel did
>+ * not attach one.
>+ */
>+static int so_inq_recv(int fd, size_t len, int expected_ret)
>+{
>+	char control[CMSG_SPACE(sizeof(int))] = { 0 };
>+	unsigned char buf[SO_INQ_BUF_LEN];
>+	struct iovec iov = {
>+		.iov_base = buf,
>+		.iov_len = len,
>+	};
>+	struct msghdr msg = {
>+		.msg_iov = &iov,
>+		.msg_iovlen = 1,
>+		.msg_control = control,
>+		.msg_controllen = sizeof(control),
>+	};
>+	struct cmsghdr *cmsg;
>+	ssize_t ret;
>+	int inq;
>+
>+	ret = recvmsg(fd, &msg, 0);
>+	if (ret < 0) {
>+		perror("recvmsg");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	expect_res(ret, expected_ret, "recvmsg");
>+
>+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
>+		if (cmsg->cmsg_level != SOL_SOCKET ||
>+		    cmsg->cmsg_type != SCM_INQ)
>+			continue;

Should we check CMSG_LEN and/or MSG_CTRUNC ?

The rest LGTM.

Thanks,
Stefano

>+
>+		memcpy(&inq, CMSG_DATA(cmsg), sizeof(inq));
>+		return inq;
>+	}
>+
>+	return -1;
>+}
>+
>+static void test_stream_so_inq_client(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SENT");
>+
>+	/* Wait for the whole payload to be queued, so the values below do not
>+	 * depend on how the transport delivers it.
>+	 */
>+	if (!vsock_ioctl_int(fd, SIOCINQ, SO_INQ_BUF_LEN)) {
>+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
>+		goto out;
>+	}
>+
>+	/* No ancillary data unless the option is enabled. */
>+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN), -1,
>+		   "SCM_INQ with SO_INQ disabled");
>+
>+	if (so_inq_set(fd, 1)) {
>+		if (errno != ENOPROTOOPT) {
>+			perror("setsockopt(SO_INQ)");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
>+		goto out;
>+	}
>+
>+	/* Partial read: the rest of the payload is still queued. */
>+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN),
>+		   SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN,
>+		   "SCM_INQ after partial receive");
>+
>+	/* Draining read while the peer stays connected. */
>+	expect_res(so_inq_recv(fd, SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN,
>+			       SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN), 0,
>+		   "SCM_INQ after draining receive");
>+
>+	control_writeln("DRAINED");
>+	vsock_wait_remote_close(fd);
>+
>+	/* Nothing is queued once the peer is gone, but 1 is reported so the
>+	 * caller keeps reading until it observes EOF, as TCP_INQ does.
>+	 */
>+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, 0), 1, "SCM_INQ at EOF");
>+
>+	if (so_inq_set(fd, 0)) {
>+		perror("setsockopt(SO_INQ)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, 0), -1,
>+		   "SCM_INQ after disabling SO_INQ");
>+
>+	close(fd);
>+	return;
>+
>+out:
>+	control_writeln("DRAINED");
>+	close(fd);
>+}
>+
>+static void test_stream_so_inq_server(const struct test_opts *opts)
>+{
>+	unsigned char buf[SO_INQ_BUF_LEN];
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	memset(buf, 'A', sizeof(buf));
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_writeln("SENT");
>+
>+	/* Keep the connection open until the peer has drained the queue: an
>+	 * early close would turn its last SCM_INQ value into the EOF one.
>+	 */
>+	control_expectln("DRAINED");
>+	close(fd);
>+}
>+
>+static void test_so_inq_validation_client(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (so_inq_set(fd, 1)) {
>+		if (errno != ENOPROTOOPT) {
>+			perror("setsockopt(SO_INQ)");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
>+		close(fd);
>+		return;
>+	}
>+
>+	if (!so_inq_set(fd, 2) || errno != EINVAL) {
>+		fprintf(stderr, "SO_INQ accepted an out of range value\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+
>+	/* SCM_INQ counts bytes, which a message based socket cannot report. */
>+	fd = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (!so_inq_set(fd, 1) || errno != ENOPROTOOPT) {
>+		fprintf(stderr, "SO_INQ not rejected on SOCK_SEQPACKET\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -2633,6 +2815,15 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_collapse_client,
> 		.run_server = test_stream_collapse_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM SO_INQ functionality",
>+		.run_client = test_stream_so_inq_client,
>+		.run_server = test_stream_so_inq_server,
>+	},
>+	{
>+		.name = "SO_INQ option validation",
>+		.run_client = test_so_inq_validation_client,
>+	},
> 	{},
> };
>
>-- 
>2.55.0
>

