Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8611FC7C5
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536141; cv=none; b=dr9SC1rFGJ+gNFRhitVpi8OpsOogwnKHfG4w+iq91LTuLVrxhvT/SnyKrLfM6IPORmwNg6xjTzIhLYcLGoz6ZWxrvEjrI4lXBJG53lM47Myco5D/fxccggsLVR/pwZh1YVlvUkl76rpicU8A6l1mWvETAjCPa4cNvMDm3Speh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536141; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsUI42s77baAXQa759P29wOtyHuXCPRCIcMgPjWS1WQDcKcQxQAOV/dFZ9+P+M2rtOGgulkCsdQ2ZJVbLUrQa5fqTRPecuco+hEQYLDEctj0WSVICLbifGWtaQ1g52qQKxCDHm13tavpGz7yHZjRDmzWEIYol2kw+idby3IEhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy5umz4R; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy5umz4R"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b9387df58cso8851648b3a.3
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536138; x=1767140938; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=Sy5umz4Re+AYb05WIXSOioKnTB89TXYj7CXmM+AAPca+7jljkgxbakL/PYglvE+BLE
         LSyBv5bPTRJdjaMgN7ogdlnKRPZnQL/Z+Sn2aN3JWpL+EWurgwRy2VfNkljiVDo5pqvJ
         XkgqUqshWaC7tFIXATisHTGF+LyLiqS5EPAzh3hTCXrLpm2xCqj5U/EmLiMdn/k+ChlQ
         h/711Gz6GLwEEXGH2IET5K36iRG1OAcmdgbALJtBsijOQrQ4DuWiQlrAlbYV6vyFjst6
         udJk0f+ODkzclYlSah14FkSk/P6sgpzgyeqMpln67HS/xHAn+1TpdfsvT+51VwC6BpiH
         h8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536138; x=1767140938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=da4Sv8vXrETsZZRqj/Je8L325Y1CERDxBpaPHsuGjBODDMAGxKL7vOJIC0Ikb1UvVd
         0qXA45HW1zEHINB9k1KVSWT3U0sAJcb4dZEgk7n0rFJG6eXTjCYRPTOBRH9aD667YkEf
         8uowqdEzLiHAhDLLPh4HMlfso17ijkFVaMDUh6leePRx+WdUKvKxAJAV3Ncpwhq8qzSg
         tnNzvy19UdKA0VKe133hNNwiTqwpBOQeUCXpmUSnFIPbP6k7gwHH6KiX4L0YF5jmPD0r
         6nCoT0KgBhynZS8iVH/doHcGYioWFr+BDJztrgY95SSZYhHacKCZx2HRW1iGPQBaYILo
         5bMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Lk78caVe4e6Kz9oKlOeIOWc0LouPMtPzicXH3uIL8i1+xm8s0XzFK2n1n9IWNCXLU6p057/DgjZcXFVkWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1+7ZgaJfWIs/aBtKyi8oXgIMPPaf0rr0plsVjsDgad+x1TI+U
	hE0Jzi67IM1+ZACN8IcCQ2hcRLPKqehHbJioCqMQdN58v3BHf6Z6twE5P2Eiug==
X-Gm-Gg: AY/fxX4nGXphtvVO2Lk9zuNpUwtN80ESRGmt2BlyDnr7oFQhFJv8PkOav9PJOLvy7/7
	oTg//geOjWPR+2+sLwS8RcM2mAk2WysGNV+HUPg0Xr+EnOOxhGo222d/Ror0DmKoVxs8nnxHXGR
	zWLU5IlPQq2waH6/TnmRt7CUGPtazEYhCayp77dBx28wI2AADPPBN2j1dhnQoZoCmqax87DhM3s
	T2gczUMp5GSRj911e0kopLd+CYFnbqVBY0PnR4PU/9Nyj7KR6bwVBgWgm3fIu1csI13aSLI8cvr
	LZZnEnfpqxUYMGdEByl2B5ugI0isgrhgj05OtX1MPUJdsjyu7t7+KgkT6RBsEfe7lEuRW0lBBaA
	eDj9V35bZ9cS+pT0dFzpjCCgdPIY2WvFrjmCgPvQip8iyMnNX/S2yWjNeklupfYsjLU97o1TW4T
	ZA0IUMAawdisBoDwa52EQ=
X-Google-Smtp-Source: AGHT+IFdIc/UDuq+YWFWwYE+rGSg4T/7sFob5YN3Yow0dtG/wPBVPu2NKHMvyvYhCHAoi2nwyYlnEw==
X-Received: by 2002:a05:6a00:418a:b0:7e8:450c:619b with SMTP id d2e1a72fcca58-7ff66a6d701mr13217930b3a.50.1766536138262;
        Tue, 23 Dec 2025 16:28:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93ab3csm14729340b3a.7.2025.12.23.16.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:28:57 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:37 -0800
Subject: [PATCH RFC net-next v13 03/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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

