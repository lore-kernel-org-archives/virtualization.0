Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8237B3F7
	for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883560; cv=none; b=JvTdp369pAzHT9unQV+1RXEVXVi+MRfGAszsVvreD5oizkr6CknPYGZ1dXix6mpx5dwuxtDCOwgjU9AVHl5dSEepJPBCaD1VMJUq/OGIefQZiB67oFeHIq1GEK8oo+6O94K6L+6kDJ1gQm12lL2PbEixDWmvAAvLAVQdLNN+bxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883560; c=relaxed/simple;
	bh=riMK5tIxZ/tlx1xUBChqxhQ0YqYmC9DikPeWZJpzIAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRj7E5kCCG400+rKbYw8dHPhkMtPwtp4ep4LvHPDV+h6sVFdsQovpVvd2vMn61wxXWyHP7luIoa66N+JBZo+AmJ3RVwCg4H1uKFH3Kb1rU7PeptR2Ym5+VasTQYlsUZBn8Cn69Yp2BpEQdmR/8yvrKIZLI3dLOALAPg+Q7Ywu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=VsnOxpLl; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="VsnOxpLl"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZMp5qLMzlh2fD;
	Mon, 23 Feb 2026 21:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883556; x=1774475557; bh=1Bmdw
	9NbhTfvVL4UZl+mqhgJRe3L8OtoJbJ8D9bpECI=; b=VsnOxpLlf4w9fleq1shLZ
	3ZzlIjtc2wcraM8gei2DK3hIIqs+J8P6h6hEHP3/iRrc87UpVRX9MCqh/Nbj2PoY
	mORggl3Ws47HuKDqeydwE5YB38rXHLgBOUYRy9mNoznd8Y3IiUAjtd5HUbNnfjJ0
	YeVZRZff4qZqgJQnTdo+yaLijM+Gn/fqWgsjxfHML4ohtxzpfIae6Vs5wLHOtTnu
	mwVt0qNVQceonGxxjhgoEtdLYDzV5p5Y5q3VaElTwJfQ8nMfbHoWUjFi1ExIqYFu
	SQ3zreyxHj4/xyV01m0j807e956oQIXkt5YENK+wf6rPI003PABWfzoiS2Ckq9Qg
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Y226Vvly3dkF; Mon, 23 Feb 2026 21:52:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZMg6ZgSzlh1Wk;
	Mon, 23 Feb 2026 21:52:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 13/62] drm/qxl: Fix a buffer leak in an error path
Date: Mon, 23 Feb 2026 13:50:28 -0800
Message-ID: <20260223215118.2154194-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223215118.2154194-1-bvanassche@acm.org>
References: <20260223215118.2154194-1-bvanassche@acm.org>
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
