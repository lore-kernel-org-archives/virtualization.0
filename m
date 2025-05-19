Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01B265CCB
	for <virtualization@lists.linux.dev>; Mon, 19 May 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638431; cv=none; b=KgBP/Xq188GUM/XSp6YPKKXuMifMTox5bxiNZvgL0+08DRDZDvWDDKOXkrqea9tWq6wYPSgVWScpvTWoETfA1Xm94s/yV982D94B/yWdzuK4F56Zt7R18OR/kKrjwKaSGoqlPAZ7oKO/Wx6Rwns8Nt6EtOfQotSDe6a6H+DEY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638431; c=relaxed/simple;
	bh=eoGMF2Rt9uZ2gIcNe72NFY9+t/U8Awv10xG4k5ShIao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvBgdY/gk2kcRGCmnhBeFMUIX0y/jjVgIBLEYYhuHU0DW0DegaGG3Cvr/XuiPyAOmkayALU64djhOCqZoiICebG2KFs6ymPi1ZPUMic8aFMZt6DSAu6xhDMbUZDhdGl3yQk1We/ZJBXGXVyqGcCvAdOVRRcLswPcjpYtFqEhSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSJkdib8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSJkdib8"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c035f2afso695972b3a.2
        for <virtualization@lists.linux.dev>; Mon, 19 May 2025 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747638429; x=1748243229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHAaWm/nwPVfz2tbZm/P8yaDDY/dUJ8pDKEX+ugzIbQ=;
        b=ZSJkdib8DxcCGzPDdFMXLpZTlMJ2SVPGt/m3pQrtO8T/G8K7UNyXlHSR/vd5HMN9I0
         KpZtykaY/EDEPjeC3N/8jCHMImvJq9NpotkYpv7WWT1rltZp2HLGRcCsVa/FXvCl85gs
         S67lWBpCc0qJ59xYs6jwgS4bZVYReFhySYdto69OGm+upTmOudGjNiQhIBSMqLdP2Z1I
         lmckQ1B0t4VcDJksJnoVvAHtvOTJiMX09VSFqyg0ZKpztFPZ1RIrMzHWzJYPj7t1rD5J
         J54RMIguZcDxpuBB1tDxgosLJJr28RPcUk94jl8A6DzZCIpUTiiFOzZdgEJXOOHBDoGn
         /soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638429; x=1748243229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHAaWm/nwPVfz2tbZm/P8yaDDY/dUJ8pDKEX+ugzIbQ=;
        b=sTGGEUsN7EzSOdCQceqT6YrPYSKFDOp8CxvI6ZwTzV7YbbgNocjXII7gs+qDIzSKoi
         9NQ8hgFA0lvUdVhzKin7YzR/nv2FgAIzONPj6YGmPBAPfGpfOEEjpgI5RubU/LQxpDdR
         Rld/FrZtou4bw67StUhRUbPt67UVIqYrvAOvFSp5RJ1cQdEj2/Lp5Zt4VbxkUw/+7iHe
         NC/jg9RvyYIWH3wz9wU80ZhnLzQ6mWuTjFMYgKD8Vp8ss8kw/U46kh4BRNpgYd2br8z/
         AP9/aFmxETBiqLJc0OCT1dRe8O7GhXpbCpA8e5f24mHLLD72BkBca1gAkWY4gtKCkfNh
         FcJQ==
X-Gm-Message-State: AOJu0YwsZnYnZgGGhLLsP7e29y3ki7lSPjAV/KAvCCXfc7FMWm95YF7H
	BZBQuC9/Kj75k2dJg8aQ6cBpRvQxc8AmvV974JHLj73hmsyQ8e4zYryr
X-Gm-Gg: ASbGncumZSa2wfFn7zR+CXIwx9r52HxCA8HnG8MWqTg/lS++aqppqMRIemx9lkcz7wc
	gO84210Vk3YujKY9f/Szcxvy+VlTSX5oabx7RPIsRdFSHqmrM6RpVXfOsUGFhePlL64oe9vdBGq
	feHNLX2+zQ1y2ESZy2NO83enMK3F8tAbd5ArDUgAkqVfcPiPlN/2dOJnCWfdU0G02YTs0VXdls4
	fcHwez+n4yZgue/zNJegzFwAPm/eQbflkxVoVHqN0FABgifr/kcFBhj5mquh+T4Dp+H0M33Phsz
	AYyYYODN7CWq6btv8+Cmo2xVc+/NROjuikcPdQ8Ju8Y0yl+36fVmfoxE2si8yI+S7q70OMIYTg=
	=
X-Google-Smtp-Source: AGHT+IENpOr+coy+nuUYSAQz1G13SXO8o5nY1ZaRb3QaUw56V4IvmR4mxX3+5YP0g6/vBT3U7sT4sw==
X-Received: by 2002:a05:6a00:9455:b0:73d:ff02:8d83 with SMTP id d2e1a72fcca58-742a9786a85mr17865169b3a.3.1747638428863;
        Mon, 19 May 2025 00:07:08 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a0120sm5574336a12.63.2025.05.19.00.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:07:08 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	fupan.lfp@antgroup.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	stefanha@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH 1/3] vsock: Add support for SIOCINQ ioctl
Date: Mon, 19 May 2025 15:06:47 +0800
Message-Id: <20250519070649.3063874-2-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
References: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for SIOCINQ ioctl, which returns the number of
bytes unread in the socket.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 include/net/af_vsock.h   |  2 ++
 net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 9e85424c8343..6f32a2601a49 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -171,6 +171,8 @@ struct vsock_transport {
 
 	/* SIOCOUTQ ioctl */
 	ssize_t (*unsent_bytes)(struct vsock_sock *vsk);
+	/* SIOCINQ ioctl */
+	ssize_t (*unread_bytes)(struct vsock_sock *vsk);
 
 	/* Shutdown. */
 	int (*shutdown)(struct vsock_sock *, int);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index fc6afbc8d680..288bbfd43bc5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1356,6 +1356,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 	vsk = vsock_sk(sk);
 
 	switch (cmd) {
+	case SIOCINQ: {
+		ssize_t n_bytes;
+
+		if (!vsk->transport || !vsk->transport->unread_bytes) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		if (sock_type_connectible(sk->sk_type) &&
+		    sk->sk_state == TCP_LISTEN) {
+			ret = -EINVAL;
+			break;
+		}
+
+		n_bytes = vsk->transport->unread_bytes(vsk);
+		if (n_bytes < 0) {
+			ret = n_bytes;
+			break;
+		}
+		ret = put_user(n_bytes, arg);
+		break;
+	}
 	case SIOCOUTQ: {
 		ssize_t n_bytes;
 
-- 
2.34.1

