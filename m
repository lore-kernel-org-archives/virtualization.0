Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A392586C8
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134788; cv=none; b=I4mRnvxM00xQEigFr9eNqqSR/eFlL1Jf3qt1HIX9LcgMEN65mGdfOfZaH9F0kF7n/qmlYSkGkwKV+CkAeY5VCE5XGwkySkWEN+QNO20SSIiweXuRqV8nTBUXpcQ9nF6I2pxd3f6o/GKNDM8g7mjSviGctfNQnexqAWY2jMRidag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134788; c=relaxed/simple;
	bh=8iL4uzIPqS8RLVh3FNuZXgVHq1hRBKkNvfmU0de7s8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAwuPTXKQmgvFtr52XInUSZ5OQie8o8VTTkPq2lsKMqOPb5N+K3J1NQO2LrdX4umW1TEvnpEAweuy35pGDX+eHQ4rWSb8zl+ph9jllVOl4gXO07NNGr1+PYwvOpKX4bNwtkahAnYEyCFZpfdvTspL5rilKh/t0C9ckxvY73rZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C90bGcRn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C90bGcRn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234bfe37cccso66827785ad.0
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134786; x=1750739586; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJN1ESreek0j9m2XTDShreBHd17nPCksTQTpnYLrMbE=;
        b=C90bGcRnqAAcGBYYDNASaBFKj9uA1aVeDcdNDc8M2UVlcZ4mQCslMGC9pbD5DwM34V
         vSQgN+0+FJlpJpxmzrN+NslOUaGPXvpcTJtDJVEEGablmCHLvazV3ZsPDRWH8JiLJ0x0
         a6/ngZZXFWNHK8ohseq8IlFFP+P6yY+NgcjVuhW1y8E8ORrbh3pz5foiAvwEIweNyagF
         TvbFjSl3iHTKJ8yy3qGJ0CQknvace3hy9fEAOgRMlUDzxklJ6unOmPoM8ORTuZyoGKJb
         gLPjCEYLI2u5RE8VmbEQQ16AlmnZbCptp1abtpSMqPAEb7FX1SV26v1KyKRyhrA6d4ss
         eRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134786; x=1750739586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJN1ESreek0j9m2XTDShreBHd17nPCksTQTpnYLrMbE=;
        b=SuXcE86vzPF8Km3KMmSyuvPL+9Zwxvxd2OL5hKsnwS+TOYYcGkqkas686ykWT0Sy1G
         u8GBKXSpWk9Maqbr4nAzusPsERDxUlwk0bgCk4wWn6TlG9Co1eSJSncjC+WAz7aerHDW
         SyJ/TXHCgR7XQ4eXaXR7MlLuJDmMsmlScT0TEZF+xW/wberNYjcohQVFtS9EEOzsktcl
         Zdflkd4gM1qyb3aFT8U45jpD7Pb7oC/qRuNY//NOFeg+U6DZUwB+GMx/vTPSMP3KUynf
         K4Go7449+BQVZZZ80LzcJ6CntoQLouio1+BGQKCjeZNWT/6Uie79YmGCRS3lxOtQJbkk
         lapw==
X-Forwarded-Encrypted: i=1; AJvYcCXAatbb8rdJxORekZZ3PokKMZQ2q7qItkkm2qX5xDVwa4OScr5afIeMMR/6TZlTrQxqeR+zkvSO3RdqBW7PKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzwn086Gk7jk/siplZyUvKcDyb/kQIuV0rmrbT5RxavnI+E+4OH
	d4NlFei/6YaL99cHnRhyZklw0a55i4TgClYTOXBvOjaXu6dQcgdRCL4U
X-Gm-Gg: ASbGncuS99t98BC9RjqKtQAogCxa/ZXScQlenYnDW6rnolWgYq7aAo/+aHlMKJA2OD8
	CR6q+d44Gw44/Dcnlc88TGJIa6kGO337+ysFqKxIJrTR7sEAKS47VY80Oz9QtvEmcBGRaCQZDh9
	Vg8yKhD0yi4BygjLIOUn9OcLI1eo0ULlNChBBAyJGTFNxI2VcWt2eXhpX3RGwlVNIrDLIA1RSlc
	gESeexINOcbTkvJlqvENuHBQsDzIVW+K34LdTd0FQdE7cWy4q3y0ycC5zLqAg9IrOM9h3kubke/
	PUopV70k2bJXhsF74oQTUTJNwPKD0b4eHttWLkUTg09kHJVzub4xmMOKFrS/
X-Google-Smtp-Source: AGHT+IGkFu9sQ96pWE/tvZJGaNKtT1/Ussv66FYp5oIw+9uvT4GiaGRUxhl5bUUj7am7ZNMIQejaAQ==
X-Received: by 2002:a17:902:e848:b0:234:a992:96d9 with SMTP id d9443c01a7336-2366b00ee5cmr163590035ad.17.1750134785904;
        Mon, 16 Jun 2025 21:33:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea7d98sm70324525ad.151.2025.06.16.21.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:05 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:57 -0700
Subject: [PATCH RFC net-next v4 08/11] vsock/virtio: add netns hooks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-8-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

This changes virtio to not be broken by new internal API changes
required for NS support on the host side. virtio-vsock namespaces are
always global mode, so behavior is unchanged for them.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/virtio_transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..25c1bca7b136 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -536,7 +536,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid);
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 
 static struct virtio_transport virtio_transport = {
 	.transport = {
@@ -593,7 +593,7 @@ static struct virtio_transport virtio_transport = {
 	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
 };
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid)
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
@@ -649,6 +649,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			}
 
 			virtio_vsock_skb_rx_put(skb);
+			virtio_vsock_skb_set_net(skb, vsock_global_net());
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}

-- 
2.47.1

