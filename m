Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06636C19F2B
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 15:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E92B4088D;
	Mon,  1 Aug 2022 15:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E92B4088D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z2MRSpMt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T4P0NeNotSY9; Mon,  1 Aug 2022 15:13:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B86D24086B;
	Mon,  1 Aug 2022 15:13:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B86D24086B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84F65C0033;
	Mon,  1 Aug 2022 15:13:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0114EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 15:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA11D4088D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 15:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA11D4088D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VTOMPWB14kcH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 15:13:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A180F4086B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A180F4086B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659366802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsD/rgTzse5a0ywH6Izn9rMfo/95Q7JbCqp8jKzGMjM=;
 b=Z2MRSpMtJ7EooOFl/w/Z8argW0SDP9SNMMgtwaP/qyuhe+7+ZJDD2PiK7g9+XknhDEpt3U
 O/Aqxl+ywrWp/bnUsg/kjWLi1c1/VVAkyss9ZXY2rEPrdiQc5ckX57Pl3z+kXUvT84sXGu
 pubr9VFEg5qoCwz0s5Jlt2qNSKWTkks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-hlNZXLqENkW8ZWGan5NxVA-1; Mon, 01 Aug 2022 11:13:20 -0400
X-MC-Unique: hlNZXLqENkW8ZWGan5NxVA-1
Received: by mail-wr1-f72.google.com with SMTP id
 w22-20020adf8bd6000000b002206311fb96so747127wra.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Aug 2022 08:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=nsD/rgTzse5a0ywH6Izn9rMfo/95Q7JbCqp8jKzGMjM=;
 b=7d7LLsf8+iEeWCy76NhR3FPbBBaJGfTOVoPnn5OwuphJlU/62Crq5cStetRkvoMteW
 waIKWnCVJV6PFMZrWQp47EP60VW5ye0Kr8mBUW2Ll0Dwpilp2NVMkr+p6SBZuDJ0yK2O
 ZUaoh0MUwmTL8oLcEGytNeZqMuYOQRjHRClod+irhS5hupsHwVnPQcn6VzO7kj0HPWwf
 04o/TsQ4BhlIgfmRD08fjQ8WiDbJikeZ6GDKth9PpnNGs/wgAk7oAXYVAW0QYlUhaKFd
 ZCfE9+KDh42PMX4pu1UX7M2hJzlBrGYe/fn+QsJZDw2hrxuKa1IgjVQIL8/Om8b3+XgE
 AYVQ==
X-Gm-Message-State: ACgBeo06i9mhDO2l2r5flhbpT703NimHoXSzZNh1w+g5qJCNUhh8LmpO
 l+RFyWyx2Uyjf338eQlZ2P5gMctB/s4lm0XgUZzc2nCdzBfxqBuzVw2iHUWX+iGepVONDQ7BDM/
 X1l+CiZ1X1dPaBAd65rq/fjru9SJKd2uqWXeLyUYeyQ==
X-Received: by 2002:a5d:6b50:0:b0:21e:298c:caad with SMTP id
 x16-20020a5d6b50000000b0021e298ccaadmr10078129wrw.509.1659366799349; 
 Mon, 01 Aug 2022 08:13:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6SFeifuzPYHVAqFr8/wF0WF/GYI/razjAjzF4+8/U33L470f+d6kBv248bmE1Rqf3OzIa40Q==
X-Received: by 2002:a5d:6b50:0:b0:21e:298c:caad with SMTP id
 x16-20020a5d6b50000000b0021e298ccaadmr10078114wrw.509.1659366799134; 
 Mon, 01 Aug 2022 08:13:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00?
 (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de.
 [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
 by smtp.gmail.com with ESMTPSA id
 bs22-20020a056000071600b002206d5fded3sm358369wrb.104.2022.08.01.08.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Aug 2022 08:13:18 -0700 (PDT)
Message-ID: <8ee986d7-0e3e-6b66-8c13-61fc70fa538e@redhat.com>
Date: Mon, 1 Aug 2022 17:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 2/2] Unify how inflated memory is accounted in virtio
 balloon driver
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <20220726141047.72913-1-alexander.atanasov@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220726141047.72913-1-alexander.atanasov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel@openvz.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On 26.07.22 16:10, Alexander Atanasov wrote:
> Always account inflated memory as used for both cases - with and
> without deflate on oom. Do not change total ram which can confuse
> userspace and users.

Sorry, but NAK.

This would affect existing users / user space / balloon stats. For example
HV just recently switch to properly using adjust_managed_page_count()


commit d1df458cbfdb0c3384c03c7fbcb1689bc02a746c
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Wed Dec 2 17:12:45 2020 +0100

    hv_balloon: do adjust_managed_page_count() when ballooning/un-ballooning
    
    Unlike virtio_balloon/virtio_mem/xen balloon drivers, Hyper-V balloon driver
    does not adjust managed pages count when ballooning/un-ballooning and this leads
    to incorrect stats being reported, e.g. unexpected 'free' output.
    
    Note, the calculation in post_status() seems to remain correct: ballooned out
    pages are never 'available' and we manually add dm->num_pages_ballooned to
    'commited'.


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
