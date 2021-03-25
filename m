Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CFDC433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:48:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F9361A28
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F9361A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C8B140526;
	Thu, 25 Mar 2021 10:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8xTCJqB1Itc; Thu, 25 Mar 2021 10:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E71740182;
	Thu, 25 Mar 2021 10:48:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05AABC000E;
	Thu, 25 Mar 2021 10:48:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F71BC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E470C84A00
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AA0lt0ISJdii
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:48:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2E3C849F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616669310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uG7Xvxqmhobojsj5OJqFrV/WCwv8p+ZZ6c7WsrWCTcI=;
 b=KS0gk0hRyMzGAmOBRIoG/Uj1YuCiU27q5uztHdVGzTtdyzMC44Iw3XzjLPv8lodJlBqvqy
 nTabUFIeKnDlk7+XMD/2h5TSR/3ra82T5ApVWi4yCeZq/1h/e8c6Ti+/WZQ/MSHJFpCs3V
 zBunUTp6c+04sCSnyU3dvnCYGnoUetQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-xzu8aLVbPqexWvfci_hV6w-1; Thu, 25 Mar 2021 06:48:28 -0400
X-MC-Unique: xzu8aLVbPqexWvfci_hV6w-1
Received: by mail-wm1-f69.google.com with SMTP id a63so1092685wmd.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 03:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uG7Xvxqmhobojsj5OJqFrV/WCwv8p+ZZ6c7WsrWCTcI=;
 b=DQnxPizz7Dbq1W5gduoLMOgHqh2xpUiRGg21RQmWKjy99Y2jX4hHRnpRmJPLzqhU7J
 4zLV4deCCoAM3o03ee3ZSh/4laLcwPtI07KFgk/yaXI4E+X0h8uUIsUsGYWqV85mwnCZ
 kJtATT7MG8iZD+g/7dJNXsoo9Vc85TBMv2qx9v1D5r7Aa6m+SQXY2saIjZhptFNXA2Ol
 unBntYf/jNzuOBjeF+Ox2Lq0kzzMbB6fJCjpDeeHmHg12NIYgB/3W0s6k5RqUdDIpkx1
 utNrEvRQ9dL4cXBazGalfjogInbplXX0vfsRXkHBkcrJkZYhKRJKYWBoWJ4ZAOpq3wzq
 4s+g==
X-Gm-Message-State: AOAM530pVHPjZM7ZQgX7Am1mpHM+wDtWiUFiNqHXz+kIVDNpfyoK9WND
 bF5CiBqgB9hHXE5v8u9sZouGFJjdarbqQlPJZ7y+Wor+qjuLrxqCRvfyI+vctbE6mTw4qQSHmC8
 6cuhrKkJOQW1nUj3JlPMwSQILmEfgSyMYAKG6/Oibcg==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr6830191wrq.357.1616669307627; 
 Thu, 25 Mar 2021 03:48:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwba4i/cNkvyGHe1MXcfBoFDQppd2SFKpM4+Idmc3yl4RPx5YeZV2q+XoHVidJ3th6SnvpH1g==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr6830170wrq.357.1616669307472; 
 Thu, 25 Mar 2021 03:48:27 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id x23sm5818233wmi.33.2021.03.25.03.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 03:48:27 -0700 (PDT)
Date: Thu, 25 Mar 2021 11:48:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 18/22] vsock/loopback: setup SEQPACKET ops for
 transport
Message-ID: <20210325104824.josycnluwxehuxhn@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131436.2461881-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131436.2461881-1-arseny.krasnov@kaspersky.com>
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

On Tue, Mar 23, 2021 at 04:14:33PM +0300, Arseny Krasnov wrote:
>This adds SEQPACKET ops for loopback transport and 'seqpacket_allow()'
>callback.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/vsock_loopback.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
