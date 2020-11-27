Return-Path: <SRS0=QmqV=FB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D80EC3E8C5
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 18:45:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813A521D7F
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 18:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jl3letpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813A521D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2FD4987AAA;
	Fri, 27 Nov 2020 18:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sggs1bIb6spH; Fri, 27 Nov 2020 18:45:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8561687AA1;
	Fri, 27 Nov 2020 18:45:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F89FC0891;
	Fri, 27 Nov 2020 18:45:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5EFAC0052
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 18:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8717287729
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 18:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQForD1eHru4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 18:45:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E3C3787551
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 18:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=rhJY7wLAspkaYEzHkh+yVX+skQbZ/DMKzfC009QO4I8=; b=Jl3letptNo6u4QgElIXiUuVDjW
 td6bdKE9PaWZb/3s15iGapD4moQGO+8TeXlAArrzMZ0OLWEEmQy47u8STeR5T/BsPWgQSri8vmCa/
 D2JxjFG10Vkzgk4028eQdXoJjws2M5CS34SO9fxczCPNSiCnr2f3IYBSymn6Q6ZjwcRzEpYwNLR15
 ehIYizH0dHbVe4NJ9kds1RVL2QVzFxXHrrBpTFCbYhmjpxIAsrd94lnDruwV1cWGF0qtvmbVJlePv
 4ar/h3Ajh9e/YfDCORx/Trj81HpwhhsyBNBdY6nNX/mUasID1wrJnagY6T+QGMcQs70gGxpKTUo1o
 kmioOo1A==;
Received: from [2601:1c0:6280:3f0::cc1f]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiike-0000vy-Et; Fri, 27 Nov 2020 18:45:48 +0000
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 linux-kernel@vger.kernel.org
References: <20201127183003.2849-1-info@metux.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ba756539-2435-3587-3aeb-31e7ce95aad7@infradead.org>
Date: Fri, 27 Nov 2020 10:45:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201127183003.2849-1-info@metux.net>
Content-Language: en-US
Cc: linux-gpio@vger.kernel.org, linus.walleij@linaro.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, bgolaszewski@baylibre.com,
 linux-riscv@lists.infradead.org
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

On 11/27/20 10:30 AM, Enrico Weigelt, metux IT consult wrote:
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5d4de5cd6759..e8414d82cf75 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1613,4 +1613,13 @@ config GPIO_MOCKUP
>  	  tools/testing/selftests/gpio/gpio-mockup.sh. Reference the usage in
>  	  it.
>  
> +config GPIO_VIRTIO
> +	tristate "VirtIO GPIO support"
> +	depends on VIRTIO
> +	help
> +	  Say Y here to enable guest support for virtio based GPIOs.

	                                         virtio-based

> +
> +	  These virtual gpios can be routed to real GPIOs or attached to

	                GPIOs

> +	  simulators on the host (qemu).
> +
>  endif


-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
