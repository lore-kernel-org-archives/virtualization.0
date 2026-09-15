Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAC481FA1
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470868; cv=none; b=aA8dFTORkWpI5sAZwAjrsTVt3lhZO0bATMaobPD3eh0iKkVPJEq2W7/wtqOpk7q6kzt1ZUjsDmQwKI165yyMBGL1TOmJ8siDGn0j3GBVS6V3QJAO0J2bZ4DBqE4H3wNXtXaqOQ9jKuf2IlJgIsyF3Db1uotNUETZN2y16uDOMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470868; c=relaxed/simple;
	bh=/oB6vaOXGg5+3zOLKgYNrRDA/rQtpvhIZtESt0iNrCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyhkeOgA+MdLguZcFlFbzdELgK+empWN1n+xf59G0/zWJf9FIVynVcNs7d5eMO7ckKuJoIdZkNE9ZMHiBiSzRIirLPGpkBojCKb89b+IwCXC25IKV0EkD0adZn/bLr4NrbpChH/sVipQiMYCiUrkcJNemuqf7Q82ca1J1KtSeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSiRDkAg; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSiRDkAg"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5c83be8db39so2412191e0c.3
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789470866; x=1790075666; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FAuAan9y645zprFQBzGcUeZpc28nMxYe+p5U/JKA+9w=;
        b=JSiRDkAgu2DpQp6Mb3/szorPlD84piPrpfAWqGJrwunYVu9EjDqou+VaVfRkXP7t0r
         wr0UAjPislLTCvFZ9fkvzFITzAgyv3XftHJrndfSBtuoSM8YekKZj1Q029o0TrFxisnQ
         xJ442eDOpVwe+P9Fst9+h+lqx0BZwlPvQx7i2GMp9spf4bxGsglcJdVtUtYhGfVDq7KX
         slpMgGDAnZ+/lqwQCQNEDIzGDcsrJddcqnRjKvFt0iVNVbACGQ7sMdYeQS/FpOelyZAY
         OmKKFuBxn+L52sP6ROsGkbWkfhzM7+x6v+OJfhdu8erpPFKQiMAbUU5CmO+p7br91lFx
         rZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470866; x=1790075666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAuAan9y645zprFQBzGcUeZpc28nMxYe+p5U/JKA+9w=;
        b=lp3arrHJpZYPb/4VCRIpTCxaz9LWoNue/FCqXnuztpxaatdCtJFTMH7VgQbZRLhnJJ
         zqZ4yznZjR8E0ySfvCNNyWTw7ciESgBU4Bnhaxn4dVJ0k9ETJlfKA95nq0E3vB9kwulx
         0beyd2uRkP0Mjdnwat2piidJ3ueeGyMaZnCUL6EuMt82r4VyQSX09CjTrkjH6vLZa9w4
         GkIP60ZhARQ42GKtGX3EsofMs/3MXaKuZqAtixvkFGpdkVOqPnZF9apJ+KCM3FefYsci
         SF2smJtgpyA1kUHNI/Xi8+HQ/mvY/1mL+XL3NljCxDPXPq+FHhoOG2WPvdu6CO3aFmzd
         Cj1w==
X-Gm-Message-State: AFuF++mxsdg1lN0ZeQUS2I++ShN9yddgZN5XhLBWIbflaYWHuk4PlGXK
	fUZSAOx4mv6T41hlR83DtnhXriQ24BhTFs2kNdvBADVwPI3hdL4uCmiN
X-Gm-Gg: AYBFou2dvJLn5Ph+uTA7LR58kFIvrX4Wgu0daa0mM7n0N51KjqKzqH3G6mTCCl5g4Mj
	+1gMrqDBUJ8fjrPgecOCJdrMMchvr02/RGEpF2UPlW8FWhfqrMrED6VXyJJu9Frak+F+Hs8qRPh
	VTX42XatcdcbaplQdLKvRM9cimwndh5L6BRND5ew/YH8068b/VVwZOFeCxuCHoYO5HYE/MfLUbk
	7NqAbshc37VQFms7LqSD/v2yRBu1Ug7jllideRjFgjGXkh+3W28Qr4hNdUxgrC2O05sBFe611I+
	nUbGkaCDLKLLvAg+IqeMCa4TTshEpFw75QDlyytLbTYOBzgn9oYhv1VTMuJoHQXZPB/9datnioZ
	B0H6Rh3zOZtnVcYtuDG5JvvY+kW4yMFAefREWAJyQ6D7svVjzoStr9/TAzk3Qa0WMTmvBE7LWFA
	jT0YIwuyT5ug7YNqhiRP9Xu8SaaVUeaeinLWdL3ljnWW8y+HhlAwZstynz3MS7xKz3
X-Received: by 2002:a05:6122:894:b0:5c7:ebed:1018 with SMTP id 71dfb90a1353d-5c981d87e33mr4414877e0c.8.1789470866398;
        Tue, 15 Sep 2026 04:14:26 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c846f76238sm14577407e0c.2.2026.09.15.04.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:14:26 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] vsock: preserve child namespace mode on an empty write
Date: Tue, 15 Sep 2026 08:14:17 -0300
Message-ID: <20260915111417.2726515-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vsock_net_mode_string() returns success without updating new_mode when
the write length is zero. Its caller then reads the uninitialized enum and
may permanently store a stack-derived value in the write-once child mode.

Initialize new_mode from the current child mode so that an empty write is
a no-op.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd0467..61163357ae 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2878,6 +2878,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 	int ret;
 
 	net = container_of(table->data, struct net, vsock.child_ns_mode);
+	new_mode = vsock_net_child_mode(net);
 
 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				      vsock_net_child_mode(net), &new_mode);
-- 
2.43.0

