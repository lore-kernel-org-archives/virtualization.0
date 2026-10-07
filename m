Received: from cvsmtppost15.nm.naver.com (cvsmtppost15.nm.naver.com [114.111.35.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3363FC5D0
	for <virtualization@lists.linux.dev>; Wed,  7 Oct 2026 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354627; cv=none; b=KhpKdPPnuko0tLoE+rPSFuFMnEnkFpZkCksflofbT9HOY+g1RWiCWHIOkIiG/OSMncr1pDMdRXc8MCX9RVTvJy4kkrsS2a2kWfytxWcMQQoXN4J3uz744DxGC3uEo9o4E34ZQic75gHiimienCaogaTNQm3JkP154e0ds6UeMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354627; c=relaxed/simple;
	bh=z/5uOZYR1Y1u3E66uPuCbI7MhJcuTSLKits+KG2x+Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMTXdMo4WEVllPLFDW6AJJPbW80uop1rnPzxZKOTPZ3sFYjowuJpp9DTpg+tiipOec69WMMX005axzOdmb1M2Sn/uzNKbd4QvQSxWz+F+ZsITal6RuLmjMt+Gcxi1Yqn4HZe2hIM2O+4hFzNfAOiRk5+MXDkyy6yxrYJQqKuCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=CGBAvmdM; arc=none smtp.client-ip=114.111.35.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="CGBAvmdM"
Received: from mvsendbo11.nm ([10.179.40.204])
  by cvsmtppost15.nm.naver.com with ESMTP id 4bUm-LxxQtSBk9xRFZAjLg
  for <virtualization@lists.linux.dev>;
  Wed, 07 Oct 2026 06:20:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791354004; bh=z/5uOZYR1Y1u3E66uPuCbI7MhJcuTSLKits+KG2x+Xg=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=CGBAvmdMK8qc9P6TbzPc6ELSgNa1mVO9mS7C7jm8wvr7xZkWrnvZgXzQvgAilAxVm
	 jr+kIMr3cKv8W3S7dXVsvkuSJZ1S2U/DxyJEdwXIdQfgINxGh2o+kc0wPZUCI4Rxpc
	 NcTsIPCaRY8781lN7uucwbBbfX9oAp946heUfRpLFAAQxu7FIXkYIIANGR2VGU1Tsc
	 sTH4B0+Yip04z0yfKRjDxyB+v2hcz6Jn6p7r2oG2PdpIAwR9IlMwlEN/BFtdZeGuAf
	 a0E7OmvzA3LC5yLp/CtX2gAJfL3ILbohnkN0d03i3Wuo3L+qkDxHBF/nQ94yUpImp/
	 XbnTkEkOtFtWQ==
X-Session-ID: gXJdtBoqS3KGP7KppeaDYA
X-Works-Send-Opt: O9RwpzGdjHmdKHFOMr39Ko3YKHmwKBmwFAbrFxKrKqEmjJkaBd9YKBmm
X-Works-Smtp-Source: XwnZKqulFqJZ+HmqKAMw+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp011.nm.naver.com with ESMTP id gXJdtBoqS3KGP7KppeaDYA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Wed, 07 Oct 2026 06:20:03 -0000
From: Sung Byeongchan <tjdqudcks0424@naver.com>
To: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] virtiofs: validate fixed-output response length
Date: Wed,  7 Oct 2026 15:19:49 +0900
Message-ID: <20261007061949.23008-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A short successful virtiofs response can leave the fixed-output portion of
the request argument buffer unwritten.  The completion path nevertheless
copies the full declared output to the request destination, allowing stale
allocator contents to reach callers such as fuse_statfs().

Require successful fixed-output responses to contain their complete
declared output.  Continue to permit a shorter final argument only for
out_argvar requests.  Reject positive and internal restart error values
and require valid error replies to be header-only.  The error already
stored in the FUSE output header is returned by fuse_request_end(), so do
not copy output arguments from an error reply.

This was found by source review with AI assistance.  A header-only
successful FUSE_STATFS reply returned stale fields in nine of nine calls
across three boots.  The fixed kernel rejected the short response and
preserved complete replies, valid negative-error replies, and
variable-output replies.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
Changes in v3:
- Keep fuse_i.h in its original include position.
- Drop the unrelated warning ratelimiting and prefix changes.
- Explain that req->out.h.error is propagated by fuse_request_end(); the
  completion copy only skips nonexistent output arguments for error replies.
- Use the spaced real-name form requested during review.

Changes in v2:
- Validate positive and internal restart error values.
- Require error replies to be header-only.
- Add Cc: stable@vger.kernel.org.

 fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4f334766b8c30..1b585bbbe353d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -730,6 +730,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* fuse_request_end() returns this error; there are no args to copy. */
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
@@ -777,6 +784,29 @@ static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 			oh->unique, req->in.h.unique);
 		return false;
 	}
+	if (oh->error <= -ERESTARTSYS || oh->error > 0) {
+		pr_warn("virtio-fs: invalid error value (%d)\n", oh->error);
+		return false;
+	}
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

