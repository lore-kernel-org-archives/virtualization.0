Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92E34B1B7
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244093; cv=none; b=d9D3eua9jhxnzdJQAXFPhy2pnzk77E53miBo4eGShAHbFyW5X+LpaoVahBL3SOsBJCqxMo28b4t8CcYqY88kzGpx1V1BqxX0+snxFgyIbmOkMuUctkNt9m/3E4bA45RgGxvqY2yhDbHfGwiaxcvN2FFVf5c5bZaMhLiFaROL720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244093; c=relaxed/simple;
	bh=/NnsC3/kyQkEuJK5iOUFqzrZwSnxBzzrLIV6TJlSX58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NccYy38VguPVUA6vIX75P+3pDXvmakCW2l9hUUNRu1mTnlQfCIPkJ35DU6F5IwycyYhQMTS1bk1946y3e93bDEQ3t0vNHfkC4bDJ61WGg1TtHV5IGdBro/tkLRxZFxTFdxMezfg8YjgIfWLhabWSpttG0oijJeHyV0LdWZvwQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyUCYU+k; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyUCYU+k"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290b48e09a7so14308475ad.0
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244087; x=1761848887; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/1b6yRMCqBZzs7tcE4MzTOrQu/agnNRge7CXTKa+MI=;
        b=dyUCYU+k0tj6RXiG1F0I45b9dLWYuRvtvxadOEJgv2jhvjtfUiRHwVAf8Drc89eFx5
         pYJvKIwvystGL+8mN+OQrOko4tMXoc5Gvi5FaRbE0jQVFEV4F+NcSI62ZdPl3dWpjzTJ
         U2pc/aN/PYcToyj8AzXxUukuw6t2UyRyH5s1DR3OPXjMLfQfGZsqGRqLrzNe3etR6Cpx
         CxDQoSptTAndFXwiplDdaqdQJprLNZ5OudRs7Xe8ywPgezEpnrqzR+VYR2DlpsIohlHW
         dZO/dOHnNLadXfZogVeaILKLEeFhr8j3gTXIuM+bu6GrtDy+bacm4FY5a4YZgAmXpOIX
         Mg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244087; x=1761848887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/1b6yRMCqBZzs7tcE4MzTOrQu/agnNRge7CXTKa+MI=;
        b=ZuwAJKfrDh/++WpD2WvRC9P5l3GOYYdlIijYHTLKHLvm45lSZb52Dh2wuM3FQ8cM8W
         T2QUfA1/niooPnBj1ynIorsSFc99X9HOr6SlwaW7szMZJ3HYuclFQDstB/eXsHpvj09Z
         chwOUApUuQ6nNmU6v/w2HWByEMGEqEvxRmnT+rD2tRk4o17jXulcjC8qqLQTuHHiem5B
         m2WFG4VVj/iQMN4dYkgtnBJLWyUF1DNUM/rOHq3bbYZiYzJT+rfxJzqmnSJpHxvI1sSq
         v9lUcanUjPgaqi2zgaEMPSmF0RKiqHoC0k5rhGmDp9Dx44ni2ZglvkLV3Slh//Npat9h
         kadQ==
X-Gm-Message-State: AOJu0Yx6Sw8MvQYfIvAKvBsTJebEwZmOI7cZzvzj1U9s72pIeLF9Nm+1
	n15yjv64FNr+JBixbzMONDDYvKJXfTGKqtF4d+v63sWl3SFd5aPYy+/k
X-Gm-Gg: ASbGnctlPCrhfHoe1lO5cTSJZ5tz8pIBJIcF5nt5/zSLxwbGSFIFdX4w15hAybQqflh
	W2z4a2PBBwtryoY0TrIMPGXJclm/cD9XyCmKqKZzHcp4LZ6RITORJKac9I0sDfGNxwk+ETqs7X2
	44Aryd9lvOIBZS8I1aoQWECYhhVvuh8QOQ8B5LgrvtY77CHmZ31dax/6rk7vWEdGJItxJX69Wj/
	AxHlRtCdNSC/xJoFVrEbMZHXxN9w0RA8GtIsEpHvsCWlGW17bIAh6DqKj/6BmTAZ3UrAgYSZ/HP
	BY6P6lp/0xcDl5zMObhTpJ3eDiolarzGR7GNVOecH6oS4zdaaBh8TCMRmPCqCrQL6Qq/7HzqA3T
	flghog3SdD9O9Qrv8E62TP7eQo1hlUpzHzLmoCTVdajwGMPLCXZnBGPfj/d+7J/9LSs9N1Chs5N
	8W0Dj0FCNs
X-Google-Smtp-Source: AGHT+IGRrKHIe8i2PewhMjRBhP1W+eQCJR1uY99As6NL8XQQmuNG2L450IKTPePeAvu2qClkS7Jbsg==
X-Received: by 2002:a17:902:dad2:b0:293:e5f:85b7 with SMTP id d9443c01a7336-2930e5f9113mr89467435ad.11.1761244086676;
        Thu, 23 Oct 2025 11:28:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f06d5sm30959555ad.82.2025.10.23.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:06 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:42 -0700
Subject: [PATCH net-next v8 03/14] vsock: add netns to vsock skb cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-3-dea984d02bb0@meta.com>
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

Add a net pointer and net_mode to the vsock skb and helpers for
getting/setting them. When skbs are received the transport needs a way
to tell the vsock layer and/or virtio common layer which namespace and
what namespace mode the packet belongs to. This will be used by those
upper layers for finding the correct socket object. This patch stashes
these fields in the skb control buffer.

This extends virtio_vsock_skb_cb to 24 bytes:

struct virtio_vsock_skb_cb {
	struct net *               net;                  /*     0     8 */
	enum vsock_net_mode        net_mode;        /*     8     4 */
	u32                        offset;               /*    12     4 */
	bool                       reply;                /*    16     1 */
	bool                       tap_delivered;        /*    17     1 */

	/* size: 24, cachelines: 1, members: 5 */
	/* padding: 6 */
	/* last cacheline: 24 bytes */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- rename `orig_net_mode` to `net_mode`
- update commit message with a more complete explanation of changes

Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 87cf4dcac78a..7f334a32133c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,6 +10,8 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	struct net *net;
+	enum vsock_net_mode net_mode;
 	u32 offset;
 	bool reply;
 	bool tap_delivered;
@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
+}
+
+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
+}
+
+static inline enum vsock_net_mode virtio_vsock_skb_net_mode(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net_mode;
+}
+
+static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
+						      enum vsock_net_mode net_mode)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3

