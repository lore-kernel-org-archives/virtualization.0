Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5FCC2ED;
	Tue, 28 Jan 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057202; cv=none; b=Oj9HHj/3jid3S9LMCzUSHhK+/k9hnu3ji1G1+/S1pE0s5hVXl0RJZ8PSyM+zHVuneedLsew0OE6hnjpDsA9KLgkqmCeKpoAjkiZ/8Borm9nzxmkKgwFiP8VIwEzelR43KKLo9mJzbBcEpBDGDxKDCw5SuzPXPmuzTyYH+mCD8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057202; c=relaxed/simple;
	bh=u7WN9t/FFOUJYA27Q/Hh77m+GM0Q+RIl68RYJfkAe2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NyvST400UeOiFP9/JM+gKEOBiZNDGJUO1x1XrieTx/CFKC7Kgk+h5imG2hM0UKu1LQoHedvFU1iJQPFzws4Xc8maWMFBVeAp4p8XyoXHSVqQhsyPdFfoGxR9BqYiiFjh0/4XsEatbtJYIBmMCkatCjoPrS+OAsWmcW7u3TtIAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6WS+qSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6WS+qSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB23C4CED3;
	Tue, 28 Jan 2025 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738057202;
	bh=u7WN9t/FFOUJYA27Q/Hh77m+GM0Q+RIl68RYJfkAe2I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O6WS+qSoyR5kflowep/C7NSmDdFy5PSLYKGOlymf32qTURnGY05dTh+szYBOK7pTg
	 TVSFca5CDuqIu0+rP+va5vwgwdacxSHuypSxmhkbTg7511eRTk5GkuWnFiqNXd5008
	 igSQ9HzUdY50ZNrMG3HLmJOy+oghMzlkwNkao1mDfiPI7k8C4LplR+2IM2agBja7qJ
	 uwZFNt2AMihnndr1HKELQejA9VQqt/L0HE0OfTRP0KmNuIEbq6nOvcuvkTT/hNr/e4
	 h2EeLlN7xk/Zo+gSnq4u6glPYfu+fgKiHUEda6hzYnvDtVyVSSkDRO9dB+Dc5jkM4I
	 QVctFjdbSjI1w==
Message-ID: <9a10b435045556f5625afe83bd41bc4d4f9be80b.camel@kernel.org>
Subject: Re: [PATCH] virtio_console: Convert to use devm funcs
From: Amit Shah <amit@kernel.org>
To: oushixiong1025@163.com
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Date: Tue, 28 Jan 2025 10:39:58 +0100
In-Reply-To: <20250128055241.30760-1-oushixiong1025@163.com>
References: <20250128055241.30760-1-oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2025-01-28 at 13:52 +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> Convert to devm_* funcs so that no need to manual free in error path.
>=20
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> =C2=A0drivers/char/virtio_console.c | 43 ++++++++++++++------------------=
-
> --
> =C2=A01 file changed, 17 insertions(+), 26 deletions(-)

[...]

> -		goto free;
> +		return err;

[...]

> -
> -free:
> -	kfree(portdev->out_vqs);
> -	kfree(portdev->in_vqs);
> -	kfree(vqs_info);
> -	kfree(vqs);
> -
> -	return err;
> =C2=A0}

Hm, I'm not entirely sure about this - the devm_ interface is better,
but to me that just says that it's an extra safety net that avoids
memleaks when we forget to kfree, and not that we deliberately do not
free and get lax about managing allocated memory.

So I'd prefer a patch that keeps all current frees as they are, but
with the added advantage of using the devm interfaces.

		Amit
