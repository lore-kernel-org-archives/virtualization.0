Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1A3AD526
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096854; cv=none; b=mkvPcQ94Bdjz4MTgYMoSVEASNgHxn/YawdgWV74azgIaaRAczIH7FEHcVDnE7xi5ciJB3H6+tJfheUwnNhAsCfs3S5a+wyNdNflLY9jVVh6xXArerWs6x0/GQon04zaw8fJsO186M6m7Fq9+DlDA27tJvwM1AZNpIM0KBPL6ZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096854; c=relaxed/simple;
	bh=MCXM2XKBVlX/EwXo9DZCvLtvoatevzZ4S5wRf3peb1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYJzZGY1hzjCfRrrT8orqfqucIVUkBJC18BdqrYMRXmqCl/L05obHF7xm1JdD9ES279c0oPrg6p25G0YslbrpkkMCKy0Bt1wYoEtvYcbsR/opjjZdidBRMC6YvhAdaHElv9ALqKA01zH3e/zraNJXcDtGCF8cXx2iBbbmkcW680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYKf00hp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYKf00hp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce98cb8165so22134925ad.1
        for <virtualization@lists.linux.dev>; Fri, 07 Aug 2026 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096853; x=1786701653; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXJlW9JsusO8To5K56BmONAgJx5Sdd1b4tle9i9ZWE8=;
        b=AYKf00hpcQ0iDfJkJkFDjyxUzWUuMP8I4dVN0eD3aGWadY3rhDbEB0ommrv68KwVra
         QvwNMFsj+YP7pfaMPFl4ccyseBN4p3pFA6ODyNM6Ax8xqgoU9O+WZbamPXHlQaDBblPd
         2ZO1Cg03iI+QfJvIuCJCQupQblt+BUS66XlPECy3bmSHXt/ZjjhOmi+CmOVo3MJN6GP8
         Yl6gIxV0pva+swdTnqIRE9VblsBqkwyZ9Cl9kTtNgQ6mSHoParbiZc7m2cLhsg9chJ85
         vzf3OFSDM/gP3l927sqiwpmhrauNR9haWWZkgtCIy0MJSEX9OmgLSJ6Lvi0div/rDguA
         UTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096853; x=1786701653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXJlW9JsusO8To5K56BmONAgJx5Sdd1b4tle9i9ZWE8=;
        b=NhgcHiwWjNZ6nZ8TpFuiCaMBoqoyGQLtXslL6Nh1lFOpqdty95KXvZ7bQZurZyMJUD
         s5pfIuWfKEF+crfemUDBCKH5GM9CKo1U3tWRrJOH3Lv8yy5mGJ8cLVMSnxwa7MhKhq5P
         dJpsDEpAJPLWEAsINq/n8ehHfvAzrWOPTVtfdk8DiFqoaYMcVsDY4wv5ojZkNXffTRdg
         JFkHJS2zlHxy2AiUAB5wsuXYDV4Ku2k+anSnpPtTK1A/0CzeFYTZgYw90dfwlK+cI8lN
         kkT3i5CbNCIQkpZli1ZJwJaG8bO4Gw/4TUauGOYTStJboglWFbH50rnyW+4DnTBmatLQ
         SKDA==
X-Forwarded-Encrypted: i=1; AHgh+Rpz3A0qP2oLyLbEj2x2dbPF1XWBlTCaBhPEBVxBHfdR9F3C4TJCSuW4MgMODKrs+J9FwQ8yH1uQ3lJSM8cuXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWnag0Ltz2NDWJMgxt2dDaJvev7mAxRHW82JKhblEAEeKwmbTE
	FCRQ2+AfpW4k8x39cbMAY6iSq/AkQHu799+EMdpA8v8Oc+ofmwWGPKbA
X-Gm-Gg: AR+sD13b6FdRQv23VxuSNu29u54A2PcIGwhl+r2gQXhVi02VJ+7+iSnybiNUlkkKQyr
	BcE9IMP3UChay7MK557zfFmqLiT/Olg+aqtOmU3UKQvVjO6W5u79LljMHyeB7t38pohx+ZppQr4
	b3MdoZBZFU1ku9JVJ7VoHCW2KTIGOh8t2wqcOv3Qk8v6n6HaZWjlTo3zH5wNN3SM1SJio9iSlK9
	SgianHlXmrVS1kiIo/RoJ8ZxCmj1GEwPNjGVppgECQlfctKWBN/XZGuPou8zqbfRi4AGVrguX58
	w0TxJL4zH1Ucr+bfbec3+WaY6dEVcBP/bfMjGDuO+ueu0yUhOTswaccFKULPHGVIRj5d2Pd5Co3
	rtbx1F3wE+X7HjUex6JhcDjuD8HjlKjkKHIdvzrcQrFiYgBUxz43JCwWfotBznrgi0gBQlBhIqe
	xMPRgyLbPLjhvdViy1v40t/kVxbChCwlogh9+d/GFqXVA1EElQ8KgiLnj6Um1U4mCx+6VP71evS
	swuSuOR1tla876DRSmKtWMDj4LEYjg3XOS4zqn+3qp55GOZ4Kh4IUA=
X-Received: by 2002:a17:902:ce0c:b0:2cc:89ce:2f07 with SMTP id d9443c01a7336-2d0f704ca37mr63534455ad.1.1786096852750;
        Fri, 07 Aug 2026 03:00:52 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a9f0fsm6500035ad.68.2026.08.07.03.00.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:00:51 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH 1/2] vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
Date: Fri,  7 Aug 2026 20:00:24 +1000
Message-ID: <20260807100025.19750-2-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807100025.19750-1-yuz08559@gmail.com>
References: <20260807100025.19750-1-yuz08559@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vdpa_set_config_call() swaps the eventfd_ctx_fdget() return value
into v->config_ctx before checking it, so on failure the field briefly
holds an ERR_PTR:

	ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
	swap(ctx, v->config_ctx);

	if (!IS_ERR_OR_NULL(ctx))
		eventfd_ctx_put(ctx);

	if (IS_ERR(v->config_ctx)) {
		long ret = PTR_ERR(v->config_ctx);

		v->config_ctx = NULL;
		return ret;
	}

Commit 0bde59c1723a ("vhost-vdpa: set v->config_ctx to NULL if
eventfd_ctx_fdget() fails") added that clearing, and spelled out the
invariant the rest of the file relies on: "we consider 'v->config_ctx'
valid if it is not NULL".  The window between the swap and the clearing
still breaks it.  vhost_vdpa_config_cb() only tests for NULL, so a config
interrupt delivered inside the window hands the ERR_PTR to
eventfd_signal().

Check the fd before installing it instead.  That closes the window and
matches how vhost_vring_ioctl() handles the same failure for the vq call
fd.

It also stops a rejected fd from tearing down a config interrupt that was
working: until now the swap replaced the live context and put it, so
after an EBADF the device silently stopped delivering config interrupts
until userspace installed a new fd.

Fixes: 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/vhost/vdpa.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275..e5e47f6 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -529,18 +529,14 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 		return  -EFAULT;
 
 	ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
 	swap(ctx, v->config_ctx);
 
-	if (!IS_ERR_OR_NULL(ctx))
+	if (ctx)
 		eventfd_ctx_put(ctx);
 
-	if (IS_ERR(v->config_ctx)) {
-		long ret = PTR_ERR(v->config_ctx);
-
-		v->config_ctx = NULL;
-		return ret;
-	}
-
 	v->vdpa->config->set_config_cb(v->vdpa, &cb);
 
 	return 0;
-- 
2.43.0

