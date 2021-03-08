Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC3C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 16:17:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA1065226
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 16:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA1065226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36259839E6;
	Mon,  8 Mar 2021 16:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OA6u9ptcln6u; Mon,  8 Mar 2021 16:17:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDC0A83984;
	Mon,  8 Mar 2021 16:17:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A67DFC000B;
	Mon,  8 Mar 2021 16:17:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F972C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0118F6F4D4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y-zGQz_TkGXF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:17:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6565A600D1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:17:15 +0000 (UTC)
Received: by mail-il1-x129.google.com with SMTP id b5so9297307ilq.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Mar 2021 08:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NEZnGRLyGUv6j7TBBXQHVAxZPQHAwJbm1fTojXbpoFk=;
 b=Cho/P6nHpddiaz/cI1Z1BsYnIITIQzQDsk046xSUrqx8QMsc8lymC8Zvpqvnk93caH
 oym9P1XKRpUdJideJc/wyuG4gidGl313q71cT9fYHCJp6jTMGw6Abk2CHRTgCudmJjld
 eqGo7w1zwJU5IBG4XY/2pP0S1Ygw6Iazs8a+na2aU9T0tGFTnSpCqK3e+s/tJUiifeiP
 gb2UgxGvD8a8ZhX7azlyeC1jQGywcjJnDmz3OB4+oVvhwjHkokmEMSutsPeDR5MXiKSl
 Y+D+cV+bLkzs8Kt1xvIuNkjoXrpgArxisoKOInGmLnpSxaLYhq69OCb/ine50c4/Cz2V
 5bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NEZnGRLyGUv6j7TBBXQHVAxZPQHAwJbm1fTojXbpoFk=;
 b=HaCfNMGwLKVr+N/NmvOe1K6n5xnFg6EoVpaUniyoY0dxXzhVQtWVk9dYIPFwWX2pqj
 sXTqtuc+Bb/01V4wi5UA6aaIZZJ0iY0oco3mMiHK4hfoM6d5yjZuc5hs4CbRDU1z2xxx
 oA7Vzi5JeveXoW+5hvjCixosrvUZ/klr10+eKHLtwnRJXlmKA6+rg/s1BxA3KwsUQbou
 bQo/A8eeBTCugb3W3jT8i5kn9R73TE0Kiz+k+wKvFxNF92m9Qt74WUfnia7fAlc+uTc+
 oS6v+5WU0e3w82GYnv+dyLMpfAkbMoQWHPhmlVOJmas7JvpLVwnunsZk8VpEUeEiz/wJ
 ULYA==
X-Gm-Message-State: AOAM532SlYaDYYZG7TBfkqVEjx7RKcI14sz80PTbmeJ8fVBrXtYO7NbG
 RJW0PAT0vT6NR5XkWAittVpFHz99Bhk=
X-Google-Smtp-Source: ABdhPJxtkcRFaiLSBFPuVKHol/kRwMdooHx08HbsN3kfIwciuc+ZcnOsk7VC7YWo9CENtqqQ57cLcA==
X-Received: by 2002:a05:6e02:12e3:: with SMTP id
 l3mr20948602iln.24.1615220234437; 
 Mon, 08 Mar 2021 08:17:14 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.40])
 by smtp.googlemail.com with ESMTPSA id 128sm6201496iov.1.2021.03.08.08.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Mar 2021 08:17:13 -0800 (PST)
Subject: Re: [PATCH v2 2/2] net: avoid infinite loop in mpls_gso_segment when
 mpls_hlen == 0
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Balazs Nemeth <bnemeth@redhat.com>
References: <cover.1615199056.git.bnemeth@redhat.com>
 <85e04e1e6367f19c8f538d145b32f5bb93788d8a.1615199056.git.bnemeth@redhat.com>
 <CA+FuTSdWSCzkB7sDn+_0Oxy8JqmqL=nsQXP_3bnb4Xdd=0A=KQ@mail.gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <718e4f13-31a8-037c-9725-08ae3cd93ccd@gmail.com>
Date: Mon, 8 Mar 2021 09:17:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CA+FuTSdWSCzkB7sDn+_0Oxy8JqmqL=nsQXP_3bnb4Xdd=0A=KQ@mail.gmail.com>
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
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

On 3/8/21 9:07 AM, Willem de Bruijn wrote:
>> diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
>> index b1690149b6fa..cc1b6457fc93 100644
>> --- a/net/mpls/mpls_gso.c
>> +++ b/net/mpls/mpls_gso.c
>> @@ -27,7 +27,7 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
>>
>>         skb_reset_network_header(skb);
>>         mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
>> -       if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
>> +       if (unlikely(!mpls_hlen || !pskb_may_pull(skb, mpls_hlen)))
>>                 goto out;
> 
> Good cathc. Besides length zero, this can be more strict: a label is
> 4B, so mpls_hlen needs to be >= 4B.
> 
> Perhaps even aligned to 4B, too, but not if there may be other encap on top.
> 
> Unfortunately there is no struct or type definition that we can use a
> sizeof instead of open coding the raw constant.
> 

MPLS_HLEN can be used here.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
