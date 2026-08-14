Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985547D959
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718806; cv=none; b=pu8aW+NfkRxtHT7vLcoZIZGh/5i94gJkqfvgTO5DCZKHjXxDz1NOlOEdcRVsscmZIhj1CPp5TXB9qrSEgWXXy1xdauHkdMXzmwb6Y5Y0ejKBytdQ2kGzvY0vR5hu9BFihPNsYfkoTSVxKrcPnBHV3BX9zT9J3jKNJBfnsPGexRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718806; c=relaxed/simple;
	bh=7Y0D9/fB4CPNrZj7EyeDRq35Pf1NaBCqtEh4/sL8M4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuHZO4IOYlTtzgRr0Z8dxCHwFqVff+gWY3mWsdo0E1WmC1ZVMr6liL8og2RRYcbRLugKFpt+lBnzVkN7k6BRsYtpG+zWZUN7prUmd9ElV7ptOiNsXxBvxxby7G0TZOxRPoxKiw2R8NnX6ClDj7WbLEuHyfA3tvK4ceg8c0qN8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA2KCrbq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA2KCrbq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1139907a91.3
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786718804; x=1787323604; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7vE+GY2/DQc/aiTWp62voffhOJnyDy6ZbmiuSnMuXk=;
        b=IA2KCrbqD+xC4Kp6E2WmrgIVCbzRxg0Afo3Zg+3eDxvOXJY3+3stJST1fs+sUQMN9Y
         d+8Mxn6GfMD+kOe0IWAh/Otp0rZ1jNRgHNUGuTlAmOBViMWPO1rJiLi4d9h2VJhcYFOb
         yJifSebXVJVbsnmV4oPMTON8e6JUeHw7kJ36/KNzdTg0TsFQhnn3JnKhhQDMz53mcDW0
         ORJaPet/34E0vCa5ALv1mzEnj5DEATmRNPE5pPQ8i9UGy0HhNdK3jXJw8X0jpI1JZ5de
         oDCdCPTo7H8oGUmsBO0pgxDIsyjSCK8DhPpWmtKySrNiKRvLkRDxNNS6dihLKbyfwHaa
         Aktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718804; x=1787323604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B7vE+GY2/DQc/aiTWp62voffhOJnyDy6ZbmiuSnMuXk=;
        b=YZUtrFiX6Tvt6yFE/d5LIjDzbHwCzA9vPFvUPXFu3sRQaYAlPnmRdqu1GJzEFbmtr2
         CwMjxb5BVhDEgsE7m3sL16gxTCgNb/iybDKEt+AZke12/2cuZtP/9OIS3hFGD9ouTn+o
         8/lCN4Ax2/IXkYVXqlozho37onJKKeKK7NsVC5EPekcjkLWrWf1HQ3Dth0xM7S3as6bI
         AvgWJzFmRhNvcmik3r4P3rHOEZYP2ixFCgJ7C2qWCnN3NV/413YQg87MbJfOtd+imBte
         V0hOcdqoaqi7Vak9+Bq/kGdlbm/E0CiJWE7injtVh+Fm7QfDi4uyctcmlL5MqULDhYm4
         V/Tw==
X-Forwarded-Encrypted: i=1; AHgh+RpE3x/+bOpyl5JT8K6zldMS/p+amGQ04bd2648Ridq9wcardNiJou3Ttdx91WMz6LJGg7XJ9rLZoginoRPUpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPleu7CBnjQiMvG/Qi+2ZUUuIXJ3xROGxiFUbiLC9x9kN8Sbg/
	E5PJdINTPp50vlPNStHTJ9QKZwerLsMrKVMs8OtW1r6erQ+KSoddVcAW
X-Gm-Gg: AR+sD12zHJDkY6VfkC5hxKmUC36KYhQmsSrq0/C2wQnSBuIW2dcJytl9nBvkGspufDv
	gOO4iQqMV973z8UsRszWF+ah6ynDdxg7MhcA2jEqm3rsnQPwdyh9owUJlJOREEkpNWKuUEaP1Iy
	6egPo/d5/r/HJr8fjPV0Pq9+2PT0A08MI36BYb7gbCpwi6BRVq+wyUcgZYo0ReRLo/3DpGpPzAv
	fgCSJT+FxazFpZFWX2Pt+umQjezC4/ocN5CCm5436P2ZgX0QiZurFSUrfkXVJCdcAdlfrbKMeQ/
	zVu1CZFHeMQBKqgBsQOU86XH4cxoaUN2X9Jj3uvI5L5vWAK5rBpaBmnX0HMLURTmABPt/lohBxM
	Hv07vOKJTV01dbkTJ9amZUMAiOKYuXE/6V5gfurlOBybyyppyewNHVNq2w1/XlkWAxMGwTArdn3
	kfhlSyI9hnu9F+plQBQt2IgQ6YpGZW1/DG2YqHhW1XHAT23372gNX5BMvXn2RsX1E=
X-Received: by 2002:a17:90b:268c:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3933b84be0cmr7541431a91.9.1786718803151;
        Fri, 14 Aug 2026 07:46:43 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm14193140c88.6.2026.08.14.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:46:42 -0700 (PDT)
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
 [PATCH v5 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 22:45:57 +0800
Message-Id: <20260814144558.134314-3-physicalmtea@gmail.com>
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

vhost_vsock_set_features() currently leaves the device IOTLB
attached when userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptor
translation can therefore continue to use mappings installed before the
feature change, including HVAs made stale by a later memory table update.

Use the common vhost helper when ACCESS_PLATFORM is absent. The helper
handles the no-IOTLB case internally, while the common initializer keeps
an existing IOTLB when ACCESS_PLATFORM remains enabled across a feature
update.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 1d8ec6bed53e..1a61d7db7605 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -849,10 +849,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
-	}
+	} else
+		vhost_clear_device_iotlb(&vsock->dev);
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
