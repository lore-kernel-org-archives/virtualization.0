Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBED145A1F;
	Thu, 14 May 2026 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755528; cv=none; b=VEDBN/9oyAWy01yGH72sN2H8XcOaPmr6R5Hiu0Sb2gSou3LsGFH4AoDQGXs1uR8CKJWvUevHk+LeM9Kp+M4qywtSFXiOtBuBL1KGeXowwWCXqVg0GlvBSrVtcq3tKikdlMALjHiIoCvXCPJiF5zRi/hSYOOEI0OJmBnbQKle1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755528; c=relaxed/simple;
	bh=2Xy/uOEwjIdS1BuwcJydzBd1CPrsbg0kCWkIVa3N494=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqfpY9f5RIQx8KWPgqLTR/tmKs5sMPesRlutykOd5yeJjwRlAvCfOJ5z8sbzXQBxX3dV43pGodHMtdynWbKJTCqlch44TO9MvDwRzE4wDSQB+Q4qrDhyg0+k3uX5pcdqBQMHPiqI8liBYIqG6OyyWC0V3HXRU47p/ntD7JWNLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=IpMASfUb; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="IpMASfUb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date
	:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UhfR0/ZvF83ZUidAa86k1A146BHo3+5dN86/KotPlUA=; b=IpMASfUb/MJykO5z5m6hGBV9MT
	D572dGWdme4s9SvJRQfNyDCZQcQAMH4/tQgX+0BBImN5BqDJ2LxU1N3WRB7Lxh+wJaIcFubGEcmOZ
	EbvR1RGPYrEUgkmRY2un3UPhKRJykI3kgwQjD1tKUH2VtTA3mC6wbFX09ErctTCpCldsHMpvTqeRz
	VWEF8BO+eyn4U1sgQGAsv944/Mhe3OJvqVs65URnOZx7rrLE/dRIVp6TltOg1hvvUaWs4Kwj8T2Ya
	p3yF8E+PMagcgf7YWDWMFsbQecIr34zAD7h4E1iSSsLFBfLQ4mM9zl1cfDGkeWG1ocwHpdLkwjSwm
	OUwBfJUg==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wNSzB-005gW0-0l;
	Thu, 14 May 2026 10:08:10 +0000
From: Berkant Koc <me@berkoc.com>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/qxl: validate dst_offset in apply_reloc against BO size
Date: Thu, 14 May 2026 12:07:40 +0200
Message-ID: <1778753260.e30adb21c660@berkoc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email/skynet 1.0
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com

The QXL DRM relocation handlers apply_reloc() and apply_surf_reloc() in
drivers/gpu/drm/qxl/qxl_ioctl.c perform user-controlled writes at
reloc_page + (info->dst_offset & ~PAGE_MASK), where dst_offset comes
verbatim from the drm_qxl_reloc ioctl argument. An aspirational comment
above apply_reloc explicitly states "dst must be validated, i.e. whole
bo on vram/surfacesram", but the validation has never been implemented
since the driver was merged in v3.10 (2013).

qxl_process_single_command() copies the user drm_qxl_reloc array into
qxl_reloc_info, narrowing dst_offset from __u64 to uint32_t. This still
gives the caller (any DRM_AUTH client) the full 32-bit / 4 GiB range and
no bounds check against dst_bo->tbo.base.size happens before the writes.

The kmap target is io_mapping_map_atomic_wc() over the QXL device's full
VRAM aperture (vram_mapping). The BUG_ON inside io-mapping.h only fires
when the offset exceeds the entire aperture, not the specific BO, so
writes within the aperture but outside the resolved BO succeed and land
on whatever data occupies those pages -- including other guest processes'
QXL BOs, queued QXL release-command BOs, and ring buffers that QEMU
consumes.

The kernel-side primitive is a guest-local OOB write (CWE-787) against
guest VRAM, not a host escape. Corrupting QXL command structures that
QEMU/SPICE then parses moves the attack surface to QEMU's QXL parser
(separate codebase, historically vulnerable), so this is a viable
priming primitive for guest-to-host chains whose terminal step lives in
userspace QEMU. The kernel bug stands as a defense-in-depth concern
independent of any QEMU chain.

Public discussion of this issue is at:
https://lore.kernel.org/virtualization/36acd33982bfdce04090e17294596ff8@berkoc.com/T/#u

Add an explicit bound check in the per-reloc fill loop in
qxl_process_single_command() so that both apply_reloc (8-byte write) and
apply_surf_reloc (4-byte write) refuse out-of-BO offsets and the
arithmetic overflow case (dst_offset close to U32_MAX) with -EINVAL.

Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026..c65d468 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -231,6 +231,26 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
 
+		/*
+		 * dst must be validated, i.e. whole bo on vram/surfacesram.
+		 * Refuse offsets that would write past the end of the bo, or
+		 * where dst_offset + write_size would overflow uint32_t.
+		 */
+		if (reloc_info[i].type == QXL_RELOC_TYPE_BO &&
+		    (reloc_info[i].dst_offset > U32_MAX - sizeof(uint64_t) ||
+		     reloc_info[i].dst_offset + sizeof(uint64_t) >
+		     reloc_info[i].dst_bo->tbo.base.size)) {
+			ret = -EINVAL;
+			goto out_free_bos;
+		}
+		if (reloc_info[i].type == QXL_RELOC_TYPE_SURF &&
+		    (reloc_info[i].dst_offset > U32_MAX - sizeof(uint32_t) ||
+		     reloc_info[i].dst_offset + sizeof(uint32_t) >
+		     reloc_info[i].dst_bo->tbo.base.size)) {
+			ret = -EINVAL;
+			goto out_free_bos;
+		}
+
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
-- 
2.43.0

