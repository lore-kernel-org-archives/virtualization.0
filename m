Return-Path: <SRS0=KlxN=KO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D6AC433B4
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 14:31:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5C56135A
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 14:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5C56135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66B41406B0;
	Wed, 19 May 2021 14:31:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a2kWbT1zOu2R; Wed, 19 May 2021 14:31:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE133406A7;
	Wed, 19 May 2021 14:31:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2972C000D;
	Wed, 19 May 2021 14:31:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4653EC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 14:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3ACDF4010F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 14:31:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6egzwZbJBpfj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 14:31:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB3E2400FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 14:31:15 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id y14so12175524wrm.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/uIuAty7PjxXFt4IM0i+V1A/dMXLvYisaqsv/qbrezE=;
 b=W+/COpqc5fQ8jmoquxbMKC6Ehnr83ZF2XRb52KqwZYN7L9L0nJoj8xNIabgDHYxZU0
 F6iZlhockfTfVVlBkn4ud9d63iT87RLJhl0WQV+OQVc0Z9lsHJAAuhWChvkIKFxDEhLd
 Xoa9cvo6JnHyS6iHtnXsHKHp+ZdMGxHsp/sajjaTvDNFprJ9bSOJGFyOiuU3cfWjhy2C
 YskgE3TmZMU/r5Xd90LTUeyiE4CVC0A4tBp0aekOUo+UNVY56u8W9gQ6fkhcO9VfRGSx
 GzoIvK4VI42X9hGqwFgF2D24x6CNomcKUJUvFaU7WURaHypRYJQvhdgxRr44O6trhOlA
 fB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/uIuAty7PjxXFt4IM0i+V1A/dMXLvYisaqsv/qbrezE=;
 b=Uw+uj3a8z1ZkFb+EF/Cm6It3dpcMBB+gAzR3sQqmbe4nxUjhyztQJSPkRGorr5JdSm
 4lUcvf6812nrj/7G5+sjdxxrzMb8Yh1DpgQ7fSdQdmOIbSZbd/GNtr7+Ot7RxCtmbFin
 UeTMb1kKAlnqQKl0LzvDzOgc8TTfQc57DhxWYN6uLb9HHWCFqe3D55VHcYD1wN50jj03
 VKTHkdl5snFBLvPb3IIiFJUzk9/G9HClip3yCzpV6G+IjS2zMmuqGYKw/Xy+jsN19OmK
 D8F1Xoegnq6sI2qm5A66Ew4Vb4d7AHDICkG/8H4FcP0H3lmTYXPs5om6EElkf8uYE6Vl
 YM8g==
X-Gm-Message-State: AOAM531GGsV4v64xwjhs1c9YqQKcek5T2xeCoVl9cs2OvkI9bjh0e4k/
 l1sHQVn9ImAAaGprequU+j8=
X-Google-Smtp-Source: ABdhPJyXuJnhzN0eu3ei8cGd0y+n4IYYl4B39s4zlfx5aYYQ7hSLjMfpxGTJMNX9DJK1bCo8vkyTLw==
X-Received: by 2002:a5d:508e:: with SMTP id a14mr14900327wrt.88.1621434674015; 
 Wed, 19 May 2021 07:31:14 -0700 (PDT)
Received: from [10.0.0.2] ([37.172.163.196])
 by smtp.gmail.com with ESMTPSA id c6sm7693369wru.50.2021.05.19.07.31.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 07:31:12 -0700 (PDT)
Subject: Re: [Bloat] virtio_net: BQL?
To: Stephen Hemminger <stephen@networkplumber.org>,
 Dave Taht <dave.taht@gmail.com>
References: <56270996-33a6-d71b-d935-452dad121df7@linux.alibaba.com>
 <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
 <CA+FuTSf0Af2RXEG=rCthNNEb5mwKTG37gpEBBZU16qKkvmF=qw@mail.gmail.com>
 <CAA93jw7Vr_pFMsPCrPadqaLGu0BdC-wtCmW2iyHFkHERkaiyWQ@mail.gmail.com>
 <20210517160036.4093d3f2@hermes.local>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com>
Date: Wed, 19 May 2021 16:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210517160036.4093d3f2@hermes.local>
Content-Language: en-US
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Xianting Tian <xianting.tian@linux.alibaba.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 bloat <bloat@lists.bufferbloat.net>, Jakub Kicinski <kuba@kernel.org>,
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



On 5/18/21 1:00 AM, Stephen Hemminger wrote:

> 
> The Azure network driver (netvsc) also does not have BQL. Several years ago
> I tried adding it but it benchmarked worse and there is the added complexity
> of handling the accelerated networking VF path.
> 


Note that NIC with many TX queues make BQL almost useless, only adding extra
overhead.

We should probably make BQL something that can be manually turned on/off.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
