Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A7322A03
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Sep 2025 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626731; cv=none; b=KDK5KRmG+3nyT9JhK+FcXH/GEvU+whNjyNZ3xOT/q5VFMxfojeVFPd0hTuXIdDGg0E2g6wl72l/jQG2ZKpjpoc2cH2Tci5nj0inw1hH/B32zkeKwBxtGp9TU8xoEVlUzqcVrMMLuQVNIYK6pqS+hKZbfSBh65PC+9hMZiUaQ0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626731; c=relaxed/simple;
	bh=tu2kpNp5GDUDTAaXPWcXrvZxhyL8QBmF1sZcKwUwe5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JnaRdBgHg14pQs1T3zj0SqwIZrfKYiE79yTkJaW2cq8601v0rvdmQ4zyUyZc6SEl4soSOUlQH61mxuD5sPKwpkgf/iW48Al88rS+IMQsHx7q0Ny1qdXu1DZDE1HzfHHIYYC/jrPJMauSB2A9op/7DCi4aXNzzhAfjgRN2EtQ2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ9m0r6I; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ9m0r6I"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A827E40AD4
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Sep 2025 11:25:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2JlwkHEEbDR0 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Sep 2025 11:25:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E18F240ABC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E18F240ABC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dQ9m0r6I
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E18F240ABC
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Sep 2025 11:25:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E64544CB6;
	Tue, 23 Sep 2025 11:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE489C116B1;
	Tue, 23 Sep 2025 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758626727;
	bh=tu2kpNp5GDUDTAaXPWcXrvZxhyL8QBmF1sZcKwUwe5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dQ9m0r6IzIP+PZG9Vaj+GDzjXrgzQtMEBcurDxwNwifFk8VUv+jRMOwkwPD8fiPIE
	 MtVB1SXjTno4FVEuQl1dZAffZppEyYBwYtVJwV9yffIC2vEIuDo2F/OonbZlQpGErv
	 i1bZhfw/zWXo14dic2hL9WDeKPTlOPA5IStXa9ogCVrm8r1UJY0ta6HExmbkVNF38F
	 EVCcY6k6yLiyRzbo0PObyCXoiulcHyExlEiaFCeWrNEuodegLr6ErqqOzD5ds9jz06
	 sRCNkEUZcPBl+N3Bw8DIsIYMg+aXsBwx52VJuAK0il49hsa8ItG2DPQT+toTK9SvHT
	 cyY++8qHYpqWw==
From: Mark Brown <broonie@kernel.org>
To: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com, 
 quic_msavaliy@quicinc.com, virtio-dev@lists.linux.dev, 
 viresh.kumar@linaro.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, hdanton@sina.com, 
 qiang4.zhang@linux.intel.com, alex.bennee@linaro.org, 
 Haixu Cui <quic_haixcui@quicinc.com>
Cc: virtualization@lists.linux-foundation.org, quic_ztu@quicinc.com
In-Reply-To: <20250908092348.1283552-1-quic_haixcui@quicinc.com>
References: <20250908092348.1283552-1-quic_haixcui@quicinc.com>
Subject: Re: [PATCH v10 0/3] Virtio SPI Linux driver
Message-Id: <175862672437.1039628.4150229884552248859.b4-ty@kernel.org>
Date: Tue, 23 Sep 2025 13:25:24 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Mon, 08 Sep 2025 17:23:45 +0800, Haixu Cui wrote:
> This is the 10th version of the virtio SPI Linux driver patch series which is
> intended to be compliant with the upcoming virtio specification
> version 1.4. The specification can be found in repository:
> https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.
> 
> The original contributor Harald submitted:
> RFC v1 to RFC v3
> non-RFC v1 to non-RFC v3
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] virtio: Add ID for virtio SPI
      commit: d9a2211dd3aee3ef29fc675f70a1941bc3f4f51f
[2/3] virtio-spi: Add virtio-spi.h
      commit: 6a1f3390fafeafe130b8128b3047452b92911a98
[3/3] SPI: Add virtio SPI driver
      commit: f98cabe3f6cf6396b3ae0264800d9b53d7612433

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

