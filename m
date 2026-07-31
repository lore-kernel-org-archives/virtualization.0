Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBB41A4EB
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494082; cv=none; b=mF+cutPed2FvICYYLUsfWWRhAE0piazFwvMabwMHo3gGCj/EkKbH4cVoP1pVwcscNP7lD8Up8s48kKZh/PNENkSXWw9eoFuIvbAdgPfQMIDQm+Wm7/+4d82eLGMTftjzy6y4PF/TiiP9mMuOAIZTm6d0gEDgnCj+4ua10quRCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494082; c=relaxed/simple;
	bh=8jBFo3leZDgnmqctwiw0V0hqICmlxQdyuA6JJbEn+2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQG8N/wSEpKGvQ7g1IYoHE1BI/GFYA1cngRHcBdfxyBf/Drw69fgX5IwiN9P8UVN+gvOJ+bwyQECRbvasdEc71q9Bs0FaHrlzRIgBrhTsqAGl3AUPJ0ACpD4T5GjdVju0jAP1rsj9ypRBuiOCHDfjbaq4sctoTfRTx4SlrsWhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCq/xUHE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCq/xUHE"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e7109321dso482985a91.3
        for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785494073; x=1786098873; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2oD6x90/2ngEh3h/+xTr/e8V2AGqBaiy+5NsZiEXuL8=;
        b=MCq/xUHE83Iv8YTGS70BqgQoORkWqGd42RuPlnrcTV/5KE4Q8ya4jlDWOOlIAtmT+f
         eEA9qsZMGHski1wb9OtmPmgBb5vzf3xL85QqHiv6eZaNkCQ5lqnePSuzCymdr91bh0S7
         7907+Xn95nJDrf4oylZk5xddYAEr8/KHL4VNozTcgntyhKzpZroaIPW1eDOHvTO136cp
         LHF2Fe0RIBoOiwspJDpotUL+pfQLafdH2lGMBqk7bb0srwTM4qb2vgHblwtfBOowMQP1
         6TYjAwULTisT/FHP/1vKQmLk7HeiUM8BK/oG5pfUIq3oJTtGAtcF5ErHq40MRr4K1CXp
         IWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494073; x=1786098873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2oD6x90/2ngEh3h/+xTr/e8V2AGqBaiy+5NsZiEXuL8=;
        b=Dd4TYuU578JPaDWewocKDaJPcOLKE4pguyiOVxsoXjr+gZ48V+L/Pc1y+5PU8PZb/I
         0m98Foh5JKTg2rwaEFYTR2SBzikHEeR202Ic6oH1PNaGWa98Q6rusOEdRzMxzRWFsDvs
         qObUNBwzdJzmPhc0FrNkegvk6hH758VwPyxTuJb0lvenyh/EonKpJmI/bP7ELNocIwPO
         yoPbVid2CIH7+DxYNC89C7FqkbQbETe7JjTj5rilR/BcBa8Ljz8A/JU/7qE/+HcjMtkY
         Phu5pjOSKTpANRbt+KqaEOsMqQtH/7DlaqgASe9hVQcd4cyUYI0bmzfadUiv1YW6TKic
         x5DQ==
X-Forwarded-Encrypted: i=1; AHgh+RoraaYp3HGa4fRHZJhzCsO03Wx/D3yuXBqzdvx5TubeS/Axt15e6jxGATcgN/izJS+AtPYk3dse8BFNM6zU7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuB3+Fm0c/RGeDYGKidC+QoAa7kxZJr6edj4LfPDmngDkf6KdC
	2fwWt5DluMTrPj1IJHYSL9ueKEIBsuA5uw9nsHfO8sdf/LPtl2go9RWt
X-Gm-Gg: AR+sD13a9BP8BvTTpqCo8l3tIOlks8sQiwF/g+/a5GYdRyncFqAycxbTH3u+WCpnaIX
	afAubfCV3KAr4MVwzew3FJowuhFgylqI4vhJld/MjokveYJQrODDu+TyrX1UDo9h7RWUtXGXWuh
	rws3ZRiIwK+GUoxQEAETQR9GmnLhbBxIgzWRCfd6Ih5bDtE4235rRl0ztGCu4eFdmi10kpDeXOW
	kNBbPbPqaPq+Y8vwTMl7JbiDNQtIfya6607szgYsE7y+4Ktz/HgHh/TQ9RlrzM/He4hFbJMhHWj
	eV/9c93dHRe6HkJBH3bAQHUOp2tpvWfPc5FrWSSpzJnNwxr9fDJoFLAv8MM69rzWuk+aq8xKP2Z
	TXv2Vt8jXgfqFnQEc0/L2BpTpyq2XtpZuseo+KDPT1amtFHti11yzvBgTHPn0xujMCo7LgcSAQ+
	zasYgdUG1mRikB+KQ3dNFYvR/9cOzCK2DpITG9L2uO22KGAYhOE6SOoBzCsvCn8eY=
X-Received: by 2002:a17:90b:4d04:b0:38e:712a:be68 with SMTP id 98e67ed59e1d1-38fb15304fdmr1243750a91.43.1785494072849;
        Fri, 31 Jul 2026 03:34:32 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab25227bsm1934172c88.7.2026.07.31.03.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:32 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 31 Jul 2026 18:34:14 +0800
Message-Id: <20260731103414.1746316-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731103414.1746316-1-physicalmtea@gmail.com>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHOST_SET_FEATURES is also used to update logging while a device is
running. When ACCESS_PLATFORM stays enabled, allocating a new empty
IOTLB on every call drops valid translations and forces avoidable
misses.

Initialize the device IOTLB only when one does not already exist.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 562b9e139a76..3703fd219039 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -893,7 +893,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    !vsock->dev.iotlb) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
 	}
-- 
2.34.1

