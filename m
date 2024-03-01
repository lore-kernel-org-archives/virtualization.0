Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D76A32F
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283951; cv=none; b=nR7gCKWu5vPkIf+xueITK/9gbAJVsG7UHpE+duD0523HAgsFA8zTg2cdG8h/7VA1x8FitsjpP/+DUBQSPNM+Zm7ghZh/4MZNWrkOGt+0+vOvgCdoTRS77Y9L7IxnEt/qC3ScBJcMQP85e5G7ywNQRam3G5pL4z+Z04bGXQejlak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283951; c=relaxed/simple;
	bh=U6zrGDf1CH9J4v5DCBN2pKsyO7iS9kDU6k4Ptp3kKy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSXVWa3+KzZx+nVK3iuY10IVFYa8iBx2DPVWPK4pSkOZKaPW3uW38JFJzUevBNjt9nB89SKTsz2FRGFOE5Jz1kbq517w0fJUefjoKAgANTt95HfGs7AV8oOtZr5CgJIqv2LHT/odNmJMNFP+yhhkgKO2m4wfC56WeyGTDDzyfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=P8auQz5C; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="P8auQz5C"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D485841579
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 09:05:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id opxQjc9w7Oj6
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Mar 2024 09:05:44 +0000 (UTC)
X-Greylist: delayed 603 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 01 Mar 2024 09:05:43 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 95EC941559
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95EC941559
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rosalinux.ru header.i=@rosalinux.ru header.a=rsa-sha256 header.s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503 header.b=P8auQz5C
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.19.76.54; helo=mail.rosalinux.ru; envelope-from=a.burakov@rosalinux.ru; receiver=<UNKNOWN> 
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95EC941559
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 09:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 20489D998EC3B;
	Fri,  1 Mar 2024 11:55:33 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id z6G6-abwn9Qu; Fri,  1 Mar 2024 11:55:33 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id E0C91D99A42FF;
	Fri,  1 Mar 2024 11:55:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru E0C91D99A42FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1709283332;
	bh=f2qKsIAGkUNEVelOg7DTK/0b4IF/e+zG6QgMW3olvD4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=P8auQz5C6OaEzL92Wd4UVkrC0+agep5xnkw9WQbAvEflW8hYcBiV0bOPGTvWixe7R
	 5gxvNYDmZDMIDT39UZNaUeriACLVOP+LYwBzNwp2rfCUbIjLGIV4y+Gn9PkkJH1Er2
	 JUF5lJQmT3mMEr+/Q+tD7LNg94RH6EhR51r9IvJ99jPoMVABIFcQizUSbngm4T9xos
	 YOlMDOS/3uc9mLjR6mQOjQb3qWpyRgPOrUpRCM0lhwhsDpkcZH8FPO5fhQU+YqsFOp
	 sZn27iVdF2fI7cmW584/cJT+Vz4OzY87Bc1BK5LaXVEkH+8L44a/1Ao+xDCGi3r66n
	 9aqkPUQvTnBAg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I9d5Qmb4AYe6; Fri,  1 Mar 2024 11:55:32 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 97E4FD998EC3B;
	Fri,  1 Mar 2024 11:55:32 +0300 (MSK)
From: Aleksandr Burakov <a.burakov@rosalinux.ru>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	virtualization@lists.linux-foundation.org,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/qxl: fix NULL dereference in qxl_add_mode
Date: Fri,  1 Mar 2024 11:55:11 +0300
Message-Id: <20240301085511.23298-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
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
 drivers/gpu/drm/qxl/qxl_display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
index a152a7c6db21..447532c29e02 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -236,8 +236,10 @@ static int qxl_add_mode(struct drm_connector *connec=
tor,
 		return 0;
=20
 	mode =3D drm_cvt_mode(dev, width, height, 60, false, false, false);
-	if (preferred)
+	if (preferred && mode)
 		mode->type |=3D DRM_MODE_TYPE_PREFERRED;
+	else
+		return 0;
 	mode->hdisplay =3D width;
 	mode->vdisplay =3D height;
 	drm_mode_set_name(mode);
--=20
2.25.1

