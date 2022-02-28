Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213A1C4167B
	for <virtualization@archiver.kernel.org>; Mon, 28 Feb 2022 20:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAE4B80C58;
	Mon, 28 Feb 2022 20:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kvOrzM1V9tNw; Mon, 28 Feb 2022 20:03:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 69D9B80C62;
	Mon, 28 Feb 2022 20:03:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3456FC0077;
	Mon, 28 Feb 2022 20:03:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF6DC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 20:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0673C60AF6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 20:03:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IaFkdlqVxbOx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 20:03:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BD1B605AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 20:03:29 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9CAF360B12;
 Mon, 28 Feb 2022 20:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D75C340F2;
 Mon, 28 Feb 2022 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646078608;
 bh=mHHh973hMePN9wmM/jcpBb22Q6OGomp4QlydWc1Dh6w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=aCeGMO5xD8fsEhRGr4+eOr9z8MstaRRDVGhQ2JFOj5VttTy3IwU/54lJ+oouIG28u
 z81XCgIJowof9B0hR7N3AT4EL/cp1tR3vbL6RuXPasvJp4dShvWkyCbSLiUvoOUiy9
 Ch40bfT8hyQmBKmOBWB/wdlu+kbLkxch8hnE1YJuMD+DqGmnrqOp1buDYyiFRg9zyZ
 nZTjzG+1MPqyPE0xBXIt+SPfFuZFdVwk0yBkI7QA+0xdPnGZ8DjYwz0x7qT3uUHRRq
 N8JYHkY9orf+PL5YgJkzP9kJWMETh9P7vFNG2d7Sp1HIFzdd8vaKYbZBnn3S5kUq8h
 a4Caw+KYsuQwg==
Date: Mon, 28 Feb 2022 14:03:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 01/11] driver: platform: Add helper for safer setting
 of driver_override
Message-ID: <20220228200326.GA516164@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220227135214.145599-2-krzysztof.kozlowski@canonical.com>
Cc: linux-hyperv@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Fabio Estevam <festevam@gmail.com>,
 linux-clk@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Abel Vesa <abel.vesa@nxp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andy Gross <agross@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-arm-msm@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Sven Schnelle <svens@linux.ibm.com>, Shawn Guo <shawnguo@kernel.org>
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

On Sun, Feb 27, 2022 at 02:52:04PM +0100, Krzysztof Kozlowski wrote:
> Several core drivers and buses expect that driver_override is a
> dynamically allocated memory thus later they can kfree() it.

> +int driver_set_override(struct device *dev, const char **override,
> +			const char *s, size_t len)
> +{
> +	const char *new, *old;
> +	char *cp;
> +
> +	if (!dev || !override || !s)
> +		return -EINVAL;
> +
> +	/* We need to keep extra room for a newline */

It would help a lot to extend this comment with a hint about where the
room for a newline is needed.  It was confusing even before, but it's
much more so now that the check is in a completely different file than
the "show" functions that need the space.

> +	if (len >= (PAGE_SIZE - 1))
> +		return -EINVAL;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
