Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1DEC83F2E
	for <virtualization@archiver.kernel.org>; Thu, 31 Aug 2023 15:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75D3C41892;
	Thu, 31 Aug 2023 15:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75D3C41892
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RvDmU0b0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YsAQaxm8mhrP; Thu, 31 Aug 2023 15:23:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C1A94031D;
	Thu, 31 Aug 2023 15:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C1A94031D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2271C0039;
	Thu, 31 Aug 2023 15:23:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3090C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D41F41888
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D41F41888
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w14-Qj0B10vO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:23:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B08C54031D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B08C54031D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693495407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2qLYWseOqvE9giCpHzoh0LjB8ysce7C+TOetknN7JE=;
 b=RvDmU0b0+CzhJ9O4FcAT5pQ1amNgx26Razx50jprVGxxXiXyBiNGehXkvJAHpM1i4zj31I
 a5ufuBcL+77NUgWLeiNVZFvb2BEQaStLTev1lBCweHkEj4JnqIT7CMzB+OvmT3iWbUdrvJ
 X825Z2k6EuOnxgI6uj+ibe8z7aKMed4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-woNIhyXcML-ItyJW4VtBfQ-1; Thu, 31 Aug 2023 11:23:26 -0400
X-MC-Unique: woNIhyXcML-ItyJW4VtBfQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso68196266b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693495405; x=1694100205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2qLYWseOqvE9giCpHzoh0LjB8ysce7C+TOetknN7JE=;
 b=kqmzMbZt/leR0mHywByKNADDY/uyqksxHNRGM/1HHOIYgu6Oy16XRvBKGTFoK1ZjXD
 fZFo1jXuEIW9h20xT0pce8xshprQ67mn9xF5dNbYmHtkI4JGJmuVKkXanfo5haMF9obD
 iRuBnZblfuXuINcav+iy6Q0ed2BzLE9el8IcG8WtoqQ1Az4mXXoOGwYV0HcACD/EceSV
 qQ600TEaB9bchzKVqNowN4YUrLjyKYvB82GUhqm8x2+TRGt1bUKPcuL9Z4QR3PxvFr1v
 blYMXTrnBFpJKghL04SKQze1OCsycstAXPL0NdlO2g0PM4UMpGR9L3DOlA3pgspXhA/E
 jLng==
X-Gm-Message-State: AOJu0YwZWYvDKgjeKAeUZZDtxIWp2VSF1s5CscrZ3wsvPRp0Ko4qhtcU
 FRFPHl4xcMG1zjAbe3E1NWmTq7vAExDNMpY2inammK40ldMOJyMmSAroffpIekIthq4jiZmbLrz
 MZuKS7X47uyboM1+/2rUeW6SCmwFqFcBjVP3GdL2xEg==
X-Received: by 2002:a17:907:270c:b0:99b:40b5:1c3b with SMTP id
 w12-20020a170907270c00b0099b40b51c3bmr4298766ejk.57.1693495404939; 
 Thu, 31 Aug 2023 08:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqU32suFcax5N4zksCL5waYuwAr8trEmXcjLOBAuPXy6wP4BOWSV+IqSHWUR9lSPZ+Yzgs4w==
X-Received: by 2002:a17:907:270c:b0:99b:40b5:1c3b with SMTP id
 w12-20020a170907270c00b0099b40b51c3bmr4298742ejk.57.1693495404674; 
 Thu, 31 Aug 2023 08:23:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 l18-20020a1709066b9200b009930308425csm859467ejr.31.2023.08.31.08.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 08:23:24 -0700 (PDT)
Date: Thu, 31 Aug 2023 17:23:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [RFC PATCH v2 0/2] vsock: handle writes to shutdowned socket
Message-ID: <7byt3iwpo5ewpxkjwh6adlzq2nerrbv7trlreujuchsrkworxk@2jxzyul3o5cz>
References: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
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

Hi Arseniy,

On Sat, Aug 26, 2023 at 08:58:58PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this small patchset adds POSIX compliant behaviour on writes to the
>socket which was shutdowned with 'shutdown()' (both sides - local with
>SHUT_WR flag, peer - with SHUT_RD flag). According POSIX we must send
>SIGPIPE in such cases (but SIGPIPE is not send when MSG_NOSIGNAL is set).
>
>First patch is implemented in the same way as net/ipv4/tcp.c:tcp_sendmsg_locked().
>It uses 'sk_stream_error()' function which handles EPIPE error. Another
>way is to use code from net/unix/af_unix.c:unix_stream_sendmsg() where
>same logic from 'sk_stream_error()' is implemented "from scratch", but
>it doesn't check 'sk_err' field. I think error from this field has more
>priority to be returned from syscall. So I guess it is better to reuse
>currently implemented 'sk_stream_error()' function.
>
>Test is also added.
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=b38460bc463c54e0c15ff3b37e81f7e2059bb9bb
>
>Link to v1:
>https://lore.kernel.org/netdev/20230801141727.481156-1-AVKrasnov@sberdevices.ru/
>
>Changelog:
>v1 -> v2:
> * 0001 stills the same - SIGPIPE is sent only for SOCK_STREAM as discussed in v1
>   with Stefano Garzarella <sgarzare@redhat.com>.
> * 0002 - use 'sig_atomic_t' instead of 'bool' for flag variables updated from
>   signal handler.
>
>Arseniy Krasnov (2):
>  vsock: send SIGPIPE on write to shutdowned socket
>  test/vsock: shutdowned socket test

Thanks for this series, I fully reviewed it, LGTM!

Please send it targeting net-next when it reopens.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
