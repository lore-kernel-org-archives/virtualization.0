Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A752FC433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 16:10:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FE8233A1
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 16:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FE8233A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 79B2985082;
	Wed, 20 Jan 2021 16:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OeqqCo1RAW90; Wed, 20 Jan 2021 16:10:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 05329848A0;
	Wed, 20 Jan 2021 16:10:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2C2EC08A1;
	Wed, 20 Jan 2021 16:09:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04FE9C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 00651848A0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kkxJeEqjoqsU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:09:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9B09B847C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:09:11 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id p22so26368179edu.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uFPoWmdT1E7447c/foHDjqNJuO8UPeUXJAj8ZTCeNuI=;
 b=bNp4m8GXBuiU/FXyjO9D9cA/C4gIGIPznUcpKtSxPEKyebwvVQ+aRwdeBURGW60Aqn
 LWDM8IY14JaXyGVpmy9pspE7lfObh3UXUk1T9JUoE9m742jY/UWqwZOuCBJ1bPyIODGl
 UnlPbfbmqFegwGszXH5A2WM1t7WLON4F/hTTf41tPfVOHi9uvgUn8pBT7w/CdD4OSxCR
 Pj4XoIeByZmeoQNQ4FhMnueL2wZ9/ttGENz2s0DHc9xIW18UNCzE7rgOV30lEB4IWM6K
 z43ISZVwDPuNuqM8j3RZAlGmRUAK0i/ai2ThrTF7kmw/zPRYVf/biTfeZ/ArEDWa+95U
 iDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uFPoWmdT1E7447c/foHDjqNJuO8UPeUXJAj8ZTCeNuI=;
 b=V1qzvBgFX3PkQcmYvvHAPnTtSiKW/vVD+ZF8647NC1ixiCN3SJomLhe7zjoXSTtScN
 w0Fzs/GcLdrwrH8ID2OvTZxmlSEwf9rgtJIWRCeeMskh/52Q0GvWZuNfNFvj+Zo514PY
 WMW2VqZfhNSNlld+4XI478kIH5XiskhACOoIsMGh0M8jc+JapKopm0DrQc4Gvuvut55s
 Quu6nfL4yjRW6mthZzm9oeL9D+OKwvVRbJseR2dirW0hanfryOT7SHg/TV0c9zwyqMvP
 fjLVArB5B+bPDZ8P8yJ9rA5l+YKNALcox5Tje1IrMUfYbOMB35FFnKMDWVWoOlNmym2M
 LHSw==
X-Gm-Message-State: AOAM531+VEHJpfv54SbNgg2wum188iDBQpp3xKnIJFp2v3+qmuuYrp1a
 93iAXdmqA4CJPMDBeVjoFEas/pAu408JukUi6HtpJQ==
X-Google-Smtp-Source: ABdhPJzzrx43U/MRM+U+2IS6fjT5/s61ISkHSJJW/uV0YTHN3o25ui9xpDMoE2/qruoEGyRFVzUk7yyVBnemuDxnOFQ=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr7685979edq.153.1611158950213; 
 Wed, 20 Jan 2021 08:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-5-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-5-wei.liu@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 20 Jan 2021 11:08:34 -0500
Message-ID: <CA+CK2bByGvCr_H3_wv_3-vAOONhRenonFNeHff5UdeFLDxSoUw@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] iommu/hyperv: don't setup IRQ remapping when
 running as root
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Joerg Roedel <jroedel@suse.de>, Stephen Hemminger <sthemmin@microsoft.com>,
 Will Deacon <will@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>, Joerg Roedel <joro@8bytes.org>
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

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> The IOMMU code needs more work. We're sure for now the IRQ remapping
> hooks are not applicable when Linux is the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/iommu/hyperv-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 1d21a0b5f724..b7db6024e65c 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -20,6 +20,7 @@
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
>
>  #include "irq_remapping.h"
>
> @@ -122,7 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>
>         if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
>             x86_init.hyper.msi_ext_dest_id() ||
> -           !x2apic_supported())
> +           !x2apic_supported() || hv_root_partition)
>                 return -ENODEV;

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
