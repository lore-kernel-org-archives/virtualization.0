Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C417202C4C
	for <virtualization@lists.linux.dev>; Wed,  8 Jan 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359596; cv=none; b=Ek8qpNDev5yqAe9kyzGv0tFOttsEfGWc9p8hsfzMaObTtQF6rtrIGuOhTGUZGpvy/Hin9JJ32wkxVJZLOHsJlBgW3EeWue4WzEDi2PEr3o6nToU/rgAV/W6qOCUmMRJSlmZdyhoDK48sv8BAQD5HeAojx56x+MQmi7aWY10C3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359596; c=relaxed/simple;
	bh=NW1NN64WPOb8zvTk9pQc9y9wJMAUw7k5KI4tbn3qy4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=N58xON3gjBZUOjMBK0Ig4qcSo7XPsiJRL+Mhc+jmCXCB9Z642NFgwCTIahWynDNbNauoIii3GmwnVaiE29qmnB2U38LJ1CrAOf99gHfRXBC6repCniX7rxHif5COUNwR141F1SJt3i0UNzGHa2PM68Qh373L8arrtoTswnisTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7Ikg1XA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7Ikg1XA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736359594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTpnjYdFe65i9cQrDrcRqhmpYDaSR/fVnChURrprIX4=;
	b=a7Ikg1XAe6BTlp4lfdSEPC+NxweStz0jygHAgidBg2GGEryKZ2dkEyH2ttXkf1S6XQPOMg
	GcJ/E5HaiPHqT+DPaYQ1BlTA+xpiqeGCX1u68VeYBz6TSC881oDRnmdrM4XyP7ONDS5WGv
	CiM4A8N9CnwTFoht6lKEgSj05Ral5GI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-YL2fsi48NdWMYOkAHPcFmg-1; Wed, 08 Jan 2025 13:06:33 -0500
X-MC-Unique: YL2fsi48NdWMYOkAHPcFmg-1
X-Mimecast-MFC-AGG-ID: YL2fsi48NdWMYOkAHPcFmg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862e986d17so22259f8f.3
        for <virtualization@lists.linux.dev>; Wed, 08 Jan 2025 10:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359592; x=1736964392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTpnjYdFe65i9cQrDrcRqhmpYDaSR/fVnChURrprIX4=;
        b=B/lcDrDb61/ob4H4Qz3U4N5uL5fSPc0Tcbz1XqPzYpoZnG8WLzp+T878NP4tBWjmwx
         GGJwbhHrkUqrwt1ztMt+EZ4cYVY7/yIOvWyXo3PtMop9K4JRUCyyyxQ5ltpi34lipw+R
         ZKr+pIPMhduHfF5RG4lHEkyChbTxgvFnONZ5DfgCa8kqq/8ihWfKF9EYyyfv9kPqMj8y
         Rui/Je6tQd+/1oazFAKIavyIQChTxAnIeFF2GGdN+mEJfj9QfA64hEyo1VOAwjpTsYeQ
         hjQcflSHnV8Ilg/AmfFS1w/2A5zlMt8DpSFyUHrjuXvGAVuxq5yW3Bjkbf5D6qLOAytF
         HJOA==
X-Forwarded-Encrypted: i=1; AJvYcCXk5kXImggrQ7So9mMO3kCLmohATWfWRlyKazK37LvFPCBZzuOeex0G5jfKqfRyeQTnMqFXNSf3tK+4fqPfyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZTAM+qwVbEYmCSp2tRY0oDlbxXVWwRpfKsKd0AEFNntyy9GNI
	PluDdwMl+8DcOTpXbE7UOrzvwMrRmhrvkip9wsYb7qOoLdhG63FMXu4RZ6x+L6993OeNVdnzBXC
	5TAusVA3u4QHb6M5+rmH3djjjXR3dkSeknVudSFH36EJPx+QI4DHhWcwSDUC4lkxW
X-Gm-Gg: ASbGnctQRVCaEjoJaixkV0J1mfHtjGPCLu00/ONF/tf/E0CN5vk9b84E94DCb9weI7J
	y1K4jF/1gOHIC27RhBdCnOOZ9KxnJ8IodAnxAxKrwZ+WDztITJYsIRdwo9pAzKnVf930XH0/EWN
	VCJuwC9J0j/8gvaTOgk4tkNLRFUiZ3S5Qet2cdKmc5Vn0YSGsCHJE9kHpVmGALOWo10DDAdPzq0
	PCa3YvzYTRrVzAB+NVJoDff5rA9c0pdKR3pWYNUr7l+2Zo=
X-Received: by 2002:a05:600c:1d14:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-436e26f6d80mr37370995e9.30.1736359591816;
        Wed, 08 Jan 2025 10:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTv/Bx6C2k5LOcLLY/XN2JmilQSz5qyKDCjlMy44PV1BJ3rFBTpqkU5iqtg5HftWkhRLAW+A==
X-Received: by 2002:a05:600c:1d14:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-436e26f6d80mr37370685e9.30.1736359591257;
        Wed, 08 Jan 2025 10:06:31 -0800 (PST)
Received: from step1.. ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89fc3sm28849325e9.30.2025.01.08.10.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:06:30 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hyunwoo Kim <v4bel@theori.io>,
	Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org
Subject: [PATCH net 2/2] vsock/bpf: return early if transport is not assigned
Date: Wed,  8 Jan 2025 19:06:17 +0100
Message-ID: <20250108180617.154053-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108180617.154053-1-sgarzare@redhat.com>
References: <20250108180617.154053-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BiioVWyhw5I4zZ_q0pqJV6wGqS1Iat2ljjtRZnkhn-k_1736359592
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
Reported-by: Michal Luczaj <mhal@rbox.co>
Closes: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
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

