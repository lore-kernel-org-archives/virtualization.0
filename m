Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B3369972;
	Wed, 10 Jun 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119017; cv=none; b=DBfURhUJZm4L8cORKkp+g8pGaBmny8yLpLIG/PHNKRe88hd+9izeplZ9ne4CXGh/9DdvdvOkl0zvyVyk4BVAjsIZGJcRG5Flro1J3Y+N7sPwE1PTvQ4lVXI05bJ5XjlmORPvK88uq45ScyDFPwdRjqNqAlYyYcAHw0N06ra0C1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119017; c=relaxed/simple;
	bh=87NuS3KNdlitbOETz2zmHH8D4uXV5+ppQqeSTQxa314=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t4WoOAnVj8HNzy+WYVinQCYx53oOUea55x7vsJUOmnECHhkDQYAI5A/PyZp+H3nUWppQseGQqryBUBxY2sbhQsVHCJSurjdBiGzhDuRSrGi/MH8PsJRcXn8Jjq3Tykj7i7YXf+738TbrIQMLDpif4A0imXNAD52hzlurmmoiay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggsLn+S2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggsLn+S2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2BD1F00893;
	Wed, 10 Jun 2026 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781119016;
	bh=Kpw1MsS52NmtqUVuVI31AuxdPeof9d4Z1uB6+yh651c=;
	h=From:Date:Subject:To:Cc;
	b=ggsLn+S2UnECXQqe4vtikcK8qQlfd0BciyI4rmMsVq6eR0xW1Xl4+sLjaSabBLW3d
	 1YTF/Uu9ZW6xjxfUY5bkRIUZhz4sG61B/7mLubWoO9Z2keThVDyNaynnf8IfsNZ+5J
	 UGIR3WTAD3f092cmGQ0lOv7kGi5yEYf1l9UqRWG+K/90gFKRrKhzggh1ekF3ZgChgI
	 SXGf+WA2hbdSi6nHjrJG9h3UvtBO4hBceZvt8DSnK/kUPRMu0INk1dQJzEqWz0ZPD6
	 7r4SxSctZjmYvDSiU5eMWVwZ7Kbn5xXQL2MCP2CK0Q/JDdO+PxGMpREx3zO8c3Nlfg
	 uD3NMjyttahXg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 10 Jun 2026 12:16:49 -0700
Subject: [PATCH] vduse: Fix error around jumping over a __cleanup()
 variable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-vduse_vq_kick-fix-guard-usage-v1-1-0ce02c08006e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAxA0V8ZeTbQrDLRXxEZtY0zDqY2tghj/
 75MHw9c7gzKWVjh1MyQuYrKczLQroF4D9PAKMkMrWs715HDmopyX9/9KHHEm3xxKCEnLBosTuT
 8IXpPezqCPV6ZLfn9z5e/tVwfHD/bFJZlBYYxzcuBAAAA
X-Change-ID: 20260610-vduse_vq_kick-fix-guard-usage-d1037c331419
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=nathan@kernel.org;
 h=from:subject:message-id; bh=87NuS3KNdlitbOETz2zmHH8D4uXV5+ppQqeSTQxa314=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmaO9Qkuwpjzom/cMxhVne0Y3uw+gu7U7PkmxynyUt3n
 LugsKuuo5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEwk9TMjQ1fFU8dbx0K3Jx2o
 0N/H8Ivbz3mLQJiL45ubaccurxPuSWZkON5/kOmhZ39SsGDBqvAF17a/vF50Nuu71ypnhvutB/e
 U8AMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with clang, there is an error in vduse_vq_kick() from
attempting to jump over a variable declared with the cleanup attribute
using goto:

  drivers/vdpa/vdpa_user/vduse_dev.c:566:3: error: cannot jump from this goto statement to its label
    566 |                 goto unlock;
        |                 ^
  drivers/vdpa/vdpa_user/vduse_dev.c:568:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    568 |         guard(rwsem_read)(&vq->dev->rwsem);
        |         ^

Jumping over a variable declared with the cleanup attribute does not
prevent the cleanup function from running, it would just result in the
variable being passed uninitialized to the cleanup function .clang
errors instead of generating the invalid code, unlike GCC.

The jump is only present to call spin_unlock(), so convert the
spin_lock() and spin_unlock() calls to an equivalent guard() to avoid
the jump while leaving runtime behavior unchanged, clearing up the
warning.

Fixes: 6c141c034c1b ("vduse: Add suspend")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index a257fdcb77b7..0500da043761 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -561,9 +561,9 @@ static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 
 static void vduse_vq_kick(struct vduse_virtqueue *vq)
 {
-	spin_lock(&vq->kick_lock);
+	guard(spinlock)(&vq->kick_lock);
 	if (!vq->ready)
-		goto unlock;
+		return;
 
 	guard(rwsem_read)(&vq->dev->rwsem);
 	if (vq->dev->suspended)
@@ -573,8 +573,6 @@ static void vduse_vq_kick(struct vduse_virtqueue *vq)
 		eventfd_signal(vq->kickfd);
 	else
 		vq->kicked = true;
-unlock:
-	spin_unlock(&vq->kick_lock);
 }
 
 static void vduse_vq_kick_work(struct work_struct *work)

---
base-commit: 6c141c034c1b0b74a2ca4dd3d6fbb6d9054f6e46
change-id: 20260610-vduse_vq_kick-fix-guard-usage-d1037c331419

Best regards,
--  
Cheers,
Nathan

