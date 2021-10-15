Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BDEC433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 19:13:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E01360F11
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 19:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E01360F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14DEF8272D;
	Fri, 15 Oct 2021 19:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ywas7HGaOQI0; Fri, 15 Oct 2021 19:13:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0C471826EF;
	Fri, 15 Oct 2021 19:13:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBBA7C0011;
	Fri, 15 Oct 2021 19:13:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0C23C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 19:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BC5D40239
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 19:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GFGBw6gokM2q
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 19:13:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C98A401DC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 19:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=jpGCHkuYdSR/3o8eROnu0R5nGfFS1MAWWpnW00KwYzU=; b=zDsy6j+Ognfw5Bft8Wp9MkJykI
 9CrolxOt/BLOIQYoC27bl0XyK/Ul0rd4GzwS6XoCscf/zW8K6l4QjtksKsXcPRO0SQfgaKoCzuSjg
 P2DtKOzL9Ew42VETiQEMNvUIcBeggIAj8OBthdi0UVm5s+obe5Yz4ue+lrUyIJmBIYBDBdhY0p4ob
 nN6EK+LsxSEjzC9gE58tP+WROvgi9zmjV21wpC2w036VJgA1yQsZj+GJlRTaAjaLZ/ki0HM6giSCL
 OeUnPjbzGYNBOanB8kSHqif/GC25cLuYBE2G+sCxLz9rDseKGTWfr0b3p9mu2cWam7Et640z/AwFC
 6vJ5/rOg==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbSeB-008aka-LI; Fri, 15 Oct 2021 19:13:39 +0000
Subject: Re: [PATCH v5 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
To: Wu Zongyong <wuzongyong@linux.alibaba.com>, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <57a04a9e516ec4055cb887e9c7b24658ca5b0228.1634281805.git.wuzongyong@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2a92f30a-3ffa-70cb-a054-8bd7b6326ade@infradead.org>
Date: Fri, 15 Oct 2021 12:13:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <57a04a9e516ec4055cb887e9c7b24658ca5b0228.1634281805.git.wuzongyong@linux.alibaba.com>
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

On 10/15/21 12:15 AM, Wu Zongyong wrote:
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 3d91982d8371..c0232a2148a7 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -78,4 +78,12 @@ config VP_VDPA
>   	help
>   	  This kernel module bridges virtio PCI device to vDPA bus.
>   
> +config ALIBABA_ENI_VDPA
> +	tristate "vDPA driver for Alibaba ENI"
> +	select VIRTIO_PCI_LEGACY_LIB
> +	depends on PCI_MSI && !CPU_BIG_ENDIAN
> +	help
> +	  VDPA driver for Alibaba ENI(Elastic Network Interface) which is build upon

	                          ENI (Elastic Network Interface)         built

> +	  virtio 0.9.5 specification.


-- 
~Randy
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
