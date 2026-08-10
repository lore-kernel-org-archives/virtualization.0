Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C001B42E8C5
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381858; cv=none; b=GTQ2Huauc8N9dWEOn+9rG03mVf0EYiZFaVCazkR30E9XZser+vXPtuHrglbZOlre/zU64RFdrcQna7PosG14nnGp4gSTzuHEKkcEnAk0ExTslnqSkCiNGCgN2ILbVw45F3qmsGkp83uXt59PJp0a05GMHSrdjzzX6+NUbest4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381858; c=relaxed/simple;
	bh=P9yChhC5nEAPRJBgrn49F1A2elik1HxqQF0r8qN6qek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWr2lxBnuyDS9vz7AsWbQmMGq8/0gzbM/JJsncWTvUECIFqhFA+8HEVtrcTf3gJsHAtSkGbWTdE14LTnvsxTdTUt0/Yyre7IykhxCkvIHrz7rRVdHKaCNFVs8yenFKHVNElphGSviFgV2pRYUSRtYgiQ+KYVN0wVgRPKvZjlr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb9LL9EL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb9LL9EL"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so1177735a12.1
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786381856; x=1786986656; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhsqyhzE48bljLLTr+dFhyiqwriY9sOBMtlHTtICd3s=;
        b=Fb9LL9EL8O+mQ0UkSje0/yMFLDDGzihcbV2x/FMR5D8rm/9VAQsXvGl+1a6WVr4KRc
         YsmEq4r7l5TjZx0ICtsgPJzm1CzKTFAqhFdQNCnZ6A6pjh0D0WWAo/wGz6BUpDqliFAZ
         cA8AI4+pSg06bjmOojhbN+XvpprrOpsRf7rpU8thXz7Fzp991vkIkh43YHn+1gBYhu0r
         QDdYWe/Swomm98FHPi8VjqWzWB4zoQwh0d79p/Q1RftnPkvLNCmxxJa8S/pB/NCSFtOr
         P09iHwgFnvj/Tl6XjSrcbyWF+zvXOPZfEFUVQt8bpb4mtfQDquvMBXDUK1N5drY1qVBB
         ixuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381856; x=1786986656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhsqyhzE48bljLLTr+dFhyiqwriY9sOBMtlHTtICd3s=;
        b=S7R0Gs32jYP5C9rRYgNcDCDheBvgraJMmvyokA86anUdWZ6lWT74KxUmYWz6YWsQVH
         4SUQqzOC0VUbNE54KmtqF5z3YLgRK7gM9t/uzfSOGo3P6CLJJJC4gV6bqFD4hRMuNOY+
         1Nx2Ehz83cxki6L3elM4iO36yJkLKsdgq9uPEvLGZOiPtciuo69+BpZYh3hgq0g6OL88
         W4W9ZeU84NU4rbfR8pAsDkjWonfxG/K/I7FNUiWXenNdJ8nLCVTO3hPabz/V08Gbmlw3
         DukfaXWUI2IvukWVqn2melKjPtTBJ+vwA5sBfPVg6qB0x6DUJTN2ahlpCKcOeaTliiWO
         Y96A==
X-Forwarded-Encrypted: i=1; AHgh+Rqz70NXEFeV+g5FS5ZDYf/SusDXYrFjzjIkrYylpcbW70iHllxp+uwS5lYJQYjaP0pnXQgdAZFvJOxxLF0JNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXVImOvUV6O2IPqw5MHLSiPf8Gbj3vpS7L5pnHwUw4okP6iQKn
	nA/Culhazgd2vywU/xYuv0YE08l+FN58JdBIJjNOPwopztCSZDJnU3wD
X-Gm-Gg: AR+sD110gGFMmk8arYTjGvJPGRlT1/jwxArQLWFDOf/HspuKoQYkBghx5qJ+Ljq1Yr7
	ZsPZmms6E0z+6oRcCwFBROxN1afhfTxlTqZ5V30RHQUw0i+R/ibCfjVo772QRcoF2zJ5A4EW2wY
	BDh+w5AxvPGGBNsJylpPFdtmxGtBeZUt2/1ESSSnqfFp18iKofFxNSTNTs8qjMCIzlg/0p72zUm
	3Itd0jYil54A/QLS+auhAc4a5jY6ofIvGpgWIUw5XPqiTQ1X2aq9OdGcuMfS+GIb9bxMP3gJrx6
	G/Q7/qKqa0lz2QFG7OPSgaBWLLKRTiF0R4PYQRi5aprty+1fPwotEtRhYPR9uL0P+vyoKYsBLEH
	WYQgUDHJiumaxGP7NAXF5djXXsJM9sBiEC1WZjKW3xgrPyzY7xnyYKfm4s67Q29PAkx+tXZ2lkF
	Whhy3kqewBY01qP+ME6aNzZ/9hBvybaewfUc3PbZL4MkA2GdYDdHNtiGNm7OseXw==
X-Received: by 2002:a05:6a20:7344:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3cbada660a2mr33795635637.8.1786381856114;
        Mon, 10 Aug 2026 10:10:56 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm37194663c88.3.2026.08.10.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:10:55 -0700 (PDT)
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
Subject: [PATCH v5 3/3] vsock: use sock_error() to consume sk_err after a failed connect
Date: Tue, 11 Aug 2026 01:09:32 +0800
Message-ID: <20260810170935.2242314-4-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810170935.2242314-1-phind.uet@gmail.com>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
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
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index b59890bbd217..1a287719f24a 100644
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

