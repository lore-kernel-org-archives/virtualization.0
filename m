Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC5DC61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 15:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 464F782028;
	Thu, 16 Feb 2023 15:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 464F782028
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fTPbuYoh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQmihVfE4rUm; Thu, 16 Feb 2023 15:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A24AE81F89;
	Thu, 16 Feb 2023 15:30:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A24AE81F89
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C3ABC0033;
	Thu, 16 Feb 2023 15:30:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36549C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 15:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F136B60759
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 15:29:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F136B60759
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fTPbuYoh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g6UW0SlG65TH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 15:29:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC67D60687
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC67D60687
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676561393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O+OnUaBkHzkHXcVUDxA2W+iWYjA7NHTym1Lcryt4gOY=;
 b=fTPbuYohSqwPKmn59lyrhFQ7OiBrpd6QTG66jZkaYJtZN27Sz+lqtaxlr1Nat0YsxCJ0in
 ga2pW6yAy7v7eu4CrdmrStGsaOyF49RU7fSBxVvXlbDfLPdgMrUEAaBbL3Jm/U6ACqMX7v
 2p5enm489zm97OsGWOkxsERjhAE2PwE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-HIvhkAddOEuPWP5aY42sEQ-1; Thu, 16 Feb 2023 10:29:52 -0500
X-MC-Unique: HIvhkAddOEuPWP5aY42sEQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 c9-20020a05620a11a900b0072a014ecc4aso1375174qkk.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 07:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+OnUaBkHzkHXcVUDxA2W+iWYjA7NHTym1Lcryt4gOY=;
 b=sV/WC9qZVaZR8vOBhGxnpMiiu9I1qSfytnBTtw+9MBQ2v0+7y+H5amedDOWWUY5gVk
 Kjh2i7pZ1A7u9TQYr7YJXNvJWxtXewIWMOZsdtsHyLUkSIq02Qidli6o614Dvrsrnttr
 IYj+lxG0tdy5sHh3hvxmFZaZfu7D7iSf+ByUYDez0pOXAiRMozNzZXTtTfPRF5v5jECp
 DMhdKeTgnYxzu5ekEeMUrh6VenCUgTUr+hGUgep3GdT91XAp9HF3uqlF7XVIaS+VSgDZ
 0blpIkPjMrXUBKS9SypH3KekaZo4V2gpRvq8CTCUSrNrFKkvl5MCSlRJSbREpFpuJwsB
 vVOA==
X-Gm-Message-State: AO0yUKWVrLV/VgBjcAgIaaMo7le6RZOfX5hosNMfKbv3F0INP+rfXevh
 ujVx8AiPJu44Di6z1zjpkhhwyCAEP152Tp8JA+aBJzUDOg3j/6Ph7eyFiHVaKalJ6+3ur4/+5GA
 ydTv3Dr7WCcNo9A71/H1yYDtpk+02bEApzssaRB+wKg==
X-Received: by 2002:a05:6214:20aa:b0:56e:adc7:da2c with SMTP id
 10-20020a05621420aa00b0056eadc7da2cmr11354180qvd.45.1676561392259; 
 Thu, 16 Feb 2023 07:29:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8jujUmYvQoNbsqIW6FTw3ePLT8M+JBb9cOjPHIvg9BVyvokaD0baxtMbtkCTkLtlm/CuRZaA==
X-Received: by 2002:a05:6214:20aa:b0:56e:adc7:da2c with SMTP id
 10-20020a05621420aa00b0056eadc7da2cmr11354147qvd.45.1676561391923; 
 Thu, 16 Feb 2023 07:29:51 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it.
 [82.57.51.167]) by smtp.gmail.com with ESMTPSA id
 b64-20020a37b243000000b0072ad54e36b2sm1349762qkf.93.2023.02.16.07.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 07:29:51 -0800 (PST)
Date: Thu, 16 Feb 2023 16:29:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 12/12] test/vsock: MSG_ZEROCOPY support for
 vsock_perf
Message-ID: <20230216152945.qdh6vrq66pl2bfxe@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <03570f48-f56a-2af4-9579-15a685127aeb@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <03570f48-f56a-2af4-9579-15a685127aeb@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 06, 2023 at 07:06:32AM +0000, Arseniy Krasnov wrote:
>To use this option pass '--zc' parameter:

--zerocopy or --zero-copy maybe better follow what we did with the other 
parameters :-)

>
>./vsock_perf --zc --sender <cid> --port <port> --bytes <bytes to send>
>
>With this option MSG_ZEROCOPY flag will be passed to the 'send()' call.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_perf.c | 127 +++++++++++++++++++++++++++++--
> 1 file changed, 120 insertions(+), 7 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index a72520338f84..1d435be9b48e 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -18,6 +18,8 @@
> #include <poll.h>
> #include <sys/socket.h>
> #include <linux/vm_sockets.h>
>+#include <sys/mman.h>
>+#include <linux/errqueue.h>
>
> #define DEFAULT_BUF_SIZE_BYTES	(128 * 1024)
> #define DEFAULT_TO_SEND_BYTES	(64 * 1024)
>@@ -28,9 +30,14 @@
> #define BYTES_PER_GB		(1024 * 1024 * 1024ULL)
> #define NSEC_PER_SEC		(1000000000ULL)
>
>+#ifndef SOL_VSOCK
>+#define SOL_VSOCK 287
>+#endif

I thought we use the current kernel headers when we compile the tests,
do we need to fix something in the makefile?

>+
> static unsigned int port = DEFAULT_PORT;
> static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
> static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
>+static bool zerocopy;
>
> static void error(const char *s)
> {
>@@ -247,15 +254,74 @@ static void run_receiver(unsigned long rcvlowat_bytes)
> 	close(fd);
> }
>
>+static void recv_completion(int fd)
>+{
>+	struct sock_extended_err *serr;
>+	char cmsg_data[128];
>+	struct cmsghdr *cm;
>+	struct msghdr msg;
>+	int ret;
>+
>+	msg.msg_control = cmsg_data;
>+	msg.msg_controllen = sizeof(cmsg_data);
>+
>+	ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
>+	if (ret == -1)
>+		return;
>+
>+	cm = CMSG_FIRSTHDR(&msg);
>+	if (!cm) {
>+		fprintf(stderr, "cmsg: no cmsg\n");
>+		return;
>+	}
>+
>+	if (cm->cmsg_level != SOL_VSOCK) {
>+		fprintf(stderr, "cmsg: unexpected 'cmsg_level'\n");
>+		return;
>+	}
>+
>+	if (cm->cmsg_type) {
>+		fprintf(stderr, "cmsg: unexpected 'cmsg_type'\n");
>+		return;
>+	}
>+
>+	serr = (void *)CMSG_DATA(cm);
>+	if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY) {
>+		fprintf(stderr, "serr: wrong origin\n");
>+		return;
>+	}
>+
>+	if (serr->ee_errno) {
>+		fprintf(stderr, "serr: wrong error code\n");
>+		return;
>+	}
>+
>+	if (zerocopy && (serr->ee_code & SO_EE_CODE_ZEROCOPY_COPIED))
>+		fprintf(stderr, "warning: copy instead of zerocopy\n");
>+}
>+
>+static void enable_so_zerocopy(int fd)
>+{
>+	int val = 1;
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val)))
>+		error("setsockopt(SO_ZEROCOPY)");
>+}
>+
> static void run_sender(int peer_cid, unsigned long to_send_bytes)
> {
> 	time_t tx_begin_ns;
> 	time_t tx_total_ns;
> 	size_t total_send;
>+	time_t time_in_send;
> 	void *data;
> 	int fd;
>
>-	printf("Run as sender\n");
>+	if (zerocopy)
>+		printf("Run as sender MSG_ZEROCOPY\n");
>+	else
>+		printf("Run as sender\n");
>+
> 	printf("Connect to %i:%u\n", peer_cid, port);
> 	printf("Send %lu bytes\n", to_send_bytes);
> 	printf("TX buffer %lu bytes\n", buf_size_bytes);
>@@ -265,25 +331,58 @@ static void run_sender(int peer_cid, unsigned long to_send_bytes)
> 	if (fd < 0)
> 		exit(EXIT_FAILURE);
>
>-	data = malloc(buf_size_bytes);
>+	if (zerocopy) {
>+		enable_so_zerocopy(fd);
>
>-	if (!data) {
>-		fprintf(stderr, "'malloc()' failed\n");
>-		exit(EXIT_FAILURE);
>+		data = mmap(NULL, buf_size_bytes, PROT_READ | PROT_WRITE,
>+			    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>+		if (data == MAP_FAILED) {
>+			perror("mmap");
>+			exit(EXIT_FAILURE);
>+		}
>+	} else {
>+		data = malloc(buf_size_bytes);
>+
>+		if (!data) {
>+			fprintf(stderr, "'malloc()' failed\n");
>+			exit(EXIT_FAILURE);
>+		}
> 	}

Eventually to simplify the code I think we can use the mmaped buffer in
both cases.

>
> 	memset(data, 0, buf_size_bytes);
> 	total_send = 0;
>+	time_in_send = 0;
> 	tx_begin_ns = current_nsec();
>
> 	while (total_send < to_send_bytes) {
> 		ssize_t sent;
>+		size_t rest_bytes;
>+		time_t before;
>+
>+		rest_bytes = to_send_bytes - total_send;
>
>-		sent = write(fd, data, buf_size_bytes);
>+		before = current_nsec();
>+		sent = send(fd, data, (rest_bytes > buf_size_bytes) ?
>+			    buf_size_bytes : rest_bytes,
>+			    zerocopy ? MSG_ZEROCOPY : 0);
>+		time_in_send += (current_nsec() - before);
>
> 		if (sent <= 0)
> 			error("write");
>
>+		if (zerocopy) {
>+			struct pollfd fds = { 0 };
>+
>+			fds.fd = fd;

Which event are we waiting for here?

>+
>+			if (poll(&fds, 1, -1) < 0) {
>+				perror("poll");
>+				exit(EXIT_FAILURE);
>+			}

We need this because we use only one buffer, but if we use more than
one, we could take full advantage of zerocopy, right?

Otherwise, I don't think it's a fair comparison with non-zerocopy.

Thanks,
Stefano

>+
>+			recv_completion(fd);
>+		}
>+
> 		total_send += sent;
> 	}
>
>@@ -294,9 +393,14 @@ static void run_sender(int peer_cid, unsigned long to_send_bytes)
> 	       get_gbps(total_send * 8, tx_total_ns));
> 	printf("total time in 'write()': %f sec\n",
> 	       (float)tx_total_ns / NSEC_PER_SEC);
>+	printf("time in send %f\n", (float)time_in_send / NSEC_PER_SEC);
>
> 	close(fd);
>-	free(data);
>+
>+	if (zerocopy)
>+		munmap(data, buf_size_bytes);
>+	else
>+		free(data);
> }
>
> static const char optstring[] = "";
>@@ -336,6 +440,11 @@ static const struct option longopts[] = {
> 		.has_arg = required_argument,
> 		.val = 'R',
> 	},
>+	{
>+		.name = "zc",
>+		.has_arg = no_argument,
>+		.val = 'Z',
>+	},
> 	{},
> };
>
>@@ -351,6 +460,7 @@ static void usage(void)
> 	       "  --help			This message\n"
> 	       "  --sender   <cid>		Sender mode (receiver default)\n"
> 	       "                                <cid> of the receiver to connect to\n"
>+	       "  --zc				Enable zerocopy\n"
> 	       "  --port     <port>		Port (default %d)\n"
> 	       "  --bytes    <bytes>KMG		Bytes to send (default %d)\n"
> 	       "  --buf-size <bytes>KMG		Data buffer size (default %d). In sender mode\n"
>@@ -413,6 +523,9 @@ int main(int argc, char **argv)
> 		case 'H': /* Help. */
> 			usage();
> 			break;
>+		case 'Z': /* Zerocopy. */
>+			zerocopy = true;
>+			break;
> 		default:
> 			usage();
> 		}
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
