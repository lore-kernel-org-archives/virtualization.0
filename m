Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733E2EA49C
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169619; cv=none; b=HCcEXsfCsguCFsPBFUi5CI/15GGqTNd67DjUgen52kr5H18aL1oZjR47YJrpKnZ/K0Rj8G/BF+XH5i7Dg6UmajJsYypiGpj6gyuW64lYNwmtzbMzH5wNGzND5e5rZiQlAU/r8XITxGcxCSsgbO1p9PrrN+x9mIBmPcXOPOvkiDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169619; c=relaxed/simple;
	bh=hVwsYYZn36xXiF5W8xIP83MlOYW1QisiRJWsNZw5rJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=suilNLRUO/E124s7koqFQg7/aNJCkF6TpMLdv9gc49kSwvx1cGD+IdMzQF+DKeMn4qgUFUmiU+A4FCg2YTB3cvICbcA69e987DWgJMTg+UvD2a9fAEGYjeLa4/9U+EtRrIivAyb6fsMd+cLKzD4dgMImzJKfeaEmdO58lmWCwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgsNViCD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgsNViCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750169617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTK+V3/5AEIMjD1XgMrGA0E/N7Cn3he/i5NWgha0jd4=;
	b=YgsNViCDZ0HCsmmfCFYz34aZRNfKbz2AD5bFIdGx6RlohYu8AkiMKeGDNZid+o7KpdNT6R
	lW/HKqNjEn4DhC5kGtDITesP77n4mUeAL78mp/wPrA517AnbOYSTaslmsjZd76LrenWmFI
	DrLNCt1tPXnpytbY6H338Wb3ytes+Xo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-rGufyjCqPAGkoOHGZ5lNXw-1; Tue, 17 Jun 2025 10:13:36 -0400
X-MC-Unique: rGufyjCqPAGkoOHGZ5lNXw-1
X-Mimecast-MFC-AGG-ID: rGufyjCqPAGkoOHGZ5lNXw_1750169615
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so38108405e9.3
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 07:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169614; x=1750774414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTK+V3/5AEIMjD1XgMrGA0E/N7Cn3he/i5NWgha0jd4=;
        b=MP0Aq9r0OMdAivMPHDFmFKrlnfI80LCUt2ssAkIiatDaNSKO6t1lgu6ODNQycXEyml
         gEYoPo8cS7S/iajws0SHvqTCcX2HSoN88fzD07miYcsVmeie1xRgUmlrWsqrTpNf8+x2
         a/dmdY1F5jf6n0tv4STm91lLfTvnatUJHB1yYuSab604S7KcTHDP2vB07AET2m6oASFc
         Gb6RXBbsRvoyF9MF92rFNDOFXWpE6N7Z2izUj4NtRcfzG6IY5F6wjq72AjNbpHQaKKe/
         p9HuwMPm3BNygec3Org9m9Z66rm4JnO5OOgQ6WAJizUyYWc122X4eWTb+64+9Izwt2e4
         f0Ng==
X-Gm-Message-State: AOJu0Yxpt1kTPVTnM/6fr2HK5fsrHP7jlJZ3XUAaP7A78O8BJg3dv6fo
	IqPO+PHC+4ikMfkrZNKzyKCD3N6ubSN6B1B/PqrjCbsg1zErW73b1ofo4aHJiWvlWcPXoSQOALf
	nMYXZbgdliAuMhkLuXHKtJHBOBsRw1wxKiz5QNfjHYfn8zySibnQQGqY6Zlan06nuE7ogskk33q
	hi
X-Gm-Gg: ASbGnct3Q3gOxxzA/rCnvsJoUKNL6BMqiI0+myWWwgCQNLArQMhg/X+MYavbcJZZILd
	+TxNWuJbucWmj+FbYYKhHCAiPf7xt/+Pbe9rL1H4LIeeD0mk8Vw+uMM+J3gtdKNMr0fH+3bEdpe
	ZRqLGD1jOUVwE9ZCnSIC7zDfLmniI8b32u6GT3hALuN8r6iyHOAkxVGXAi7TZ5F+5Jh/kAQteUD
	8D5v5Fl7dTw44mVmphU9gZdBEq+rn2dDcqbKKq9GJrEBY6Y48j1eeaUiKvEloFimBVYVPGQgT57
	QYDn1yWtLQPGL8pRkvRFKERW0c2G
X-Received: by 2002:a05:600c:3e0f:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-4533ca6e93fmr146086605e9.15.1750169614471;
        Tue, 17 Jun 2025 07:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPlcYkMqJhY85N5kdJ0NVPIrUeWzKVBvVBAW5XUvo4CXxFBhQJGAXlkXspSZkF+qZOv0I1Kw==
X-Received: by 2002:a05:600c:3e0f:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-4533ca6e93fmr146086135e9.15.1750169613883;
        Tue, 17 Jun 2025 07:13:33 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea15b0sm179940885e9.11.2025.06.17.07.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:13:32 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:13:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] vsock/test: Cover more CIDs in
 transport_uaf test
Message-ID: <ktw4ong6tsucyx2j2okeow6do7x6whakjg75hyoc7cwzxnt2mu@qzkve4sdpu4o>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
 <20250611-vsock-test-inc-cov-v3-3-5834060d9c20@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250611-vsock-test-inc-cov-v3-3-5834060d9c20@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: An6a7PUVEUPB5JZ-sEAWaFJpkSN59Lp6RjRKTmgB790_1750169615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 11, 2025 at 09:56:52PM +0200, Michal Luczaj wrote:
>Increase the coverage of test for UAF due to socket unbinding, and losing
>transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>Add test for UAF due to socket unbinding") and discussion in [1].
>
>The idea remains the same: take an unconnected stream socket with a
>transport assigned and then attempt to switch the transport by trying (and
>failing) to connect to some other CID. Now do this iterating over all the
>well known CIDs (plus one).
>
>While at it, drop the redundant synchronization between client and server.
>
>Some single-transport setups can't be tested effectively; a warning is
>issued. Depending on transports available, a variety of splats are possible
>on unpatched machines. After reverting commit 78dafe1cf3af ("vsock: Orphan
>socket after transport release") and commit fcdd2242c023 ("vsock: Keep the
>binding until socket destruction"):
>
>BUG: KASAN: slab-use-after-free in __vsock_bind+0x61f/0x720
>Read of size 4 at addr ffff88811ff46b54 by task vsock_test/1475
>Call Trace:
> dump_stack_lvl+0x68/0x90
> print_report+0x170/0x53d
> kasan_report+0xc2/0x180
> __vsock_bind+0x61f/0x720
> vsock_connect+0x727/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>WARNING: CPU: 0 PID: 1475 at net/vmw_vsock/virtio_transport_common.c:37 virtio_transport_send_pkt_info+0xb2b/0x1160
>Call Trace:
> virtio_transport_connect+0x90/0xb0
> vsock_connect+0x782/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>RIP: 0010:sock_has_perm+0xa7/0x2a0
>Call Trace:
> selinux_socket_connect_helper.isra.0+0xbc/0x450
> selinux_socket_connect+0x3b/0x70
> security_socket_connect+0x31/0xd0
> __sys_connect_file+0x79/0x1f0
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>refcount_t: addition on 0; use-after-free.
>WARNING: CPU: 7 PID: 1518 at lib/refcount.c:25 refcount_warn_saturate+0xdd/0x140
>RIP: 0010:refcount_warn_saturate+0xdd/0x140
>Call Trace:
> __vsock_bind+0x65e/0x720
> vsock_connect+0x727/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>refcount_t: underflow; use-after-free.
>WARNING: CPU: 0 PID: 1475 at lib/refcount.c:28 refcount_warn_saturate+0x12b/0x140
>RIP: 0010:refcount_warn_saturate+0x12b/0x140
>Call Trace:
> vsock_remove_bound+0x18f/0x280
> __vsock_release+0x371/0x480
> vsock_release+0x88/0x120
> __sock_release+0xaa/0x260
> sock_close+0x14/0x20
> __fput+0x35a/0xaa0
> task_work_run+0xff/0x1c0
> do_exit+0x849/0x24c0
> make_task_dead+0xf3/0x110
> rewind_stack_and_make_dead+0x16/0x20
>
>[1]: https://lore.kernel.org/netdev/CAGxU2F5zhfWymY8u0hrKksW8PumXAYz-9_qRmW==92oAx1BX3g@mail.gmail.com/
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 93 ++++++++++++++++++++++++++++++++--------
> 1 file changed, 74 insertions(+), 19 deletions(-)

Thanks again for this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f669baaa0dca3bebc678d00eafa80857d1f0fdd6..eb6f54378667ac7ed324f4823e988ec9846e41a3 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1718,16 +1718,27 @@ static void test_stream_msgzcopy_leak_zcskb_server(const struct test_opts *opts)
>
> #define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
>
>-/* Test attempts to trigger a transport release for an unbound socket. This can
>- * lead to a reference count mishandling.
>- */
>-static void test_stream_transport_uaf_client(const struct test_opts *opts)
>+static bool test_stream_transport_uaf(int cid)
> {
> 	int sockets[MAX_PORT_RETRIES];
> 	struct sockaddr_vm addr;
>-	int fd, i, alen;
>+	socklen_t alen;
>+	int fd, i, c;
>+	bool ret;
>+
>+	/* Probe for a transport by attempting a local CID bind. Unavailable
>+	 * transport (or more specifically: an unsupported transport/CID
>+	 * combination) results in EADDRNOTAVAIL, other errnos are fatal.
>+	 */
>+	fd = vsock_bind_try(cid, VMADDR_PORT_ANY, SOCK_STREAM);
>+	if (fd < 0) {
>+		if (errno != EADDRNOTAVAIL) {
>+			perror("Unexpected bind() errno");
>+			exit(EXIT_FAILURE);
>+		}
>
>-	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
>+		return false;
>+	}
>
> 	alen = sizeof(addr);
> 	if (getsockname(fd, (struct sockaddr *)&addr, &alen)) {
>@@ -1735,38 +1746,83 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>+	/* Drain the autobind pool; see __vsock_bind_connectible(). */
> 	for (i = 0; i < MAX_PORT_RETRIES; ++i)
>-		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
>-					SOCK_STREAM);
>+		sockets[i] = vsock_bind(cid, ++addr.svm_port, SOCK_STREAM);
>
> 	close(fd);
>-	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+
>+	/* Setting SOCK_NONBLOCK makes connect() return soon after
>+	 * (re-)assigning the transport. We are not connecting to anything
>+	 * anyway, so there is no point entering the main loop in
>+	 * vsock_connect(); waiting for timeout, checking for signals, etc.
>+	 */
>+	fd = socket(AF_VSOCK, SOCK_STREAM | SOCK_NONBLOCK, 0);
> 	if (fd < 0) {
> 		perror("socket");
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (!vsock_connect_fd(fd, addr.svm_cid, addr.svm_port)) {
>-		perror("Unexpected connect() #1 success");
>+	/* Assign transport, while failing to autobind. Autobind pool was
>+	 * drained, so EADDRNOTAVAIL coming from __vsock_bind_connectible() is
>+	 * expected.
>+	 *
>+	 * One exception is ENODEV which is thrown by vsock_assign_transport(),
>+	 * i.e. before vsock_auto_bind(), when the only transport loaded is
>+	 * vhost.
>+	 */
>+	if (!connect(fd, (struct sockaddr *)&addr, alen)) {
>+		fprintf(stderr, "Unexpected connect() success\n");
> 		exit(EXIT_FAILURE);
> 	}
>-
>-	/* Vulnerable system may crash now. */
>-	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
>-		perror("Unexpected connect() #2 success");
>+	if (errno == ENODEV && cid == VMADDR_CID_HOST) {
>+		ret = false;
>+		goto cleanup;
>+	}
>+	if (errno != EADDRNOTAVAIL) {
>+		perror("Unexpected connect() errno");
> 		exit(EXIT_FAILURE);
> 	}
>
>+	/* Reassign transport, triggering old transport release and
>+	 * (potentially) unbinding of an unbound socket.
>+	 *
>+	 * Vulnerable system may crash now.
>+	 */
>+	for (c = VMADDR_CID_HYPERVISOR; c <= VMADDR_CID_HOST + 1; ++c) {
>+		if (c != cid) {
>+			addr.svm_cid = c;
>+			(void)connect(fd, (struct sockaddr *)&addr, alen);
>+		}
>+	}
>+
>+	ret = true;
>+cleanup:
> 	close(fd);
> 	while (i--)
> 		close(sockets[i]);
>
>-	control_writeln("DONE");
>+	return ret;
> }
>
>-static void test_stream_transport_uaf_server(const struct test_opts *opts)
>+/* Test attempts to trigger a transport release for an unbound socket. This can
>+ * lead to a reference count mishandling.
>+ */
>+static void test_stream_transport_uaf_client(const struct test_opts *opts)
> {
>-	control_expectln("DONE");
>+	bool tested = false;
>+	int cid, tr;
>+
>+	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>+		tested |= test_stream_transport_uaf(cid);
>+
>+	tr = get_transports();
>+	if (!tr)
>+		fprintf(stderr, "No transports detected\n");
>+	else if (tr == TRANSPORT_VIRTIO)
>+		fprintf(stderr, "Setup unsupported: sole virtio transport\n");
>+	else if (!tested)
>+		fprintf(stderr, "No transports tested\n");
> }
>
> static void test_stream_connect_retry_client(const struct test_opts *opts)
>@@ -2034,7 +2090,6 @@ static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM transport release use-after-free",
> 		.run_client = test_stream_transport_uaf_client,
>-		.run_server = test_stream_transport_uaf_server,
> 	},
> 	{
> 		.name = "SOCK_STREAM retry failed connect()",
>
>-- 
>2.49.0
>

