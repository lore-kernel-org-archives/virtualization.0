Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4FC16C873
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646771; cv=none; b=rXtO2zhY3DN7atDyVym61+mkUo2ENNgCKXh3NYpZLaUXmm5DtxnB7WwhJFAv7FlUwwD85QjcY38WIAq4NHVm8gQUfphHwBoP/JxqAuW/lkJvmWBpNEL0uMPeeHA97qa1xkP/TCGo+47GHiGinPOVu6yAdaARAjwqwqPg6FBdw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646771; c=relaxed/simple;
	bh=aa9fCTbYzE+aisD6RqXIAVWYsXTP3Jh37dzQFu2SwWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TexlLCGmsI5c/XQjMxpuFfmmqXkIAaj3rh9EpGTFE8QVe+YtysnHMVykQ3ZMg1Pj1bUM+fDV7qcGjl6N6GJgGNNgJsK2u4qA/oe8aRCDsKh5GH6EssGBetBkfx2isSgBwr9V6ki9Fgu8wvYfixM5rHlWo48AfNUd2V46MYfCx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSteeDqz; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSteeDqz"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A818440C7F
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qynwz1gKUzGq for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b32; helo=mail-yb1-xb32.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BFEB940B97
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFEB940B97
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BSteeDqz
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BFEB940B97
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:06 +0000 (UTC)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-e04f1bcbf84so226885276.0
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646765; x=1721251565; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNa2JyqzSfsQHlae80C+dAnyTQSrxK9qhyOYTj2h2/o=;
        b=BSteeDqzuDmNMjwtHH009o1F+mJDcfvRM0lgKBmDEvySnH7TcTGlsVgIig+sjdM9p4
         aVGlx7pM3EF+opO4V+z+Pyrx6nJDtwFsk1mgdhoISq6gkxETtBx29REvQSIDdmcQf2my
         G4KP5fRDYJ9rYpgiGNPnydZ80TEaPMYQ0M9E+tFlikvOsjY3rBRJSpIB5fdtdvzmaqR5
         qNWoRvd+TfGb7RLiYl359F1MRdesYZVI7GeIqXH0foCIfT685G00gLtGyISYsb6cFXsJ
         358bRIa22nxQ9kY0Xj3+PRRaaHjEJSVq3Fx2MdRzeu4Ud3ph1fBfLxlikBMa/7KoSUon
         TZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646765; x=1721251565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNa2JyqzSfsQHlae80C+dAnyTQSrxK9qhyOYTj2h2/o=;
        b=u9o+GtXyDOLkWqpyb5ajkjQDG8loIJNRx2Xk+wLcSkUwHOYFi31vKMy+U+GtpknIC6
         gTQFAkVJ7REsSHbneumiocXdg48W4YqZNeE1GIanVNp8bBR2QuWjaYOCcRE1HpNrJFEr
         4dKXp+MZqgQTFxCS1lJvOG30/BsURILY+z2mBG+Xu+8HvMJGlbI34WlxjdPQYZHWIPel
         g4uJGreup9qvNxeOPbsB6QpKZ9pd+QkFXqxXhGJjCZTSSFPze8OT47CmOWp84Y7QeUMc
         Yp7jylM8ShJpZsFcIzUJ2DMGhPyPL4hHOTF0r28KCSVTsY9KG8VRTrf9SBY+WZl5vbtP
         IfpA==
X-Forwarded-Encrypted: i=1; AJvYcCX1uv78fuPCZcVgM0qhu4NdVUuqTUq4eDeDqnXp1MrBso4jdayEWf+50ADsBAKktvNuhdZVoTDiD7YsnIkzvf0cfpI0UlEMxMJqkpnTlWXPbO80TEoIVyOIsA==
X-Gm-Message-State: AOJu0Yyioi9ZZ3I4veSFkcRfRG+jBEUY3PB+9oe4gbTdDIaj1rY9XDLI
	CnGxO8aPgGPl+kBXFIv78m4UNMeukuVP3pM9UGwxO4mYSIlBOhYL
X-Google-Smtp-Source: AGHT+IF5ioq7BkP55ZrDd65MHpqGoaQfutI36NHEnLXbX07dGmO7XnmHfZ+Wg65ipK41BqyPE67tdw==
X-Received: by 2002:a25:7416:0:b0:e03:adcb:f8e8 with SMTP id 3f1490d57ef6-e041b078c55mr7655917276.30.1720646765536;
        Wed, 10 Jul 2024 14:26:05 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:26:05 -0700 (PDT)
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
Subject: [RFC PATCH net-next v6 12/14] vsock/loopback: implement datagram support
Date: Wed, 10 Jul 2024 21:25:53 +0000
Message-Id: <20240710212555.1617795-13-amery.hung@bytedance.com>
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

This commit implements datagram support for vsock loopback.

Not much more than simply toggling on "dgram_allow" and continuing to
use the common virtio functions.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/vmw_vsock/vsock_loopback.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 4dd4886f29d1..0de4e2c8573c 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -46,6 +46,11 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 	return 0;
 }
 
+static bool vsock_loopback_dgram_allow(u32 cid, u32 port)
+{
+	return true;
+}
+
 static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
 static bool vsock_loopback_msgzerocopy_allow(void)
 {
@@ -66,7 +71,7 @@ static struct virtio_transport loopback_transport = {
 		.cancel_pkt               = vsock_loopback_cancel_pkt,
 
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vsock_loopback_dgram_allow,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,
-- 
2.20.1

