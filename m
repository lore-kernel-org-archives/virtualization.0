Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB82BDC02
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836066; cv=none; b=TQEHky7Z5zq8x+krMidEl3r0bmDxvuBq+EW7ixGA2h2apx99W1jNKuWdeBksYdpkgLvw4V3bu2y5U+qC7UQO9VtbU0c13/U5GtKrTg+Lt1oJxmck9cmR0nt/hLwztupAcZ15DmrHC3SXdWLI7lTrJF+jBa4pKcfds75Q5SDo1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836066; c=relaxed/simple;
	bh=k7CAZOnVX3McTF9rA6EaJjI3tqH2gxRiw0k5BhFfu+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmrHkYKwyjZWb8LHFuSu/McqM8y3MPJ0jHSF9djHRfAijt22Vzk3YWJg6qPim2759ewWSZNuJIr0yfRBLI5NmjdJ4oexT7cuSjTDfuKoVFKNm1GQo5Dd/YZvVZSQMEDAePCs1ryoPgtmgLZKotrT6ARFfwSEP7I1Orip5szdx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Sjynf/u+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Sjynf/u+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752836063;
	bh=k7CAZOnVX3McTF9rA6EaJjI3tqH2gxRiw0k5BhFfu+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sjynf/u+D9SjkEYOCSDJrxhLi8UWPgyv13WkmDPUqBdHSgA888JhJLdg2oy4ObMt9
	 KYovrzdWiDYVeLa6c/50qDU4SmZUkqP4hdwseHAWYqUiWl9/DLSMkdg/eHjqBXq3V0
	 76icLc08zdr3iH8cQQnP3A3TndrdxnqI6Cmnqdkyh8Y5BRBOLwHTMH0bacvHfMhe6u
	 IMFfDQ7HPmWFgWTe9AEcT9oOMstEHna+guZKMatkjZkjXJJq9RA01Zr/bWQ7IOaSeV
	 dwZJdK6I2M1V9A4pWQ7OUaRAJxUnSC/SMxapeKOdL1pFzZPKZ3IBVSK0VJoykx9kOd
	 sz9xgKfJK5huw==
Received: from debian.. (unknown [171.76.80.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C2D9217E156C;
	Fri, 18 Jul 2025 12:54:19 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	lumag@kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] drm/ci: disable apq8016 and apq8096 bare-metal jobs
Date: Fri, 18 Jul 2025 16:23:53 +0530
Message-ID: <20250718105407.32878-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718105407.32878-1-vignesh.raman@collabora.com>
References: <20250718105407.32878-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These devices are being moved to LAVA. The jobs will be enabled and the
job definitions will be updated once the move is complete.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/test.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 81147e86bfd0..53d19ffaaf61 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -148,7 +148,9 @@ msm:sc7180-trogdor-kingoftown:
     GPU_VERSION: ${DEVICE_TYPE}
     RUNNER_TAG: mesa-ci-x86-64-lava-sc7180-trogdor-kingoftown
 
-msm:apq8016:
+# FIXME: Disable the bare-metal jobs. These devices are being moved to LAVA.
+# Once the move is complete, update the job definitions accordingly.
+.msm:apq8016:
   extends:
     - .baremetal-igt-arm64
   stage: msm
@@ -165,7 +167,7 @@ msm:apq8016:
   script:
     - ./install/bare-metal/fastboot.sh || exit $?
 
-msm:apq8096:
+.msm:apq8096:
   extends:
     - .baremetal-igt-arm64
   stage: msm
-- 
2.47.2

