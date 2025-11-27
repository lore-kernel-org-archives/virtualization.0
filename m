Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE96320A29
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229670; cv=none; b=nX5gyn5T4oq2Dr0RkHGHTLQvo283+tgBf8OBvhEnsFkjVHcTrshLlZ7zxmpa2NYUlAaDtmt0/fudrgwIVQKYQXtO86O7IpZxGphIoXAHcXalpD6ehUNHZ20jEs1UVoKkKmObFJJiOCk5njRS6t0ivrIrRPKai0fQKx5+GrVg6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229670; c=relaxed/simple;
	bh=ngrprkAcK9o71FbUOC3NZ7RyRN7JcMdikXQcWlHlTQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ev1N2lck9/2TLQPE1UCUZmAmRdkx4UCPP9sCrooJlMkv2KlPyzo1T+wgt0D7VftizkYnuvirCF4YeawttmNjlpGBJJkYcEOtfRY3titgGIjKSierdjsRtHNsvmIWnGy3OZBID+JIQDHEGlyGpUGdfaQcSz1y/RTbyvBhOSmmjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCE0sPl0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCE0sPl0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297dd95ffe4so5165275ad.3
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 23:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229666; x=1764834466; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdjtlHAU46wbJRJNPh2vrdaHOqMf+PZ2xHKsN6+qWOY=;
        b=FCE0sPl0UuwHJgN327T48H4Se76oYfJakiD9MFvPO8zNi64+smYP7pERdObQ+Y/LBW
         78To45PDq4Jl/ZiPJslu4tN94xhTdCB0RTv7MCEB/ALXlpbz4N6626HRovH85u+SIGVT
         i0PZqWu0pR+xSegK9sBi+jka9u8Ic/OMjRa147PCuQwlvS0SCP17+997DOMEGjyyb3/h
         xttgZn3I5fdCvPwfwi8CqgqqhFmUWnDkOnowJi8FcGhve0M6q20KWN11R+dyLhB9+qJ1
         z1+DT4xQvmKcPer1MtQEzcd2Bs5B9I+5VVyFhob+Dfoe2dMcnjLf0l2M28e/r16Hz1ty
         KPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229666; x=1764834466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wdjtlHAU46wbJRJNPh2vrdaHOqMf+PZ2xHKsN6+qWOY=;
        b=SSyOH0wLvUkbvtqq9SeoIkUROYrgZv7hjP29DFQ01flkKmjI7c/1jBJdoagYMDizKp
         0jbOwMGOE+QI3403Kxj5SQzU93veSP39DI9iYyYw21GJIzO+h8JyjFLsnZJQKTH0laXW
         DG7Qokwwa75H+xGyvMckHFpFhRrYKtuRTrhxS9EDTjQOYyht9iEhPGDYpxe9FxCWM6Iy
         yeYO/ZhJ6abnm7ixsK5C7aQqy8wv9bnqLTD5oSW58vMqWRsEkp99hLRx4XR2OJEImU/T
         iYLpUAJSCnMg/9rJtlMj7/yi8Uhwp9VKTLfsG8Ax8F449kk9aH8BW8EHxApdal9uwnWl
         r16w==
X-Forwarded-Encrypted: i=1; AJvYcCW3y28pF40bF0wuwOdFG9yReknDTy79AZlUCZRAzxti6UpKAtRgpZ/VhSuQXFmgOxbIGqQoFCMb0bzdmCZEFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ+E6baHn4AAStAxSsFvxFgda1WALfnEeFFITmVTSW/j/8LBbT
	qPDEq/WA6sLtbjt5g4QYRGdfmw/OzS9mc6MWZ711VtICWEwidkF41BRX
X-Gm-Gg: ASbGncuQ2NDTpo2ueIYdnScBdkY+wKqfd15hsFrLVOAlLFncGP/OvI91kPd+sqs3L8v
	V4OeZYbGEUVsDDkjF3cVtp17SS0dcfCnWBDnomCW74ee5QvavjK6cNSaMjNwHud22Io2TpAc1NO
	xkGwH9QqkMpvMsT5ma5LnK/cCe/wUkPpaEUSDkwH/AT6JkkaOq4ggaCDG08O8HYNZqiOyDJ0DvW
	M5AjkvPgLpcfJZwVW0+v0p3Gps2oUDtqvV862aRMu6Y8AfUqSBJ0BGTruxVnVMeug4bnxCr9u5o
	CyGkx50u1hR9MorarBgWB84zUizRTWg8dWwI+ba1iGu3H34x71m8yZRWWYy5SpoTfxJG7n+ZaQK
	cU+jnGd8NRu59X+Qw4abVoW/VtXrY8S3HymO1gIMcLGeaSxw2sknzObKtBo8FtJaNNbAsjHXOc8
	0hu3xLU1JoBGkY8zOEWSc=
X-Google-Smtp-Source: AGHT+IFYvO1UtpbFl//by/z1SxVW3RV5sMUL/B4xccNDs4++DXCvOjc0LlmnAs3s4Ij/sBDaAEebvg==
X-Received: by 2002:a17:902:da82:b0:269:82a5:f9e9 with SMTP id d9443c01a7336-29bab148972mr111949915ad.29.1764229665894;
        Wed, 26 Nov 2025 23:47:45 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b1cbd8csm965410a91.1.2025.11.26.23.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:45 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:32 -0800
Subject: [PATCH net-next v12 03/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-3-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- move before adding to netns support (Stefano)

Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e6391eb7cc1b..de71e2b3f77e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 

-- 
2.47.3

