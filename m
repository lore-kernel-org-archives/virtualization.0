Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685393;
	b=lw7ukLHkE/ibG568G761E0DRY4FyLNxLxKEAxD2LI6YZBl35OJQCQ49oCv6c4dVx4wiJ
	 vKHiVBWb//GrnQlA0B8cq+yVuBOvYYYhfCFM0rQpQF9XAEqPKWhHBCD3CX89t0vsGusm3
	 eqTOZe/o2cAd6k9fgUXc/wRTlfutFli7POPinpAOK6FhLaOnAnRzIZy6A4kYsmWPhPIlP
	 Zew393KUSjXuIJUshwqjm8eUTykoVFpS92y07RB80L9dChYMdh80TjZrwyHT1ZzpckFJ7
	 Ry/b/q6IkoFzJh12/xsEKfJKOkdXQlQnSyA0pO6lY7/G9Dd397bvRWXcpy42pSHn2bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=H8x7/XkTJsQWhqAAmf5sC1iGmFvt1Btlq5a0jfg+eY8=;
	b=hyuZLuVYDyhGIZJYCX/HBIOjE3zBFx8/+GqIZ+RX5ScsMOCr6WFaBaA3x3k7dA3L57XP
	 b3TRmiONH5DIqOToBIu3M8L6Szi70qQ11DVu7JhB3Z+eFpAEZlSCe4SLEVyP4cg7ZaJat
	 7ETEys1qdHms3nwzWx2IIB1CDYU8MlbDs8TpxlzDYdQA30SfnDXq7ePj0UNsEvig8+Die
	 tyRyP0F85WEzQYOX7OXlR2YBeTnWzPR57gnzJdrfoUa5tYuCaC5Z6zLWqiuDX6evGXnzV
	 hHLyYZH166LaPfzfFidLo7Nsh7xUlVSYtZCWTlXNWFGo+BiIno8MZzUUVsZiGFurf9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EgYgcBUb;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DDB606A333
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 16:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DDB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EgYgcBUb
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14394530ec6so2774624c88.1
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685392; x=1793290192; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H8x7/XkTJsQWhqAAmf5sC1iGmFvt1Btlq5a0jfg+eY8=;
        b=EgYgcBUbF+++slkjh9ywRRDWIfrbiIv8iYXs3sHTxRuOhdJ05UOi9isf4fNCVP3+tL
         26eeROQN3B+B7MRYCUb+fE/weRsKmD16Yk+caG+KeJBn0+8ny0ExKjVJeXqwxtP/MFQN
         ZZDnlAMAtKQrDcIc4KcI0YlWA+2ZfzFLM6zo2MjFZEcj8REZsFnNsKf4XXANhvwVDQsx
         UAba2w80HA4PYSHmPmol26bEAVSm8oCeCL4O5LB8vtmwPlVfghGCF+I0AOox+0uvoNv3
         pI5kk86uMdwuArXQX+iVWpKzCySJq/p61LWCWauzqPcH+HI3X4E+AH1uZFjSeVpp3tUn
         19CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685392; x=1793290192;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H8x7/XkTJsQWhqAAmf5sC1iGmFvt1Btlq5a0jfg+eY8=;
        b=BNW03LTP/CbY46lU510qrRunPg4X1CaXauAsBD60KYQRYvB9pYmye7ZbvtNiQBlxR/
         ddePFHL1+ektx2yFgnp/KqmNASiB4430Zr82Zvl4oSVrZb+0H6XYv41e/Ktze3dW6G/1
         pfJKXEDBEMNUcRHaLDP01d3ZgQqQxEIE9qiPCTP7hCal3QZ0PQExBDYEj0WJARdHGFXo
         aAp/LwFxg1Ut/2RBg8nBv1VPakTX8SKbcTwBY5RM9KiDXCHD73p+HsKoO4oXsoUeTJ2f
         Gff97qBod/MYKRzGRFBLZkB3/hlIq58+8l8Wz29itSvmpAmy9AF0nKaWuOUu89HfP/UO
         bxig==
X-Forwarded-Encrypted: i=1; AKwUvBzXX0V8Uc22egGM3bf189tEDwFQG5V3KyF2yqQGe3NRXqOLAeGT6RRpPyOF5N4ByjKUMUCEr8wjroUsdD8iGA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJx/TWa0ZEfVspbSlYPONKrEyilygybt6ZbeYWC+7LrKGjPOIVY
	b1spSCQ1Sjsu0xD5hjbSrB1qK4ove4z6L0stlrbTa520pbybEUd/alkZ
X-Gm-Gg: AYBFou1IqnCl58vyaRhbckhScvoiNzzxUEwNCqDbyqqrJiF/PSDx4p682ljkeYaV+Q2
	f9s4IBIFytcqottBWqHrWIhQHy43fifcJHzloNdBkdpgpSNnWXtfBvFUb6j3uj19W4unp9DO0cy
	fxcVtkP2RcbRurn1SINRqUbIJyBqDTewFtPuat2iwkiIsVKXaKHFerJTCR9f5QfLNHwjiD8lAry
	zcc08f1CEZC6AsQsCSr2+L5aq+zdmqs8SLxVdQYPQnLV31GvuH6u9eaOY9FluesdJJoNv/F9pnC
	8Jd1ZoraL3+m4o8RV1GxAhzIXJ6R3k4ayPfyS+UvNBuvD44YAG+JfS7jnVCPUaazOk6JLzMfgZ/
	aGVk+KhmikfdfpyDDimcHJOk0R+YRmM+GsuQdFHMztwcSgQ45QcYNsgTqH2f1xkkX70qADVBxhd
	P7oTGmqsgl6w5APuqJXFoHtxgbxZLWA+IKr5FLFUr/OWZ9ivMC4oGTqwU5qxMm+BlM/S9FHsKqf
	yp2SVe2N9Ash3VPnPfvbh5focXMR5PN1mXWwn88FUvMVN+FZQVh9/nC/8IdJf4FoCTYjqxJjAnB
	H1Cz
X-Received: by 2002:a05:7022:b88c:b0:138:148:6a28 with SMTP id a92af1059eb24-1933bf18b4cmr3304575c88.18.1792685391652;
        Thu, 22 Oct 2026 09:09:51 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm14594124c88.23.2026.10.22.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:09:51 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject:
 [PATCH net] net: virtio_net: decode tunnel csum_start as little-endian
Date: Thu, 22 Oct 2026 08:26:48 -0700
Message-ID: <179268538303.70821.1734486381476363942@gmail.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

virtio_net_hdr_tnl_to_skb() decodes hdr->csum_start with the caller's
little_endian argument when it validates the inner header offsets, but
then calls __virtio_net_hdr_to_skb() with little_endian hard-coded to
true.  The other tunnel offsets are always decoded as little-endian as
well.

tun passes tun_vnet_is_little_endian(), which is false when the device
uses big-endian legacy headers: by default on big-endian hosts, and
after TUNSETVNETBE on little-endian hosts with CONFIG_TUN_VNET_CROSS_LE.
The validation and the parser then disagree on csum_start.  For
example, the bytes 14 00 decode as 5120 for the validation and as 20
for the parser, so an inner_nh_offset beyond the data pulled into the
linear area passes the check, and the USO branch reads iphdr->version
out of bounds:

  BUG: KASAN: slab-out-of-bounds in tun_vnet_hdr_tnl_to_skb+0x74b/0x830
  Read of size 1 at addr ffff88807999d044 by task kvd-program/9399
  Call Trace:
   tun_vnet_hdr_tnl_to_skb+0x74b/0x830
   tun_get_user+0x1827/0x3d00
   tun_chr_write_iter+0x113/0x200
   vfs_write+0x5c9/0xb30

Decode csum_start as little-endian, matching the parser.  Callers that
pass little_endian == true are unaffected.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 include/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..ddc6341747e5 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	inner_l3min = virtio_l3min(inner_isv6);
 	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
 
-	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
+	inner_th = le16_to_cpu(hdr->csum_start);
 	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
 	outer_th = le16_to_cpu(vhdr->outer_th_offset);
 	if (outer_th < outer_l3min ||

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1

