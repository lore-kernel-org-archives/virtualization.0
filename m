Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89172C433F5
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 13:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C73460B35;
	Tue, 25 Jan 2022 13:24:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id raDD-wx4xx45; Tue, 25 Jan 2022 13:24:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C3F5D60B3A;
	Tue, 25 Jan 2022 13:24:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D539C0039;
	Tue, 25 Jan 2022 13:24:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B49DAC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 13:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9340460B3A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 13:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DwKDH1MPMeaA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 13:24:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BAE760B35
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 13:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643117059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBuf2DEMMEYvXIlU2KdQGISDe09T8cEBp/JHdIeTMLU=;
 b=LuJHWuAB9y2n8wY71ac//MSYIK5Kfc6ifB8pSJhZKvONAsyeuoDeXQap0p/HZL4Sfr89bF
 lMwNv3MOlfwJgXqBoLlAP82sxJ3yieKFm9mPmNuero0BKBgFZHwsgZO0cehAc+mZHpqZll
 dVtw1uFgIlRUN2F+9oStLIJdZzVKlvk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-w0-pQmvbM0uJRwtNuvawCA-1; Tue, 25 Jan 2022 08:24:17 -0500
X-MC-Unique: w0-pQmvbM0uJRwtNuvawCA-1
Received: by mail-wr1-f71.google.com with SMTP id
 v1-20020adfc5c1000000b001a37fd2fa2dso3070684wrg.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 05:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=nBuf2DEMMEYvXIlU2KdQGISDe09T8cEBp/JHdIeTMLU=;
 b=zQRERsJfa7T55oLvnCJgeP1Z8y54YSHDMqIpegBNwz/D5nLw3bA1RhTOgHSiiNplhu
 Y3xHxjluHzszO37Rvk1oTF3CMa837u8XaAx0g9ClCasyEPx22jfYzMZ7nI8ECgKNgbQe
 GUNa0qtH9ZrO4YSHCrUNPtbXCMFHAWA6GFFBY+OTKMaAHiGzHr21rJ5DqWwH0W8uOIQ0
 WY7pt3lsTX3Yz0DsKiMA87iaWOUvotPykBtbwIbDAY8TQhWlwKFznEFH0MbToRFRsJf/
 2OKtfh6vpWcre87giKm3k98N8tF2m2kA8Xmzgd6S8E4943iuitdFeNQ8dvpSW9WMf+/t
 nz+Q==
X-Gm-Message-State: AOAM53246ilpJPfYvEaYo22iOsjSQGiYi8SU67YyKV0T3pa4ZOtMsEFh
 M6KrcsDenvUfHnlGUEKMO6X5lCE4NLYFjUQXEQ6Qdwxn3dqtKPvoejRNYXR1xBVqpmwGuwrJQ64
 AdbY3m4nF29RHk0gj8/5tyr85JIYiWEY71otpmQ6uIg==
X-Received: by 2002:adf:df84:: with SMTP id z4mr18355488wrl.519.1643117056665; 
 Tue, 25 Jan 2022 05:24:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykX9Z09gHjcPtI7/ZjdztfQF3TWvj2kNgbHH+lViiPnjYVjMpuSFmy3f9HCngWET/i0aIKXg==
X-Received: by 2002:adf:df84:: with SMTP id z4mr18355467wrl.519.1643117056451; 
 Tue, 25 Jan 2022 05:24:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8000:9797:8f:1ed9:7596?
 (p200300cbc70f80009797008f1ed97596.dip0.t-ipconnect.de.
 [2003:cb:c70f:8000:9797:8f:1ed9:7596])
 by smtp.gmail.com with ESMTPSA id 11sm368265wmx.5.2022.01.25.05.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jan 2022 05:24:16 -0800 (PST)
Message-ID: <a4faeaa3-ed16-3ee8-8e1d-71bc1029e1f5@redhat.com>
Date: Tue, 25 Jan 2022 14:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/balloon_compaction: make balloon page compaction
 callbacks static
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
 mst@redhat.com
References: <20220125132221.2220-1-linmiaohe@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220125132221.2220-1-linmiaohe@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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

On 25.01.22 14:22, Miaohe Lin wrote:
> Since commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
> feature"), these functions are called via balloon_aops callbacks. They're
> not called directly outside this file. So make them static and clean up
> the relevant code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
