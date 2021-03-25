Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ADDC433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 09:43:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6849619FB
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 09:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6849619FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53C3B400FC;
	Thu, 25 Mar 2021 09:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9TGMcutGQA0; Thu, 25 Mar 2021 09:42:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE52E40146;
	Thu, 25 Mar 2021 09:42:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC831C000D;
	Thu, 25 Mar 2021 09:42:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98C85C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E722849ED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zrAVY02EP4_3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:42:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2C35849E9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616665374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iazG2kvbVV7z7jI0Hl0WMxl3hq3T9QCm0mrnWD6S1vM=;
 b=HZTTwqpzI5d25dA+u+5V1+FbZO0bikzsheye5w95tALiqhsMxz7v6633IuXdbfPj5LanJl
 SEOvIrzH0fPCep8L3dTPaDgwJ63xtOpmmDqozhrEbV9rcBZq0oNVNBl8g8PhGU76hbYYzj
 ntTA+Qs8qgwjyxUjcy0I/fEvZO0dqI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-9sSo3X7BMwO9S7Kyq4m2JA-1; Thu, 25 Mar 2021 05:42:53 -0400
X-MC-Unique: 9sSo3X7BMwO9S7Kyq4m2JA-1
Received: by mail-wm1-f71.google.com with SMTP id o9so1030347wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 02:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iazG2kvbVV7z7jI0Hl0WMxl3hq3T9QCm0mrnWD6S1vM=;
 b=jbLnZmb6aLn1bhp3kFbwtf6ifH+6BtxeIHQ4d8F0e/KXqQV720m/kve7/6HkOT1Q23
 rcgPih4ERNfm0NSR6uuCxGfuRkDuYHGPFgbFutzmDEXXy+I/jjcBa/a+1EHXGA973obd
 RlS40lSjU0d4gxJJJ1bxJcqkM7KUSQbBM7er+JuRihSAg80xPzr+qip4qkzH2WvUd+eF
 eHNij8piBfUeuG4vofkAmHEcc798CCGUExuyTIyilzKt5Xi5lny6a1X0NuDyLQN6vTMM
 x3jO1LN2dkTD409P5zWrzt85c0WdyGFgTz4uLCkTZpRJI4DjrxjjeUeV/gB4zlKMX+3j
 baJQ==
X-Gm-Message-State: AOAM5337MiOjLSE8bVvfPdnF2uKF/hF662ejXr8EvaOWd/iDKxpeyATK
 z4idAg5ZLTlN9qk0W/9ih9RXUiH96IO9eyd4cpCoF0rm9IdLq6swCocdAU80QUXYnsVlsLmYU4b
 fw9EySuPACK822u+PIzpTN1aOuvS69u0GdTqUAjdXcQ==
X-Received: by 2002:a5d:4e0e:: with SMTP id p14mr7877646wrt.64.1616665370844; 
 Thu, 25 Mar 2021 02:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmI0XTmVVlZKGjXd72cRR6QIqVv7OMV2LK555R2VZPMAHPAdbuj1iy4hwRCKLYd5iX47irTg==
X-Received: by 2002:a5d:4e0e:: with SMTP id p14mr7877623wrt.64.1616665370676; 
 Thu, 25 Mar 2021 02:42:50 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id j13sm7019686wrt.29.2021.03.25.02.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 02:42:50 -0700 (PDT)
Date: Thu, 25 Mar 2021 10:42:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 06/22] af_vsock: implement send logic for SEQPACKET
Message-ID: <20210325094247.np2hdgwzgcjpgsia@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131045.2460319-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131045.2460319-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Tue, Mar 23, 2021 at 04:10:42PM +0300, Arseny Krasnov wrote:
>This adds some logic to current stream enqueue function for SEQPACKET
>support:
>1) Use transport's seqpacket enqueue callback.
>2) Return value from enqueue function is whole record length or error
>   for SOCK_SEQPACKET.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v6 -> v7:
> 'seqpacket_enqueue' callback interface changed, 'flags' argument was
> removed, because it was 'msg_flags' field of 'msg' argument which is
> already exists.
>
> include/net/af_vsock.h   |  2 ++
> net/vmw_vsock/af_vsock.c | 21 +++++++++++++++------
> 2 files changed, 17 insertions(+), 6 deletions(-)


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
