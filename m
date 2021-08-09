Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22587C4320A
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:42:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B6C61055
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2B6C61055
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 767AA40195;
	Mon,  9 Aug 2021 07:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u_Dajpl6-B8U; Mon,  9 Aug 2021 07:42:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B88CE400C8;
	Mon,  9 Aug 2021 07:42:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AA9EC001A;
	Mon,  9 Aug 2021 07:42:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12748C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6ECF82C3B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D_6aurxlALwK
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:42:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37DD482C1E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628494952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpTchTW2WHBbp1FKZwjHPai3s4d7skP1b3ls4uFFkQM=;
 b=VOMQEzhr9grrnoTBTxRICfIpqMVHm8yvO2nxzJvBZMLEhjXc3E7KbcJIfMKmVEXnuBqiZ9
 AYtQHVKC15CoTGkp4CNRQeqccgBgE+f1K1ppzDRedIkMO89vMQ1vvV48O9CAP51S7OuxFv
 rczKIFfdSryWYJstljIZuUCorH7Ffpg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-ul1Mf-i-O1uf3IGzduvPgw-1; Mon, 09 Aug 2021 03:42:29 -0400
X-MC-Unique: ul1Mf-i-O1uf3IGzduvPgw-1
Received: by mail-wr1-f71.google.com with SMTP id
 l7-20020a5d48070000b0290153b1557952so5100015wrq.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 00:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rpTchTW2WHBbp1FKZwjHPai3s4d7skP1b3ls4uFFkQM=;
 b=TNU7JElfKdypVanXE3znPC+PPZGfQi3SIjCiVUPkOCSqFxeEjJs0jVgySCjZg3Fj81
 XeBYq8qB+PUpGIZ0qBQhNyqbJfbq6f42ypm6bRhyQBTA1i0eaWK7GeZfz+pnab1zywus
 2zqdgAf4Q3FV8g1V/ck/UI9moA+1P8yclhjPmRKqgauwzHFmw7KjcDOkPFXP2WC+EW+f
 MYs0EsJxZaFj5MVaa5vn41kxHuxvy2otkm2oIvzxYKIsgY9U3jR1Y9fLbXaicU79CVB7
 nsOtJfO3yLU7JL7OlQ4ZANJyY4Q1GXMUjVoE5p1i6ZfQbXvnX4aLK5lY+wI5Eindl54Q
 YsPQ==
X-Gm-Message-State: AOAM5305739KcDYuLFv0VSifJjxHEInM3c+Yc5E+vtjF13eG78IBbvhI
 gZ9ZyUKhe/ae4ZcQ2hzbKxOeBJbrOAaZZ4xolQY3Ln3+Eu0Ym7+sT+WPlmWk9ef0UQbHFmA3Zu9
 MwmKXu6tD7NdsBCo3y+QJseaZ23bqEuDL8bzBPVs2y5F58KcirM8FDjNH04hItioKz9bWKbS+3c
 ztedpssq/rs07d2Q==
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr785833wrs.77.1628494948508;
 Mon, 09 Aug 2021 00:42:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxIs0Mx3OKFD9xz5+nORNxkQlRcKGJL37rseXuAmlE7FZXZNGrGWmsWEyh3ihAd2BaJSF+0Q==
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr785813wrs.77.1628494948372;
 Mon, 09 Aug 2021 00:42:28 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f?
 (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de.
 [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
 by smtp.gmail.com with ESMTPSA id a11sm4453865wrw.67.2021.08.09.00.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Aug 2021 00:42:28 -0700 (PDT)
Subject: Re: [RFC PATCH 10/15] virtio: virtio_balloon: use PAGES_PER_SECTION
 instead of MAX_ORDER_NR_PAGES.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-11-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3e27818c-970d-7138-0258-928274bf294e@redhat.com>
Date: Mon, 9 Aug 2021 09:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805190253.2795604-11-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 virtualization@lists.linux-foundation.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

On 05.08.21 21:02, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It keeps the existing behavior when MAX_ORDER grows beyond a section.
> 

... but it breaks/changes existing behavior if MAX_ORDER is smaller than 
a section?

> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 47dce91f788c..de8d0355d827 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -36,7 +36,7 @@
>   #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN | \
>   					     __GFP_NOMEMALLOC)
>   /* The order of free page blocks to report to host */
> -#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (MAX_ORDER - 1)
> +#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (PFN_SECTION_SHIFT - 1)
>   /* The size of a free page block in bytes */
>   #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
>   	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
> 


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
