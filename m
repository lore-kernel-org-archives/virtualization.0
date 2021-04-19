Return-Path: <SRS0=J9So=JQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DE7C433ED
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 16:48:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0438761157
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 16:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0438761157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F62C40372;
	Mon, 19 Apr 2021 16:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eUQPsqnAfCQw; Mon, 19 Apr 2021 16:48:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25E664035E;
	Mon, 19 Apr 2021 16:48:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01568C000E;
	Mon, 19 Apr 2021 16:48:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9B06C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 16:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0C3283848
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 16:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5IwQcBmlEucB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 16:48:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E7318382F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 16:48:19 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 g4-20020a9d6b040000b029029debbbb3ecso201267otp.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sJGKbymQi9DBaB5FfbpLm+QMITeaprzp7V2EHZWOmNo=;
 b=bERlyjmAr/QcW+a1cHmXNDJX5sjznRzB6WDRTVS6gyCYVkxeSDmq2oxeu6uk0KFlzC
 FXyFzI2BP0X2OsD6Z+boF6prTfuY8WzNCj7xY2LRWF7DXTKDu5da9xnQ8ICpjkc6xMSk
 2sECNtkcpFtwKtijXT6dlI8H/+uEPjaakwtsG5F0SxG0ie3zdpfZK1N4dVB9gyZecfU0
 gxFVyrd8gFElmlGJ5s4tuEX+LnNSad9IcTZFvfooBqb9yxHTzKl+zuoN06e2O/wGSEft
 9AqwFLw9+VM0N6QU4Oy2WMmt9ED/TbUkGcY45c7apdyVw3QVvccMOK75F/qzi21qbEBU
 KYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sJGKbymQi9DBaB5FfbpLm+QMITeaprzp7V2EHZWOmNo=;
 b=sgtEQooXDQkjYZEz8Ma08jHgeJY8Vo5G6nVSPPnHOq6rpMnVwjquIX5Ax5BANISQna
 Ftv8G5po/5VktCWjidZL97dwYIHgb6B8MXS6lHc3HVSDeo4YHLpMpe/hKMslj+Sc/2Ys
 SMBYKPxGIk5U2DKDAwkmMIjXkq/JHHeGux3EUgbw9cPnKtZE291N+R1HH/6KfH4jlg6b
 Gd5mYADjmmp2mIUYTZIcbRGg4rDUNyDBgmgDb6CRYuisy0vdcrLFge+SlY6YrDFazRVJ
 E2Jzd0u3XVhptOuQm2VgOu8+ANE/pjX4Sf4+HCBf4k/Ux4IVFJJbdA3oU65kX8+x3lo0
 BdCQ==
X-Gm-Message-State: AOAM531bKzVfdi9qZMsvY+mJFQRZdpkJ3lOugKZG5pvTH4SuS+crB2YQ
 xPsMSf9cJIB+g/Rf1kCngeJU++CDnnI=
X-Google-Smtp-Source: ABdhPJwfX5nh9pF75tXwDAGoj59DPOWQU6o9JkNznnYMMqFvEelehYN6etDO6WWN9FwmUnVYy8bbIQ==
X-Received: by 2002:a9d:73c7:: with SMTP id m7mr15164909otk.11.1618850898293; 
 Mon, 19 Apr 2021 09:48:18 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.45.42.15])
 by smtp.googlemail.com with ESMTPSA id 3sm3569597otw.58.2021.04.19.09.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Apr 2021 09:48:17 -0700 (PDT)
Subject: Re: [PATCH net-next v3] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210416091615.25198-1-xuanzhuo@linux.alibaba.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <ebaeb57a-924a-43e4-bd5f-e41ecce9ffe6@gmail.com>
Date: Mon, 19 Apr 2021 09:48:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416091615.25198-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
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

On 4/16/21 2:16 AM, Xuan Zhuo wrote:
> In page_to_skb(), if we have enough tailroom to save skb_shared_info, we
> can use build_skb to create skb directly. No need to alloc for
> additional space. And it can save a 'frags slot', which is very friendly
> to GRO.
> 
> Here, if the payload of the received package is too small (less than
> GOOD_COPY_LEN), we still choose to copy it directly to the space got by
> napi_alloc_skb. So we can reuse these pages.
> 
> Testing Machine:
>     The four queues of the network card are bound to the cpu1.
> 
> Test command:
>     for ((i=0;i<5;++i)); do sockperf tp --ip 192.168.122.64 -m 1000 -t 150& done
> 
> The size of the udp package is 1000, so in the case of this patch, there
> will always be enough tailroom to use build_skb. The sent udp packet
> will be discarded because there is no port to receive it. The irqsoftd
> of the machine is 100%, we observe the received quantity displayed by
> sar -n DEV 1:
> 
> no build_skb:  956864.00 rxpck/s
> build_skb:    1158465.00 rxpck/s
> 

virtio_net is using napi_consume_skb, so napi_build_skb should show a
small increase from build_skb.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
