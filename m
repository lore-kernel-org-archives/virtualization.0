Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F7C2B9F8
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 14:17:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67CE613AB
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 14:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67CE613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DA7E83C83;
	Tue, 25 May 2021 14:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eOmPgksCBZtG; Tue, 25 May 2021 14:17:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F61983C6A;
	Tue, 25 May 2021 14:17:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27EC4C000D;
	Tue, 25 May 2021 14:17:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58FA8C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3320883BF8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmyc2QoedgJA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:17:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C32C83C6A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621952237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qs8EjzEOCz++s3CVPlPwuFgTHOtbAQXpJzzRW8nZD74=;
 b=TW9/8YZGM1mkLpvflD0gLSzJo0S08hykkvXHS8Y/a6g5y2bdP7K1ZCdigy7jtSSuyCLI46
 xmqIdEh7N3JcHJtMifJS8gK5nd6z9VglULGGkt4UCBCg3gIgimPpG+2UysuiSJzZaxqF5z
 1d8DV2Y3ZOK42DNtLtP2vpyzfRkgf1Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-MZnD_1SANz2ZXouJ0vYdhg-1; Tue, 25 May 2021 10:17:13 -0400
X-MC-Unique: MZnD_1SANz2ZXouJ0vYdhg-1
Received: by mail-ej1-f71.google.com with SMTP id
 k9-20020a17090646c9b029039d323bd239so8817210ejs.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 07:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qs8EjzEOCz++s3CVPlPwuFgTHOtbAQXpJzzRW8nZD74=;
 b=SdCyKnIksH14nKcGWoYmsRi72Yafcue80H1XGyyA+COzSOrCl8QMh5WnNdr8U1Jac/
 swO+oGUNO613UDON+hIVKUAErZXE08n++Wzxp/mfi57qp9sC9z/jg0vEB6v2eCmTdtzh
 C0T6LaJcO25/ZbUPrmnZdBJrv2xdEAOTxl78ppQYuyqW88CKvO2l/7ZYjh3S/NLJIaZc
 uJ4iWyHCvrclp2zixjl7w+6kjzhn8U5W6RZMTlhBMX9Db1NtxvNFX0QrabRsUGYLMA97
 56dZpLIdRuS9HtwRq5WVEuZCZdlE2jJmjZhnF9eskNZF3kkm+AAQXZLr99BO/gEm/5uy
 VvqQ==
X-Gm-Message-State: AOAM533fdccLToMa/e5bXQctHGjiRofmQw3qXQK8raZQcn1nitzQkzTl
 lax0IxoSwmCeFj1KLmijm7KhMopUdHLBFQJv6ukjxLLTTaQ1lWQyXYbsQeQ4k2n8yYI6jQCOogr
 zRy8EjtkpWBWwWcyeH9veW73xZuVDfoz87Qs1l0CsjA==
X-Received: by 2002:a05:6402:190e:: with SMTP id
 e14mr32337346edz.146.1621952231503; 
 Tue, 25 May 2021 07:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFKL2as0znk9EfRE37BQywDQJb+X3ks+d5tVQoRqTJJqOiRkyF4ZCUMGJz3wAnrUijDO8n7A==
X-Received: by 2002:a05:6402:190e:: with SMTP id
 e14mr32337320edz.146.1621952231368; 
 Tue, 25 May 2021 07:17:11 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id bv17sm9143813ejb.37.2021.05.25.07.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 07:17:10 -0700 (PDT)
Date: Tue, 25 May 2021 16:17:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 06/18] af_vsock: rest of SEQPACKET support
Message-ID: <20210525141708.nklo776yq2nnhju7@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191639.1271423-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210520191639.1271423-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
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

On Thu, May 20, 2021 at 10:16:36PM +0300, Arseny Krasnov wrote:
>To make SEQPACKET socket functional, socket ops was added
>for SEQPACKET type and such type of socket was allowed
>to create.

If you need to resend, I think is better to use the present in the 
commit message.

Maybe you can rephrase something like this:
"Add socket ops for SEQPACKET type and .seqpacket_allow() callback
to query transports if they support SEQPACKET"


>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 36 +++++++++++++++++++++++++++++++++++-
> 2 files changed, 36 insertions(+), 1 deletion(-)

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
