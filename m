Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203507;
	b=AiXcgXfLLtPF4M1CuhQ+Ip83VVwvcV3Bdw6t3+Jk4U7KH7X4asi908vOeVG+XOurH9e0
	 alIPF9TBqKjj9Wn84DETLHqxzAIcYZQL8Kt+901c27i18EF52MVp/+lq4x+3qJwZ9K6OQ
	 8ryYeHvNbzDbQ99XAAacA/6/GF8o68DvhbwSY+E/e/NgiTvDOjGMdMRLI3wK+3UM0V1y5
	 fgORZI7sAgHYjWUttn+mISNzXwX2pxSb2v85byM0DS3NSs5efNpizbaawuDwBzIrsjCqL
	 ya1Amd8LwdQDHkRnZIMNQiOS8P0l4Ye0KmgAuTmrtaeptaTy9nEhL32bfJ6zZfgLw9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203507;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
	b=IYkF6xYWts5MKYfundiCkUnY+HgcHl+EBMeqYtE0dk8f15DDcFUBcf6aIdnSL/qiYxeK
	 yI8fNVDzjBkMWFkRiDacatx9Om/tl+xoXFhs/P1goRRL5/qGhhxR2M0meq5eZzHnQ0oQj
	 RViqFA/kyVTHBCxpN9vmxYps9Q5O8q8PuD0xdQNM6QuU83jcNTaGFAlHG7X814uIPY1zD
	 2iNNqS1kAbD6PA0Gsz2Qow03gYdGR3Yj88/nU34/SfbyFdUxd5ske8buDO5cN0m9BlKJf
	 iIeXdt7zwc/Fz8Bdfb2tsWADE05pSodoqZJUHCSWr0MvibM/t5kDMAgxu02SE5J4uag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KfXp3yla;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20960A5BCF
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA20960A5BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KfXp3yla
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
	b=KfXp3ylaM2Z8EzQx0tyZ4BW6hpt628CChsh4Y+ElYgn3W1ngPdi0PylydoTD+GIZPQQVoS
	dXykZPodJWxgSQoftI79wXnUHI8qf9JtGGJaVx6wAFTflW+1yq8SFUAgE6LGdI4JSorQed
	OQrdqMkJUSA+514aqZ+zFNBjXz0QPNg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-awzHyUOFOemf2G3rP7mVDw-1; Wed, 28 Oct 2026 12:05:05 -0400
X-MC-Unique: awzHyUOFOemf2G3rP7mVDw-1
X-Mimecast-MFC-AGG-ID: awzHyUOFOemf2G3rP7mVDw_1793203504
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e17d30a79so779798f8f.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203504; x=1793808304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
        b=zIykhqik9tyetRFZ0m+6lJaIB3aQFtBhxBftHdBEVERSeale3R+VvIGtx/V68irjdn
         ZEityYnJO99K3mP5JIM9ThPZmlmVLZT4ipt2EmE6pKyDzmUk8Dc2AZPGXOv06W0txC2k
         JKVeGNcAsU8m+4ruO09xdgGKQ853DQxNgiNIT6UiM5YJRleqCw9gC8X+7mV/JthagKZn
         nh69qonqmy5iRuVw4jMu2Os+f7dD0L3nBrZr8NVxMFcZ6ebtwVgc1Jzrpi1278ppI0+p
         2BtvKEdETEa3Eg6Xn6cr2cidy0yCJs53CtnLRZCdpwK+TjQvmyTxNl0Pqut7V9K1yX45
         5bYw==
X-Gm-Message-State: AFq9FYK4vKfwgGlDIdQ8SCfQvsUgBNSZp2pUsLH5dVhKdtQu5VmtSHxK
	UCBFfjidGIM0lNG/lyjeyw4ibps4gWwGwkpUez0G0pdGQuxF60/Kfi49yn58quJdZbnbIVPkTp4
	ycvU3SimVfr0ypaf1AG5lKuJo4mh/irkNZaBaYjYwC6VqvlDLzChCY9FabZoRGAP59KII
X-Gm-Gg: AYBFou2R0fAOvtR/+m1WBgRd5pCxClZyizVtaRRu7Sj8UtV1l9ZI9po7OxedHryThUk
	QarbDeSm3gAcA3/MvHa9ZsSdcZ+lek79p5GYZmCL1qULeEapez/xfQPxnYq3/1eZn8+rna7IYrT
	HARQIsvnstNfNOV0aOeoli3M7i7Q/Ss4Asi9V5OsdGtBZqjOtDz9BfX1BpcQnyHPhx/c57AuwDU
	5KPnIBxD+v9EGrG8PN3Pu69yFJvCsEJpi7/SnplaRWrhzlM5mlygvmRgIAf1Ad6dl6XIp+Ix3A1
	JLB5cQzyHWSjx9LjPcGYQE0KB+HmuhM7QSeHfqhxLHUW84bEmuFmLr41ZbFiCaec5FMwaeyDuSB
	mXiw0rwmr94tC+mOzpmGlAGoqKQ4Sn83gVKIb5/VqqSDjunf8PXNMSFBu8QwxoAAToVnHOpPWwB
	fxvP+niLjTWnA=
X-Received: by 2002:a05:6000:98d:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e5d567ed1mr7017683f8f.7.1793203503978;
        Wed, 28 Oct 2026 09:05:03 -0700 (PDT)
X-Received: by 2002:a05:6000:98d:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e5d567ed1mr7017631f8f.7.1793203503646;
        Wed, 28 Oct 2026 09:05:03 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:05:02 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:34 +0100
Subject: [PATCH RFC 5/8] vhost/vsock: negotiate datagram support with
 guests
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261028-vsock-dgram-support-v1-5-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3464; i=slp@sinrega.org;
 h=from:subject:message-id; bh=S/4WwL5dbPWCiZa0zeuBb6RBsuWeJgQfZUwqCMWgNGg=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0e97Xa4zjSMJH/xL6mXhEFJLr5iP+9ch7tW
 39VyLppJZSJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHgAKCRD0aSeNLwwC
 NRheD/402018X9FBIyAMMgECnQa6yDcTR5QuwyzPlGz5FU3Usm0YdBiY4B7W9pjUCrlUNUDsPBh
 ksIdh4bV9svFPsQ9oCZgZRwfFoY3hSJNnyvTN3tE7MYRPA0uZZpTQACnKw0FrTz2+luenFHGnF/
 ycD0KQ0ejq5Uje3XgSzl9vNFIaNQZjgV1ii62A+qKzTOoLDxcYTHcYKzkpE0O731ZH0P9qRLpME
 OLusu+MT47wAqaWVvGA7v+F7q+NIO65WdytU4jx7KxqIdFFuI5B5zqBReSNOcW0u17DiMcUuWhJ
 87+N4tt2foVeHlcNtLGyi8A//zJuvc0zmEuuVi39QStNZyDYyhF4xq2T168g6Jw79ok+wCfHZFp
 XtXcmIp6Z0Uso6z5/fU7AnJvgCHAaJv4qAj5FB5nkuI/NQwo80oDApKvKRWoyB4B/WkuPwbZWVo
 y6dGBTrEINxRHOqywyEEEvvz6rYZe3WY5naK0fpnr+HNHVfBiO6ias62HtsrGO36MnE2s+sHJC/
 cpYz0guHd7QByD6nTn7TJJJTjUk0Q1+7sFkxIBBTryZ5PxAT/aVB4hmF7eBeQFTBqvY34ccn4cP
 CqzmK8OoKeB1Fshdqvito+Go6gpfCtRrXApVO13D0UFAnSn2qxBp1TzjcJDhAl48UAEETZHxUHB
 fV584fy3LMal/ew==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HYbWAK8Kk7R0XFUgScMBbbHsKfeibm2mZNdQOYeMqNo_1793203504
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
negotiated value for each guest.  Keep datagrams disabled until the
feature is negotiated.

Use a vhost-specific datagram destination check to look up the guest
in the socket's network namespace and require its negotiated datagram
feature. The common virtio implementation supplies the bind and
message operations; destination validation remains in connect() and
sendmsg(), where the remote CID is available.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..eb2fbdb721aa 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -32,7 +32,8 @@
 static const int vhost_vsock_bits[] = {
 	VHOST_FEATURES,
 	VIRTIO_F_ACCESS_PLATFORM,
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 #define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_bits, 0)
@@ -62,6 +63,7 @@ struct vhost_vsock {
 	u32 guest_cid;
 	bool seqpacket_allow;
 	bool ever_started; /* set on first SET_RUNNING(1); never cleared */
+	bool dgram_allow;
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -436,6 +438,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid);
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port);
 
 static bool
 vhost_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
@@ -460,7 +464,7 @@ static struct virtio_transport vhost_transport = {
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -516,6 +520,24 @@ static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 	return seqpacket_allow;
 }
 
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port)
+{
+	struct net *net = sock_net(sk_vsock(vsk));
+	struct vhost_vsock *vsock;
+	bool dgram_allow = false;
+
+	rcu_read_lock();
+	vsock = vhost_vsock_get(cid, net);
+
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 {
 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
@@ -737,6 +759,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +913,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0

