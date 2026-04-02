Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D302DE6F1
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136522; cv=none; b=UUVuQpufsm9+kel6nL4F6wwqdkoL/kshKqetG6CkPSVkvh0LDfsMD5cMc++iXnIzaWQz42u0Xr8BHK+4xzt9b3FIo71X1MiOxNqQnHJ4IfVQBXc+P2bTzSqyIC2JnR6URpcEu49IDxiBqIVWzTlKrn7iPmXHb7RSkWiEHRa+cUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136522; c=relaxed/simple;
	bh=gGY/VwPUMO0SWDMiHLhnA/IVkYO3C7UOkCh7m+DwrXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RnBg3857gxkzvbQaJF1ubJPjqMVkzLa/q0K0mLhKLWCuy7OgwLruVj0mfcAbqI0c23hpfNR+VrwIoTzFlPcbtq+WlQTTEGUeZs9+ls+BaVZD5DvmxS8QPjzR7oTG6wJvughZgIYxz3w/K4e3KXWQetkFDWSZIvLBaBKrOd/y7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfXr5cxK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfXr5cxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775136520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/+o6grdtsiw9OGyUnvd5JR5iZVJ9ugAbNz7gRFL3qM=;
	b=FfXr5cxKtseQvhlftxRxqMTd17uSed8zW/N1vrrQILDgAMpS0YFvFToTz83fQKS6+0WmgD
	P94Dj5MnVxtENTrOZkkv+AmH7UwpocSjG7gN7xhOVQc8Dk8Hmk0LE9qLIzaqEvvbd9lft3
	ReF8X1W+mNtmAx9kMS+TFbqQE01cKuI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-ayofLh3ROpiUFFDLXphopw-1; Thu, 02 Apr 2026 09:28:39 -0400
X-MC-Unique: ayofLh3ROpiUFFDLXphopw-1
X-Mimecast-MFC-AGG-ID: ayofLh3ROpiUFFDLXphopw_1775136518
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d034589d0so845162f8f.1
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 06:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136518; x=1775741318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/+o6grdtsiw9OGyUnvd5JR5iZVJ9ugAbNz7gRFL3qM=;
        b=QgPcP/VgMaC3WKnUmCkzU8M/ZJz3yVoXIs2jgJfokYilkqtsesJts+ELltvLA58YLn
         mXHokG858qBoPD41z6pDMiKkf752ndeteRZt3FtV9X/vkudKLF3QJyr5V0fzoCXVb0Pe
         rRLoE07TcAUDh6x6mTNMySdfVcftbUpAyAUeNFZIfBsa1rhqYO7TZ7/719eZ2aDWpyuB
         v4OlrQlrVDy+iv2sw90DkL2TsWC6Um4VQrr4Fb7EI7NaTLxUQi533O0ZaxVezNT5AZnG
         aihZPjszh0WdLFEqZvGD/nyAfX0JAdsyU6O1AXzgSBw2m97o0pc4oVst4mmtUbStRxXr
         Ac1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOdIU1JtDY2LgwKgYEdUL01sAHuuopruvoqHhuKXwGLxaNzH8cv8n5j8v3hqh8Q4Q2uW92fEaUxXQvds8lSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKx99P1Jb7qtjvrke3wtKV/GMDG2lUT8xN2QBUokLoYlkaReEy
	NncgC2AJCGZhsllvpalNIuKqz/fbIl7gIFLjZbZ4NFPXkdS9rDATLwvUYfHYwscgvsNSJ6m/FYJ
	BLOdQXsWYkdKxi1l7JEdwT+Z2ERsPofeGH0869vH14ls1npYX7qobVF6gumlEkGWXmBlE
X-Gm-Gg: ATEYQzw4nin8aSVfCYUjumhTqIHG5S+a2NlSnbwjBjLNEljC3EpBov3TPZpU0n+BikR
	sZ94bygpw9Tvg7pMTOFijVrfr+2zb5nExhcl0nukbNb9hxbtrPNrMvgkwJiU8Z2yNA+LFCR3mBx
	j8sbDD4b2bQ0PFUzryt7U4T68Ts43HuaRDl7xiiSkideTgjopKqRlXPXQnYnN0bi9UWZk7MFEiX
	HIGOp5RodVzN88uCjwBU+wjV8ajEGJmk8rZQ42iqcp1MZaEqPm3nsJrys97ic04V4gBdrNzhbj4
	jd31xrnR2NizJ1RTii7Fmgyr16OZFUiKosyV4fLER/MNtrpAAD1hoAV1MkNL0IMojCbwwepfkBt
	/UzkyLFOI2kuRBNqpsZMQLtA+z1Gg1I8G3ZFoFhe083Sf3egNlNkHCPCeMLMzSwCaakohIXmXvo
	Z9
X-Received: by 2002:a05:600c:848d:b0:485:3c66:e230 with SMTP id 5b1f17b1804b1-488835b78f1mr140993775e9.29.1775136517999;
        Thu, 02 Apr 2026 06:28:37 -0700 (PDT)
X-Received: by 2002:a05:600c:848d:b0:485:3c66:e230 with SMTP id 5b1f17b1804b1-488835b78f1mr140992975e9.29.1775136517515;
        Thu, 02 Apr 2026 06:28:37 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm244763235e9.0.2026.04.02.06.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:28:36 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:28:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Message-ID: <ac5qWSEBM--HuKQK@sgarzare-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5CN2WfdCmbofympQ5WMqn-YPNUlAF0BNlfi4CpS3_Dw_1775136518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Apr 02, 2026 at 10:18:02AM +0200, Luigi Leonardi wrote:
>Add a test that verifies MSG_PEEK works correctly after a partial
>recv().
>
>This is to test a bug that was present in the `virtio_transport_stream_do_peek()`

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#11: This is to test a bug that was present in the 
`virtio_transport_stream_do_peek()`

>when computing the number of bytes to copy: After a partial read, the
>peek function didn't take into consideration the number of bytes that
>were already read. So peeking the whole buffer would cause a out-of-bounds read,
>that resulted in a -EFAULT.
>
>This test does exactly this: do a partial recv on a buffer, then try to
>peek the whole buffer content.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 64 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, false);
> }
>
>+#define PEEK_AFTER_RECV_LEN 100

Why 100 ?
Better to use a power of 2 IMO like we do in all other cases IIRC.

>+
>+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
>+{
>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>+	int fd;
>+	int i;

nit: int fd, i;

>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (i = 0; i < sizeof(buf); i++)
>+		buf[i] = (unsigned char)i;

Why setting the payload in this way ? Can we just do a memset() ?

>+
>+	control_expectln("SRVREADY");

Why we need this barrier ?

>+
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+
>+	close(fd);
>+}
>+
>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>+{
>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>+	int half = PEEK_AFTER_RECV_LEN / 2;
>+	ssize_t ret;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SRVREADY");
>+
>+	/* Partial recv to advance offset within the skb */
>+	recv_buf(fd, buf, half, 0, half);

Why reading half of the size ?

IMO is better to read just 1 byte, since it is almost certain that an 
skb does not have a 1-byte payload.

>+
>+	/* Try to peek more than what remains: should return only 'half'

How we are sure that the sender sent all the bytes ?

>+	 * bytes. Note: we can't use recv_buf() because it loops until
>+	 * all requested bytes are returned.

Why this is a problem ? (an useful comment should explain the reason)

>+	 */
>+	ret = recv(fd, buf, sizeof(buf), MSG_PEEK);
>+	if (ret < 0) {

Should we handle EINTR like we do in recv_buf() ?
But I still don't understand why we can't use it directly.

Thanks,
Stefano

>+		perror("recv");
>+		exit(EXIT_FAILURE);
>+	} else if (ret != half) {
>+		fprintf(stderr, "MSG_PEEK after partial recv returned %d (expected %d)\n",
>+			ret, half);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> #define SOCK_BUF_SIZE_SMALL (64 * 1024)
> #define MAX_MSG_PAGES 4
>@@ -2520,6 +2579,11 @@ static struct test_case test_cases[] = {
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

