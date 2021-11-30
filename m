Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12B0C433F5
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 14:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 444D7824DC;
	Tue, 30 Nov 2021 14:51:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kn-n_A-ua0bd; Tue, 30 Nov 2021 14:51:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF8A380F00;
	Tue, 30 Nov 2021 14:51:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 805D5C0012;
	Tue, 30 Nov 2021 14:51:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2921C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3A44606BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C3V4p5bqF2Y2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:51:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7C2E60684
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638283903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9Lx9TJJBXg2rHTFjd4QMdkDXGIXIvnZzimFPOne8Kw=;
 b=Re0j07cEVm++Oj9WFLoquFPIoNAfIL7/fvOexGBLywYfg23sBFdm2lqnWm5FLorsdrdQ0P
 Kk0tuFBUslp9ZrDN/Tombxq27KrgEfB7Gl/5vcEQXdXBu8ZcUSngDNZNsxbPGzmxpA1bee
 0gx9nc3bImfmjN4yfHiO7r+/TDWxp+o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-5ky127O2PtiDR8mlI4wBgA-1; Tue, 30 Nov 2021 09:51:39 -0500
X-MC-Unique: 5ky127O2PtiDR8mlI4wBgA-1
Received: by mail-wr1-f69.google.com with SMTP id
 d3-20020adfa343000000b0018ed6dd4629so3667659wrb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 06:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=E9Lx9TJJBXg2rHTFjd4QMdkDXGIXIvnZzimFPOne8Kw=;
 b=lk4ellwA24yKryi/4YsbngTcfY7QtKntmLX3FwzmgrFA9HqpLb8ofV7DqFwa2IeSBB
 WmMMy0oDCw3xn35ecrFTbBNdSMViXdohUaOWqHwFnA6NgNDnB9lgC8t+uv8jj6+FqOYE
 muXoYrHsyGHAnvPRqL18/bB0h5QnO5tbxPZw+E3rmq9+R3sq8QE8YoN7Ssw34TRNSI2f
 vDIBJ1btRzWz3V2+s9ItDe/Q604uCAz45Ye8+g9akv4o9zQ+jbthGEOiauwE+6EAvJfC
 Yq+D/vARE11XHG6s4VRGrDXkhq0CEmDVrF23zu84NVok/2+BZxnTQb9vT++qGgD+i4uI
 pLxg==
X-Gm-Message-State: AOAM530kCXwtnXOO5420MhBkVgb8NQLJfQrOERMFh8kggfJ8GjGJ/wdw
 y3wEQMciyU2v3GNmGuKbFPhHoZZpiD8SID+yvuJNQ0CeU/gxMgwpfh1n3nkg92CEp0wDjIWimwI
 C2NsCV6dSdDRZos17JXgP+ML8lmhkw+lg0iqICdeNwg==
X-Received: by 2002:a05:600c:b43:: with SMTP id
 k3mr5511849wmr.159.1638283898584; 
 Tue, 30 Nov 2021 06:51:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKgqfybofwM4ev+7p0oQTgMUxgl8EpmgO9OSaeiHHO8/ElEuvqxrQdaFyWneC5jrZs7Om0zw==
X-Received: by 2002:a05:600c:b43:: with SMTP id
 k3mr5511825wmr.159.1638283898421; 
 Tue, 30 Nov 2021 06:51:38 -0800 (PST)
Received: from [192.168.3.132] (p5b0c68ec.dip0.t-ipconnect.de. [91.12.104.236])
 by smtp.gmail.com with ESMTPSA id f15sm3295403wmg.30.2021.11.30.06.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Nov 2021 06:51:37 -0800 (PST)
Message-ID: <18472b72-c64f-59b5-f767-d965f0264ef0@redhat.com>
Date: Tue, 30 Nov 2021 15:51:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/2] virtio-mem: prepare for granularity smaller than
 MAX_ORDER - 1
To: Zi Yan <ziy@nvidia.com>
References: <20211126134209.17332-1-david@redhat.com>
 <F0D31D41-7843-4313-8264-E1C97979471B@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <F0D31D41-7843-4313-8264-E1C97979471B@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Gavin Shan <gshan@redhat.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, Eric Ren <renzhengeek@gmail.com>,
 Hui Zhu <teawater@gmail.com>
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

On 29.11.21 17:47, Zi Yan wrote:
> On 26 Nov 2021, at 8:42, David Hildenbrand wrote:
> 
>> The virtio-mem driver currently supports logical hot(un)plug in
>> MAX_ORDER - 1 granularity (4MiB on x86-64) or bigger. We want to support
>> pageblock granularity (2MiB on x86-64), to make hot(un)plug even more
>> flexible, and to improve hotunplug when using ZONE_NORMAL.
>>
>> With pageblock granularity, we then have a granularity comparable to
>> hugepage ballooning. Further, there are ideas to increase MAX_ORDER, so
>> we really want to decouple it from MAX_ORDER.
>>
>> While ZONE_MOVABLE should mostly work already, alloc_contig_range() still
>> needs work to be able to properly handle pageblock granularity on
>> ZONE_NORMAL. This support is in the works [1], so let's prepare
>> virtio-mem for supporting smaller granularity than MAX_ORDER - 1.
>>
>> Tested with ZONE_MOVABLE after removing the MAX_ORDER - 1 granularity
>> limitation in virtio-mem, and using different device block sizes (2MiB,
>> 4MiB, 8MiB).
>>
>> [1] https://lkml.kernel.org/r/20211115193725.737539-1-zi.yan@sent.com
> 
> The patchset looks good to me. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks a lot!

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
