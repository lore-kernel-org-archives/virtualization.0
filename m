Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2DE3B27DF
	for <virtualization@lists.linux.dev>; Wed,  8 Apr 2026 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643495; cv=none; b=CThglMih8UAhpI3G9cjw/5KgGEXf5TKTtNI+j4PMEcqt+0rvNGHqdjXR7pVEb8ROrsvFJ0ngD9OIocbsuWpKdWDvgIEmcbVvhKcczRcVvBgG9FSqMcWDbzsbWci1vO7lMjCsL15pS6FORivdcgK2vNJSDTFdGb7YbDhP/JIINNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643495; c=relaxed/simple;
	bh=6xSUwHLjkibUmQWK2HeD5Idw7sBp7VhBE/kVSPW3QPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mQuRjbututq0riLruBADOGz8ubd2b+jsClL4iIQdVVThGALcV39K04CRNoteG7bJOjwi7YTWCVogVr1qlywdnlreYAG7kU0c8chAny9fQysa3mH6C8iMQmUMefmhn6gesE97LEh75qmr9F73VESGq8l0Stek8s7rb1ZIgQ9GRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqpQndp4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqpQndp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775643490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfb2nFt+DWPOPwjJLlcYgP+BepPoSw8wC9wFBQagHJw=;
	b=OqpQndp43lhSoogUfFYJMbYwKnVDnddQ3wBbmfehBo2FjIOF2batqtxuNUg01UJ21ZPJar
	h++4JmCg/HIPy+nJH/vldFeVsxpbzkPq1FgjjXwANdg299YDTAvA9TR2SWfPTyxSdp2/4c
	abNfZzy6Q7Z5Syk7roEo87kxxGC9AHo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-UWs1tBRBP3epBVFkYQQolg-1; Wed, 08 Apr 2026 06:18:09 -0400
X-MC-Unique: UWs1tBRBP3epBVFkYQQolg-1
X-Mimecast-MFC-AGG-ID: UWs1tBRBP3epBVFkYQQolg_1775643488
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d167a0c1fso4422560f8f.3
        for <virtualization@lists.linux.dev>; Wed, 08 Apr 2026 03:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775643487; x=1776248287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfb2nFt+DWPOPwjJLlcYgP+BepPoSw8wC9wFBQagHJw=;
        b=XbNrGExgjCmPyamfEz6e/oFaZOGCbWLzrGu+BQrlt2UJtJh0YptY6OWMACFF8+v/Dv
         Gr5eFifaE3paVmFH7T8mUghqgi+kKa5nJrqACt7db6p4eAKoLh8udwC5tWIIC4FOnPRr
         eGyTSP9Zv6UtRwVe2WH/tS76jOrRNxjvvXIQbvSotPTecLO1TmEaTRJ14FH/adGg5L0k
         CQ+Cbec8AA9ob7YDz8lb91gqrmW8EczO+PSl8+Zq1lqcVPR0ymGepg4p/gfwlSOMvnyr
         e0v4z2EWvgETvcNic6GMxbjsSFRBSFPo8haQjPK9zC0fP/n+4uoA6I5Nf7HATOBst0nF
         O+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd9LlxScN8SYf26mSiw19DAu7NtfdGy8pT3LZabM3XICHioJRkQXvXrO5gw6uOCdvI6LywqpUrR5G/t4Wqig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7+OiwnSoAUPD7Jyj4ASYzl7BGHkY/Ej3fwu5+JfDJmTEHfz+9
	CZmXkK4nIBJoPCVv+mcNJAD+R9bDGtspQVJc5x4R5tSU/UPOQjQzIyq7YQSYJwp7iRC7qDPpj6E
	MKbKz9NFjeOME8DYjhHboplEjpdVKsuGOrOKX0GiYIM1ivUx1voxrpPs7QWbg44YjH+m2RGOsS3
	eP
X-Gm-Gg: AeBDietcei7vOegm5brEAQ2syS9HTONcH3o4xe4pp35Km1vZcrgjdsAm/TSc3n7lKJs
	AGzZZ9XnOlU0Vo/TFPDhLIrcYWlcmq1sxIODNEwg72+RDCz+0HqewIRlavcsSSuIlUZqZOHbxqm
	0JSiK1tOJJd+rGeI4BVuSEC+elODGmLbKzLCyCWZUDqP8vMNZ/tqCLSjgmmDcoAvQuUlvFpecFw
	0/DaYshr4KuybyV5CSJglp7UfIUI/lFUizuvT2wOjCeXk8OY3S9WmL54z44UKkk/nFknh7JLuhh
	yuOOv25lpeRsC67TJsOFLbSPD5+pBm9vgcyTsX/S1XAdq4ygpltOYI3sYMevC4MUE5E/QB4vGp4
	axhZmnjgGgZx0w3e6p3uKElRMd+Pglj3xBXjQWUvez/EEzr2QC5cLbTqVsczt6s8GxwYsXlDsWw
	==
X-Received: by 2002:a05:600c:1da1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488998f488cmr282885455e9.29.1775643487288;
        Wed, 08 Apr 2026 03:18:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1da1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488998f488cmr282884915e9.29.1775643486788;
        Wed, 08 Apr 2026 03:18:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c76d9ed4sm34393955e9.2.2026.04.08.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:18:06 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:18:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Message-ID: <adYoNtv8-fQLts1V@sgarzare-redhat>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
 <20260407-fix_peek-v2-3-2e2581dc8b7c@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407-fix_peek-v2-3-2e2581dc8b7c@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JQNQ7uJ3GJzwj9w2ODzzdTY8NrVggGgY2eD2w-svpp4_1775643488
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 07, 2026 at 11:13:57AM +0200, Luigi Leonardi wrote:
>Add a test that verifies MSG_PEEK works correctly after a partial
>recv().
>
>This is to test a bug that was present in the
>`virtio_transport_stream_do_peek()` when computing the number of bytes to
>copy: After a partial read, the peek function didn't take into
>consideration the number of bytes that were already read. So peeking the
>whole buffer would cause a out-of-bounds read, that resulted in a -EFAULT.
>
>This test does exactly this: do a partial recv on a buffer, then try to
>peek the whole buffer content.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 43 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 43 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bdb0754965df..d38a90a86f34 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -346,6 +346,44 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, false);
> }
>
>+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
>+{
>+	unsigned char buf[MSG_PEEK_BUF_LEN];

What about:

	unsigned char buf[MSG_PEEK_BUF_LEN] = { 0 };

so we can remove the memset() call?

>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	memset(buf, 0, sizeof(buf));
>+
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+
>+	close(fd);
>+}
>+
>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>+{
>+	unsigned char buf[MSG_PEEK_BUF_LEN];
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Partial recv to advance offset within the skb */
>+	recv_buf(fd, buf, 1, 0, 1);
>+
>+	/* Ask more bytes than available */
>+	recv_buf(fd, buf, sizeof(buf), MSG_PEEK, sizeof(buf) - 1);

What about checking also what we read like we do in 
test_msg_peek_server() ?

Not a strong opinion, but if we go in that direction, maybe we can just 
reuse test_stream_msg_peek_client() also for this test case.

Thanks,
Stefano

>+
>+	close(fd);
>+}
>+
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> #define SOCK_BUF_SIZE_SMALL (64 * 1024)
> #define MAX_MSG_PAGES 4
>@@ -2509,6 +2547,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_tx_credit_bounds_client,
> 		.run_server = test_stream_tx_credit_bounds_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
>+		.run_client = test_stream_peek_after_recv_client,
>+		.run_server = test_stream_peek_after_recv_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.53.0
>

