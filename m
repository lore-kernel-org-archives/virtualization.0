Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89750C47080
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 11:06:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B16611CB
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 11:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B16611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC2F840233;
	Tue,  1 Jun 2021 11:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kn7H6a6x5DB5; Tue,  1 Jun 2021 11:06:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 83D14400F6;
	Tue,  1 Jun 2021 11:06:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55E2BC000E;
	Tue,  1 Jun 2021 11:06:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D94F2C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 11:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8EC040233
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 11:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YEO7I2zN-GBk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 11:06:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EB56400F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 11:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622545610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aaASPp3wsnjRSRxwYNnrbRgJnT5vvPPdfGvm6PNwdHA=;
 b=KPfK2bGq+PG6tXPU+SV56oltBQLhYSgFpoNvNYfNsxLofYjmOK9DD0TlYNw7B4WTYJ/B9S
 WfqRWRZ8Z8tq73q4jg3k9E6RzVx+uotC1pzl26epzpmjE4HOl9ktO8ITJvZDHQU5cZ3FJE
 MowZgpeOLTnsNTrzmZvGn0vmIIl7+CQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-56BQdacxNZysPj58JkZldw-1; Tue, 01 Jun 2021 07:06:49 -0400
X-MC-Unique: 56BQdacxNZysPj58JkZldw-1
Received: by mail-wm1-f71.google.com with SMTP id
 f13-20020a05600c154db0290195f6af2ea9so313936wmg.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Jun 2021 04:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aaASPp3wsnjRSRxwYNnrbRgJnT5vvPPdfGvm6PNwdHA=;
 b=E9Mq+aiuhjhS/13Uh4Mqpr8YZYWM0TiSQm35hgfKC4fiPZCDbTBhpch8nlnOYxUd1y
 OhNfHrcXOVfLpgLuiCX8RDLY7QkOiLXDmiMN21JLLEBa/JauHRzgzFbqjov1jAOO9+xg
 f30S2X1ICDRzMcgA30lKiLR7yMcb+XBbz0W6NoNf1MkADYo/a6SJx+0e06OEl+az/nYr
 yUhII5X0Xw+DUEFxbLSnKA2MWedM0zKjZvAYJaz+d8N9UWtjQbJlD2foDrppdLGSCsoP
 yPjX/aSsXzgjVGc0WcxyC+tq0IhPVLUBcAHOHSF3uLPjkrDOEhh4KedRBcZujrxzspLI
 sG8g==
X-Gm-Message-State: AOAM530R1W/yZG7pVF5lcRIQoon9U7xxwjkq02UOn7BIv2SKyJ637/zY
 kYkjGMryVLyPy4cGGCukonKa19pXq433Vdz4qtC3ibVFY5UML0/gdESmye/6OitakNKA3eV/mR/
 yeidRCILI2VLrEV2WrcODi3Eg8m0nYYpCODmy/V6/3A==
X-Received: by 2002:adf:c38a:: with SMTP id p10mr13213653wrf.138.1622545608107; 
 Tue, 01 Jun 2021 04:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxse7H7NC7uKSyVhO6tqCkb28FmQf5X8G+WwPdEHDAGaDn6G2Zi6zozpeSFKQlrGMyxGwqDxw==
X-Received: by 2002:adf:c38a:: with SMTP id p10mr13213630wrf.138.1622545607887; 
 Tue, 01 Jun 2021 04:06:47 -0700 (PDT)
Received: from redhat.com (line103-35.adsl.actcom.co.il. [192.117.103.35])
 by smtp.gmail.com with ESMTPSA id o17sm2656386wrp.47.2021.06.01.04.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 04:06:47 -0700 (PDT)
Date: Tue, 1 Jun 2021 07:06:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 0/2] virtio-net: fix for build_skb()
Message-ID: <20210601070610-mutt-send-email-mst@kernel.org>
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Tue, Jun 01, 2021 at 02:39:58PM +0800, Xuan Zhuo wrote:
> #1 Fixed a serious error.
> #2 Fixed a logical error, but this error did not cause any serious consequences.
> 
> The logic of this piece is really messy. Fortunately, my refactored patch can be
> completed with a small amount of testing.

Looks good, thanks!
Also needed for stable I think.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Thanks.
> 
> Xuan Zhuo (2):
>   virtio-net: fix for unable to handle page fault for address
>   virtio_net: get build_skb() buf by data ptr
> 
>  drivers/net/virtio_net.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> --
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
