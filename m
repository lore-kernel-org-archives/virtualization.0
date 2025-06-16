Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786C273806
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082352; cv=none; b=dHGHSrnENRFKsieCED0NKIgx9WlY6SDwtowzB9dfx76Ud5lIXeWiEc1af9XOwoCc+PxKFXBIe2+A4Tfd3vuRwKPwT+9S71JMcl4AmVuUV+mjEr1EpTW5qzeNt1txrwOB2tO0CYcVWU9GUgHglwNwb/XSRo27JZetbIE9w+p2A60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082352; c=relaxed/simple;
	bh=vqy7nH2TRHhiiSz/OGaQv55N1pBGXt8kziKc5Kqy/AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Qg36tjgSnb+Nrxtn4UHFRxujmC+FETgyol3LY0k0BA3D51ap/ycNpUQcVZFvJSQob02R3T162x1aRc58plfp7RX/ABz97WBJ1LMmLKRlFV2Rpt7RI2PP08zg0FtUAdHorMMY+1AlC7BFLg2RbPQX1VCCly8jRVRehwTPFubcLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGgPlGqO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGgPlGqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750082349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDXOR2+9SFucAcceARHVMU6Tuqx3sff55HmAoDR3SqQ=;
	b=ZGgPlGqOvgMiZ+2GVovrmzeJYEkLWgmpnx7kEWXXMo3qqhDjPf87PaUqbyDn6Y4HJlFho1
	dGCOjkYh2cvg2ekOw8lyY3VgmRZnJNbtfJL0yiY96sYs97wikOEsnfHa9reZv52k4u//Sf
	hkM0R7unUTzzkh617BOV74qAhK0EqO8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-yk8z2XyaOD-Uf6x1iyAV9w-1; Mon, 16 Jun 2025 09:59:08 -0400
X-MC-Unique: yk8z2XyaOD-Uf6x1iyAV9w-1
X-Mimecast-MFC-AGG-ID: yk8z2XyaOD-Uf6x1iyAV9w_1750082347
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4530623eb8fso33372995e9.0
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 06:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082347; x=1750687147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDXOR2+9SFucAcceARHVMU6Tuqx3sff55HmAoDR3SqQ=;
        b=TeW/t5HoCTD7eNEuozXFuYj8ziFjZ8Lu9X39r9TeW7MF/PL1RXqv6fZhvdeix2qMFN
         lFFVlnegfcU96OvnwGMbdwYyBhdyf7RZssUY9VXdODIdw1+lw7FI9NWpd94m46LuWXS8
         sb0tswdeQyHKkf0rkiHy8NoXBaa4vn+Uf92WtVHYyQTcnRTaysOBTLdbd7dDW5yPLd6R
         XyYaCsJ1/uN0gG8Toxa1aa6G3tG8lP/EjXI19jQJ4+I599yiI6f3lE6O1WOq+rZujWCy
         8muKlHelQx16NyTnV0bo13iEQtTRGvhfQAePhwqEOrFxJHHib9Kp5LQcot/+H9qFx5RY
         3SVw==
X-Forwarded-Encrypted: i=1; AJvYcCUKNZaHV8tWMkouYw/TTqurBKGqO05Wb2ECBvURzO311qPxILXX38/M/R8ujDhq6iOWC+P717mcvl0Zl/lXtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyF+adRs2FahRYC5laHwSLJrDnxboUXjhvFHW3/8U4C7NzDNYVa
	q605CXQ/Sv53hF3u8eGt3RnuCpF/06aqjlpTruqEKef8i3Gz8RIpWoxyGCsLriKmuRX7TC6VvnC
	bJDqn8VcbJ2lMgBHjN0Ed7ZLgMJn0qkZu3LmtMbolKWVi8lN2JeoJSGV3GSYagtMBj1tq
X-Gm-Gg: ASbGncvEoxXzDLEheJqhkXEK3rMKeqflDS6mBxD7xZnVOmysm04WZWma2bjbcu06w6f
	c6BJRQtQmTbkcg6RRTNeN2Z1xNSOQ0Jwgtft9KfKjsW1OUo5P4e5w8rFnLTwhU7zyeWw+8vp9Au
	j6NIjZsiEa1OYNkVH/VXUu/R+pozQZXB3VJ+7ZiNTmgIXOR/zUbwD7/RMk3CPMX8hT++gxRiIUU
	JuOdVfrbZz03x28YludDEjrIhSPTWAPijwSLns/wlYfC1a7zd9hmXcae9AtjV+3/HxESoveDBNs
	OBVHk5oL1sFFc4zs1S7G08gjyzU=
X-Received: by 2002:a05:6000:2913:b0:3a4:c2e4:11b with SMTP id ffacd0b85a97d-3a572e5889amr7854235f8f.51.1750082346875;
        Mon, 16 Jun 2025 06:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRgV7a2zE81Cn4q+8HsPH4Efg/1Yo3ECeuGZsn/U6pXmXm9DovaRfGerUSfCxyx2uouMUMag==
X-Received: by 2002:a05:6000:2913:b0:3a4:c2e4:11b with SMTP id ffacd0b85a97d-3a572e5889amr7854209f8f.51.1750082346294;
        Mon, 16 Jun 2025 06:59:06 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.202.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2354fbsm143617795e9.15.2025.06.16.06.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:59:05 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:59:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v2 3/3] test/vsock: Add ioctl SIOCINQ tests
Message-ID: <2oxz7toygswngn7kfmsrbmpikk5qggwbvk3oxb5ucrbq3pcfff@azc54m4hwlfb>
References: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
 <20250613031152.1076725-4-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250613031152.1076725-4-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E8mfKLW2CUv1GM3m2vvLWdgFJdTrT0CBvkTlYN78450_1750082347
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 13, 2025 at 11:11:52AM +0800, Xuewei Niu wrote:
>This patch adds SIOCINQ ioctl tests for both SOCK_STREAM and
>SOCK_SEQPACKET.
>
>The client waits for the server to send data, and checks if the SIOCINQ
>ioctl value matches the data size. After consuming the data, the client
>checks if the SIOCINQ value is 0.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c       | 36 ++++++++++----
> tools/testing/vsock/util.h       |  2 +
> tools/testing/vsock/vsock_test.c | 83 +++++++++++++++++++++++++++++++-
> 3 files changed, 111 insertions(+), 10 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 0c7e9cbcbc85..472246198966 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -97,28 +97,46 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return a negative value if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+int ioctl_int(int fd, unsigned long op, int *actual, int expected)
> {
>-	int ret, sock_bytes_unsent;
>+	int ret;
>+	char name[32];
>+
>+	if (!actual) {
>+		fprintf(stderr, "%s requires a non-null pointer\n", __func__);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		ret = ioctl(fd, op, actual);
> 		if (ret < 0) {
> 			if (errno == EOPNOTSUPP)
> 				break;
>
>-			perror("ioctl(SIOCOUTQ)");
>+			perror(name);
> 			exit(EXIT_FAILURE);
> 		}
>-		timeout_check("SIOCOUTQ");
>-	} while (sock_bytes_unsent != 0);
>+		timeout_check(name);
>+	} while (*actual != expected);
> 	timeout_end();
>
>-	return !ret;
>+	return ret;
>+}
>+
>+/* Wait until transport reports no data left to be sent.
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
>+{
>+	int sock_bytes_unsent;
>+
>+	return !(ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0));
> }

Please split this patch in 2, one where you do the refactoring in 
util.c/h and one for the new test.

>
> /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 5e2db67072d5..945c85ff8d22 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -3,6 +3,7 @@
> #define UTIL_H
>
> #include <sys/socket.h>
>+#include <sys/ioctl.h>

Why we need this in util.h?

> #include <linux/vm_sockets.h>
>
> /* Tests can either run as the client or the server */
>@@ -54,6 +55,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+int ioctl_int(int fd, unsigned long op, int *actual, int expected);
> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f669baaa0dca..43996447f9a2 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -20,7 +20,6 @@
> #include <sys/mman.h>
> #include <poll.h>
> #include <signal.h>
>-#include <sys/ioctl.h>
> #include <linux/time64.h>
>
> #include "vsock_test_zerocopy.h"
>@@ -1305,6 +1304,58 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
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
>+	/* The data has arrived but has not been read. The expected is
>+	 * MSG_BUF_IOCTL_LEN.
>+	 */
>+	ret = ioctl_int(fd, TIOCINQ, &sock_bytes_unread, MSG_BUF_IOCTL_LEN);
>+	if (ret) {
>+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
>+		goto out;
>+	}
>+
>+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	// All date has been consumed, so the expected is 0.
>+	ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
>+	control_writeln("RECEIVED");
>+
>+out:
>+	close(fd);
>+}
>+
> static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> {
> 	test_unsent_bytes_client(opts, SOCK_STREAM);
>@@ -1325,6 +1376,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
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
>@@ -2016,6 +2087,16 @@ static struct test_case test_cases[] = {
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

I think I already mentioned in the previous version: please add new 
tests at the end of the array, so we can preserve test IDs.

Thanks,
Stefano

> 	{
> 		.name = "SOCK_STREAM leak accept queue",
> 		.run_client = test_stream_leak_acceptq_client,
>-- 
>2.34.1
>

