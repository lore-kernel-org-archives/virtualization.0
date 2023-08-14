Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F23FC001DB
	for <virtualization@archiver.kernel.org>; Mon, 14 Aug 2023 07:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF2744098D;
	Mon, 14 Aug 2023 07:56:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF2744098D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HGwNs1bR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 56-zzNSxRy57; Mon, 14 Aug 2023 07:56:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EBBE1408BE;
	Mon, 14 Aug 2023 07:56:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBBE1408BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEA3EC0071;
	Mon, 14 Aug 2023 07:56:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22192C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 07:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED5F760FDC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 07:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED5F760FDC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HGwNs1bR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OsHEHGVy23i0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 07:56:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FC5A60FC7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 07:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FC5A60FC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691999800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=feaezPibfnu2tN6eVjG3wExJsO1fsEJOd8vXqRY1s+A=;
 b=HGwNs1bRy5EHHnORiVEXq6M3oT3HaynranwqmRWB5+efJHLKaNZrO3QwEb1BlLG0Q1SZYZ
 pioQ9E1BSNNF77DjPOCpu0ODeEwVGAdvA7HYBKDPdcVycU/yH4YREZ8tT3upF3Pn1fVF1K
 5O7PaLVwePLO7gNf7lS6Xt0/phvR21c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ldAdBZIiMm2aYJ0zt6io4w-1; Mon, 14 Aug 2023 03:56:36 -0400
X-MC-Unique: ldAdBZIiMm2aYJ0zt6io4w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso24629395e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 00:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691999795; x=1692604595;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=feaezPibfnu2tN6eVjG3wExJsO1fsEJOd8vXqRY1s+A=;
 b=JrSplT1Tgg/G04dXJbo6zJf3mRRZmCKL3EtdCZcWF4/k2v3309QzO2/pK1KJpuAtOt
 VNZcXP1ksTUqVLbK0mv7N2e76sOQS3OPXg+SDasmjjiGXKN/gN/qPFFlVprRv9x5HrSR
 MDC/BjVAEWIHLuWctI4oJYhbwjKdY4F37dYMLD8i6zlWOFaEYfXNGQhgBh+ZmYwsyKAo
 zKgSvOM0bs1vgHa5lwUNoOE+03exkoreqv/ZT8dQLhHrMTLxOakq8jUziSI5TTRWyR3G
 x+o8TLwsr6uW2teYlekS0jFYY1WAYihDpnq0RRwc7lBE2kzYS81e79j4yy8V4DYiAHS4
 XAcA==
X-Gm-Message-State: AOJu0YyukINFlY3e6sy1e6aR6bEH2Eu1BV04xAFS+kcDDBV0JuAfim9T
 J8KkEtkJtlU8FWUUGn5fyxiiEZG36c5iN13zmR0/VFX17BCReJ9avzsrUahRIRuuVBRt0SjpKph
 BnX3AAJoxds1cTj6EGrvEAIHKefYeCGo4/zaXHuuFmQ==
X-Received: by 2002:a05:600c:2494:b0:3fc:7d2:e0c0 with SMTP id
 20-20020a05600c249400b003fc07d2e0c0mr7286619wms.27.1691999795151; 
 Mon, 14 Aug 2023 00:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwWUWSC+dZ+6bJHTp9i8dw8r+CNPXuFHgcPKByIHZGNFbhsTkatWjBnokB+NRwivqKwNHEkw==
X-Received: by 2002:a05:600c:2494:b0:3fc:7d2:e0c0 with SMTP id
 20-20020a05600c249400b003fc07d2e0c0mr7286610wms.27.1691999794770; 
 Mon, 14 Aug 2023 00:56:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:d900:2d94:8433:b532:3418?
 (p200300d82f2bd9002d948433b5323418.dip0.t-ipconnect.de.
 [2003:d8:2f2b:d900:2d94:8433:b532:3418])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c228800b003fbcf032c55sm16481338wmf.7.2023.08.14.00.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 00:56:34 -0700 (PDT)
Message-ID: <3b76343b-bc54-f704-b567-c586002190ea@redhat.com>
Date: Mon, 14 Aug 2023 09:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] virtio-balloon: correct the comment of
 virtballoon_migratepage()
To: Xueshi Hu <xueshi.hu@smartx.com>, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com
References: <20230813140709.835536-1-xueshi.hu@smartx.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230813140709.835536-1-xueshi.hu@smartx.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

On 13.08.23 16:07, Xueshi Hu wrote:
> After commit 68f2736a8583 ("mm: Convert all PageMovable users to
> movable_operations"), the execution path has been changed to
> 
> move_to_new_folio
> 	movable_operations->migrate_page
> 		balloon_page_migrate
> 			balloon_page_migrate->balloon_page_migrate
> 				balloon_page_migrate
> 
> Correct the outdated comment.
> 
> Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5b15936a5214..f5aac6cf3aa9 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -741,7 +741,7 @@ static void report_free_page_func(struct work_struct *work)
>    *  2) update the host about the old page removed from vb->pages list;
>    *
>    * This function preforms the balloon page migration task.
> - * Called through balloon_mapping->a_ops->migratepage
> + * Called through movable_operations->migrate_page
>    */
>   static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>   		struct page *newpage, struct page *page, enum migrate_mode mode)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
