Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F644BF930
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675304; cv=none; b=BzvMzzImcgSpPQe+GDXksK4kc+GfWpBJPTQgkx5MA4WJblpawOLOZtdTMVzpW/qi9/lAOx6r5vPnkRdVsqgcgfeXpvpvHX66A+4j2qT9uHC4UykbkpI64sDPhX7htpNXtnnMWcd2oDOtcTOoIAnDHBN93/wqHMgE0wzH+MI6nqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675304; c=relaxed/simple;
	bh=kb8hjY/3GbCIKHPmXiRjeyjyJtS8xD8BUXG7R2aM3sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3h9V83Xyd7OhEHpe7W1TP0BkHb+wTdEI2wBwJgwtp0Kgwi/DbY7RsDnUteXlH1twgJ+GRnFIJaduVXTzdcIr7dc0M0Zbt/69Xxw0zRyLeL/hGZnQGJpF63iZxB6UiJWZrU9l8SHtjOfqYNgRHr4VSHRssjyeWg4rdRb1xAb9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxjQG1vw; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxjQG1vw"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342568a5b54so1742021eec.2
        for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790675302; x=1791280102; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hd2pDaQuHkOifvuoX51kyffsT4qd3/Uun46tkq8lzb8=;
        b=dxjQG1vwvLcGGoxca08YU9tJExpa1r2uplrthm+dhYJywel8amxSijK3+3hG7Xk9Ev
         h9ZB5MuTfVpAUbdrSlQ7ysiwbYmfQQdbRS108WvfSkex9AdZ3xEk8E0Hee2YLbJ+JaYp
         luVkkP9cO8fagUMSCcGHbhekHvMLT49XuJnRvECcy1tok8pgPBJfucdNmP+vBW4hnr5S
         Wwd7JRGlDpxRApNvYGqdYJTw5cp9YcqUfDQc/TIVMgRDlka65hVYE2FOShOrUBndknhe
         SUFbY/sMk9GRzlFzzWXgi8UylYAQNjstEOlco1Ge/lPB3homOMvCIT+s0JTlNSGYdxnr
         UDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675302; x=1791280102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hd2pDaQuHkOifvuoX51kyffsT4qd3/Uun46tkq8lzb8=;
        b=iKK87k0XlBwqB/3+iDfV1/0/AWJCItqenPUd1BbXvupKUQ+sOeObOggdyqGOHrHRw2
         hUy+OrESkugioGxMDFEWWX8bYrtadk/S18v8q/ofqbWnpHOqNkqkDLWqqn9wGLyBm0jH
         L1waDuKWe4VXirRJvxZIq2rbba3DdLXFJ9oUXDhfggh6CNbKZuCLHWVw/wlX7WUTHwex
         DBGmE3yaU4NNYMbIypkFL5/HsxA2tiKljZ6FU8gWZdj663Zan2u9QP1elY+nx+a57ETx
         u/m/zYHDO6HA5p64v9Z18KZ6VuCdcofEWn5XP+UO+GE54S7bUlotgIZ849WqfNhxFe9L
         gK/w==
X-Forwarded-Encrypted: i=1; AKwUvBxmrpfbJDf5ZSHX8QcbGrdOsoHVww4HiwM/pCAPxTm/iKx9TIZXrU8uig8yaVsxV3DFmEOmy0XwcX9u+K+lDA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIlPMdvPCNMl4SllLYLYQxoX861FuEmo2jC1CHwkHfWSXgwYMnq
	VOI6ehxZdZyETh6P48g5owfzp7bwXJqAFWKDe3OUMZasQGn1hMaBds6J
X-Gm-Gg: AYBFou1asvykvzkjtITADv5Q/WLmQrs9+7MZiRSoAro8ZWYr0OJtkF+6H2g55S7UHd8
	nVAH5xEw534EuaCPnr2Yy+MWfjiZKbVfVRQRn2Zj82tFh4TSHQsuYn9Hyid0ZP+kM7Thj5HOOLw
	6+D2JtntvcwmTYJ/SMUxI3APwTJXNshgk+WBoMABzi/GeeS0ftG536UN+uklUUjI1O+UZU0Gft9
	3BeWsR4n9x50XFpbsF+yDJBpZ1Fwtgj1SvUHCnzfWLLfKsJdHApUd7sXD2KKnEnz+/tFgI4+j7w
	3LJSqPOdo/qA5k6Eaxo7jv+nONvXKcOA3GEFi1eznFecxfuVd+YncuYvrEJpTGWO/L2JCGqUJLt
	mk2uS1gBxtlG2iR0+++n6lFhd7Guw3wmDRLdcVm689D5vYjTbaREpZECnGUnW7niQxfm4N8SKa/
	gPFBl3rOPzCeb3iqw3p9SPYd0t9eJLmSEaUxzbTHa1a9TDrL94BS+AxBpeS8YnvVt9VYKN69RXp
	rKMwDzOOaOlY0snSLKDwRNnhzBr1wZPv9tD1sCi+ZyhYKn2IL/voxRTdNNtLdunnFh1uQMAL+/u
	4hT+
X-Received: by 2002:a05:7300:cc1b:b0:327:e68e:3230 with SMTP id 5a478bee46e88-342702c203bmr16200118eec.10.1790675302090;
        Tue, 29 Sep 2026 02:48:22 -0700 (PDT)
Received: from Mac ([2401:4900:88cd:edb4:3499:f422:21b4:55c7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm31447320eec.10.2026.09.29.02.48.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 02:48:21 -0700 (PDT)
From: Tarun Khandelwal <tkhandelwal32@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	virtualization@lists.linux.dev,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	Tarun Khandelwal <tarun@supabase.io>
Subject: [PATCH] fuse: propagate SB_POSIXACL to submounts
Date: Tue, 29 Sep 2026 15:18:12 +0530
Message-ID: <20260929094812.93374-1-tkhandelwal32@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tarun Khandelwal <tarun@supabase.io>

fuse_fill_super_common() always sets SB_POSIXACL on the superblock, but
fuse_fill_super_submount() never does. Submount superblocks are created
from an fs_context with no sb_flags, so the superblock of an automounted
FUSE_ATTR_SUBMOUNT directory (e.g. a virtiofs export containing another
host mount) lacks SB_POSIXACL, even though it shares the fuse_conn, and
thus fc->posix_acl, with its parent.

Since IS_POSIXACL() is false on such a submount, the VFS:

 - fails setting POSIX ACLs with -EOPNOTSUPP and hides existing ACLs,
   without sending any request to the server;
 - applies the umask itself on create, so default ACLs on the server are
   not honoured for new files;
 - skips ACL checks in acl_permission_check(), so with
   default_permissions (implied by FUSE_POSIX_ACL) access is decided by
   the mode bits alone and restrictive ACL entries are not enforced.

Copy SB_POSIXACL from the parent superblock, as is already done for the
other superblock fields inherited from it. It cannot be set in
fuse_sb_defaults(), because fuse_fill_super_common() checks whether the
flag was passed at mount time to decide fc->dont_mask before setting it.

Reproducer, with virtiofsd 1.10.0 started with --posix-acl and an export
containing a nested mount:

  host# mount -t tmpfs none /srv/share
  host# mkdir /srv/share/child
  host# mount -t tmpfs none /srv/share/child
  host# touch /srv/share/rootfile /srv/share/child/childfile
  guest# mount -t virtiofs <tag> /mnt
  guest# setfacl -m u:12345:rw /mnt/rootfile           # works
  guest# setfacl -m u:12345:rw /mnt/child/childfile
  setfacl: /mnt/child/childfile: Operation not supported

With this patch the second setfacl succeeds, ACLs set on the host are
reported by getfacl on the submount, and default ACLs and ACL-based
access checks behave the same as on the root mount. Tested on v7.3-rc5
in a QEMU guest.

Signed-off-by: Tarun Khandelwal <tarun@supabase.io>
---
I wasn't sure whether leaving SB_POSIXACL off submount superblocks was
intentional. I would have opened an issue first, but since the fix is a
one-liner I'm sending the patch directly. If there is a reason for the
current behaviour, I'm happy to rework this or drop it.

 fs/fuse/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9552be36..ef3c7fac4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1629,6 +1629,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	WARN_ON(sb->s_bdi != &noop_backing_dev_info);
 	sb->s_bdi = bdi_get(parent_sb->s_bdi);
 
+	sb->s_flags |= parent_sb->s_flags & SB_POSIXACL;
+
 	sb->s_xattr = parent_sb->s_xattr;
 	sb->s_export_op = parent_sb->s_export_op;
 	sb->s_time_gran = parent_sb->s_time_gran;
-- 
2.43.0

