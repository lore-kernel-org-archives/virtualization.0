Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1445EC4346E
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 15:47:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E74E2344C
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 15:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YC+WDN2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E74E2344C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D7F5A86B15;
	Thu, 24 Sep 2020 15:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rxa4kVRX4Ve7; Thu, 24 Sep 2020 15:47:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4428186B12;
	Thu, 24 Sep 2020 15:47:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D62FC0890;
	Thu, 24 Sep 2020 15:47:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6357DC0859
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 15:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4FE5B86BAD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 15:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1jXTV86wWvc2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 15:47:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6AB3286BAC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=qc5JXV13U/VUfIz1+Qfz+XAsujxBI5R8St3MEEbVRIg=; b=YC+WDN2UsHdLRUqIPkY6NU1zOq
 pTOI48Y3JjopfrDzA9z5xfIMpsqQe9fZyAAljojPJPl82x5S7OxCY/f5tcVwxF+CU7J24FgvrgIGX
 J2HLoOavodyTdMdX904oNPA+q4s0/PrkI1BLTKM87xoKtv+o1ZzAYqevLHci9oeF56jbb9GyuysNt
 Jpi1H6Oi1tdgQMSkeeKjdUaj8n/fUJWx+bl+WBl36MUEffKTdbg22WbpwFwKHy3bXWfSGWRRHa6tR
 Tuw+E1eKhss7s1AnhVCdiffZPnAwFX3k2UZ1x6bcFrnUoiFc8Q7tuTtAcrWLhimWR6WI32EQqWGeR
 tUzQDpyQ==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLTSg-0002U1-05; Thu, 24 Sep 2020 15:47:10 +0000
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
To: Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <73f7e48b-8d16-6b20-07d3-41dee0e3d3bd@infradead.org>
 <20200918082245.GP869610@unreal>
 <20200924052932-mutt-send-email-mst@kernel.org>
 <20200924102413.GD170403@mtl-vdi-166.wap.labs.mlnx>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <079c831e-214d-22c1-028e-05d84e3b7f04@infradead.org>
Date: Thu, 24 Sep 2020 08:47:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924102413.GD170403@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

On 9/24/20 3:24 AM, Eli Cohen wrote:
> On Thu, Sep 24, 2020 at 05:30:55AM -0400, Michael S. Tsirkin wrote:
>>>> --- linux-next-20200917.orig/drivers/vdpa/Kconfig
>>>> +++ linux-next-20200917/drivers/vdpa/Kconfig
>>>> @@ -31,7 +31,7 @@ config IFCVF
>>>>
>>>>  config MLX5_VDPA
>>>>  	bool "MLX5 VDPA support library for ConnectX devices"
>>>> -	depends on MLX5_CORE
>>>> +	depends on VHOST_IOTLB && MLX5_CORE
>>>>  	default n
>>>
>>> While we are here, can anyone who apply this patch delete the "default n" line?
>>> It is by default "n".
> 
> I can do that
> 
>>>
>>> Thanks
>>
>> Hmm other drivers select VHOST_IOTLB, why not do the same?

v1 used select, but Saeed requested use of depends instead because
select can cause problems.

> I can't see another driver doing that. Perhaps I can set dependency on
> VHOST which by itself depends on VHOST_IOTLB?
>>
>>
>>>>  	help
>>>>  	  Support library for Mellanox VDPA drivers. Provides code that is
>>>>
>>


-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
