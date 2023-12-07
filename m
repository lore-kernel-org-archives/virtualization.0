Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450A40C0F
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YPdgsVhe"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0940404D5
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0940404D5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YPdgsVhe
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLAmAGSu2mgn
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 14:15:32 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org; Thu, 07 Dec 2023 14:15:32 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89440404B0
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 89440404B0
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701958533; x=1733494533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKKiprSC301Q/AIeayiNtJoUwjj/0Z6QsX3HsdR0aTM=;
  b=YPdgsVheBnXREPg9yA8RKw/gh4EkSCzrvXZ4PW0uXhT9DYk0U08jEZ2T
   +T4z+syCYGG/uYK4VMxLWZcN/P/KzMWCv+FS6ufcP2rxXSBjSMBamAmLC
   hUdXQ1CCoYTA+tCJQrR7s2J8EKqmlsuXFLAGWtKJJxSZZ1/0pJexuirds
   jfl4HRrYLOi6Oc/iEdEvYxwv8ut16bWySwolc6HU+A5BkzoJc7pii0fuQ
   m6Zn/rOvEgAtJSoNG6nBfRM3RZKazvU4OtM1elK7zYsPX1rkTZ+OfMRFr
   bL8dgyKOkYGp4fxsvU2k0Rp6AdTpynnJ+wnYDPshBi4vqJv/lK0ilkSCM
   Q==;
X-CSE-ConnectionGUID: m2fZxj86SumexGQMB9uwOQ==
X-CSE-MsgGUID: B0qPIv/8T4KE8pZ2VLe+tA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="asc'?scan'208";a="12934293"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 07:08:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 07:08:01 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Dec 2023 07:07:58 -0700
Date: Thu, 7 Dec 2023 14:07:28 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Andrew Jones <ajones@ventanamicro.com>
CC: <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<virtualization@lists.linux-foundation.org>, <anup@brainfault.org>,
	<atishp@atishpatra.org>, <pbonzini@redhat.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <jgross@suse.com>,
	<srivatsa@csail.mit.edu>, <guoren@kernel.org>
Subject: Re: [PATCH v1 04/14] RISC-V: paravirt: Add kconfigs
Message-ID: <20231207-unsealed-bunkhouse-bd79271b4896@wendy>
References: <20231205181119.207204-16-ajones@ventanamicro.com>
 <20231205181119.207204-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f2Nei8/R6cqxLGD+"
Content-Disposition: inline
In-Reply-To: <20231205181119.207204-20-ajones@ventanamicro.com>

--f2Nei8/R6cqxLGD+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 07:11:24PM +0100, Andrew Jones wrote:
> Now that we can support steal-time accounting, add the kconfig
> knobs allowing it to be enabled.
>=20
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

In hindsight, should this be squashed with the code actually adding the
support?

--f2Nei8/R6cqxLGD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXHRoAAKCRB4tDGHoIJi
0qUfAQCqwJvSwf/igC0LLRE8vbiSENZiLROkCzNiXFQVBy2CXAD+J8Bq9Z5EDEBC
tchBjiYy3HOQKbc+BqTmd6Wq3zjSDwk=
=Wn6E
-----END PGP SIGNATURE-----

--f2Nei8/R6cqxLGD+--
