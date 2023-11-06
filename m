Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C92EC4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 19:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BABC541596;
	Mon,  6 Nov 2023 19:32:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BABC541596
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SH7Y1GQb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1gGxBX_8ELEz; Mon,  6 Nov 2023 19:32:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B148400C5;
	Mon,  6 Nov 2023 19:32:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B148400C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B71BDC0071;
	Mon,  6 Nov 2023 19:32:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB74DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 19:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFAB541596
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 19:32:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFAB541596
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZpehNYLScWm
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 19:32:31 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3E1F400C5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 19:32:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3E1F400C5
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7bae0c07086so1427684241.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Nov 2023 11:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1699299149; x=1699903949;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DAHtCI4uX5rSDG9hdPsxsTF21tKIZfBDAKE7xDsp3rU=;
 b=SH7Y1GQbUyt7VmjM8SYBRKDLenK1W33RNvokdFG0rUAB2B410gmltzKXdzOlihbrSU
 pTMgtJI5UhlTZJtJ6ASiLtbRVyLfxxVCpF7T/pHrzxbHoRql8Sl0gXoap6k1Ssf/KQYx
 xYkeeD0ZLZxgTw85ON+DOhZbJo96ck1e9kECjQf0XNNydf5kFy1pVBdSgVUQKqaVYgud
 LMljWDsRFLW3/Pp2OKGrt0vhLJoJqOBK6GlQqQl2k3tif+s9hYw5Weo1G/XtRJ87dTy5
 +nw1Bl6kMOJ/ua/Eyhv09xJ/AFBj8jUklTMVISIQ8DOOCQ/p4VxqGN7ziIVmUt5f+FJ0
 9KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699299149; x=1699903949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAHtCI4uX5rSDG9hdPsxsTF21tKIZfBDAKE7xDsp3rU=;
 b=w9Wy2ufnpAee2nlUv82RXU0H/HSBfgSJkaS8JNOn7ClOV1jPc3ujdIJkLF9xy6k7Dp
 1aCnk0rPK7dcPo8xuNgCfFB/zeCL034I7H6M7FdyduWpPtWVaONIihAJkrRKpLZnGcFM
 ssJ3tANv+EBFzO/OKXP9GRT7p2369K4IbBhDw5JckAYIuEWLcYlkyosf5sFdFX+KzONq
 N3LNQqwz6kD99suUzIUhG7aVAMDHEgYwFwWaReNuc8Rb7HLjVbdsKrNaq1RwItW1vQbp
 hObk3SIKv3OibGMfz2v+ZZ3lESTgXEEec3wNZlLm+ZKY68uwbj40OmQIylBCrLDztq0U
 jEQg==
X-Gm-Message-State: AOJu0Yw7YoZapNM6cfUvDIbh2O65d5g/Rt4Eq0Jsp8Buh4qBzBsv3Vki
 dqnyVtDZyVGfNHxIhmbKNPYGMw==
X-Google-Smtp-Source: AGHT+IHHrThxyHmJktLceZ794OYsaOv21wFux00FTZbUeam8b2XhNtl+ya1TeSFos/G045SdeP1ylg==
X-Received: by 2002:a1f:1c4a:0:b0:49b:289a:cc4a with SMTP id
 c71-20020a1f1c4a000000b0049b289acc4amr27005359vkc.3.1699299149465; 
 Mon, 06 Nov 2023 11:32:29 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 b3-20020a0ce883000000b0066cfd398ab5sm3663160qvo.146.2023.11.06.11.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 11:32:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1r05Km-001Qut-BY;
 Mon, 06 Nov 2023 15:32:28 -0400
Date: Mon, 6 Nov 2023 15:32:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Subject: Re: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table support
Message-ID: <20231106193228.GU4634@ziepe.ca>
References: <20231106071226.9656-1-tina.zhang@intel.com>
 <20231106071226.9656-3-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231106071226.9656-3-tina.zhang@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 will@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
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

On Mon, Nov 06, 2023 at 02:12:23AM -0500, Tina Zhang wrote:
> Add basic hook up code to implement generic IO page table framework.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/intel/Kconfig |  1 +
>  drivers/iommu/intel/iommu.c | 94 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.h |  7 +++
>  drivers/iommu/io-pgtable.c  |  3 ++
>  include/linux/io-pgtable.h  |  2 +
>  5 files changed, 107 insertions(+)

If this is going to happen can we also convert vt-d to actually use
the io page table stuff directly and shuffle the code around so it is
structured like the rest of the io page table implementations?

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
