Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4702FC432BE
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:12:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6ED560F55
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6ED560F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC866404E9;
	Wed, 11 Aug 2021 09:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KbqocNBiDpnR; Wed, 11 Aug 2021 09:12:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B169404E5;
	Wed, 11 Aug 2021 09:12:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3650C001A;
	Wed, 11 Aug 2021 09:12:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D801C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBE7E607CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:12:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m_cBKOe0t_Cb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:12:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 561BA6079C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628673165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXwE7CHo/JY+uapmOrMsy/SWDFuCzkqxTC2MlTmyXRU=;
 b=PNqRbR0LCPP26r8qJyRM55VysXR+ZyvAF8CTULKwFk15qy1NRgy2UoYSCC2s5YBYa9vs6C
 9Phodca/oMtaaqWr4kqj1oOs/oRrI5MjMn52c9p8gLUcZ4fwVd+ateECb8aitmXugn9e7B
 lW5rIlePq0M6sar42bmsQUDYctNx3go=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-BfSZ-8fkN9ChCUPIhUEItQ-1; Wed, 11 Aug 2021 05:12:44 -0400
X-MC-Unique: BfSZ-8fkN9ChCUPIhUEItQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 z4-20020a05640240c4b02903be90a10a52so879492edb.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xXwE7CHo/JY+uapmOrMsy/SWDFuCzkqxTC2MlTmyXRU=;
 b=hLt2Pecchtv7P63GunsFCFpCl+Jx/7Fg3y6neS7iN6F/mrmkx2sl0+w1KYW6T/rGQN
 3UeqeozSmZB0h6FiddM2H1mU5QHqz9fte/4lzbHaxj3sG9d0Es5XvlIuskqzJnfqSiMr
 l6zdovEOQFAYa9cLHH8SzmYyXg061xbuotcuvLvVNd9o97vl9qA3zwNyS7fJjs+wR6ke
 H3npVxvbN84V4HYS9m8dJnQKIXZ2VpHr7A2dLFqS0gHgkvPDUvmP5QnWAhdpw5fVjGtf
 XmhXlY1rLzFQSzaa5alNsJqovFjn1JE75nkwqnsougyi2L1Eiy/dBDretX3hcVpY4435
 It4g==
X-Gm-Message-State: AOAM530EuhKhfbyT+MacVe06SNhZOz6fBFJb5VIDnucnhDFTG1k/JJ4T
 aVwAZL1CtbfGxSzFed7kg3hePc8ZOiGqWHT5jLK/wFFWHAsy4H+8tjpzK+63EvjUj4zK8EFPIPg
 tw1jWBk8r8YZBo3pIlGOKJEGwmABUZUpgpgrxI46fHw==
X-Received: by 2002:a17:906:b1d3:: with SMTP id
 bv19mr1140406ejb.361.1628673163551; 
 Wed, 11 Aug 2021 02:12:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOBdpK/bCd9lXs8Es1fYDQDN9tg88WZ+etc/k124zb/U4oV6dt2a1qRBU8C9IEa088GmY3XQ==
X-Received: by 2002:a17:906:b1d3:: with SMTP id
 bv19mr1140394ejb.361.1628673163432; 
 Wed, 11 Aug 2021 02:12:43 -0700 (PDT)
Received: from steredhat (a-nu5-14.tin.it. [212.216.181.13])
 by smtp.gmail.com with ESMTPSA id ee11sm8306374edb.26.2021.08.11.02.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 02:12:43 -0700 (PDT)
Date: Wed, 11 Aug 2021 11:12:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 5/5] vsock_test: update message bounds test for
 MSG_EOR
Message-ID: <20210811091240.jbum3572eelgbbpi@steredhat>
References: <20210810113901.1214116-1-arseny.krasnov@kaspersky.com>
 <20210810114119.1215014-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210810114119.1215014-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Tue, Aug 10, 2021 at 02:41:16PM +0300, Arseny Krasnov wrote:
>Set 'MSG_EOR' in one of message sent, check that 'MSG_EOR'
>is visible in corresponding message at receiver.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> tools/testing/vsock/vsock_test.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 67766bfe176f..2a3638c0a008 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -282,6 +282,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> }
>
> #define MESSAGES_CNT 7
>+#define MSG_EOR_IDX (MESSAGES_CNT / 2)
> static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> {
> 	int fd;
>@@ -294,7 +295,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>
> 	/* Send several messages, one with MSG_EOR flag */
> 	for (int i = 0; i < MESSAGES_CNT; i++)
>-		send_byte(fd, 1, 0);
>+		send_byte(fd, 1, (i == MSG_EOR_IDX) ? MSG_EOR : 0);
>
> 	control_writeln("SENDDONE");
> 	close(fd);
>@@ -324,6 +325,11 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> 			perror("message bound violated");
> 			exit(EXIT_FAILURE);
> 		}
>+
>+		if ((i == MSG_EOR_IDX) ^ !!(msg.msg_flags & MSG_EOR)) {
>+			perror("MSG_EOR");
>+			exit(EXIT_FAILURE);
>+		}
> 	}
>
> 	close(fd);
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
