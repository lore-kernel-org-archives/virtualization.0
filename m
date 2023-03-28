Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E765BC76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8291F40121;
	Tue, 28 Mar 2023 09:44:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8291F40121
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q7GBFMNr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fp8zrBdQt9vV; Tue, 28 Mar 2023 09:44:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CD90411A9;
	Tue, 28 Mar 2023 09:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CD90411A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D93FBC0037;
	Tue, 28 Mar 2023 09:44:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B73D9C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85C3A81F86
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:44:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85C3A81F86
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q7GBFMNr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vGNhIlaw3Bo5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:44:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D65B081F84
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D65B081F84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679996672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GyxpUUnFruYhLDW97U96aBL0RSI09u9J7yvwV5Q6QsQ=;
 b=Q7GBFMNrcg0pHN88DHweesWiONAdjYVKN9ineFJWYYtjApva5VoD9k4OdUXm1F1wKxFdiy
 z05uocewWu9sOahleIuzsNenIICuWBqGi/yW/078VA9IGn7ecb0W+HVJWUUghqO8bdhI8B
 b0vWovCgTnkyE0Fi1go3LOmUlIy+mNw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-DZLYj5irPDu6JEVfPVREcQ-1; Tue, 28 Mar 2023 05:44:29 -0400
X-MC-Unique: DZLYj5irPDu6JEVfPVREcQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 s21-20020a05620a0bd500b0074234f33f24so5312353qki.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679996669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyxpUUnFruYhLDW97U96aBL0RSI09u9J7yvwV5Q6QsQ=;
 b=bAWDGBJmgae63zR99+eC0w1OpNMYzF+HcDMq7XdPiua2/Lxu90LqYiXJbwpZnYrXtI
 +G+vdg/Pg4+O411wps2BBdS5l71//7mcYh0wWx8emCEU0VP2BST5pmGqR9nDorHitCz1
 oWuntBnSVgQgpHgZ8mS+dhsQWS7b7MpDno3koV4eayjhXSZhcxMT0CdG2Nb5v/TSdBRh
 fHR3OP4aOpqL8DdWIRnPcQ09mFGsXkrSFVFmYbG7D9xCkO2tma7eEbi+ESfbtaCQPn8Q
 pmrDYUcMwLtEvexA+RHQ9wM8hXrD3ttSmC+4NpgAx4FRQs/ZR6QmBYxBZ6lEpy6zyWPG
 Q3pw==
X-Gm-Message-State: AO0yUKUVEKKRSe/imW7fr+hLY4LUrrm4LJcE9VBNOeSnhO037x+y7lF+
 AtDP6o+wYH5TO1EWsdFODZAd6PwrbmB0jSggrU2D70yrdB4XSgNkeL/6QuGraEIV6IDPa0g+J03
 z4xOmzsXu/lUMlTLbjpr+rgShQyrNfIPih4UuuMiOgw==
X-Received: by 2002:a05:622a:13cc:b0:3e3:89a5:192f with SMTP id
 p12-20020a05622a13cc00b003e389a5192fmr22427372qtk.61.1679996669197; 
 Tue, 28 Mar 2023 02:44:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set+hHbSqMRRzFJgBA3hfVusjzZ/rusAYAK9YK1O6yI6x5F2UoicEOao0GkyXZn34kiaPcnzB3Q==
X-Received: by 2002:a05:622a:13cc:b0:3e3:89a5:192f with SMTP id
 p12-20020a05622a13cc00b003e389a5192fmr22427348qtk.61.1679996668960; 
 Tue, 28 Mar 2023 02:44:28 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 11-20020a05620a040b00b007468733cd1fsm6632277qkp.58.2023.03.28.02.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 02:44:28 -0700 (PDT)
Date: Tue, 28 Mar 2023 11:44:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 2/2] vsock/test: update expected return values
Message-ID: <eysn6yxwzwe4mirxk6maqubfdu33yy6b6jjrxa6lqexxxqghln@3ean24dkrf5v>
References: <97f19214-ba04-c47e-7486-72e8aa16c690@sberdevices.ru>
 <f302d3de-28aa-e0b1-1fed-88d3c3bd606a@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <f302d3de-28aa-e0b1-1fed-88d3c3bd606a@sberdevices.ru>
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

On Sun, Mar 26, 2023 at 01:14:01AM +0300, Arseniy Krasnov wrote:
>This updates expected return values for invalid buffer test. Now such
>values are returned from transport, not from af_vsock.c.

Since only virtio transport supports it for now, it's okay.
In the future we should make sure that we have the same behavior between 
transports.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 3de10dbb50f5..a91d0ef963be 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -723,7 +723,7 @@ static void test_seqpacket_invalid_rec_buffer_server(const struct test_opts *opt
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (errno != ENOMEM) {
>+	if (errno != EFAULT) {
> 		perror("unexpected errno of 'broken_buf'");
> 		exit(EXIT_FAILURE);
> 	}
>@@ -887,7 +887,7 @@ static void test_inv_buf_client(const struct test_opts *opts, bool stream)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (errno != ENOMEM) {
>+	if (errno != EFAULT) {
> 		fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
> 		exit(EXIT_FAILURE);
> 	}
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
