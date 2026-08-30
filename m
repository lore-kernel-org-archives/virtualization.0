Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65AA4A3859;
	Mon, 31 Aug 2026 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200411; cv=none; b=kPLgyRwiYoecaxKFPtWvu4xcKo97Ge3OYcOfnIxTJc6bjibtmBbHPL7PJpnfFXYVU9yZf1Rj+kNrJzVfSp6jZCPlj+AGjlyng1mOYoRuouXReEeLldjvDOE7F1F74LSNZZN9K7axmyEpdQe7BVHcw8JY0ZpevQRKFxKyyLlUI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200411; c=relaxed/simple;
	bh=64RgWKapbpcbTo++x8oKoCjSO4fGjfuVJKQTTCf8nFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qgcN3yIDM4i79AhrMh88Mn+0oTf/BgO6cLwuu7JmpB7t2jCAFAbqEZOZqGZ818q8aPbrByfZBKb1zb3Grr5dTRpL1qaKbyvicyPMxHOvUa18jBMX15VKJmZaEol+MZiU3FF+dVNso0aqkGeC82Yj3UraiX61Nc4f10RPmLmGE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMArrpKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMArrpKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3381F000E9;
	Mon, 31 Aug 2026 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200410;
	bh=OcVayUEOylEhJ95Hs31FmQv3AK1ni05LLXEAjjJILmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XMArrpKgi1ESB44cv8SiSrBZFPnHsPtFgz1yy0b7Up76mtKlYWBsn5Nk6+Samp2LX
	 TUvPoOzHzcPhplWEkO8QNmdGwV3qksdN4p1k8jkXyeZawW4kk+MGAwuz6qvdB5B06z
	 dG0VMkzT1zZYhSNZwZV9688NrLNx8U64XrZoBe/1bLlhFmhrG1yFgF+WcIUrtytkNH
	 HLp0ZVs+uzX8cu2nMe6fkvEFJ95+T19pFABo9Z9Xs2IsmsWK6BivKrhlV57KHY/qpA
	 zrpF3w/sKeEhzqUxXgtf9YiCp0cOqSiygyy7Dd673HaRotTCw33rD4LmHvqVna9ArP
	 Zv7NCTMuL7iFQ==
From: Mark Brown <broonie@kernel.org>
To: Haixu Cui <quic_haixcui@quicinc.com>, 
 Francesco Valla <francesco@valla.it>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260830-virtio-spi-fix-v1-1-62f486f4acdc@valla.it>
References: <20260830-virtio-spi-fix-v1-1-62f486f4acdc@valla.it>
Subject: Re: [PATCH] spi: virtio: drop duplicate completion init
Message-Id: <178812668896.13461.6916167520873314863.b4-ty@b4>
Date: Sun, 30 Aug 2026 22:51:28 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=64RgWKapbpcbTo++x8oKoCjSO4fGjfuVJKQTTCf8nFw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlcXXyaLPGOELx8FlQjQeO/DNmQWxcyRasPAP1
 EOSA3I+A+mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapXF1wAKCRAk1otyXVSH
 0CYeB/9JYeRTXXPn3BVLcS1aZFEbg0sn7JMBtTSpzipPYsIpFUQs1avExyP/S1g76v4u0miS1aP
 4+sd6Y5jM9gQ966iQsgitl1K/tihTIsldm+pVulySPRBzP04+vphH3mW0DN+5TdPupVjx+7G5FI
 CQbYbsa3/qVEzSTwyXWckn5ExY6GrGlFjh1WigfdVJ/wrHFucvmkK8lfwLWjtlGjC0SY2K31ck0
 S27oGM8aNeSA6BeDnzas2HEU5eqZHRtnoTxwR5c9nz7bcv7ASenOihHEpG52pVY10QbkDMjWrrr
 Di32uSwkhrKGv/DjrQAkbrzlDfAlvpjC+Y+AQ7NkWfdD3WLE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 30 Aug 2026 15:48:35 +0200, Francesco Valla wrote:
> spi: virtio: drop duplicate completion init

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: virtio: drop duplicate completion init
      https://git.kernel.org/broonie/spi/c/b34c325539ca

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

