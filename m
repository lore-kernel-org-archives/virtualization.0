Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC430E0CC
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273980; cv=none; b=Ld5lT+aCw1zmGqNjLb+E5Kwsl8aQES8UxnxjZ1KySa8SAWxWtI+HTZFdSwngpcQKi7/T2eR/pAsAZ2Kw2bMdxST2tMpxKFFxzUvICLcj3Ao0QekXTCg3lQ0TgHDK0yv5Pk+J8zM6zKx+c1B6LbipKKe+098VD7Z4PPmUj6uTGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273980; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qamtTZQUUww56htk9GMzh+/tgYzhyyj/EghWyUh4mGHFF9+FPiH1WFJn8G4+mt8xQu1d5rWLHhETbsfvYah3Oc5tHCM2ak4/FyyIS6ZIS1FPVn2RfaFIKYyg0SKqAzdHyoTZJSIlvZxy/K2QKqne+X4eTEa9KrD1bT29GiG60PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOwEwpY9; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOwEwpY9"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79276cef7beso22173607b3.2
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273978; x=1768878778; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=OOwEwpY98qboHCxhgVDFYUt3pQJzUc9e7aPaMSODz+3oKVXrMeIPnVt//58DPNv6vB
         88kzq7f6m2HgyBB/3E3h1JAlB100PZ9PfSLtTl+AV2/aJhZj1TEDseBii5+YBhI6jrF8
         05xU0uK40Au6Bysln7Hvc0omAajkECvcGYuFFxmV/+Lr7HgEBGMqri6RjYU73XNm13wf
         iOUg8H55+reTYGlqsdzKUWoGBObHyzi/XxEyXBbvXQfEpDq1ubm1avNz79J2yja72bOo
         JFzsIPBijNKrBZEWIhFGd2zeSHLE1+ZdZ9blmISR970y+eZLBGij8MZdsmJG2CUBsDFt
         0I8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273978; x=1768878778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=c0tW0cjTR1Abk8o43kGHNmsrgxilbWK1gb5F6er0NT2B4DaNmZouIy7F20c3o1FW1N
         t/dnctLhtrETOg90VxKHvcR59mhpXYC4+47OCo47uwmzMBH2MYybRtJV+GUVSdN1sGnN
         BROauCMEJTma7mJfEcqbhsr/lSpdvybVC/eCniPw+Ul06G4ELcxR4GaiFp4LsFuNSPp1
         SAbjZVPywHnfpa7a/MjcJM/6KdrUrtt0fJ8muNQ2OGWzUQupzumvCy8R9YvrgPSgPtuz
         mRisjCqLS2lHnEoo9glAFRaV1JysJD6/Vi6L3enTzKh30YL03u6Ys0wPTTrVmtd8F3VB
         rT9w==
X-Forwarded-Encrypted: i=1; AJvYcCVXqAVcqlMiM+tODxGHvtCCNsKZQUvzAyGgbi13WYuPrUoA+r9p4UBMWxB78MCpiQDOz+YqGAA4RUrtXIyEpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YysXh7QVnY2TxIck7vZNrdtpydqgExFm+iRiqzp4tX1frCoOQAX
	KkrwcorcBM+0C/ulIXFWPEqjh4D9indAeJIXW+356DMwZUu3Mxx6hyZm
X-Gm-Gg: AY/fxX5TIMH6RQ96YGyZCE4L9+LjPHGnlG9TaiwFULccL1DUleD9zXxjt5iaF5mQDiU
	u9XyMyvCchf57myWcAL4I3B+u0FBkZR2isg+BFqHJoC/vQ2JTlXaAjy3n/KbK39Dvr8HJhRwR2z
	3gp95N7xvNRZ7Ty0jC40f2mXEumnJXAaP2wnh8EpzzrSu3mgEIPBzv+lgj847cgBwEPnNZVqUrV
	I3F/xN9Xcl+lT1FIbhT7WQ33Vi8XNU1pw+rvuRO4dLOJ5YnFJaA4Cw8578bW8OMeTApUEnkXlUm
	zhCCICQX9c7gA1LzOWsAcOlaLj5Ylnd+GE+CSk0k5KWcvOvm3L7eV+kyzOj8dNK2yNbzER/pRmi
	SxtV+PCz5EybTHOHvI03+nmTdYQLjtOhAjd7unFHNGJZD+shZWJgTE3fP/2zTEWAbMf6H3WCaJo
	vkx7gtGyq+oA==
X-Google-Smtp-Source: AGHT+IHcF7Zmu1veaf8u0eg/Kbb68KxKW7zWjXp5XrByj/JKfJyEyOkbbQZuZ3nalmLjzPkGlfdNOw==
X-Received: by 2002:a05:690c:6285:b0:78c:2473:ae79 with SMTP id 00721157ae682-790b56a66bemr171959117b3.39.1768273977917;
        Mon, 12 Jan 2026 19:12:57 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa592cdcsm75715147b3.25.2026.01.12.19.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:12:57 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:11 -0800
Subject: [PATCH net-next v14 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-2-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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

