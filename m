Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3234B41E
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244091; cv=none; b=YAz2TOwhgBVCNqt2Eoc+FRouWA9rc2+bUzP/Bu9GvuBLLZd0OQ/0pP4mqybyREPlwJRCYxo9LC7gkmXh1SAn28/Ae71IxconoEthThX1dZXOotnbPe1WrnI3gA1Ygw6BhiSO8kfeV7tmoo2lirJLFvtwpZQaBUV3/dgadwPTe4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244091; c=relaxed/simple;
	bh=5ZnZPrVDfdO+Z9/UM3e8BCikhyLuP+zNDA80rKqdbMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QPQdRzgem093J4DLKbXxllpFqS0fi1GEMoCuk6L0IV66DncIEzRBIaz5IA/Gxqms1cAzyL3Z3dM1sn+8pQ8sTJC1ttT4nbfHi+62UJIdvA3+SoRKBF3X0GBE6c4/Xx5k0TCzPLCRnJjvZIW1fPjmp7Cf7hN/WFC0xsTVWEnlYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aoxp6V/e; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aoxp6V/e"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290b48e09a7so14308325ad.0
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244086; x=1761848886; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=Aoxp6V/eTyY2mtwx0Qeuahcz/PvLSn8vAIBiEygVLYAkj9kNH5zcikVKBVSYDcqQ5n
         p0UQv2GE07t3Fx9ZwFWqYe8j9hrpiDxwvFrOYCKqErxzduIE0GTNm71vn51JuLERJwDt
         zFpoQvPkrSlQXwIjmTLLVU5hBvo7wNWV6H6AVZUCu0xF6PiZU23b8q3KlBVwTlWO/h51
         RwUZsnZYUivUG93Zx4mRvkchDIWREAFSW/+n7rReGBq8pyu3OUy0yiFizu8QQeTaLAJS
         VnwCpmvT6lP67HpuYyiVFLyPQS+NH9toEhq7bOJ1ULXHCHkbN8pZMz8rVwzsHPH1W+pd
         Yz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244086; x=1761848886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=YaGX/r+cy22hYLy76lBcqAagRBYg2/Ts1jYKDIXVpGY2OcUUf6nQOms+cmvyJpg2G+
         +OaY5vLZle1H2pSO50K3p6E3pUusPQakh67i8lYg5MnXFiDnbcOVF4G7gZOxpUhod2/H
         QfOzP5z1/KiPaLxyA/gGocTFWIw9xYoaBE2kDSjPlxvXtyIxaQzUtA1Z8h8UY6MKBtnB
         BUHnyFRRBeSlSXTNr2T4wpkCA1A2oVUTW3Fd9Mbf1Aavnh35rnshLtTJ2d0QuA6BN3ol
         LcS1DH2NOCD2znDNEZCJ94GADvFgmGs5SWKo6HZSB4P07bt6yASluf7phrsGOYqeeuhH
         R3mA==
X-Gm-Message-State: AOJu0YwIpZqd4Vg2tAWhvvxDP7Zj377IUYNWrN3XTJShcB7d7D9UMAtA
	l+o+K8x6zAAOl0jh3RNL1pmeYWab9XBiKTg0BXO8vatFTCMZ2NbRDjWE
X-Gm-Gg: ASbGnct9rtAeKxBZA6q7HhfNiAv4sfZDF5YIY8m37UBAiMlvUpqbTo1u0kmzivbbn5y
	E9C17jBISmWQumXopMgm5iXh2iFBUCPlthTZ59mbt/cusrlb6DAx1SN+PoL09K3JRqHIYfLL5Xr
	oMxn7L9jIPI70u4irwBoKsgkYc/rIJqzkpdP8fYxWCeS2QT+0RROysj94aczjQExEOI4iv9CCy7
	Ytgf0z2Y8lXejy03tmnAHcFduIb1hp2JPv834ll/oBUYa3i5t5Qz72bK0lzcFp/CCBsbRlZzrHb
	zwD8jPdMue5dECfRF920XOyddnVbw7Dzf8ZAJh/muXHMXWs45XGxMOxWbsIpbz/KTL5xZ5iV2DD
	WUHkvOmaHyHfB5NCfWgIrfZbdtk9nIi43SYgKZkFRREDvaSchcvfLsmst/kUVusewbcMSxpiukM
	q6yb8Qcgy4H9cms66qaKQ=
X-Google-Smtp-Source: AGHT+IHuF0nGiLuYIY7bEPnV/kWChQOzz0OHyllyc5LZQHhWV90GhBaf/if/KbPVYud5pvRswtc0Ww==
X-Received: by 2002:a17:902:ebc6:b0:290:9a74:a8ad with SMTP id d9443c01a7336-290cba41dc7mr337313795ad.53.1761244085636;
        Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de152e7sm30294645ad.29.2025.10.23.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:41 -0700
Subject: [PATCH net-next v8 02/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce holes in struct virtio_vsock_skb_cb. As this struct continues to
grow, we want to keep it trimmed down so it doesn't exceed the size of
skb->cb (currently 48 bytes). Eliminating the 2 byte hole provides an
additional two bytes for new fields at the end of the structure. It does
not shrink the total size, however.

Future work could include combining fields like reply and tap_delivered
into a single bitfield, but currently doing so will not make the total
struct size smaller (although, would extend the tail-end padding area by
one byte).

Before this patch:

struct virtio_vsock_skb_cb {
	bool                       reply;                /*     0     1 */
	bool                       tap_delivered;        /*     1     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        offset;               /*     4     4 */

	/* size: 8, cachelines: 1, members: 3 */
	/* sum members: 6, holes: 1, sum holes: 2 */
	/* last cacheline: 8 bytes */
};
;

After this patch:

struct virtio_vsock_skb_cb {
	u32                        offset;               /*     0     4 */
	bool                       reply;                /*     4     1 */
	bool                       tap_delivered;        /*     5     1 */

	/* size: 8, cachelines: 1, members: 3 */
	/* padding: 2 */
	/* last cacheline: 8 bytes */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..87cf4dcac78a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,9 +10,9 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	u32 offset;
 	bool reply;
 	bool tap_delivered;
-	u32 offset;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))

-- 
2.47.3

