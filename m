Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE0B2D77F7
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049055; cv=none; b=bOQLLYBUHU/CI5m3DCitPAlf2xG7jNfIqlxyKGp6y1u/lhKWQrkiY69kz6XAsrkTuE1bGmrV9lr9leK9vyRsHaXc0EcDfCuVZHSNoHUFqoC89+nKB5cg4A94L67Pfgp050bhZ73qubu/ozLuZ+RZTD/IlwczjGI2Y0qgDIB3oMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049055; c=relaxed/simple;
	bh=8jAVkUMH/+u3VOLZBfozegkzfmtTLIRMJxxRi5VQsQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=KB5V3ky727rlrCKqG4FrV2JA+lhz7pR6+TnfbQe15/PKVmaZpnN3IyUyJ1qWJy+M1jbNOG1Y3YIhKS5DmUAhSRINwJP343JujygoLuwTbpI7pzmq2liiYiaiqIUv7OqlJxLPZMN1asKsZXhTS7alzUErgbDXJ/q5DyIQV247hCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBmH680o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBmH680o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bCWN2qWia5U/NhXPrwUuTQXMXPl3dg4yyzToKGFJy2Y=;
	b=fBmH680ob8oCViyxmTpaZ4HMloGEnACvGF35IgxJSByN6P/cS0zsbV9ecXPl0yJ4eQiONr
	lQtxrLoFih7O9Xjh0130HWja7aFx4hmaBa+h5QIHMDMOBvIHZfLRU+0JgPukl70tjWZezJ
	fr7WvTqcYVF8P7TuCWRYjquH1uoi1AA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-bhT2m6rRPwqmCb4ovuBpwQ-1; Tue, 21 Oct 2025 08:17:27 -0400
X-MC-Unique: bhT2m6rRPwqmCb4ovuBpwQ-1
X-Mimecast-MFC-AGG-ID: bhT2m6rRPwqmCb4ovuBpwQ_1761049046
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4283bf540ceso2212146f8f.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049046; x=1761653846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCWN2qWia5U/NhXPrwUuTQXMXPl3dg4yyzToKGFJy2Y=;
        b=T4j3UmOE5VoK/4KJaAI/bk/IDwVC78g+XrwLv10hgzsIw9qtdAdtq7ZpXPF5C+LVrr
         c2sgHGaSW/XzpFSYpwPOHdFZggh1Kx+0g8ODYERk88La+GgA4dnR142gglzX7E8cbmGk
         MtFsC0EqgndmV86bG4g4Udol2Y1vG4FF3ehkAGZdZRWWUeV794DHKAt3K/djki4BJlx9
         C+Exv975uT3608OfShFShafyBwP7o/UpBHLYQqVAVztC8+j6bwQFjRtzwZXsxjdnNYpb
         Mq4w3X5SvNxCyhbRnFwDUjcczQAf0NSKvEFsLO/tJ/zYG8PdYygLVBE3zc4ROgxK10j+
         FLVw==
X-Forwarded-Encrypted: i=1; AJvYcCXs/KdfZ9G+eEaPLPupXjD9z5RP0/q3ZRq7zrVkUGLHelZR5y/o0ftTO/gdpunSv9sAlyAPt1+JLvUVdoX49g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAAp7JJbpYNCvaE9NClZRzTzsDz1tVoZ1Hzf/fzhilQVvl2JTE
	j02EqlbYaGQavj1iEl6Zd+tGA3TNu9hTnHxILm7+D0hJXMI5xxH4PZUURpyR392GCp2JDduilwI
	MlvLhkSFFquPbYijmTFXkko+lAcqHiTKcKswKBUG0TN1iKJpRLVWZuzQMgfRlB0Lf8hFl
X-Gm-Gg: ASbGncvsVZwAMNgtWYdI01Dsk5CaDSzyDApyChNa//zXa85pkNoAiayEdCpOiL0dPjg
	OHu8ryo+jFErU0DBCzuN8OMREHJVPp8VX/IrzIyVp/GfgiRPyX9ABbxIEfGDxA8Um0ht1rBvNlL
	LnabJM1I6h/9hTZEAUkG0saS8+A5FpJUW+evy/Yn7fQSMivlN/KmcX87lOfkgYlRuouAC/p9799
	UlPS24qQVUvS5MckeRmXthBZB9nyN4TiGi/ZZCBBKDy0xQw/XnUQyq0o86P0CKMZUV71oneV+J6
	UIvEsSVJxhj77ssnF2Qlqg1RVjCppt2YUtIdDvBUdpljEzhbw3hvEU7VBXaGSdHWvRBhuyroatc
	9O0ogeag0ALIKk/VcGAYIvrztrGPy3pB7b4xYv+qteBIrCezigbbn
X-Received: by 2002:a05:6000:1867:b0:427:6a4:93da with SMTP id ffacd0b85a97d-42706a496dcmr8994712f8f.49.1761049045867;
        Tue, 21 Oct 2025 05:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIDzVJ2UzNuMp+C3slOnSBweFytGxnRjkV0uaR+1r+JrGCQpAt/7Y9bGWU8thLnHIYoiPCxA==
X-Received: by 2002:a05:6000:1867:b0:427:6a4:93da with SMTP id ffacd0b85a97d-42706a496dcmr8994691f8f.49.1761049045378;
        Tue, 21 Oct 2025 05:17:25 -0700 (PDT)
Received: from stex1.redhat.com (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm194606535e9.9.2025.10.21.05.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:17:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev,
	Michal Luczaj <mhal@rbox.co>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] vsock: fix lock inversion in vsock_assign_transport()
Date: Tue, 21 Oct 2025 14:17:18 +0200
Message-ID: <20251021121718.137668-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u9QUW6dkidqr8uP7EcgsiYHEE5xXCJyD3dhgWqyyeC0_1761049046
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

Syzbot reported a potential lock inversion deadlock between
vsock_register_mutex and sk_lock-AF_VSOCK when vsock_linger() is called.

The issue was introduced by commit 687aa0c5581b ("vsock: Fix
transport_* TOCTOU") which added vsock_register_mutex locking in
vsock_assign_transport() around the transport->release() call, that can
call vsock_linger(). vsock_assign_transport() can be called with sk_lock
held. vsock_linger() calls sk_wait_event() that temporarily releases and
re-acquires sk_lock. During this window, if another thread hold
vsock_register_mutex while trying to acquire sk_lock, a circular
dependency is created.

Fix this by releasing vsock_register_mutex before calling
transport->release() and vsock_deassign_transport(). This is safe
because we don't need to hold vsock_register_mutex while releasing the
old transport, and we ensure the new transport won't disappear by
obtaining a module reference first via try_module_get().

Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Tested-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Fixes: 687aa0c5581b ("vsock: Fix transport_* TOCTOU")
Cc: mhal@rbox.co
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..76763247a377 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,12 +487,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport && vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -512,20 +526,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {
-- 
2.51.0

