Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51383C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C9665005
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C9665005
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4BC743063;
	Fri, 12 Mar 2021 15:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsLxI05Lf6YX; Fri, 12 Mar 2021 15:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 66CC94303A;
	Fri, 12 Mar 2021 15:33:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD88C000C;
	Fri, 12 Mar 2021 15:33:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53CA2C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 347C643049
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:33:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5w2YD2_arRrF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:33:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7ECEA4303A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615563197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EGb6AXgwl1nr5zRdbpARNJm/jkKcLJumJXwWNk6t/ZM=;
 b=WD5Yyby3iB+3ldmbJyAiniGsu3Is0/O0a8kkfQYpb2GQ2WmbSo1wYrODQb4MILWnB2dP/A
 793OSQDQB0oSR1gOWUr8CIsnnyeOWs4hIUT3z3hF4NtPgVIpijVsKWdOnUBjMOgeyp7Tdx
 DJLVr/uxqYSO/yHpmvRquVU/7Uy/j30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-4Rs4Cl5kPpiuad6AI6EmEQ-1; Fri, 12 Mar 2021 10:33:15 -0500
X-MC-Unique: 4Rs4Cl5kPpiuad6AI6EmEQ-1
Received: by mail-wm1-f71.google.com with SMTP id r18so5474956wmq.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EGb6AXgwl1nr5zRdbpARNJm/jkKcLJumJXwWNk6t/ZM=;
 b=QiZ5pNizVF8SNgG0j80AzUhaLsi2+5sqDSbXABuwnng0uimbGhHq4PuPrV7B07W+gw
 hCHKG+jSJBHAIwS+1/WKDnPUOfrQt8nwx03bHXuxCaer6hsc6WuvSQ80BN0wYKeB5Pbs
 npg5VK3u7RVWtGhzw7cMv0e+9Fwv4SsEph6f9whzSL4fRSPOmpK5tnAHarHFkfDzdOFo
 Iw0MxuhN9C535CUnPR3OeG6YY2tp7OItGrh/EMi2a7qf7N5/IoacG1w94CSH1wiO/fuc
 50IcaJGM+lQcbvfGh8TsYV6KDXS5BrkManbUDorFCYiaZDsYIfOmgW1xLvO+tDaibbBZ
 dVxA==
X-Gm-Message-State: AOAM531bio0WSm+XGmDVqTzgVj4SKQd0NO61eCYKvq/cPto21D+3sNcJ
 C4sAYrf0ZLBqbhi82QmRVi2sdxXT40KRK+IrSvajm86Q3GbCSva7rmNehKR7TLlxi609sGHPFmG
 LT41BdOu3UP0pn6ehwmdK1BE+krSO8xk/FATxKdC6Zg==
X-Received: by 2002:a5d:6602:: with SMTP id n2mr14787234wru.262.1615563194406; 
 Fri, 12 Mar 2021 07:33:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1RDUTjqMib142hX4+22hYQB63u70C7eZFaAyLkKWSCQkvVf0EtQUYs3f0XWrxZzKygWvWQQ==
X-Received: by 2002:a5d:6602:: with SMTP id n2mr14787212wru.262.1615563194209; 
 Fri, 12 Mar 2021 07:33:14 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id e8sm2440515wme.14.2021.03.12.07.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 07:33:13 -0800 (PST)
Date: Fri, 12 Mar 2021 16:33:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 10/22] virtio/vsock: simplify credit update
 function API
Message-ID: <20210312153311.4vfhrb7aqhfqmokc@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180147.3465680-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307180147.3465680-1-arseny.krasnov@kaspersky.com>
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
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Sun, Mar 07, 2021 at 09:01:44PM +0300, Arseny Krasnov wrote:
>This function is static and 'hdr' arg was always NULL.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
