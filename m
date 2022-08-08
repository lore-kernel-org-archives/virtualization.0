Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EF9C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 11:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40E844089E;
	Mon,  8 Aug 2022 11:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40E844089E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUQ8vh58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WyJ4r1r8NMFj; Mon,  8 Aug 2022 11:10:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A1DD54088F;
	Mon,  8 Aug 2022 11:10:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1DD54088F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 769FBC0033;
	Mon,  8 Aug 2022 11:10:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1A4AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6DAB81CA3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:10:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6DAB81CA3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUQ8vh58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OXchC7MPNfzQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:10:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C20781BF4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C20781BF4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659957040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBe2fpdBGNWzcr6vXOzuBs2kJsMnU68Mt4pMY9LLh1w=;
 b=AUQ8vh58bF6brXuQHf/VM/9ltM8yOUOyPqHvMak4v9ejm8LiCMWVByEedyq1yaQSYGx2VH
 kCRIdm8mCbJLz99riM6fkhA3JDNbW915GxO9wNr76LLneTwR7Rae2m+Fn2nfEbYA2s9F6y
 ppM8kI1v+KcyF2i0sbp+1+58RFY6/OQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-X33Df7YgO9y_Wv-1cGM82A-1; Mon, 08 Aug 2022 07:10:39 -0400
X-MC-Unique: X33Df7YgO9y_Wv-1cGM82A-1
Received: by mail-qt1-f198.google.com with SMTP id
 ew4-20020a05622a514400b00342eed9a57bso3603014qtb.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 04:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=hBe2fpdBGNWzcr6vXOzuBs2kJsMnU68Mt4pMY9LLh1w=;
 b=TmxjcJzEr3HgX5TOyTaGBFO1l/pBg6h8i8ArwpPZ2m/oqkhMKmr8ls4U3LTKV9b//f
 yP/5aIuRFM48taoJKw+N4SZ0l97Ha+zMmwr0X0JEQOyzREQrVDpCqmPKW3uDKC1f68nc
 tgpZCfZBSQABIBhOno3ux+MThXLDvXJSAjd13VJKMHbZRC3t4i57++ry7RJ+fcyzqHJf
 PClYpvL3/RL3GugpjnTaySiBhlFuD2pFwbG/ClDSsHC6xw1K7E0Vcob/EcULYRJ6CPCj
 LwTA2i5D6g7mW5ZHoL9J5vdifk+QHwCAN1OIvYpFiWxZW954aP8CDDnAyxYb4IHcbp0f
 U+Ug==
X-Gm-Message-State: ACgBeo3Qnsf2EZe+OuqXqp49dIYRvmAloN3upY/sb5JJFlJiiihHEZc0
 /uL/0+o1S2giqza49t0oYBw7lFkzdfQfM9kD56jM5dYVYKwHbyNB+mAvl79YS2zMEE4wd6Jld1T
 jPYunbq6vWVulrxclfmGRv6SIlmHk+s9BxlVoc5ciXg==
X-Received: by 2002:a05:6214:5285:b0:474:69d7:c22b with SMTP id
 kj5-20020a056214528500b0047469d7c22bmr14912796qvb.97.1659957038983; 
 Mon, 08 Aug 2022 04:10:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ujYB7ib/RGWCUpFI4MR2ymD2ume/U+w9j2VF/0+QfSm3zys9i5QUsO2JwnpbewhemYJWtSA==
X-Received: by 2002:a05:6214:5285:b0:474:69d7:c22b with SMTP id
 kj5-20020a056214528500b0047469d7c22bmr14912769qvb.97.1659957038768; 
 Mon, 08 Aug 2022 04:10:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 u3-20020a37ab03000000b006b46a78bc0fsm1093912qke.118.2022.08.08.04.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 04:10:38 -0700 (PDT)
Date: Mon, 8 Aug 2022 13:10:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 9/9] vsock_test: POLLIN + SO_RCVLOWAT test
Message-ID: <20220808111027.nmreeuxa4jgn2e4t@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <1f50d595-cd37-ad61-f165-5632162dc682@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <1f50d595-cd37-ad61-f165-5632162dc682@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Wed, Aug 03, 2022 at 02:07:58PM +0000, Arseniy Krasnov wrote:
>This adds test to check,that when poll() returns POLLIN,POLLRDNORM bits,
>next read call won't block.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 107 +++++++++++++++++++++++++++++++
> 1 file changed, 107 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index dc577461afc2..920dc5d5d979 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -18,6 +18,7 @@
> #include <sys/socket.h>
> #include <time.h>
> #include <sys/mman.h>
>+#include <poll.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -596,6 +597,107 @@ static void test_seqpacket_invalid_rec_buffer_server(const struct test_opts *opt
> 	close(fd);
> }
>
>+static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>+{
>+#define RCVLOWAT_BUF_SIZE 128

Since we use this macro on both server and client functions, I suggest 
to move this define outside the function.

Other than that the test LGTM. I also ran it and everything is fine :-) 
thanks for adding it!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
