Return-Path: <SRS0=Y9jr=OS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E2BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 21:39:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4876135F
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 21:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A4876135F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3458240609;
	Tue, 28 Sep 2021 21:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ECSDr7PKDJg0; Tue, 28 Sep 2021 21:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CFAD405FD;
	Tue, 28 Sep 2021 21:39:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66120C000F;
	Tue, 28 Sep 2021 21:39:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F414C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 21:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F21080DF0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 21:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=aepfle.de
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r7W3xHCVUugb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 21:39:16 +0000 (UTC)
X-Greylist: delayed 00:05:56 by SQLgrey-1.8.0
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.167])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94D1A80D4C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 21:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1632864430;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=FtDPVWexU4xJe/tAusBJYNUP4c4isrVjBItMQMHTHjE=;
 b=Aq5hll2aoIvcbuzHXu4aPnciNtTYLsjKd9l9MdUrOzf/sAUhVNT+wqAQe7H4yhmJOD
 OADOLdelhMMiUZ6aQbern/lOho7G34klQJ870XtkP4Ty+l+sse/A45KLT4I9uYBm7oDB
 gzN/7M64mcr/fqsh/E5e8nmfk6y8l3ah3QVNbCrrC/WnCE2H+/q5Bk5P7dNuNFaAhuIV
 YmYsCgsXx0c/i89ymiRay76XbDqOzylHqTnaJw5y9SgEK8fALFPpIV0c0UoPQTZt6VqL
 VzBW5a0DWznAyaiLOZhnk2xA0e83QQchel8BAhByAoyLco+3BdO3A6Tv82ScGTwx3vKv
 mErQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisEoBx6KYk3sDSS2ECuxRNydJqDgTcTmRadqe62a"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 47.33.8 AUTH)
 with ESMTPSA id j06d2fx8SLR9XXj
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 28 Sep 2021 23:27:09 +0200 (CEST)
Date: Tue, 28 Sep 2021 23:27:02 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: Re: [PATCH v3 08/19] drivers/hv: map and unmap guest memory
Message-ID: <20210928232702.700ef605.olaf@aepfle.de>
In-Reply-To: <1632853875-20261-9-git-send-email-nunodasneves@linux.microsoft.com>
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1632853875-20261-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: Claws Mail 2021.09.26 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, sthemmin@microsoft.com,
 ligrassi@microsoft.com, linux-kernel@vger.kernel.org, mikelley@microsoft.com,
 wei.liu@kernel.org, anbelski@linux.microsoft.com, sunilmut@microsoft.com,
 virtualization@lists.linux-foundation.org, viremana@linux.microsoft.com
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
Content-Type: multipart/mixed; boundary="===============1298491707704068257=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1298491707704068257==
Content-Type: multipart/signed; boundary="Sig_/0hx3rtBWUJeEmmJ0OWqZ=2y";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0hx3rtBWUJeEmmJ0OWqZ=2y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 28 Sep 2021 11:31:04 -0700
schrieb Nuno Das Neves <nunodasneves@linux.microsoft.com>:

> +++ b/include/asm-generic/hyperv-tlfs.h
> -#define HV_HYP_PAGE_SHIFT      12
> +#define HV_HYP_PAGE_SHIFT		12

I think in case this change is really required, it should be in a separate =
patch.


Olaf

--Sig_/0hx3rtBWUJeEmmJ0OWqZ=2y
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmFTiKYACgkQ86SN7mm1
DoCzPg/7BzqGmQge0FXBboVIFiF8AO30AipTW+49jct6hzfqEbECZxBGXnh21tVc
yWlyPotEtV7FlldrW1DNvNuzMv/0/4H6KYvSt68YudzetG9KBHOJIF/JnIKPCRc2
wcHTRWQe9r6FJGJF0dVwByvzdLD1BUvPPEM39STys69Y+Nq3z3cnk1q7qPBp4rSA
QQaSwRCdle5CoHmHvg1Ipc7uqIA+L7ySqec0oq55v6QzbSwZKql5j79sCY/c/53U
aONAs/pBDG6Q8FRBu+U1s5sBcDmWKVDQ0QHeCIH45X2bUgNa7EHwVDpnQN0UH9AO
KHe3jEPQDTh41CE34Va47lz6X/OcBIrjmUt/r/Njxif86i4beBGGbrjzDLx61anY
nnsvnd6z3olZLiSzoboyPoKTl/4WwdYZoXlnCxfCmaHujECFVNhc3A3PA58PLhh0
xy4CCcmYJiuaQnVIbuQcmn4+1huWDkNdDPrrEVLK1BdjL/Ru/SP3PWDxm97tz0wv
uPyW/tB3ErB3Edh7UyhNPaUTJLZy0rwcxx2P5DQ+S5Mv1utnPcQeModuuTKHdLLM
TFLWRJOXPitCS3+eKxORrB6/QUDn10VvYxn1tt+iVrHrSvf0qncTAa17e4ZbCGEh
s3Xp1BEegkzGWnOX5EV1I5msbm91AiSJoc/98TwyH0ViA+doYtM=
=RRvk
-----END PGP SIGNATURE-----

--Sig_/0hx3rtBWUJeEmmJ0OWqZ=2y--

--===============1298491707704068257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1298491707704068257==--
