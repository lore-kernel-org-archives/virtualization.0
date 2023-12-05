Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F573DB95
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8Gt9Sf0"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E81F261074
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 10:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E81F261074
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8Gt9Sf0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Jy3UlfpxkDS
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 10:56:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED47560B94
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 10:56:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED47560B94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701773764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xHoHZN4aRFvNFdo4bu58j5O/6N2eNq1OsRYRF67Krww=;
	b=d8Gt9Sf02byvnxxNLTbjEcn/xNV1Y+a4OJsK5ijBFATYxZ3XsSrpzdrq+OWKo+stqwYfTi
	1RSBSmVTnNHiYY93PAZ5bgaLSeJZscj6WVhJA53UUhb6ciZXdNQvjs01hPXnqxw2b14YLl
	QHSobBHj3HQhxkhwyyuT5dF24azcMJI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-meu2ZeIbNSGSZ5pTX6OdAg-1; Tue, 05 Dec 2023 05:56:02 -0500
X-MC-Unique: meu2ZeIbNSGSZ5pTX6OdAg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1c915eae11so39017466b.1
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 02:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773761; x=1702378561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHoHZN4aRFvNFdo4bu58j5O/6N2eNq1OsRYRF67Krww=;
        b=SwFN3ri98w7DM+s64zZFioi1Yw98zN3TJtOl9qLVMvV3+kOyxek/c1H2ZHETlbR4aL
         TuOMIN2eOD/OnBbJHP2avRCfHrMr497qebweEc+Z+UTK0Xez9h48MQ9tR0OVEaNGivPh
         7zCMcfm3Ur6WtnM6Pk7eQsNUkGq3u+FvSz+BA/YFDrWS5lp6NkIzMrXoI5p4hG7JUXtP
         BZ366lWqZpfhMtVs/MhDq1kX8/DJExWk9DwpaeAuKXbyTDxEi2rabAwEL0aqdQ7cVsNL
         5giiQxhnB03v2nBK4e4KoD7tplXc1B5stDNG85fSGJo3GxXaSjj/1IT5BTiAzbMIomYI
         VMjQ==
X-Gm-Message-State: AOJu0YxBoLTVdI2qyCpq7QY2I7OSpXDGBF+ICT0M03j2Q5nRKpj7Oa/z
	4WdDFpscEJh33FFCpiLu7BqZXUxF/0P0Z4gvbPJrIh+xw/7ZlAUYMxOvcGvbOtRmJmvYuggRi+B
	bcg2hir0VFCsaoCnWXLUteoic7XwocXUYqSKK9Qv3LA==
X-Received: by 2002:a17:906:2558:b0:a0f:c538:4612 with SMTP id j24-20020a170906255800b00a0fc5384612mr770829ejb.28.1701773761259;
        Tue, 05 Dec 2023 02:56:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFodYj5wYSzJpUOxz5vmAW8yxE1ykvgpNcy8FOngHr66MXZwbO9eVpr4+yZyLwfPmeuRUBXfQ==
X-Received: by 2002:a17:906:2558:b0:a0f:c538:4612 with SMTP id j24-20020a170906255800b00a0fc5384612mr770808ejb.28.1701773760965;
        Tue, 05 Dec 2023 02:56:00 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-125.retail.telecomitalia.it. [79.46.200.125])
        by smtp.gmail.com with ESMTPSA id ci9-20020a170907266900b00a1be80a0b69sm1143002ejc.58.2023.12.05.02.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:56:00 -0800 (PST)
Date: Tue, 5 Dec 2023 11:55:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v6 4/4] vsock/test: two tests to check credit
 update logic
Message-ID: <tcrlrx2iegveaioryasdvsnjvnrumvq4ky6qcq2p5tb4g65joa@ckin3ipduxvv>
References: <20231205064806.2851305-1-avkrasnov@salutedevices.com>
 <20231205064806.2851305-5-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231205064806.2851305-5-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 05, 2023 at 09:48:06AM +0300, Arseniy Krasnov wrote:
>Both tests are almost same, only differs in two 'if' conditions, so
>implemented in a single function. Tests check, that credit update
>message is sent:
>
>1) During setting SO_RCVLOWAT value of the socket.
>2) When number of 'rx_bytes' become smaller than SO_RCVLOWAT value.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Update commit message by removing 'This patch adds XXX' manner.
>  * Update commit message by adding details about dependency for this
>    test from kernel internal define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
>  * Add comment for this dependency in 'vsock_test.c' where this define
>    is duplicated.
> v2 -> v3:
>  * Replace synchronization based on control TCP socket with vsock
>    data socket - this is needed to allow sender transmit data only
>    when new buffer size of receiver is visible to sender. Otherwise
>    there is race and test fails sometimes.
> v3 -> v4:
>  * Replace 'recv_buf()' to 'recv(MSG_DONTWAIT)' in last read operation
>    in server part. This is needed to ensure that 'poll()' wake up us
>    when number of bytes ready to read is equal to SO_RCVLOWAT value.
> v4 -> v5:
>  * Use 'recv_buf(MSG_DONTWAIT)' instead of 'recv(MSG_DONTWAIT)'.
> v5 -> v6:
>  * Add second test which checks, that credit update is sent during
>    reading data from socket.
>  * Update commit message.
>
> tools/testing/vsock/vsock_test.c | 175 +++++++++++++++++++++++++++++++
> 1 file changed, 175 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 01fa816868bc..66246d81d654 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1232,6 +1232,171 @@ static void test_double_bind_connect_client(const struct test_opts *opts)
> 	}
> }
>
>+#define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
>+/* This define is the same as in 'include/linux/virtio_vsock.h':
>+ * it is used to decide when to send credit update message during
>+ * reading from rx queue of a socket. Value and its usage in
>+ * kernel is important for this test.
>+ */
>+#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE	(1024 * 64)
>+
>+static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opts)
>+{
>+	size_t buf_size;
>+	void *buf;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Send 1 byte more than peer's buffer size. */
>+	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE + 1;
>+
>+	buf = malloc(buf_size);
>+	if (!buf) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait until peer sets needed buffer size. */
>+	recv_byte(fd, 1, 0);
>+
>+	if (send(fd, buf, buf_size, 0) != buf_size) {
>+		perror("send failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	free(buf);
>+	close(fd);
>+}
>+
>+static void test_stream_credit_update_test(const struct test_opts *opts,
>+					   bool low_rx_bytes_test)
>+{
>+	size_t recv_buf_size;
>+	struct pollfd fds;
>+	size_t buf_size;
>+	void *buf;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
>+
>+	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       &buf_size, sizeof(buf_size))) {
>+		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (low_rx_bytes_test) {
>+		/* Set new SO_RCVLOWAT here. This enables sending credit
>+		 * update when number of bytes if our rx queue become <
>+		 * SO_RCVLOWAT value.
>+		 */
>+		recv_buf_size = 1 + VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>+
>+		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>+			       &recv_buf_size, sizeof(recv_buf_size))) {
>+			perror("setsockopt(SO_RCVLOWAT)");
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+
>+	/* Send one dummy byte here, because 'setsockopt()' above also
>+	 * sends special packet which tells sender to update our buffer
>+	 * size. This 'send_byte()' will serialize such packet with data
>+	 * reads in a loop below. Sender starts transmission only when
>+	 * it receives this single byte.
>+	 */
>+	send_byte(fd, 1, 0);
>+
>+	buf = malloc(buf_size);
>+	if (!buf) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait until there will be 128KB of data in rx queue. */
>+	while (1) {
>+		ssize_t res;
>+
>+		res = recv(fd, buf, buf_size, MSG_PEEK);
>+		if (res == buf_size)
>+			break;
>+
>+		if (res <= 0) {
>+			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+
>+	/* There is 128KB of data in the socket's rx queue, dequeue first
>+	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.
>+	 * Otherwise, credit update is sent in 'if (!low_rx_bytes_test)'.
>+	 */
>+	recv_buf_size = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>+	recv_buf(fd, buf, recv_buf_size, 0, recv_buf_size);
>+
>+	if (!low_rx_bytes_test) {
>+		recv_buf_size++;
>+
>+		/* Updating SO_RCVLOWAT will send credit update. */
>+		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>+			       &recv_buf_size, sizeof(recv_buf_size))) {
>+			perror("setsockopt(SO_RCVLOWAT)");
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+
>+	fds.fd = fd;
>+	fds.events = POLLIN | POLLRDNORM | POLLERR |
>+		     POLLRDHUP | POLLHUP;
>+
>+	/* This 'poll()' will return once we receive last byte
>+	 * sent by client.
>+	 */
>+	if (poll(&fds, 1, -1) < 0) {
>+		perror("poll");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (fds.revents & POLLERR) {
>+		fprintf(stderr, "'poll()' error\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (fds.revents & (POLLIN | POLLRDNORM)) {
>+		recv_buf(fd, buf, recv_buf_size, MSG_DONTWAIT, recv_buf_size);
>+	} else {
>+		/* These flags must be set, as there is at
>+		 * least 64KB of data ready to read.
>+		 */
>+		fprintf(stderr, "POLLIN | POLLRDNORM expected\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	free(buf);
>+	close(fd);
>+}
>+
>+static void test_stream_cred_upd_on_low_rx_bytes(const struct test_opts *opts)
>+{
>+	test_stream_credit_update_test(opts, true);
>+}
>+
>+static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
>+{
>+	test_stream_credit_update_test(opts, false);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1342,6 +1507,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_double_bind_connect_client,
> 		.run_server = test_double_bind_connect_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM virtio credit update + SO_RCVLOWAT",
>+		.run_client = test_stream_rcvlowat_def_cred_upd_client,
>+		.run_server = test_stream_cred_upd_on_set_rcvlowat,
>+	},
>+	{
>+		.name = "SOCK_STREAM virtio credit update + low rx_bytes",
>+		.run_client = test_stream_rcvlowat_def_cred_upd_client,
>+		.run_server = test_stream_cred_upd_on_low_rx_bytes,
>+	},
> 	{},
> };
>
>-- 
>2.25.1
>

