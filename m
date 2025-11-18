Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB4325739
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431239; cv=none; b=ZzH2EgPlgWM1XtMrwZz6wtOljolAulaeXFVAFRmoZUSTKzxluaRhzFbgAAa0ZwUJ2BQUxQmTpquTYi2eMIM/ph4/7NmGYbPkjmXVmhbwI15uj1pliG39mUidqdQ/4p1n2edGDLhqySWlmuA5gTCwLreUUzOBDS9CjVvvzTqdEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431239; c=relaxed/simple;
	bh=uOW23oUD888uPdfswggyv7h4B3njoPEFvMHwF6iAAmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGiWzrjUEUw7V0/cdwZdhI9eEHyIcYdqYut/z4AhzX/Jh+hI2UF7VnYVqHbKEJeyTZSS+8EDaLlUEHNmEnyidD5I2pJmMs+wKs8QdsWr4KMy0vxvw3nhRiOyF3ANgLlWIHKGUOmh6oXQ3GE+3UKPd7cufVZtefwfjslIG1r5iTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbdgF4bn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbdgF4bn"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34372216275so5389383a91.2
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 18:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431235; x=1764036035; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhLUPvGLtyJcQ25GpVmgIbln5JiS+qaXLLDnH3A077U=;
        b=GbdgF4bnho9J2d/B9V8aGme1KiEm/Xuwj8aDV9bqlEBnS67Bfff+AfHnxMkao4ISEo
         if9IgxOeX8q31BmvdZSsq3ZonWj/cPzidNJfjAqcxxEQ39OZ8tGMYRppH5kTViIbVeRH
         +PETcWTepyXXkI5GvflMAG8T6fZr3nEfmndhGyNYIx+DtEQ5Mc44QHKcSdLKdIr/voHp
         6vRgmjgyFNQvxq4Vf3t+/ElRr8xkMjYND8H/r7UOTUuL/sFKo9O/KVnuhySkBoP/DTiV
         Hem9sNIksu1AbJnBskLF8KToHjjMxe6as4PMrxkea6fuvysY94V2r79gmBOv4CsK3cym
         jNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431235; x=1764036035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mhLUPvGLtyJcQ25GpVmgIbln5JiS+qaXLLDnH3A077U=;
        b=abJPbYgPPnDKItcQgKFqeFH7xt2zcFbwEKOLi3alvo0Z1JqXmI7AFlU30R+ev0iswk
         VQRRSw/gIJ9TVMSiCAOYaF6X3mjKP4ueY2qtigd9ZGCdEzEXEpNmpU9w4LH9U2iHWQu0
         DTmPaArk+oLGym7/3vHbUB3e4p29wnxjh2lSJd1IluIb7zv4uYDflw5cZC6BN7Pn0ssy
         4WuEgqRyNQvmdSoMPaIXCWnnVnRZpSmx37sL0gCVxNYu7X2zj4DgwpbC/M9VZXOvDWpd
         TfUoxNkuchtpoSzs4zXoGHrtD8W8eypH16NAW1/NxwLvsOSSZfES/DODFwzijINtF+JK
         KW0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLkHS8MNJavwISPd3pdF/Z09zB9eayVZyS+LroFRHedhczp3/p2J31Uuh+Q6nCwnKpT8K2LbGXc0b5H+a9vA==@lists.linux.dev
X-Gm-Message-State: AOJu0YySjafrwypOZWyxloUBYf7J28EkiuLbQHZ1cad5+YhJaUfdjlW1
	xZQ73KvS9R4D4114uV7x+oFyo+IhnwzDrqIjvasHVs7BkGhPZOaV+bOb
X-Gm-Gg: ASbGncvwkzG66hPRYNwr1xIQnsfUhl2wkcAJOng18F3samiWdh7ydiHTz0vD3US4NrY
	Kt0uBzkxb59v2bTwPuiA3Wu8Q2hikQle4fhDWMcjePbkd0S29ADjhc7LnpBW2PfkM38cM5K1FEO
	MPLnn8LbsjRpBeRg340WG4F0ciVaABVUoYpWv8tVj+49g8hwSL3pWlBLsoIZt8LgovB2H3Dnppa
	8DGnxctf028T9zxSUCwtwk/aVUE9rhAISTKzv0XkDNUVgAzP1J5fNFhlumpelOQBKhKr1c/8hRN
	giTqINij8ttOrY90TVeT0wfDCXN/6kE3+WujYguK0XlFkmBrnT1Jhyswyc+EW/v7L0+aoL40sX5
	XR921xWmHFb9UK12/w30zCGWK+4sTYJ0mVyEqnzuC0T/nUeSUBUFDnBQhKjNoXT7k1pDSmIESNc
	A5dmmePPVgBekNmGwU1yp0PpnF5dJ9Hw==
X-Google-Smtp-Source: AGHT+IHLky6hFd2s4o/LoM/Lst3F8klAMSAkgSuH9Ql0+UHi5g9wFfThPyUZnxKhdSO4j0xQMtxpww==
X-Received: by 2002:a17:90b:2d05:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-343fa6326e0mr15954772a91.21.1763431234714;
        Mon, 17 Nov 2025 18:00:34 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm20082011a91.1.2025.11.17.18.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:34 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:28 -0800
Subject: [PATCH net-next v10 05/11] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
In-Reply-To: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
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
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
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
Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 168e7517a3f0..5bb498caa19e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1181,6 +1181,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
 
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
+
 		/* net or net_mode are not defined here because we pass
 		 * net and net_mode directly to t->send_pkt(), instead of
 		 * relying on virtio_transport_send_pkt_info() to pass them to

-- 
2.47.3

