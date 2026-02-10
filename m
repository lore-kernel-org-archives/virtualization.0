Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803B33032E
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770707528; cv=none; b=BCs1w9vd5YAh0JZPi88zLWqbiImbjTKGUVNO2LiR31fydGYRNts4/RXb3GUFsSJRSO3bPZmRHOT87O42P4QNATFVYPHdOYmXP8un2iCyIwEUwtUxGAdOmtAkp+/9AvImN8MjGpBkqBf89M1Lt+zU03zpcAzGtNW/5sW20VRMYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770707528; c=relaxed/simple;
	bh=rCvwRJK0W1o4tQMv1YUlAV0iLAot+fdH9pyn8DDPkzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITXHHKwvkB1plH5ZNzDgloxSGXLQ5hZ2X0vrVTgB9x2rnfOa4RN2ee613kdqxVvlFwsttBTFe0D2k6Rt7jWLcwZTCdoRBuE5IBui0iRA++dtjTGUNwmv9VEOb9oY3b+WLquPHB++ABDlbnRdnT6gbel0+p3dXaUBY0+slUB+Ljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ollmS416; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ollmS416"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770707525;
	bh=rCvwRJK0W1o4tQMv1YUlAV0iLAot+fdH9pyn8DDPkzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ollmS416MnF1p+bIkLxzga0hVUTR1dkZ1ZAjfTeIspGzfAhGX9bLJJbEE75CbGmhO
	 HTi0sJC3eartiybLxVcJ1AQvEOlVqCtuJugMoHkVJ0rqNm8o14YgfrwXOjYOBD+zPe
	 hg/5D55WQqb1POGXXPo9NByhmLYU3bU96XBvw9zeGbiSC3gZN2tgVhz3nvEYlJ3z5/
	 ysH4z71Ldlv/Rv8hIJjFbG6S7MH3ZLwStUlFci0/WY877POaUW0AiEg8GcFbwfGHz6
	 D+A7dDTOD0IhiGe6sFv2VFGH2sxpBqZYvwvPtG44AvJjj7kiuuQkxt23leB1l9ux0h
	 dji2hcLrrxiiA==
Received: from vignesh-thinkpad.. (unknown [171.76.81.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0929D17E13A6;
	Tue, 10 Feb 2026 08:12:00 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	dmitry.baryshkov@oss.qualcomm.com,
	lumag@kernel.org,
	robdclark@gmail.com,
	robin.clark@oss.qualcomm.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] drm/ci: reduce sm8350-hdk parallel jobs from 4 to 2
Date: Tue, 10 Feb 2026 12:41:30 +0530
Message-ID: <20260210071138.2256773-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210071138.2256773-1-vignesh.raman@collabora.com>
References: <20260210071138.2256773-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sm8350-hdk jobs are short and each test takes around 2–3 minutes and
the full job completes in about 10 minutes. Running 4 parallel jobs uses
4 devices at once, which is not needed. Set parallel to 2 to reduce
device usage.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
---

v2:
  - No changes.

---
 drivers/gpu/drm/ci/test.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 81147e86bfd0..762598c7db25 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -183,7 +183,7 @@ msm:sm8350-hdk:
   extends:
     - .lava-igt:arm64
   stage: msm
-  parallel: 4
+  parallel: 2
   variables:
     BOOT_METHOD: fastboot
     DEVICE_TYPE: sm8350-hdk
-- 
2.47.3

