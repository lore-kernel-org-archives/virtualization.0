Received: from cvsmtppost04.nm.naver.com (cvsmtppost04.nm.naver.com [114.111.35.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83ED456E14
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125904; cv=none; b=sXBhlmsGTduUHdMHWRiXl1WWtcfPX/LqtZCJaZC6EO3fIzU3wcuvpRC1YYCMR7V9O/EBYFHm2F4+DnUxG0rKnaQ/Sf2X0S8urobuSiUe2hy4tM9avp5OJD3xF4yc/LAp/wDY9UzDI4nCp/VJAiSlhRvK/YXeKiYYkPW/kyrsoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125904; c=relaxed/simple;
	bh=XcNN7eJ8pqt5t9I3uN7RYCmycRwA+uReKRMPHRBCfAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxjSvfx3Sp50TxGfmI0lHR4LmH+84GiJTss58BGLgmZVtc+RwztE931UvR80rQhkOyM9pFk5lK5YtmGoz+SQVOkZIKCMAmkbOqTLzsy3AmmlpSxG81hqrgOUO/9M/FekW43IBAgWeTTBBnezJHi7FhJPps7LWDUF2Q5lrg7164c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=diiy3L9d; arc=none smtp.client-ip=114.111.35.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="diiy3L9d"
Received: from cvsendbo010.nm ([10.112.20.44])
  by cvsmtppost04.nm.naver.com with ESMTP id cW4pIM2JR6aqH2X7Gtl+tA
  for <virtualization@lists.linux.dev>;
  Sun, 04 Oct 2026 14:48:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791125291; bh=XcNN7eJ8pqt5t9I3uN7RYCmycRwA+uReKRMPHRBCfAU=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=diiy3L9dOxW4HPbY2YH5b66jCUt2IstVCPK9V22LyK+a8YmsxHXLqmukZwvO7RYbS
	 CV0B7Z4c2XC79Sm0uO1mqPujARBlTgsA1thrD46qh0mMAUcysD1vFE3YuqgZlgCXRU
	 dnzwNQDn2hE0z0MlnhvYUbTOKUeEw5UbDmpmtgLBzeBZQu95hFXMS/G2Y5WjBq3EKr
	 IQEza4mrDky41gRd6DcGAN6MTfNrG/gJgHLptDJtm+EjMruNNDcROx/Dn7IvKKH8Ms
	 ErH5KctN7wNVg090+8EmE5yoh6u8Fb2RHKXjWwNiy5XGg+BQGTalqmpTK2DAMr+4pd
	 qsj0ApW0ElPeA==
X-Session-ID: LmKJ5MAwSoyrVmVIaLe33g
X-Works-Send-Opt: O9ewpzGdjHmdKHFOMr39Ko3YKHmwKNmwFAbrFxKrKqEmjJkaBd9YKBmm
X-Works-Smtp-Source: sdKlKAulFqJZ+Hmwax2Z+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp006.nm.naver.com with ESMTP id LmKJ5MAwSoyrVmVIaLe33g
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sun, 04 Oct 2026 14:48:11 -0000
From: Byeongchan Sung <tjdqudcks0424@naver.com>
To: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] virtiofs: validate fixed-output response length
Date: Sun,  4 Oct 2026 23:48:00 +0900
Message-ID: <20261004144801.663923-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004123405.586168-1-tjdqudcks0424@naver.com>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A short successful virtiofs response can leave the fixed-output
portion of the request argument buffer unwritten. The completion path
nevertheless copies the full declared output to the request destination,
allowing stale allocator contents to reach callers such as
fuse_statfs().

Require successful fixed-output responses to contain their complete
declared output. Continue to permit a shorter final argument only for
out_argvar requests. Reject positive and internal restart error values,
require valid error replies to be header-only, and do not copy output
arguments from error replies.

A header-only FUSE_STATFS success returned stale fields in nine of
nine calls across three boots. The fixed kernel rejected the short
response and preserved complete replies, valid error replies, and
variable-output controls.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Byeongchan Sung <tjdqudcks0424@naver.com>
---
Changes in v2:
- Reject positive and internal restart error values.
- Require error replies to be header-only.
- Rate-limit malformed-response warnings.
- Rely on the existing FUSE pr_fmt prefix.
- Add Cc: stable@vger.kernel.org.
- Use the author's real name consistently.

 fs/fuse/virtio_fs.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f15e516ebcb5c..fffbe08d9114a 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2018 Red Hat, Inc.
  */
 
+#include "fuse_i.h"
+
 #include <linux/fs.h>
 #include <linux/dax.h>
 #include <linux/pci.h>
@@ -20,7 +22,6 @@
 #include <linux/cleanup.h>
 #include <linux/uio.h>
 #include "dev.h"
-#include "fuse_i.h"
 #include "fuse_dev_i.h"
 
 /* Used to help calculate the FUSE connection's max_pages limit for a request's
@@ -730,6 +731,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* Error replies contain only the output header. */
+	if (req->out.h.error)
+		goto out;
+
 	remaining = req->out.h.len - sizeof(req->out.h);
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
@@ -755,6 +760,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
 
+out:
 	kfree(req->argbuf);
 	req->argbuf = NULL;
 }
@@ -762,19 +768,46 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 /* Verify that the server properly follows the FUSE protocol */
 static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 {
+	struct fuse_args *args = req->args;
 	struct fuse_out_header *oh = &req->out.h;
+	unsigned int expected;
 
 	if (len < sizeof(*oh)) {
-		pr_warn("virtio-fs: response too short (%u)\n", len);
+		pr_warn_ratelimited("response too short (%u)\n", len);
 		return false;
 	}
 	if (oh->len != len) {
-		pr_warn("virtio-fs: oh.len mismatch (%u != %u)\n", oh->len, len);
+		pr_warn_ratelimited("oh.len mismatch (%u != %u)\n",
+				    oh->len, len);
 		return false;
 	}
 	if (oh->unique != req->in.h.unique) {
-		pr_warn("virtio-fs: oh.unique mismatch (%llu != %llu)\n",
-			oh->unique, req->in.h.unique);
+		pr_warn_ratelimited("oh.unique mismatch (%llu != %llu)\n",
+				    oh->unique, req->in.h.unique);
+		return false;
+	}
+	if (oh->error <= -ERESTARTSYS || oh->error > 0) {
+		pr_warn_ratelimited("invalid error value (%d)\n", oh->error);
+		return false;
+	}
+
+	if (oh->error) {
+		if (len != sizeof(*oh)) {
+			pr_warn_ratelimited("error response too long (%u)\n",
+					    len);
+			return false;
+		}
+		return true;
+	}
+
+	expected = sizeof(*oh) +
+		   fuse_len_args(args->out_numargs, args->out_args);
+	if (len > expected ||
+	    (len < expected &&
+	     (!args->out_argvar ||
+	      expected - len > args->out_args[args->out_numargs - 1].size))) {
+		pr_warn_ratelimited("invalid response length (%u, expected %u)\n",
+				    len, expected);
 		return false;
 	}
 	return true;
-- 
2.43.0
