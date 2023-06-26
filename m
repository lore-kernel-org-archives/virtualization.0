Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C891EB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 07:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A1BF60B9A;
	Mon, 26 Jun 2023 07:40:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A1BF60B9A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MWdgQtvf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bh1CpprbD9qn; Mon, 26 Jun 2023 07:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E831460BA2;
	Mon, 26 Jun 2023 07:40:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E831460BA2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1484C0037;
	Mon, 26 Jun 2023 07:40:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 814A1C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 07:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CC2D4054A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 07:40:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CC2D4054A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MWdgQtvf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EIjr1ZXjpyyV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 07:40:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6BCB404C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6BCB404C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 07:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687765225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Th6Q21wltoNkgg5HCn+fk29FROJ//zlxfhb4XjFHSU=;
 b=MWdgQtvfSbOrQ8I1LJojZKLbcwYCpm3WNOdUB/8R2pfBBgk6B5JnPysSG19/RT8dPfLyMb
 /4EJzRZ9+0DOjDZq/yVesfuyfGfUJ5eorLjr4LjOvvgFBDJj6WZ6h5IT7HuowJPNgn8K6i
 YlFC1Jo/vh+IhhuHvuLmwv9QwhYkIHo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-_AqEwiarOtaq3M-NJcM1Uw-1; Mon, 26 Jun 2023 03:40:23 -0400
X-MC-Unique: _AqEwiarOtaq3M-NJcM1Uw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9d7ff4b6aso18447285e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 00:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687765222; x=1690357222;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Th6Q21wltoNkgg5HCn+fk29FROJ//zlxfhb4XjFHSU=;
 b=lkhMNqlN4lMmlryc3F4WLUg2isqQXdtKkNOiWhwvenBpV/qA/3twl3LT58exj89BC0
 uprscHQ2dNh2+wH1Pw4qYCNVOGC81yKFvfpmkKhdfyNuMTEW64B0lZ38KLVqNaqe/rIl
 lvwF4fbTfe9yOIZjhIt/v49TQdtZkZ0Bkt9cp8QJKFUop0lYG2bRW+nFoxpyANrnN8P4
 UN6H9W5H+u1Lx3rWqRXDOxq0VKc0gs3qY8gbJf3MbhiDhKuW6XeNW2SQvwhnAxStuXXn
 tL1MWONbcT90EFw6eHQzn5DZ4NJlfIMjGEA6vpIxzoNV3bjrvmPPeA8Y47X/sEWz77eb
 QYiA==
X-Gm-Message-State: AC+VfDy1Q0tI4/lge8AqsZanAYfJkGlo+tDSxuPS/Sk+/4Lhi8IfTesK
 cISaCXXcoZKfVb1T/1gccET76Aam0qFXhJq7ZWx8c5+LunZzmKK6cSeZknltQik1FZJTWYIjyMU
 xqU3GYI6nRPhZDO2GRLfH8Knzqq8Cz7ZWe5JuTBTNWg==
X-Received: by 2002:a05:600c:3782:b0:3fa:889f:e272 with SMTP id
 o2-20020a05600c378200b003fa889fe272mr3619804wmr.10.1687765222387; 
 Mon, 26 Jun 2023 00:40:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46RMEimKMFUMFkeJmfv9ICdxrovvDfzA7wYiA3UqdmJx5S5dsL/yuz+zbda1uD3mEG62oC/A==
X-Received: by 2002:a05:600c:3782:b0:3fa:889f:e272 with SMTP id
 o2-20020a05600c378200b003fa889fe272mr3619788wmr.10.1687765222092; 
 Mon, 26 Jun 2023 00:40:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:7300:2ef6:6cd6:703c:e498?
 (p200300cbc74b73002ef66cd6703ce498.dip0.t-ipconnect.de.
 [2003:cb:c74b:7300:2ef6:6cd6:703c:e498])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a7bc408000000b003f5ffba9ae1sm6739278wmi.24.2023.06.26.00.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 00:40:21 -0700 (PDT)
Message-ID: <ccbe39b7-dca1-cbc5-3344-9d906f400b6c@redhat.com>
Date: Mon, 26 Jun 2023 09:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/26] virtio-mem: use array_size
To: Julia Lawall <Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-9-Julia.Lawall@inria.fr>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230623211457.102544-9-Julia.Lawall@inria.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, keescook@chromium.org,
 "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On 23.06.23 23:14, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>      expression E1, E2;
>      constant C1, C2;
>      identifier alloc = {vmalloc,vzalloc};
> @@
>      
> (
>        alloc(C1 * C2,...)
> |
>        alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>        ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>   drivers/virtio/virtio_mem.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)



Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
