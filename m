Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B908C433B4
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 14:04:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDC061463
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 14:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDC061463
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0369183C60;
	Fri, 14 May 2021 14:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n3m2xbrUluOQ; Fri, 14 May 2021 14:04:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B872783C52;
	Fri, 14 May 2021 14:04:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9432DC000D;
	Fri, 14 May 2021 14:04:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BF3CC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 14:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8867883C52
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 14:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G8-tb-o2R1-Z
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 14:04:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A84E83C49
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621001083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=is4w+TCn3msJ9Lv2hnDIZ3A/ae5d78m5BGbhOBjRDwM=;
 b=BS5Ujx69U2GrtCwJEcYwhJX7xD3G6yPIAUghVI0AFElZaTG6XBepLWE1Ro1nYNNa+6xnHP
 qaKidnK+ywDFT/+PIJkOjiblofaZftWXJ6SpXbgNblvAfeJNX0a/wJrAb9KL+rleoRr04V
 8LVZjrGSKor1CVe5UzOFPpPS/e0Uq/0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-ruipKY_iPyy_eH090pAdWA-1; Fri, 14 May 2021 10:04:41 -0400
X-MC-Unique: ruipKY_iPyy_eH090pAdWA-1
Received: by mail-wm1-f69.google.com with SMTP id
 129-20020a1c02870000b029016fa2bab83bso1115149wmc.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=is4w+TCn3msJ9Lv2hnDIZ3A/ae5d78m5BGbhOBjRDwM=;
 b=DR/Ym374GTTbZRsYcpQ1U34vehQUK2OOfvPq1HuVfVtH7dbYf8y+CLedto19nYWwY0
 FM6+9uMoFv1t0wfb1CMW+7FXs7KTGvImNwzWCCjwb/RcaVS5Ozee5OYXVLlRraWLUwQo
 S5D0avPFbrZ6fiYaCgQfBD8inWBAEMcJSna25G2Gyz/M+/KW9ldTKgwfBY06MYcjLBRq
 4eiQEp77LaQUatZ2vgfqOBKmCNOEXkQDCmUuCu3TQz5lhmO3gE225slzwZ4MCtbuwDGP
 R36BoKIuMb5ka75llHaAqbHLdAVnJJIe2XvN/f62FEvUYikAucpPWYhj6K612ZM20Lf9
 hM5w==
X-Gm-Message-State: AOAM532tH/2HXinI03ZX3VN3F8AYTS9HiM6NsRtrC1HAQo6KcntqI5ED
 BGq50UUShqXpZy9SLCQuEp777DK/KMX9mJmcx2bMLmH8+lfWGp2RrnYHA9BxwVJtQA9TZlmCGO8
 pACyCqmtjdwE/z4yttjgrRjAuKPOmzIjF9UvLggLZGQ==
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr23646432wrt.95.1621001079448; 
 Fri, 14 May 2021 07:04:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4iA/HgadsB2lsRId4OOvBGpKAqwH3PMIW7YVjgLLNeMDpfssFX4UIjarUvAw16XstGk4aKg==
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr23646401wrt.95.1621001079232; 
 Fri, 14 May 2021 07:04:39 -0700 (PDT)
Received: from redhat.com (bzq-79-181-160-222.red.bezeqint.net.
 [79.181.160.222])
 by smtp.gmail.com with ESMTPSA id f13sm3003855wrt.86.2021.05.14.07.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 07:04:38 -0700 (PDT)
Date: Fri, 14 May 2021 10:04:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net-next 0/2] virtio-net: fix for build_skb()
Message-ID: <20210514100326-mutt-send-email-mst@kernel.org>
References: <20210513114808.120031-1-xuanzhuo@linux.alibaba.com>
 <162094681137.5074.5504584757048483865.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
In-Reply-To: <162094681137.5074.5504584757048483865.git-patchwork-notify@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, hawk@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, virtualization@lists.linux-foundation.org, kuba@kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net
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

On Thu, May 13, 2021 at 11:00:11PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (refs/heads/master):
> 
> On Thu, 13 May 2021 19:48:06 +0800 you wrote:
> > #1 Fixed a serious error.
> > #2 Fixed a logical error, but this error did not cause any serious consequences.
> > 
> > The logic of this piece is really messy. Fortunately, my refactored patch can be
> > completed with a small amount of testing.
> > 
> > Thanks.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net-next,1/2] virtio-net: fix for unable to handle page fault for address
>     https://git.kernel.org/netdev/net-next/c/6c66c147b9a4
>   - [net-next,2/2] virtio-net: get build_skb() buf by data ptr
>     https://git.kernel.org/netdev/net-next/c/7bf64460e3b2
> 
> You are awesome, thank you!

I actually think this is a bugfix patchset and belongs in net, not
net-next. And maybe stable? For there

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
