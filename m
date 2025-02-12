Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC9127181D;
	Wed, 12 Feb 2025 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362766; cv=none; b=iptfH2NxHC85T67VzFuiO6QA6/5Vr2jc1MDKsfXLN14K8/QLUHS12oC3CFBe/+/xbtZAglLoQEX0/B7Fwb14a8sNzOEkIAQ5W2E9fGPY8Xj0KdUjS3r1i/cybi1DucJHbYmJQPMaA+QltgEfbds/pDJSX9U5UafIS+bhsvutVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362766; c=relaxed/simple;
	bh=M+Xlt2XcjgUNFYP2qssnoRDZSeAmp3wXi6EiLpgW0K8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W2glPMRJfb20+Y1o/AP0lr+YjmgLJ9Nf2GXDigzWp5FnT6XzI8lHezTOdkSqidsKzGbUwPF6VP2cpzCPZRuedz2X7yK5d9JYoNkM+3usvhq07dcga9mxOIxjrf2WIcpuD7CCR7dyUUghrQPweYKropk0IHcbG6/lWONVqYaiHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2H8y0xk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2H8y0xk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3357C4CEDF;
	Wed, 12 Feb 2025 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739362766;
	bh=M+Xlt2XcjgUNFYP2qssnoRDZSeAmp3wXi6EiLpgW0K8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=j2H8y0xkUj5igOMzvMQlxJ/MmBzBhTfF4OZoCCuLNvflIzvm61v6+/BXUwYjHxdMc
	 UA2E0xD0Kc38PfSdLStL67Ne2hcmwVx71KQAjGlfZOLNbM6ZziRu3wB2jjZzqP5oDW
	 6Cv6R/MM/1iH4yeqikRtYqMFZn/H5AUGGlSkg9RA0eB/XaW9dBax+8mSh/HoRSbY0I
	 qU1TOJRSyAhw3nh7oxQw74rBTz8uozdYhYiNlmk6e9BetD+ucPW8lSWtFZU4vDMeG4
	 BXpRlkXMeAIQWEIkn3GLEzEu/ZLMW9xmi2IRIx/L6SflxA2c4b/09kNtNR+mgR0Cq1
	 cGyj2NrlH0XQg==
Message-ID: <60d61b5bf637370f0eeda0e331b9da2c29fbf2b4.camel@kernel.org>
Subject: Re: [PATCH v1 1/1] virtio_console: Get rid of unneeded temporary
 variable
From: Amit Shah <amit@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Date: Wed, 12 Feb 2025 13:19:23 +0100
In-Reply-To: <20250210095946.4122771-1-andriy.shevchenko@linux.intel.com>
References: <20250210095946.4122771-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2025-02-10 at 11:59 +0200, Andy Shevchenko wrote:
> When compiling a kernel with GCC using `make W=3D1` with
> CONFIG_WERROR=3Dy
> (which is default nowadays), the build fails:
>=20
> drivers/char/virtio_console.c:1427:9: note: =E2=80=98snprintf=E2=80=99 ou=
tput between
> 9 and 27 bytes into a destination of size 16
>=20
> Indeed, GCC can't see the limits of the variables that are in use.
> Fix this by using dev_name() of the newly created device that is
> luckily the same as the string used for the DebugFS node name.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/char/virtio_console.c | 5 +----
> =C2=A01 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Amit Shah <amit@kernel.org>

