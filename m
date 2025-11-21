Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C55D2F6924
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703897; cv=none; b=ruHSpCQiOYDIbAcv4V+dN0wrvI0D6fZfm0jAj6wZWic4Xva9nyidzmUVTxU72SGXHxKD63G5lGsjDcHr8jjU+05XvwWX/WAa36160fuGt0af6S2I6kEg3OLHsh3DXJ3T+PEHr3HiLW++3ygk7jDbcHbRkH1xamfxW9r0SfZaaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703897; c=relaxed/simple;
	bh=fsBBb11rRzR4Q5pi4KL2AyZQEMokJCJhZHnuBGJ1xhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2vA0rgLiTpnqOPoZf37xdQM3ki4UrHIlZQBCKylImD4xPjpYu3xGOlYay+0X06Wj+7VViewUOacpe18N+qhd+UnNba3TBy64s8yrvWr/+d83fatXZ0Wl+y2awXQA1rVg6wXv4AJ7KVnkfT5Zv+TKadcAZdLd8FMk7hXv8JKNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMR0ktvO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMR0ktvO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297dd95ffe4so14270175ad.3
        for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 21:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703895; x=1764308695; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eC15iyYiDR+Sm1hgPKilCqyF6DXQAH/mQRgGwIW2dVA=;
        b=YMR0ktvOFdy/FAXVetifUyMvCNuSdqEJm9nqrAS/HNXdysMt929gEQmx3mA3jomkqY
         rJdXn6GhZ2fBFDtmSJ/n7Q21jEONiBbuG9xbvfOxW4tn1NsUMLuc6bkGUqMjOy/b9+tm
         yO7xog9jNOOSWe8GH9qTgJLGNdoYzP7bLXyZGazsidjKroAL+89AE+Ta2TuOIpOVDe4y
         +j5GRwMv9UdFPK1mXYDw9XZcVyoSzH6J1ywQgzPBWbs5XOf05m2lQqAB1lHBio1lkMSr
         DwcBk+q0J5sybmp9Mkz8UVlmRmgS6REaI/de9hHFPyYnWKBvFsMDgnkV7/cK1sr1ZcBK
         kngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703895; x=1764308695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eC15iyYiDR+Sm1hgPKilCqyF6DXQAH/mQRgGwIW2dVA=;
        b=JYO80ZkcKF1MbKWly1HZFSs+iV9m4DPssE/Pu64jsq32FYZYFF0I/Acg1lJO/1ztME
         4dmhtHgLe8dl2e7RLRYLET+OdxL4ZBSQIPOpVmismBNEhpLRuBb+vuLKssRnB/RFZvvq
         rpskw/3wlGMk40Dr3yw3b52yh4Yc+wZXKletvnLv7i2cBbWvax4LqqYN1R3XjmTBR6lq
         SvMTyvm9GruxRPc7HyIQwqkGJ4kaN5oiwtk3cokvxTXEIHcguVS+hTLKg/BDIfcnpiYD
         zQba7r5PfzTaExlPW6bwzKxkRAAHwVBloObMgtW3gnS7K2vRLxIC/Lr0l/1W59ilWrD5
         Z32Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyVfJh8S/rl1eJj1tRqbzWjUzk4m1cvzf9V4kVd819+0JLjusU6+FwvsZ/uW7fdmtX4xRV5W+yDOoT1TPJuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5fUroldJU/YRkVEuovoTgXIExiU1lSPrkeeF6VmUDexsjiNDH
	JMBVXdG5sKuH1GVH7rLLKJbFTPvidHHCvqJWNy0hcR745t55+cNhAt9e
X-Gm-Gg: ASbGncutunTwiFkzxkpNqXdluZqZ3zAKzPsfiqZFVxNNYNohLCuA7hbzFySsR5IzAPY
	Wl3bgynfzJjdUxNP/M9oltNIWWvvfCMI94YnYLFEzml1nEGVQds9Vlfmd/cmxOx34MiDz6UjvLx
	Aj+L7qwr/KFJNt781GQ260T2/6ztxtXhb5sAbHVhGTKui91EnJGjUpqyEXigW0Ne5kIvWGtCOcy
	qrKsjMlNe7fd9aRJc4Y7+vWljoqCWmuHFLjE2XKakqyojp0L6mVW/++cQtangRHa87qLE6Nlzm2
	EbDrhzxXTwqEmbOODGa/713HRogzOGkQMHr7bDIKbTxdQrcPQEguNCMXnCNF0ZLgppBg2FaMPmX
	0P0m/wo55pfEgnaJvmTRGd8ETg9+sUEKp976S8WrcvJuOePeJe2t9I1LqH2EpEeLci/ApO8M0+H
	o9hhPaVXbeEAczPA3B
X-Google-Smtp-Source: AGHT+IGa+OjNw6ZNUabNVrbiRm1cN34zeqSyarDkZ/uyC1wiDWIlKAxvnZ18+6IgwXZkACrQhhBeIQ==
X-Received: by 2002:a17:903:2acc:b0:298:efa:511f with SMTP id d9443c01a7336-29b6bf3bc9emr17507735ad.39.1763703894492;
        Thu, 20 Nov 2025 21:44:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a870sm44383905ad.34.2025.11.20.21.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:36 -0800
Subject: [PATCH net-next v11 04/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-4-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
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
 Shuah Khan <shuah@kernel.org>
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
index dcc8a1d5851e..675eb9d83549 100644
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

