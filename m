Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D84216D4D2
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646774; cv=none; b=GkHkZWlyhfH8LAEpjNzfVJCwvUU+B6Mm6ZiAWXge+eJt1goo6DRXlWRlmjvrtK1k6q4/XSvvCfFReHs5ER3UeJxLsEcFEf8iZ796Roqb5fy8cbt6B+jE4Gx9psZU8YJpZuCKuYrDl4IaqsZbCM0wUuJnLPI33qvqQ+wlKIx6S/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646774; c=relaxed/simple;
	bh=gGDd9b+eIPhJKP6IsUlyGBx9zga4xIilMlUsKve5RCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QHjW+1uqbCdkLBH+jgAiG++qHsk6YgrPoc4jw+kQWhhJjKyWyu44hzaMAOJR/QlRLhLOOO1A0jYET15exNZEY8zlL2r8H0QM1SuYxjaGp6iMdzKfU7tm1WAEC5QJFeVWUQxe4jH3Tv9eLGC2Ex+72/e3Y51z5GReFs6waZIw1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km3avahs; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km3avahs"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9145A40B97
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oEwta3nnRaWB for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::732; helo=mail-qk1-x732.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8EC9140B8F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EC9140B8F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=km3avahs
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EC9140B8F
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:07 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-79ef8e0c294so92119685a.1
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646766; x=1721251566; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVIqbNrhEav3W0++Ik3CGMaAVVSiaEFKng5Yf5v/RzU=;
        b=km3avahsGWojPIknpmyV5dfPN2cZd62JlicT81VC5kAO/rKqTZtweHz7HV26CzGTHD
         6viUu0i2/+d1/EMXt1r07rYS9lwxDgDxcLM/k48fTVejPf/S2CxSwHt6pTLVSE7qNrgy
         gj5JNHeuoGwr9srJdbC5+UnO93+Fdlcp5PJfdgF2ZeontejDDnPzldfGmbNj2Z5YgVxy
         JEPO6Ll05w3yENacgm9DzSbCgbkWa2iTJezEWIciRMiJqv58xfIBDqWUxuVqLLZRd8vf
         s1mzk1Y3w9q7cQYEfpxiTnXrSJLJJBHA6IcnfsULsM+wPuWJvo52xEdm2TgWIOvg2RJm
         gDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646766; x=1721251566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVIqbNrhEav3W0++Ik3CGMaAVVSiaEFKng5Yf5v/RzU=;
        b=Q4KLGm8a1ggIAqbk8s8+zyCgao4epxrEAkGLS8pBTEkM09sWy44p4LmZiBDEYVM8CH
         VVfvr98zDGhvCdU1N6LtFSauw7Y8HQCyojq+WAvnrVlcicIP69rSlQ/ZkXs+kzfIP7fp
         os4+nKvEwcdeXzf0Hc9v0EXsD6NRKPfV6Vef+mxTDIxzpWq263i4AiwICC4jNTSfoPQM
         nN6JFCG9r8CUmsWEWhIgjWs41CrqV8x93RZniCx9dGy5W+k5QaKfZY4P+9M9A7hUxLFd
         11LfdrCz6JQ/3rfUHMZpkPsXzN4odJhWsfnJWGHyEd+e+M0+X5Y0z7lRVmDGvcBajt8j
         nWOw==
X-Forwarded-Encrypted: i=1; AJvYcCUPtzXo1Ts5SgsRhKtRdZUHbYkwoTqKP/jT4ANEYTOdjklQzadKe+3wW0vrsSS/r8p+2c9E0uBgbsUeU1sXyRGuOnmS9BAuPt+L0Y18c+lrAtuht4ay+Wv4JA==
X-Gm-Message-State: AOJu0YwinEOBgymM4OX48lOPwFuhkJkEzNOecs/Y4UUHKAiVdZXw4Lss
	bu+aL0bZ4lGZcMHjCpSdAyUVx3ZTrSfcB5HSkjBlrcE2ItwXm/FT
X-Google-Smtp-Source: AGHT+IFI320bP+IbIdMehUjmnO755tB0kWKy6r95fV4jib7ke50hwNQJtvQqfOpqotKxyY96hgBfNw==
X-Received: by 2002:a05:620a:4011:b0:79e:fb4c:2fb7 with SMTP id af79cd13be357-7a1469bce83mr198013985a.12.1720646766248;
        Wed, 10 Jul 2024 14:26:06 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:26:06 -0700 (PDT)
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
Subject: [RFC PATCH net-next v6 13/14] virtio/vsock: implement datagram support
Date: Wed, 10 Jul 2024 21:25:54 +0000
Message-Id: <20240710212555.1617795-14-amery.hung@bytedance.com>
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

This commit implements datagram support with a new version of
->dgram_allow().

Additionally, it drops virtio_transport_dgram_allow() as an exported
symbol because it is no longer used in other transports.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/virtio_vsock.h            |  1 -
 net/vmw_vsock/virtio_transport.c        | 22 +++++++++++++++++++++-
 net/vmw_vsock/virtio_transport_common.c |  6 ------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 4408749febd2..fe8fa0a9669d 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -222,7 +222,6 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val);
 u64 virtio_transport_stream_rcvhiwat(struct vsock_sock *vsk);
 bool virtio_transport_stream_is_active(struct vsock_sock *vsk);
 bool virtio_transport_stream_allow(u32 cid, u32 port);
-bool virtio_transport_dgram_allow(u32 cid, u32 port);
 
 int virtio_transport_connect(struct vsock_sock *vsk);
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4891b845fcde..4e1ed3b11e26 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -63,6 +63,7 @@ struct virtio_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool dgram_allow;
 
 	/* These fields are used only in tx path in function
 	 * 'virtio_transport_send_pkt_work()', so to save
@@ -492,6 +493,21 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
+static bool virtio_transport_dgram_allow(u32 cid, u32 port)
+{
+	struct virtio_vsock *vsock;
+	bool dgram_allow;
+
+	dgram_allow = false;
+	rcu_read_lock();
+	vsock = rcu_dereference(the_virtio_vsock);
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static bool virtio_transport_seqpacket_allow(u32 remote_cid);
 
 static struct virtio_transport virtio_transport = {
@@ -753,6 +769,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
+		vsock->dgram_allow = true;
+
 	vdev->priv = vsock;
 
 	ret = virtio_vsock_vqs_init(vsock);
@@ -850,7 +869,8 @@ static struct virtio_device_id id_table[] = {
 };
 
 static unsigned int features[] = {
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM
 };
 
 static struct virtio_driver virtio_vsock_driver = {
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a571b575fde9..52f671287fe3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1010,12 +1010,6 @@ bool virtio_transport_stream_allow(u32 cid, u32 port)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_stream_allow);
 
-bool virtio_transport_dgram_allow(u32 cid, u32 port)
-{
-	return false;
-}
-EXPORT_SYMBOL_GPL(virtio_transport_dgram_allow);
-
 int virtio_transport_connect(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_pkt_info info = {
-- 
2.20.1

