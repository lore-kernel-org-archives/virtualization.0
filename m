Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04641239
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tsJCST7g"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67E0961AD7
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:14:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67E0961AD7
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=tsJCST7g
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3GBHxdlxrPOd
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 14:14:26 +0000 (UTC)
X-Greylist: delayed 428 seconds by postgrey-1.37 at util1.osuosl.org; Thu, 07 Dec 2023 14:14:26 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 442AD60AF8
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 442AD60AF8
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701958466; x=1733494466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FcrSijvE4f1IkcQ97V2bhaESClswu8A2/SLJLTjyLy4=;
  b=tsJCST7gwDy05T4yOKskeUbmRSsZ/rMsBia6YOWP3YZQL2Ec0VHwtuYZ
   q1SVUH8VBXdEi+JJdFhAyfjN+18Tda+ZoYXNAdkxfVNX01E9Ri6q2k6UY
   DnmCGtROu8vOh+Of58+zOUZXumpMnRzmeOnJwjJKqGKUzzgBSileXJuF5
   hJunZcEsyjcQvtL+hD59XPn5HvKhP09lgitoiCy/JXU/d+ic718azBbm8
   ee94XJT4oMshplJL7ChjzY8c0OI0VKourilC62IOq4HqH2B7EWovv19RS
   GqHCQRZOtF+PphoyQGxDDtjzxUzODTaO2imPKch+YpMelkAyodO2Co5pW
   Q==;
X-CSE-ConnectionGUID: eIjt9fRyQI+quPyqXbhx+Q==
X-CSE-MsgGUID: 2932n12QQ/O+STS0j5Z9cA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="asc'?scan'208";a="180086965"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 07:07:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 07:07:10 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Dec 2023 07:07:07 -0700
Date: Thu, 7 Dec 2023 14:06:37 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Andrew Jones <ajones@ventanamicro.com>
CC: <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<virtualization@lists.linux-foundation.org>, <anup@brainfault.org>,
	<atishp@atishpatra.org>, <pbonzini@redhat.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <jgross@suse.com>,
	<srivatsa@csail.mit.edu>, <guoren@kernel.org>
Subject: Re: [PATCH v1 03/14] RISC-V: paravirt: Implement steal-time support
Message-ID: <20231207-kindling-upgrade-22d29116ccf3@wendy>
References: <20231205181119.207204-16-ajones@ventanamicro.com>
 <20231205181119.207204-19-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8ewSSXgzOuaTlaZW"
Content-Disposition: inline
In-Reply-To: <20231205181119.207204-19-ajones@ventanamicro.com>

--8ewSSXgzOuaTlaZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 07:11:23PM +0100, Andrew Jones wrote:

> +static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long hi,
> +					unsigned long flags)
>  {
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
> +			lo, hi, flags, 0, 0, 0);
> +	if (ret.error) {
> +		if (lo == SBI_STA_SHMEM_DISABLE && hi == SBI_STA_SHMEM_DISABLE)
> +			pr_warn("Failed to disable steal-time shmem");
> +		else
> +			pr_warn("Failed to set steal-time shmem");
> +		return -ENOMEM;

btw, how come this is an ENOMEM and not a propagation of the error from
the ecall?

> +	}
> +
>  	return 0;
>  }

--8ewSSXgzOuaTlaZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXHRbQAKCRB4tDGHoIJi
0qaSAQCrWAPSqAvfzE2m8SQ/25FLnCV29+FUxC/4XmtNTzii/AD/UVtOcM36NryL
rFVl/FEY88aDf13VTFCOtAejMbOHXwo=
=krKo
-----END PGP SIGNATURE-----

--8ewSSXgzOuaTlaZW--
