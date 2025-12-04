Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56F33E37D
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873994; cv=none; b=KEB3X17yVPoJcFh0vhv0C/IB4UmPhHnpUetgR25D99YfBGRpm+H1K547r7vKIeXILCTj8RwZIjhauGA6LCBGnTcVldvLvX22cJ6xACReIwcLBe8Xl1B6jvcjsalCNCtGxMI0jkLi1tHwliiwaR4NBr9fsSy0qdO5iZeKWW7nt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873994; c=relaxed/simple;
	bh=NHWs4Ry8HHRLf+o5mhmm41ueMxFv4C8ozFsNMdNkNEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YGnQNmVqchABBYPP1vWGH5daTkLi26Z1pzGpGE0sxmmoqd2eyRu/zOtiDU4QB8pYd+gL11h3ZfnDMPC4K0OwbiyCxyshXRaRvXoEhhFilMBDKLWVe8IdgfhzjYyJhe9gEnYzKa+Kfykkt+oqaGhFXeDyOoE9tUAbmAbLlS44PR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blS6Ai1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blS6Ai1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+LGEfjXuYA5o2UOiQcd+BYHc9d9GOCVncn80x+Iovs=;
	b=blS6Ai1aQZ8rsvbMOXcEKysq8DkR/KaeH97vN5k1uQNZmv7zCI5E4CvBk3+fuMQcN9z/9J
	wYdpNVSs0Jqi9Snx0kP7vlg4Wz7X4PwAADUi0V+vOQf0l0gp0JCmCInKysyQi3XYlhKi9u
	ZN2VdxNuXaeXfmbifZUgypadpHvw5Fg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-eDyF0ev4PiWwJIK2T_Azzg-1; Thu, 04 Dec 2025 13:46:15 -0500
X-MC-Unique: eDyF0ev4PiWwJIK2T_Azzg-1
X-Mimecast-MFC-AGG-ID: eDyF0ev4PiWwJIK2T_Azzg_1764873974
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42e2e3c3e1aso632433f8f.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873974; x=1765478774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+LGEfjXuYA5o2UOiQcd+BYHc9d9GOCVncn80x+Iovs=;
        b=IMkXz3NM3KhiHArZg88Ccoo92pHBnCtVMW2BIwox9EsT4uI5E40XLauCt1vg6TUzqJ
         UCxCfpA4ifgQHkqFbhalsIW41qXqL2coRm8ImvKkXBC54FqoNHEraj4z0F0fj1dwrLMx
         Qc/k8FooK8qCvmXbTxpn6QoLPrZUCWoNFyILTWtRad78xsLuXaiPwBv1NO14XDLaTeQ9
         ixXcSBDYN2IXeiY2Z/PcSOdqcKIDPQZhtK5y4ghdRRFtUFo2iYuYrR1Y+hgP3hwrVz7A
         sbe8+giZ80YvfGaFi/Lt4wsn9LsALz640xgRUAJFC9y6S2WaiFFHS1/a1Fid+9YDA82R
         QaSA==
X-Forwarded-Encrypted: i=1; AJvYcCXjKPMQP5j4lJYEpIZNrbMb5+nqZUih5T/7N6e+dcjx92I+VnCmQwNB+I7MnYtbSvNLEcZ++y8urxl7cZGMmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCUmAmOa9lJuxPF6Z+ZdYrfE/BJL+9WWXBKCQwu3U2ONEo7QaZ
	dE2MXgTwFspZhVWVhF92yFIgO2XkIimsLIb9maGBALjE1yEH4sfkhNiIO1EozCsKrXRmhyrAH8x
	b/VL8h5I74RteoRcrgYpsSVptToIvoKKCLXA0XnsH5u1m7Y6hSbUNtENWDklSC51cGfPS
X-Gm-Gg: ASbGnctDp+uWixnqcJad4+IC4lV9ftugyIBogL9ge9AQi95rzOvcn/i2WT8B1eA2Yk/
	Pu8BwhllGvScXVOxZzm7f34E7/AZmdGDnOnPVBKo/SXOZACo+ysm/hPvIrDzgJijMJMciWTstVL
	cyVd2ODPQE/b7N6GDEUM7qRc3UJ+gsIFQLskzZhU/KzHlECbWKqSSYuS56iRGRqnA2DbyASCAlp
	QUbFyMRzKD0w73XnBn97TSZhvT0tU0UueXUA7wU/uXRBePBHGyI0HKRlk+VjAdkzMztbP897qGp
	j6SUQ3DTTrKU2x+ZKLyrC2jPAdIHr1b8GbDSv1Z2bVEp9SGpYzDpDUkVKOOhfLkQPpnbeV2QroI
	=
X-Received: by 2002:a5d:5f53:0:b0:426:d54d:224d with SMTP id ffacd0b85a97d-42f731a2117mr7561819f8f.27.1764873973715;
        Thu, 04 Dec 2025 10:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZUaysE9egfTG7fFLCDV1yR8PGeXIX3TUqP6xuF1SrAJ4TxPfJVYdDMI1teljcp6EnjeAKwg==
X-Received: by 2002:a5d:5f53:0:b0:426:d54d:224d with SMTP id ffacd0b85a97d-42f731a2117mr7561783f8f.27.1764873973187;
        Thu, 04 Dec 2025 10:46:13 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222506sm5303879f8f.28.2025.12.04.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:12 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 05/14] tools/virtio: stub DMA mapping functions
Message-ID: <3512df1fe0e2129ea493434a21c940c50381cc93.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4_YMb07D__MTp8Uwodj2YKT2a-x0_tRfUF7vOnhLZco_1764873974
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add dma_map_page_attrs and dma_unmap_page_attrs stubs.
Follow the same pattern as existing DMA mapping stubs.

Created using Cursor CLI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/dma-mapping.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
index 095958461788..fddfa2fbb276 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -22,6 +22,7 @@ enum dma_data_direction {
 #define dma_free_coherent(d, s, p, h) kfree(p)
 
 #define dma_map_page(d, p, o, s, dir) (page_to_phys(p) + (o))
+#define dma_map_page_attrs(d, p, o, s, dir, a) (page_to_phys(p) + (o))
 
 #define dma_map_single(d, p, s, dir) (virt_to_phys(p))
 #define dma_map_single_attrs(d, p, s, dir, a) (virt_to_phys(p))
@@ -29,6 +30,9 @@ enum dma_data_direction {
 
 #define dma_unmap_single(d, a, s, r) do { (void)(d); (void)(a); (void)(s); (void)(r); } while (0)
 #define dma_unmap_page(d, a, s, r) do { (void)(d); (void)(a); (void)(s); (void)(r); } while (0)
+#define dma_unmap_page_attrs(d, a, s, r, t) do { \
+	(void)(d); (void)(a); (void)(s); (void)(r); (void)(t); \
+} while (0)
 
 #define sg_dma_address(sg) (0)
 #define sg_dma_len(sg) (0)
-- 
MST

