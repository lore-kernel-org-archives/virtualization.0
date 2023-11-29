Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EC1DA2A
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CvOBtgya"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79A0581E7D
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 12:19:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79A0581E7D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=CvOBtgya
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lEt_BIxfCQrq
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 12:19:32 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C3FBF81E4D
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 12:19:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3FBF81E4D
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id BE0426607326;
	Wed, 29 Nov 2023 12:19:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701260370;
	bh=XPqb5JshYNquGPkJGWY0HezlshvZancOV1Y08nA8CYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvOBtgyaHioy9cuADbv5R52hqXzjAP6cvOJry63R7jsCOKHTBGchyto83ojeFKwwc
	 CSN/82xQ6AtamhXf5OZFA1EAQHnxOP8FcDeWA4kZBH9khBgZ159iLfJ/XfQJ4hxDJN
	 vtNHkmeKWkukAUFB9tJyIHES7LevAq0IIjfjABewYpCGeCvAWRqY2Cs6L2f7BCyjRV
	 zBHtJkuY8t78GXfQMKVQZgUC1Fi2l0skQZlm2HgxPjhtBFJ5FBJp/f8MO5N2ZEg1Qa
	 oXV/vJtFK1Y5V5XSFzPVR3RHCpQ2EeLiTa18AXJiiAIwvNics+lU6X+jb9EPXYDfYZ
	 3aGfOJeGQNMyw==
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
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 09/10] drm/doc: ci: Add IGT version details for flaky tests
Date: Wed, 29 Nov 2023 17:48:40 +0530
Message-Id: <20231129121841.253223-10-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129121841.253223-1-vignesh.raman@collabora.com>
References: <20231129121841.253223-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the IGT version in the flaky tests reporting template.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v6:
  - Added a new patch in the series to update drm ci documentation

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

