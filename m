Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310690;
	b=nOuAuBkrRl8pKA9OTHqEhG7OjI5gACthRB0t2V+WATRLMZGbHRZ2jICSofZaRRieUg46
	 eDFMkeHm+ZZJep6sSDqyV3HFlutoiZEfPuMFdtQ+AciCVJ6nE4X75/Scikxzsz8xjjxDX
	 6UQdZtnrxyxjIsWqFHNMhZBQGDqKXU4TckuWLx9wdCUl5A4yHJRKyeLK8dRFphWlZZtoC
	 jclEns5APT0b4a4tOqIxWP+zgWNKyyiVv375e6XwPxj3K6PwXe12bQk8PQ9MqLmAT/8DH
	 waJZvqFTgyeeeHt8TCf4dctPkplqCpdNsUNgw+WemFPoRHsLxfdJvgwbthOHmU6WF7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310690;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=3R4x3uteIeoz/32bLgfmQXYM5ZAzZ0CcQl4NVV+iUr0=;
	b=moRNA6vVTbYe30XjP7rfmWewnKijXHCmasFuZghrxPMB9KyT+yeozVCBLRciRIJBHb79
	 JcGagJE+kEFFhpbpRblc3PsQOtwZdZxB4xLbL4AsbeE42PefkCfbTx/OkoNjdozDslipB
	 llVHHRCcvnlvDlYQUKktU0Kwtfy3rwEDa8dCt3tTgwPg0ynXyAkPiMb6zMddXuEPmwFmt
	 7rcJu4/ZeNUwv477u9zq1hzP1r55ZYnE6i81PaQeVpGLFRhVAH8OgTQnfkDsx5JFj56+v
	 cSHCI0vK3lTRcZsiNTXhFK7qHN/7Sqv+StcYPGbnV1ZEoiXMCSQL11MGDuMlSk5znTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZqcQnCl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C260A2601;
	Tue, 10 Nov 2026 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZqcQnCl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEDD1F008BC;
	Tue, 10 Nov 2026 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310689;
	bh=3R4x3uteIeoz/32bLgfmQXYM5ZAzZ0CcQl4NVV+iUr0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JZqcQnClOg3KSSBtRFIKe8OsbB0G7iih6O3x9hMuTO5r7qBpi+FwZUGF0cqdoK3M7
	 xtU2oGNcDVBYMNN64p4C5YBSVFYu6OqByckcw4WbNY0LsPeQW9VhAyxpEibdaG08ZQ
	 ZDHHjijQQi0LdxHIiVyhNI61HZNlipc+aEZt779icwqMMXPrtJjPp4UTX23sl+SqQ1
	 X4VdqnhVJ3MqlQ8IDdowBSM9eF64NYBS/a3jeeJFDX7trmYwFDDi+vsGy9PDq0hIZj
	 5Axhc8a8QkiIUunzRWTTvUvrRdyjAQdZbTzGm917Vgog44ep0BdDGrCNXcmqC8XjJe
	 Jwjp+ePu8OeTA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 17AA6310B6A1;
	Tue, 10 Nov 2026 11:38:07 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261108-spi_virtio_remove-v1-1-fda5f0996290@valla.it>
References: <20261108-spi_virtio_remove-v1-1-fda5f0996290@valla.it>
Subject: Re: [PATCH] spi: virtio: move teardown to .remove()
Message-Id: <179427233249.3711751.13794984431224969594.b4-ty@b4>
Date: Tue, 10 Nov 2026 00:58:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hY3NfjWYKPeWiLqN0QfOLJDtAYJg6lABRA0ms2c2Snk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+M8lJc2ecF0hetn+/9MbgS4EyoYL3zmXZnL9/iHOP2
 nHlAEeWjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzEZA7DP3uXuUpXwmVlWZJb
 pwXOFE3XnJ773bbYTLLPykwy+E6MP8MfTl2vigeNuqmHFiu3rq6d33dbJ6LDbk8r30VNsaK3LVY
 cAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 08 Nov 2026 18:41:17 +0100, Francesco Valla wrote:
> spi: virtio: move teardown to .remove()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: virtio: move teardown to .remove()
      https://git.kernel.org/broonie/spi/c/9060f5ba658c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

