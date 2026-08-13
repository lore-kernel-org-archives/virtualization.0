Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6D383C66
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642317; cv=none; b=GfR3PppZIIigTBtgG1ZiV8XnHMPHL7e20hxjCCbQ4WqBQ+25GSEUR/wxmgXcXtJ6yUhYPHormucH2xZKPhcyZQ3rnnLCp+yuf4OvYygf7PsB1dh3G8CCE7wrqFSmIut3oiLBaBjF6qjhGiC+EwSRSwkGEviqKiNkO9t8aphRcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642317; c=relaxed/simple;
	bh=OK+3PSY7/vVg8tPTstwFNKlug+QDc4pfGSyYeQEKZn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed9dcW7M/0LNiP0ZKrTx0R1oPy7t/OyxFhVARXRnnI56Fbb3GudnDcrLriyVb9BAuDejaElON0KyrKZ6ElOhq2FR+djjbLTzcS0B4XBEcM+DP1+EYuVYl/Lv5C+R299YDEsO2cIipigm2dO7UxA2t+ywrQEHVQFMZzrHktrJo+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY0SwoOU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY0SwoOU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so128419a91.1
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642315; x=1787247115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hHhRM52KdKrRi6gpE3cIbQsE04qBYaQW/Y0DpiPJx5g=;
        b=TY0SwoOU4PSjDLbmhQme3ys+RWEmbVs20n81ObnEMK+rMdMKti6ftK0qD80vZ0gIAW
         zI4Twh1HyvgXT2xByud48rwaUUdlJ8c3VGxKHyYaIvwV73xujqJRjxnHc2k3c3LMS2PZ
         abvS0JK/DAqLz6e5a8xweT67hxtvPsvKvAyPUGzjcKhUwkv7L7h3S1+3Sgy/lZBrhITj
         7wOV2A1TEhD/Vf235g7JjocNUTB+2XC7iRyjSU33Yy+vznMTT5lVpqSdC2FUNIWYhysm
         ofXEu8et5+pYs4US0nEHcNHi7SUlkrzeToRy4cTInUqn/new8XwAqapu3Jrd9B9Fzbvd
         bN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642315; x=1787247115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hHhRM52KdKrRi6gpE3cIbQsE04qBYaQW/Y0DpiPJx5g=;
        b=nMeGVVD9hg3OBehFvuGFEf3SlRDldHanuQhDciIioPsqBFsVZRmdEF/+hWLTCso2wR
         E1lY5uIWBjCXzRzUg3cbfdreAcWsOT0Awr4qrNEnaBb7bvYxjYsB4Jc0c/8jtxdsTlDi
         fbjXK3ErLUOFFGz1nhqMts2RDRq96pqvK9ES2jO+iD8aGF8h43ErzN1tjfg2dxv+uSgU
         0Qqv0prudMf6l7HIwhLx3f6GX99HMxuERerFLNcuvXtsHPVdVy2lVWDq1e6GMiOPNwVP
         8mwtUGDhklqkkZnMkhBAs+idaRt9VtalPNhwhur5KkxrP3G58BBTyFyMEfJtHZBlJdxz
         u5Rw==
X-Forwarded-Encrypted: i=1; AHgh+RoIPOBF+hOt7o4k6Aeab8TTzKpPbGCtQb+Jh9wZsxvckQMoeo5xuoR3XG4eYrHZab9FaSZQ97jFS2/qipbjgg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3tt2UNi2nCj9NvpxTfX86qeE81yApR0b58LslkXzM2WRSzg/o
	MYqzgJQFxNFRdHBA3CeKehwslTVdYQKS125i56K5sWp0MYf5aZHeh2q0XLdWGbnz
X-Gm-Gg: AR+sD10R14jJx+Su3XDXWpoKIPEu614dFyxnq5sHxE1ckwlVF5mxPILJRQxwiM39jIc
	ABNc14jPIs7j1f9watRHUZiWWo7FJ5Zk7xWJ9bM7qprRciabMj1sk5MwcenpLgSK8s3gB+odbPl
	n9J8uyQiRunTqIQ2+6fvYrNcayPf1aO5MjUiKi5wYEmUBoLbSIdhrOf34KiPNSRuOl2S30kq1TO
	6yMbptOQK5L8eSlVOWY44NG+VZhSCp57he03v6YGOr9MAaV1+K3UXWD6OkEepyS4tBn1rnsnYhL
	Kyu5QGDQqewtsmHntrtfW9OPoKUULi3ZTHdop3+6jZuX63ZJuhcvDhzIGNft8S01b+3aIwRmJMI
	GcVn1WN3o6nRcmB0kPmfCXbHqchR+rcCuKg+7yBUoeHX5DKtGYqiu8fBrhc+EzE0il5i8/55c/M
	eFFMit0O9x5sKI8BQ66p+GCyu9dmqILRKk+FwgXYJt1kA+0pjsyYjZP39F023eUw==
X-Received: by 2002:a17:90a:d40b:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-3931e058763mr8418570a91.6.1786642315261;
        Thu, 13 Aug 2026 10:31:55 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc75d8casm10961169eec.3.2026.08.13.10.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:31:54 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dmitry Torokhov <dtor@vmware.com>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] vsock: use sock_error() to consume sk_err after a failed connect
Date: Fri, 14 Aug 2026 01:30:20 +0800
Message-ID: <20260813173024.2362935-4-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813173024.2362935-1-phind.uet@gmail.com>
References: <20260813173024.2362935-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsock_connect() returns sk_err to userspace but does not clear it:
  if (sk->sk_err) {
            err = -sk->sk_err;

For a blocking connect() the error has already been delivered as
connect()'s return value, so leaving it set causes subsequent operations
like poll()/epoll() to keep reporting POLLERR even though the connect
failure was already delivered.

The error should be consumed once it has been returned to userspace.
Switch to sock_error(), which reads and clears sk_err atomically,
matching the behavior of other protocol implementations such as
__inet_stream_connect().

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Tested-by: Wupeng Ma <mawupeng1@huawei.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 62e22c4b13c0..e89cb84b8d73 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1842,12 +1842,10 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 	}
 
-	if (sk->sk_err) {
-		err = -sk->sk_err;
+	err = sock_error(sk);
+	if (err) {
 		sk->sk_state = TCP_CLOSE;
 		sock->state = SS_UNCONNECTED;
-	} else {
-		err = 0;
 	}
 
 out_wait:
-- 
2.53.0

