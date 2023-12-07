Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F373419A
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lGVnA638"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA84C403E9
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 09:19:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA84C403E9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lGVnA638
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F_7dKeZWKzEI
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 09:19:18 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E6234404A3
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 09:19:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6234404A3
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 1241C6607393;
	Thu,  7 Dec 2023 09:19:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701940756;
	bh=qmAKEwMzQObcjLEImfox96rI8rjtke8mQ615PmXpD6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGVnA638sMEQ9HaGHUDUvuHtJ5Xh/906YK6hhJu/GIKx7xqGz7Fojo1t+eMsIo5cq
	 rMm+GieXrh/Zht8XyARJl/XABeOOMRifvopgH/WD0JmvyJQjvWoCbstPi3IE3q6R0D
	 mtTI1ZXW4A+5IuYkMxm8A45j9/BXIyp2rKV5UsbUw24i/os8twuWB91V6u2nfnZiqJ
	 bCV0ox19vmwdGqlYDSkhoCtEG3ZaJ9wi1gCz5uOfEYQBigzgpy6uKGVdRfUKZy665k
	 W1A97teFWuaU3HCzcXXtkaM4EqRU7R+1TCT3LFNHZrwI9fLPxuk89Vg9OIGh1cUcZ1
	 /GNyhEhXCKx2A==
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
Subject: [PATCH v7 09/10] drm/doc: ci: Add IGT version details for flaky tests
Date: Thu,  7 Dec 2023 14:48:30 +0530
Message-Id: <20231207091831.660054-10-vignesh.raman@collabora.com>
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

Document the IGT version in the flaky tests reporting template.

Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v6:
  - Added a new patch in the series to update drm ci documentation

v7:
  - No changes

---
 Documentation/gpu/automated_testing.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
index 240e29d5ba68..2d5a28866afe 100644
--- a/Documentation/gpu/automated_testing.rst
+++ b/Documentation/gpu/automated_testing.rst
@@ -69,14 +69,15 @@ the result. They will still be run.
 
 Each new flake entry must be associated with a link to the email reporting the
 bug to the author of the affected driver, the board name or Device Tree name of
-the board, the first kernel version affected, and an approximation of the
-failure rate.
+the board, the first kernel version affected, the IGT version used for tests,
+and an approximation of the failure rate.
 
 They should be provided under the following format::
 
   # Bug Report: $LORE_OR_PATCHWORK_URL
   # Board Name: broken-board.dtb
-  # Version: 6.6-rc1
+  # Linux Version: 6.6-rc1
+  # IGT Version: 1.28-gd2af13d9f
   # Failure Rate: 100
   flaky-test
 
-- 
2.40.1

