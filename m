Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2833CC1
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bc4qjA9T"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2523F83298
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 09:19:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2523F83298
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Bc4qjA9T
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sB1roCG-8klA
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 09:19:07 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 58E7183168
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 09:19:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58E7183168
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id CAC7A660739B;
	Thu,  7 Dec 2023 09:19:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701940745;
	bh=FI7vvMbXu6jw/8V7yXWu5M1HVFfmnKGFMWLn6Tl2uAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bc4qjA9TxkLS3NJOdvzQjV+8p6+K/mNbdEUkQRGrDgCxj+vR1BTD9G8EIC1Dr0y7F
	 NRa3+ZxR/e1uR7rThkSZ6SLCKrzUeAuCp85mz2kg3lNhyKl3kz7EDNf3jH1vyVTi2I
	 H7ByDIJ/kzpIc8xZFEzwNUQqyoRAeyTLttFHVElO34ZVjbo0wsGuMfLr/jQTIiNq0G
	 IowVm/oItYDlR0ZVJp2qrxRtNHxugUc8j45jRMsuHO81TfgBRxvuxhAJGkLr4h1XQH
	 7h05n7Bu3PSMdDs7p2yrOeKuFOVPcaR3dY+i2ZkOycSr8Ga34LLYDP+XBKtQ5jAsB7
	 2CEUg+1OYLf4g==
From: Vignesh Raman <vignesh.raman@collabora.com>
To: helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: david.heidelberg@collabora.com,
	sergi.blanch.torne@collabora.com,
	guilherme.gallo@collabora.com,
	daniels@collabora.com,
	gustavo.padovan@collabora.com,
	emma@anholt.net,
	robdclark@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 06/10] drm: ci: mt8173: Do not set IGT_FORCE_DRIVER to panfrost
Date: Thu,  7 Dec 2023 14:48:27 +0530
Message-Id: <20231207091831.660054-7-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207091831.660054-1-vignesh.raman@collabora.com>
References: <20231207091831.660054-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mediatek 8173 and 8183 SOCs have a separate display controller
and GPU with different drivers for each. For mt8173, the GPU
driver is powervr and the display driver is mediatek. In the
case of mt8183, the GPU driver is panfrost and the display
driver is mediatek. Setting IGT_FORCE_DRIVER to panfrost for
mt8173 is not the expected driver. So set mediatek for mt8173.

Support to test both GPU and display drivers for these ARM SOCs
will be added in the next patch series to increase test coverage.

Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v5:
  - Added a new patch in the series to set IGT_FORCE_DRIVER to 'mediatek' for mt8173

v6:
  - Use GPU_VERSION instead of CI_JOB_NAME to check if it is mt8173

v7:
  - Rework the fix and reword commit message

---
 drivers/gpu/drm/ci/igt_runner.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index c6cf963592c5..f1a08b9b146f 100755
--- a/drivers/gpu/drm/ci/igt_runner.sh
+++ b/drivers/gpu/drm/ci/igt_runner.sh
@@ -20,9 +20,16 @@ cat /sys/kernel/debug/dri/*/state
 set -e
 
 case "$DRIVER_NAME" in
-    rockchip|mediatek|meson)
+    rockchip|meson)
         export IGT_FORCE_DRIVER="panfrost"
         ;;
+    mediatek)
+        if [ "$GPU_VERSION" = "mt8173" ]; then
+            export IGT_FORCE_DRIVER=${DRIVER_NAME}
+        elif [ "$GPU_VERSION" = "mt8183" ]; then
+            export IGT_FORCE_DRIVER="panfrost"
+        fi
+        ;;
     amdgpu)
         # Cannot use HWCI_KERNEL_MODULES as at that point we don't have the module in /lib
         mv /install/modules/lib/modules/* /lib/modules/.
-- 
2.40.1

