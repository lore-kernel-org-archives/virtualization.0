Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B819D071
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335371; cv=none; b=dYcsm/iifxIRcl0ZhsNNEZZMGfnQnxoeKggdm9rens5zefmoMSObktC5NCsp9rBMqQp3iCb1OTp4Ejnvm7yv671c2zqM/d0rC2irJmOiS0TYSe4OGf4Frd6RpgrJJRGywAHmgeG11touWgkV5Uex4Pr2WkAlclkduH5b3Y1XJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335371; c=relaxed/simple;
	bh=gCTdPchWuc1xiR4tpvlqqw30LOOS9lTJyDFe5on17HM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRpuSR2aK64jv1pZEpnpk88juoq1bOWAKa3rwMYZaZXoPRki1hEmGn5Rzhc5bhqiN06WwllEptmrttC3jrMHlW2SjtITIcRGn49sx9rzKadaUuPRKfD5I4jJ/6tYCRoO52puAuzyeKcO3KbJ9GQMLx+7CKyIzsDZS5JQsoZfdew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TAFlBh2a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TAFlBh2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760335360;
	bh=gCTdPchWuc1xiR4tpvlqqw30LOOS9lTJyDFe5on17HM=;
	h=From:To:Cc:Subject:Date:From;
	b=TAFlBh2aNv23DXPQ8OmreZbzQmFTLIEjl9J0KbxvbjC5MtwEDNbXW5ujofaTRW+XL
	 KO2ISTQK6VLqg6gIt8eK01iUC61DOl72IhIbVAd8Uh2RUP0MV+1sbBup1PxcUL3Udr
	 rNFUwfDC3qq0kgUl0qUdx5t3dkfn+cHIOCN7SIWrLYmNfGvL7Dar5Jx6QYWjcHmEpA
	 ZmH/LzM1ZfJ5fjq8ANRpuElYt405PKG/Rru0AscGlyxSihbzvzzmy/vF0/u9uZL1Io
	 7KVmdMeZ3vp1bYNvsFVYPV/gZX1Wn7B/AL6tw4uOItj3wuAmFt97FfOZiW9LFpAlDN
	 ltp9kK/V6HuoA==
Received: from debian (unknown [171.76.80.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BC90217E0CA3;
	Mon, 13 Oct 2025 08:02:36 +0200 (CEST)
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
Subject: [PATCH v1] drm/ci: disable broken MR check in sanity job
Date: Mon, 13 Oct 2025 11:32:10 +0530
Message-ID: <20251013060212.14583-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GitLab recently changed the required permissions for the
are-developers-allowed-to-push-to-my-MR check:
https://gitlab.freedesktop.org/freedesktop/ci-templates/-/issues/81

Until that’s resolved, disable the check - it’s mostly obsolete anyway.

Based on https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37782

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index d502d146b177..56638814bb28 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -280,7 +280,7 @@ sanity:
     GIT_STRATEGY: none
   script:
     # ci-fairy check-commits --junit-xml=check-commits.xml
-    - ci-fairy check-merge-request --require-allow-collaboration --junit-xml=check-merge-request.xml
+    # - ci-fairy check-merge-request --require-allow-collaboration --junit-xml=check-merge-request.xml
     - |
       set -eu
       image_tags=(
-- 
2.51.0

