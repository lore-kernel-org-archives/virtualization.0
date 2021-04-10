Return-Path: <SRS0=ZtZT=JH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA8C433B4
	for <virtualization@archiver.kernel.org>; Sat, 10 Apr 2021 18:17:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA79861108
	for <virtualization@archiver.kernel.org>; Sat, 10 Apr 2021 18:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA79861108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C8C44043C;
	Sat, 10 Apr 2021 18:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wRaUMqkSbvgH; Sat, 10 Apr 2021 18:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E648D403F6;
	Sat, 10 Apr 2021 18:17:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE792C000C;
	Sat, 10 Apr 2021 18:17:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E377C000A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Apr 2021 18:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C51F83BB1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Apr 2021 18:17:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=opensynergy.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lK9Lp8_BiA7l
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Apr 2021 18:17:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47A3583BB0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Apr 2021 18:17:18 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id CA77AA12B3;
 Sat, 10 Apr 2021 20:17:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=flMyugclSqb+
 wAO9k1tJ+ecrs2GxO/hHiLPPe7sDecM=; b=0DCITfk38Efzyum2sPHDo/2Ucbqj
 bQK0hAUSCZm0Cyx/ioFrkapdLShAKjLaDznkxqbMIxTzoQVtScPg60RNKhlCQJn9
 42aT+ofGidgl1jsTQINRjnwQdRXXcOs3p4WRq8Y4giWtrTm08jXm0VkuKMDwj03T
 X/gj8uw5d2enk5TuYvXZkR7Sq3k9Y9UCjUaNRXyK0V4vRBlN+j+L7ZaQkJnElSqv
 YBkb+hq1fOCAMuCYlXDIwuv1zaejCOn+O17J8CUNPjjbZmDbZFNiWFSGwSMfbHTr
 WVjVoh2ev5cd5RY2cUP5yqxsKu4K4Oddu2pqtXqXyV8/eC+N9vceact4wg==
Subject: Re: [PATCH -next] ALSA: virtio: use module_virtio_driver() to
 simplify the code
To: Chen Huang <chenhuang5@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>
References: <20210408125429.1158703-1-chenhuang5@huawei.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <d0c7f617-50ef-0d39-cbd2-11925eba24d0@opensynergy.com>
Date: Sat, 10 Apr 2021 20:15:45 +0200
MIME-Version: 1.0
In-Reply-To: <20210408125429.1158703-1-chenhuang5@huawei.com>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
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

On 08.04.2021 14:54, Chen Huang wrote
> 
> module_virtio_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Chen Huang <chenhuang5@huawei.com>

Thanks for the patch.

Reviewed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>

> ---
>   sound/virtio/virtio_card.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index ae9128063917..150ab3e37013 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -432,17 +432,7 @@ static struct virtio_driver virtsnd_driver = {
>   #endif
>   };
> 
> -static int __init init(void)
> -{
> -       return register_virtio_driver(&virtsnd_driver);
> -}
> -module_init(init);
> -
> -static void __exit fini(void)
> -{
> -       unregister_virtio_driver(&virtsnd_driver);
> -}
> -module_exit(fini);
> +module_virtio_driver(virtsnd_driver);
> 
>   MODULE_DEVICE_TABLE(virtio, id_table);
>   MODULE_DESCRIPTION("Virtio sound card driver");
> --
> 2.17.1
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
