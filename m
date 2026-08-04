Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C940B114
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812190; cv=none; b=lGpsfPylzrbRPQOUucAmFWl2jdFsU4aKoloGcGZtbjEB5nMn19LYIrmOBKMkAv5vWMvPOP1z6RSzp2BNWAex+k9CAQcNEmaEna3yxOHtW7SGJru2GVLzJXYADDMHDpS7MCTcHACWi2V2TiEIMtYzG+fzFiBoZNJur/wpVbOevhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812190; c=relaxed/simple;
	bh=zqrmGtNYwoSSlb1WHgT3h/cWLH0pWZUE4OokQlWtRek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlWh3/n93+lAvYnk2wn6xReYg4gerIO1rqJkDnnPsYeccbmtMYgOr3kFH7U5I8KbzZTCARGYZ63RQDlau3pVvw8oEGGA+JF2CpAwuX1kTYpQqHdqj1amn6lgoH9W8w41Tdy8OaEl7WMSNHXGeID3BLk8iGNNKR2mb0+VHEMnBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AICGUODt; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AICGUODt"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3878552a91.3
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 19:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785812187; x=1786416987; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1yxnvuZRVlxtf+BJKMZxwYjNsgm5M4Tjb/ynOLuWlk=;
        b=AICGUODtG0Z7uU3hdTleohTQkhg+EA3hvyyp9XpjmIcS2kO1MPNQNO82wsllIvsAg1
         d9sGQ6PzmB6Y+JNwZ8NOpS/vGZfX2cuRq7/snVMbT2L2c/CGorgjAi2Qy3yxsXaSIjIh
         EzozL2Af0yU2G0W1B9R3tib1MGJPE3lw1bhn/q0FUrlnT3cfmf/Aw6jOsICIRIjOQrKl
         7D2ti4MbKGSCytG1g4Bc99BD7EspYmmvEZSF/uN09/aPiKrFpAQdTqZmYhLRvnqB1OKI
         bFeVjYgWRCvWHoV8QDo+1jSu+2Vrmw+SKrf8iJYYSiyZAd0rvqY28I2NLPNuTtVq5J9u
         RGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812187; x=1786416987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1yxnvuZRVlxtf+BJKMZxwYjNsgm5M4Tjb/ynOLuWlk=;
        b=XMARPDWWo4FA4LUGfYvWHrkcDBhoOqVSLxPWrv9920xhRQZsRqOTURmNBtLEC6Sj3b
         U8rvA9mXWkxtpGDuSjvdchVNU1wc8dUSi8aKSziWeePWaIVinLROEQZBilMMwRmk9WfE
         u59gJZhS+0buV+hNoUteIuvojFCjStUncdjA5FyQDa7AMkQyIJzfY0fRiVYuR05ffAT0
         13MY+1GMZqjY+ogIqKicYrsaxGlovN5YHNG9tLH9kQkSG4NPk1cY5VHOExv0uDdrMr7l
         hBi7XypZB0NKPh9HpPdBnmRIm4k89oGzSnPIbs5OIx6JA/k96YRXeofrnKbFtN74sJ3w
         U1xQ==
X-Forwarded-Encrypted: i=1; AHgh+Rov4q1+RML8DoJHjATJz4OxbmEW97gpX2YnkOxnCH8yqTbfBIlZ5RyIAVZsFbb+xPj23zGqIKaw3zidFiR4uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtSY5jq0jcw3uxgm5sBYDCxPvKb473sZEdp32EmWVwuXeJk/C3
	GYXaQG4/EKyX9dyrgRheA1460KhOMcuLkNIrpyFNXtQj7odbf0KGEFcJ
X-Gm-Gg: AR+sD13uDmqitpbPMxDJb+cl+ZZLdxDK/TM3sE3qnbJea6i+R2qvcjMdxYVGqBTukjt
	stxSty4C4iwDNcTvpIVIl15+o4RLo3Kb+G8pcM+gqUYjqWBIqqMex3Wa0qRa+HXSbc3LUv2hP9I
	0R1mnSOpRUS+Z+jDPxO5tjVQwEQ9EXGq5+h6l0TvNSR0UwiwV/ivOTGtEcrZITR/Rhg7byrcB2/
	j2bC7P5j+SZkgcb/nro14W3BJ9X/FacJvXpCBknDrwkn5si2J3oJilxd7/ZEVh5IXxEwXTcZAg8
	e0EFJWN/qd/fImubM3LuRqbuSf3C1Lu1eEMR3Jj3hZWzfmXABKuynijklTVDf/TQX/N/B3RfMkL
	o7vieDnaWgn7FdA1FAhsBuQj4NFkVbQ6acEEpyZ1r2pcHgWcJLtkohu9wFjnB882iDFhzMDYI/r
	SNOYr6m1mDIdMrUpxhzTHRPABIV5GRaAUBtsLL6wFnT8kFK/7S+0YSLosi3ibt65S+gs6Nej8vb
	KtvURWY1hzgB/gng2rKOsEbEa0=
X-Received: by 2002:a17:90b:590c:b0:387:e0db:3fb1 with SMTP id 98e67ed59e1d1-38fbc59b1aamr11609901a91.42.1785812187080;
        Mon, 03 Aug 2026 19:56:27 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19ef2sm45373175ad.4.2026.08.03.19.56.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 19:56:26 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost: reset the vring metadata cache on vring reconfiguration
Date: Tue,  4 Aug 2026 10:55:29 +0800
Message-ID: <20260804025621.16580-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260803014823.68623-1-juny24602@gmail.com>
References: <20260803014823.68623-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

vq->meta_iotlb[] caches the vhost_iotlb_map that backs each vring
metadata region, and iotlb_access_ok() returns early on a cache hit,
taking the hit as proof that the region has already been validated:

	if (vhost_vq_meta_fetch(vq, addr, len, type))
		return true;

The cache is reset on VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE, on
device IOTLB (re)initialisation and on vq reset, but not when
VHOST_SET_VRING_ADDR replaces vq->desc, vq->avail and vq->used, nor when
VHOST_SET_VRING_NUM changes the region sizes.

With a device IOTLB attached both ioctls are accepted while the vq is
live, and neither validates the addresses at ioctl time: vq_access_ok()
and vq_log_used_access_ok() return true early because the addresses are
GIOVAs, deferring validation to prefetch time.  Once the cache has been
populated that deferred validation no longer runs -- vq_meta_prefetch()
hits the stale entry and returns true -- and vhost_vq_meta_fetch() keeps
translating through the old mapping as

	map->addr + addr - map->start

for an address the mapping no longer covers.  vhost_copy_to_user() and
vhost_copy_from_user() consume the result with __copy_to_user() and
__copy_from_user(), which do not check it either, so a subsequent used
ring update or descriptor fetch accesses memory outside the region the
IOTLB actually maps.

Reset the metadata cache whenever the vring is reconfigured, so the new
addresses are pushed back through iotlb_access_ok()'s slow path.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
v2: add Assisted-by and Acked-by tags

 drivers/vhost/vhost.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..77c96993100b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2126,6 +2126,14 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
 		BUG();
 	}
 
+	/*
+	 * The metadata cache holds the IOTLB mapping that backed the previous
+	 * desc/avail/used addresses and vring size, both of which are being
+	 * replaced here.  iotlb_access_ok() takes a cache hit as proof that the
+	 * region was validated, so the stale entries have to go.
+	 */
+	__vhost_vq_meta_reset(vq);
+
 	mutex_unlock(&vq->mutex);
 
 	return r;
-- 
2.50.1 (Apple Git-155)

