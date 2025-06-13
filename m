Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9025C838
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784332; cv=none; b=e9cOSXbB1LW4oKf8yMnHxcl2mRQIJoYY0B+y1A34R396ra+Qw+48NswRy72VhvYj/pmAcYFCarhPTqaobLxpcLeAzX6PTs7xZXXUNZQ2dYCJZ/l08ZbhE77Y1nuoAW0s1mIVQGNO61EfKXGJQTV0EwgAmja2AaAsmIKSPUz1ZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784332; c=relaxed/simple;
	bh=zTdqwv9Ssej6orvsbamVC5PHhURL+JyHsh7Gy+vvlK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5QgbilpS+8ZFC/jzkmVQtjVy+CkulRptzkQh7CFOAUMYJX9d7xT1aCydyOI6Rz4qVXR7luZdkB0VlIGI5aK0d0X7vMEBh3VF+1feDBPpIqrKgzkfNZInYioLkp8tqYCliPmuOXjdpcg6XvIxR6t9arCnGSCVeCss2N6BnupjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsjYmY0c; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsjYmY0c"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2fca9dc5f8so1229510a12.1
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 20:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749784330; x=1750389130; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JaBNyC5lfL5DwQH+KQYKj542RoCqVrJF6tcJtmbxpA=;
        b=YsjYmY0cVNwCWdyfycC4EpV5pp5mW/FE+zMubRslefLVCe3Oul5jOhaiyJHL1dqyEU
         BPYTVExelmvGxGbwkaPENdGn8lvCU8ywdQynn2QaV/2SY18zas3vMm/ExqBXxNDC9Z7+
         RhtXVaYDfQjhmcGrgvTPQMHad38OQDTOw+NZUpqKd6nFtO4KrYfdXQGZwh5Ghhdpd6wD
         fJkAunIhjHBp5lyngdg7iFXqaNnhq6RQhWATMstqGdB5/OozvWuqaM8a1foUkOpPkWmm
         FiTDmhyfi6/PgJNVMgLUf8is0ahsz298U968CQoQqIoEyO7WYlkSJZMspiL7hax12YzY
         6zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749784330; x=1750389130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JaBNyC5lfL5DwQH+KQYKj542RoCqVrJF6tcJtmbxpA=;
        b=V4Ef0rbhnVbqAXWrDsj5b6eJD1rQSy7CcXvCqPg4UuqRnLAszdhvYhNXTnIl3iWmP+
         /dW2IGf2A4VDoysE9f1stYct8bh9sJOy8JOTz769V9Jk3SZ6F6ByksOHbGNYu/gYxvRG
         uluJeRs0pIyrdm94kngtnpixySQu5ahIo+oOk7I+nceEwXV/NznKtwjWdMX7u6OO7DAI
         NYEQX/5HXE34wIxcdLOhQPpW6S2cURY79xUvad1+OTjgQ1FdRffGVr6amsCxiBoVyqjb
         1TNyabakJaRgk55wSGrbC+j07vVL4zgPeWM24SGJqwFO9TxXfvF7K6bd144onVhPuYAE
         UgOQ==
X-Gm-Message-State: AOJu0Yw6c0So9JXNomlCDpqF/bMdR6VJkuurW64diB8gufu+KP9AyWQu
	ZQl8YeMT81bKouaPdt0rpyE+ZFERXDnz/fbN3uhtpGCwPNzBzbMMZaP4
X-Gm-Gg: ASbGncu66vvDJ6U+dluwIYvnKMv5jh/cBTXTlrKSMPKOYL6j9xdyC4Zj8z4gTJDbjfe
	RTdqVo/GHkL9W660ez3T5/GmjWuN2deMvYUElJ+eXMplxa0AsmNDhgjEcKnbl4L0adE0sjApY/n
	3QHI93ytXINjvvK18vpy/KQNqcd0yYoUDpQiCOhdQTSMstbwipx87AAZixcmy/wFzOf+GlmW7XS
	OvyPgP5QkE41pjdfuF6PlgV/JbfXYhQWgW6b0+lE/dwRk4XxzvUdM4AVb0sEf51ZmLy+itL07T/
	RWndP9RbMqEl47m/ofzyMrQ6Ew41/WxyZ9IEQW2aMKnhbrQQhFY7PD+MsIaYJCbvHtQmjFPKgEz
	Tv8zEQVlt
X-Google-Smtp-Source: AGHT+IF6ZIGLNpqqBVYQhsnYee4rQdJFSL+hFV4nO+/toKNKtFhZK00+NJViwASyw5ZSKmQr/HD8ww==
X-Received: by 2002:a17:90b:264e:b0:313:28e7:af14 with SMTP id 98e67ed59e1d1-313d9e93c27mr2245323a91.19.1749784330326;
        Thu, 12 Jun 2025 20:12:10 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bcbb39sm2291801a91.8.2025.06.12.20.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:12:09 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stefanha@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v2 1/3] vsock: Add support for SIOCINQ ioctl
Date: Fri, 13 Jun 2025 11:11:50 +0800
Message-Id: <20250613031152.1076725-2-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
References: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
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
index d56e6e135158..723a886253ba 100644
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
index 2e7a3034e965..466b1ebadbbc 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
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

