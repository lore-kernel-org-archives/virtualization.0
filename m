Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B8159583
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523983; cv=none; b=Vxzwzt6zwK7cZkKOGF9mtc+IROpMARfRubt98glzitIo0zu8tpb1WDuaZ3SNySLqwLNrNNlV6e8pgzxjqG0SAZmwBpIh+FbyB/a6L8hDjtSTeScwoQ4yM4zq4g8H8pWAqDSyQLMdkLD4lr3Dp1i42RcISEjZqfugvDd6rZndKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523983; c=relaxed/simple;
	bh=Xjz3MTVYq/NAB3daYzBwLF+8t3T7ssr4yfGhYIRspPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/XHds0H2hPnGJ/88Al6sHDul/icf/d1qvOWNMwqTCXuZXQ2LhVzTfbwxs+B+ndQ+UtHvmNtJJpfXPBZtS/hiKPeSE6TA1DXC57LrG2rgcz6F/CL1jhmxgXKW6BR913YL/WbzID7T8/ovrcdW5wLjPMpOxDxJVWIIc2yu/Vkv3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SF2fBBO8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SF2fBBO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720523980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YN0cRtZ4yjTFsrRdrBTPFQCjU2aNbe9nzOGwlrFJ09U=;
	b=SF2fBBO8f3B9X9iok4QBDeOoFdV8C44CFqWuQ2IEey1JEivfdhQhr4QCFFXmRUfb2F5uYb
	P580hRDEkOH6FrgODETebUq2RHabvKlYeJlKvEF58h48kwQCU/Cm9X7UvGDrvHL1b6bMSq
	WmWYuCcqhmCYR6jlj1w8W2bSuOQlDlA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-0ALF5rPnOGmEFc_Vg4aecQ-1; Tue, 09 Jul 2024 07:19:39 -0400
X-MC-Unique: 0ALF5rPnOGmEFc_Vg4aecQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3679e7eeda6so3071630f8f.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 04:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523978; x=1721128778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN0cRtZ4yjTFsrRdrBTPFQCjU2aNbe9nzOGwlrFJ09U=;
        b=mu9fVyLB0JpSjwBe6B4NPz9c5hlvsQjqhoSHNg3fnciDf8sydwtDLDMy9uO6XAceKK
         h6D+pue9nyBEAZIJRB4rm0OUbZHR7iP6lnuvHm2SMNSgxKa+VZgSJGS0O5y/ddUmjD96
         TacZrosKe3I68sQtMTEMMSQu2RMwcIQ06HCRuRqgSUc5YG1RNpTTF1kHXLBVXFYwRVz/
         cAf2AJ034WWVj11UkRbf4WbC05J2xubMQto74vYd0uY6JMkAOwtvM6/qNmEuQF+l0YH9
         aJSHbbUOQV5Vcy1K4E48Sjp0LMYctTF05GdIKbAfyPgdJT5mwG/xgQNunfzsg2fcIVFo
         BNBw==
X-Forwarded-Encrypted: i=1; AJvYcCUttScOyX2Elp9xByQGdinM3Rc8P+caJCFT/wBxsBSC6D/tGDmJh+V7kn07vq5WQhtZ63UhgiSJSf7NLGey4kT80ZvN/7Pvt0JWxPLdS5I=
X-Gm-Message-State: AOJu0Yy6qcCaq776F+7H882LJcqfWXhbOUS6MztlHgNOcgiZW2gTsWAG
	Xx9LfQki4E7odufFg6PNVEpMFumofFIsiQxGYfCrKC7mDZQJgJVkP5Sj3kc+eun7tu1bpiRad5f
	7ouqcVql9p02qW/g+IFzKps0K1AdBVXhyFyeMhM4xvO0wgQfLT33YYDj2wCposntn
X-Received: by 2002:adf:f20b:0:b0:366:ecd1:2f38 with SMTP id ffacd0b85a97d-367cea45cb1mr1566741f8f.7.1720523978453;
        Tue, 09 Jul 2024 04:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoGPU/A2758fnfW+6Bj1ZJdPWuqnkDg1NjoVhU3Nny/eh6gvsNgugn821lvXZApx4Cx1TO8g==
X-Received: by 2002:adf:f20b:0:b0:366:ecd1:2f38 with SMTP id ffacd0b85a97d-367cea45cb1mr1566715f8f.7.1720523977994;
        Tue, 09 Jul 2024 04:19:37 -0700 (PDT)
Received: from localhost (p200300cfd74b1c2b6d9a10b1cecd2745.dip0.t-ipconnect.de. [2003:cf:d74b:1c2b:6d9a:10b1:cecd:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e08asm2270192f8f.11.2024.07.09.04.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:19:31 -0700 (PDT)
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
Subject: [PATCH 2/2] virtio-fs: Document 'file' mount option
Date: Tue,  9 Jul 2024 13:19:18 +0200
Message-ID: <20240709111918.31233-3-hreitz@redhat.com>
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

Add the new mount option to the virtio-fs documentation.

While at it, remove the note that virtio-fs would support FUSE mount
options, because it does not.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 Documentation/filesystems/virtiofs.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
index fd4d2484e949..201ac9ee13c5 100644
--- a/Documentation/filesystems/virtiofs.rst
+++ b/Documentation/filesystems/virtiofs.rst
@@ -43,7 +43,10 @@ Mount options
 -------------
 
 virtiofs supports general VFS mount options, for example, remount,
-ro, rw, context, etc. It also supports FUSE mount options.
+ro, rw, context, etc.
+
+The ``file`` mount option allows mounting a filesystem whose root node is not a
+directory but a regular file.
 
 atime behavior
 ^^^^^^^^^^^^^^
-- 
2.45.1

