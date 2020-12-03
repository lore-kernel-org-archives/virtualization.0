Return-Path: <SRS0=OlB3=FH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C8FC433FE
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:26:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFC1207B0
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFC1207B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60CEC87574;
	Thu,  3 Dec 2020 17:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RspGLg01Dbt7; Thu,  3 Dec 2020 17:26:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 87D2287445;
	Thu,  3 Dec 2020 17:26:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6186AC163C;
	Thu,  3 Dec 2020 17:26:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B8F8C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 115E587366
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mx5vnD8zp9jk
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:26:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CFA26870A4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=1ys3tD29yyXiFC0wdrbI9llPCLLvllG6Avtg8Riop2w=; b=Ktj16xIdTj3m+YMFkFDzvgkkc/
 BWsyux4yLGkgmExSv1HICil5cSWVbbPvIpJVFtlZftQBQGAne4ys3cbQ6QBTTmNfDMX7VRf0Ah5n9
 kTOs7rzItjdLzvl+sTP7n96dfUg10qQ8AG7WjHPjs0dU7z7kMArROSJmugAJ35vkE3izte/rz343g
 n0Z6YlZqOrchcI5LtdioiEZvrtIBvCs36g+qFUbzE4qlh9YHRgAWWgqor467dCPM1d2OnEXATMXnD
 UanaImtP8rYDQvmiPS78bVHf7xWNPJShHMCyZ8qXmt+WFQuZjNSp0i+wF7nnEPrDd8pg2L2hZ6XLR
 HoBL5ooA==;
Received: from [2601:1c0:6280:3f0::1494]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kksMh-00057z-0N; Thu, 03 Dec 2020 17:25:59 +0000
Subject: Re: [PATCH v3 19/19] vdpa: split vdpasim to core and net modules
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-20-sgarzare@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <920c4975-a3ae-b7f9-ac89-6444ca2e4c45@infradead.org>
Date: Thu, 3 Dec 2020 09:25:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-20-sgarzare@redhat.com>
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

Hi,

On 12/3/20 9:05 AM, Stefano Garzarella wrote:
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 2c892e890b9e..b0f91ad8eb47 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -9,15 +9,20 @@ menuconfig VDPA
>  if VDPA
>  
>  config VDPA_SIM
> -	tristate "vDPA device simulator"
> +	tristate "vDPA device simulator core"
>  	depends on RUNTIME_TESTING_MENU && HAS_DMA
>  	select DMA_OPS
>  	select VHOST_RING
> +	help
> +	  Enable this module to support vDPA device simulators. These devices
> +	  are used for testing, prototyping and development of vDPA.
> +
> +config VDPA_SIM_NET
> +	tristate "vDPA simulator for networking device"
> +	depends on VDPA_SIM
>  	select GENERIC_NET_UTILS
>  	help
> -	  vDPA networking device simulator which loop TX traffic back
> -	  to RX. This device is used for testing, prototyping and
> -	  development of vDPA.
> +	  vDPA networking device simulator which loop TX traffic back to RX.

	                                         loops


thanks.
-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
