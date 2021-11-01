Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FB7C433F5
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:18:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DE760F46
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77DE760F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FFB980B5B;
	Mon,  1 Nov 2021 08:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RyoAaQycNaKG; Mon,  1 Nov 2021 08:18:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F1C8280B3D;
	Mon,  1 Nov 2021 08:18:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C80BAC0019;
	Mon,  1 Nov 2021 08:18:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A685C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 461C580B5B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HdZx58e3Pp1s
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:18:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F3BE80B3D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635754722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1VJ7I9+UXANPnUsj7WuJy/EQjAg507IxwXZkWzzQG2E=;
 b=GTogfy9mUt6UHrYNbFmAtbGwWo+CRg0hzYOWAhBoWiKGs8K+mvfN3RF73OxMnje5550ClO
 v9ibO9bqPFOXm5qXn+Rxt2Mad+NryB4xkX/kJkhU1+KZNSD/CKxqCghhI6oO6ouUVGhdjT
 rZpFNs80sjLryoeM9ucxzWXyXCTuptc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-0yGg-lb3Oj2cS0jRrTQd-Q-1; Mon, 01 Nov 2021 04:18:39 -0400
X-MC-Unique: 0yGg-lb3Oj2cS0jRrTQd-Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 g3-20020a056402424300b003e2981e1edbso334830edb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 01:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1VJ7I9+UXANPnUsj7WuJy/EQjAg507IxwXZkWzzQG2E=;
 b=yfdRzwSVtFThEy8YQ2W8dO0Yir/qEwjxYwKfqkedxnFbPu+Jnszj91d4z1jNV++389
 0VL3xZ2knuGA1BRt4nTF71PvHTR8BmPOpj6iYBB1vLEGPltJRqMoI+C3dQcX97sifve/
 kDI2oSSG9CvPT0x7nvOCOd1lzgUvUWg6zR8sV8Aby1Hof9QnY/IpnQLaBKHvV+vycl9D
 Jac2r5BEPZnGz3r62WWsc2VijB6+lW9JHFuChJU05jzesBfDOt9pBmLLhZXR6I3nQG03
 7nx53BqCg34uUqXimvti/KRe/qASkyVwnEW7CL8rq+NezXOhp0g/KzY8NjZB5dJA/NsQ
 NMmQ==
X-Gm-Message-State: AOAM532cbLAqnJJmtZYU4HkG1C1JaQRVD93SQdr30OuzvaJfaa4SNykC
 XwVUd4Dtq0Lngk8PnPpAqnGPDLnlBXRQ/bpb8ADFeqiNb3toChsNQqiSKmZCbNumoD0To6CHX9T
 JbP5SyPiIpw4cEdCw0MgHAOMhv4IzUODx552MWhWXVw==
X-Received: by 2002:a50:9eab:: with SMTP id a40mr39722373edf.281.1635754718315; 
 Mon, 01 Nov 2021 01:18:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjgeNnO1O2bOJHQh8lmeLqGbJq9Vgsp7BeICMK7EiQVwicym1EUAm8TwLuENIy8A/xBTFpNg==
X-Received: by 2002:a50:9eab:: with SMTP id a40mr39722356edf.281.1635754718179; 
 Mon, 01 Nov 2021 01:18:38 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
 by smtp.gmail.com with ESMTPSA id g10sm7504925edr.56.2021.11.01.01.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 01:18:37 -0700 (PDT)
Date: Mon, 1 Nov 2021 04:18:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Subject: Re: [PATCH v7 9/9] eni_vdpa: alibaba: fix Kconfig typo
Message-ID: <20211101041739-mutt-send-email-mst@kernel.org>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <cover.1635493219.git.wuzongyong@linux.alibaba.com>
 <0945b37f19b96ecadb79a4e1b01f486119a0b83a.1635493219.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <0945b37f19b96ecadb79a4e1b01f486119a0b83a.1635493219.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@arndb.de>, wei.yang1@linux.alibaba.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Oct 29, 2021 at 05:14:50PM +0800, Wu Zongyong wrote:
> The Kconfig symbol was misspelled, which leads to randconfig link
> failures:
> 
> ld.lld: error: undefined symbol: vp_legacy_probe
> >>> referenced by eni_vdpa.c
> >>>               vdpa/alibaba/eni_vdpa.o:(eni_vdpa_probe) in archive drivers/built-in.a
> 
> Fixes: 6a9f32c00609 ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

This one I'll squash into the previous one. That commit hash is not
going to match anything useful.

> ---
>  drivers/vdpa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 07b0c73212aa..50f45d037611 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -80,7 +80,7 @@ config VP_VDPA
>  
>  config ALIBABA_ENI_VDPA
>  	tristate "vDPA driver for Alibaba ENI"
> -	select VIRTIO_PCI_LEGACY_LIB
> +	select VIRTIO_PCI_LIB_LEGACY
>  	depends on PCI_MSI && X86
>  	help
>  	  VDPA driver for Alibaba ENI (Elastic Network Interface) which is built upon
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
