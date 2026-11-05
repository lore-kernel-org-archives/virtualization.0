Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887808;
	b=jdQW3kXk0ZkyFdD0Ennqvc1lVZOcRpxCxeOCi599zQ/HNmLS4/7tWVDl29ee2ePS66x8
	 QozCKZwHctv2/cVEKsVqvN6VKYGDpZPboQ7biLcIRiOdiPUgltS1Jy2VbMe8cMMHxNuY5
	 RI+9Uc9+XM6D8ehfWqLQti2/wAkbAAM89/iGOBwqYg2NctW/qey1gwRLAJ6vL+HLegEl6
	 N85R8Fp+KvJjEiI6tVZK7PB4c9jD+XVX8+d2dFrKvxu/d4/SZxab0r2gweglT1a82Yb5Y
	 H7pOD1OsngU7YEJxTtb4qfW73Dkdh8huHAYN9fks6pfK6RbJraVI5VrCrcDHYtqElRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887808;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/+2ONKaoV6IzTGGYYJW55T5A5jiTSV5R4wIry1IrHGM=;
	b=RA703gYqE886S+3kuJ0A06YSKd/Hbb6oQJfpB0eK62p+DzAzUDYp+sS/twVN2uxGwEhM
	 BXgNbw1mNjTpkhFtY/O5jh9cNrDQE8Xr3K4A72U9lCdkFxqy+SQ9fPQK1XYR2D7JW377K
	 dVlqafO+WCmDpmfT6NXYKB/ixSCVf0anubCEydFRAxh9bZTOOiM1MKHzkNIGsbNv8aF3k
	 urK/eHxCNFWR4ZZbZLqTipI+pn6+WBQLtX6BzF7iNikHk6vU/yj+xm/hyTMdJA4lqdikn
	 Y05CLzACg6lodgXXDqzyxH64ia7o+/FQHmdsNlL/Zj0SK2Wi45QCj9AP8zF7fTDEyAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mO0H4Ada;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EA606A330
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mO0H4Ada
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B8C1F0093A;
	Thu,  5 Nov 2026 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887807;
	bh=/+2ONKaoV6IzTGGYYJW55T5A5jiTSV5R4wIry1IrHGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mO0H4Adau7SHqZHHBizTs7yFfiF6wcC7TZNgxxxSblRr9qEiJ4UyllivtgLa+Gwbz
	 IT4vbGOx52/WdZdC3hGq5nBAerU8jwUGBFfe+NQ8WTyiN4L+FAu2lNgr30VqHVcNiC
	 xVDpBo/bBfVVyZZkpXxfLN7wEebgvPBWhQWqzrihzFULY+vbI+23TOE+cJkZckOw0B
	 a4dI90oAALUhB9sXXyWyCoiTcimE3EWO11/tjLeN60XP6MB33E0TxV+ZHzdOnsBJLY
	 6fAB7kGShdcajqX08i0DOHG2EPDnI0HvoALoFv3LWs6qyPjzdXurzdFJbA986Dbemf
	 I8FRkcNOId3ew==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:07:51 +0100
Subject: [PATCH 34/83] drm/qxl: Switch to
 drm_mode_config_create_initial_state
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-34-763560c2cc3f@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ldl6ijul3QdFV66wGmaDh7N43eVOWOlaVmdgUZ+Lwn0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlveldV5vp95X9tuSr83VfZoudi3OxagZMeuy74Icx3u
 zuisr+2YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExk+yzGhm27BWJ2mNXaNGwo
 1DfK/x9pl9C/KbL6hdqsJi131+STDDsWvzGP5oiwEfiqeIOr6sJJxobfRj5J58o/mrZLO85/8mP
 irSnpV6/xHQzjSDGdwjg17aaNWdTDLhHODynx6z9lccz21gcA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/qxl/qxl_display.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 204c47d61373..7f719e200d31 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1313,6 +1313,5 @@ int qxl_modeset_init(struct qxl_device *qdev)
 		return ret;
 
-	drm_mode_config_reset(&qdev->ddev);
-	return 0;
+	return drm_mode_config_create_initial_state(&qdev->ddev);
 }
 

-- 
2.55.0

