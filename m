Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2C3AA4F6
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442318; cv=none; b=CJMLwbPg9erQ+R0l1rjunJTOd9RSCBRAMskhnPzvYAXlDEHABXZDSEh13mD0m8CM2iEDZPDUvJairG1IWJ8MsotSemoIhb81jOSxLGMAUxEKMnMXrFxEO2HNuPGWLmnv7nNBYs1vt7klomo7ZOihzi/bcNurQlI8vHcSXcjhC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442318; c=relaxed/simple;
	bh=82dBttW5BbKeJKJs/OF80tfwpM2MddI/t/zJLyO/za8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcjlUjieDNco6SV5tvv/OBt8uLNDz5nj2M4cQbZVJKjecVYhByCTtpB04d0qmMmKL+b4cL0DTJbrHpl65Ua593CzoGpuu3idbGQJhssZ17s/TEoD5iZYWsgP+pggrQZpbUU5+Dls/kLG41EgleWl+QyzHnR7J9WoxZUxH597lXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2SxXy5s; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2SxXy5s"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e507b079dso249282b3a.0
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442299; x=1786047099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1cRzxCLmJh01GBR+ktuxuJ/o0iMR1lZqgXW5wBf6dg0=;
        b=F2SxXy5sy9mTyKtzCN4t5W7E34B6Z8AMz1sSu+Hp70v7975IYjM9qqCcXuuek0U+dE
         vfKvWpVDAfucLiO3GC0UTcX4pKOT53d9TwK758/tfwQJbzs9muZxgbAMaP/3IjcJy57T
         ROm+rC1SZedEsD3vaPZ1VqQDtdOclvEpATt86ATExFlknWoaVsQgUoD21xTZkXZahRhq
         c14H0efBl7XiuJqv7Flfvz6IX5Iy1T9/ejBhR+NyY99h+GVLgWHm4DBigv9MPnLZw+El
         TGTWvJZqrkNjGC+KGA4JC7w+uehOIaqE+phl8GxweeSJfHJlGJqqILfjQBL4wJk5JPuX
         L/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442299; x=1786047099;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cRzxCLmJh01GBR+ktuxuJ/o0iMR1lZqgXW5wBf6dg0=;
        b=DRrfKHBOiSPTiLtma/XOAEt+px4bnr5zS7wVdtp+FMXKJ+912XoAZ/jHsNEEfcDAGn
         KNMivlj5Mq6GGJZiulp/yg6Q9iWL57KIVdYW5zmFPKQ3+2vD8ONnrmjnPWXKgXJLUIWF
         ktfobkGAnr/AWfNCOKx33VY7o17nj5vEU7tgY82cFsxz05O5vrtXeTxlM9KguweM0uk6
         Q3PVXkiLbOtREmBQoIRLnKWYVukCcIJ9o+aQSv/Q7auYZe61+OGYh9sMMiwKJerNG3AQ
         6S1mr4lSwDoKj8qWERtFA57PUibdCnMolvWXgqiEONydksrNoiyje7EOI9FTYqMqA1w3
         Oriw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+JtWoTJbiCnfEBn1zVaGvFZ2sc34k7zn7C/mz589Vso8kQWIgxL64vvUGfu8k/IlOwgJJx9zVjHYxviV6yA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRMFe8Q6D5Wxm/NdkNlflOVEl/Q22LfY5wLFOFY/iNGSE3pArt
	I5cRWQJl+sxSnxy/8bijYhRirwJaBA5qMQtK1B5UDb1kqn0y13TyZoL3
X-Gm-Gg: AR+sD10kcLBlen4sx5yqQz/VO71dj3+7siuRGlIX+NxufNEZoICap53GrC5fjw+r5vU
	qujZtw20U01fhbu0hFMplwQGALWv64mvsQ2YXgbKZBYV4LYl4AsSgas80uolYxP/MB0XrHmXtU2
	8X53F0kEHY1tANNy9gXt9KhMkeKvzJdnVVqb37LSI8CGyA42bVqs4lxjX8spK7EIvXA7OGd5/VZ
	TyygXnBRX5NVekcfXkjLe4mmZ+9giFHW/EfqRZw1qfNvFuNbt+Z6glefsVbSV0HpS/E5ZMLqYQv
	L1V9j7QR3BfkfaFZjdjbeOGhLwNgBSVBGCBkx7v+pfCDfXfERsl4uamf08x4JA6q3D5x7+xyiCs
	3lvEc05yj+2axof8Yqkm5hChC7pN7En/lCP/jUqZAaKpDG5DCdawgbevmh38RiSFq9QUbKR2Y4p
	+0k69bI0WOOyqkU1R4FlpY0l7hL4Imt3eP8I/C748IWHNKIvqMR/YhoCUmvu9iy0k/jU1I4I5ch
	osrp9gHUFNzliFHSuMLHeSD79NzNoql/7bStUtynQc=
X-Received: by 2002:aa7:88c7:0:b0:848:760e:eb76 with SMTP id d2e1a72fcca58-84ebc432c34mr3475574b3a.61.1785442298760;
        Thu, 30 Jul 2026 13:11:38 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:37 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@kernel.org,
	ssengar@linux.microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	sgarzare@redhat.com,
	horms@kernel.org
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RESEND PATCH net-next 2/6] hv_sock: Remove check for old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:19 -0700
Message-Id: <20260730201123.1767-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730201123.1767-1-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, the check for such versions
during hv_sock initialization is no longer necessary. Remove the
check.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 net/vmw_vsock/hyperv_transport.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 5405c2680dec..855b15971c35 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -961,9 +961,6 @@ static int __init hvs_init(void)
 {
 	int ret;
 
-	if (vmbus_proto_version < VERSION_WIN10)
-		return -ENODEV;
-
 	ret = vmbus_driver_register(&hvs_drv);
 	if (ret != 0)
 		return ret;
-- 
2.25.1

