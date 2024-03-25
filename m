Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089213D264
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386786; cv=none; b=eGJAWbR2WG8KqMEHwLWDbtZehhQf20MYr/alt0XO+L1xhZJDEPrOHXZ8lvfbrwelWdfLmIwzm3apgowxhtiCqjWNGtvqHQyqYPWyhUOyJj+o6HpDMiewpQkhQ809dYTQFTg2KJCMqlwT4EjfMNPN+f4S3cqepDLSAgnACqOLtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386786; c=relaxed/simple;
	bh=0ZhgzFV5Xt/mswqGy6lswxgldIuR6Mr25B7wtDUTbrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pn/L3i4hsXEYj621Ey1ghptJToxff/voKayeDMXFrcG4ZolVq070f5Fs4Ln5fMqvQ1rfTwBa7nVu6mfAijB3I1igdjjPoX4jPvJ4nnjYW6XjMEiuBCIVA7a2SNVyQe01pAq0A/REGQYLZj+h57Cv7TdmQoDjtpoxXSPhhEuuIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1e9xFg9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1e9xFg9"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so56567011fa.1
        for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386783; x=1711991583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6X1NNxLlcRJ0g+9m4U+W77i//Qg7iE4ilrLW92aE7CM=;
        b=F1e9xFg9OX/DbC5jwsP37mi9zFUG8YSmSMhE6+EAEmErBjEtUaCCFUzoecCZM8vv+b
         20F8GBXeC5XPSFmKwfeINExUwG8YAI7duCRZu584O2gUUnoPnL3D8IoUTWBYYp3LMnm4
         +HUH0pw7f6l/l8r+QizDXctnb+OSDqOpiLxYYt70KK1XFglmuVc9EFSxyvAoXayLAQvY
         MQ1JZx9NY53yxlAcL/UlGKdgHkknPH3gvFhDBxQnwL+x0Z6vwfivuqC9+Iv4Q8Of0lK/
         0c6RUKMhbmRRqDGEh28EyaRqNAW/Ms0K0UG6WBNOHt1tDIqeljeNbo6qmckm7y//9MHj
         sngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386783; x=1711991583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6X1NNxLlcRJ0g+9m4U+W77i//Qg7iE4ilrLW92aE7CM=;
        b=wn1wzM5Rm8t0Rv3eSWMjRfmZiu8fITdmZ0l1Kct0h1CFxYKSYXmsWY/U7xyjKMOYdC
         i7JZ1BFC+kB7gT8PGb4F3Dih3yX/nbL2PU6B5kTqYj0w7AP7hNGWbUDOz7Es9Dx1Vdtn
         lbk6pqse/zQr1nAnmHpwU2ksDpHjCETAYy+eoXZD5R54IqJKLmDKKaq2BmBL6u8Kohi3
         qmxfm5iiUVprfDbt95J0dR7MyHKQlmR8SK/hSCUGxOOzy7lz/nAKg6ow6R0Z6CDhihxR
         /865BJoaxXv9pZdEmsXQ2jVYhcP2g6718KDtxmTlZ8iwnz8ae44POMjbpTPUyJiXo5W8
         lYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUwWaeXQR7+WDGdyfY6CXYBQGOps7VXOYzfqCYlZCrcE561YgDRlv+pwv2+S2IO31iX3iZDsCTqOgfrCSsiKzhtvldhzuQKVk3ys7x+R4=
X-Gm-Message-State: AOJu0YzydXn37Ek20bdXxEhNpQtvIYia2lLZtl12Vv/1M6cwhSG3VxxA
	6BXDnxEsmJ7XfXYtlWeJI/wOZDB9MVDmbo1hUqFBRuhGnPuZLwWd
X-Google-Smtp-Source: AGHT+IEMfYysiCUhsoDAJD4rwXSiQC8clzZILdXxljLw1O/gnZYMnp0fL9CFIQ87w0fRRjJ8GC4krg==
X-Received: by 2002:a19:6406:0:b0:515:a523:d38c with SMTP id y6-20020a196406000000b00515a523d38cmr4000791lfb.63.1711386782887;
        Mon, 25 Mar 2024 10:13:02 -0700 (PDT)
Received: from localhost.localdomain ([82.84.234.137])
        by smtp.gmail.com with ESMTPSA id h4-20020aa7c944000000b0056bdf694890sm3225666edt.43.2024.03.25.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:13:02 -0700 (PDT)
From: Marco Pinna <marco.pinn95@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ggarcia@deic.uab.cat,
	jhansen@vmware.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Pinna <marco.pinn95@gmail.com>
Subject: [PATCH] vsock/virtio: fix packet delivery to tap device
Date: Mon, 25 Mar 2024 18:12:38 +0100
Message-ID: <20240325171238.82511-1-marco.pinn95@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks") added
virtio_transport_deliver_tap_pkt() for handing packets to the
vsockmon device. However, in virtio_transport_send_pkt_work(),
the function is called before actually sending the packet (i.e.
before placing it in the virtqueue with virtqueue_add_sgs() and checking
whether it returned successfully). This may cause timing issues since
the sending of the packet may fail, causing it to be re-queued
(possibly multiple times), while the tap device would show the
packet being sent correctly.

Move virtio_transport_deliver_tap_pkt() after calling virtqueue_add_sgs()
and making sure it returned successfully.

Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 1748268e0694..ee5d306a96d0 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -120,7 +120,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 		if (!skb)
 			break;
 
-		virtio_transport_deliver_tap_pkt(skb);
 		reply = virtio_vsock_skb_reply(skb);
 		sgs = vsock->out_sgs;
 		sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
@@ -170,6 +169,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 			break;
 		}
 
+		virtio_transport_deliver_tap_pkt(skb);
+
 		if (reply) {
 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
 			int val;
-- 
2.44.0

