Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F819C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:55:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296E665253
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 15:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296E665253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9D87494C8;
	Tue,  9 Mar 2021 15:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XyQuMSwauoD4; Tue,  9 Mar 2021 15:55:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8704F4BEF2;
	Tue,  9 Mar 2021 15:55:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64B80C000B;
	Tue,  9 Mar 2021 15:55:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04033C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F14214BEF2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7kvH9Myccelj
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B466D494C8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:55:47 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id a17so13280397oto.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b5sJf5a/Nsswl7kMHUtt9MARj1P3JFHsuY5CgeMMi5Q=;
 b=reguRV/Ku7o0pbogf/jH0d0oJ9bs8Gg7KnDshPUabTd0DMCyxupAWt3RvDINC7r5FN
 m1aKVH3ls8zAmYf5cgXn/koNUdgNiQZmBhTWj9z9HZK0Tp53SThuvtBjv0ieLH7yTRvE
 +0qzoYZoepRwZ47CR3eucxI6LDO5zP4cMOPXY0uBEgTRKko+XJMdUCaOKgFPjHKuCDaO
 nElHP50cjUEn4xXnHEUvRKTxuRSigssWkPdnbFU3tIpGonKW5WraAixFe6K0qfiy1OkI
 IKfncQi9IMoGZmKdPl9y9aVs0gFU/Rwh9DvTS8INIPDwqR0xMo0Te4UZhoLqtyzwVVow
 M+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b5sJf5a/Nsswl7kMHUtt9MARj1P3JFHsuY5CgeMMi5Q=;
 b=M61Rn7vqa2DU3JY0I4xFGTukldgs2lEBe8l2M/1/X4fbPjR2OJNgDKfDWgLr4djA7x
 18mzdNfMH+1TKNdRvjDAb6zpZ0nfyHvmtC2GfK7QZ8/TJjSt8rEatWhRXWGwmL136XCV
 6Qayam9hq+uE2Xo2XIJG3aXzlEgSUXFQS6B/cv56hE2cwwRGGxFkrGy5v52m3sYZ4mHL
 ckcNg80qkyoMNhSd/7mVowNPtopk+IE71th09g9/s07IPGXdnNNkcJuuWYXbE57JoLo5
 Oj+biTxiz7J/HQLzNaVX9QPbag+vzCjsVtD7HwSAoKKXqYKw/UvjTMY5/ovqHN01fYke
 vUeQ==
X-Gm-Message-State: AOAM533QQ2LdDit3nxR9RVfDroOc62GBgAnYECpZLjY7hvniNQwclTt1
 5H+d6v+ZVZX3Et+NT85Jp7RZUzmBp+0=
X-Google-Smtp-Source: ABdhPJzOTAJZeoOCLFXCyS3YX0cMxQ/nL2IbduyYBDXUYZMUVtkvcAeYnXQmjN3m07qD/56Cnm4Nmw==
X-Received: by 2002:a9d:650d:: with SMTP id i13mr25180280otl.12.1615305346631; 
 Tue, 09 Mar 2021 07:55:46 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.40])
 by smtp.googlemail.com with ESMTPSA id d1sm2950488oop.0.2021.03.09.07.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Mar 2021 07:55:46 -0800 (PST)
Subject: Re: [PATCH net v3 2/2] net: avoid infinite loop in mpls_gso_segment
 when mpls_hlen == 0
To: Balazs Nemeth <bnemeth@redhat.com>, netdev@vger.kernel.org
References: <cover.1615288658.git.bnemeth@redhat.com>
 <9b79f43d2dfec8b2cb8e896b5591e7b1c3cc1f6c.1615288658.git.bnemeth@redhat.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <0c2f075e-ea66-66df-82e4-2c5fa71b2d43@gmail.com>
Date: Tue, 9 Mar 2021 08:55:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <9b79f43d2dfec8b2cb8e896b5591e7b1c3cc1f6c.1615288658.git.bnemeth@redhat.com>
Content-Language: en-US
Cc: willemb@google.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, davem@davemloft.net
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

On 3/9/21 4:31 AM, Balazs Nemeth wrote:
> A packet with skb_inner_network_header(skb) == skb_network_header(skb)
> and ETH_P_MPLS_UC will prevent mpls_gso_segment from pulling any headers
> from the packet. Subsequently, the call to skb_mac_gso_segment will
> again call mpls_gso_segment with the same packet leading to an infinite
> loop. In addition, ensure that the header length is a multiple of four,
> which should hold irrespective of the number of stacked labels.
> 
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>
> ---
>  net/mpls/mpls_gso.c | 3 +++
>  1 file changed, 3 insertions(+)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
