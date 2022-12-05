Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FAFC4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 13:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3746E60BDE;
	Mon,  5 Dec 2022 13:24:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3746E60BDE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ul50X1zm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rn6s5vPftvYX; Mon,  5 Dec 2022 13:24:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 80A44605A5;
	Mon,  5 Dec 2022 13:24:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80A44605A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60814C0033;
	Mon,  5 Dec 2022 13:24:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4421C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B256E605A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:24:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B256E605A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xR1f5bcWoCJm
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:24:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B55DA605A5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B55DA605A5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670246653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nntNqJI+IggSSFHH2KpYxbpn7ZZuTtPLk8uU1mNP8JI=;
 b=Ul50X1zmJi/wJOGlRR9Nlep3XJhkARL2U5VTig0EABmfw4cYaF2e/j/hXJR+PPyLeSnNpV
 ax6tco/Zf+Df45lsUZmz54Wm4+eAH5cNGD1G342nx0knvf8RY9BeF0bXEIVemGC1LxfGs8
 ytZTml8l3mZ/WijPK4cJZVcJzsEmaLg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-381-FBM9dNDPO3GxeKvBOqaPHA-1; Mon, 05 Dec 2022 08:24:12 -0500
X-MC-Unique: FBM9dNDPO3GxeKvBOqaPHA-1
Received: by mail-wr1-f70.google.com with SMTP id
 k1-20020adfb341000000b0024215e0f486so2307066wrd.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 05:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nntNqJI+IggSSFHH2KpYxbpn7ZZuTtPLk8uU1mNP8JI=;
 b=Bnfefrj3U50tVk4SH31L57FEBKVD2/2bmj2w5EQFZq+02A/lgBEotkA61IOprjEF2j
 9z+V6iWIG5qy19pbfzB9l14snd+grX8AHtl2aI+u3JyFZ+hdSUgruawp38V5mfPV2/Jd
 UY+hhJCTF+G9glG2mg7EmBUgFfNqo8D+kaHVyOwoEU5HJLYQD1UEQ1JZYQoZT/4ev5qc
 MeiKcNu5yHEh8Uuzy6VeCpXOlFpdipbPtVctG86XoBdIPeL8XS6tt5xPfAhD25Vo91q0
 xE5uE0C86/Sw7klu0F+POHbAguMh2AEas3ZvHusop+o2LW34zDNzQ4SS+MbXD4Z1xaEE
 RF9Q==
X-Gm-Message-State: ANoB5pl8NslvmFXnuFvSQVoqQbAQkdlGiUp9jODte2x6GMZeKOZpM32z
 CLsbm12wD9lpZQmkCoRmSCvasPsPMyyUih4jL+B8Ze2wka8rlI8YXN08QXsomowGODRmTiY7bHQ
 UJLlO+0pJhVUltoCNidR0gmqiXJM3NDZ3xvxG9J2DbQ==
X-Received: by 2002:a5d:6090:0:b0:242:3a63:9e6a with SMTP id
 w16-20020a5d6090000000b002423a639e6amr11305110wrt.375.1670246650881; 
 Mon, 05 Dec 2022 05:24:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6FLWhvxYqtr/+fBZixW+KEyHrn7aW4tETP3vGEOxYFhN2uG1XasSfSi+TsgKYY4+LVacrY8Q==
X-Received: by 2002:a5d:6090:0:b0:242:3a63:9e6a with SMTP id
 w16-20020a5d6090000000b002423a639e6amr11305095wrt.375.1670246650616; 
 Mon, 05 Dec 2022 05:24:10 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 g13-20020a05600c310d00b003a2f2bb72d5sm27122624wmo.45.2022.12.05.05.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 05:24:10 -0800 (PST)
Date: Mon, 5 Dec 2022 14:24:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 2/4] test/vsock: rework message bounds test
Message-ID: <20221205132403.oobyrog4chcdqk4z@sgarzare-redhat>
References: <6bd77692-8388-8693-f15f-833df1fa6afd@sberdevices.ru>
 <bdecf9ed-6c9d-ecf8-f159-d4610d5e7cb1@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <bdecf9ed-6c9d-ecf8-f159-d4610d5e7cb1@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
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

On Sun, Dec 04, 2022 at 07:20:52PM +0000, Arseniy Krasnov wrote:
>This updates message bound test making it more complex. Instead of
>sending 1 bytes messages with one MSG_EOR bit, it sends messages of
>random length(one half of messages are smaller than page size, second
>half are bigger) with random number of MSG_EOR bits set. Receiver
>also don't know total number of messages.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/control.c    |  28 +++++++
> tools/testing/vsock/control.h    |   2 +
> tools/testing/vsock/util.c       |  13 ++++
> tools/testing/vsock/util.h       |   1 +
> tools/testing/vsock/vsock_test.c | 124 +++++++++++++++++++++++++++----
> 5 files changed, 155 insertions(+), 13 deletions(-)
>
>diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/control.c
>index 4874872fc5a3..d2deb4b15b94 100644
>--- a/tools/testing/vsock/control.c
>+++ b/tools/testing/vsock/control.c
>@@ -141,6 +141,34 @@ void control_writeln(const char *str)
> 	timeout_end();
> }
>
>+void control_writeulong(unsigned long value)
>+{
>+	char str[32];
>+
>+	if (snprintf(str, sizeof(str), "%lu", value) >= sizeof(str)) {
>+		perror("snprintf");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln(str);
>+}
>+
>+unsigned long control_readulong(void)
>+{
>+	unsigned long value;
>+	char *str;
>+
>+	str = control_readln();
>+
>+	if (!str)
>+		exit(EXIT_FAILURE);
>+
>+	value = strtoul(str, NULL, 10);
>+	free(str);
>+
>+	return value;
>+}
>+
> /* Return the next line from the control socket (without the trailing newline).
>  *
>  * The program terminates if a timeout occurs.
>diff --git a/tools/testing/vsock/control.h b/tools/testing/vsock/control.h
>index 51814b4f9ac1..c1f77fdb2c7a 100644
>--- a/tools/testing/vsock/control.h
>+++ b/tools/testing/vsock/control.h
>@@ -9,7 +9,9 @@ void control_init(const char *control_host, const char *control_port,
> void control_cleanup(void);
> void control_writeln(const char *str);
> char *control_readln(void);
>+unsigned long control_readulong(void);
> void control_expectln(const char *str);
> bool control_cmpln(char *line, const char *str, bool fail);
>+void control_writeulong(unsigned long value);
>
> #endif /* CONTROL_H */
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 2acbb7703c6a..01b636d3039a 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -395,3 +395,16 @@ void skip_test(struct test_case *test_cases, size_t test_cases_len,
>
> 	test_cases[test_id].skip = true;
> }
>+
>+unsigned long hash_djb2(const void *data, size_t len)
>+{
>+	unsigned long hash = 5381;
>+	int i = 0;
>+
>+	while (i < len) {
>+		hash = ((hash << 5) + hash) + ((unsigned char *)data)[i];
>+		i++;
>+	}
>+
>+	return hash;
>+}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index a3375ad2fb7f..fb99208a95ea 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -49,4 +49,5 @@ void run_tests(const struct test_case *test_cases,
> void list_tests(const struct test_case *test_cases);
> void skip_test(struct test_case *test_cases, size_t test_cases_len,
> 	       const char *test_id_str);
>+unsigned long hash_djb2(const void *data, size_t len);
> #endif /* UTIL_H */
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bb6d691cb30d..a5904ee39e91 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -284,10 +284,14 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>-#define MESSAGES_CNT 7
>-#define MSG_EOR_IDX (MESSAGES_CNT / 2)
>+#define SOCK_BUF_SIZE (2 * 1024 * 1024)
>+#define MAX_MSG_SIZE (32 * 1024)
>+
> static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> {
>+	unsigned long curr_hash;
>+	int page_size;
>+	int msg_count;
> 	int fd;
>
> 	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>@@ -296,18 +300,79 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	/* Send several messages, one with MSG_EOR flag */
>-	for (int i = 0; i < MESSAGES_CNT; i++)
>-		send_byte(fd, 1, (i == MSG_EOR_IDX) ? MSG_EOR : 0);
>+	/* Wait, until receiver sets buffer size. */
>+	control_expectln("SRVREADY");
>+
>+	curr_hash = 0;
>+	page_size = getpagesize();
>+	msg_count = SOCK_BUF_SIZE / MAX_MSG_SIZE;
>+
>+	for (int i = 0; i < msg_count; i++) {
>+		ssize_t send_size;
>+		size_t buf_size;
>+		int flags;
>+		void *buf;
>+
>+		/* Use "small" buffers and "big" buffers. */
>+		if (i & 1)
>+			buf_size = page_size +
>+					(rand() % (MAX_MSG_SIZE - page_size));
>+		else
>+			buf_size = 1 + (rand() % page_size);
>+
>+		buf = malloc(buf_size);
>+
>+		if (!buf) {
>+			perror("malloc");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		memset(buf, rand() & 0xff, buf_size);
>+		/* Set at least one MSG_EOR + some random. */
>+		if (i == (msg_count / 2) || (rand() & 1)) {
>+			flags = MSG_EOR;
>+			curr_hash++;
>+		} else {
>+			flags = 0;
>+		}
>+
>+		send_size = send(fd, buf, buf_size, flags);
>+
>+		if (send_size < 0) {
>+			perror("send");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		if (send_size != buf_size) {
>+			fprintf(stderr, "Invalid send size\n");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		/*
>+		 * Hash sum is computed at both client and server in
>+		 * the same way:
>+		 * H += hash('message data')
>+		 * Such hash "contols" both data integrity and message

Little typo s/contols/controls. Maybe is better to use checks.

>+		 * bounds. After data exchange, both sums are compared
>+		 * using control socket, and if message bounds wasn't
>+		 * broken - two values must be equal.
>+		 */
>+		curr_hash += hash_djb2(buf, buf_size);
>+		free(buf);
>+	}
>
> 	control_writeln("SENDDONE");
>+	control_writeulong(curr_hash);
> 	close(fd);
> }
>
> static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> {
>+	unsigned long sock_buf_size;
>+	unsigned long remote_hash;
>+	unsigned long curr_hash;
> 	int fd;
>-	char buf[16];
>+	char buf[MAX_MSG_SIZE];
> 	struct msghdr msg = {0};
> 	struct iovec iov = {0};
>
>@@ -317,25 +382,57 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>+	sock_buf_size = SOCK_BUF_SIZE;
>+
>+	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+		       &sock_buf_size, sizeof(sock_buf_size))) {
>+		perror("getsockopt");

s/getsockopt/setsockopt

I would add also the SO_VM_SOCKETS_BUFFER_MAX_SIZE, I mean something
like this:
                 perror("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       &sock_buf_size, sizeof(sock_buf_size))) {
>+		perror("getsockopt");

Ditto.

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Ready to receive data. */
>+	control_writeln("SRVREADY");
>+	/* Wait, until peer sends whole data. */
> 	control_expectln("SENDDONE");
> 	iov.iov_base = buf;
> 	iov.iov_len = sizeof(buf);
> 	msg.msg_iov = &iov;
> 	msg.msg_iovlen = 1;
>
>-	for (int i = 0; i < MESSAGES_CNT; i++) {
>-		if (recvmsg(fd, &msg, 0) != 1) {
>-			perror("message bound violated");
>-			exit(EXIT_FAILURE);
>-		}
>+	curr_hash = 0;
>
>-		if ((i == MSG_EOR_IDX) ^ !!(msg.msg_flags & MSG_EOR)) {
>-			perror("MSG_EOR");
>+	while (1) {
>+		ssize_t recv_size;
>+
>+		recv_size = recvmsg(fd, &msg, 0);
>+
>+		if (!recv_size)
>+			break;
>+
>+		if (recv_size < 0) {
>+			perror("recvmsg");
> 			exit(EXIT_FAILURE);
> 		}
>+
>+		if (msg.msg_flags & MSG_EOR)
>+			curr_hash++;
>+
>+		curr_hash += hash_djb2(msg.msg_iov[0].iov_base, recv_size);
> 	}
>
> 	close(fd);
>+	remote_hash = control_readulong();
>+
>+	if (curr_hash != remote_hash) {
>+		fprintf(stderr, "Message bounds broken\n");
>+		exit(EXIT_FAILURE);
>+	}
> }
>
> #define MESSAGE_TRUNC_SZ 32
>@@ -837,6 +934,7 @@ int main(int argc, char **argv)
> 		.peer_cid = VMADDR_CID_ANY,
> 	};
>
>+	srand(time(NULL));
> 	init_signals();
>
> 	for (;;) {
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
