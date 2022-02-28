Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BF2C433F5
	for <virtualization@archiver.kernel.org>; Mon, 28 Feb 2022 13:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF42D403D8;
	Mon, 28 Feb 2022 13:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6E1mLDnbxjKc; Mon, 28 Feb 2022 13:08:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A47D40259;
	Mon, 28 Feb 2022 13:08:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EFE6C0077;
	Mon, 28 Feb 2022 13:08:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3770C001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 13:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9883781A24
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 13:08:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xdYze5utJCDA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 13:08:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C874081A1C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 13:08:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 12319B8114E;
 Mon, 28 Feb 2022 13:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4116C340EE;
 Mon, 28 Feb 2022 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646053683;
 bh=xwpZD4gZhTKAz2WFv6X6JMrNMSyputHa5miIKZ7mnV4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FDHaYinVMNM6kACb7E2Qy0TXd85azTDlvzFKosdq2q5aXpNxj4+0bCHnUOyq7qvCX
 SdYowwLghSSD7m9p89L9IHLNURvZvuumE6Vu3Y7iNzNocmQHWUzg83s0qB+weG5HB0
 +kvmS/aLHNI/6Nqh49ZcJOvFivLCHBHTVfK80/WeRhDxjAD3RPcXkp71y1CkrubPcT
 TYf9kmUe4enaJ9QLuu5EOG9nUHW7bKk6BlwMqnVjYo83gCrxYJUvbhawoVypGiHk6k
 f1g5of4zmfYtpdOQJOHVTh9uxD0U5bue4hdKW1TR99VKgbXAKo0qKyQa7hTJW5HG6p
 WxhALj7z+X8eQ==
Date: Mon, 28 Feb 2022 13:07:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 07/11] spi: Use helper for safer setting of
 driver_override
Message-ID: <YhzJKKCxnx9DvliT@sirena.org.uk>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135329.145862-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20220227135329.145862-1-krzysztof.kozlowski@canonical.com>
X-Cookie: Killing turkeys causes winter.
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
Content-Type: multipart/mixed; boundary="===============1991664706284036876=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1991664706284036876==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IskqWBy0ijhzVzPO"
Content-Disposition: inline


--IskqWBy0ijhzVzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 27, 2022 at 02:53:25PM +0100, Krzysztof Kozlowski wrote:
> Use a helper for seting driver_override to reduce amount of duplicated
> code.

Reviwed-by: Mark Brown <broonie@kernel.org>

--IskqWBy0ijhzVzPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIcyScACgkQJNaLcl1U
h9Ao0gf+JDpig6VFnyylTAGyA+EFJ7fmHFbvWhVF0t9hjFi5sLRAs8Z3+hLLKVej
zLVg+PMT7lEK9f1Cya6K7+gCq6ukWeVmmFBvuEA5Mn++s0vTXTuvx7VPQ8I7paXG
iePQNfdjxSxtdDUM+zinbF3mL8p4PcKUzqKlYEGeYvhxM2KxJx8a01GSsgKU1rNC
8ynKO/iKprh+dyGZOBcXM/m3OJDmQ0YEQi9uVQFGaznJ/yE4YjoBnCc7gj7uF2gB
3VAYxVi8Uj4ZMLOq0HPkR6QYxtneVT0Gly46I5Mg5BJZHdJ4yGkOOhaqZ0E4gwXI
YsZPSj+FAaJ1fM7xBMDL23NN8cHicw==
=Gb02
-----END PGP SIGNATURE-----

--IskqWBy0ijhzVzPO--

--===============1991664706284036876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1991664706284036876==--
