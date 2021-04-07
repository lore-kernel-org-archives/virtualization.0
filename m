Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA2C433B4
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 17:13:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDD361284
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDD361284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D8D9403F9;
	Wed,  7 Apr 2021 17:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrxDWUUPblnw; Wed,  7 Apr 2021 17:13:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC535418DF;
	Wed,  7 Apr 2021 17:13:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84A91C000C;
	Wed,  7 Apr 2021 17:13:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA307C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 17:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D805760D60
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 17:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0VTAXDLu52li
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 17:13:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B55560A4B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 17:13:39 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id 12so4280175wrz.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Apr 2021 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=spct60znTNGYOyR35NREia36IJTXUy0OONnZZ90mbMg=;
 b=fcM6235XPcsSY9CAcuM0EnAr4ev5sEK6pprD4EETY0o64yvRFeJMAIHa/iRBfJMxMs
 nTAK+BABT9ahSQnyr/sDvUsDNltjNEniTSgkgxYOwPDyWR9nc8LjrrdnTcMsqecdujBR
 V7DYn4cgyo0ohcEjp2uznICvCnD/K88zY9grlZ6Y/xecUbdcihhDKLDFW6HL2gsAiyq5
 i5wgN9S/5IX2cVqwNzCsLjfTWdWfs6w6uBOV0JDMYIMSaVRKUtvsyZjwyq4P0H9Igt/J
 2FAvYnBa8lctPeoS9d0Ufhx0v8H/dxuVjo7BDRL78XaEBx2UdRgxvRmcZ+ioRb/WcEQ9
 a5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=spct60znTNGYOyR35NREia36IJTXUy0OONnZZ90mbMg=;
 b=Q6wa4upml1PV6NapCxP54KU0xh6fMXwsTAh6gmMn1RVqyzwaJIxSSbSLQN/AHvjGrE
 R12l0BosmcxpN8/i1oo9T8eZ9jq99EEE9+jE9+fGTdS62dQTf3QUIYx0jP3F9/07Vujg
 3pMwe6GUfDSJuCSPua+lPJ6homc7WkK+rP9wfUXTT7OxKpWdS7OzAZjwa4nNZ68VRqdV
 wk8u1yv0hMKvmLPSfYVlu1pCxCDMwD+iwKJ+QLERwaFi+c5RN1bYGxZz8WM/d4af2k4/
 nfvcNEkNSF5pK8FFxX75GHXSN2mt4qweVBZ5dUVzs+eze2Vc2MTzvvtoWJMrtP8X4qRr
 kRsA==
X-Gm-Message-State: AOAM5332F7lIIt4YeGSsTcjXm1ErwwJKsKMX97WZ7ziZA+W76WfGGZuB
 61GncdYPphRbRRP2a+ewTQU=
X-Google-Smtp-Source: ABdhPJyneJDvCbYOpE2sWkEPumyYrEh/x7yZCzB1QjxxpxCzw4omtqCcAT2YPDwOT+OXpsUVELc9Ow==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr5572670wrm.39.1617815617496; 
 Wed, 07 Apr 2021 10:13:37 -0700 (PDT)
Received: from [192.168.1.101] ([37.172.15.210])
 by smtp.gmail.com with ESMTPSA id c16sm49403852wrs.81.2021.04.07.10.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Apr 2021 10:13:37 -0700 (PDT)
Subject: Re: [PATCH net-next] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
References: <20210407054949.98211-1-xuanzhuo@linux.alibaba.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <84995a39-c588-3aa0-98ff-f16087dbdff0@gmail.com>
Date: Wed, 7 Apr 2021 19:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210407054949.98211-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
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



On 4/7/21 7:49 AM, Xuan Zhuo wrote:
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
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> ---

This will generate merge conflicts.

Please wait that commit 0f6925b3e8da ("virtio_net: Do not pull payload in skb->head") has reached net-next.

Also are we sure pages are always writable, and not shared ?


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
