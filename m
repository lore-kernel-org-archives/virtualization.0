Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84781A2398
	for <virtualization@lists.linux.dev>; Sun,  6 Jul 2025 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776633; cv=none; b=MXL1EyAdAnViDMuN5gbiUVlskHHlMZyHHQCicNHr9oXDx/wIadw1xbv0zEtL6kwJVFynHBaSuOsyWRw8pQVVT8TdurcE4m1jMx867gQpzM4mRQbZmuFxt8zOLCRSPp+4Po8/DA1nhZG9owmgK58zN8iL9ETmg5Fz1FI1hyQrplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776633; c=relaxed/simple;
	bh=n9Q2c70s99hykiVWRTO0HNEhldxVXbUo16t8vijIGOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOQ+3x4OZl/CMEwktiMQfC8Yzfq5J6AwmcTzli7Pe8HmTXKP97owo+gR/CnRlCs8hkYPpHR2k/07Fg+BEy9uTriyOmhGUyaUm4YZuthwl62bXlZQyVqPR+wJQtJ28oSlRdqAoO8ppPTm1R7Pm+gUyKe3ezRAVzR7t6xlMNQiFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDtf7rw6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDtf7rw6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747e41d5469so2383163b3a.3
        for <virtualization@lists.linux.dev>; Sat, 05 Jul 2025 21:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776631; x=1752381431; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkHPe6LE8OXWdD0I5CLih7m7+WFtKYT46OEMON9KnWQ=;
        b=cDtf7rw6XLbjY1l3jF3KYxujrIaCaEuEJysROG3XM5EUf4fSImufv2J9rF3wkJ6t3i
         nkp+iasbRJo91AXpUOz73DFyO161ET5TG/4v3Y11E4CDPRgymZct9xCXNIGHJQh8llc1
         wpwmyKeXOBd90wrB9Ls3qe9EWCCQ3x8cPWUNuBJyxn4BsMo2McET/hMNRZXy8ckv6+k2
         ssCtmOi+aso4winzqw9SmSas0u791dHFee+a7PfrTyVnFdJe/0Rdj6o+8wtcNg6dwsEl
         Xnh0NPgg0CMR3aNZTy2tIV5xeNPMvHyp9v2Ht4qytfsbY/q8c2YCTSPwSBRPK8iN/OeJ
         gd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776631; x=1752381431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkHPe6LE8OXWdD0I5CLih7m7+WFtKYT46OEMON9KnWQ=;
        b=diMlDakBoRpPlvgZby1bA8V+pr+nO5G8Fjpvu9OKTdxGxlSs8esuY2YJ5AWOBY8dLd
         HSYwqRxqfCrzbWE+Xj6sufmogmmtX/g7XwoCP2GE4q3X+EzuSfHL6fJ4nHWCjg5TAaOa
         aohGJrhNYZcGRPQAdouJ0/KlZCk9YbxohlUgy/Ah7ibv/1Ot5HdY9iPIoMmoXQF0eLc0
         3/PjT5c/ihlnYByghuwA7uaTskKAjsMZJXiKQu+QhmrCp+Nrk9wys0zMylhN0TbeMWUZ
         npNeI8zcB//J7FJzlapq9nLqrLJQ+3+OPpVjPmH/oBcO5b1aA6TKoEDEyQGHO1pbq31s
         nVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZwK+HJL0blTrYTwe1jrAzL75IKnk/IXrg5i3cUPBP80IaKpfK/BYzf1/ETZei9oG3Wl4EkHAbjutezvut8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1QZC//WRGaP3H4y+1UChHh4r5mphcaQq/K53eAGJoRT2eh1rk
	bwHKVlJRoiXcKPUXws0NwciwPCImJ0MFbh7laCjpXjC7Aug/cvE677Uj
X-Gm-Gg: ASbGncs7UMlqtYyumMJmRHVhb0f1Lx8iTDGxbJYt86boc7OucZDtqk8LDZZqH8xNdsp
	oVR7+3700Vth/S6KHZkHBUYPgNr9kaNk5rOoIIcR6M0ifytL19RNUBm/nGItxAGruje0N3Cgp+k
	o/+XDQAWjpxJ65r6FEdBVk8QSV1j7hE2e24D2yb0He1G2QWLJ51/vf0SlGu+F1NepKWVly9Pb58
	faBuQ/qg+wHfwRLHkLLPBPHn4BwF1SSZp/5eJiBXOX4goMMnRQjYLhcaevhvwAB3Ei+FjjiXtBr
	aDL5cO+CvgWzdsiICGXrVXfbwcW/tGo6iHvPcIVajXSQTP9ZkO1rRWGRpnmQjv+83g==
X-Google-Smtp-Source: AGHT+IHGk8AFJbLfLq2JPJAq88rU8JLJAkLvo3fQgqjmGI7NA8C+iaMBGdiCICDxGFishDdjSB5qyg==
X-Received: by 2002:a05:6a00:3e21:b0:748:f365:bedd with SMTP id d2e1a72fcca58-74ce8ad63cdmr10121558b3a.17.1751776630879;
        Sat, 05 Jul 2025 21:37:10 -0700 (PDT)
Received: from [127.0.0.1] ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc2cesm6105137b3a.59.2025.07.05.21.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:10 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Sun, 06 Jul 2025 12:36:29 +0800
Subject: [PATCH net-next v5 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250706-siocinq-v5-1-8d0b96a87465@antgroup.com>
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
In-Reply-To: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
X-Mailer: b4 0.14.2

When hv_sock was originally added, __vsock_stream_recvmsg() and
vsock_stream_has_data() actually only needed to know whether there
is any readable data or not, so hvs_stream_has_data() was written to
return 1 or 0 for simplicity.

However, now hvs_stream_has_data() should return the readable bytes
because vsock_data_ready() -> vsock_stream_has_data() needs to know the
actual bytes rather than a boolean value of 1 or 0.

The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
the readable bytes.

Let hvs_stream_has_data() return the readable bytes of the payload in
the next host-to-guest VMBus hv_sock packet.

Note: there may be multpile incoming hv_sock packets pending in the
VMBus channel's ringbuffer, but so far there is not a VMBus API that
allows us to know all the readable bytes in total without reading and
caching the payload of the multiple packets, so let's just return the
readable bytes of the next single packet. In the future, we'll either
add a VMBus API that allows us to know the total readable bytes without
touching the data in the ringbuffer, or the hv_sock driver needs to
understand the VMBus packet format and parse the packets directly.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 31342ab502b4fc35feb812d2c94e0e35ded73771..432fcbbd14d4f44bd2550be8376e42ce65122758 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -694,15 +694,26 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
+	bool need_refill;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
-		return 1;
+		return hvs->recv_data_len;
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		ret = 1;
-		break;
+		need_refill = !hvs->recv_desc;
+		if (!need_refill)
+			return -EIO;
+
+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
+		if (!hvs->recv_desc)
+			return -ENOBUFS;
+
+		ret = hvs_update_recv_data(hvs);
+		if (ret)
+			return ret;
+		return hvs->recv_data_len;
 	case 0:
 		vsk->peer_shutdown |= SEND_SHUTDOWN;
 		ret = 0;

-- 
2.34.1

