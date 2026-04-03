Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57713379EC8
	for <virtualization@lists.linux.dev>; Fri,  3 Apr 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216425; cv=none; b=LLCMQSVnga1g1ad/VGSfWZzUaQb/tGGs+nJC2peki6KsUcRYrzWKv9xZAmnLbKQ9au7a32O4lb4SaaBK1uqJ+bLC4ueeDkIdZeGSp6UzAjEpwE+Lzhr7q+Bi35nv4sakJbFZSAR8PTYKde0QmDAaPIkgqg3P1rwUuzKupAaWqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216425; c=relaxed/simple;
	bh=8TN+BlZjPY5l08/Ao9K/M2zGY/MEGID9w+7QBFQZdLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Dnx3cG7OONOxHrP7I5FA7s3ih4pyvAb0dxHYVyaZNp6AGgff8Tj6fDBysOtSwcwAwUZaCpYy0v4rrFzfhswLzvUwVgGCDOxfT4rF6IUZZngl40SnAHs+koK4qKLuUCArffu6Y5xprzwYmxdE00BHJKyzGreGQMDgdtARw2kA+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1AD4uuF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1AD4uuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775216423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppi0x+HSa6LF7yaD9isSOML84wuFQNIDT2AkWs8WtI8=;
	b=T1AD4uuFIoT1WzNB7SHZa1b9fjK/9KofrXELLjfn/0jGr2mbhbSca6PqlrNCySFVHJHOME
	TDsoHrG5BsjUgl+OP6gZbfbMe9dvp+QMJeiS+tTO71EF9Xygxf+5RGbjFEeowZObEUOyn1
	INopGt+5sv3HLhrkXii6Hkk2ZRS7YRY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-4_Z_nJu-ORCwZgUWLDx2cA-1; Fri, 03 Apr 2026 07:40:20 -0400
X-MC-Unique: 4_Z_nJu-ORCwZgUWLDx2cA-1
X-Mimecast-MFC-AGG-ID: 4_Z_nJu-ORCwZgUWLDx2cA_1775216419
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so1954728f8f.0
        for <virtualization@lists.linux.dev>; Fri, 03 Apr 2026 04:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775216419; x=1775821219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppi0x+HSa6LF7yaD9isSOML84wuFQNIDT2AkWs8WtI8=;
        b=F3jskGfDPWXNKOEREHnOgsqDxAc5IU9YhDbqWA+GKqWuTqAtlnrDOtv4oQL10VtEyq
         IhtFQXXtqcXi99okG+bvzf0DkoQYwebtXQseEOgIItLN7H3Tv+odh+NnRfZ3mR7U7ZWx
         Ut8qSCtNoP66ZYDsWn/53T2xtnRlDjoGzBOeRmxYHplsrF3qdy2/mK/AV4lVgoIO+Uby
         Ri1H542nQAWaLjh/kGu7bHBz7XF3CFEEU7+13IJe31po/2QpjwYxMYXwYjnWZffNmNf4
         DFRiRjhJI/z1BJB9ByygvzUAz7N4i11c+WLpmZTgCgZN+sU2e5Jyf6l67cWJXp5Vr+LA
         ZKgg==
X-Forwarded-Encrypted: i=1; AJvYcCVpCcu6zdzrn12YulnEi27EtKtg+0v2ysHzhGBN6jmkNP7mxZ6LSFzXhSxvlFxdGp+V7PYj9yJIwrlgNsJacA==@lists.linux.dev
X-Gm-Message-State: AOJu0YztxxgwBMXCMPQh4bocA741sv3ZT0DPvoH/QAhTlfab6oN/rd12
	6gUmKUq3JXlYuCK5uyNG1zZLgmzFv23arPsHEiDJtp7s8TH3O9gf4xOciZ/LQBg0i9RFSAQhWuj
	mbctdW/9PsqOVc2ORiGijVrctLSXRsW6T1hz+gQhCZTrc/msEgPHB9RikERbJyooFSoTM
X-Gm-Gg: AeBDievxmSvSicrKdZNjqzWDFhfu9gketI5twXjzuQVedKOWIWUZGuJdO6wO0/eVUMG
	ip0i7L0uAg2Ec3de/TlBIiEvDe7aBVQp8HSToISsLjU4/4hI5gZnQiAyGEDh9YDLt/OKA03qpoT
	mnK6/JeJBM7R2/J2373t8WC7zZgohvViDH7I+n4jkWRkcvQxaXxBeq34b3MjFDovqEnOERnRl5N
	0wPtc0taGYtn8SGn9nycfP17eXNmHtMkRG78b0u2pAb2ojVJsXh20hO1via4JNdh7NZUufnFzW3
	Ggkz43ze4/TRLw02G4vF4SXOdpQeC2lCiAMAmP9W5qajO+eDNZ+eFufz1ljiM05R6lU/DecdnBQ
	ATNXSsTShAW20qklV+lWWJBxc83k=
X-Received: by 2002:a5d:5f86:0:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43d292a9591mr4506597f8f.22.1775216418995;
        Fri, 03 Apr 2026 04:40:18 -0700 (PDT)
X-Received: by 2002:a5d:5f86:0:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43d292a9591mr4506537f8f.22.1775216418515;
        Fri, 03 Apr 2026 04:40:18 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e221bsm15087517f8f.29.2026.04.03.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 04:40:18 -0700 (PDT)
Date: Fri, 3 Apr 2026 13:40:15 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Message-ID: <ac-mZ9vHII96dTtP@leonardi-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
 <ac5qWSEBM--HuKQK@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ac5qWSEBM--HuKQK@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: db7XuFiVGvJf_OQHBIW1v4RWswocRX0SaM-zawKO0ds_1775216419
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Apr 02, 2026 at 03:28:25PM +0200, Stefano Garzarella wrote:
>On Thu, Apr 02, 2026 at 10:18:02AM +0200, Luigi Leonardi wrote:
>>Add a test that verifies MSG_PEEK works correctly after a partial
>>recv().
>>
>>This is to test a bug that was present in the `virtio_transport_stream_do_peek()`
>
>WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>#11: This is to test a bug that was present in the 
>`virtio_transport_stream_do_peek()`
>

oops, thanks :)

>>when computing the number of bytes to copy: After a partial read, the
>>peek function didn't take into consideration the number of bytes that
>>were already read. So peeking the whole buffer would cause a out-of-bounds read,
>>that resulted in a -EFAULT.
>>
>>This test does exactly this: do a partial recv on a buffer, then try to
>>peek the whole buffer content.
>>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
>>1 file changed, 64 insertions(+)
>>
>>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
>>--- a/tools/testing/vsock/vsock_test.c
>>+++ b/tools/testing/vsock/vsock_test.c
>>@@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>>	return test_msg_peek_server(opts, false);
>>}
>>
>>+#define PEEK_AFTER_RECV_LEN 100
>
>Why 100 ?
>Better to use a power of 2 IMO like we do in all other cases IIRC.
>

Right, I'll reuse `MSG_PEEK_BUF_LEN`.

>>+
>>+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
>>+{
>>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>>+	int fd;
>>+	int i;
>
>nit: int fd, i;
>
>>+
>>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>+	if (fd < 0) {
>>+		perror("connect");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	for (i = 0; i < sizeof(buf); i++)
>>+		buf[i] = (unsigned char)i;
>
>Why setting the payload in this way ? Can we just do a memset() ?

Good point.

>
>>+
>>+	control_expectln("SRVREADY");
>
>Why we need this barrier ?

leftover from development, will remove.

>
>>+
>>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>>+
>>+	close(fd);
>>+}
>>+
>>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>>+{
>>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>>+	int half = PEEK_AFTER_RECV_LEN / 2;
>>+	ssize_t ret;
>>+	int fd;
>>+
>>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>>+	if (fd < 0) {
>>+		perror("accept");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	control_writeln("SRVREADY");
>>+
>>+	/* Partial recv to advance offset within the skb */
>>+	recv_buf(fd, buf, half, 0, half);
>
>Why reading half of the size ?
>
>IMO is better to read just 1 byte, since it is almost certain that an 
>skb does not have a 1-byte payload.
>

will do

>>+
>>+	/* Try to peek more than what remains: should return only 'half'
>
>How we are sure that the sender sent all the bytes ?
>
>>+	 * bytes. Note: we can't use recv_buf() because it loops until
>>+	 * all requested bytes are returned.
>
>Why this is a problem ? (an useful comment should explain the reason)
>

Some changes are required to `recv_buf`, I have a working v2 version
that uses that. Thanks for the hint.

>>+	 */
>>+	ret = recv(fd, buf, sizeof(buf), MSG_PEEK);
>>+	if (ret < 0) {
>
>Should we handle EINTR like we do in recv_buf() ?
>But I still don't understand why we can't use it directly.
>
>Thanks,
>Stefano
>
>>+		perror("recv");
>>+		exit(EXIT_FAILURE);
>>+	} else if (ret != half) {
>>+		fprintf(stderr, "MSG_PEEK after partial recv returned %d (expected %d)\n",
>>+			ret, half);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	close(fd);
>>+}
>>+
>>#define SOCK_BUF_SIZE (2 * 1024 * 1024)
>>#define SOCK_BUF_SIZE_SMALL (64 * 1024)
>>#define MAX_MSG_PAGES 4
>>@@ -2520,6 +2579,11 @@ static struct test_case test_cases[] = {
>>		.run_client = test_stream_tx_credit_bounds_client,
>>		.run_server = test_stream_tx_credit_bounds_server,
>>	},
>>+	{
>>+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
>>+		.run_client = test_stream_peek_after_recv_client,
>>+		.run_server = test_stream_peek_after_recv_server,
>>+	},
>>	{},
>>};
>>
>>
>>-- 
>>2.53.0
>>
>

