Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043E6D1D2
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296017; cv=none; b=S49kv5cvrFAUZvCq3j/x/tc1S4Cv8Riieu6GHjFHFEXimXt+49+4+zoh88MtKXKmp0/VN7Tfq0Kr+l419aYmwrueI/hezSiyamxHVv5jIdk3wlL94x7GVSMPykdH3jFE7SCZnPXanV5ONyApXpkSwGWC6st27t+vwYokgZQsKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296017; c=relaxed/simple;
	bh=j5D9U6KjNVFx9zJvU329TCD0lS74yEhf5AvcIdP3EC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlvR+QuP9tyA/vBtc1hI0dZEXNDKdWcYxIF7M7wQy0rTmZZwsXrURPZHh/tptMqGSPx2ZqCy/ybKuSe1HyavVBd4a+Zo5Yt91PByNLVqL5YF/MpxeokggG22wpYK5rPsbkOnndg8Sin1ZvHjMpZscntgMzjlD6keTMnIaJmqzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=PdctvGqO; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="PdctvGqO"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6785E6087B
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 12:26:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TK_0Zv7spN1G
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Mar 2024 12:26:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.19.76.54; helo=mail.rosalinux.ru; envelope-from=a.burakov@rosalinux.ru; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 847DD605D4
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 847DD605D4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rosalinux.ru header.i=@rosalinux.ru header.a=rsa-sha256 header.s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503 header.b=PdctvGqO
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 847DD605D4
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 12:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id AE28ECFF46BCC;
	Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fqAs-W5z0ecx; Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 84DBFCFF46BD3;
	Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 84DBFCFF46BD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1709296002;
	bh=GPmQWvjQuc1pVJSK54+GnJ6cGFBHUxKlE2p3TVblCUs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=PdctvGqOjq3p2Zi7u3eZmpT/nGJf2zXfxbj9ZZS/6BvPa9WdbccuaQU/a1buAlzaC
	 lVQ12ZpwmWjDVedZ0smgilBF8Z9Pe6XTnpIJ6krCG8aId80PRbrOGaVlptqYNZB+Yr
	 wSAiQLLqn61BPdFa6L2VO57xPNZseHWfXUpCL19ZXoz4/zXVNFK7qBaSHTzKgPkFoy
	 4wwsxFNmCIXStxhnrXXpp3Vh9fwJDbH6AgIYKG8bDv7Mhw/uP6sQ5KgvDZZJyCZkqW
	 farm3lc+/N43U0R7OhXA7dtka1vlBlx1I68xZq6QYF8bhRJ69UMWEhvPE3fOR9L9Wv
	 fmVWP3Fdhrk7w==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IDqMVs1C3EXX; Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 48574CFF46BCC;
	Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
From: Aleksandr Burakov <a.burakov@rosalinux.ru>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	virtualization@lists.linux-foundation.org,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] drm/qxl: fix NULL dereference in qxl_add_mode
Date: Fri,  1 Mar 2024 15:26:35 +0300
Message-Id: <20240301122635.25058-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <oprbqmdpjzhjwuqypqfdnirl44drvrhlaiounos44ywdbiustm@myk6llv5chlv>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Return value of a function 'drm_cvt_mode' is dereferenced without
checking for NULL but drm_mode_create() in drm_cvt_mode() may
return NULL value in case of memory allocation error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
---
v2: case with false value of 'preferred' is now taken into account
 drivers/gpu/drm/qxl/qxl_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
index a152a7c6db21..d6dece7a0ed2 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -236,6 +236,9 @@ static int qxl_add_mode(struct drm_connector *connect=
or,
 		return 0;
=20
 	mode =3D drm_cvt_mode(dev, width, height, 60, false, false, false);
+	if (!mode)
+		return 0;
+
 	if (preferred)
 		mode->type |=3D DRM_MODE_TYPE_PREFERRED;
 	mode->hdisplay =3D width;
--=20
2.25.1

