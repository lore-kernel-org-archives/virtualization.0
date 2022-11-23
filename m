Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931D1C4332F
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 15:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 37F414050C;
	Wed, 23 Nov 2022 15:37:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37F414050C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m6P+8V1/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMKQaHLSGZ7y; Wed, 23 Nov 2022 15:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DAB834032E;
	Wed, 23 Nov 2022 15:37:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAB834032E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7DBDC0032;
	Wed, 23 Nov 2022 15:37:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91D02C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6BCFF61092
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BCFF61092
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=m6P+8V1/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pH29dQ4bkD87
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:37:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAA5660F69
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CAA5660F69
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:37:26 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B618861DA6;
 Wed, 23 Nov 2022 15:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47180C433D6;
 Wed, 23 Nov 2022 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669217845;
 bh=UanCtzyfyh7s6GC+lB/BgGuUYEuJMVRrxquRNUED7QE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m6P+8V1/dZMe1Sdy38Jer2Kq0kWOQcWPpch/6FCsgX7mogbRiZx+nRYmaqo4cOT5c
 2VBhRCgyAp1QZeQHA3EETx8HSmmQjCOuPPa172HaY1MAN9akX9CNVq37lxVTz8BMr8
 BBLccHPaIU6D7mYb41M582jELquyQZxntjmwvKYXyotA//5tW/2MbJATyer9nFW/f0
 ufcjB46KzIThaQo20IBXLl20DeebxUayijZK5CPRM4y+7O6LBfTdsu4RRUcLHP5KOK
 b4r/lHFcNKfmA5EJjEfSCvbMR52QJimK5ICXr91dLn0KonGcS4j6q3bU+aNI+8DhYx
 YzSjHFJvVHfAg==
Date: Wed, 23 Nov 2022 15:37:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 4/9] dt-bindings: drop redundant part of title (end)
Message-ID: <Y34+KaMMI5H/qBlI@sirena.org.uk>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20221121110615.97962-5-krzysztof.kozlowski@linaro.org>
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
Content-Type: multipart/mixed; boundary="===============5171827105409705212=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5171827105409705212==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3/TYdFfqHAXL0OZ"
Content-Disposition: inline


--c3/TYdFfqHAXL0OZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 21, 2022 at 12:06:10PM +0100, Krzysztof Kozlowski wrote:
> The Devicetree bindings document does not have to say in the title that
> it is a "Devicetree binding", but instead just describe the hardware.

Acked-by: Mark Brown <broonie@kernel.org>

--c3/TYdFfqHAXL0OZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN+PikACgkQJNaLcl1U
h9Axvwf9HW9i1/TYYTLxyy8fUtu5a3P9a9v1aqZ5Vk5GOoY4gLBJ+Nn6TQz4e3WA
B/mLs0ELXPm3nJVTGPQfpqgCN3STLaUwDcVJIskltCSFn08YUWFcyfkQWyBkAWym
cNTiF+sk8z6Aw5orSNcjJFWhpEZejA/1yQ+eBJbfm3d44vR/G2D5tMGJXmbE3rEA
bRa98QZef1l34JDi6+gadC0w7LX4jj8Q41K/mjRuLqdmV6BUstQvCsKC/8YIeoua
G3jLmit5vd8KXG2eEiqK2lY2t5FBYlNLXqLoaE2yjZFcmvABd6Vh/2JDcOOFeBpK
sPr6SAIesrsLQzCHS/nuT/saF9E/UA==
=p0qY
-----END PGP SIGNATURE-----

--c3/TYdFfqHAXL0OZ--

--===============5171827105409705212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5171827105409705212==--
