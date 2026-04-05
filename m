Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC042F069D
	for <virtualization@lists.linux.dev>; Sun,  5 Apr 2026 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417561; cv=none; b=Jvveo0Pfi3cnTHVqSXinxOppujpTKvnTy/4yCJCVqb8bvGDU+CAPYq1JWqBMi5eXXALuPBp6f/27FqdWAve7+w2ALyW0wdNQWVDK6ok7JyfRpwbojlRNjojdN+G9OCYWjD+IBIq5wmZ0IsQGbKuzDuOcukqW4sTkkiVQ4671E3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417561; c=relaxed/simple;
	bh=vBtlceh81EBRly2nwGp4pbLnqkxyOo4vOEbYGLFUMsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJwdSr0fWKjFx+ohXlF43GB15zuGUFENZvRnLCTllPQNPFRtp1tnNOxLY3ZHdBxDqD4DNzZlDvjGo5Dker7tx0dHAlwDITxUNza3tItnK4adFqKA3Vv5cEzujfK8YXMMIy9fhr8aOtR37H9P5bMR/EQzqx9HCCgU17V1DzUfrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLyBqsBN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLyBqsBN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so1257309a91.0
        for <virtualization@lists.linux.dev>; Sun, 05 Apr 2026 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775417560; x=1776022360; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBuFGDALcJeSyW255Y6h4kabjHqNu/KLOW1Xbqv4rHw=;
        b=kLyBqsBNXSVoyMkq3zy09rHeDir+qgjhukByaiVIdqwiS/eUFAdvZymnRxfAkWnnFG
         a7gNgzHs1E3ipiON87YdqU6x7aWuiyBOuwVWGFMfuUsu9PfI2TSnN00X8KGexOniPW6L
         sXUmhwoqy/QLxz5LzJeOWSq3Iva9nv1luM/McM92PAzmfsA+0O8lQMS77VzGIkZWkfb+
         63+Drc/smB+DE2s0NLURuavd4PdW6UKhymxJxjgr514jTa/fQttf3h8l+ArgxbkzJzks
         3DUj+3k2Vxk8Bf6lj/2VgykxhNa4o3V6fG1vJsUQ/iQPZTXJYEQy6xbDULwXyQeeWAvr
         zsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775417560; x=1776022360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBuFGDALcJeSyW255Y6h4kabjHqNu/KLOW1Xbqv4rHw=;
        b=Vnzkvp15Vcz+MLU8EWZB/MljsW8XoWPro2mr3fWL3aCXu8xmTERtg273aHl/5pePRE
         bcGEE9q4kA8kEoIMjiOX5R4jyitNy/MOGG+JQVSjfHpjWlUIA8nJGpTW0P3qlrJ1ELkj
         f3rpIahiJXSXiVZp/AGiwVSQ5aWRW9tmFXjwXDYGB4DyYUMUTHi02yy5Mehw5cOQMv27
         /yNSsRVMumpRCAXe7h7iIM0f1IzOPmz4j9cHa5MMf9b/afZQbkVWNyNcVsL0//TR0eIV
         xlAwHMd0qS6rjLvImcoRUveITM9UIynb3QqNL7Dimnh5t2PL3SOnvzRNGirtRbwWtHi6
         jtvA==
X-Forwarded-Encrypted: i=1; AJvYcCUAtKhc7BGKqo2RJctFR5chrndnclPdxtD1j5CpAZycNaThjrfvifMTJ4kczJMCoRq1S6KmuGWXXTeRmBWQrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YztDGJwjVXYoQTQO/8iJeI7xE8SbPi5pEGOYH67kCvCVXv9Y4mS
	quHsBLlfjt1Iirh6lOUYUpJ113YOEFgbD1WXpAD+8nXqh8QC/YX5PCDw
X-Gm-Gg: AeBDiesyrVjCx4U5EJwvYiyGzVMYgZ7iQzK3HBGKsFY/xl4O5yf8OBH2QfITsLLmZQz
	t/he/1OsVtXzcblKz/MN8SYlJ6eYYL9w0qRgRx8BBvtiW+6vFAxaK6X5O7FVitFxHaNicekPWie
	K+GLJzmrf37oT0h7gP1Mrsg9FOvxglxtHwzR0RPFnusHDN7bsQP3Hs3J3NfONBRDIxLbIM/UO0O
	kJQxl4UFTJLWnN9jnUD0T048qAm3jYtYzXi7b80u/dvh1coFxYxn5OXGE5lnsZwkuwNiGOoiUIa
	g9MCOBqvCYOofoNKR/SjSJR4v66OdrbjQO2Xg8yTN4gj6zWVxjc+mrMx4IBRqe+JwsS4olCi3Xl
	r9ONsDopvrWKR0mZyZo1PBTMCwgIsUfQ/EBKTyE52PyNl8aNvuz3ECk382BxUP1QQYj9FX41thf
	6nSHRNYA7VhcOhEA==
X-Received: by 2002:a17:90b:1dc6:b0:35d:a843:6b1f with SMTP id 98e67ed59e1d1-35de6899ce5mr9686034a91.11.1775417559954;
        Sun, 05 Apr 2026 12:32:39 -0700 (PDT)
Received: from mes.. ([2001:288:3001:25:be24:11ff:fe8b:b59f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6563aacsm10498601a12.19.2026.04.05.12.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 12:32:39 -0700 (PDT)
From: Yung-Tse Cheng <mes900903@gmail.com>
To: gmaglione@redhat.com,
	vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Cc: eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yung-Tse Cheng <mes900903@gmail.com>
Subject: [PATCH] virtio-fs: avoid double-free on failed queue setup
Date: Mon,  6 Apr 2026 03:30:39 +0800
Message-ID: <20260405193039.178506-1-mes900903@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_fs_setup_vqs() allocates fs->vqs and fs->mq_map before calling
virtio_find_vqs(). If virtio_find_vqs() fails, the error path frees both
pointers and returns an error to virtio_fs_probe().

virtio_fs_probe() then drops the last kobject reference, and
virtio_fs_ktype_release() frees fs->vqs and fs->mq_map again. This leaves
dangling pointers in struct virtio_fs and can trigger a double-free during
probe failure cleanup.

Set fs->vqs and fs->mq_map to NULL immediately after kfree() in the
virtio_fs_setup_vqs() error path so that the later kobject release sees an
uninitialized state and kfree(NULL) becomes harmless.

Signed-off-by: Yung-Tse Cheng <mes900903@gmail.com>
---
This can be reproduced when a broken virtio-fs device advertises more
request queues than the transport actually provides. In that case
virtio_find_vqs() fails while setting up the extra queue, and the probe
path reaches the double-free cleanup sequence.

 fs/fuse/virtio_fs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 057e65b51b99d..e33241e1b8ad9 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -988,7 +988,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	kfree(vqs);
 	if (ret) {
 		kfree(fs->vqs);
+		fs->vqs = NULL;
 		kfree(fs->mq_map);
+		fs->mq_map = NULL;
 	}
 	return ret;
 }

base-commit: 3aae9383f42f687221c011d7ee87529398e826b3
-- 
2.43.0

