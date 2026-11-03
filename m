Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679153;
	b=NRssH4eY7wJOkhUWotcETiS8eDUNYhDXBb/axL39sW+RZXo3utwZj8/XNTYifdXEMUIo
	 KPb9+it5QeT118LR4Y8Q0lBxXlVI02JGv9GTlS3khTVkzr1aYiHa3SDd44WBhizI2TN05
	 Nq/2UyTMsjwPMqxhynJ1Qb3e6lMcbhA71AV2uNUb2GXBx06bqGDqU+FaRy4tfvIFDALF1
	 3AioEU1ZoCJVUnCmtbod9Q/wfaDLTs5feRhjJms05kHIO7EjqHxrzk1Fj7dfYDs8cwmCc
	 RKJiNK5SElX534cl/qlcKssQkbpjILpAs9cVlzq+egn6SWWlVjIJiRJimfMhMr5WLUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
	b=mZKfEkKhL3gFv2qQobOWVN+M8vmOYqqAHcJwc9c7ZScxXWycopRBINjh1dm6xGdDF8Kr
	 82iOZY0UxKM9e7wucnPALaXITDKL/dTIrxG3c5uV0dD2bT7CJfT7/j0Mch028XvCEH2LL
	 vxjwXulpiTtDV3u2PTpWIv9ychAeDKVppCHA6/p/3zlckLPtfhBd4Cm21RT+ClbvK/f2i
	 eBs/+zXnaAT7M4LTR0ekX198CwCBp4oEXeMMTbYpDli7rXZ+VhSZpkZXnhb1vwWfo3vR4
	 ug8iDjsyA9LkLk1AULpbGesoBk8D/pW5jhzK0C37lgiwABRSRjplwqiY+0xz1S/PCwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn+hz4CS;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB3606A329
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 04:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68BB3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn+hz4CS
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so2926275a91.2
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 20:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793679152; x=1794283952; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=Fn+hz4CStgbZotJC/znix2uLdLZ4pMsMzNjX7ApO5VPvrXFp2hr0Y1lyDd3JAHsDTV
         mlB377aXjSExZfWuqN8YSbs8pAQJgx2yVgdmU9FmUk3XFAVcMjWyHbgWLvhuYeG8WhWC
         b0cDcaGPT7oPxjrg+37kd8swQMiEZFAomfN010bb/iFit6w+2IZb9kFv1KyLcjrG/OHY
         NYvheloDbot/ipD1zpoAMEIpl/LaqqrNhP+mNHsJf9phL6y+1JSHudnHa9BDSSa2OQDM
         CuGGZCilT7RlCGLsFl8PEBhYlP61SIT1TtuW+I2jnaucJqV9e6spFOQrenN1MwuqpylP
         Gm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679152; x=1794283952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=1+n/EfOIFBBINHCGmvM1nSxleR71Z1Lduvl5VpNWTlYzljdy+K3OUjt21fFc4x6akU
         HZvs9WLQd9UNgMc17T3yjEFehGPWgrSOQWelhTzgNgFuk8/KoXh0E6//1WOD6Nx0Uf3l
         eWMrTT+k9cxSk3fbAggcViFzz1KpO+p30cKg3gtmF8/XZhyEU8TX5fVq1rT4WqLcZ9iS
         0JXS9/YdenQ4AGT5xf4soiXynuvoNJs/EGqN5MMHAFNtzvca2RpEXDzXZ/AsrJ1G60wD
         IaaOXEX5ZUYJ5vv+HRKPxiHobWZf9vfn34gZqn7rPyZ4qQ+KzNr9mrl2YUMWxTMMWz2s
         zC3A==
X-Forwarded-Encrypted: i=1; AKwUvBwoOgp7kWxXbMg74AhRFyFKpPkAFQxZqOYj4yHH9YAN0+NWe1NTc07OclGzgfOg1vYDjttWW3tGIHhLV2+sIA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+QWP0gfjzeYYQIPEGFC8hZIcfvDGIuKZuTPuoNrTz+41BMJH8F
	//Rj6E4y0KMvr6NjpTKj+Ix+ARCgnjGILhfVuhiGKRMg9LNxc7DDnWH9
X-Gm-Gg: AYBFou0hqLi/I+aYCFlrMMc1GjHktI6QfY3w+hRxvv1JYhkZnizZLb6S4DjCkwOOfZE
	4pVnLfQ3kOXxhOiUQpbv2VndhMzo7whdnjwVLNUEHFhmU+Z+4RQ4RilWbk6igkAL1Z0vQcjsu1e
	8hqBHkMljglLPdzdkrXhZku5STuXVT05juJ9tXHnUShnHP2mZC22YIYqAmK4eGHf5R8CP5eVRvx
	Pt1Wa7zIwXWpTt8dRYXrODmbTVZAoFRxdnT4DL4iomBNd64HJMehWEWTDXi94HBhpNdHMMTr73U
	xF7nbxWRslPMWPQbfR+FzOr5H2AFFV6Ry2Kq0dAPCnmNTPPgk+m/M19+6mpCLye1nLkqduCaAeV
	HHYYLW7N8wNHcd2CILMIU5Ped96/Kr/f3wJAJJ5rzvZtbbcD6OP/Tg5wti15S8/34TLdSaaMmRJ
	fzkrdaPdIMBuTMm4Jk5RskOUxz6Cj73eVDZ2CRXpz6HJvdVzE4v9FO61mmje9PAbopqncVf0Suy
	gLvdo7sxMkEPuPSsJZUjCes4u/QXCm2VPlH8iztIAdKZDCiMZUy3MwRuODTCNbHxa6yj4h7aSx3
	8V14zSEM
X-Received: by 2002:a17:90b:224d:b0:3ab:afca:1d79 with SMTP id 98e67ed59e1d1-3ae897eb33emr9769580a91.21.1793679151782;
        Mon, 02 Nov 2026 20:12:31 -0800 (PST)
Received: from gmail.com ([2407:cdc0:f00f::117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6f010asm1941708a91.15.2026.11.02.20.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:12:31 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata budget check
Date: Tue,  3 Nov 2026 12:11:31 +0800
Message-Id: <20261103041134.33310-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103041134.33310-1-physicalmtea@gmail.com>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
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

