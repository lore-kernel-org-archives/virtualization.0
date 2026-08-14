Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87EA3BED66
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718821; cv=none; b=LMa81uetQyc2ZDZTZlVQ9zTclA5E+oKlhk18/ASgZyG2qwMpU/s6aHNoLkpHZj8ipv5DS/yEQBAX6Mi0ujLpDBOQDu6m3i7iNNMVMicyJ0XqiVzXX2UvmOBdkhr7hO8oYgYq8DcrvZV+BuU1mJiI1j2dmYMwxRPXVwOWL56MHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718821; c=relaxed/simple;
	bh=AL6Q65vw+ZJt4TGaGgMNlD2ik6ILvC2I2FVHjTJiIRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgwqEtkzXiC/Ny4yuWH3WXV9jy364NqHUf8IochDclWQcsZnHv2AtykHUs6WGagvsY3HaETgZyvaxxuDJKifsgjHwqpedk3ZMhqOz2qJUOBR5BcrshDCRU7zr6YHxqeCkP6PcTWhuVZe+UVj/rQHABmWQDR2zjukFzanOvpCy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SionK5qZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SionK5qZ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1130093a91.2
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786718818; x=1787323618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xLjQg6E2MSVykNQCAn00xe/LP5TgPchFkGhjlJGqvKQ=;
        b=SionK5qZIZvpUQgjxu8Nk98bKAowTmrocQ3QW/xT1kNjVEaerTKU+QMcokB3jyQHY3
         o3LT07yIepBUlHo8Ayn8P4AEZqHvpshAz/2WpAtvHhKV4O1cTEDpG4j5gyPGelJSsTYr
         WYr69ZTsc7C6p6PM7Qu5yspHrRj8ezd5p3DsZOLZAqqMSRzJlKkmhcQqqTeqInVMSN8S
         QVqmjG0WpFRRIK2x/lE02oTxoWTEcJgkVibB36vO3cOq0KfN3Nb788tQ92CD6GIZXAVl
         z4tK6na37TzxLKEcz8Xu7LFvp70WQSdstD/uInuAWEXv8nGKQQ5/6DkvEVHfiGtD08hD
         hEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718818; x=1787323618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xLjQg6E2MSVykNQCAn00xe/LP5TgPchFkGhjlJGqvKQ=;
        b=ermLZmo00YNW52S1nD77l6/u7yNQ91t27K6aNIaSxwuBo4EF8uZogya6ZgmBNl8OnQ
         JXAoh6WU8XlVoSdF4qgE//VnErAMEP1njLqFTENLRbj0jOK0WJ7hkMV6CRyytzL9Zaf/
         1tExJ+lz6D+2tpCRovkl0C8eSRuwghqBkmQ5ZUsIfDI4JJBsdeIlCdvfwIm2nFuP6cxK
         LbOFKuGo116SAeBOLI35VM0crVv1N+Z0BOiAkrdoXh2BGoiSCXqbtEM8P3/IamlFdrtf
         CCIZ5L3oxx3GArArbxHa+Y1PLDjS4dcZl1Of/7Ep8kJwkSzBa+j8U6NYF0VznvK68oNN
         pKvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDvAoXaq1e/52KKjM7IlbqYtaK5Lk8Tv6eIpahqHCzi4z+F2F6G7Qm74N7qlbm/wI6xtTWzNPZb+uQmlCHag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3ScGuVm9GiRlslkLI9RjAmq/FNKPo6EVn9n7KnxPgzp7AGUOT
	XLnn6AzsBVE+lglROb1dV29tQL/h5XrqDxLSQLtYjFjjXMBj54yXz7is
X-Gm-Gg: AR+sD11cytihw3Weu14Jj8kLKIETrj+ZmGMmqK9CsR1eH2VxIXaP9aSoe0ApSjYya12
	i+BBRyPAtSw9wgf5ntOw+gC4a92yYU1nvFs7oGonqJ9rVcgZumNBmzigou0cuGRt//QbCu9Xk/f
	Rr5AjNETjdPmpuzCAiOO1xnjoeaiel7fsjzveRxMReCk1TMWWsfgvzqbvDWMQx9saTqjL8QNVsS
	RaWE3vH+HanyPbl8aK7fa2nVYpmADeoWZrR/HBsdYhwY1VtAGk3OKZCCHydVADFni4rswjRh5+9
	O2Qqv8BCQsrtnpkPozzt7spajhi8ff6JC1Hh6kC2pvEvdwUIUpFWiKvB77A8JOwBAxPvyz5r9Yr
	PwBOCU8TVLZKPqdDTT3PD8j6wKz5tSLhDI0n17ut8u8LthxouN+KdYFZEnZc6vmW+/r7llMrudl
	141RcMItH9vMUgVD8391J9YIVj9jHfl+Ve4oxESsjszjIn9b3erZ/kwxSvO2ABX1I=
X-Received: by 2002:a17:90b:2c8d:b0:38f:caa2:5721 with SMTP id 98e67ed59e1d1-3933e62f4f8mr7303910a91.17.1786718817623;
        Fri, 14 Aug 2026 07:46:57 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889bca5sm14642249c88.12.2026.08.14.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:46:57 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject:
 [PATCH v5 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 22:45:58 +0800
Message-Id: <20260814144558.134314-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814144558.134314-1-physicalmtea@gmail.com>
References: <20260814144558.134314-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_net_set_features() leaves the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. Later descriptor translation
can therefore continue to use translations from the old IOTLB after the
userspace memory table has changed.

Use the common vhost helper when ACCESS_PLATFORM is absent. The helper
handles the no-IOTLB case internally, while the common initializer also
keeps an existing IOTLB when a feature update retains ACCESS_PLATFORM, so
logging updates do not discard valid translations.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Link: https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6536cad9c4f..8d6f530f49b3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1687,7 +1687,8 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
-	}
+	} else
+		vhost_clear_device_iotlb(&n->dev);
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
 		mutex_lock(&n->vqs[i].vq.mutex);
