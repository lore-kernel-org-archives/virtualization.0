Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E30FC4332F
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 15:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE906817ED;
	Wed, 23 Nov 2022 15:39:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE906817ED
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F3k9sXYZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7sDfwVK26uNK; Wed, 23 Nov 2022 15:39:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F3EB81773;
	Wed, 23 Nov 2022 15:39:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F3EB81773
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43772C0032;
	Wed, 23 Nov 2022 15:39:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9132C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 893DE4055D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:39:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 893DE4055D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=F3k9sXYZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o0lCSwpvzHLV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:39:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09D444042B
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09D444042B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:39:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5D3C161D96;
 Wed, 23 Nov 2022 15:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9DFC433D7;
 Wed, 23 Nov 2022 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669217954;
 bh=pCgyV6URGkswg9KKfkXhBda5Iki1k2lO8qrKykFSEt8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F3k9sXYZXMZbJL2KgSGmWiPRXMvHRdfTCIP9VQmjXd650/uUYXwTHEqUWxxttSOWT
 hB9b2sL956S0bUti6tuHTy2XEt5HjAbHeCo+axvVAD2rZcRJx2sPwnWchFDK3MrGxa
 yAlYOmKN8Mg4CXN+fkDD7QVG2+Cel0JnNA0akTveOPTARV97+qqsyEi6hpO6vdCsSE
 LSyr4JBajkK5pYVRAYm5iecBZGybtYAXBVbkB+5aKcTmslEywj8Jzp0bx/0VpZMrY2
 D5rI9GA2AAWuXzKpflAIq18/MHA6MmSTayBSrTtAwCYcKH0rMZJiTAzR77dwqComaB
 rsQQ9HVyYiq1w==
Date: Wed, 23 Nov 2022 15:39:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 5/9] dt-bindings: drop redundant part of title (end,
 part two)
Message-ID: <Y34+lGKAxewL8B1w@sirena.org.uk>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20221121110615.97962-6-krzysztof.kozlowski@linaro.org>
X-Cookie: I'm rated PG-34!!
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-rtc@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============3871425490177529640=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3871425490177529640==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3A/ckh57FM2wa6K8"
Content-Disposition: inline


--3A/ckh57FM2wa6K8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 21, 2022 at 12:06:11PM +0100, Krzysztof Kozlowski wrote:
> The Devicetree bindings document does not have to say in the title that
> it is a "binding", but instead just describe the hardware.

Acked-by: Mark Brown <broonie@kernel.org>

--3A/ckh57FM2wa6K8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN+PpQACgkQJNaLcl1U
h9D31gf/diT1M+7KeH7O9XMaZE9GvQx7EpNfWPd6EPxvzUkePN6w8u24ztB2s1gn
LKqFnrfx5FQwvbCsjmuHqePIJ6kdBJHpd8zn0XYx/cJQJlR/lFm5FPbdjhDnfcCC
lH4+dPqm7Tms/Dmlw8z49shzkjbAkN5O81QNFCdqvgYfp94E6kUVysgHobbu7DzT
8dtk4IMR8dgd1gsVYd3RlfLDv7zlhti06pOwAYvL7I/+ELvcFRXtGgOq8p8EMd//
e9dFGh61GX0//8+cYUSUG2Qb/npn7nA2mFko17JRUU21NrTgMn1qbJvntYvhfKqj
AqDREqKbfhSeQVkKulAfyfkiBA4hNg==
=SxY0
-----END PGP SIGNATURE-----

--3A/ckh57FM2wa6K8--

--===============3871425490177529640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3871425490177529640==--
