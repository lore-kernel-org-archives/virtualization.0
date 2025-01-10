Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398620969A
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498128; cv=none; b=f3pCIgMmpKQeHdNfsxZJjQssbn4wd0R78a4EsQ8YDY+VAIJDcKGVjhtyY++sumK7J8L3P2VL2WvIhBA0zRpmtQ4yyoFbHbDVc/z0IkqpT2CZykmV8nETHEhVSRW9cm7RuViI1i2ZSJB5kfpuM4p0vwC0KsR7YqOlYE8Z4Mefdkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498128; c=relaxed/simple;
	bh=gg9zwP3NuIW09DU6vGz9JHfMW8EBO0Kk4gY/BezPQf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MZaqwH6xsLdU0ulbsuxBseRqUaCgCIRl/gyoPJRlkUZUQtasEA6nRn3p0TJZWm6U2G81tuFJtdXLYyZIp3MjNFRaClLJvaWn7GqhubECBvvCOgGs0hwbIM4T4VN31JJ/p2FB6BxVJpA72FGJ4pK82ab6OZ00ljAJuvy56ldSE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOtt2Ny7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOtt2Ny7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NbnJJOfD3lLHAPtW6xOg0cYnPxIPSN5ji63JO1T6TM=;
	b=VOtt2Ny7qPgJf3uoHSBePwzXInCywEjlSUNED8ZleMecJdSScfGWbhcIwaaMRNXwaym1zg
	kgojGDT3cthDQpcZtFXTrb9U0bkqzLo2tSDAsDRBGmqkFzheKi1MyH/tfAay2GE773d8WV
	XWm0mAPRqyR79l2viC6MrI96S929sTc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-PVIfW4PmO0yh2uQIigYEYw-1; Fri, 10 Jan 2025 03:35:23 -0500
X-MC-Unique: PVIfW4PmO0yh2uQIigYEYw-1
X-Mimecast-MFC-AGG-ID: PVIfW4PmO0yh2uQIigYEYw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a9118c486so992198f8f.1
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 00:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498122; x=1737102922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NbnJJOfD3lLHAPtW6xOg0cYnPxIPSN5ji63JO1T6TM=;
        b=tJI6UTA9xujUuQKiHA1+UceCIhoPjzkY/qqdpnY311u9OVg/SjpKNpXyb5mcxWgSPs
         kjB77iTmFyaOOF2O/OCNSetrRwdOOrjz86b7ReTJPCekJmmzwhYJM5M1l/5eP+YfCuok
         Ej7L6j1yzwKTIdrdLQnAc7pxWbT0V8bfBvUoIAgwcD9l1FSkp5VSrZjHf6FpygKnRac9
         pGvZ1w2NS0zFP/IjOZhikCX3HHqGw9tZimXoQLV2j8NR4Gr/XOj6S8ibaTE2y2fo9s10
         qOFCpNbyEk2Vn3nGLKBDy6n0+zH+bvk6+AHFmJ7HsHvTowIq8Uc7swugt9d18qKBXCe7
         1TXA==
X-Forwarded-Encrypted: i=1; AJvYcCV67EhUcTMTxsfATHmwkUVpBY0BjCHnpPsUVP3Z7f5uX+PBuYzU1wvsDA+VsoH8zKC9LveUHsVbjRIfK/FqMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9oniTF/C0QQ4BVjmfjJRMK+v/6fJOh3BonnydlUPDlHF9ewrV
	XrGy4PCI2J8N/hzb9hfjJp4/LdGTvhjBNq8MhF5bc/DHDD+zAR4gGryvisCrSxf7JTtPsgmVnxZ
	vzVe/qce4WNm97NUu6S9R1Ug8PRn9+VXv0jvWUGyOEr8skrS9njtX+WSViWoVKez/
X-Gm-Gg: ASbGncuBdRi/OITomMz8q6FAwhc7ECVU+3aYdZqP3iZKtlYldN5fexlOGhHwUJvcFhU
	HycFeKuuPnJ09f/PVNH+Mu5Xv5FfvPme7nTR1vzYCj6qboin2ZYHAVg3Wbg6Z6Vzf0pFAHsik8h
	cr7XFhsVrfFMVX/hKYIhNkpv/YbyrMckaMMkIccUITV06Kqn3ruahv/LvGm0yS7+NKQEbRI3AeT
	7RZ523Q5x7NvNWJpRq1ByFMOJKdIYF6AEpD1CZz4ZmQfro=
X-Received: by 2002:a5d:64ce:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a872eacdemr7037320f8f.24.1736498121728;
        Fri, 10 Jan 2025 00:35:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaMGGKjwRAwVyhTKqw23Ww9p2dwBHr6VnXJ4BcQwGregbXhxMe1Q9lXOo3WbQYlPlIlcZAdg==
X-Received: by 2002:a5d:64ce:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a872eacdemr7037271f8f.24.1736498121118;
        Fri, 10 Jan 2025 00:35:21 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c76esm3843166f8f.47.2025.01.10.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:20 -0800 (PST)
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
	stable@vger.kernel.org
Subject: [PATCH net v2 1/5] vsock/virtio: discard packets if the transport changes
Date: Fri, 10 Jan 2025 09:35:07 +0100
Message-ID: <20250110083511.30419-2-sgarzare@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Bdecfkgg6Wq_8fv5NFc-BsWpUjiZjNDza_wGsRu6zfA_1736498122
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
Cc: stable@vger.kernel.org
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

