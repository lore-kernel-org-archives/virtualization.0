Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C633A019
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Sep 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830518; cv=none; b=cIWtocmq9DxmsubaS3BlIEwDI9Ll0UwXry3vSRaTJH62IZENPmSZ5kyQJ9y0U18UOp9T8eWwprUw0KZyUwCrNafCM9mWVuKW0NZYaOstBBKpcthse0siPNQzAjvCyPpXEYh9HG9x08RzAK87IvVlZciXnNZFh+jqpomoKMRDbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830518; c=relaxed/simple;
	bh=3qWM1isXmW1mcxXD55WMamsR5tb/FO5a3JRgKcnuhrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpycYllSbFPTxuoaEV7BABxZf8HY5RQ1nSx6M4YjajpunatBsxF72x8QdAvgcwL1e4tRrAPHZSG8SghrRJV6IBNbM+2MnQxVILGhmRzLSyNOCPZ9X3exkNsvuVcXPRC9+2jmRTxLqeJq199GUbL7eHEt3laqahtVC9aB4+Ioehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn26u4lA; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn26u4lA"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2A47415F1
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Sep 2025 16:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YxI8ZtrghjNc for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Sep 2025 16:28:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 09E48415F0
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09E48415F0
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Bn26u4lA
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09E48415F0
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Sep 2025 16:28:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F37296020C;
	Tue,  2 Sep 2025 16:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269C9C4CEED;
	Tue,  2 Sep 2025 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756830513;
	bh=3qWM1isXmW1mcxXD55WMamsR5tb/FO5a3JRgKcnuhrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn26u4lAcmOsj5NjbHiPcYo+hGRsmcYpIa69l1LpTM9+5drziCyDPrM3jCRJnUBgW
	 mLljXTGf70mgg73naRfBR8WkOJcOkqVcRxt39JATuc7PKTLYJ5u6xtbz4sy8uw0tlx
	 rTBiFEd6FxhGj49+TihpgIo9oKkMwmxw/TdcheuPplRRprnS+zBHYkMKMPvSe7t4LJ
	 3UJV8c4JLLYUBiw9UE/GDQZ2i+qXQOYRWJwBp9vYrXLqX7QBgPakkrPWpdqNz+/sGQ
	 YQAByyKauVqeWM8SrAIrdauuqCl/x3KGojyUZwlsrrcyrp9FNRg4+gP3crMqHlMEtQ
	 fg4uGB/+e4FGw==
Date: Tue, 2 Sep 2025 17:28:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Haixu Cui <quic_haixcui@quicinc.com>, quic_msavaliy@quicinc.com,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 3/3] SPI: Add virtio SPI driver
Message-ID: <92d07f3f-8416-4b54-ac6f-c6e46869fd53@sirena.org.uk>
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
 <20250828093451.2401448-4-quic_haixcui@quicinc.com>
 <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
 <be8961be-2964-4571-9818-b5a23867b27e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G2RZgqiagCB3CCmW"
Content-Disposition: inline
In-Reply-To: <be8961be-2964-4571-9818-b5a23867b27e@oss.qualcomm.com>
X-Cookie: Vote anarchist.


--G2RZgqiagCB3CCmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2025 at 05:54:39PM +0200, Harald Mommer wrote:

> I'm not aware of a requirement in the style guide for the Linux kernel
> that all used headers have to be included directly in the C file but
> this does not mean that such a requirement does not exist. Can anyone
> point my nose on it?

It's a general best practice for maintainability, I'm not aware of
anywhere where it's specifically written down but it's something people
commonly try to do.  That said so long as things compile I'm not going
to block anything on this sort of extremely pedantic review, especially
at this late stage in review.  I would have a lot more time for patches
for such issues, this is rather stop energy.

--G2RZgqiagCB3CCmW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi3GysACgkQJNaLcl1U
h9BHHggAgKiHhB6Fw3H0O6lrMZi3Xk+xeRdeWcJk1ItgABmYtW93ddbteRFHyVf2
Pi7k8xYeSnk6ITDyl4VrESErjlC9AMEMO+pAdjWJ0vJ8gaOCLkKMd8KDVVhZWxDh
MZVcwBcm9CX04p6A5P1egihocy+sWrqfwrI54RQQyWLQT5moVkN8N2M2exIwuQZe
z5+8ro9aJvA+g4ET3e7Ub3nGt1UBYnTcVu/MD62fHHs6QaDLQ/b0QKQsFL1Gg9tU
ISyeZdeiJmlC24vfzDiQJyxhyWZec5dpUToWkyrwhVDaBk6N/6HmxiTD8THK8l1m
23ujwFdn3ldt7j+NPhDy/EWu8YjgLQ==
=1ZD9
-----END PGP SIGNATURE-----

--G2RZgqiagCB3CCmW--
