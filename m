Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676513074A1
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598948; cv=none; b=ZEB7QUb/VhkKHHRzUmACZTKZm7cAIvhDLhtkcQwQYFvqOzm4Ba5ewJcDHZ+hMIiCgo9mQ0DXcnLCn3LTBFYVgj5r0wxQpshrkeT2Low9QvEcmphhJnXwPwBDWDi3QV8a+Y6MVvPu9ql2YG7hs8cqi0WUSAcFJeJ05OThr97F0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598948; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uPXc+ZH7XjvLVBMtwpLJAYBMJOP52VTB1/+vTaH+UebhAQy5dn/xR4xXYBfF2t7KO2LrLekjveJGdHfohc6LkGnYXugsiPmUwOPktk3e1NxpE/22ihIcAyRpEtJ9qbIlp2UBcScWobSVur3VN/A0AWYfGaBvq6abVEYURnv1bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlNVJamH; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlNVJamH"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7927261a3acso24616137b3.0
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 13:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598944; x=1769203744; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=QlNVJamHyp8lwVhBpxh2+OcG60cKcRsWtUaNkP4hCo9EgvBeBc2EUeuccpHK9MWwee
         WjRyi9843ZZS6GAcVqTJlmRzHNiRT+TNiutoC+zYIgVCTc9+hUlw4guyYr74HL7XMz03
         o2/ntFn0Q4UsYSO03ut5WGfqfIt/IqnUL1dwwpxoaGr/ypxAhqw5fh1RGB9kRCV6Ia/y
         7uy2SI02qzt01jaPCTJrkKj/iXGTFmOL01l0b1R+uoN8c5VJxX2VRjR1TBK6/dqKxPVe
         hg+DngcS34U7qUvueG3lk+VgRJ7NE53CHO7kfLLAHTjed8zskBrhHuZ6fUuugT90oPTB
         +Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598944; x=1769203744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=mcfBbu4Ba4vPntWq14xV/0q6vvOxXg6QLh2WAV7UXj/OQ8fMennRA4VgVSQhEQrab6
         ex1BPO9lGa6iFNXZtJttb4fo4vooUkfnrTPB4xC7tuPA+bBkD+0E+gVWxeRe/+/dOUDO
         hzXpmU2UfDOTtxwEL24KwTTL/YARzUfMcw5i40JfMPJw3UQbMVQlzjFmUDQoHK1QWJnU
         v3WKw9VmbvL2WpBVN48OAtniAZIannh+KK5STR6zUe9pSY5TDRpLMOj53E2rruzzpucy
         InFWVidH5IzR6AuCaHRw3g/q0uogDmAxKHFg/yyb1M8maYwwUBXrU/lnso1i2pK3vKCe
         EQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Qogn08EIzXXz+F07OmT4VBBLcu/rqwlfzF3sPOUx+qjreFLsWnimWieM4Ea48jvdjCYWZtn/nRLD8c2s6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ0RGK0rkQ6oE24kBYp3tzyIjVfhOwIjQXu/6TCc/sEUCM+ALF
	UYSbVoeiUaBccqYM4fSGSAp8pr1GzvOCpBd5YjqBogBQJoEwm+ESwYn+
X-Gm-Gg: AY/fxX65Wjl0bc5ccc30oSoflx7YeTZ5yEyJTWpC2jj4iOcDDkM7QRbtBDVMlZzO9/K
	Uob/lgjkFGUkXr4u1QIuf5lMBtdCq5YDy/lrLLhOpn5MG4o3N7gpuVaYDk8k6SG0KR2QSUQygaI
	tQc3H416tOGSqgxp32EGF/PuMrjF+O9dN3NpfBz9dZ1+HoLgnyVaAMZIPL9Y62YwFE6w05JZpkT
	N5FkmG9OO7RMXf3MHSTbnpClSWWVq3Fn7MvxtpIH/oSyFe/99774Y8QtRsOALgU+rJb52bybCze
	VHX+bT6CwDCeMEgzah+dc3p5oro3/Eth9lCUTYKJDqVuvArdEaYe2VRLkzZNtR4/bgCN5yAlsGR
	YMZseDowK3dGEY3THh5jF4D1XCI0ihyaRK3dk/+49/8hIC9vdTxUCnHb0SJofwwoIa0yPYK4wR/
	+UDBVZ8OQxOg==
X-Received: by 2002:a05:690c:39d:b0:78c:2916:3f0a with SMTP id 00721157ae682-793c66b8eb1mr33268517b3.7.1768598944439;
        Fri, 16 Jan 2026 13:29:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c729fsm13186297b3.12.2026.01.16.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:42 -0800
Subject: [PATCH net-next v15 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-2-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
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
index fdb8f5b3fa60..718be9f33274 100644
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

