Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24920A5DF
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498137; cv=none; b=MF1cVMo75+Zkjvz7mFZU8dyNFdVAZlXU3nbdDK128X7Juj+flW5A52gexFH6Ba+/x1w+sW/v/YoRQIQw1YmBllqcTWrPvO0we3hP19woi5O+nFOGJXfKW1wytUzXEQRfpx3FXIbLfL1A17+VSX41BKNZMN8knUbbtPYdLyf3To0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498137; c=relaxed/simple;
	bh=QjfOQgTaUWrmSTlG/geSr55nIlTbnhvRsiGytk5OSls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VKqyYttkqq83gbJGQB+JQRak9cVsNRvBR8lm//PT3s+AtBx2k/LGr9wBk16ee3Ezmqdmz1ESOKZo9hTyNdPM4Fo2xKwT4sq1LpNEofR/TYIte+3eDlKbFWMWEFuYPGTZ0C94bQmLCvkLOY9UCXJLHXxTdPMg3QxovbHs0nVHdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieKL/YkP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieKL/YkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBLDY4DTw2zaWMjga9j81VUizG/Z+zQDnv2kJoLZ4eU=;
	b=ieKL/YkPkufEKmzc1HXVMk4d7SBaVGgCIcx+mA9YepJoFC1q5kze5GAVsEvBbm0M8sntIW
	Q/vOXukieX8Nd+2kE0ODtetG3AwTxmgcBuThOv0Yn2TORtrNXRH9ZVn7jZDIAH8GiuiMtk
	3u4GA+WlUpe+fI0ifE8vBitw3GkQMR0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-J-8sq0uLNqyPdTD8P9MQsg-1; Fri, 10 Jan 2025 03:35:34 -0500
X-MC-Unique: J-8sq0uLNqyPdTD8P9MQsg-1
X-Mimecast-MFC-AGG-ID: J-8sq0uLNqyPdTD8P9MQsg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so9104875e9.3
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 00:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498133; x=1737102933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBLDY4DTw2zaWMjga9j81VUizG/Z+zQDnv2kJoLZ4eU=;
        b=uhahlprNv6pLtoVH1DFmMiUZcwCy0BrKEJL8uY8dqkEklpyjeZRwqG2qGTABAdIdz5
         10XQMbsz9Tn8pkGfCbsK3LCS2jy4UHUissY21FOaiXVXPLigWPf7qOJPDXcFJniCQVO7
         1E3iF72a0OfM925PcoA7HqFG0Dzsl/HuXRfiQ90C/F0KPxO3S5nxCXPkV4fddSpXF+eq
         dEl8mcqCRve95DeDXgoFR0ALK2AnNDamtLepgJHK4EXyV2F2wbPjZNUfQw8CdzvsUxbq
         1H+bl76ANIhEoqP/jdU38WG/kDBgdhMkNr05YMuejoxU39UsFVpbdlbc96hd23U+giie
         eE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRiPII1MiI7v28CWiR9B/iY/27qPePxv/rwLoHJZvnwFOY5xYiGUOyeoQ9q53WD6Pozo/MHKimy+iNaK06BA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFNeLyjvG+/6jOWsJfyQEBkSwT9ty/39CbxMT1sd+cPk10UaFh
	+3K6Uu8YBH3KxH6piOWR+uNehA5UhU0jGgGHr3aHq4fET0zgXF6Gq9j4xqSpejc7Ih4DLdwNjQT
	D+ODsvobQ7PBXn6lXdSoDZLxde7xrYLAv7QMJWOpwZ91vzBDz8VI89+DXym1FhwjJ
X-Gm-Gg: ASbGncvVHjCmal29lID1tzu1aOm6QwEVmLA3C4+LPqlH/IkYUk/CbP9v8mzikq1l+yv
	NiF10/Mk2kfrOoEEyajv4DGez5EQUn2zvCBw6xVXqnZGk906/FvxcYPHKM4GpJBwtOdljL/zP0f
	48DD59BE7U7/GNv+kXZhBeEp+rJT+ZNVPXYYth7ONNQseRKUN8mLfeor9mhANrQSGaF8vFTeEn4
	/MNjGxlufjYoS/z1QJAe1BUGT/bUpyFbb62JB3cB0q+CGg=
X-Received: by 2002:a5d:64eb:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a87312d2emr8464147f8f.32.1736498133279;
        Fri, 10 Jan 2025 00:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkY+6wyisWu9I5OnlNIAEaCc1RkfYRMe4WOOPOqI9L+4Q6XFHZJA9lRe1HqGdOwc7Z+AC+ww==
X-Received: by 2002:a5d:64eb:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a87312d2emr8464107f8f.32.1736498132691;
        Fri, 10 Jan 2025 00:35:32 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcc8ddddsm73101805e9.0.2025.01.10.00.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:31 -0800 (PST)
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
Subject: [PATCH net v2 3/5] vsock/virtio: cancel close work in the destructor
Date: Fri, 10 Jan 2025 09:35:09 +0100
Message-ID: <20250110083511.30419-4-sgarzare@redhat.com>
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
X-Mimecast-MFC-PROC-ID: IMyYtFLpGsCnZZPNR0vUM9y7T83703Avh8dycJKlWao_1736498133
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

During virtio_transport_release() we can schedule a delayed work to
perform the closing of the socket before destruction.

The destructor is called either when the socket is really destroyed
(reference counter to zero), or it can also be called when we are
de-assigning the transport.

In the former case, we are sure the delayed work has completed, because
it holds a reference until it completes, so the destructor will
definitely be called after the delayed work is finished.
But in the latter case, the destructor is called by AF_VSOCK core, just
after the release(), so there may still be delayed work scheduled.

Refactor the code, moving the code to delete the close work already in
the do_close() to a new function. Invoke it during destruction to make
sure we don't leave any pending work.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Closes: https://lore.kernel.org/netdev/Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 51a494b69be8..7f7de6d88096 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -26,6 +26,9 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout);
+
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
 {
@@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 
+	virtio_transport_cancel_close_work(vsk, true);
+
 	kfree(vvs);
 	vsk->trans = NULL;
 }
@@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
 	}
 }
 
-static void virtio_transport_do_close(struct vsock_sock *vsk,
-				      bool cancel_timeout)
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout)
 {
 	struct sock *sk = sk_vsock(vsk);
 
-	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
-	if (vsock_stream_has_data(vsk) <= 0)
-		sk->sk_state = TCP_CLOSING;
-	sk->sk_state_change(sk);
-
 	if (vsk->close_work_scheduled &&
 	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
 		vsk->close_work_scheduled = false;
@@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	}
 }
 
+static void virtio_transport_do_close(struct vsock_sock *vsk,
+				      bool cancel_timeout)
+{
+	struct sock *sk = sk_vsock(vsk);
+
+	sock_set_flag(sk, SOCK_DONE);
+	vsk->peer_shutdown = SHUTDOWN_MASK;
+	if (vsock_stream_has_data(vsk) <= 0)
+		sk->sk_state = TCP_CLOSING;
+	sk->sk_state_change(sk);
+
+	virtio_transport_cancel_close_work(vsk, cancel_timeout);
+}
+
 static void virtio_transport_close_timeout(struct work_struct *work)
 {
 	struct vsock_sock *vsk =
-- 
2.47.1

