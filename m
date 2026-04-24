Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B039446B;
	Fri, 24 Apr 2026 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027635; cv=none; b=KjVR6E5VdhyVnRwoe+JDSf6FWgqPBQo1fiSGju6YUTT/wyFzCor16hZkaTfOvX4kuPpwn7h+Zlw6kHvMnMIUfxHUIJG7DoL/hFlCCMMWVpGDjtvNDSqdFcSf5k3S4A//VqyPbif1TyFirC4NgGZRKWimxvRog5J57lMxPQTEM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027635; c=relaxed/simple;
	bh=24mKT75kjB4AZBVc9bjMu9IT8tdkJyGwZI8WsyS7dDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6GSAXMD10YFdrx8WB9RNR31xVDZwRciiJFvPaNeia5gRgyjLdgZhbVeR6pMOKF5pcL/XpnqWxmzU6t9Vhw9Q8d1DzFUyEe1dlKKtNe8q9N0fifnlsrzAiYhrTzdebVuufRszbRmZingGb3SK9HvXJ3bQ0CyfunZST1XrvbmrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0UtRLUA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0UtRLUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE05CC2BCB4;
	Fri, 24 Apr 2026 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027634;
	bh=24mKT75kjB4AZBVc9bjMu9IT8tdkJyGwZI8WsyS7dDc=;
	h=From:To:Cc:Subject:Date:From;
	b=g0UtRLUAXJodclJWHX7vrc6Cp/8cEFrz9DPl0cqR6ZYnbzcVcvu2kBC/tzyIn/J6C
	 HnLncYJG2+usY1DDA9Mu84lsEExsK+3CwQwsnP/aFxvhN/rMciyUtfHA1S+lcSAS9v
	 kpn9jsl7v5InfIXvTm5eQFnldx3NBg7m89arvJJn2hT8eL94pVK8VkhRXx5FJSSpps
	 zwLh8ujxdOAbJIEabHIKcGDk+EfOvI9+KtGZWhq8iX114gGDRkdSyxv1IspsCQCAxp
	 M3DwQWEl9vSyVgX/xQgPfrZi/h7Lta90TfVAV/2IqLSU89vNLEsSo+QnxaM92kBtoK
	 FcV3Gxlr1wIMQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGE40-0000000AzLm-2jZz;
	Fri, 24 Apr 2026 12:47:12 +0200
From: Johan Hovold <johan@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] vdpa_sim: switch to dynamic root device
Date: Fri, 24 Apr 2026 12:47:01 +0200
Message-ID: <20260424104703.2619093-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces the statically allocated VDPA SIM root devices.

Johan


Johan Hovold (2):
  vdpa_sim_blk: switch to dynamic root device
  vdpa_sim_net: switch to dynamic root device

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 24 ++++++++----------------
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 23 +++++++----------------
 2 files changed, 15 insertions(+), 32 deletions(-)

-- 
2.53.0

