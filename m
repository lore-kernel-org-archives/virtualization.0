Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C7434FF56
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681811; cv=none; b=gwwk6Ld492CeEsgl0632wd4pJWB1ltVK3vY/+BigEpRq6RLlUKj7T2xfLHxNX5NZT9sRG1Ohl6Pon+FeqREgAVUnhFoJtbXLWi2e5rAO3BQBPIkP0dEC+EqCqObW93YPzKWMFTBodvpNxHBDkp9yOg3HDu/kQE6us8CeFdeio5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681811; c=relaxed/simple;
	bh=BDUaSKODNKtMq7VQYWR0GriGBCfWmxRXz2MCLuAhAaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orve4FJmenVf6d3Vdb1co1kohwwZPrlANGVKbYEy/qOa0co0NFf5ALOwAjjSqJ9ZW04Bis8bgdIWNgT1KkI2MnOgh4TmHzvYZqFSJFals/xp3HEZw+xgEqFsNsNuR8pDvOe7SCCz8ap+DJuKEdyuWmrOUw8Xvqw4FIEvuVQ3p6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzhzgkeg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzhzgkeg"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33d896debe5so7131534a91.0
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681809; x=1762286609; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8joGPkRS7NaA/SU5NP/PHmANMNfQZvGYAt78YOV8B8=;
        b=fzhzgkeg4981XtDrVE/sXnlhkXWzzFFqPuhQXEI4Zu5Sal3AYHUEssBAbOj4+wVpUl
         JLIHjIVYrrSc5Uj5JjQIQzqZfQeRVMqssDYWYIYzjY9s/bPGAyCIFq93iLSxMnpFjPUV
         DdocZK3e6JbuNMCmAjEpUWU6CdOKGdstr+/RmfoK9a0kldZFKzkP1Ns4oWmjAToe2pf6
         YbF0apnlQW/eUSUeGt4OopJDxIT6X5Xjca2rYVkWqw76mY+JIdoTA+Ny+nRwdWQVS7ij
         MM15lQbGSFiRDBLQnMeyshoWnKTwXbod2O144Pn7i4GFtMpjJF9687slNF10XYxUoiZN
         Bcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681809; x=1762286609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8joGPkRS7NaA/SU5NP/PHmANMNfQZvGYAt78YOV8B8=;
        b=AtA6MGc59MMXnlINAFP/De/V9XyjvM2tXU5JmwOmZTs8f3U2NHlKxEuLi9gbbi1JXX
         V9LXc1+R4woMZvRAIbc2Je0CJGvT33cuo408rQonId1wEzGY6z5q7no0SJdNkewp8Pne
         Ynt5ZZMZSYaLOFQW07yqv+EXfEg4s0oxr81HDiFup90hMrEjaF2m/AWWOk8PKczIT+G8
         wCXZzMogLod46JaVwExDLrpqJCsmrew3OtFzBDuyAW9iwugtfS2h57bDiiUp0L79fLuw
         ow3D+a5pfyl+faVrxsNY8/7OByh6P+IQnNJKLwIb6egV+rfKdx1IO9HUTx+XTAlCp82J
         Cu6g==
X-Gm-Message-State: AOJu0YyBXm+I4GajOOmWMcJsiIsqiG63V36JaDM19ZMvvWuBXcZucU6D
	ye3BTkwZ/J9aqSVQEp8ld0R8bfh6leICMlRFFMUsOwGrnJV2BIFmKvbq
X-Gm-Gg: ASbGncsvO7HwIVzDI6QUL6OZE/zDAzVNB+DwNc/jLc01NPbY77NR0H+nRGnHDsYil91
	1UcQXLxTLTDdhU/M37OomBj3ZXXKxOgOKsVRk6bVzYBzv0KgxBp4hStrF2lL4x9P1OPjPzv+Qlv
	JHzVRl088uZV8PeTzG+NxlLXib/jOXAtiWYZA74IFaNdl/YG1RIgo8aoGusI0wEm+s2dc9mOSDU
	/iBHzXgSN4UfvSKe7wCyO/+hJnkCxeAO2oy58oQiBz+S7NNiF5V2ayjjMZixCBPuwxqOYCIfA+f
	zAo4p43PufpAfyRTJQGXOiK/tq85/EW8I9kPuZ+yV62neA+T4lqE35x3nQCDU2q2OrPkT8UM6i4
	7qxc8yCTa7gKGZgIUB4f8bCM/1h6OwimBtMbB46MUXPNEeIgvGbabqVC6xWa0P6+0tPSL3Z7NeM
	lXTCm23zx8Tb+zdfllC90rI1eJwg2U1wqWneBFdQ==
X-Google-Smtp-Source: AGHT+IFax4JLp6peVjA4GRSNGg+x5gUWORdeMvPmm1KtEIj6rMAl9UjikOCZ4H3Vmq+EX50VwOXgvg==
X-Received: by 2002:a17:903:1c2:b0:294:def6:bc1e with SMTP id d9443c01a7336-294def6bd88mr4468365ad.15.1761681808551;
        Tue, 28 Oct 2025 13:03:28 -0700 (PDT)
Received: from brajesh.. ([2401:4900:78f2:772b:141e:4f0f:8f8f:6f84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4254asm128996765ad.82.2025.10.28.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 13:03:28 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: miklos@szeredi.hu,
	stefanha@redhat.com,
	vgoyal@redhat.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	virtio-fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH] fuse: virtio_fs: add checks for FUSE protocol compliance
Date: Wed, 29 Oct 2025 01:33:11 +0530
Message-ID: <20251028200311.40372-1-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation in virtio-fs to ensure the server follows the FUSE
protocol for response headers, addressing the existing TODO for
verifying protocol compliance.

Add checks for fuse_out_header to verify:
 - oh->unique matches req->in.h.unique
 - FUSE_INT_REQ_BIT is not set
 - error codes are valid
 - oh->len does not exceed the expected size

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
---
 fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6bc7c97b017d..52e8338bf436 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -764,14 +764,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 {
 	struct fuse_args *args;
 	struct fuse_args_pages *ap;
-	unsigned int len, i, thislen;
+	struct fuse_out_header *oh;
+	unsigned int len, i, thislen, expected_len = 0;
 	struct folio *folio;
 
-	/*
-	 * TODO verify that server properly follows FUSE protocol
-	 * (oh.uniq, oh.len)
-	 */
+	oh = &req->out.h;
+
+	if (oh->unique == 0)
+		pr_warn_once("notify through fuse-virtio-fs not supported");
+
+	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique)
+		pr_warn_ratelimited("virtio-fs: unique mismatch, expected: %llu got %llu\n",
+				    req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
+
+	WARN_ON_ONCE(oh->unique & FUSE_INT_REQ_BIT);
+
+	if (oh->error <= -ERESTARTSYS || oh->error > 0)
+		pr_warn_ratelimited("virtio-fs: invalid error code from server: %d\n",
+				    oh->error);
+
 	args = req->args;
+
+	for (i = 0; i < args->out_numargs; i++)
+		expected_len += args->out_args[i].size;
+
+	if (oh->len > sizeof(*oh) + expected_len)
+		pr_warn("FUSE reply too long! got=%u expected<=%u\n",
+			oh->len, (unsigned int)(sizeof(*oh) + expected_len));
+
 	copy_args_from_argbuf(args, req);
 
 	if (args->out_pages && args->page_zeroing) {
-- 
2.43.0

