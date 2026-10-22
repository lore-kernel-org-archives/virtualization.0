Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660739;
	b=MOYzzEQMqLsCahd/dn5yZKtLpYUjLFJwHEQEgd8St3HhxTP+IxBxQFzDNu5GXg9zq9Mu
	 OlW6daIZUZCxZRx1faZec6QbprdJg/2WPBupqNYs4NTL7UisRh2IbJslKGUvzz6tlD/4G
	 czhDTtU/FIyCLnxB17XaT+89ewwoZdA7u0zfWBPkrgNUqZVJtEt6FA3egqPOaPGnWpAQ+
	 stZVhama4yQsyIKQ+6jknDbWmaMSysfznISoPXPzx36CD+PI8lqR6mqOrhfRIhqJws6Fj
	 NwpbLwycsypjs07BqJdSVTtTQMqI4sjmNCD/mEyRSq0E0xmRZrGRG9ZLzBXBFugwxHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+3+RimD4u8oBrFVN6CFkCZt6Ny3U/0D/dKYnMLBj9z0=;
	b=Haa4F8NJxC3afXddNHRIdnnsTuvdut2khKyV+Rs5PVzrMWCsR2ddrxtLQZVoRzWRfNJb
	 jpDd87hJuqlDP5oVlS5GGIpQIRG8ngkRn60EfHjVpX/QJehxdYSKwfFCovjfMdFaFB91Q
	 2PKEb68GVpjb1Y4YcdM4fOD/ypcV3gM4DZgCgkNUxp0d1jLeE5qaG4VnD/f8l26YJm169
	 m1uDU8RmB7p/DPw4HeI5OStyhvnvkvPzcBwjjyOrE2HizOYnNd5j+YqAJVu8/EyHprkrK
	 6qWeRm0nz4hx0qzYh1OYqFEitkFFaL/LHPkgWBd+kf+d/276qPjCsdqyTZxe0uI6htA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hEz7cOzt;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3639606A319
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 09:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3639606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hEz7cOzt
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-16079d54c17so3058131c88.0
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660738; x=1793265538; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3+RimD4u8oBrFVN6CFkCZt6Ny3U/0D/dKYnMLBj9z0=;
        b=hEz7cOztK5hWYAEIRxAemNFjAz6F65f6PHmDv+uARRArj96+iqabJSAHXPjzoXZI6m
         4DckzZ8Lr8IrjrOWbwBclkWxQjvF6g7//VmfEkXlWi54nKCGveRA2jd7dpLBrLfazlcD
         egLtMYOTmcs9kFet9vVDs33syaSObJ1LjEKGGBJrkGfQkOg1kahJWhqmOobzE+l2F2zn
         WQk5b/+dAZXEUK6obpkAbku9VT5R7DK4ETTZqp21yklKbYpsBcwmqcR7rEqIH93mEeCp
         CyQ6ddSQW6PGRPq0J/S2q2glupDJ6/e28XYkB2/lYnM3JzDsd7zQAjnG7em3BFmLt6gd
         pWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660738; x=1793265538;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3+RimD4u8oBrFVN6CFkCZt6Ny3U/0D/dKYnMLBj9z0=;
        b=0KwKX3WejHgYBb5rIqgst36y02ugRNwwEpZEPwCk4kI1RUxZzZe83xgjpKh5f3L2nR
         eF87zrM6bUlwkwgfeviiw0j2HAutUq/ONEyom8z2pgO94nDEvjU9ItQqCx/qBf6QUf6H
         cQ/VQ7hWXu/NSdRX+jlgHhtFVZSqRyP/gTZobOAjTH2YOF6+BG/hL/l/C1ZOIf+C2Inw
         77IyLwijaazDDalXvLa9lhkkYQdFY4pqz5Lpr+KsTdRWH4mwPvlY/QRqLc+yZZLzy5em
         urcrdXt9SeTWvS/4/ix2rYUdVryt/fqHrvXdE/ffQth7KpD3hFQ7n8nGxMVcwhEBJB6+
         DKtg==
X-Forwarded-Encrypted: i=1; AKwUvBysFfGOe/KSCYHxpR0niZRrPu4hf6IZVcTFZg4jqlDh/M6kgFvBJo2i3Jr1BtrmzxM9/r+qnl4jCeoglF2Pzw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKtpRwHFd5dGm5D9g90bjcEc8pQ0oFY1iiF4sYB0BuhhSDLzZ2i
	zuW/xECiKvGECMB++jU57TY7KV+dPc59cInMyFdFGDwXUxmeKXwHGozO
X-Gm-Gg: AYBFou2iZ6mFRpVttJ62KEtjupNp5oCStjaM0oRSz7CQ9UKU6eSnqy5GfP2pktJH0Cn
	pIdqjef7qskLNtTLP8YHotmqRh9h88J3duf8zsWo9Wl81rsZsIDC/6SVo2dco1s+/p+CoFdzJ6E
	nT7CYqLxufN5KcndbtHChVPASo8Pn3+6dUoPBzvITTwTzQDVF1REi2MISHvZzHk2lNsJ2ALXcn+
	WXLHX+ewdcegx8LmlKO8YrLDHXGb6RmoSyAkjZpiLjGKh31JVxuillXhSpMuyJj+iDUEhmmq0a1
	CJg7YKlIOZ7gMEg6vwDbWvSc65z7z7BjrkgZI1//jRiouiH9gOzVJFRUenC/FI323sV61/jPF7a
	NH+2seCmIeXK0nnIfdyf2yuYZwdQqgS0YN2RUrPxg8RUgonxqtkSk4k1Q23zxli/fZw+CQYIHIa
	9KN3L4fpxUMv3uwi30/4HXRpMm9bjlnBTBI4x4ITUZFzUQtmpIHdlJksKU07KsMpSGYZ4a5HS5r
	16XhoIKZQNOu1yfMqa2Bf4V5CWcSbXcgnYL1E465CbGXj4kNjGe4QGIID6VlKF2x6XGt/vICWAu
	ys4U9ZwYPGQt8JlYitRMnMJhS9bJs178F5iFv3sr
X-Received: by 2002:a05:7022:ea57:b0:144:f089:b189 with SMTP id a92af1059eb24-190a74775b8mr5453836c88.36.1792660736253;
        Thu, 22 Oct 2026 02:18:56 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035926035sm11607230c88.1.2026.10.22.02.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:18:55 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: tun: zero-copy path can expose uninitialized packet data
Date: Thu, 22 Oct 2026 02:18:47 -0700
Message-Id: <20261022091847.3654028-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

The experimental vhost-net TX zero-copy path can hand TUN a user buffer
whose effective vhost virtio header size is smaller than the TUN
device's configured vnet_hdr_sz.  TUN computes an skb copylen that
remains larger than the bytes actually available after stripping its
configured header, publishes skb->len from that copylen, and
zerocopy_sg_from_iter() initializes only the real payload.

The resulting frame contains an uninitialized tail.  The tail can be
read by userspace from the TAP peer through normal forwarding.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with:

  init_on_alloc=0
  vhost_net.experimental_zcopytx=1
  TAP vnet_hdr_sz=200
  vhost TX total length=256
  real payload length=56
  TUN copylen / skb len=128

The exact control with vnet_hdr_sz=10 delivered the expected 246-byte
frame.  The corrected trigger delivered 128 bytes after submitting only
56 payload bytes.

Sixteen of sixteen corrected triggers produced the overlong skb.
Eleven of sixteen had nonzero bytes in the 72-byte uninitialized tail.
Several contained recognizable stale kernel allocation content from
previous skbuff_small_head users, including fragments of environment
entries.  Those bytes were never supplied in the virtio TX buffer.

This is a userspace-observable kernel-memory disclosure on a
network-forwarding path.  It is configuration-gated by experimental
zero-copy and an enlarged TAP vnet header, but the overlong skb occurs
regardless of init_on_alloc; init_on_alloc=0 is needed to observe the
stale tail in this test build.

This is distinct from candidate BR-023/BR-025, which exercise
IFF_NAPI_FRAGS.  This reproducer uses the non-frags tun_alloc_skb() /
zerocopy_sg_from_iter() branch.

I found no direct upstream fix or CVE.

The vhost ring reproducer and complete program/console logs are
available on request.

This was found with a multi-agent workflow; the
information disclosure was reproduced in QEMU/KVM.

Thanks,
Cheng Yongkang
