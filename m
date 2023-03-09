Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA33DC64EC4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 16:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6762741041;
	Thu,  9 Mar 2023 16:30:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6762741041
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KaakZY4V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RFudENTeKQ07; Thu,  9 Mar 2023 16:30:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CDB3B4016F;
	Thu,  9 Mar 2023 16:30:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDB3B4016F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5320C0035;
	Thu,  9 Mar 2023 16:30:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D11AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BEBC41040
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:30:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BEBC41040
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XKvOtkZXTMTV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:30:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CB594016F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CB594016F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678379442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z4raW7JwK9AMYLNaG7Amr5oIsub3jCwJbX6vi87O+9M=;
 b=KaakZY4VpoWDhsdqpd7rTaZarb3vF9Rz8YG+l18Chclhb127Bq9vWsC4eCq7UWd99ndK4u
 1qg8DBJiKF6CtibCaXIK1EXWVtq7dj+v+DRef9RJZDwgAPNlNZiOZ4V5MVid0oMN+sCxWH
 pzaValVcWempkOuvrp408X6EBkgGB7E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-5gXQO9ECNWeSsOuGTO3u-Q-1; Thu, 09 Mar 2023 11:30:40 -0500
X-MC-Unique: 5gXQO9ECNWeSsOuGTO3u-Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 jo13-20020a056214500d00b004c6c72bf1d0so1451959qvb.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 08:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678379440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4raW7JwK9AMYLNaG7Amr5oIsub3jCwJbX6vi87O+9M=;
 b=zKq7zYr5f+kug8+UmCpdVqncIZmB1Cy7vAT38G5E9xozwiiHVRsD6wbdztzjSOiTk/
 AFP/94WPdrqfXvRIGrVmeJ8J1vrNBnZx0IDUWCj4VHPbSR4C26VH6qKrVAYi3XweR0RP
 Vz4IeOvFS5A2Cyvo67GqtuKo/DQUx3mszrPhTbykRmZaYkVUMUsj1GRRVJsc+dCs7g65
 4n+HXfrEhV1NFhnj0NvjZbmKahzgnYiSlM22P/LjxR/h6soG73WjkflncIf+PPkv+xQo
 dtCE9onxsAIeZZzpSoC/DatdBnPqJCUFaFFVbtP7RG8VmTjlMGs8zfkIyMISsIi5WQP8
 k6DQ==
X-Gm-Message-State: AO0yUKVYostjFCyT6O9wvNasI9hyXuHMXTsE2UEqr7kLo2syHHJGrjvu
 yKINBDctBEnHQyKx0CPiwN4kvI2lBLeQWN9Ii4qN8pepVCjokoZDxN+8eBQHsAcwmuINaVuxKOx
 fOcamtOxYWNnIzQg2pQN1xhTM1iTOTJT+pwkbquiJnw==
X-Received: by 2002:a05:622a:d4:b0:3bf:dc57:5034 with SMTP id
 p20-20020a05622a00d400b003bfdc575034mr9196019qtw.29.1678379440307; 
 Thu, 09 Mar 2023 08:30:40 -0800 (PST)
X-Google-Smtp-Source: AK7set9F/7Lif+W8Grh5U9Rl6sCN3eyoUaSPb2LI2vQ/RFVdDMCaeHv1X/pGMvmo6/ilZGbAAqWACw==
X-Received: by 2002:a05:622a:d4:b0:3bf:dc57:5034 with SMTP id
 p20-20020a05622a00d400b003bfdc575034mr9195975qtw.29.1678379439938; 
 Thu, 09 Mar 2023 08:30:39 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 u37-20020a05622a19a500b003bd0e7ff466sm14142374qtc.7.2023.03.09.08.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 08:30:39 -0800 (PST)
Date: Thu, 9 Mar 2023 17:30:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 4/4] test/vsock: copy to user failure test
Message-ID: <20230309163034.bznx6pywv5a45egw@sgarzare-redhat>
References: <0abeec42-a11d-3a51-453b-6acf76604f2e@sberdevices.ru>
 <5d726a68-8530-3e90-202c-ba21996db60f@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <5d726a68-8530-3e90-202c-ba21996db60f@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
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

On Thu, Mar 09, 2023 at 01:14:48PM +0300, Arseniy Krasnov wrote:
>This adds SOCK_STREAM and SOCK_SEQPACKET tests for invalid buffer case.
>It tries to read data to NULL buffer (data already presents in socket's
>queue), then uses valid buffer. For SOCK_STREAM second read must return
>data, because skbuff is not dropped, but for SOCK_SEQPACKET skbuff will
>be dropped by kernel, and 'recv()' will return EAGAIN.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 118 +++++++++++++++++++++++++++++++
> 1 file changed, 118 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 67e9f9df3a8c..3de10dbb50f5 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -860,6 +860,114 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define INV_BUF_TEST_DATA_LEN 512
>+
>+static void test_inv_buf_client(const struct test_opts *opts, bool stream)
>+{
>+	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
>+	ssize_t ret;
>+	int fd;
>+
>+	if (stream)
>+		fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	else
>+		fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SENDDONE");
>+
>+	/* Use invalid buffer here. */
>+	ret = recv(fd, NULL, sizeof(data), 0);
>+	if (ret != -1) {
>+		fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (errno != ENOMEM) {
>+		fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	ret = recv(fd, data, sizeof(data), MSG_DONTWAIT);
>+
>+	if (stream) {
>+		/* For SOCK_STREAM we must continue reading. */
>+		if (ret != sizeof(data)) {
>+			fprintf(stderr, "expected recv(2) success, got %zi\n", ret);
>+			exit(EXIT_FAILURE);
>+		}
>+		/* Don't check errno in case of success. */
>+	} else {
>+		/* For SOCK_SEQPACKET socket's queue must be empty. */
>+		if (ret != -1) {
>+			fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		if (errno != EAGAIN) {
>+			fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+
>+	control_writeln("DONE");
>+
>+	close(fd);
>+}
>+
>+static void test_inv_buf_server(const struct test_opts *opts, bool stream)
>+{
>+	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
>+	ssize_t res;
>+	int fd;
>+
>+	if (stream)
>+		fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	else
>+		fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	res = send(fd, data, sizeof(data), 0);
>+	if (res != sizeof(data)) {
>+		fprintf(stderr, "unexpected send(2) result %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SENDDONE");
>+
>+	control_expectln("DONE");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_inv_buf_client(const struct test_opts *opts)
>+{
>+	test_inv_buf_client(opts, true);
>+}
>+
>+static void test_stream_inv_buf_server(const struct test_opts *opts)
>+{
>+	test_inv_buf_server(opts, true);
>+}
>+
>+static void test_seqpacket_inv_buf_client(const struct test_opts *opts)
>+{
>+	test_inv_buf_client(opts, false);
>+}
>+
>+static void test_seqpacket_inv_buf_server(const struct test_opts *opts)
>+{
>+	test_inv_buf_server(opts, false);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -920,6 +1028,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_bigmsg_client,
> 		.run_server = test_seqpacket_bigmsg_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM test invalid buffer",
>+		.run_client = test_stream_inv_buf_client,
>+		.run_server = test_stream_inv_buf_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET test invalid buffer",
>+		.run_client = test_seqpacket_inv_buf_client,
>+		.run_server = test_seqpacket_inv_buf_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
