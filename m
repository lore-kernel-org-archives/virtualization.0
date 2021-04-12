Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE5C43461
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 12:00:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AF36135F
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 12:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AF36135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 250054035D;
	Mon, 12 Apr 2021 12:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hj4DXNLo4_c; Mon, 12 Apr 2021 12:00:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A18684032B;
	Mon, 12 Apr 2021 12:00:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DA4FC000C;
	Mon, 12 Apr 2021 12:00:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6501AC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 12:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4249F607AE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 12:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2N5OsNP1Y4PS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 12:00:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78190605BB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618228832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fqhV33RkbsMbtO9g46LNef0TvFJ+Oo49emjwqgVWPXY=;
 b=WCoBJ9ww9/3t1COXjbh1ibLY0xm8m4VvGPrvoE4Fe00mYEYYwbiOwNSdf6EygTzfkkxkeg
 bnDrVvz8fxf65GJcKuUtItHgm20jqe8fLBkkq9WxtgNLJ9vnAC1l/cQGQ9fDfJvOKIn3qL
 69JhbZezDctcg3njJEZskD2azAMx0A0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-bDq7BQc2N7utIsr1WzJudA-1; Mon, 12 Apr 2021 08:00:30 -0400
X-MC-Unique: bDq7BQc2N7utIsr1WzJudA-1
Received: by mail-wr1-f71.google.com with SMTP id n16so500721wrm.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 05:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fqhV33RkbsMbtO9g46LNef0TvFJ+Oo49emjwqgVWPXY=;
 b=n60QrSw+UEKlgMKXNhO2eIa45G+7Or63chvYY4xnFk61IBWdFZinpShhVGv7DSgNYq
 k+QbkzCkw7vdDFWwhmEx9n2tvquOW+rcLB8W+X6MtqfKUy/VwMONtlnRPjaxtLL/s+WB
 IWXkrBXP7lHQv4r+YmI30VaWm4VABuhCMzrzL7T7OO7fl0ZXOXt1HtL6NDoNM3efNKnm
 g2oKS7995qI+c0VI/2tD5SmRF2rmFfmBJLPJkuypPoTORXF7FsEL6BQO0IseLAynYaZy
 dKtWVYmSzEBiDmm5NbygOOIs+dZs4pLg4PUo5YqZJz3zPE/doqBBTwY+1TzuLH8GuqBr
 ggyg==
X-Gm-Message-State: AOAM5336EaU62f0VgI18ARsEQDSq0V7HXKvUZCCvjrDcenB4VKHdT01m
 N4Efnxel03RShLdj3+JKbPAEmCK7s2y9Ib7oxTF8a71kolLzzDzRs+fiUqw7hY82sOdf3+EzY8z
 jDElUCdxuamlUVEmtVz/F+pzT8vGMhRfMe004IyIYXg==
X-Received: by 2002:a1c:2985:: with SMTP id
 p127mr21710529wmp.165.1618228829093; 
 Mon, 12 Apr 2021 05:00:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2SCE8sMznZG6rxO4GSbL4qQt0Uw6bMoyj3GCEYG1byM8BieOAw3WLYqRj7PoobgERMieckw==
X-Received: by 2002:a1c:2985:: with SMTP id
 p127mr21710521wmp.165.1618228828984; 
 Mon, 12 Apr 2021 05:00:28 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id j14sm16118383wrw.69.2021.04.12.05.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 05:00:28 -0700 (PDT)
Date: Mon, 12 Apr 2021 08:00:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] virtio_blk: Add support for lifetime feature
Message-ID: <20210412074309-mutt-send-email-mst@kernel.org>
References: <20210330231602.1223216-1-egranata@google.com>
 <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
 <20210412094217.GA981912@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20210412094217.GA981912@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 Enrico Granata <egranata@google.com>
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

On Mon, Apr 12, 2021 at 10:42:17AM +0100, Christoph Hellwig wrote:
> A note to the virtio committee:  eMMC is the worst of all the currently
> active storage standards by a large margin.  It defines very strange
> ad-hoc interfaces that expose very specific internals and often provides
> very poor abstractions.

Are we talking about the lifetime feature here?  UFS has it too right?
It's not too late to
change things if necessary... it would be great if you could provide
more of the feedback on this on the TC mailing list.

> It would be great it you could reach out to the
> wider storage community before taking bad ideas from the eMMC standard
> and putting it into virtio.

Noted.  It would be great if we had more representation from the storage
community ... meanwhile what would a good forum for this be?
linux-block@vger.kernel.org ?
Thanks,

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
