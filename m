Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE391194137
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007193; cv=none; b=b15kYGnZO8SIB4Kldl3+Ik/JNmDohMpri0p7Lg7HmKKd+CHPR7TsSCtGSHRkluF/1sdQnWtUM+JXmYIyvmB/JpAoeVCQUG5jgcVueeFbY3SLLTXTL+VDOYWr15PATeATjmGaX0uox5XgcXnH+2mT4OcC1huq1lCfRmhHXnXp9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007193; c=relaxed/simple;
	bh=epwaAKL6z/vr9Qa+iuSsEHyh1Wat9F+jzorfnphZDzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dOIhXk15ns1p+JXz4ti7vunT1XoschHZG+GtNpOVE+2peVqJpHAkL513/o97DVaeHW3UHliopNjyugvo9v50FiN5Q51uEEkmcf2gUOSipiNBurCnf81hw9TY/u0dw9/rN8Xh2wh9ymqidiizzI0wVT+YnY+bEaw5PhIhrvOZ2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDDBZuZ7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDDBZuZ7"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ebb390a5so450265266b.1
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007190; x=1731611990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lz0x5nr+zytSDXNC3TjwSD3fvnHBp9KDDJ6PheBe2/4=;
        b=KDDBZuZ7+yYDFQ9t8OT2GWGGt/adqX4qkUuBAs2G60QluTQ3F6M+EEjQMaQxCYeryp
         FEJ+omR/G/+Pn2xcjgXMefnrLGmZUtLudB7Qtx0D/YBpVNOBMLriYhXgI0HEUP3QQML4
         GWak+fHIPhIn5xNrefvimyicTF6RQS8CC/RPNTRtX56RejJx/1NEAjTMHBrztPz0VXCf
         OVepPqAu+Z2Osf66OVHja550EVHG32GKr12NZEmUihW94wQymeupZQnihMtZH0n1cknl
         RWaLDb7SqUw5PihMRzYJAqieM+6M0Lqgnn8uD1KQ9a2BZPhj+zzF6T0BUQtkiGcn6b+Y
         uwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007190; x=1731611990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lz0x5nr+zytSDXNC3TjwSD3fvnHBp9KDDJ6PheBe2/4=;
        b=cx3N6nKZa0rDB+kTYngJQaxk0M0gsFn4clBeZ7CJ+LNpZXqgwBbdZPZbDmdJ9ee9Ft
         HMX3WxX79ruXvTDNDXgMYfmUiCZ+9PRmxzeyJsKWlk0twJd4gP+XuDlH0w73TwdkQl+a
         wceZ1sAkfw5e9yCkZkVXXVW1CcTo2UY4IrpjHiqaZLON38bMETKfhfg2TAqNhNHEOaKM
         sqslq4Ojyye3pMrmHO+m7r160n8iRQNa3D0BfmDvumsK7V+XCM14Rexnw7xe1jYhPGVf
         uNePYUNpLFNYA8nwqOt5aKYwQNbTVb2gi91JbDihf5TF8Mf8EgGMolIhALmttDxzH5yc
         oFWg==
X-Forwarded-Encrypted: i=1; AJvYcCWCNLJ0QyhJFqZ7I9DQ/XFaT9oc9UizsoBFEF6eEDn4BJwLUQPAmeYu7wyOiYFS788PWimGCimKgbQpDJYW0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2YLwn/IACpLDVBmB7u8P8ssaEQ0b5u4YDU2zCkC0bx30vf/MT
	9imFHM+hG662B9kuWNayFESQZGUttmFX+8u6qDFQ7NsrDQ9NhHGL
X-Google-Smtp-Source: AGHT+IEkLuumkMpxInzmBkBdOYglzCszz1XgQbRnyBEWkOKX6vYSz1RY83BmnkN2yhVDyd8CXPOasg==
X-Received: by 2002:a17:907:f1aa:b0:a9e:b174:9cf7 with SMTP id a640c23a62f3a-a9eec993bbfmr62509066b.13.1731007189753;
        Thu, 07 Nov 2024 11:19:49 -0800 (PST)
Received: from DevOne.. ([85.206.117.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abea92sm133553066b.85.2024.11.07.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:19:49 -0800 (PST)
From: Gediminas Repecka <gediminas.repecka@gmail.com>
To: mst@redhat.com
Cc: jasowang@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gediminas Repecka <gediminas.repecka@gmail.com>
Subject: [PATCH] vdpa: vdpa_sim: vdpa_sim_net: fixed cofing style issues
Date: Thu,  7 Nov 2024 21:19:41 +0200
Message-Id: <20241107191941.37300-1-gediminas.repecka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed coding style issues reported by checkpatch script
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 6caf09a1907b..0705aff74cf3 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -53,7 +53,7 @@ struct vdpasim_cq_stats {
 	u64 errors;
 };

-struct vdpasim_net{
+struct vdpasim_net {
 	struct vdpasim vdpasim;
 	struct vdpasim_dataq_stats tx_stats;
 	struct vdpasim_dataq_stats rx_stats;
@@ -293,7 +293,7 @@ static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
 	unsigned int start;
 	int err = -EMSGSIZE;

-	switch(idx) {
+	switch (idx) {
 	case 0:
 		do {
 			start = u64_stats_fetch_begin(&net->rx_stats.syncp);
@@ -543,7 +543,7 @@ static struct vdpa_mgmt_dev mgmt_dev = {
 	.ops = &vdpasim_net_mgmtdev_ops,
 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
 			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
-		             1 << VDPA_ATTR_DEV_FEATURES),
+			     1 << VDPA_ATTR_DEV_FEATURES),
 	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
 	.supported_features = VDPASIM_NET_FEATURES,
 };

2.34.1

