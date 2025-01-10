Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BE20B1F1
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498143; cv=none; b=EIJreQfOPj9UjD5av/U9zPVnGvLczC/eDyRakG5ZrPfJHxgDQL+9wlUSxU+3UEXgWZ7Um3MTVA2hY8JxLivRAdokhkCuETJMExnPwfJ+fnGNCPx/9o+50WCfBARjPM2B/fP/uo2XlE5pQYOsuC4Jr+ohvQJtwP/RsGX7hEeJ5/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498143; c=relaxed/simple;
	bh=uPsduUWhdScehzIkWWVjxwh3m7xAtK9UHuNXKkdV3cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QsdgN/Lsvkz8R4pcLX5ebZpzw6bW2UxR/+HC0YHdfNJB/QuVPZxGDNEfqXdyo2VIbrjXSsdHn4sIMY2kkgmJwfXTWxjpag2zxheVLcfULaJrq12rCUUOY+ygNIRmMk5RmsrauJu7xEsGQUtBNjwJ8GlD/9dYmbII0Ri72Gi8/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUuNdwxI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUuNdwxI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/UxJFQhjZHiTLyDu6i94GmVxCXul14lCOVKyB1E+sY=;
	b=XUuNdwxIoU4kSfGJn0bw0qhiCrNjxh9bbUup5ESNolSePOMRDM1+vMIE2tyA+04Yarg1gZ
	P+OcoofQ+Av4DPF6Ua7lG6QCyFL7Gh/MkZRzwdd7YM6oxw1gHvFtBX8+EDxJbn43F84NwC
	3JnqXTZEFl/Vli6lzEHHODIdRdlMAr8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-eEvaPx3KO7q3NS7r-sOd9Q-1; Fri, 10 Jan 2025 03:35:40 -0500
X-MC-Unique: eEvaPx3KO7q3NS7r-sOd9Q-1
X-Mimecast-MFC-AGG-ID: eEvaPx3KO7q3NS7r-sOd9Q
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3862c67763dso684019f8f.3
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 00:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498139; x=1737102939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/UxJFQhjZHiTLyDu6i94GmVxCXul14lCOVKyB1E+sY=;
        b=kc7a1ZkJ3A7jAiapkv1Rp3Q93VgTIWwva1OUQoDTwOiLkpdFqK2EArlcp5G/n+W7H6
         rzum+BSM06tdcZhP0ZXCyVhY4Sz6E4/+QoCSqmEnbonriQuw7j9+eVeSsOKAr0aie0zy
         OutzDA1adiKdjnYj76iC6WB0QdIzNJLUixU9EBYcDrPPY044PlSkJyVnBIRDbQBu4b7M
         WIM3ngcLr6nX0nlCNCf+48ykKvAUU2vdCP0btnIwHUb64yN8WlYHpYaf7qikSysfEBfs
         pAkYqxEZbZlE7notZC0T+fKCVPj4F6qd87h3qPTAUzmPewFnA/MRPL7O9E3OrKfOJSeo
         /Z9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXTh89vooCIeJ1gzd6UNPfG/TfIbSa0sOiUsPpV5zs6h1LHwjafbqlEqZPLemctHNPaoGdAkwluVkn9PmQRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQtlj+l3wwWzI2bGX5QP7QmdRAxlQqx7QmHkifdtl/Cx9DLwng
	ZmKHMVhdi1qsXSV8/+dZVqKwLx4ZfPKU1X0f5WGkOVON8Gs9z1xLGIpAVViYIJ9L4LNf5Ue5ORL
	1ftF/+sxiY+jNGnfUqKDqrOGe+mDzLyRQ2ArWg4i3EepSYFT/sXGzD5lBfz/U5oP60FgPtQnLCC
	A=
X-Gm-Gg: ASbGncuj1e1bTQvQCmAvwHBaJIYVk8tn9HRKX+KZKcnjPR8Iem5suPiI7custJBqrHj
	V7hEpvizt4Oc1zPOniOn2YqhHpYkWsYO7nSqubmLcGW7iB7ho7r3ZyAM+QDnm2NAs6GNrr/uPtj
	oNfDCY9LPr89TZ9KR7q+MomVjji7IpdZupkblcGEksV3V7k+wyOOgHm+2OJYlSx04qppvvdpFpn
	i8YOrKoMsH4XqHfhalxcA4UKSSShXGKuKwlkior3KZUJJg=
X-Received: by 2002:adf:ae59:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38a88b898b4mr6672301f8f.2.1736498138760;
        Fri, 10 Jan 2025 00:35:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0wfwdkUAlCHyAfjqywZwwjbDz7xJE+/6M4bU0+8jxnFXT/mEU5AdPqfdlVeWVXgoMTeKpvg==
X-Received: by 2002:adf:ae59:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38a88b898b4mr6672275f8f.2.1736498138249;
        Fri, 10 Jan 2025 00:35:38 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8214sm3895187f8f.78.2025.01.10.00.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:37 -0800 (PST)
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
Subject: [PATCH net v2 4/5] vsock: reset socket state when de-assigning the transport
Date: Fri, 10 Jan 2025 09:35:10 +0100
Message-ID: <20250110083511.30419-5-sgarzare@redhat.com>
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
X-Mimecast-MFC-PROC-ID: vSB2cYYz5F3nOVefXvwtTyz_7Adc9ON7ZWQZVnk1h5Y_1736498139
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Transport's release() and destruct() are called when de-assigning the
vsock transport. These callbacks can touch some socket state like
sock flags, sk_state, and peer_shutdown.

Since we are reassigning the socket to a new transport during
vsock_connect(), let's reset these fields to have a clean state with
the new transport.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5cf8109f672a..74d35a871644 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -491,6 +491,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		 */
 		vsk->transport->release(vsk);
 		vsock_deassign_transport(vsk);
+
+		/* transport's release() and destruct() can touch some socket
+		 * state, since we are reassigning the socket to a new transport
+		 * during vsock_connect(), let's reset these fields to have a
+		 * clean state.
+		 */
+		sock_reset_flag(sk, SOCK_DONE);
+		sk->sk_state = TCP_CLOSE;
+		vsk->peer_shutdown = 0;
 	}
 
 	/* We increase the module refcnt to prevent the transport unloading
-- 
2.47.1

