Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66520124E
	for <virtualization@lists.linux.dev>; Wed,  8 Jan 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359591; cv=none; b=MITE/SE02ywmupb+q/h5qHYaVtZiLVWBySnZW0uqXuc+cZMi8ft6luIXaHa72PqbyozkJGvZg/TA4N4Sa4ah8494P4cYaWy765NTb5wweqGdtApRh6a/jLAp+e8apSs53MzHxiG7bYRWAerFI5t9QbggCEUJeXVeZOYN0CLwckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359591; c=relaxed/simple;
	bh=XhT2B/XMcI2q+vQQF0C3xrDtTRflQwJMsW4aCd7eL48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CJRpYvS97HnaUZwsgJ+dANqqWoIj3R3zNNHauWiFGb59d8Y7pON2/ZstvJRjJ9+TSoN8oyQbUwk7ktZ4yJXc1F0e/gkGUZHdA69qi90RpY/mdXhebOKK6WRpNGLmMMkliSmb8h3LFqWbBwob+WK/qM3NPN+bJGm2vsteqxYKFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3LfR9pW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3LfR9pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736359588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P81z0YmLvdT8m64Ix0hrS5vpO81KiskzyN+gGNFCQNI=;
	b=P3LfR9pW/fh2aMV+LVhjlByxHGl0JP8AVJ04Bsz8fH9eYuo8LtVoOzNjeprrSuKlAdrn/R
	WFjo6/0nh+kj7DzR+hRDgDK78/2yY9dzevvEK+2kC5ywFvmBq0WqSDZzDDrwOLwbtVIuPk
	NKiDCx6MauRuzXd4ftN+iMqAvQN2HqM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ZUyNnmFeMESgTWRU1Tw9KA-1; Wed, 08 Jan 2025 13:06:27 -0500
X-MC-Unique: ZUyNnmFeMESgTWRU1Tw9KA-1
X-Mimecast-MFC-AGG-ID: ZUyNnmFeMESgTWRU1Tw9KA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385ed79291eso578491f8f.0
        for <virtualization@lists.linux.dev>; Wed, 08 Jan 2025 10:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359586; x=1736964386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P81z0YmLvdT8m64Ix0hrS5vpO81KiskzyN+gGNFCQNI=;
        b=ry2ogGpFATmLbmUZmxTGSV/QyE2ln/3afu96+9+0g5YAo8FHUXVXM3+/51ctN3xdPN
         yBqdz20a66I5T7elRgIQKYGSY5qEynSnuQ03AfnNxo4rpsY837+fEDlHlhBr0SFCJ5AR
         z1tWYbqex1IpFHrBT6WwtJmA3yX8Tn/Z9po614z2Xsv4TQfsdDR5UXlblM9lBH1JvnSn
         8uoGkCm3yy3rQGs+KRp1Xsi8aW+44M2GDb2vgBgRNEnw5oBfCgU8VWXHsDV+KEEhvoOY
         +Dzv0TgS+vowo6V4xuK6kT9ARtwh+1wx8r9Op0wpaXJfU1aLP8VixCn0akwYlaQl1Hce
         GPZg==
X-Forwarded-Encrypted: i=1; AJvYcCXK9BVe/qKaZjtK0rk7CtZOp1VpURE/NZgCefiVtPUfM6rk5m/CuaMqa0cIrWzUFVwVSaYuVoqhCpOsCENhfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWb510CXa2dgGnk8DWomLaDXOKADTtTkDtxDazMuzE6aA/mLms
	wIhlwwzCKHLFpiv4/Z5PH+v+cpbYn87DnScGVAwUfuAQYjGgj9ONpdRSsUEFlowd5N8m+gIGE8h
	k2PQaGld6Ok1VuWoWxusBKYqzQG0o6DSRhv7AZ+Fn1HjEfZIBhXcfikJRBNUra9pZ
X-Gm-Gg: ASbGncufNnh4rShO2K2SybNf9G5EbqUn0JJskEH9G0t7Vamtar4pSFHLPMQ1RKA+gUD
	jnTn4GO2JMPjYKknfaohKJxydMqi9NonrtaOvUfCEcZBAo6lj1PaV2Qq1f5w9/AT4QSA+fwkdQe
	TaAUxn7ipGRJqk/X4TIplVBlaF/dWFD3H4jSG8YR4GKfocyJQdoIiDbxIQo6mznom3ChbnYfhXL
	3RKpMhXRxr6HGBjjN/U+N8czw+Eb/3Bzk6xh1QeQ60vBlE=
X-Received: by 2002:a5d:64af:0:b0:386:1ab3:11f0 with SMTP id ffacd0b85a97d-38a8b0fa39dmr213716f8f.28.1736359586642;
        Wed, 08 Jan 2025 10:06:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyImssYlGKFMwIIkelKFtn5EBvRpRzebX/KbLVJOoRVPg+AYW6dhCm61RcqZ/eZtr4R9nAwQ==
X-Received: by 2002:a5d:64af:0:b0:386:1ab3:11f0 with SMTP id ffacd0b85a97d-38a8b0fa39dmr213656f8f.28.1736359585987;
        Wed, 08 Jan 2025 10:06:25 -0800 (PST)
Received: from step1.. ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8292f4sm54344839f8f.3.2025.01.08.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:06:25 -0800 (PST)
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
Subject: [PATCH net 1/2] vsock/virtio: discard packets if the transport changes
Date: Wed,  8 Jan 2025 19:06:16 +0100
Message-ID: <20250108180617.154053-2-sgarzare@redhat.com>
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
X-Mimecast-MFC-PROC-ID: M2LeH1ajHRpYm9TyZA_N19EVmowwRGbPVFC_65RfPH0_1736359587
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

If the socket has been de-assigned or assigned to another transport,
we must discard any packets received because they are not expected
and would cause issues when we access vsk->transport.

A possible scenario is described by Hyunwoo Kim in the attached link,
where after a first connect() interrupted by a signal, and a second
connect() failed, we can find `vsk->transport` at NULL, leading to a
NULL pointer dereference.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Reported-by: Wongi Lee <qwerty@theori.io>
Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..51a494b69be8 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed before lock_sock */
-	if (sock_flag(sk, SOCK_DONE)) {
+	/* Check if sk has been closed or assigned to another transport before
+	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.47.1

