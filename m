Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E73382E8
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381844; cv=none; b=bTsxjoMenmUSGEeuf98tSksGv7douD25HZlFdSLGZC+bTNKYGkfWPKYYZxIUX3F1tTFdBkBvRkXwucBCT8f97B0IFOR8lJhkcMb9zZP5jXAXyU9WzoZ3I8QsAw79i+9iTB+INGrgK9GpxZg/8BZ4QySSJl2ySCojjxNKIib4ypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381844; c=relaxed/simple;
	bh=u/03OJopUWpYIZLPOmNno1ZcdLO9Vd/Dsn+H/2t7RQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQy9WEb/0aIuMsSvoM3qZe2tD0+m5bddErHdXl7wbU+7I5DdSvUgGRr3nOXQsODgVoPJyxY8eUPCui/0G/swodUTIEy7d+67cciqRaApgvd1IzQMf4CCzspwGlLazvkt1c/uMlMPcT9TxdKKOJfQ+fW5/8HVRFUTFcRXgK///5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhcG12jg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhcG12jg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso1532897a12.0
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786381842; x=1786986642; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YwnNatVO8vJ44aB8viIABkdP11ZOZYuCLz8W0eTqLj8=;
        b=XhcG12jgc/VAogEruBHqU16cIIAYwCvJp0WB77Zr8KVTTJ8aCIzhq7pgLFNkOll3kL
         nGip/YhdvUNci7B62H2ph3lckt4ayCX1OjnjpZ4YuCncblyu++azApyjhD8UMsRuqKYn
         nqy82iSjuZ0mfxwD37LXuBEQpLjMcmAApTtRpPK4WzBxv7muhERhl91veUPI4KnPOIe6
         nbeObxA/IO3wxjbFNrN7yvxykdFoqwYjPAMVsJPIzInugqGGLHHy8MAQalzROU2TQS/S
         Ks0RuJtPWg2qHs/Ebdh+AVrP4L6herzv98c0rHYwsQcrzlwjLbJKzCmF2WyB8lRTpo7Y
         0org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381842; x=1786986642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YwnNatVO8vJ44aB8viIABkdP11ZOZYuCLz8W0eTqLj8=;
        b=PS7GwtY9DDQS20/6Kap7g/wI3H+8nz0J3JB1CrEJskVWI8zBdEU4SZf4ndpcXwFS64
         z8+wGxEv77cFJafAFcy7ngHa/zOBqGJLkPveT51CQE3lRcFqRzpdeEFuaQ5kt8LxFCtG
         9DGScCfYiFCEoJBUz1NUd1lfO2t2VBP46b2gx/k6LnRxu2NmlbEJXGRvMRuUM3nLm/gA
         NWBNj86JwK/Jb3uF9POc8BWu/OukReoqBsYPqkq2ustiKY6ivD4ape+MiJVGlYQ8wvTt
         nwxI+Zlv9CaSKD/1pXp7tjz7hIRVf2Mwx7Eaxb0oJSfVyI+rAt1DtAM/v726mWqzXUlN
         DB0g==
X-Forwarded-Encrypted: i=1; AHgh+RotgaGD9Pl30q+8MholJ4ZWcqe69xYPXGrKHXMUpQjwiXP1EXgRwuNXqZqjvjZKG5sMVJwtdnB1XB6Dz16EOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxgsKVk6Y6HOZ3ZJi719m+1/eBD5ewYSQJIIKNk4IyETOMQy/g
	LLY5nd2vpAtNpMZkun0ER8FkTsC44KgUi+5xPNIroQxHaCUshp8uAgeR
X-Gm-Gg: AR+sD10MvXewXmqGJr2JjcwaGvHfK5Xq9Rg4lwfCQnaNiJSNTqdrSysNAqnBMsohfN1
	FuhtO9eYWJblCImmQHZauN07ifg7OshwisRBwTObt/q5VqybW8OGEyAVE4fVsVbb+nuN1ylzBgP
	m8RNrfXXCrvkY5K+fNtMwJRzEbI61Udu/PGe5i/SywxK45ebhPKUR5hnvU54CgAtvC46tzr2bWq
	ppHJ4iuhZ0v9/4C6pnkBVGVFxzIHi4eoMzE8lnp9zkU4womMvgwrUR/PyPVdhPOILP3SEDnmmtH
	hfF9TZySVKJEGRlYyH37oGz0JyO+WEFotQGNRLM+qCs7Qv4gIP1DJnJMM3HmUtpZ4yngbMEMLg2
	6mNUf9YNrLGOHYkaPvokfLXdjTy4v/P6Yj5uaelBzPs0qavjBs7sJE9BpSODOn97hXCavtj2Q0L
	KHkekpucYfBd8OKy6dIy2fsGNBZcdmzO1qD/K9k0zpFskr5RH0fuOA7rRdKe2znA==
X-Received: by 2002:a05:6a20:6a05:b0:3c4:3112:3b with SMTP id adf61e73a8af0-3cb85e771acmr47912530637.18.1786381842462;
        Mon, 10 Aug 2026 10:10:42 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm37194663c88.3.2026.08.10.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:10:41 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy King <acking@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	George Zhang <georgezhang@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3]  vsock: fix stale sk_err handling after a failed connect
Date: Tue, 11 Aug 2026 01:09:29 +0800
Message-ID: <20260810170935.2242314-1-phind.uet@gmail.com>
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
Changes in v5:
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

