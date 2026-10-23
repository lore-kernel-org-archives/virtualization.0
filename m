Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741919;
	b=bxvV7QNZTLGIwp63dWaB31O0iq87N5j9InQxzV6zI3Y9fNyKF8+5klvzttcER1S8ABp2
	 NeIRd/S2kWfGGCwmLrTh7APKH6K/YU31sw6411+SjBteAXrGK4+00KHtBE04XHevsJUoF
	 smcua8MW1yCtB/I1pkGM8BFR8Esa0JiayjwPmCeazgO6/u/hBdh7SF7SO9VBdlPXoiTRA
	 H7T0ya/4xQCYuAqLQqnXt611IDmNlsFGQgkvv3h0xvXCYI4t8MChk7VzBF151qcyO/Pex
	 K0etzyEqW3527jKAsnig7Y6H1XNhTzPE+7lHCTEFi33sAIDRt2PLI/7IbbABVcKBnUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
	b=Sh45rPulxGsisIKV0mU9t4kanmU4e4hxpmXiv1ifPWTm+hx5oD+JazNflZE6NwVHiT4e
	 VXK9+GnBDVBsQ+gSMRx7p4e2b6Ot0t42QlMsMtxQJ03sEw93hWImAqkF8mluVEDYEjYbx
	 hV+DL0DGuqUAJOioJvrrES5LDviihQ0Jvx1pT8AeAbp0wR8oA8btpIb20aqOmrgIchVpf
	 NDqbEsUx71mHkzmAID1LfyNuJ7F9Kf9CPZiNG2huTKdi8SGIYSLDetZMBhr0JgDMMapRl
	 WD6eAqhOsnDR3OsaAAGOG2IsQ8/bD4L0Mpw4VrfaKxP/Eb0FXFG/tKj/b5zojqiZ7ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jVENQZjX;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BB606A324
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 07:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 171BB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jVENQZjX
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e940d5d2beso2119425ad.0
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741918; x=1793346718; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=jVENQZjX5j6dnYK2chmGRe0QtBHGE13d89nXoL2fEjyj0vDpxDWIcBoH1q0nFVSU21
         q0eDtVMIsWFerNmXTMPfp6yYI6AN/IE6QRwWn1EuT98hEo5AGkV8/6UsN8LLQH+jf4gl
         UBV0X8p2nh8ufyheqgnxi/mV6u1FYm025DTBk4ZcLLkpSI4V3NoVywlkB8tpR0L737U+
         fUAM+PCOepflyDhD7nsgIkRM/HYNkSbjVTDAgoYZ+bhW5rSkm+QXXEMqwon6aJdrsdVn
         1L+L9swA4Yy/uQ1edbEMfkvx3vI+La9EMhIlAzEJlQj3rYWW3VDmUoQO7UyHyCYwpK8k
         IHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741918; x=1793346718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=p5eGzpnNPiYOniJ72dYo9Mmh+IONF9DyLXNXaUEywElJrqzbA7nELrqUvm+1TUJtH4
         UM1Tftf/6fcskjS+lJTA85R6ySFpsX+F9y8/MNQTGNGznKUABnroDSz8ozjwlb/t/TzK
         9Q4iWNw9ceAIS6LQEvEjn8Y9x3ZvxYyvCpS/oWfUBiTum9llVKxQwuh8UrWygEM1LYXf
         5UecZGln5GZQI0cCessRrCDCs5bhO8LEFmKMRajo4K6QzjUPgQD+AyzOnfRbL3qPuLSg
         cG8jOpD0UOMojb7Bi3lAwTuf1r7bairh+/N8QZv7brKsgz3BBhjNZJIFcOjlW9lo5UpS
         9Q5g==
X-Forwarded-Encrypted: i=1; AKwUvByBmoQW+jaIuqwWHP/ksBKQ9y08VP7trSuGhXi9qA7ktUcnOAqTOBAzydHfTPyShZwQakhEGpHQgCTkXNwXLg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJxdFCJej02pxtm768B2KgpLsepXLUqPyuxrpR+jPy7omeARVrk
	9B78mC5K7FkKl4SHR7wq3YK3+VuBLflrPMKaeePAXWB1xzwUP1IeF3PS
X-Gm-Gg: AYBFou3DIjilelbrHK5HlXQQCU/jg8wKsp+XMrBB3KuGZep1RbFpLFfCpLBS2LPSAyV
	jy2l4XO6Fw7M7LM8DuycDmQqcsVKEtnFb/YXeHQt+vLqxNCYTE9I5PwxWS5ysmyaRxa9QkLIYwK
	t7zNBqlfFZ0EIPoMABm+EHHeSV26J+H6Kbkpdw3Y/jeWM83pAOdEYQsR7IouGbsw56+SufVdqXq
	Ww9pmj3dz9OZuiFv/FTmaQKw2/lDx+O/CuxAsPpO1OxN9tH92j1bNZVjvERmnnQ5GqbJcghle/d
	pMjFkGKKNee4d6NRFzjHzZUf5MP/34vPmV5OJ9uvT77ZQh+IrNUl4FSaCgTe9lKY42pCBiNorNC
	tZ/s2w9vzXKDUypPaKy/2rtYbG3K2dcXv/OXRHZMvi2aXZjAXCldeCmOcxiYyOh893aExzwSR5P
	RpOCHUkE4tyA3A/+UOX67/iQO8+oKDcTVGA3weEF5kRWhNPO4TDNTlyOqKGOja42MmO5FyTcuOY
	quatAR0tClLC/hrqMYVy7pBeqS5yQLwJ2lBlzGnGp45m7Nf2SFiw1T0A+2XdpL5s2tPn7H+L4Bs
	03U=
X-Received: by 2002:a17:903:26c7:b0:2e9:6be2:1296 with SMTP id d9443c01a7336-2ea7c330b3bmr15087225ad.56.1792741918158;
        Fri, 23 Oct 2026 00:51:58 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b368c90sm7208265ad.29.2026.10.23.00.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:51:57 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata budget check
Date: Fri, 23 Oct 2026 15:51:37 +0800
Message-Id: <20261023075140.9613-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023075140.9613-1-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the skb metadata budget check from virtio_transport_inc_rx_pkt()
into virtio_transport_rx_buf_full().

The helper retains the existing condition and will be reused by a
following RX batching change.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 43325d7aebbb1..2a9cfed085515 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -576,11 +576,17 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
 	skb_queue_splice(&new_queue, &vvs->rx_queue);
 }
 
-static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
-					u32 len)
+static bool
+virtio_transport_rx_buf_full(struct virtio_vsock_sock *vvs)
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
+	return skb_overhead > vvs->buf_alloc;
+}
+
+static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
+					u32 len)
+{
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
 	 * metadata. Check payload against buf_alloc to be sure the other
@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 	 * queue growth.
 	 */
 	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
-	    skb_overhead > vvs->buf_alloc)
+	    virtio_transport_rx_buf_full(vvs))
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.53.0

