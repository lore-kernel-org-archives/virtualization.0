Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6828C5DF
	for <virtualization@lists.linux.dev>; Wed,  6 Aug 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480792; cv=none; b=XK0GYkpX+nnWI5LBBwBFzs8Rl9e/iAHuBJGznoq20LQTxWKSE1HZ51ljhy+BQ+SQZQHNsnceyH23w6iNWgvXAu7TDqg2j/TBbwLygoMqXYZGx4EE2iYxTCsfAD+fa2c5ZaQ2TY3gLP2ntlM98jfm7KS34QS6rwI+DxPnGzB8wiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480792; c=relaxed/simple;
	bh=AeTg3n2+36U1bKKUxTj3cnvi0+ymaUvU/tCDhqRpp98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b71HUZHv2F6dpIiHKk6CxNAgSDvWltYBzkT9QfbdAVAqnHUHd8r03YLgZYSG3b0RYF6vnZddJLoDuT5OFu6ONziruZcqTwwEVOuKwIwaur+2pH61E89OEcYaIA5VQtR5hMMcp/TPMOgW2wqlNjtSJUFG/KvJoCFccmsNPSpmzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnLVH9j/; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnLVH9j/"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-23c8f179e1bso64809755ad.1
        for <virtualization@lists.linux.dev>; Wed, 06 Aug 2025 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754480789; x=1755085589; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvQ3K/B+PsFDhSqERlrqC+tEsNJAT5qOCzxTgrGl7VU=;
        b=QnLVH9j/9m5tJYjFJt7/IKKdqfULHsnYh/wocXGu+tf7spGGL0HKWVa+2eAeNu2XpJ
         DxOPKo6S+3muS31M90ME64N2RbbcnDwvRwJ3yHDBCz36mFrf9v0YwzNMoOaRQzidjc5D
         EtozrZfCi8oGww51CZIW3CN7yVAPNG3QVmSpN+rc2P1410VswmCzvW30NMKiXfP2w0ib
         WWqq6Mi6CsWG7nThTCgaMKvH36VQ9BByyyQc/H+CEt3Uou7skCCz/n7D46NUTECF17FA
         qmLDbcnqsatGh4s+P8j6FzFHevhP3BiPZrmHSD7L3OkYUg7buwra8DjVR9alZipoIY/i
         bvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754480789; x=1755085589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvQ3K/B+PsFDhSqERlrqC+tEsNJAT5qOCzxTgrGl7VU=;
        b=KdNdgYUWv4aFvPg2gzUd6rA3ZnBsDb6LutFOKNdKbvk1l0T15NuzN15guWTYA6g99+
         zqfbn102qzcucVaqa6dcGHPWOLrLa5q4ajX3nwN6ppudzVlpg3Rk77ousy5cqYW8IH7E
         d9vYyoHAPn5ecQPDJS2jTPBs/oTFf2TwdOF7qpJNELtBfEoyFBqWBJ7DAv4rp5iRfG8o
         6wP2dE88TJmcfb6PYdiw1I6z3MigJa0Ixet0KWL2dei9XN9Uq+R39M/OH/a6Onn92fQ+
         FIOKyxIXxNFupGlxU/jKJkJxVa+/QTRG9E6R47QnqcAfMQKs/MDySeRbm7hse1Ef4d5y
         Ppag==
X-Forwarded-Encrypted: i=1; AJvYcCX/RMSwmCUoGt7Ud9eAdgibO46GiSrJuFs63NA9C27y4RKp58pbvl+ZIDJTLwrZ/fvJ5pxQpIBbNqkLVk6FeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdYngTQJRpKireZ2gA6IvdxR0DvFPJ86G8YDdsz9GZpaD/HleV
	T1GnMY58svFaXi4XPsU50q/BAY5Tc6sneZS8weZpYX4XVvp07JFO3lcy
X-Gm-Gg: ASbGncu+z1rYyt0ZeTR1UJnpK0ZlnLnhHJRnB0/68h7QQxUOwjqYGgMhML1rGtQIkrO
	9XX6xeWHHHRMq0wh4Bai+EIuR/rduD74JiZA23qAEwejnHpKtkQifh8xHKfVx8LI9tI5eb65z3w
	Vlrb3/xPhhxXVKXCg562vNqvau4EsoYkZPiMS496khzt1QaKdiFnrbNDgpCLuJo3X0qFTRhWCx7
	/k35XtxNXUiq2nvRBJv9e0XMwSEnrf83qi77Jn7tL8EkfwWaBocq9z5LW/If1iGyqMAJzYOa1Z7
	tYH7BtpMxbiSYGmGs9nd1RA43rSmlWlpCpxJJ+4DDO/080LqRSQ6cFnRCOnvL2Mhk0UeETzGDDL
	JRcCymkbDSf5BhavjVzUjT35Vwptg3Gw4OsOzQ9rDnD4T72ou5LPJdCRKmsNmqIHGZPZqjjI=
X-Google-Smtp-Source: AGHT+IGYnNnkqbBejCEa738PL68HMyteeGMcVERAvjm5Y65paJqZqI9HTxHastRunZ+7mQnAMKeaEQ==
X-Received: by 2002:a17:902:f687:b0:240:aa0:1584 with SMTP id d9443c01a7336-242a0b8bc9fmr32866005ad.38.1754480789428;
        Wed, 06 Aug 2025 04:46:29 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6fesm15190656b3a.26.2025.08.06.04.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:46:28 -0700 (PDT)
From: bsdhenrymartin@gmail.com
X-Google-Original-From: tcs_kernel@tencent.com
To: huntazhang@tencent.com,
	jitxie@tencent.com,
	landonsun@tencent.com,
	mst@redhat.com,
	jasowang@redhat.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsdhenrymartin@gmail.com,
	Henry Martin <bsdhenryma@tencent.com>,
	TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH v1] vhost: fix missing descriptor reclaim on copy_to_iter failure
Date: Wed,  6 Aug 2025 19:46:20 +0800
Message-ID: <20250806114620.2696386-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Martin <bsdhenryma@tencent.com>

If copy_to_iter(&hdr, sizeof(hdr), &fixup) fails, the descriptor is not
reclaimed via vhost_discard_vq_desc(), leading to potential resource
leaks.

Fix it by explicitly calling vhost_discard_vq_desc() on failure.

Fixes: 4c5a84421c7d ("vhost: cleanup iterator update logic")
Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
---
 drivers/vhost/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 6edac0c1ba9b..7b4be344b8af 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1238,6 +1238,7 @@ static void handle_rx(struct vhost_net *net)
 					 &fixup) != sizeof(hdr)) {
 				vq_err(vq, "Unable to write vnet_hdr "
 				       "at addr %p\n", vq->iov->iov_base);
+				vhost_discard_vq_desc(vq, headcount);
 				goto out;
 			}
 		} else {
-- 
2.41.3

