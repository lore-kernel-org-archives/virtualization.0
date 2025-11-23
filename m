Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87B280332
	for <virtualization@lists.linux.dev>; Sun, 23 Nov 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763920692; cv=none; b=LNrOqD6Eh/mVRIvLRzNFqQIOYVWJTL+LWn4EtDNJWfIANu1u8+STm7weKXpT8Q7F4oFjclrf1Pt02KVSAkam14Fet9T5aqeIAnXtASx9RN5g407ciXvtwQ+riQVF6X9PpZYpYArf+ObxxgdFh7NU6eDyvrBWxWkIvpUrvpQ+DhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763920692; c=relaxed/simple;
	bh=IdrcSvJ1MGOPznQILO3f3sgw+rqgjbAlbWwbtIfCVl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slNmTSmDKNrehB7DzBESkk4trIsm9NjbDy0C3tygTnPXX0f+KjvSdzJWhSL03WoxpXTdPoB0pr7DClXUnuaYUzh71tJCQ/cG8uJs+cNrwrNvoYgjeXgrdwY+9DIdhk9buI8TCKDO3oXqOI39sRwJKXU4pMolFxDdSoY8DM7qOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MPam6zo7; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c4+aEApF; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MPam6zo7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c4+aEApF"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dDxWZ0LS2z9tsR;
	Sun, 23 Nov 2025 18:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763920682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gseAWsYENWws/CLKiwf2oXz16cFfq2UYnVYd9WRaur8=;
	b=MPam6zo7/qr6BMxc9OMQjL5Cglv8IqrzeYNjs45Yqj5WXXVHmpknUNiRLXVLbNURGoaHgt
	jESGnxjPWnQv5Y84NzMgLEQM9w/n5/bQTJHz5+NWc2j4Wk3k7RyLbkgMxFmH+JbVgp7FJR
	SZxyn6U0MUeeooHoqCEmjdpXXDn3mAHumdfDyUcXTASnr/tG8h6guBaSpw0mgKRxTIUYHf
	7utC/NL+Y/iRNC0tFW9IrFKoAzuUgm1f8+dPqwyiZmgJYJZzWdobU2Yfl/t237FvUn2aZZ
	Rhs8FMGf01pXsCqQTAEOzLr5SQ3KPzwzwi/jVLhNRDbfA0WtVH1aiLTmoqciag==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763920680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gseAWsYENWws/CLKiwf2oXz16cFfq2UYnVYd9WRaur8=;
	b=c4+aEApFS21CMWJ+YmxxXOkeNsWUeuetGiDarLoD3PKsIjMY1yOZQ2Hx16vkBVxQaGsP/Q
	qFAdhDCZIi2wRODSiK+CptoO1d9cVwlCYIIjPAGeMW0/qxGZ67R+K2s9SEd/FBjgwrdzfU
	NI/YSxoyBhqowiLtMe1Bmegt05bR3d1UtQ8PK6+/IdSduvcDWjQTkK1j+veQoXbD5hPXVI
	ZjCgz975aMtPsSVY4/oZYSc8REpuH/jslgr3dQ5/YbnL3AJwZeB4noSsRCt+T+OJ6/3m4v
	FKDvBmkn3BD+OftqIJfUO5iBHzOqH17lGdqVV13TtkvE2ZRpNr/RWEqwgwDpGQ==
To: david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Maurice Hieronymus <mhi@mailbox.org>
Subject: [PATCH 1/2] virtio-balloon: Destroy mutex before freeing virtio_balloon
Date: Sun, 23 Nov 2025 18:57:48 +0100
Message-ID: <20251123175750.445461-2-mhi@mailbox.org>
In-Reply-To: <20251123175750.445461-1-mhi@mailbox.org>
References: <20251123175750.445461-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e4f5e7ae7d1d6563d64
X-MBO-RS-META: rgghs7g74sp4h8wsoc98g7gej4kz7i97

Add a call to mutex_destroy in the error code path as well as in the
virtballoon_remove code path.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1b93d8c64361..078b87720a0d 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1094,6 +1094,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 out_del_vqs:
 	vdev->config->del_vqs(vdev);
 out_free_vb:
+	mutex_destroy(&vb->balloon_lock);
 	kfree(vb);
 out:
 	return err;
@@ -1138,6 +1139,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	}
 
 	remove_common(vb);
+	mutex_destroy(&vb->balloon_lock);
 	kfree(vb);
 }
 
-- 
2.50.1

