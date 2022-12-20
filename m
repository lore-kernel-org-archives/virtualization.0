Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DB7C10F1E
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 10:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3B2081396;
	Tue, 20 Dec 2022 10:01:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3B2081396
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=EQV5Zbu8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6KNlxxhBjgdh; Tue, 20 Dec 2022 10:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD15681393;
	Tue, 20 Dec 2022 10:01:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD15681393
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63D84C0070;
	Tue, 20 Dec 2022 10:01:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 719EFC0035
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F7FD81396
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:01:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F7FD81396
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z7gyJ5udgsDb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:01:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B06981393
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B06981393
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:01:32 +0000 (UTC)
Received: from [192.168.231.135] (unknown [213.194.155.136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 87C34660000F;
 Tue, 20 Dec 2022 10:01:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1671530491;
 bh=flyXusJqODPJKu6TN7Auaug9fZjIJwX+0zuYbQTZJaY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EQV5Zbu8P1X1vzeGTnGT6qRI3PvvMoyNmNH6g8UAfMznKvr/E/zCRb8kbmt/LmSJf
 KoKUIIvHJBDXUGMQKCRBS/rCGOHxAQ+r8Tato4vAdProkDAKHd6gZr5DFBwdZMcHkA
 XXnYXlM6Zbb9IlCkgdun5plMAOpyvXrrtCBQyXzqoLRfCWXIoEZ9lPRdj0GW7wzT3+
 4iOSV5VZSZDYFUtBCv15FKpuR5j0+tFN4JIe6X+5geGxE63rwPTVh7BN1WqWAAo3UH
 4R+SmAs0rP4ydSFXzQoqB59Sgim2Aei4sJJuxLcIUHmlzQS6TwbaQSgdybgyN2jpHp
 frDplvDPRE/4g==
Message-ID: <77e45c9f-d2ec-e4a0-6114-200fa1fdd018@collabora.com>
Date: Tue, 20 Dec 2022 11:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] virtio: fix virtio_config_ops kerneldocs
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 mst@redhat.com
References: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
 <c0540d38-090a-abb8-654d-db61ce356349@collabora.com>
From: =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <c0540d38-090a-abb8-654d-db61ce356349@collabora.com>
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org, kernel@collabora.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 20/12/22 10:48, AngeloGioacchino Del Regno wrote:
> To avoid getting the same warning in the future (developer mistake and/or other
> reasons), what about dropping this instance of "Note:" entirely?
> 
> I think that something like...
> 
> the dev->feature bits if it wants. Note that despite the name....

Thanks for the suggestion, Angelo. Applied in v2.

Cheers,
Ricardo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
