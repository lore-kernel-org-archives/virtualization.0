Received: from cvsmtppost05.nm.naver.com (cvsmtppost05.nm.naver.com [114.111.35.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F3199920
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117864; cv=none; b=bd5qD5k6Z6vjIGhY5y4BftmacCMhrC+cHYVpiQza/AjxCGfYbVtFFhFg2q0tTYxHlDlXvau8e3iuXguoY5wRvkuR8ZeoRg7nZ2XtoqWvuKcq4zl48M82bi7mFzD4uTHZbCH/x9l4JnLy2Y99+h/MEUJaM7Efb/So6bMti3wG6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117864; c=relaxed/simple;
	bh=vKlmh903O9l6vLPy3nGfF3jjtRSyQOnuIrV3u0yo9iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQd24JkwJmmwy5jMlwHmEaFt5Gok8xZR/jb95xbcpochjtY4t+EP5UwHytStACe8nVyalZvfOM4U7rh6i9X4TGVHagrKKUpHqEMLnR98PWspJPJ837AYRsYEBvWa4iy40hgzaqoHKpBVnlNVUVUIKs+ZTiry8ypla8Qd1XmtX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=ViyzyQsC; arc=none smtp.client-ip=114.111.35.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="ViyzyQsC"
Received: from cvsendbo004.nm ([10.112.24.36])
  by cvsmtppost05.nm.naver.com with ESMTP id rr-1jBU-SQSuJMdntrKyLw
  for <virtualization@lists.linux.dev>;
  Sun, 04 Oct 2026 12:34:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791117254; bh=vKlmh903O9l6vLPy3nGfF3jjtRSyQOnuIrV3u0yo9iE=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=ViyzyQsCdA5hgbd0UBwju7VcLj+OyS8/CDRT6dLiZ0DdPjqba0hE9IWOTCLBnlknr
	 eOlUUBV0m5fjTrvVesaecV2LxdC/YvJaeMRO3uVCw7dDSWNNMCuZ/T1L9zLveqsk+L
	 KdeJ4rOWrl1CuK5GU8LHocR/AaURwYvmUptNTTznMNCceibYrMqJ/tJ3eNuJWCP/7M
	 EdCj5lLklwijvpVYEeV7x2UuCMBERoONrFhoHbpz14bxGpZrxiszpea7T16BxrdMvp
	 wN2Pt0hRfwdPPtSsnfChqm5rQMeMhdl4kf8PqI6g+FBkHIKWhgyWfnWY4m02MkJjOf
	 BKHuz+DG6s7Wg==
X-Session-ID: 6UKYWWETTnuweS1g2CSHKA
X-Works-Send-Opt: O9+wpzGdjHmdKHFOMr39Ko3YKHmwKHmwFAbrFxKrKqEmjJkaBd9YKBmm
X-Works-Smtp-Source: PdK/KAulFqJZ+HmqFx2d+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp002.nm.naver.com with ESMTP id 6UKYWWETTnuweS1g2CSHKA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sun, 04 Oct 2026 12:34:13 -0000
From: sungbyeongchan <tjdqudcks0424@naver.com>
To: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] virtiofs: validate fixed-output response length
Date: Sun,  4 Oct 2026 21:34:05 +0900
Message-ID: <20261004123405.586168-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
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
out_argvar requests, and do not copy output arguments from error
replies.

A header-only FUSE_STATFS success returned stale fields in nine of
nine calls across three boots. The patched kernel rejected the short
response in three boots and preserved complete replies and existing
error controls.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
---
 fs/fuse/virtio_fs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f15e516ebcb5c..288848f23e7ec 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -730,6 +730,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* Error replies contain only the output header. */
+	if (req->out.h.error)
+		goto out;
+
 	remaining = req->out.h.len - sizeof(req->out.h);
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
@@ -755,6 +759,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
 
+out:
 	kfree(req->argbuf);
 	req->argbuf = NULL;
 }
@@ -762,7 +767,9 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 /* Verify that the server properly follows the FUSE protocol */
 static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 {
+	struct fuse_args *args = req->args;
 	struct fuse_out_header *oh = &req->out.h;
+	unsigned int expected;
 
 	if (len < sizeof(*oh)) {
 		pr_warn("virtio-fs: response too short (%u)\n", len);
@@ -777,6 +784,25 @@ static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 			oh->unique, req->in.h.unique);
 		return false;
 	}
+
+	if (oh->error) {
+		if (len != sizeof(*oh)) {
+			pr_warn("virtio-fs: error response too long (%u)\n", len);
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
+		pr_warn("virtio-fs: invalid response length (%u, expected %u)\n",
+			len, expected);
+		return false;
+	}
 	return true;
 }
 
-- 
2.43.0

