Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768416DC28
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839708; cv=none; b=KK/ZkLaKWaQGtoJ7VBbvXlEUCeXxhq7nTy8mOlY1678Yc4+KR99396mVp1bCXNpvfTOM7YWs1/fmBQIXIzJcz6j6SRgk1DpA8p0bNdyYFddrXJmk7R1f1Z7foXVAber+e46PFbHuleF3QKuoQAlOMYUkA0IlFpiYQvXb33Z0z8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839708; c=relaxed/simple;
	bh=xehhInAtDXNQ/n5gfDz6llbpaPNmLMER2GgFqEhTcvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=debNZbQ80hyiZ1e8Cl/9BIH3YMqNcNojhRk4W7EL+K7Vx4N2uKoehV1GbLfcz3qanYXVqHVJqGrNrlx7RWYti3FEkuf8qRndakTwez07PNibmGbP6OsIg2+0u1zT5Scp9D1PncaBGdwN65kWew7JI4K6l1RuuVGa/M05YGYRC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWjSdytg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWjSdytg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747839705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQaN0Uw5ksNxoFenF66ughGD5YHdupsTVLr1isPbs2c=;
	b=hWjSdytgJHRjZM9ZWKgacZ2tgTfhkF2vpHZHztrQSYue5JaagsHOfpPhfi2aEqylU1js/U
	lpfS5vx9SSX2hYmHLf6MlRNe6xoJPFeA4nG/BnZoVBhnL90V8tBhJw074vcQ0Chm0Nn72H
	dPuK8Iq4o9NP+2IGGIus3dcs3LLVFpU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-EkVsrvx4OXGRDjwxOfziaA-1; Wed, 21 May 2025 11:01:43 -0400
X-MC-Unique: EkVsrvx4OXGRDjwxOfziaA-1
X-Mimecast-MFC-AGG-ID: EkVsrvx4OXGRDjwxOfziaA_1747839702
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-601f1e8acc5so3532469a12.0
        for <virtualization@lists.linux.dev>; Wed, 21 May 2025 08:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839702; x=1748444502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQaN0Uw5ksNxoFenF66ughGD5YHdupsTVLr1isPbs2c=;
        b=aJr7AYl91inne6MAzFkomAHy9Yy0BG2CrXmXLJj4LwmZMt+zSL3xrv7oiaS5GrFs7W
         6ucLkFAXPxZccYmy5QRKMNWe4kzLaj1MfrJri3Hgdbv2iUx26ib9GxsTeQE7uNiYuRo2
         qdw3S03OHTjorEc+tdeLF8Rua8TKAa77nLkQaV4l1Qd1/wqEIuQRQ4i0QqtLWYE+SwNm
         Smplhi3ZltsGpe7N3DnNL9XDQ7Xuf6uQsosbfJO+facv4gkZiJSQzAXdW9f+COBrT/bk
         zAeZ7BrhgC3vptLD9N2zWB7kHuaEt/3VtqH6F5w46tNDbrTp82l91vz0kF+V9PZViQp8
         /XHw==
X-Forwarded-Encrypted: i=1; AJvYcCUuSnkFs8IDPbFjOqXFO58YZGm+thABQq77PQb8jKHscb2VKvYTv3kfDGRpQvXlQb1MgURw5O5MYdATOfJ8mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1R3iUFJKUtqeB7Q2PjO4/re3kIR8zJDm0MGEym0XUST4wN6Zl
	qKPlCmP3CR+c2pmBS5BSgUOD2RIlGrI5xVVSS0GAmu1X3LsGTj7czHlHeRi/2j9vqRaD9PGY4OI
	lGYzWxcbDFDKTVu2fl61rWkvjCqCCJ9yT12+1daHoNuTEs0YxnC6pgagLE/K4wa4ebKHB
X-Gm-Gg: ASbGncvJoWmjQWz2BHsloRyewzm9FzaZXomIUb6kYu5QAJkmIqTxrsfaaQSPSrwTgKE
	JJw490gUvxL9xLWqjJQh7pTgRxMWRP171quYMT0PXkSU19cbhINEeJ75rAwof4jNfbdZAQUujfu
	IR7SnM93qR4ztHnhspllVnb6ltFjHdnx9x5t4Tc064IDxCvxFnRSFclLGaWNrtZ/OZ/+M4pEAv6
	IsEL0v38TPWPJLcP4KKeqjQ2ohoMEW6qXOjN5BQLRylHAxaP0P2gQGI1ynoP5wB4Z4nIso+s0Va
	4JL0aSxn1s9DlrW4sQhLOqRZB1yY/flVCBeF6ReGb9wR98yzyEVo+hF8fpUf
X-Received: by 2002:a17:907:7da2:b0:ad4:d9c9:c758 with SMTP id a640c23a62f3a-ad536b7c8dfmr1808155366b.11.1747839694947;
        Wed, 21 May 2025 08:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlYrXcyUQ/GFhKIGPeqwLg3L9B+4cCMXz+eKCUeTZ4xCrnP7r7wqBOBXYGqGyAGakMiIi6NQ==
X-Received: by 2002:a17:907:7da2:b0:ad4:d9c9:c758 with SMTP id a640c23a62f3a-ad536b7c8dfmr1808102866b.11.1747839690863;
        Wed, 21 May 2025 08:01:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4ca5c5sm909001966b.162.2025.05.21.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:01:30 -0700 (PDT)
Date: Wed, 21 May 2025 17:01:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/5] vsock/test: Introduce vsock_wait_sent()
 helper
Message-ID: <kva35i6sjyxuugywlanlnkbdunbyauadgnciteakxu2jsb2kl7@24fgdq2glxk6>
References: <20250521-vsock-linger-v5-0-94827860d1d6@rbox.co>
 <20250521-vsock-linger-v5-3-94827860d1d6@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250521-vsock-linger-v5-3-94827860d1d6@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R_IlrVUhFh-ZGBoctYiX0tKiyYFogwNWOeZ7fZxoYOk_1747839702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 21, 2025 at 12:55:21AM +0200, Michal Luczaj wrote:
>Distill the virtio_vsock_sock::bytes_unsent checking loop (ioctl SIOCOUTQ)
>and move it to utils. Tweak the comment.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 25 +++++++++++++++++++++++++
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 23 ++++++-----------------
> 3 files changed, 32 insertions(+), 17 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index de25892f865f07672da0886be8bd1a429ade8b05..120277be14ab2f58e0350adcdd56fc18861399c9 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -17,6 +17,7 @@
> #include <assert.h>
> #include <sys/epoll.h>
> #include <sys/mman.h>
>+#include <linux/sockios.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -96,6 +97,30 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>+/* Wait until transport reports no data left to be sent.
>+ * Return non-zero if transport does not implement the unsent_bytes() callback.
>+ */
>+int vsock_wait_sent(int fd)

nit: I just see we use `bool` in the test to store the result of this 
function, so maybe we can return `bool` directl from here...

(not a strong opinion, it's fine also this).

Thanks,
Stefano

>+{
>+	int ret, sock_bytes_unsent;
>+
>+	timeout_begin(TIMEOUT);
>+	do {
>+		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		if (ret < 0) {
>+			if (errno == EOPNOTSUPP)
>+				break;
>+
>+			perror("ioctl(SIOCOUTQ)");
>+			exit(EXIT_FAILURE);
>+		}
>+		timeout_check("SIOCOUTQ");
>+	} while (sock_bytes_unsent != 0);
>+	timeout_end();
>+
>+	return ret;
>+}
>+
> /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
> int vsock_bind(unsigned int cid, unsigned int port, int type)
> {
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index d1f765ce3eeeed8f738630846bb47c4f3f6f946f..e307f0d4f6940e984b84a95fd0d57598e7c4e35f 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+int vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
> void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9ea33b78b9fcb532f4f9616b38b4d2b627b04d31..4c2c94151070d54d1ed6e6af5a6de0b262a0206e 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -21,7 +21,6 @@
> #include <poll.h>
> #include <signal.h>
> #include <sys/ioctl.h>
>-#include <linux/sockios.h>
> #include <linux/time64.h>
>
> #include "vsock_test_zerocopy.h"
>@@ -1280,7 +1279,7 @@ static void test_unsent_bytes_server(const struct test_opts *opts, int type)
> static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> {
> 	unsigned char buf[MSG_BUF_IOCTL_LEN];
>-	int ret, fd, sock_bytes_unsent;
>+	int fd;
>
> 	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
> 	if (fd < 0) {
>@@ -1297,22 +1296,12 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> 	/* SIOCOUTQ isn't guaranteed to instantly track sent data. Even though
> 	 * the "RECEIVED" message means that the other side has received the
> 	 * data, there can be a delay in our kernel before updating the "unsent
>-	 * bytes" counter. Repeat SIOCOUTQ until it returns 0.
>+	 * bytes" counter. vsock_wait_sent() will repeat SIOCOUTQ until it
>+	 * returns 0.
> 	 */
>-	timeout_begin(TIMEOUT);
>-	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>-		if (ret < 0) {
>-			if (errno == EOPNOTSUPP) {
>-				fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>-				break;
>-			}
>-			perror("ioctl");
>-			exit(EXIT_FAILURE);
>-		}
>-		timeout_check("SIOCOUTQ");
>-	} while (sock_bytes_unsent != 0);
>-	timeout_end();
>+	if (vsock_wait_sent(fd))
>+		fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>+
> 	close(fd);
> }
>
>
>-- 
>2.49.0
>

