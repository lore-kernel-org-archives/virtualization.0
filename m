Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3D313E01
	for <virtualization@lists.linux.dev>; Mon,  6 Apr 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775467329; cv=none; b=k6ibfpJnreEbBc1zbqDti86leXnOnGPd9KaJkIQNVZIP15GpFSCE0Eg2PkN0mSEStAkYHjqxFVRSPoH/YZ85C8reYghmVv6iak8RH/C/GbdcAg1JUfcLqsvj1Mxqdtwvi0r3+eCQpekZ/jZMWRY1lb30srHTGP38REmXk4ye4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775467329; c=relaxed/simple;
	bh=nPmeLyKheAluha24MShpyFT0khgevoZVJ1J2O4svefg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRRbgsDXe2509miu3cRTMNPdphsnygY+wioKoDoWAGlMhXNy6TkrG5kFBQrCiSOdro/Qs6G1que5GUQfBATVCW9koG0HEmA5pWbjSEh1RVSc/AJe4YGhmJzqvGdB9/Yb7G2IEU4vRNC739hKzo894qeC1/DBguArcHG7x/PnJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdWBUezj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdWBUezj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso7891475e9.3
        for <virtualization@lists.linux.dev>; Mon, 06 Apr 2026 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775467325; x=1776072125; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oT3j7eJ56iHVhP23HyrLK/FqBqCArQkgm0YXamNGuoA=;
        b=PdWBUezjEMi4Vw2IThjJXmfJe2+mKa0YguW+XK35vjHjYjxAEGxg3/6WpyV3iefRee
         PAUPW7fWMuemrVUmFP1gkRIbpDdzLV7PbG/rZPqAeMIaL1DAJROq4rjvsLs26Tm/XPdQ
         D/vXd2mYr+tKbGLZc3hl5ogSCPfpRpd69Gon6t0qlrIN7czkFSpKoEf190BljNk+zepF
         +Di3NHy9JS+iDn/uYWAGVjNgGciy2LcD/zo0EJUzLFug7dGPWQv6uNDE4FTxgpI1HvUl
         om9dbAArP5+VvNaOPuS5HyIXafiSKSDfmur+nbvvHQ4vdpUs8QnPtPmthN4/tL0qIBuz
         Srvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775467325; x=1776072125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT3j7eJ56iHVhP23HyrLK/FqBqCArQkgm0YXamNGuoA=;
        b=XpB7YkPVXuDHnC1GKLEivGPfDRF4/1gTd2OzO4eOublIT8CnLi7WJt2u1gnXmxwD0+
         hg7iigEXfawtstIWrHAOAH6hT8IInxz1NL4FjQeu/poVfsqD8ExtUFQSx8krWyMB/6hf
         J7GoCMBfumZeS029WfIvkG/EamGO7mm1HxLFLp3h8DXfTcmXVl3omJv+Ojr3M4iI8rIb
         HMNoQKNsL6jbOMLfi4vYXqy9mtnz0do9FSMU5mzHcoXQsOZkFOv2hZVOrUegTVVDM3ex
         tsyAMrrfL9sd6f+RUgIYmRq1zqHtoYoriUTasx7hbDaqcit+ubGaS2R6wEu4NXn4nveN
         F7gg==
X-Forwarded-Encrypted: i=1; AJvYcCX3pBwwng/ebjEIOT9hrb8Ewg05HlcCY/Dj5bqgZ3mE/JEcs/WFAfdbnzw+XAw5viGbUTaZUzB4xfCdCnQZEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzmf5BtwmYCd8ioraSpfTRYdNRwoll0nsUe88dQ5U/MYf1YuDUd
	v0tcc5NuN1i0RkpmdZxvA/XIFzMXZiLFlbkQzWTVi8hhZKtshmJ6UmWzR9OZzClYofo=
X-Gm-Gg: AeBDievjfW4UlgUu2FrS6RcEo66oTNSxeGCwY7CB7lXH2G/5LTzkKlsDIr6xyaer0zm
	/DF5ZoJTqMb5RbijT3UCLzavziI3VEqWWfYqad7dTMEjrqZx2mDC5dGDA3YgPBQ9t7sIepxcFUr
	WachtRXV1+ymAjqNdr/Hndrb8vktcV8W5+k2oFdtiw/0Zkip42XU7jgKnzoZYaDH2fiXf9+uobz
	jvUpzCiZpbHcH1yfmJC4af2bte0rve1bpOBF4Nam/g/w7YlPODlG5uE7dzQyCxx+t5caNaCun3b
	+nph+Gh+nT5se9t0VmVmXc1Dn22eFfRw0YD7U7/4wW03k3iD+ahn/icUSqq8wp7HPthE31eajL0
	1ROU4yPMHim9s88s2J4FGzBR/7wkyCkpazG2vwJSDpMyyKAeXiFISB2AYlR/8EWZopeL7kehpSq
	y6MLzpNcqUsWuz+1CZdx3KfDJgqs/PTsGrujL+8FlHSr+sgJWB2ktaxK3R3g6LB2e0W0LRt6Tu6
	vjl1FIrTooz2qopCXCBFesmlNWzFqa5g9arPggOID0=
X-Received: by 2002:a05:600c:3549:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488997d1f50mr164045015e9.21.1775467324920;
        Mon, 06 Apr 2026 02:22:04 -0700 (PDT)
Received: from user-Vivobook-ASUSLaptop-K3504VA-K3504VA.lan ([2001:861:3380:8810:54d0:56ef:66b3:18ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fd5594sm87940235e9.3.2026.04.06.02.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 02:22:04 -0700 (PDT)
From: Clement Amar <clementamar@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Clement Amar <clementamar@gmail.com>
Subject: [PATCH] virtio: simplify of_node handling in virtio_device_of_init
Date: Mon,  6 Apr 2026 11:21:59 +0200
Message-ID: <20260406092159.136447-1-clementamar@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace goto with return for simple error

Signed-off-by: Clement Amar <clementamar@gmail.com>
---
 drivers/virtio/virtio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 5bdc6b82b..b49113ea8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -493,16 +493,12 @@ static int virtio_device_of_init(struct virtio_device *dev)
 	 * Simply don't init of_node in this case.
 	 */
 	if (!of_device_is_compatible(np, compat)) {
-		ret = 0;
-		goto out;
+		of_node_put(np);
+		return 0;
 	}
 
 	dev->dev.of_node = np;
 	return 0;
-
-out:
-	of_node_put(np);
-	return ret;
 }
 
 /**
-- 
2.43.0

