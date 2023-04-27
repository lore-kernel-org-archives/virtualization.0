Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2228AC77B61
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 06:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95F3983C7C;
	Thu, 27 Apr 2023 06:56:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95F3983C7C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YYq9t+2y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8YvHMwJoJt1T; Thu, 27 Apr 2023 06:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D08583C7A;
	Thu, 27 Apr 2023 06:56:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D08583C7A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00B1BC0036;
	Thu, 27 Apr 2023 06:56:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A79C7C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 06:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F01883C7C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 06:56:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F01883C7C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SD0DJWFpS06x
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 06:56:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AF0C83C7A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AF0C83C7A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682578562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRH+mkm7wTLmUFms37x8ndQ9a+fMCIyXg2Z2DM7enPw=;
 b=YYq9t+2yJL7uXWg8+HFlMWwInP8Cxcke1inQlfDwxNy59TqniGm+rLGzv/vyWB2/gKoajS
 QnnMz23ecVJAoGYd36+XrH3nXlf00X40wIssrmOXPHmfkHr2b/cdWT2E9KYvJ88+p9MRIo
 o+BWN1tKBK6kIV6OscNmlR1PXT3rdFI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-l1Svhd9IOlyJW2QtVfWelw-1; Thu, 27 Apr 2023 02:56:00 -0400
X-MC-Unique: l1Svhd9IOlyJW2QtVfWelw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3edbe09ba35so12425551cf.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 23:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682578560; x=1685170560;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fRH+mkm7wTLmUFms37x8ndQ9a+fMCIyXg2Z2DM7enPw=;
 b=W+7cnRszaKyYLYUp6Hyq4r5XQXpCUQsWnr3S8tPX5BFXN/FDByGfJjKEQsGZLb9asg
 VsNhn+S+AziU0BkX2D/Vk9zT/QNkZOM8tbeWIdPbyQ37EPkOZbMQZsLqVOth9Vjpqv0o
 TdXWUWA7aO0onCMxpDvYfLiB6vnHkUdWGYpJzwhL/6116NY+14mU7kNVNFQMfgLHrpJ1
 uSAlKRpSUA8WqUQQyAakk8/yNXxypD55lwNpYtABj9fP6oSks5bTeDXV+1AdU4fRsw0t
 ilRPSQg/0c3b3YwBFrSLtQSqZGrK/Nn+RkBGQlWq5RZrJNbozAiRK2Ar/j9jdLXY6g8C
 P/Qw==
X-Gm-Message-State: AC+VfDw+zGq3S3NFi5ldLWssMsSeKkN8XT7s34FOaxAfRYgmhw0IM/Uw
 rl1W6OPeT+4ruE8eePASzwYGbRZp0chDCYVpCqiEKJzsch1BBoBypAp2Q5HFsoRarKH8R7+jXJr
 AgS9UMdXwXwY8x4N1J1livdiJYEjTDDp7dY/5HfXzmg==
X-Received: by 2002:ac8:5dcf:0:b0:3ef:59e8:511f with SMTP id
 e15-20020ac85dcf000000b003ef59e8511fmr785050qtx.0.1682578560119; 
 Wed, 26 Apr 2023 23:56:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IY3ISX9/AZqFDTs3717bAYMzWirNzdAR5uENXzS1qvlBOt1T2Rd78y8VkeDq5U7JJzU09gw==
X-Received: by 2002:ac8:5dcf:0:b0:3ef:59e8:511f with SMTP id
 e15-20020ac85dcf000000b003ef59e8511fmr785030qtx.0.1682578559886; 
 Wed, 26 Apr 2023 23:55:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-21.dyn.eolo.it.
 [146.241.243.21]) by smtp.gmail.com with ESMTPSA id
 pr1-20020a05620a86c100b0074ced3e0004sm5723165qkn.63.2023.04.26.23.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Apr 2023 23:55:59 -0700 (PDT)
Message-ID: <b3eebbb01a6ba370458e17cc9fa1cb80693b0f34.camel@redhat.com>
Subject: Re: [PATCH net-next v4 00/15] virtio_net: refactor xdp codes
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Date: Thu, 27 Apr 2023 08:55:55 +0200
In-Reply-To: <20230427030534.115066-1-xuanzhuo@linux.alibaba.com>
References: <20230427030534.115066-1-xuanzhuo@linux.alibaba.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

On Thu, 2023-04-27 at 11:05 +0800, Xuan Zhuo wrote:
> Due to historical reasons, the implementation of XDP in virtio-net is relatively
> chaotic. For example, the processing of XDP actions has two copies of similar
> code. Such as page, xdp_page processing, etc.
> 
> The purpose of this patch set is to refactor these code. Reduce the difficulty
> of subsequent maintenance. Subsequent developers will not introduce new bugs
> because of some complex logical relationships.
> 
> In addition, the supporting to AF_XDP that I want to submit later will also need
> to reuse the logic of XDP, such as the processing of actions, I don't want to
> introduce a new similar code. In this way, I can reuse these codes in the
> future.

## Form letter - net-next-closed

The merge window for v6.3 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after May 8th.

RFC patches sent for review only are obviously welcome at any time.
-- 
pw-bot: defer

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
