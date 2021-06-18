Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1730BC48BE8
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 13:51:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30E960E09
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 13:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30E960E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C5B84020E;
	Fri, 18 Jun 2021 13:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oqESj7W591-e; Fri, 18 Jun 2021 13:51:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 329FA400F5;
	Fri, 18 Jun 2021 13:51:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 151C8C000D;
	Fri, 18 Jun 2021 13:51:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18595C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06ADD4014A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lj9MvY6cXXKx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:51:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C294400F5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624024313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4m43haMZkXo+6dMXFc2UeeK5bFqrx7krUnKM0CcDLn0=;
 b=YDGsMz+aYbC9Y8bemDniYqdmf8hii4zbdxoZby2JrQyv1RPCwAY2IOBvsQ86wf1chCVAoq
 tKqDp7Wb0s1blD0V+VcmIoyMaYhaCwQMDVEpr64P9Rql7zHLRTncYUp+lxHWHwIuIkE2LC
 VRh0SRlJHGBvlCPIVEp72MXiHbuiM1A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-AJQot-UCNQ2q_tsaIjpe1A-1; Fri, 18 Jun 2021 09:51:51 -0400
X-MC-Unique: AJQot-UCNQ2q_tsaIjpe1A-1
Received: by mail-wr1-f72.google.com with SMTP id
 b3-20020a05600018a3b029011a84f85e1cso261309wri.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 06:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4m43haMZkXo+6dMXFc2UeeK5bFqrx7krUnKM0CcDLn0=;
 b=tkACQ1OWOe+daTZhYSbg0KV5uo8bOByMMxBXE3k34eUWLX6wQngwzar6r7TFdrNhgz
 rFkW/eYtG3i2pZFqpPCERBc7rOofF3ra+haPTntdxYo+/QfcmDBMlUKM0v9o2xpo2nwU
 yzfmo2Q6st8Ts7zJlUnl9XznkQccFQJKc4jqHPY4nGJZSBoZzyuLtl1yxqty4rN4vSaQ
 dkHHMw67cNwZF5n33NRqIl+wJm8dLt2eHRFL8TComocLbLpfIJPoAzwtrrYFZur/SvJZ
 hdSJMfzz4J9vv+wn0In+48T46NmV2oWAszxra37Lvcu7Hl+37rU6PMmtPNLBVq1QlMnV
 nDbg==
X-Gm-Message-State: AOAM5332I5mq8dhZ58eopie+6+WcpaDVfVSUySFStEbqyBq5O51K49lh
 cQ4C6vqzQN9Lo07zJ7DBtx4N3+cQVIqEyjxypsJnHn/tg6L/mfjBkM1I91NmTaSngYFvCymURyy
 LnZr9UszeKQA61NphCMxLvu6osgRklnbKzRfFAmalFQ==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr12960559wrw.41.1624024310549; 
 Fri, 18 Jun 2021 06:51:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqJ3GZeW6jRvmnJbJ7b1ZhOousWSFHH5OW+Xxp1vDn8d5uUTDBmjRCWu6e4mCUYbWrxf7YAw==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr12960548wrw.41.1624024310425; 
 Fri, 18 Jun 2021 06:51:50 -0700 (PDT)
Received: from redhat.com ([77.126.22.11])
 by smtp.gmail.com with ESMTPSA id b11sm8767138wrf.43.2021.06.18.06.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 06:51:48 -0700 (PDT)
Date: Fri, 18 Jun 2021 09:51:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v11 11/18] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210618095006-mutt-send-email-mst@kernel.org>
References: <20210611110744.3650456-1-arseny.krasnov@kaspersky.com>
 <20210611111241.3652274-1-arseny.krasnov@kaspersky.com>
 <20210618134423.mksgnbmchmow4sgh@steredhat.lan>
MIME-Version: 1.0
In-Reply-To: <20210618134423.mksgnbmchmow4sgh@steredhat.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jun 18, 2021 at 03:44:23PM +0200, Stefano Garzarella wrote:
> Hi Arseny,
> the series looks great, I have just a question below about
> seqpacket_dequeue.
> 
> I also sent a couple a simple fixes, it would be great if you can review
> them:
> https://lore.kernel.org/netdev/20210618133526.300347-1-sgarzare@redhat.com/

So given this was picked into net next, what's the plan? Just make spec
follow code? We can wait and see, if there are issues with the spec just
remember to mask the feature before release.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
