Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55122C43217
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 20:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAF5460AA8;
	Wed, 23 Feb 2022 20:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NNM1BwoCBHXj; Wed, 23 Feb 2022 20:04:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B0AB6059B;
	Wed, 23 Feb 2022 20:04:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62C3BC001A;
	Wed, 23 Feb 2022 20:04:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D7C7C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 20:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73D04403E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 20:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O7Fa0kLwqNfo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 20:04:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31F8D403B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 20:04:55 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 58B54617B1;
 Wed, 23 Feb 2022 20:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3349C340E7;
 Wed, 23 Feb 2022 20:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645646693;
 bh=M0+mVIZ0Lc26AANZRRAz4t6SzyvF92PylFUdbqphFSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=htHMZ4ejkmVw5UZH147OWWvzPaFhKffm1si8PWKoQ3tnFx1yOLEVU9zQwxK66D03d
 wplmLYlyIr1r52XdFqTtlesPjts/kWIf+iN1ATyktMdKEcaUJvlYonZ1V6H/8HPLI/
 jMTrjWGhifOrhupEC9mn93Sk6u/MBMyXLCtr0HLQ/nz2PeL0MlAZGOz+uRBQ2dNQP+
 1Ic12cGDQBffBc1oiHIM2JMAZUrS567iuIBAS786fIZ1Fhesjvllp4NBTINXzKcMxj
 GOt37pF22BkcR2HDO2jvs15Y7ID8CBJEsV/Q3gpu+i821dkJIfTeyhhFcFWSUe12Qd
 deVfLFRokXTYQ==
Date: Wed, 23 Feb 2022 20:04:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 07/11] spi: use helper for safer setting of
 driver_override
Message-ID: <YhaTWiSQl6pTVxqC@sirena.org.uk>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
 <20220223191441.348109-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20220223191441.348109-1-krzysztof.kozlowski@canonical.com>
X-Cookie: I smell a wumpus.
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
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Content-Type: multipart/mixed; boundary="===============3435886331291877827=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3435886331291877827==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PaAAhqOBo3hBuacY"
Content-Disposition: inline


--PaAAhqOBo3hBuacY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 23, 2022 at 08:14:37PM +0100, Krzysztof Kozlowski wrote:

> Remove also "const" from the definition of spi_device.driver_override,
> because it is not correct.  The SPI driver already treats it as
> dynamic, not const, memory.

We don't modify the string do we, we just allocate a new one?

--PaAAhqOBo3hBuacY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIWk1kACgkQJNaLcl1U
h9DKugf+JTJnnQWx+6mOA4DxLKfWqeASwwB38nUbBFMpWAEhjMvez2XAp0h33Cp9
bH+dZ5NjHjeUoLGkWBHxWiyuu1r4QrqL7E32x/mV1JsG7I2svj0l0XyCx7Xw7lqT
QIFJxxSknnL1YtmnB53Rz55GDGQhIg4ewuv/ayCjk0oBDS6G2WBS2UAx2FWJQg2l
0ALu1QKfCU2DfjLPbmMqLoJb9anvSLyPxe38+Q2dqLx6kUl1WqVWz/Af6dJp9YWY
UDYfURm/JqyzEo/wiM5ZS39VO9Kv8M7EO9MFJvwxdkmM1evQah6crAugVx/WeCQy
4Tv/1RJYx8DyQ53XSPVEVcgh9tSx9w==
=g4g9
-----END PGP SIGNATURE-----

--PaAAhqOBo3hBuacY--

--===============3435886331291877827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3435886331291877827==--
