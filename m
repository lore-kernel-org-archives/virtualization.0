Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0C3D2FE6
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213151; cv=none; b=c4miz4Q/+16gHA7yC5HKvOrtD5ff88tA228fNAS0SlrcyjHVfa6QyoQIuTz9is6wEPC7OZF+Kti+efxjdOaBCJcmN4SDlF+yULwYgWKmxHVp/qzRz1odyCaph35BKyv55Sh6CaRiLCGRfCGi/w772dZYNdW/PS7d17jPlFXqWfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213151; c=relaxed/simple;
	bh=qgynlLSlE9GedrgWrdeKiRWEM+qpmwf3VbwiSO5eBQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnCIpuUzaz5nXPq2qbol2RyorH+/c0GgPi0HNw1XfGF0h84B2hq1L7D2Nj7f9Uk1V5sqxqqIAnzQFMWj+BHuPzxib/rX5SUcPqYZXex4kWNXI2M1MGZwq2rdbL0EpkMf8vcZfJ3e3Rg+tyCjaDREonRuJ//vR9whNcmZDydcIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYNZT6cT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYNZT6cT"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so1522189b3a.0
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213149; x=1787817949; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNr0zjEJARTG031KsfcMOG4mbwEr/hGSSzyVmooR7Lg=;
        b=lYNZT6cTywyixI14Kt0MWtCGG++A6JUV8jXb+qDS5sdc7FHTHvSIAEE38Udp+pa7F8
         a3N7WwWN1Hq+g8PwtnYBaT7xV/89zdBq53jRbO7S7QIzMNewmBKxYbTIhsTHyi8A9inE
         q6WlHyYiLmzga2QgjTcmLoTOaR6jgr1tx4J0WBBL7tN0KCh2mwHL7tYYAn4pQpr5LK3R
         WOccCEImh3P54MjWII82GYHI2WAbpsDXeKXGtetb62xXyRqVV0NQxzs64aVhw9DG6g93
         oz60w8H0xosyxkuqtptY4tRar44AQEIcsEWS+BeBKGaWV+fs7Trt3abzFM9PPaSEddyi
         w4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213149; x=1787817949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNr0zjEJARTG031KsfcMOG4mbwEr/hGSSzyVmooR7Lg=;
        b=dyod4qwykO4eHcpBEJi1hVdVts3xZkrBqa+Fayk3411E03mrh1p3LrJ9ZoF45PA1YQ
         /A3Z8x7KfguvNGQTQevAq7rD8I5O9Y3Kbe55RQCK4XwzDpfb6sPkFS+2K8IJTDCo6PZr
         G4bfBveLyvBuWJcZRVu1GoibF8NFuvL5EYuC8Rl6OkvT0KtnFlgqjF7PUiRCtRaI17Jz
         XeARB9c0ew6fp3K9XnjAxBplMtNgWnkymW3hOPbPe/pNOhXJhML64Qlhod8ERzhOSR8w
         vYMQUc6JdNa1449RYYagw3NVUZ62zRSAJNjRIsy2jhJtH5tCxXlkN2zRxyx35D8lDF8+
         XOQg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2eaG0e1E8DJnMch1TiNQGitouaLz7AKrh5T9m2dbU6oCZT2Y4ZcQuzOYHphOC1ymburOJ5k8m/0vA2HsLTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHD7GQaLv+vcF1ry8/s40wU3DLOYt58atmNzOu+4jRsOtV0Ou8
	StVB3PZH6CBCAY48HZum4VWjPSK6s2LiDj1s3P9mAmBAE3lsc9Lwh+/Q
X-Gm-Gg: AR+sD106omDfDckPd7iO/szflpD8/stwub1X8GlfARB6I+NQpGTHqsJJeWUEs4qGLaE
	4qt7aeCYO89qZqipbiMOxjWOHstLyitVcTxEc5/umRjRLqW4Yb+MQW6fQzPKTavO4GwDknqlLFT
	bJAuIDHjOzTl8vP5oS9/A5n+9pn6Ph0KWgUHIA0+G9smarhEiYXoveeAQrkh1+qSVV0CpiaWNxA
	PIQsB1KjXw6cbmCyp+Dj/hxv6pYW84fBBAANisaeeZKW2z9FDBmVAE8NmB7HzllSlxePIg/X5MD
	8XE7kz5oq8ElXMv1o9UAUpU/SA4UxPaSUQ7e+dCNukTNbtQ13bWT1ruKAiVFt0k+6+3gXCvUqnW
	uX1GdR01DcBresTdMXH3/aZUP92m4pwDBmyCKbP3TQA7Lp93zJS/KJXsNWhsMSwWPoH4VE1Gdu4
	rVTQnZuSieNrAPyG4Ph3xyq8nieNpFrhgB+1YNOQBXtRnY1dlApn7MwQdrDW95UOGW
X-Received: by 2002:a05:6a00:2301:b0:847:7ffd:ce35 with SMTP id d2e1a72fcca58-851d382e720mr17907618b3a.8.1787213148258;
        Thu, 20 Aug 2026 01:05:48 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d366d65dsm1412020b3a.50.2026.08.20.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:05:47 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject:
 [PATCH v7 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Thu, 20 Aug 2026 16:03:32 +0800
Message-Id: <20260820080332.313933-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820080332.313933-1-physicalmtea@gmail.com>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply the common device IOTLB teardown when userspace clears
VIRTIO_F_ACCESS_PLATFORM. This drops stale translations and avoids
rebuilding an existing IOTLB during feature updates that keep
ACCESS_PLATFORM enabled.

The transition invalidates cached vring access even with an attached
backend. The backend remains attached, but userspace must configure the
vring addresses for the new address mode after a successful live
transition.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Link: https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 38d9c184082d..4d9d7c2216ed 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1696,6 +1696,8 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
+	} else {
+		vhost_clear_device_iotlb(&n->dev);
 	}
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
-- 
2.34.1

