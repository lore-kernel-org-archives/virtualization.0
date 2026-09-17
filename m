Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8333BD241;
	Fri, 18 Sep 2026 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723988; cv=none; b=qmAUPYYqt6culs5WawJsghX9B4hIW2T36KtG21Ld/V550FtYXAwcPEeMSKYLVTNIMTnGi0r920zzG6L13tmN86D/hV3RLHD9EQYnJIxN8ejAy+Cx1M5q/SZ+x8Ott57lKM6mWK3A9a11MaYw2m+KJBP6GT/gQlLNykcJLaJVAHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723988; c=relaxed/simple;
	bh=NW+hnPXY4W8iOvc1apCahb6HsULhGQOpuGQPseMMYwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dNNGR2LOO4X9tdwqddA+OsBytGepblTFBotONlm8+SXo7s52n4KeJ6YiS4pN3twEdPhqfgJx5QaLcglqYxopRLVGRfM1muYrLx7bUj63oOJQ63JK22QAFWRhGRqJfCv80y1+HJySnswaoVQIXsTgwVHHIHn88tidqI7ZqwTsPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSwmMHqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSwmMHqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263741F00893;
	Fri, 18 Sep 2026 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723982;
	bh=ypS1DgOviwraoI3I3BEGbM1+osF0L0xF0apP5Twsl6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fSwmMHqHTVYK0VOJuWzjOmqcNG6de6r5b/ojUtKhb927lfaZqWeW+Cr4wy+ZHX/U5
	 1ch0qaGUWRgYHyLXgBhLnARLiad8T2owdCm4hlERybWqVwFsmQqQbOMaYDL+1p+FBs
	 Otwqzd8cPym/O6AXuuttv2+E/T4kEEo+OcaOgSQbXdiLlGLmggJ8nfDu3z1xwynRKC
	 +0FmfNpqDPwiNadAvMOU1djrbF03SbYWQAugMUCRpLUQq9LnXDchkrLg4uMKz2heER
	 ANtnEFcGbU4BquAnWB1l0zMOVfk2Hu0xaM4UX/CcmfAWbwjlh8z9zpzfUroD+tLrj3
	 podWDeoynfsrQ==
From: Mark Brown <broonie@kernel.org>
To: Haixu Cui <quic_haixcui@quicinc.com>, 
 Francesco Valla <francesco@valla.it>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
References: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
Subject: Re: [PATCH 0/2] spi: virtio: fix max frequency setting plus minor
 cleanup
Message-Id: <178965688483.162267.10721375070232499143.b4-ty@b4>
Date: Thu, 17 Sep 2026 15:54:44 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NW+hnPXY4W8iOvc1apCahb6HsULhGQOpuGQPseMMYwg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrQVKPVvT8qGeJR1nQYIQSY/g6EKkxLAOz7qqQ
 ICfTM5GnDCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq0FSgAKCRAk1otyXVSH
 0K5dB/9MHS1/gt9SI3wHBpZU5bGbMuT9dRxnbUfSMjZNcy+lu8ruKyVVQezQ3umPDkp3MX2xJzg
 XUrbLbQ4OIC/yEWPr5tbxrYOkGrzUT2WGaGYOot03HWEM9YY48nrx77bVd5glccMYz95RNRZaxG
 woAs1xJiVl/BJvd3DF/xB2ldM/yXmaTT2mTkqyWn1/jUq7FXeS49qRKw/7zaTdYmvl38zRteFqk
 rtxNoRe5I3MEPWVU/OTcsrKJumLxbv1qJfyg522B2gNnaydVTmOkkNGmqXv0Hqmyxpa3qupDTpN
 HyYVO1U3GtUeFvf7kp41/+qI4G40Yjw0zVbFEbQV3CZfXLh9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 15 Sep 2026 22:24:35 +0200, Francesco Valla wrote:
> spi: virtio: fix max frequency setting plus minor cleanup
> 
> Hello,
> 
> while developing a virtio-spi device, I noticed that the spi-virtio
> driver in not honoring the indication on the maximum transfer frequency
> supported by the device that this one indicates using the config space.
> Patch 1 contains a fix for that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: virtio: fix max frequency setting
      https://git.kernel.org/broonie/spi/c/26f42ca8becd
[2/2] spi: virtio: drop unused field from private data
      https://git.kernel.org/broonie/spi/c/62b223cf4334

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

