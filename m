Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8AEC4320A
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 11:12:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3536161245
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 11:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3536161245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3F1B4046F;
	Tue, 24 Aug 2021 11:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLA3L_0YVAR9; Tue, 24 Aug 2021 11:12:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 840D140482;
	Tue, 24 Aug 2021 11:12:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03EF3C0020;
	Tue, 24 Aug 2021 11:12:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9EFFC0010
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9840640482
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QTW8f5qA_6iQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:12:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CE354046F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629803538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sp6r3OzWSMu57KiEYb4z4Sr1QBf9aXwrMsxdCi+UL3c=;
 b=fwCFyyX7oRdu8peO+jSa1fiJRSfEjVyv0QWVpyGnXRq8rRBlwpUe141y3/LjRb3xfiiS93
 1qmxdpW05ocB8b84gSD4H3G+fvEBAixYo9nVjqbLwZfUw9Ph+T58iI5q7UTaGgLv6y/Jbi
 jCXf3IcpZhJv6TzxU3zoFqUmRwu3hFk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-7LqnVt7aM8-GbQ1EsTe5gw-1; Tue, 24 Aug 2021 07:12:15 -0400
X-MC-Unique: 7LqnVt7aM8-GbQ1EsTe5gw-1
Received: by mail-ej1-f70.google.com with SMTP id
 q19-20020a1709064cd3b02904c5f93c0124so6883343ejt.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 04:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sp6r3OzWSMu57KiEYb4z4Sr1QBf9aXwrMsxdCi+UL3c=;
 b=HD/5Q3o9wcZBJN/9wYz+Gxtv2LbkTRwJHbiJ+tJLjiLHd8gWybz9BJBsPIoffRQc7c
 UOK6ut8rDhcxE97iatvL88xusLT6q0ICJsLKKjkdXs4dZommjOrAFUjbCsZpI3MYbMj4
 ZrD4jGoVDJVbkYZ4sktqU/MX5aJ/F0Qg6UqB8NjRMVp8fZtuyY7a6VkoNIeZ56IxhZsg
 fVJPV2bamCF2R8uidkFwgQw8MhR3jxwZqgfJLcc+CbfIOzA0i/tZgHeXd5xpaFjsu50u
 yhQboHS1LnQVVa48v6X8yOExrVtfcy0b9KFMPnx9n9jFj8zzrN85KJAzf5d6MzLdzLpw
 nSvw==
X-Gm-Message-State: AOAM532PYkK/XyFPskWGvnS9cJe4f80hb0lOBwXLUORpSP7X5FUsmd79
 zYzoDuP5YZIAql7C3Ph1zm+fcJUD8MOtf9YuMdwbC26n13vEmqYb9RAwWWhPM6A7ys2skUgL4x6
 Ky5ZaoI+RNpBABFUlnRUw99DDUDanDuX6vl/YK2hU2Q==
X-Received: by 2002:a17:906:1701:: with SMTP id
 c1mr40193385eje.425.1629803534057; 
 Tue, 24 Aug 2021 04:12:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDklZBFBy5QnXrgs3+cqOF2EU5CCgdvdd15GqRk67R8P3Nj6qlQx0g2cCYgrph1uoICqAc7Q==
X-Received: by 2002:a17:906:1701:: with SMTP id
 c1mr40193358eje.425.1629803533933; 
 Tue, 24 Aug 2021 04:12:13 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it.
 [79.45.8.152])
 by smtp.gmail.com with ESMTPSA id h21sm331619ejb.101.2021.08.24.04.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 04:12:13 -0700 (PDT)
Date: Tue, 24 Aug 2021 13:12:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 05/12] vhost-vdpa: Handle the failure of vdpa_reset()
Message-ID: <20210824111207.ppvop52hyq5xyny5@steredhat>
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-6-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-6-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 dan.carpenter@oracle.com, xiaodong.liu@intel.com,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, joe@perches.com, robin.murphy@arm.com,
 mika.penttila@nextfour.com
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

On Wed, Aug 18, 2021 at 08:06:35PM +0800, Xie Yongji wrote:
>The vdpa_reset() may fail now. This adds check to its return
>value and fail the vhost_vdpa_open().
>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vhost/vdpa.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
