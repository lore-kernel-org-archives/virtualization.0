Return-Path: <SRS0=daDg=KY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9D1C4708D
	for <virtualization@archiver.kernel.org>; Sat, 29 May 2021 00:02:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE2F613B6
	for <virtualization@archiver.kernel.org>; Sat, 29 May 2021 00:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE2F613B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C40840E81;
	Sat, 29 May 2021 00:02:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BnUIur4Naxr1; Sat, 29 May 2021 00:02:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6F0A404A1;
	Sat, 29 May 2021 00:02:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8468DC000D;
	Sat, 29 May 2021 00:02:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C525AC0001
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 May 2021 00:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA03340E47
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 May 2021 00:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7iCMLy_AU9aN
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 May 2021 00:01:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CFDD404A1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 May 2021 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=wClK8t5OqOKAJXZRdJ7lK3nU0nLrVWRCjDxwfQ1YPMI=; b=oQEOU/XvSEfv8fMGMn0Ibiyl1G
 LKUmNpGddt8Mx4Rzc2n1OXVQygVaS1Hp3LuerB4w21NGojS/f0EQXiAzFBr1Wx0TXBk0i5ANHtKRJ
 tORl/HV+bZzjqJv3n8eqlqX5CJLFkASF/ji4lMdaKwVqP53Tjac61kBHeZKEj+N4Pu23FcC5xOn+V
 VKRsUwZNciWxbginuPe10cDX1Zs6DbxYi+3erBw1ms7nDb0Venf7+yUudFgO3hPOUQaaubHAgAW5O
 dVL+8ZZzNYUOxpoxQryTugtaikRc03ghdTOD+GqHfFjpcWM5edHLX/2Noj7eqktgzaSJcYUghauEZ
 mvXFD1JQ==;
Received: from [2601:1c0:6280:3f0::ce7d]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmmQF-001zoQ-B8; Sat, 29 May 2021 00:01:47 +0000
Subject: Re: [PATCH 03/19] drivers/hv: minimal mshv module (/dev/mshv/)
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e161e8cc-4d08-8bfd-ab1e-363ed5a39503@infradead.org>
Date: Fri, 28 May 2021 17:01:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
Cc: wei.liu@kernel.org, ligrassi@microsoft.com, mikelley@microsoft.com,
 virtualization@lists.linux-foundation.org, viremana@linux.microsoft.com,
 sunilmut@microsoft.com
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

On 5/28/21 3:43 PM, Nuno Das Neves wrote:
> Introduce a barebones module file for the mshv API.
> Introduce CONFIG_HYPERV_ROOT_API for controlling compilation of mshv.
> 
> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---

Hi,

> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 66c794d92391..d618b1fab2bb 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -27,4 +27,22 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>  
> +config HYPERV_ROOT_API
> +	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
> +	depends on HYPERV
> +	help
> +	  Provides access to interfaces for managing guest virtual machines
> +	  running under the Microsoft Hypervisor.
> +
> +	  These interfaces will only work when Linux is running as root
> +	  partition on the Microsoft Hypervisor.
> +
> +	  The interfaces are provided via a device named /dev/mshv.
> +
> +	  To compile this as a module, choose M here.
> +          The module is named mshv.

^^^^^^^^^^^^^

Please follow coding-style for Kconfig files:

(from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

> +
> +	  If unsure, say N.
> +
> +
>  endmenu

thanks.
-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
