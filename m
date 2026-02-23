Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EADD33A6E9
	for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883423; cv=none; b=Ct+ZORUFpCxtVcN1p9V3QEzGc+UDyFBgdaHYEcYWppSIX5N37Orem6se7Otji3tjCx0FmVJGkxpQsgdgkz3AxN4pUuE19cxr7Lqoy4Zv5khKolB8zdi0h55OSiPibRhDx+9/22aKBns9+/YwyDszE1EeqXkqwbjMLaI38+vq2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883423; c=relaxed/simple;
	bh=riMK5tIxZ/tlx1xUBChqxhQ0YqYmC9DikPeWZJpzIAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auUv9oTNkvsfCPYTHu3dkr44ZgElHRNU2awvbzfmZPIGTW+oeJ9HdrYavJCjTu6xw/zUYwuNTKT/9nbPoijwKiqJCHxR/xKbgEvLobThD23pj0W/DglpYOZkXzIV0J/Yw0Zfo+bhrNqTxOlGNqof2QpBizal+KsoXU/sHbgg3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MSP/HSNI; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MSP/HSNI"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZK95vr4zlfl7s;
	Mon, 23 Feb 2026 21:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883420; x=1774475421; bh=1Bmdw
	9NbhTfvVL4UZl+mqhgJRe3L8OtoJbJ8D9bpECI=; b=MSP/HSNIJ722tGqNCTEPe
	no5J1V8JJ1Fhd5t11iWdUe2iV3jgutmfU3ehAWbjQxh4KOo5Dc5KXlzriF6r5cNp
	yhgkrJ/tnoWKILTOHAGOCKyepUR3jg9QcB72rt8NfSSclkAHFYy0kDH3JcKQrLek
	/awoIGmQgxj1uGk6Ee+R1fw9nIb5A/QMIATxSrnEl8L5vRo9WH6QkI9i1Y1wRR5Y
	QCFzb48DHHAEHGDm8xUv68Vz/XGfCbBMG4SSofQXooUCnKVHsASm/ZSy62fJjMqh
	mOSHE8CCOcIwYGlDJ1VApcTreqeWaYp5AzFKW2HSZZA4Byfbqg8JBoCJP2yZz93v
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XJNnmmGjJgBD; Mon, 23 Feb 2026 21:50:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZK76Y0NzlfgPY;
	Mon, 23 Feb 2026 21:50:19 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 13/62] drm/qxl: Fix a buffer leak in an error path
Date: Mon, 23 Feb 2026 13:49:01 -0800
Message-ID: <20260223214950.2153735-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223214950.2153735-1-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If qxl_bo_reserve() succeeds, call qxl_bo_unreserve() instead of
skipping that call.

This has been detected by the Clang thread-safety analyzer.
Compile-tested only.

Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
index 4ee2b5acf2e0..5617811f3c9b 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -323,7 +323,7 @@ int qxl_update_area_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *f
 		qxl_ttm_placement_from_domain(qobj, qobj->type);
 		ret =3D ttm_bo_validate(&qobj->tbo, &qobj->placement, &ctx);
 		if (unlikely(ret))
-			goto out;
+			goto out2;
 	}
=20
 	ret =3D qxl_bo_check_id(qdev, qobj);
