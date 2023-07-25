Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C73C001DE
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 15:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 966DE80EC2;
	Tue, 25 Jul 2023 15:41:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 966DE80EC2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=emCsZIr6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id omB5mGaUox-U; Tue, 25 Jul 2023 15:41:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F86A80E9A;
	Tue, 25 Jul 2023 15:41:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F86A80E9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD348C0071;
	Tue, 25 Jul 2023 15:41:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97647C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 713A280EC2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:41:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 713A280EC2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0MLy-KfOeh6s
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:41:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B11DE80E9A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:41:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B11DE80E9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690299673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ywc41/BPTk/JOAzpj2Ndsq/haHQiohuM6GBycryh5is=;
 b=emCsZIr6jKqZ7vlyZ45ONeGyycQJM+RgbU+DjUId2IW5s96A6Yxu3yxi8wJYk/0a8xuCso
 OiMtvCYPuRz5CVxqbVphHMnB+9/QrNPG5kusnNLuY5VbqqlV2yKNhiQfdW7tNbTFKmw3z3
 GUjQ9julY7wuWF4A3CleEWJy+Vb6qwQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-kcrOW-4_NW2B69_e8zZBBA-1; Tue, 25 Jul 2023 11:41:12 -0400
X-MC-Unique: kcrOW-4_NW2B69_e8zZBBA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4053d7854a9so73695771cf.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 08:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690299672; x=1690904472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ywc41/BPTk/JOAzpj2Ndsq/haHQiohuM6GBycryh5is=;
 b=HLnezR1QAqnSDnDV4JoYEkW2F7mv0b/2pYH0GYORkGU5SphTANc15fl3zvgPIOogib
 CtQ2ao04RO/KraYoBQ4vx6kjVSz9FoCaxHmSv/4Emt3cr8tVEWYLdERZFqyIe5RKuStV
 4csDds8a3LhSMpFQ175cu+THNUBI5jgSbr1bU9iuk08zA6es4uqxtmyam57mgu2VfmSY
 cxA7EDBj1cJnCFP/fbQxtEBYKVn5Vg0x5Lhvzsfpyo4VPZFjggw4B5Od7jRfStz6m4yx
 lJsTOk/qvLdDd+Qrhv6LpiuaisX9AWrH4dtFOm/MTTcY5cafS+DniOtopVPCgDEwbcrU
 sH7w==
X-Gm-Message-State: ABy/qLamH87A4mXzxVqPFH5kgiri+xExN8cXQOFlItVuSCKe3jVRCfDJ
 waBsKlpQEWnGw612sjF71kjFCDE1iKiwE8f4G0vWEuOg4xDNAeUe/Fvsrx9UuO60FW4FA+mrYCa
 oICWTIzTSFVxlVtaIms9lEIhm0bvz2op8eRTn0Iz2Sw==
X-Received: by 2002:ac8:5f0c:0:b0:405:47aa:742f with SMTP id
 x12-20020ac85f0c000000b0040547aa742fmr3527174qta.32.1690299671817; 
 Tue, 25 Jul 2023 08:41:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHA1b4My1rtvlYJYA1W4nzseTpuRek/vvdBo/xbpSdUcXuiki19nX3FPgKAFwQK2ije6YiWNA==
X-Received: by 2002:ac8:5f0c:0:b0:405:47aa:742f with SMTP id
 x12-20020ac85f0c000000b0040547aa742fmr3527157qta.32.1690299671554; 
 Tue, 25 Jul 2023 08:41:11 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
 by smtp.gmail.com with ESMTPSA id
 g1-20020ac870c1000000b00404f8e9902dsm4132859qtp.2.2023.07.25.08.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 08:41:11 -0700 (PDT)
Date: Tue, 25 Jul 2023 17:41:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 4/4] vsock/test: MSG_PEEK test for SOCK_SEQPACKET
Message-ID: <lkfzuvv53lyycpun27knppjhk46lyqrz4idvzj7fzer2566y5t@mtc7v33q3erg>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-5-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230719192708.1775162-5-AVKrasnov@sberdevices.ru>
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

On Wed, Jul 19, 2023 at 10:27:08PM +0300, Arseniy Krasnov wrote:
>This adds MSG_PEEK test for SOCK_SEQPACKET. It works in the same way as
>SOCK_STREAM test, except it also tests MSG_TRUNC flag.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 58 +++++++++++++++++++++++++++++---
> 1 file changed, 54 insertions(+), 4 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 444a3ff0681f..2ca2cbfa9808 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -257,14 +257,19 @@ static void test_stream_multiconn_server(const struct test_opts *opts)
>
> #define MSG_PEEK_BUF_LEN 64
>
>-static void test_stream_msg_peek_client(const struct test_opts *opts)
>+static void __test_msg_peek_client(const struct test_opts *opts,

Let's stay with just test_msg_peek_client(), WDYT?

>+				   bool seqpacket)
> {
> 	unsigned char buf[MSG_PEEK_BUF_LEN];
> 	ssize_t send_size;
> 	int fd;
> 	int i;
>
>-	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (seqpacket)
>+		fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	else
>+		fd = vsock_stream_connect(opts->peer_cid, 1234);
>+
> 	if (fd < 0) {
> 		perror("connect");
> 		exit(EXIT_FAILURE);
>@@ -290,7 +295,8 @@ static void test_stream_msg_peek_client(const struct test_opts *opts)
> 	close(fd);
> }
>
>-static void test_stream_msg_peek_server(const struct test_opts *opts)
>+static void __test_msg_peek_server(const struct test_opts *opts,

Same here.

The rest LGTM!

Also the whole series should be ready for net-next, right?

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
