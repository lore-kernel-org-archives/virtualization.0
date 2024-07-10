Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8513D899
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646761; cv=none; b=W2IwJaMIW1DcljW79YdwOBrfB5XWJ0RdUOTY8J7hPo/qtnXe37K+N1j8xdGUMoG33pgbh7MEr6E3g/vy8kuQHpNzOsygLIJiVkXmmjto4JfIPW4CMlD7einv87jNrgfPq8LM3/4VljroGQ7PFa3ZF/M96vn35vG1iRzIlIYbuFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646761; c=relaxed/simple;
	bh=4OTZt5riyKFHkA+zfse2GDqT3SsWJIfaNWPsNxmi0Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ER3YFKY9SZmuJZrMiTfH/ILXPGaaHI5uERIIxvqe7K2CNFCPcOAGa+cznF5tvEOy/Q0Xs2XW6bnaTLAhGeEY767jIAI3wwJJ5qghxGXLCJZ+vTGrDSgJQNBXW6y6b9BuuwmgqsCbN0c0DKgVjsVn87n93AxcMmqrzWxO1ygwKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh2uYwjr; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh2uYwjr"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9530140142
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pizs7vZxzWsQ for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:25:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A6C7F40126
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6C7F40126
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Jh2uYwjr
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A6C7F40126
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:25:58 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-64f4fd64773so2722327b3.0
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646757; x=1721251557; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHc1ID0rf+ZeWARkVYcA3IYS3VCCqmuUAjyfz62UlIY=;
        b=Jh2uYwjrSMy5C7BM9r/Tlg7LgtjbPLrubDD4XoRnIftqJ07MRNurq9YKWPQDiu/dWB
         SJAx0CnrMrr/CnmLka2zfkjOseRmXhsyD0uNm/pqkVmj5sKVzSCtWECmTgPjv8ANYygU
         xG807L5ohwC8Hq24bTz5pYz0k4E9DubiY4Xf7zB+vGy5h0KgV8qVXraQmhjA6jEdXJ/s
         PC5MnAf98NInXBPaiHyPibq4udO/NpduM9cAl8gOB0bRIbXPL/23RwT51Bo/gPomuTH+
         Vnqly1IPG/lp6KnmezlbryKCvNhLwYi2IYMNd7nHOLitfiNvC3pxopZEHmQEnV9hkWCL
         zMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646757; x=1721251557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHc1ID0rf+ZeWARkVYcA3IYS3VCCqmuUAjyfz62UlIY=;
        b=jddKCpC72Gttgf6ECEkoQ6vAnx9a034AqY+p6QeLkprmpAAuu7Qk41+2hUAVO5SbQk
         vhafKWtwqgCLzM6qiNAjjIMOIpjwd/x+36xmtGAJH7r7rREe1kUbflVxwkN/lyAPyJCR
         BtagYOuB685eLiK2YYZOO/NbDUJh/3UeE/Z5py/KxUv4Rn4kNR2qpVXPcJGY0WMsD4D3
         DlJM9K5IiVldlUNcDfS6vvizD1z58BXX2Sl2EzIMuoWf+KxRpbQ+z0JOS8hEsWWyWre7
         +xp3WjMtKcW0MCfzEwom7yqTlIh4mYh/Kw0aSdxOrkGsxWN4EsfhGx7uUu2Rr6BVpYWC
         QEAg==
X-Forwarded-Encrypted: i=1; AJvYcCXp0FBhFOsKhK1bifOTVuq/nnCSqIft6ejsPIFpae+271hFoAeNiw18Y6/lEqDpe88PtnFflhq1EnF9Rja7Bhq+2nAMOrBJBtpEqVIKNEufqf/LaFIbYPcyBw==
X-Gm-Message-State: AOJu0YwiZReRf8oTXMv18tfQGk+MUnp19fMeQ5n7Azh1iX7EQVMl+hPV
	PX4U2h1TPOCDxiVPDMUWB1KRdVw59n7wN92ivmhfUakAyOg8R5tg
X-Google-Smtp-Source: AGHT+IEjPkFnHsMfkPchn9B+Jdi+q1cCzl1WkWEy9p/OPucpa9Wk0d3OtoJt4Ti9KZQE0OkyHGT/ig==
X-Received: by 2002:a81:6982:0:b0:627:a917:bae7 with SMTP id 00721157ae682-658ef43fb82mr66490157b3.30.1720646757528;
        Wed, 10 Jul 2024 14:25:57 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:25:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com
Cc: dan.carpenter@linaro.org,
	simon.horman@corigine.com,
	oxffffaa@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org,
	bobby.eshleman@bytedance.com,
	jiang.wang@bytedance.com,
	amery.hung@bytedance.com,
	ameryhung@gmail.com,
	xiyou.wangcong@gmail.com
Subject: [RFC PATCH net-next v6 02/14] af_vsock: refactor transport lookup code
Date: Wed, 10 Jul 2024 21:25:43 +0000
Message-Id: <20240710212555.1617795-3-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240710212555.1617795-1-amery.hung@bytedance.com>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bobby Eshleman <bobby.eshleman@bytedance.com>

Introduce new reusable function vsock_connectible_lookup_transport()
that performs the transport lookup logic.

No functional change intended.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 net/vmw_vsock/af_vsock.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5e7d4d99ea2c..98d10cd30483 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -424,6 +424,22 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
 	vsk->transport = NULL;
 }
 
+static const struct vsock_transport *
+vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
+{
+	const struct vsock_transport *transport;
+
+	if (vsock_use_local_transport(cid))
+		transport = transport_local;
+	else if (cid <= VMADDR_CID_HOST || !transport_h2g ||
+		 (flags & VMADDR_FLAG_TO_HOST))
+		transport = transport_g2h;
+	else
+		transport = transport_h2g;
+
+	return transport;
+}
+
 /* Assign a transport to a socket and call the .init transport callback.
  *
  * Note: for connection oriented socket this must be called when vsk->remote_addr
@@ -464,13 +480,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		break;
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
-		if (vsock_use_local_transport(remote_cid))
-			new_transport = transport_local;
-		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
-			 (remote_flags & VMADDR_FLAG_TO_HOST))
-			new_transport = transport_g2h;
-		else
-			new_transport = transport_h2g;
+		new_transport = vsock_connectible_lookup_transport(remote_cid,
+								   remote_flags);
 		break;
 	default:
 		return -ESOCKTNOSUPPORT;
-- 
2.20.1

