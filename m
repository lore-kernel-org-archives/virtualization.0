Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC931C433EF
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 08:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77EA88176B;
	Wed,  1 Dec 2021 08:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ir2f_momRsvG; Wed,  1 Dec 2021 08:24:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D38D81765;
	Wed,  1 Dec 2021 08:24:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4303C001C;
	Wed,  1 Dec 2021 08:24:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB9B5C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 08:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A94FF60635
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 08:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jOrOisdGhasa
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 08:24:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0776C60634
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 08:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638347080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkzPDiWFZ0xPHB730aPwxoy6RLUvNRKztlsGB8SnQLU=;
 b=XGz9owLv9CcaM8gWVKdfapHSq0/2gCiee4mmwu0sI84S5UfjiU+1bHq35w/I66Nlk+Itk9
 vRawN2czYBHvYLKsfHNZGONkT8PQoK+HKs1vgBRPCfVvwU4zj9HezkoQxpriVKPETwvYaA
 Ljlb7xuHhgNCbZXZRhotENAhoI/nHXY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-69-d3i-ztJ8NHyfqOTK-uge7Q-1; Wed, 01 Dec 2021 03:24:40 -0500
X-MC-Unique: d3i-ztJ8NHyfqOTK-uge7Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 v62-20020a1cac41000000b0033719a1a714so11834970wme.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Dec 2021 00:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=fkzPDiWFZ0xPHB730aPwxoy6RLUvNRKztlsGB8SnQLU=;
 b=iH0xBwpPksyGuJFz+lu6BWeihYBYCuS9QuNWM8BPVXqdN1btYrSy4kj/Na5raurZ65
 d9CWOvrEEQg1gC3YpJsCVlTVDIjkYp8TkkS3ux4YGScjXtDIuEYNrrmBAHpEf05kc58x
 gIONwHYN2RQgzeYCkK+A09EG+4HwXehoOR37sR4Id3Npi7juR3pt1MWd8t51Z+2RX+k/
 RsPoi7gsfZU8XYdbBppFHQYHHkADnFpWWC93fg2JKOlUAt+meDVbYuoQmIPAC+Cz1HQk
 OfQH8u0SJRT/MRR2TiOoanD3nfR48aPNTTfLi3eb2j79IfyYvB+CEm0o9tszp4X2CNTL
 1zCA==
X-Gm-Message-State: AOAM532DgmuIPeXDRzYPH1usx3CEbHXy+Idr1X4/gY4k1Ny/fkcbsxGn
 71PA+qD97OhrORWcX9FxGA9VQMYEAAvOhZ2T9BzsVxgxv4rZZBMuYrUHxD5ke2e+2JzvuVRdqGU
 M0W5SfWxjEVjBepgCMawLodV7mJTTDbfJXyr0gavtxA==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id
 g7mr5186352wmq.138.1638347078782; 
 Wed, 01 Dec 2021 00:24:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxL7t5c38ZspM03DxqSzGkOrDykj7ybqwhfbHfItmliidB3NvPI6hvo5nRFdkz+zbZAl2dzrw==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id
 g7mr5186333wmq.138.1638347078608; 
 Wed, 01 Dec 2021 00:24:38 -0800 (PST)
Received: from [192.168.3.132] (p5b0c65f1.dip0.t-ipconnect.de. [91.12.101.241])
 by smtp.gmail.com with ESMTPSA id u23sm268279wmc.7.2021.12.01.00.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Dec 2021 00:24:38 -0800 (PST)
Message-ID: <7afa01ef-9048-4636-6059-efed7fadc452@redhat.com>
Date: Wed, 1 Dec 2021 09:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/2] virtio-mem: prepare for granularity smaller than
 MAX_ORDER - 1
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20211126134209.17332-1-david@redhat.com>
 <20211130185612-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211130185612-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Gavin Shan <gshan@redhat.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, Eric Ren <renzhengeek@gmail.com>,
 Hui Zhu <teawater@gmail.com>, Wei Yang <richard.weiyang@linux.alibaba.com>
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

On 01.12.21 00:56, Michael S. Tsirkin wrote:
> On Fri, Nov 26, 2021 at 02:42:07PM +0100, David Hildenbrand wrote:
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
> 
> is there value to merging this seprately? or should this just
> be part of that patchset?
> 

The value would be to give it additional testing ahead of time. But we
could just carry it along. Whatever you prefer. (I'd suggest merging it
right away)

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
