Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9EA20A5E4
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498134; cv=none; b=V9WaLI473+8xOWCeV5JrOHkt6/LiuyJ5UjmU6+RapKAc0z9Xmc9VsbuLCMjlDwiFPOxYijKqgZLNrEPE9AHE1XqYZs8Its9cZV3mbvLC4cXGkJAgVJWxVL58LF8I4WWqMm9AoiHUaTsK7viwIqNJt61CgcwGzeXdoatUQvCY7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498134; c=relaxed/simple;
	bh=N7oUWVYpspVtl1b3a9o1m38utpVtuI2HVqr6S2jFP5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=u5CZ5oSA3AC2MXN5g2kwoRIGhYfvg3mPP46Y93PVuMTK7ZkfhvgC2Da+L/3t3xFKFKgykV/6tKz9Ku2ZXCfhNjNLjmi7T9JJ3T+3Xjz6eg0CuvIqlpHTfihT1/MO/JS6NwDdngS7XfD+VOmtZL3Wm7RfFrP2hOCU5tK7yeSRs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXmK8FsK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXmK8FsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCCvBVF1oU547nRVhmRIMNs6MmiGORia96sQhicKNFk=;
	b=dXmK8FsK+Hkym5OOK70I4vKNelHAqqw40lJTqaZTFr9MvPzHwPdZqxUEA8BA5KaVAa3cQ2
	xntEE/Y4uziL8b0SStX1rUUBlPDvDYO9bIpUNfOC4ZeyYbhviA93LqD8KIt5SIVd0gG+og
	OwPK+ZQpkEpHu+4xYtrrrk7b2vPDSMY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-1ihUdI-KMESnFR0Hca_Utg-1; Fri, 10 Jan 2025 03:35:28 -0500
X-MC-Unique: 1ihUdI-KMESnFR0Hca_Utg-1
X-Mimecast-MFC-AGG-ID: 1ihUdI-KMESnFR0Hca_Utg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso12572805e9.1
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 00:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498127; x=1737102927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCCvBVF1oU547nRVhmRIMNs6MmiGORia96sQhicKNFk=;
        b=qn3+qIlI10NjvdINC2f+ZdAq75fBDByWHaTe4a9M7heq+3wPNob0rH8Lswr4oGGNDx
         X3zF0kDenXe3pUs+CppORReYqzeVgsDA+oeYvujAGHBkOIX/nVH7/goErRaNZV1ixbr+
         t1wdIcBk+kak80sXQBRLHNHhsjTUFoW4BsPmhG7nCurSLPQ13viBU0WUXCP7ugWzm6E2
         PfNBgx/bm9Or/zTCtHB6Svy7BvzpkKULZoOEp19fmNHG42GlQMAq/zVtn5zWIRn9xxan
         GU0aVkvkrWQpAxGUTGe6kzlyQoqV+qMrPVUvZqIp+88Mwc0qaXEFLewnmawz3BcsXvXd
         GIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDbNhY4jPwK2gua3aQCjGMvDvmZrqUfRG4TGfbcClXdczyTwv1gEFz85OLg/G4XGZ7k7uk5QSR0a3EpYDRkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YziEnOdGgZWeUxuBNlIp3zU/ONTjRztkp9D4jri2e7YMgm1Anf9
	9gH1+1s4NOXHw80Ygml5yh+aJoiu8gBJTOTLYpbJB7/96Q9mGU5PakzP6LuCsGfjhwdR7HFTf9d
	4/1fV6zJfWmI6BuZ/dblxRh+f1vLhJmwlOFzhEWTHRW7d3GJe7gZLyZEE/pwHXTFA
X-Gm-Gg: ASbGncuBL2qJsD2gKqpbQn6/Bo3lSlEVmOniJ5ykreS0ylu1AlmVm294gh+zLO1QVxN
	XHBONvR/dtDKagAueMVw3JJHsuiiDMJMrWHUmPDjhp32tfrcuNJ2mz5ch4tM5u6eammVMi40PMA
	CISg/iXgKEJ9xLmjq4pGh5W8ldGUYzHnrldXz/0PSzpgtXGexgVft0kONez7luZtZhqCn+PFMFc
	jdpa+8kFgn1Xle9YU1QLhsrwgjPa2mk4DMNOqdyHBoiPRs=
X-Received: by 2002:a05:600c:3b08:b0:436:18e5:6917 with SMTP id 5b1f17b1804b1-436e255ffd6mr98683135e9.0.1736498127462;
        Fri, 10 Jan 2025 00:35:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXYbonID+NCEiPxf2xSK2i1RLGHHOMCpGw+AxBXOdkAZovSc4AvlC1EcoGIJDqTU4Av556Sw==
X-Received: by 2002:a05:600c:3b08:b0:436:18e5:6917 with SMTP id 5b1f17b1804b1-436e255ffd6mr98682465e9.0.1736498126795;
        Fri, 10 Jan 2025 00:35:26 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38332asm3858150f8f.23.2025.01.10.00.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:26 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hyunwoo Kim <v4bel@theori.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org,
	syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com
Subject: [PATCH net v2 2/5] vsock/bpf: return early if transport is not assigned
Date: Fri, 10 Jan 2025 09:35:08 +0100
Message-ID: <20250110083511.30419-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110083511.30419-1-sgarzare@redhat.com>
References: <20250110083511.30419-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xhu2VBWiK_YumOE2c6AlhUob6CkEd7I8iphXv-wl8PM_1736498127
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Some of the core functions can only be called if the transport
has been assigned.

As Michal reported, a socket might have the transport at NULL,
for example after a failed connect(), causing the following trace:

    BUG: kernel NULL pointer dereference, address: 00000000000000a0
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 12faf8067 P4D 12faf8067 PUD 113670067 PMD 0
    Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
    CPU: 15 UID: 0 PID: 1198 Comm: a.out Not tainted 6.13.0-rc2+
    RIP: 0010:vsock_connectible_has_data+0x1f/0x40
    Call Trace:
     vsock_bpf_recvmsg+0xca/0x5e0
     sock_recvmsg+0xb9/0xc0
     __sys_recvfrom+0xb3/0x130
     __x64_sys_recvfrom+0x20/0x30
     do_syscall_64+0x93/0x180
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

So we need to check the `vsk->transport` in vsock_bpf_recvmsg(),
especially for connected sockets (stream/seqpacket) as we already
do in __vsock_connectible_recvmsg().

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Cc: stable@vger.kernel.org
Reported-by: Michal Luczaj <mhal@rbox.co>
Closes: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
Tested-by: Michal Luczaj <mhal@rbox.co>
Reported-by: syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/677f84a8.050a0220.25a300.01b3.GAE@google.com/
Tested-by: syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com
Reviewed-by: Hyunwoo Kim <v4bel@theori.io>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/vsock_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 4aa6e74ec295..f201d9eca1df 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -77,6 +77,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 			     size_t len, int flags, int *addr_len)
 {
 	struct sk_psock *psock;
+	struct vsock_sock *vsk;
 	int copied;
 
 	psock = sk_psock_get(sk);
@@ -84,6 +85,13 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 		return __vsock_recvmsg(sk, msg, len, flags);
 
 	lock_sock(sk);
+	vsk = vsock_sk(sk);
+
+	if (!vsk->transport) {
+		copied = -ENODEV;
+		goto out;
+	}
+
 	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
 		release_sock(sk);
 		sk_psock_put(sk, psock);
@@ -108,6 +116,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 		copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	}
 
+out:
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 
-- 
2.47.1

