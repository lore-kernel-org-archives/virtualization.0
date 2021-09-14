Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B55C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 22:37:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8954E6112E
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 22:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8954E6112E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 516148183D;
	Tue, 14 Sep 2021 22:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5VGvWLzfUw-s; Tue, 14 Sep 2021 22:37:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1D68581831;
	Tue, 14 Sep 2021 22:37:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E387FC000F;
	Tue, 14 Sep 2021 22:37:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E89BC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0AFC7607AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 70fpVfWsNwGX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:37:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84074605A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=cl7UIjCTs1b0KsfXtz6K9iVGx4kWZVf7z5I2bRPh74A=; b=dFFvdcTmcRbqGaT8IsF/AUegtm
 dks6cALCpathKp0032DBi/kakZAvNnbMu2gWMv69Po+1cmxpOa3yXKNGXuvjbFSpAza28qB4JeUoA
 siPW4gQSivNQUOICctwN8p1m9tcmE6JYi75ptc1PR3bFL17UCoAe7vV8kvwwD62uX98JdL45xF6pj
 BJELET3g57V03XK6B5PyC5T3goYFGwyrSwAH9zH2DjlLPbmQgwvA8AF9FQpkXqKUU0AlLWHiz1sE2
 uldWZHHABf++0ne5tcA645N5aP98srburh1QqB93/T+otKWGfl4JYDgMvN//lF5aex4KHzAgsNx6s
 XEFv2utw==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQH3j-007Rsg-7C; Tue, 14 Sep 2021 22:37:47 +0000
Subject: Re: [PATCH v2 1/5] virtio-pci: introduce legacy device module
To: Wu Zongyong <wuzongyong@linux.alibaba.com>, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <f833e77685cd1dfadc5c3b6688d29a0d1383dbb9.1631621507.git.wuzongyong@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ff4bc96-390d-5a75-a881-b7042822bd2b@infradead.org>
Date: Tue, 14 Sep 2021 15:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f833e77685cd1dfadc5c3b6688d29a0d1383dbb9.1631621507.git.wuzongyong@linux.alibaba.com>
Content-Language: en-US
Cc: wei.yang1@linux.alibaba.com
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

On 9/14/21 5:24 AM, Wu Zongyong wrote:
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index ce1b3f6ec325..b14768dc9e04 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -20,6 +20,15 @@ config VIRTIO_PCI_LIB
>   	  PCI device with possible vendor specific extensions. Any
>   	  module that selects this module must depend on PCI.
>   
> +config VIRTIO_PCI_LIB_LEGACY
> +	tristate
> +	help
> +	  Legacy PCI device (Virtio PCI Card 0.9.x Draft and older device)
> +	  implementation.
> +	  This modules implements the basic probe and control for devices

	       module

> +	  which are based on legacy PCI device. Any module that selects this
> +	  module must depend on PCI.
> +


-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
