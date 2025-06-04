Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE328C2D8
	for <virtualization@lists.linux.dev>; Wed,  4 Jun 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029891; cv=none; b=F7HlV6szetAdk2onduIQKT9O4Yq8GPP3CpeUcDwp30mbCy03bCyZ9yrNG9ljOIYpwIgPJquysle4kFXagha0uvnmbAMOZbzXRBTfPFb93eOtfDhKKan6xAEUijk+rACAHoDkWXLrM0N0ysiNQUAEgjY+kk+b88R+v04jhAnYXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029891; c=relaxed/simple;
	bh=7fCqoiUkxq/w4Km3ZO/7SYe9HFtg/1gxoVOckreaCUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nJzgv+mvdCLrU6SmC80kxPziAJtKTBBDuHsAE3UW03YGkM9pkoWbRd4L16thJYUkhPFeb9AeZoXSeBNc3O87vX+5ktAy51Gspw7zfaPfN5dTbWDfxxxJUfYC5cSyBSix0+KBr+QgCHk1glZ/wD3pkUtfS1yAQSrJ7D7TASwFRfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+kWZ6QV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+kWZ6QV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749029888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sTi2sDhF1ktvKDHpfvhii++xb0aFx5yYJ91mmRfRcI=;
	b=H+kWZ6QV2QZF87I8NLGtxjLeNTL86vswThF5XvsjvDSvE1+1RhXHoKxAoqNbzeMnzjYziZ
	DL4wtCteS6/d53WIH1bs12vNQbYBmRmxCrri3d6jTQCOeaAk6SIGKm4s/AD15YWXbZ//fz
	czRCK7W1r+oeeiTK9e4p6NzDpAem/IA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-JFupfYdfOZOqj3oWrVrIAg-1; Wed, 04 Jun 2025 05:38:07 -0400
X-MC-Unique: JFupfYdfOZOqj3oWrVrIAg-1
X-Mimecast-MFC-AGG-ID: JFupfYdfOZOqj3oWrVrIAg_1749029886
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e6d426b1so363324f8f.1
        for <virtualization@lists.linux.dev>; Wed, 04 Jun 2025 02:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749029885; x=1749634685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sTi2sDhF1ktvKDHpfvhii++xb0aFx5yYJ91mmRfRcI=;
        b=WTp2nvhLxvd/XWTX6WXENGseEj+k8c5mi0r6/nAXdesolQUNiMY+hFa/SeWnRktqHe
         nI4kHCUCfXIfJiqBfP+boAbEtpiHjKgRaTyuI34EiQhLOSAcUvWZ6Jlo8yp4aDiL0cih
         ydUSHV8hMu5VUU4GJ/jIJT8eHg6AVdgMNqzJb+Ddfidtg9tsQcYzTFXqVlCDSX1ZmGaj
         VJkLI+G6LpljOSmxfjC7dlxjHBRa6XxHcr25wZMdeYI7vN3guZgxblzASIUpCzSv5OuX
         nT6+UVSSCN8EBhDtBYKizRG0B5PETLVeQ6TUfC0xNtfJpTbUNlR3gqUUVI9FP+VzpWSh
         3aAw==
X-Gm-Message-State: AOJu0YzKigvaEtrprMHHr5b1ICUTblN5IDq3lfIOykKSZ+Yom4mo90Jr
	vg9hT0nwk1aWK2Lfok6KiM/0lW18yEdopWsR1bx3zqGveAMxKqmQ08Gms19oz0otcl1TGExWhnm
	1I8r/IobacXiRxG/3JdnmlfsGm/3TgbxYIAIWcD6g0VqYfLlbi7GyxvoX8yppA2ysGNQNuAXSPz
	8e
X-Gm-Gg: ASbGncsqn4Nle2D2h5byJEQHXJ1ljxTlr9nIzgdrNqqllx+eTOj/0FI20w4xZOBk45/
	ywOMYM5lclo6GEdW5e6p4cZL7UGN91raDO0qzamKPkHeVdQjxBf8SyAPVpNj2+yOtqx5QS1uocK
	PfVyQkUWoOaTrKPsfq86GdhzF+YSt437lKVsc7TQJwZdr+ymm1LOVCj4ogl9A+ueExopUafyEwR
	CGTqDjpdg/607DkuPfVuTZPINQEFo7308YUkhdptuxYgRxFB8LiIyuTauyvqU51ed5LIjxS41s0
	+8Df01toSmM1ZSU=
X-Received: by 2002:a5d:64e3:0:b0:3a4:ebfc:8c7 with SMTP id ffacd0b85a97d-3a51d51251emr1685913f8f.8.1749029885341;
        Wed, 04 Jun 2025 02:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQEvjHQup4T4kHl2W20kKgTItvfMhr3nL+cDmNt1r0qsp1RJoVbRMstHRqv/H5iC2W+0219Q==
X-Received: by 2002:a5d:64e3:0:b0:3a4:ebfc:8c7 with SMTP id ffacd0b85a97d-3a51d51251emr1685877f8f.8.1749029884778;
        Wed, 04 Jun 2025 02:38:04 -0700 (PDT)
Received: from sgarzare-redhat ([57.133.22.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73ee0sm20986562f8f.46.2025.06.04.02.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:38:04 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:37:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 3/3] vsock/test: Cover more CIDs in
 transport_uaf test
Message-ID: <ocuwnpdoo7yxoqiockcs7yopoayg5x4b747ksvy4kmk3ds6lb3@f7zgcx7gigt5>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-3-8f655b40d57c@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250528-vsock-test-inc-cov-v2-3-8f655b40d57c@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3BF_fzC9xC03vj0ZjS-uwUjMQb68cvSHYYB2y92oqyo_1749029886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 28, 2025 at 10:44:43PM +0200, Michal Luczaj wrote:
>Increase the coverage of test for UAF due to socket unbinding, and losing
>transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>Add test for UAF due to socket unbinding") and discussion in [1].
>
>The idea remains the same: take an unconnected stream socket with a
>transport assigned and then attempt to switch the transport by trying (and
>failing) to connect to some other CID. Now do this iterating over all the
>well known CIDs (plus one).
>
>Note that having only a virtio transport loaded (without vhost_vsock) is
>unsupported; test will always pass. Depending on transports available, a
>variety of splats are possible on unpatched machines. After reverting
>commit 78dafe1cf3af ("vsock: Orphan socket after transport release") and
>commit fcdd2242c023 ("vsock: Keep the binding until socket destruction"):
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
> tools/testing/vsock/vsock_test.c | 83 +++++++++++++++++++++++++++++++---------
> 1 file changed, 64 insertions(+), 19 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f669baaa0dca3bebc678d00eafa80857d1f0fdd6..b58736023981ef7c4812e069ea577fcf2c0fe9fa 100644
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
>@@ -1735,38 +1746,73 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
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
>+	fd = socket(AF_VSOCK, SOCK_STREAM | SOCK_NONBLOCK, 0);

Why we need this change?

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
>+	 */
>+	addr.svm_port = VMADDR_PORT_ANY;
>+	if (!connect(fd, (struct sockaddr *)&addr, alen)) {
>+		fprintf(stderr, "Unexpected connect() success\n");
>+		exit(EXIT_FAILURE);
>+	} else if (errno == ENODEV) {
>+		/* Handle unhappy vhost_vsock */

Why it's unhappy? No peer?

>+		ret = false;
>+		goto cleanup;
>+	} else if (errno != EADDRNOTAVAIL) {
>+		perror("Unexpected connect() errno");
> 		exit(EXIT_FAILURE);
> 	}
>
>-	/* Vulnerable system may crash now. */
>-	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
>-		perror("Unexpected connect() #2 success");
>-		exit(EXIT_FAILURE);
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
> 	}
>
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
>@@ -2034,7 +2080,6 @@ static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM transport release use-after-free",
> 		.run_client = test_stream_transport_uaf_client,
>-		.run_server = test_stream_transport_uaf_server,

Overall LGTM. I was not able to apply, so I'll test next version.

Thanks,
Stefano

> 	},
> 	{
> 		.name = "SOCK_STREAM retry failed connect()",
>
>-- 
>2.49.0
>

