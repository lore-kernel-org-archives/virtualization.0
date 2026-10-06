Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43E4A1DEB
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301811; cv=none; b=IGmtMZg7HTaRkWKVU4hdA0rUWeqcBF0ZANwPcmF8sLpbSGqirCDVEI/m6Z1qwtmiMuFSIyGgg0cnQi4dmdjWp646QmDgpy+I2C8JRLibU3pIEUIz2dJku8el2BXQvmpYiGsJftWWUHR6ukQ1LGEiPm53DdgN7+V9zDUqLcAfFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301811; c=relaxed/simple;
	bh=+z3BTio3dttLfzIRdDJhJENtcbD0+/tRk0bwGMvwPJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILjFcKmRvh4EUCtVKLkqLwCosidHS2spCQ8QuzQFUMvjDTjAGbERyQWwCgJ2XQn0kTmm6MXZZ51Ap1Rj7CylPXX5lRwaQ94rhwQ9bPwCWL8kTAYW0mkk2Tknk6H4KO8RH4UEBRckZ8ZLntfCAB162NMKKCRprC+Mxwsn7ACTnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=kn9jNxXH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tzC8gk2n; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="kn9jNxXH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tzC8gk2n"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C281CEC018C
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 11:50:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 11:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm1; t=
	1791301800; x=1791388200; bh=bHZw8spNWvxR68eOttzhCB7EQBznbaSXg7W
	RKemtuj8=; b=kn9jNxXHc32r8K0WNDobcXnajoZQnnP4xoS+Rm02iQlTy5jOqFr
	o1th/+iTmU9G/4et3iJnU0zUu//a9GF6MZiomEP5xIoNUqy9oguz299Wa74sdEA5
	pt0c8dpximEbC2BbaLHQvWWgkQA9SklOIYpWqTSC3GAeAgHO8G3vQxtllpkmQf1J
	H3Hh16EFGGCH6jXAdMRSVagcZitVnxnCEsDHcXgS+zqVgJSpekCtmD4gpMRCWxGK
	OpMpQ+Pdrtd+suBfWaG2OoMDaakN+8LedXKkMXaXn2Cgx1Ssyv+P4KHqCy8t+lnq
	jFaYsT1kdb5fGYT1SyxubI4CS4QP5V4aRCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791301800; x=1791388200; bh=bHZw8spNWvxR68eOttzhCB7EQBznbaSXg7W
	RKemtuj8=; b=tzC8gk2nPEDwXFulLRmlUF7TDoNpKEA32xG448uDA7R39rtDiSc
	0TXOzxST2Vd+b/VCNCRJoz/uTiz6FOGlI5sNRew5SWseovuKw1zOP2NgpuI6VD7e
	V8TZXOtze0y8TgXE+eIS47qCvD62+17OVStG3dJMLXZJ7v8UvNOIBliaaXsKb9Z7
	Ya6CxJGqrmUbPw0MC7ubg9K/Y9na+JdEq1jZJhvGnB0+dzuJxkYT+rXfe8euS+TT
	NbXmpOqZLmP29uhyyhhTKZZT+4KkfWsRBmxQGbc9PVlTYqYiI/ahsFoxBIas23t7
	n8xOY07U6RQGMB36wFU3PtdZKEhMTH8spMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791301800; d=invisiblethingslab.com;
	mf=PHZhbEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg==;
	rt=PHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:OmWLFKW8xJcJz9TRcSeZQEw/+T+rkOVTIdyIEFCYJM5aPgi
	8RmYFsm9EwryS1pJsHn31bOUUt4SqleTfMkB+NUsvi02rSUGxPM/mHObN/uzFE7O
	eAHaNX1gFUNiafuKFDiCnVciEy0uIQFdDKGOEvRRM3DEqJReH7uuWKJecUihEXYe
	T71pSsQ73TsKdCqvXiSqGggGh9jQwgGLAG7/SBN34yh+CmQ5Csu7HNw9Cc4/VQ+3
	fy/+CcT0vvAtTbYo+9uOEfAb49oa2LqMt81CKnQe1fSUTkhY+LjVL5PE4vHVy7rQ
	Cv4KxycyzMmMz2d4tC7kciVs24rKiMgH/MS2zWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:uTBDXNl40C+ztrwCU2gxTmFmjMy8XCtfnda7alaSZFk=:+z3BTio3dttLfzIRdDJhJENtcbD0+/tRk0bwGMvwPJ0=;
X-ME-Sender: <xms:qBjFatHHiLJSxcqkKwdk2a4BeiFDr1W8jO6MsCguC1YOq4cOzY_iDw>
    <xme:qBjFautZT5smrd-FmAln0rPUcoW4-4JKOgo_3ST4pUQLolPDAp1eZDA8een8CAVNw
    wVBp219vcOoprqg_J-paRJBUTcO2XRF_Pc41PZDzNO3vjAZNMKr>
X-ME-Received: <xmr:qBjFajn88VwQemVEwk4mejGeJVs_tmBKam8zCwWRy9VI43b7Up4zI_IIRhhgTOLqxXWxUflYalrXnnum_JoAfhr2lFba01JX2Do3i0R_Paz_l8pv7mdInREDiNPz0w>
X-ME-Proxy-Cause: dmFkZTGK3BYQg4D7QX8O2SLVb5Fmjf863f1hkDTTDgUlu/D82rNup2Ngu2sVmKhTDesYu8
    jHatZlWRTI0Z3GHm4tKcM+ZVIpL9JNo7l98jpnMm1L+O52kgwsr4lVL3JC7C108cTuHYsB
    BdgFFffZzLpQEs+9UGyJyfZzU+t4Fk+WsEu7ijT7GgaVieiDpB0zoMMeOrTbFjLpXlhzmn
    Mdkg/c/o+1bHIC5PTYJiVSxQQ6o0ReOQiN1zpu1fVCQaq+6PsQAuzSDAVHHWtawcr0cwIn
    eRJJXNbLfspAo9qV6pEkXQFpo81japWJcyr8An4m12/rcFROQVFNQ/1e+bd3maNaN8JESd
    f6Gk6vgQWuW2Z0k9yylV+hzZ+OKjgMO7vLEB3oiHlD4RugkFP/YdhXuRDCnXCbNsXlyDc3
    eAMTzy4r6I4ppwv3FQP+CGF9E5v2TI/udlNsPiEAa4FuuA5RC265N/PAqW+agj5xwblkfM
    crmZYSTn/IBeG/jlfA/voShFjKBStlxWwMJFD5rYTSLPkGtuj/eo7xS3bpoMVtr0yrHM0I
    uREJL75NZ9znyquCWYgkrIlEF7IIMmcrzNrzApDAshirdT1mH16GMmtbuxKodvL7yNMNZ9
    8+LAEo990juLJibq//tZkoliPe8K70C1ewCy/sNaQc+ig4LxhF2Vk+qM7mMA
X-ME-Proxy: <xmx:qBjFahOvZHVvIbR4vlfvuEFggNo-prmq8Ki7iP_GBJZ7M1kAM4xx7w>
    <xmx:qBjFavw8dP0wJnKRXv4ObAsuF6LwJYNtTgv2M2gvhdrf3PbSqPqp_Q>
    <xmx:qBjFamuD_zTklgzVyVPe-b6JD4nmn7WRqpV4_2VFqsy4kIicZH5RaQ>
    <xmx:qBjFaqYbrKVvos5YYne8-on4tncDYJYsFTB03NvDPLBTpa-nLRk89Q>
    <xmx:qBjFahFlcVUhWJIy1FZxclE3OQJG-8ZpkC2bjDOmfQ51sUtbFHo5pVgJ>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:49:57 -0400 (EDT)
From: Val Packett <val@invisiblethingslab.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Sergio Lopez <slp@redhat.com>
Cc: Val Packett <val@invisiblethingslab.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/virtio: do not enforce blob_alignment in cross-domain contexts
Date: Tue,  6 Oct 2026 12:42:50 -0300
Message-ID: <20261006154913.2689067-2-val@invisiblethingslab.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VIRTIO_GPU_F_BLOB_ALIGNMENT is designed for GPU rendering context types,
however VIRTIO_GPU_CAPSET_CROSS_DOMAIN is not one of those. Resources
created under cross-domain contexts are arbitrary shared system memory
files, which includes unusual things like Wayland keymaps received
from the host compositor. Do not enforce alignment requirements there.

Fixes: 47248e0d8264 ("drm/virtio: honor blob_alignment requirements")
Signed-off-by: Val Packett <val@invisiblethingslab.com>
---

v2: also check has_virgl_3d to prevent dereferencing NULL vfpriv
v1: https://lore.kernel.org/all/20261006004044.2242154-1-val@invisiblethingslab.com/

~val

---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3ddd5481d6bc..4d5ae062834d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -551,7 +551,9 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->blob_flags = rc_blob->blob_flags;
 	params->blob_hints = rc_blob->blob_hints;
 
-	if (vgdev->has_blob_alignment &&
+	if (vgdev->has_blob_alignment && vgdev->has_virgl_3d &&
+	    (vfpriv->context_init & VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=
+	    VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
 	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
 		return -EINVAL;
 
-- 
2.55.0

