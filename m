Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F853DD863
	for <virtualization@lists.linux.dev>; Tue, 26 May 2026 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792270; cv=none; b=V1KzY2i5nSlHwbfEV7pFd2eXxdh1RbdFoGfE5tMFl/vf0/IN7Uj/NqO9FwBAl2ulnIC6kZ972+HiiAEQ0r82GuVnjT7UiZNDZVClRWCXAEf7JCVGl7HYMNJdUacq73w5GPJilW6Cww2wv5yjtlskiQKl38x5u1iJGtD/t12J4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792270; c=relaxed/simple;
	bh=mRpirCObCLZqN6l4iv03pml9AZxIqV3ehKRFmi90YGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fgf2+UwuePf5gtTCD+Vfpa9DRc1DB7CBwi5+A7Lr7/NKtK/XVdyfQpUK2AUo7bFh6q46eS6Kjcyy40Qy6F0OpQ2W9sX8c38r3Z2+5Q0hPV+Sj+flMB8EZNcaAyaiFVMMfVOhixAafpvS3X80hQalBZ4AO/8WPPJ16xFhcUpV+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs+acFLh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs+acFLh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83ea84df1d0so3442100b3a.2
        for <virtualization@lists.linux.dev>; Tue, 26 May 2026 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792267; x=1780397067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsmUW9tamcq3E3x3Xj8H36QoMdq6sDlAu1sIPsLwdow=;
        b=gs+acFLhr5XsehvBI54BIpkETkHfFNHAqapJTKVZTqtbO5Nw01MUr1549b8aMY0TmT
         0DI/6VqiXM/vzk/pWGANOMtlpbVJb/pUYwxbgRLzw9/WEXl0vtOmOoxwMLuzAPvneWIp
         c2TAE2JHYl075oUc+lZ/+gEHFLsUxq0X/1bhxBPCI89EXmWuEHJ+MGxoPwovkSA3vNB/
         j+PlzkhJJEF3+Rr4d7MKMZI2CGap42+p4CjEPF3idOiVpHfnNzhIH4eHX5ZcR8A1OCX+
         e4apZmJ0YJ/qqa6yMl3xZt0eub9kB+BWpqV+lDV2grLXK/qixOkAaX3G3XOAlS4CaPR9
         Dcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792267; x=1780397067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsmUW9tamcq3E3x3Xj8H36QoMdq6sDlAu1sIPsLwdow=;
        b=Gfup7sj9wj2ipMne5Gz+CQAwefG+P6VuElhHvRo5poU/WuHweriV7Xbg1hGc1YDc7v
         86hkkWMSyi/Xj+O+QKvANf/U3FFLol+oPx++sZ5PRjX3zcpnAjyB5+w8IA85XVLLM7Cy
         RZXqplovuDTS9p3Z/JXn+DfSfndEYxusPblyTXPPfjY0fHJyW4Fmq3WhxMK6v+bQraEn
         Qkv9/fFalMoVsmJCQrIOegZULWYnIe6wUThp9KoiLa/lwg92evdLNV05IQnBwCZeEE4+
         kL9+SoQlSyi6H6GSL+9nk0D34GDSxHXlrEV2HTDN/cvIV5p+cdxxuz7P4xkHXOKMzmy5
         /Sww==
X-Forwarded-Encrypted: i=1; AFNElJ+KOLbEhrw/1AmE6mEPL8Wjbfwh8tObB+4msmjghtzYaMsQDTg5Epvc9aoyj5KP6M1dxFrLmxu2p/AZU9zuQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiuE9fx6NfT6rqHpUUxSoRAwZG2fEz+O33XKA3Upv2J4ZHbjHV
	/xJZH498/WVypKSbpipH89o8X6a/XazVONxSKdBHJqHjO7EGr+RI7A8=
X-Gm-Gg: Acq92OHglgDXQrZQ9pYDHRcCYKRBTOWBxFFRh+352jxr33QcuXQvP6mxYQrGt94NzgE
	TfUI1eR5UotVc9QUh9JxhcWMqhua5lW4Zpgb9+pGQCyE6FzRM0CTia5eCWtQLnBXPnyNMD7xyf5
	Y2S+/iCAI9iqAaPYKcw3yfMNVnKWk3MbPQ6lX+m69J+32jO4xUtSyveXX3UoIcKxXyy8hiEu3aT
	80JbZf3HTz4z5I439mfwYo+J8Kec2FAwP4F0Erj6vK5J3G5UwIqCvWFtbwIjdrHZ3Nvqbb4/7W8
	gc3mDY3Dfj+fATGBgemjZIIv5RJskopV6gda9JlWY+QRPMlpiaeCqcKBe/ItYPIfZA1ZoOMFEaP
	9tK6CEQhMpiRMY2gg8C+sGRXJeFauKLMl7RXkaUoBjbhETb+hS+neKE4LKTPwjr/bmJTfZyvXjy
	RjHI3vBdr/w4SkJZuBiYFzuNHtFkjuDXyKkntPlU+HFwijKMKbgMMN6xr6KFTJi6rUXTo=
X-Received: by 2002:a05:6a00:4c07:b0:82c:6b23:6d10 with SMTP id d2e1a72fcca58-8415f580e58mr17482367b3a.3.1779792267413;
        Tue, 26 May 2026 03:44:27 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164affc22sm12235270b3a.21.2026.05.26.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:44:26 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	stable@vger.kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Date: Tue, 26 May 2026 10:43:56 +0000
Message-ID: <20260526104356.469928-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When vmci_transport_recv_connecting_server() returns an error,
vmci_transport_recv_listen() calls vsock_remove_pending() but never
calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
permanently.

Repeated handshake failures (malformed packets, queue pair alloc
failure, event subscribe failure) cause sk_ack_backlog to climb
toward sk_max_ack_backlog. Once it reaches the limit the listener
permanently refuses all new connections with -ECONNREFUSED, a
silent denial of service requiring a process restart to recover.

The two existing sk_acceptq_removed() calls in af_vsock.c do not
cover this path: line 764 checks vsock_is_pending() which returns
false after vsock_remove_pending(), and line 1889 is only reached
on successful accept().

Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
the error path.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/vmci_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index d2579380f5..88ccc55455 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -980,8 +980,10 @@ static int vmci_transport_recv_listen(struct sock *sk,
 			err = -EINVAL;
 		}
 
-		if (err < 0)
+		if (err < 0) {
 			vsock_remove_pending(sk, pending);
+			sk_acceptq_removed(sk);
+		}
 
 		release_sock(pending);
 		vmci_transport_release_pending(pending);
-- 
2.54.0

