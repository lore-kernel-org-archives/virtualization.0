Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440153C1D7A
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213113; cv=none; b=oVUEuNlwLerhc9RZUCxnhyojezgJpp243VvHBEnHfv0UaiVbg3x1SIUy9l6hDQvBVWnNJLz+IbZO6K4OZ5jCEr48Z75hivlNDMOgmNUit86txBLFZ7vkMwMcFbzZK+cKx3ibPRWbwlJR58ZBeY9G0Ev+AEGjGniIweF2FFtXb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213113; c=relaxed/simple;
	bh=dKGHt4r84CpOxIzBLIbsre1FSK83Rg5xkKpViCYYB1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dtht96oY9tYVLcMZCp51pBP+m946iT1q3pv7ldir2E7HrggnLeNCbTXweyO+4oTO8z/OdTzHxY+lUQ+rpNvtIf+q42ZoBBAmHq2fo5JcCeBxaZSM9g9IqSa8Q20SGLfCwv0qltTxkBgP8tKarx8pl7Fl3UaRSY2IjxAZIOKr8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3DCnevx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3DCnevx"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbedf318752so1161867a12.0
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213111; x=1787817911; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTb4s8ilSvnVrxrv/sl/GlxziAICPTcGZMT22LW8F5Y=;
        b=h3DCnevxhHf57BrUkgl2AUAEoo3Mqi3tqPXJXk3SsB1St2jCm73Z7ZcnwSOBNFhwWE
         0O83GQ0k7lz4wSlvOfmW1/6xLsnoiRbLs0GSyk49AqxpYFVwHfvCZd13wpWGLQT0/2qY
         mS0dhd4esO1zanwLafU4XccRhl/unsoGK34+I9v2kfbOWZjAyqRTkglset/gMI+2xGM0
         /VyyT4ojPZKEbC6jjZHa8Jwisph1rPvzjXayAx97UACDfqvBBeKD885d6DRh/m4gBhdv
         hr/AvMWSCXyofUWb3mPRMsb/G0e5UZcBuLNAtBIqs4KIaA/ll0p12gmQxDEnHTD5TzQT
         qQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213111; x=1787817911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lTb4s8ilSvnVrxrv/sl/GlxziAICPTcGZMT22LW8F5Y=;
        b=gV792UjpS80JY0b1dg7F+zfOcjxl//0MsTc/2mWGv+C/4MRoCnQUo3WwUl7Rwq5612
         nVmrXvS/v2mXdlXvo8/nZ/VHUZfZb7DRmrph7r8jrGoL4lvCtActfr5c/sBe6jyesd8J
         roc0cyRE2YUrKzso+1dxzi8HHb6vPArMWUNanwdf1fqbORxPrLQif8n218cHR5ADD5cf
         LmyorL2ONgJAG9fxA3A868x6XwhuCBAuriMOwOtaoJm91kNtuz/oQ8M9StCL8BvX4F3i
         RyEnsnc1+vStoNFr5r2u2QdntYz7V1qOILvIyJMpD0wT5jtO1G8tD/1jKTf4hXqON8BI
         gHAA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/3tXeFjdpf1KMWDI5NUjIWX/rBAU4WwA9xZC2CIuTL3OU/tRbnXxoY59XATmZiCBrLjCJC9kuMBslBZ8Ecw==@lists.linux.dev
X-Gm-Message-State: AFuF++m+lHBgQm0tBziGD5aj+ARHR5nM7bODkoaxtA3Utt+JeDWeaQAb
	CyK+HqRH7tmqa++0cFRKDOzsQWALfVFjgkM9KZsXzlW5mpqZ3xLFMY5u
X-Gm-Gg: AR+sD114rnpYJV24bDVW2wxHoa5tEhnCJjNHge6c9dKcPwfS1hxqdMLivaJHY8r/boN
	bzEUNi1vk22lfXG4Uf2ktSfMLfSrPh7PLRbOl3efOr6EF9r90NLwHHIiA9aAsO3kJ8gvlsjbXyo
	znSvgGy5PwZ9oUrq04afJ9S4iFlUuNTaOKeqc8F+s9StlSY2ClQ1CX76CJP7pgL/H0JWfUgr79U
	GxJaUAKSpNJE9ufCY7yX64T2QjRnBvd4MgybTI1EZE/QmSjlRCyk/QHdFglSq9Ixqqt/cWh44uz
	ClEoKTsf2GDl2CY1phpfQcPynABJTvo8+yHdAYuuweno0nk/ezlegn8i8WY3yjpRWYUqUHfR588
	8+T2nciqg3JZqkYIhNVxzUSTEhYUsP+KUja3rMooQhMrR4uI1V/7Ev9VONt3/oXdjNGBkXkcMwR
	E1+wes1JpKGtaGbvEBXKT9djQG/W4muFZsXPUNnrG6MEaDJPdGNSGtAVsjq4qgNFcA
X-Received: by 2002:a17:90b:4fd0:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-39580a4d031mr20764760a91.3.1787213111062;
        Thu, 20 Aug 2026 01:05:11 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb321dfsm6047155a91.16.2026.08.20.01.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:05:10 -0700 (PDT)
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
 [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Thu, 20 Aug 2026 16:03:31 +0800
Message-Id: <20260820080332.313933-3-physicalmtea@gmail.com>
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

Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
Otherwise descriptor translation can continue to use mappings installed
before the feature change.

The common helper invalidates cached vring access and applies the
transition even while a backend is attached. The backend remains attached,
but userspace must configure the vring addresses for the new address mode
after a successful live transition.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..e1e9d002d6ae 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
+	} else {
+		vhost_clear_device_iotlb(&vsock->dev);
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
-- 
2.34.1

