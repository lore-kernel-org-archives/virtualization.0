Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD81C49EA2
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:54:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE842613D5
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE842613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96239404FB;
	Fri, 18 Jun 2021 09:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvyGwNp0FaTc; Fri, 18 Jun 2021 09:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 35B80400F2;
	Fri, 18 Jun 2021 09:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A406C000D;
	Fri, 18 Jun 2021 09:54:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8869EC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A12940200
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5p6tI8_y0fnP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:54:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A10C4400F2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624010057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y0YXDU9YxlQ+hNYdZgdqLVuT+mH4+43SSYjLUVicsFM=;
 b=TbOvBev+vxhKFZjuvvxvg+Fbs3Sji4FwvtwsR1U0wrBtCmmypgqSn/F1jh4olx6j6K86r8
 MQnEOxQfpPVErFzmN7GzMG2KfQ/nQNCgb1ldlvUb23foQZjGjbSEjpU3y0gp/A53dd3XuC
 j5kCR0GcqrMalSAQC7dYSTSTXJoY/T0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-rgTvvtmaPnC-5plNlP5bIg-1; Fri, 18 Jun 2021 05:54:16 -0400
X-MC-Unique: rgTvvtmaPnC-5plNlP5bIg-1
Received: by mail-ej1-f71.google.com with SMTP id
 mh17-20020a170906eb91b0290477da799023so3001332ejb.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 02:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y0YXDU9YxlQ+hNYdZgdqLVuT+mH4+43SSYjLUVicsFM=;
 b=irRYlx6oHY4RQYnii/Uz6fV748ps4Tfqb3wEElVpCa2uPIaxyd3CImWK38L3VMQXdT
 ulU8O8E2jbQfUpjEOhLVw8/nzh3JcpuuwI/08RJQwLHgGO0evHhqB/0ZXD1gc2ZfThtd
 mZ+04pEljBULQredGY7TS5N1UegSUKN378j6t3uS0t8DVtA+7dPrvBxXUlkBaXeM0krW
 Kihrk8gr3QKBaBLnKUzfin1TS23N1rIJALuDo+hRIsyhDz20p6ebOgYclwyM4O12r8f9
 5mdspCDo4/cqDk00tvu5z4ioBSJRDxbXqJjufSqT0Pcl8YkLTPAlw9MGI4cYvIERfELj
 ulxg==
X-Gm-Message-State: AOAM5324jqX9wOXNdd+KmcimZhBsH3yoafNi4Gn48hfG3MV3v69YTOus
 01XnarD01DxI8V6JAHItLBzlkdKk5ke/mTq2/OuRH9UVb7MIfGbq6oTGbw1Ewq3On9bIimRfEPa
 3Sku3zx8jmmTAWUXeCzqq8BNNKKPrqAyS83mwNqaHFw==
X-Received: by 2002:a50:c344:: with SMTP id q4mr813922edb.197.1624010055205;
 Fri, 18 Jun 2021 02:54:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWMR1bJzOfZ97L3/bNEKDwZD9gm2Oo2XE369CjGC2l9w0RaUVQn+dQb1wcWVE0CXQxEAZmHA==
X-Received: by 2002:a50:c344:: with SMTP id q4mr813911edb.197.1624010055087;
 Fri, 18 Jun 2021 02:54:15 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.252])
 by smtp.gmail.com with ESMTPSA id n23sm6101995edr.87.2021.06.18.02.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 02:54:14 -0700 (PDT)
Date: Fri, 18 Jun 2021 11:54:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [RFC v1 5/6] vhost/vsock: add kconfig for vhost dgram support
Message-ID: <20210618095409.q6s3knm2m4u7lezd@steredhat.lan>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <20210609232501.171257-6-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210609232501.171257-6-jiang.wang@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Andra Paraschiv <andraprs@amazon.com>,
 kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org,
 Norbert Slusarek <nslusarek@gmx.net>, jhansen@vmware.comments,
 duanxiongchun@bytedance.com, xieyongji@bytedance.com,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>, Steven Rostedt <rostedt@goodmis.org>,
 chaiwen.cc@bytedance.com, stefanha@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lu Wei <luwei32@huawei.com>,
 Colin Ian King <colin.king@canonical.com>, arseny.krasnov@kaspersky.com,
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

On Wed, Jun 09, 2021 at 11:24:57PM +0000, Jiang Wang wrote:
>Also change number of vqs according to the config
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>---
> drivers/vhost/Kconfig |  8 ++++++++
> drivers/vhost/vsock.c | 11 ++++++++---
> 2 files changed, 16 insertions(+), 3 deletions(-)

As we already discussed, I think we don't need this patch.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
