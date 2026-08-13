Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6435BDDB
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642305; cv=none; b=aD2DkQ5hC63kfq+oaWJS4Ni+hW5puGksDIe5yNwreiG3w47O9x07wl3st2rup9Cnl7csDn09Y5k8GbWCce6eC39h4/1wo2NNekz3LMYuhcqJC0fkHQfQ4pD6H7WZTgIsGHkyF9kx2pTDPX4c9F/8MGbQ5TBXkNIMHaVJKNF24Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642305; c=relaxed/simple;
	bh=PX2mRjRcZ6SKnMiqIW3z5oZL9FVYrWm7HbB1K3LDT+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWtJkYvHXPFU9LwoqR2TFQSXKwTDL71BzzVZyq3WJ6oFHJID+e8JqbreJqN+thZeE/kgBlMG8cdRp6dSonLpQIVjA87c0KJpJYUtHEjkTOyKrUmPO+47w9er2/HRxlDZ1l3AFuu020Ho3+REbX5G8tzApWwVTPqoXMbmLykSwIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ww7jjVEy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww7jjVEy"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so126644a91.0
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642303; x=1787247103; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIDNbht2xN43TSM9aB32QdRabnlhTJtOheOWQcIxtKg=;
        b=Ww7jjVEys6QdObq9/G1f5YZvyA+xVY0sMyhJOS2eolSdMWoNZ4UGBhLxL72HuIu1j3
         2YjAmiz3QDfgOJ3FktnXuqce0vedFq7EetK3dd2ZGv+DgSnL0xZGLrTvtsyZErzhpTMy
         1UgPF5qiU91r4jc9EYHh+P3oPTyAjcsQiVoDttFhdCyNWX/RvrRT80DInvhI+6SP8e+3
         FU2tO20f40zKSaHEc4QbCmNtSh7EMvsFViUmaMW4AZVwnbzlD3fHVPCjXIqnlItV+FKZ
         9MV1i76MZUkc+wp1VUHuCGziJT+wcFFQcCECxP0US8jNaDviLxPfAbNBQSrXkp0heRA2
         v+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642303; x=1787247103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIDNbht2xN43TSM9aB32QdRabnlhTJtOheOWQcIxtKg=;
        b=UGx8nuUMWtr/RmNtABP+PBjrNlJWDHUTh+PUIDuyiGoA6eso97Q9PF7Fpj/LwqLe0y
         MYPfTAgM4+spjYLYWu3vJxTxxvTxMFihP+ca6P4f8CraDhYgLyrSj+sIoPBkBZLo6G7l
         5pOIzP1qgGKyCHRc0Heq4nZnejKtNnTDgjdnRpwY/SAGWwYpp6UfuAwIe7RizKDpwqEJ
         YWfiDcITRAWoiPVqikway1VZUFlAa+4VJoPeRcvvUruOaHqCXFlyNOLv99qeqylSkIwl
         ZhRi7C0ObqPE8299eQnI7qmOXgl0cSkn+izLaV2OvxvXag1852vkg9rnOhOe1T6+DiKF
         MHmA==
X-Forwarded-Encrypted: i=1; AHgh+RoYjfME4O5zO+DXXeaAvsjB4iwcIY4HT3gM2MIuJMUknhO56UW9CfXY87reEnnfTgjfzRJBw7LyyJDGHxTUfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO/2b3dbcMbpHSWRXz0QFttgS3vog00YzmZijn1vps2hfPdNIR
	WTAFThhaHp5vXDlnon/39yJbCMOyCs5knPw2GOsiXNpjQF+hI321ieP1
X-Gm-Gg: AR+sD12vejk2SbP2ehoihvkSC4XtSpOBYr007l0lXMrHV9HYt3hmj1k2e7sl3OfO4i8
	v90aSx+1Kavh8PCSMsB5qKw8nv15NLDRVQ4CdFtBAoBooteE8l8QwXgbDHTjUwJQeTs3RNUptv/
	JhEK/B4X5TQYByc/4fJErIZBRbHW5iUmz9J747+Ng9gjdDcdQjH1FpmdTb5f4vJp/BQ4+i3BaBx
	RP26VBUujVJVkdwYdjv5KHyzzpsT2w/AV2mck5gEHtnzuMRL8jGO/wRfdcun4wqKxv6L2tjv81t
	/X6m1IZvSqfxIAFbiBV+ZIqihFL0f/5znfNRQntS9RlG2XPc10WC0DhyKMiS4bL0vSrURAeUh/e
	RjZuJMkm3NmkJf4NlatrMiEgjdAIqBBPbmTZuFWJero4WJfOyCUL18vaaVKe2gWAbky13pqseRm
	D0UawM5R6gQcwNWZUPzXHQ4aaapLH8tqGeymVcuPZzp3JawZpxuzTlsxt0e/+3qA==
X-Received: by 2002:a17:90b:540c:b0:390:b41a:b92f with SMTP id 98e67ed59e1d1-3931e31bd38mr8495099a91.18.1786642303201;
        Thu, 13 Aug 2026 10:31:43 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc75d8casm10961169eec.3.2026.08.13.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:31:42 -0700 (PDT)
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
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3]  vsock: fix stale sk_err handling after a failed connect
Date: Fri, 14 Aug 2026 01:30:17 +0800
Message-ID: <20260813173024.2362935-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A socket whose connect() failed keeps sk_err set. If that socket is
later reused as a listener, vsock_accept() rejects an unrelated
incoming connection, and on virtio/hyperv the resulting child socket
is leaked.

Patch 1 removes the listener's sk_err check from vsock_accept(), since
no vsock transport ever sets sk_err on a TCP_LISTEN socket. This will
fix what the syzbot reported.

Patch 2 removes vsock_sock.rejected, now unreachable after patch 1.

Patch 3 is a related but separate fix: vsock_connect() now consumes
sk_err via sock_error() once it has been returned to userspace, so a
failed blocking connect() doesn't keep reporting the same error a
second time.

---
Changes in v6:
- Reorder if/else in vsock_accept() to put the smaller block first.
- Add historical context to patch 2
v5: https://lore.kernel.org/netdev/20260810170935.2242314-1-phind.uet@gmail.com/
- Split into a series
- Remove the now-unused rejected flag from vsock_sock
v4: https://lore.kernel.org/netdev/20260804135238.386417-1-phind.uet@gmail.com/
- Remove sk_err checks from vsock_accept()
v3: https://lore.kernel.org/netdev/20260730081843.287563-1-phind.uet@gmail.com/
- Fix truncated title and add annotations to reproducer steps.
v2: https://lore.kernel.org/netdev/20260727071305.45826-1-phind.uet@gmail.com/
- Add reproducer steps to commit message.
v1: https://lore.kernel.org/netdev/20260719220103.684489-1-phind.uet@gmail.com/

Nguyen Dinh Phi (3):
  vsock: don't check the listener's sk_err in vsock_accept()
  vsock: remove the now-unused rejected flag
  vsock: use sock_error() to consume sk_err after a failed connect

 include/net/af_vsock.h   |  5 +---
 net/vmw_vsock/af_vsock.c | 62 +++++++++++++---------------------------
 2 files changed, 21 insertions(+), 46 deletions(-)

-- 
2.53.0

