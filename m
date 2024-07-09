Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38982158A30
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523975; cv=none; b=o66XyMkz8diydgGBOGzrfH4ThyahaoN5AEpd71maJCQlk0YebyPwEw1pEMY+3+52KSRcAwJ3cEGYdf0Do3rMgZTSfodQEgwq6JKagc9EBYtrZrnrggiqCPuQd6pBPy2dwaLcVsUqqov/fEmDgY6mHJXXDr6AVKjHC5KiezZjBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523975; c=relaxed/simple;
	bh=c6/xDqIBUH9kZJ3dSSFqPpC8zcL9m+9ITWVHyL9+N9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GR4hkhmPVA946bpxuLM3KzInI0YfFSjjdVA9Bc5LIFEyVNjkB4qFHjBk4PcpUDmn7xEOE2YQSOKIwyyIcGTu/moEoY4sJLh8kBw1CXxLw9z37PjJ9iN+QsfU/mNkGQq6vCirIvRkYOkf5jWXKrrDNACB62uMv+jpa79TdYahRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLAJYZTX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLAJYZTX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720523973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9cY1BbeC8V5UfvyXbcs6HntSp+BaCe1he0FDoMTU60=;
	b=gLAJYZTX4QwwO+YJfSnE8zNzRQgM6Q4uayM52mfmumrfn4LAETehesGed3Bi5qpdS4CQte
	m0pBJs7qtJ64myhVSp+gCzRopcWaOi1cG3w4Ty+c3uJOtbCosRT2MS/cRuxujhVY6HvxX6
	cKVr+d+c/3m9EMmndgP4ICrNKwRakEU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-_i6J2N2cMI67Y8BR_s3h_Q-1; Tue, 09 Jul 2024 07:19:31 -0400
X-MC-Unique: _i6J2N2cMI67Y8BR_s3h_Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42668699453so20046375e9.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 04:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523971; x=1721128771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9cY1BbeC8V5UfvyXbcs6HntSp+BaCe1he0FDoMTU60=;
        b=v10lV9m5Qhj/F3UxIMWDYcCNSXhKet/EO6syE4qyDsiDpBNZUKmcDghbl5K4zRu/Up
         WiusafYOHj70Vdc2TTGxiFnVfQ8qCarIdjAZpqKOok8YAzLNwx/sLwjCg3tSPNsWghDq
         Z2vugx21z/lvWDX9uBduoDGlEjS8LG3vsiATe0r0CH1S9iBZDweu9doxsHBltdYskbKY
         6rYRzVkwBiMCv9ZOk9tjslsKomgkLOFDpEcoFW9qB3A9+M6aNLIIDbRkmjHPSac87aRB
         kGvEz/P54FAiJlocbPMHVaBwsHwHHO96XjMVWNM6Zu07yWHqWWRuY7kUfp6AfjlOmvQx
         fiRg==
X-Forwarded-Encrypted: i=1; AJvYcCXLCb/yOaw3SR5wHum1E8atF7OdwpLZpRkvKO1Bt8K8nwVplKjy/mhrfGnDZ5+LOh+delvME+6xzl/cOmIug1R8OyHsmYcSwia3ncRlOKI=
X-Gm-Message-State: AOJu0YxAZwU2p6GBdwE9ic9nkRs7lIqxKqw/WQBCMePIxyAKMK4FAiwi
	su5sbw0erb6Vs90NlFSwXAstgIUh6ywULsLsjNmW/Ai3NLPdo57Fu0Xt76GZPk2Yl2AbSgVHYt6
	+ja0aKOSdR2bFXncD0jQ5mlxKgX1jkSUAhAhSsRdRGD5FiIOj3iafynj+FUHYIOZX
X-Received: by 2002:a05:600c:4aa9:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-426707cea49mr20583055e9.10.1720523970701;
        Tue, 09 Jul 2024 04:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrv6eA6i9gD88/LrJNrSNZthLrsY3bNl7E4tsBwJPh0TpR+xUYGQAK1zetmlYXCP/zrmOVNQ==
X-Received: by 2002:a05:600c:4aa9:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-426707cea49mr20582835e9.10.1720523970311;
        Tue, 09 Jul 2024 04:19:30 -0700 (PDT)
Received: from localhost (p200300cfd74b1c2b6d9a10b1cecd2745.dip0.t-ipconnect.de. [2003:cf:d74b:1c2b:6d9a:10b1:cecd:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab106sm2254684f8f.103.2024.07.09.04.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:19:27 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Hanna Czenczek <hreitz@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 1/2] virtio-fs: Add 'file' mount option
Date: Tue,  9 Jul 2024 13:19:17 +0200
Message-ID: <20240709111918.31233-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709111918.31233-1-hreitz@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This new option allows mounting filesystems whose root node is a regular
file instead of a directory.

FUSE itself has the more generic 'rootmode' option, which theoretically
allows mounting filesystems with an even greater variety of root node
modes.  There are two reasons why we do not let virtio-fs provide that
same option:

First, with FUSE, this option is supposed to be set automatically by
e.g. the fusermount helper program to match the root node's mode, no
user involvement necessary.  It is easy for fusermount to stat() the
mount point (whose mode must match the filesystem's root node mode) and
fill the 'rootmode' option appropriately.  In the case of virtio-fs,
however, mounting is often done manually by the user, there is no helper
program; and I as a user find the simple '-o file' preferable over the
more cryptic '-o rootmode=0100000'.

Second, inode modes other than S_IFDIR and S_IFREG have limited use with
virtio-fs anyway:
- Device files are host-specific, so passing them via virtio-fs from
  host to guest (or between different guests) seems rarely useful,
- FIFOs and Unix domain sockets currently do not allow communication
  between guest and host (or between different guests), which is really
  the only reason why they would be used as virtio-fs filesystem root
  nodes,
- and symlinks in general do not make much sense as filesystem root
  nodes.

The more generic 'rootmode' option is therefore not very useful for
virtio-fs, while being harder to use.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 fs/fuse/virtio_fs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 1a52a51b6b07..ba1a6ac31000 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -107,11 +107,13 @@ static const struct constant_table dax_param_enums[] = {
 enum {
 	OPT_DAX,
 	OPT_DAX_ENUM,
+	OPT_FILE,
 };
 
 static const struct fs_parameter_spec virtio_fs_parameters[] = {
 	fsparam_flag("dax", OPT_DAX),
 	fsparam_enum("dax", OPT_DAX_ENUM, dax_param_enums),
+	fsparam_flag("file", OPT_FILE),
 	{}
 };
 
@@ -133,6 +135,10 @@ static int virtio_fs_parse_param(struct fs_context *fsc,
 	case OPT_DAX_ENUM:
 		ctx->dax_mode = result.uint_32;
 		break;
+	case OPT_FILE:
+		ctx->rootmode = S_IFREG;
+		ctx->rootmode_present = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1401,7 +1407,8 @@ static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 
 static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
 {
-	ctx->rootmode = S_IFDIR;
+	if (!ctx->rootmode_present)
+		ctx->rootmode = S_IFDIR;
 	ctx->default_permissions = 1;
 	ctx->allow_other = 1;
 	ctx->max_read = UINT_MAX;
-- 
2.45.1

