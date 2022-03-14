Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F9C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 17:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8155340640;
	Mon, 14 Mar 2022 17:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mAjAmfaM2fy1; Mon, 14 Mar 2022 17:04:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D88E2404F4;
	Mon, 14 Mar 2022 17:04:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A85BDC0033;
	Mon, 14 Mar 2022 17:04:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BD30C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 17:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BC448132C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 17:04:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XbldnPvkq0tW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 17:04:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2BC381313
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 17:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647277446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWCgHwgDDKj06QMJn9h/A4XF35PO8btbj9WvrUaFqDk=;
 b=Snz7UV67vEjNEbFfvaXBkfCuBsT92v2dPu9BqBgEqbH1kdNOsvClJLOCEotcWaTrH5QQWe
 lCa3x2uHeUzSYt92PKcPhQxXzYA4SGomrKFad+qrhJvVinfEBf6QaEpFuo4QPY1m7RqK3Z
 RXW5cqndtI8JNKOARrgMurMkAjjzrVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-Cgeh2oqZPAmui6ySxAu--A-1; Mon, 14 Mar 2022 13:04:03 -0400
X-MC-Unique: Cgeh2oqZPAmui6ySxAu--A-1
Received: by mail-wm1-f72.google.com with SMTP id
 x5-20020a1c7c05000000b00389bcc8df46so7312330wmc.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 10:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=nWCgHwgDDKj06QMJn9h/A4XF35PO8btbj9WvrUaFqDk=;
 b=G1Oq7PV7M1bsaCgULgW5P2ZVpeqxVIJTQ74eGYsSRuICiHI+9na2je+YhOyL6s7fVU
 gy7ed/EQG4brtV0IILcoOT/AX4wV7ibkSgcISlHEDkqMES5uYEJny3umimPYcKnSbtLb
 D1e8NeDu901Cn3qTA8uCggr0KXwnJTRr2hm61Rk6WTqCDK6k5OFsnGzqEWfko6VxBs9x
 H5B1Mkzr1pWI7MZLSd2Fp/JFjZdTRXGP6KTGL39xVTY46r6QN9T8vds6xvn/mGnKNKa5
 n3xXKmwUeMoFg/eKaTTT1UUGg6VtMurDw4WwAorA1xg0HlnEfyO4lS6V55zw/lfrfflO
 slxw==
X-Gm-Message-State: AOAM532CM/0DfICcY56wAnwNYWNXXKH8hLx/5cx430oOafa4/HLtzoyT
 YEtB1uGo4NkkqM64c8D1PKMxz3ReBhIDPIYRlnCIZZIrnb6G+DuZUwh8ImXEd52qrz9ys32Vwi8
 Q8Gt3zZfYTY9mfamKmaVn/OEisKLf9T88WWDfUeoKwg==
X-Received: by 2002:a7b:c150:0:b0:389:95ee:4a20 with SMTP id
 z16-20020a7bc150000000b0038995ee4a20mr107052wmi.145.1647277442112; 
 Mon, 14 Mar 2022 10:04:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq4tXnPaZX7aE2z3rCDRky8biOX0gv+k8itzfOQumoQ0ijxnuBob9bchKuevyzXDNc3986mA==
X-Received: by 2002:a7b:c150:0:b0:389:95ee:4a20 with SMTP id
 z16-20020a7bc150000000b0038995ee4a20mr107027wmi.145.1647277441876; 
 Mon, 14 Mar 2022 10:04:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:9a00:b2c1:8682:b807:e870?
 (p200300cbc7049a00b2c18682b807e870.dip0.t-ipconnect.de.
 [2003:cb:c704:9a00:b2c1:8682:b807:e870])
 by smtp.gmail.com with ESMTPSA id
 11-20020a05600c22cb00b00382a960b17csm88614wmg.7.2022.03.14.10.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Mar 2022 10:04:01 -0700 (PDT)
Message-ID: <753f3cca-6862-a6b9-05a1-0b0fcc4565b8@redhat.com>
Date: Mon, 14 Mar 2022 18:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v7 1/5] mm: page_isolation: move has_unmovable_pages() to
 mm/page_isolation.c
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220311183656.1911811-1-zi.yan@sent.com>
 <20220311183656.1911811-2-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220311183656.1911811-2-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 virtualization@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 Eric Ren <renzhengeek@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@kernel.org>,
 Oscar Salvador <osalvador@suse.de>
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

On 11.03.22 19:36, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> has_unmovable_pages() is only used in mm/page_isolation.c. Move it from
> mm/page_alloc.c and make it static.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
