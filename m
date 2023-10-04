Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D72E7C4D4
	for <virtualization@archiver.kernel.org>; Wed,  4 Oct 2023 15:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B927961463;
	Wed,  4 Oct 2023 15:45:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B927961463
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ek15eaoZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBEV8cUcJJbV; Wed,  4 Oct 2023 15:45:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E437E61056;
	Wed,  4 Oct 2023 15:45:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E437E61056
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB340C0071;
	Wed,  4 Oct 2023 15:45:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3D9FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 15:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A24D840CA5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 15:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A24D840CA5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ek15eaoZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2sODu8H4rSY7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 15:45:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1D694002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 15:45:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1D694002B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696434314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IxsazhYs2n/9MAXKA5npAthF91JV0rzqOS4I79VruDs=;
 b=Ek15eaoZI0IRnmTP0zTqafNmvx1XaXqz3AoScaaoXccXjPulnNcIPqJEuxzu087NNXsvQE
 6eXE5nMQF8UCI7F4bxQrL2MvZ+YmwOF+qkJPGjzou4ZE6xrD7SfVSBx0QEMW/HmbhnDEQJ
 +A7GUdjPIbvXAp+ygC5q182wUvTZyOc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-13p6MNhJPOi9ZR_j1I6Ahg-1; Wed, 04 Oct 2023 11:45:13 -0400
X-MC-Unique: 13p6MNhJPOi9ZR_j1I6Ahg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65afcf18d05so24386826d6.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Oct 2023 08:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696434312; x=1697039112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxsazhYs2n/9MAXKA5npAthF91JV0rzqOS4I79VruDs=;
 b=kasHtOLuc+8G+uDNxW3doCsOiWfk72HEl8lAFpCUtglMLHjh1sF9ONQ9j+2EPPhNZH
 T4qPAxeRmb56CRMRjr9Y4Udm+DXhkDvTrOY9AFxYR22NxatuLboxrhKN2eQE5DAgTHdt
 RAGvXAwHzzi3iFMLszx/eakKhuftuhmKm0rwERUlLGmaaV3oLEkDHlD4gIqEgWoZPp4F
 PQBtPUcheeSzLm3469j9wF2VUf5SSERE6vFTUpaQV/XQ8bzWAEKSKGc7t02u7N8qPI9O
 GfuSlgXf40JfS+eiPOhrKKee8nkuX41NQXcM+a9tbtumQu0sKbWXbpC9iEWNoZJAqUaW
 KpGA==
X-Gm-Message-State: AOJu0YwQr1a7Lro8KUs2gmtB0V0cOnBTaFe73D7ewuiNyxWLnZjA+2BO
 E1qhydb5iOJdOA0oFUanm7oJrOOPneqXNGUAGwgjCTdpmn4brJJgGEmRm7ADyFZj/hT4lOojhAB
 kSEY5UU/M4wzea4FQJXsMheMWXkFr9d2/D8BcMHOQsQ==
X-Received: by 2002:a0c:e20a:0:b0:65b:8a2:6b86 with SMTP id
 q10-20020a0ce20a000000b0065b08a26b86mr2448015qvl.59.1696434312469; 
 Wed, 04 Oct 2023 08:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9JiqUasipY0BgL87SyW5GEOL9U/R/0xTXkbkmk6K2dh+lVGuHH2VfMxE94OR1d7VlhS5Teg==
X-Received: by 2002:a0c:e20a:0:b0:65b:8a2:6b86 with SMTP id
 q10-20020a0ce20a000000b0065b08a26b86mr2447984qvl.59.1696434312046; 
 Wed, 04 Oct 2023 08:45:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0ccb03000000b0064f4ac061b0sm1414263qvk.12.2023.10.04.08.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:45:11 -0700 (PDT)
Date: Wed, 4 Oct 2023 17:45:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v2 11/12] test/vsock: MSG_ZEROCOPY support for
 vsock_perf
Message-ID: <s5ofd3qomvc6dd7kyo675cyit6u4goehukoq5mkwa2hqsg3bzb@4v46dm7dpuye>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-12-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230930210308.2394919-12-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Sun, Oct 01, 2023 at 12:03:07AM +0300, Arseniy Krasnov wrote:
>To use this option pass '--zc' parameter:

--zerocopy would be better IMHO

>
>./vsock_perf --zc --sender <cid> --port <port> --bytes <bytes to send>
>
>With this option MSG_ZEROCOPY flag will be passed to the 'send()' call.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> tools/testing/vsock/vsock_perf.c | 143 +++++++++++++++++++++++++++++--
> 1 file changed, 134 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index a72520338f84..f0f183f3f9e8 100644
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
>@@ -28,9 +30,18 @@
> #define BYTES_PER_GB		(1024 * 1024 * 1024ULL)
> #define NSEC_PER_SEC		(1000000000ULL)
>
>+#ifndef SOL_VSOCK
>+#define SOL_VSOCK	287
>+#endif
>+
>+#ifndef VSOCK_RECVERR
>+#define VSOCK_RECVERR	1
>+#endif
>+
> static unsigned int port = DEFAULT_PORT;
> static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
> static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
>+static bool zerocopy;
>
> static void error(const char *s)
> {
>@@ -247,15 +258,76 @@ static void run_receiver(unsigned long rcvlowat_bytes)
> 	close(fd);
> }
>
>+static void recv_completion(int fd)
>+{
>+	struct sock_extended_err *serr;
>+	char cmsg_data[128];
>+	struct cmsghdr *cm;
>+	struct msghdr msg = { 0 };
>+	ssize_t ret;
>+
>+	msg.msg_control = cmsg_data;
>+	msg.msg_controllen = sizeof(cmsg_data);
>+
>+	ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
>+	if (ret) {
>+		fprintf(stderr, "recvmsg: failed to read err: %zi\n", ret);
>+		return;
>+	}
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
>+	if (cm->cmsg_type != VSOCK_RECVERR) {
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

We use enable_so_zerocopy() in a single place, maybe we can put this
code there.

Anyway it seems we are copy & paste some codes from util, etc.

Would make sense create a new header to use on both tests and perf?


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
>@@ -265,38 +337,82 @@ static void run_sender(int peer_cid, unsigned long to_send_bytes)
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
>
>-		sent = write(fd, data, buf_size_bytes);
>+		rest_bytes = to_send_bytes - total_send;
>+
>+		before = current_nsec();
>+		sent = send(fd, data, (rest_bytes > buf_size_bytes) ?
>+			    buf_size_bytes : rest_bytes,
>+			    zerocopy ? MSG_ZEROCOPY : 0);
>+		time_in_send += (current_nsec() - before);
>
> 		if (sent <= 0)
> 			error("write");
>
> 		total_send += sent;
>+
>+		if (zerocopy) {
>+			struct pollfd fds = { 0 };
>+
>+			fds.fd = fd;
>+
>+			if (poll(&fds, 1, -1) < 0) {
>+				perror("poll");
>+				exit(EXIT_FAILURE);
>+			}
>+
>+			if (!(fds.revents & POLLERR)) {
>+				fprintf(stderr, "POLLERR expected\n");
>+				exit(EXIT_FAILURE);
>+			}
>+
>+			recv_completion(fd);
>+		}
> 	}
>
> 	tx_total_ns = current_nsec() - tx_begin_ns;
>
> 	printf("total bytes sent: %zu\n", total_send);
> 	printf("tx performance: %f Gbits/s\n",
>-	       get_gbps(total_send * 8, tx_total_ns));
>-	printf("total time in 'write()': %f sec\n",
>+	       get_gbps(total_send * 8, time_in_send));
>+	printf("total time in tx loop: %f sec\n",
> 	       (float)tx_total_ns / NSEC_PER_SEC);
>+	printf("time in 'send()': %f sec\n",
>+	       (float)time_in_send / NSEC_PER_SEC);
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
>@@ -336,6 +452,11 @@ static const struct option longopts[] = {
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
>@@ -351,6 +472,7 @@ static void usage(void)
> 	       "  --help			This message\n"
> 	       "  --sender   <cid>		Sender mode (receiver default)\n"
> 	       "                                <cid> of the receiver to connect to\n"
>+	       "  --zc				Enable zerocopy\n"

Should we specify that this is used only in the sender?

> 	       "  --port     <port>		Port (default %d)\n"
> 	       "  --bytes    <bytes>KMG		Bytes to send (default %d)\n"
> 	       "  --buf-size <bytes>KMG		Data buffer size (default %d). In sender mode\n"
>@@ -413,6 +535,9 @@ int main(int argc, char **argv)
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
