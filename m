Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62129C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 22:35:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2806113B
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 22:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A2806113B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5C6380DD7;
	Tue, 14 Sep 2021 22:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TM7lL-OaZutQ; Tue, 14 Sep 2021 22:35:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 87D1B80DBE;
	Tue, 14 Sep 2021 22:35:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B6F4C000F;
	Tue, 14 Sep 2021 22:35:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0B51C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDB7280DD7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:35:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zNtcQpj1gvQh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:35:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0E4F80DBE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 22:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=UU8NPRmd+WrsnL1h2xgrcQ/YKA6+gLoFDMON/ybQaQ0=; b=c1OtSLFAo4M0NNPtWPVb8JIekI
 IaIzxdSMDGHpnQ/h3DlU2zriGdjS+nPr3bdvx1StU1I1WMJ5rYeVznEjTJnoDPnTjx2iseFgWUwqJ
 hCO/4qyxYlXfq0wDbsVDj7Bn+HHoLMtdZ8bO2cSBqRUXTUnGMK4+4JY4yNKtQ39jdMSnesezOoIQf
 StRqZ1SHCGbdngAZxqPWyfsCFFXHBLWuBb9JZQBYEBHReBDfn8hlhUcFkRig4FSoLNsBVrnlElwoL
 v2jorbiu1PiozSKgb8x3q2HUl81ofXrQmn8WTNlVvdOWE/uVHAdUUgnyq6t1FQw2D4bxy9dBdGvb0
 ZNdbqvGQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQH1O-007QoH-OK; Tue, 14 Sep 2021 22:35:22 +0000
Subject: Re: [PATCH v2 5/5] eni_vdpa: add vDPA driver for Alibaba ENI
To: Wu Zongyong <wuzongyong@linux.alibaba.com>, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <ab98427764198053b4277a127eaea3f32cd40ed5.1631621507.git.wuzongyong@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef57dd1f-e94c-f5f2-6226-8ae53c22bb38@infradead.org>
Date: Tue, 14 Sep 2021 15:35:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ab98427764198053b4277a127eaea3f32cd40ed5.1631621507.git.wuzongyong@linux.alibaba.com>
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
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 3d91982d8371..9587b9177b05 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -78,4 +78,12 @@ config VP_VDPA
>   	help
>   	  This kernel module bridges virtio PCI device to vDPA bus.
>   
> +config ALIBABA_ENI_VDPA
> +	tristate "vDPA driver for Alibaba ENI"
> +	select VIRTIO_PCI_LEGACY_LIB
> +	depends on PCI_MSI
> +	help
> +	  VDPA driver for Alibaba ENI(Elastic Network Interface) which is build upon

	                          ENI (Elastic                            built upon the

> +	  virtio 0.9.5 specification.
> +
>   endif # VDPA


-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
