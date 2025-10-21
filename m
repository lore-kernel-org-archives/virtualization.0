Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930D340A62
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058625; cv=none; b=R1ZtRV1NnGaPSj6/ek8LOOv2LwqzDCRWN6h16Vpt68gj3Hrv1GllwBZPq+EQ5NDN9HaSwwuAXUcGvzkvLEy9mETHelrYJXnUBCW/BBJ1WNf+6G6508eYx8+IN6BHCRf16tz+p4sV43NEZCU+j7G0VqZY9Md5pv6waqxclpVDTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058625; c=relaxed/simple;
	bh=3zLiBpGpx3N7y1mDFocEIkcoo3BHMmz6kvCLUvGCdoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lrrKnXpzZeZ0BuLfJtz+VZqf8TIvGDWUPkDcIYdAdlkPmjIKbARNF7Wc0D+MPgxwL2IYm2nIst3UQsDPvpo6RIOgGTsw4bcXlZuPEvDH3iys7fH53n3NoR9XdpIFcjK4ike30h9KsDBBJqR6tjG19gLjnN1CGLjaRJK8OIFYbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd4c5ci7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd4c5ci7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ON6jaTzp8OadpSErRLgvJU/FcjQ+VbZlFjItkP49EIg=;
	b=Nd4c5ci7KiZJLTyb7Qk4/IHBsLAOIAY/DCjtl/Kq8nq2ICFDd1VmY5N8AhzBbdYVTJoCa4
	OtFT4x/M3nIyaJAIS6yFjPtTj3/vs0HqPlfO2mT8uGic/26GPJli8bKp5dsMV+UgnodU3n
	lLgP9f93eD10Y/Dxc+F9KsU1rTNfAJs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-NXydf_UzNR-PECQlsdrDkw-1; Tue, 21 Oct 2025 10:57:01 -0400
X-MC-Unique: NXydf_UzNR-PECQlsdrDkw-1
X-Mimecast-MFC-AGG-ID: NXydf_UzNR-PECQlsdrDkw_1761058620
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so113587035e9.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 07:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058620; x=1761663420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON6jaTzp8OadpSErRLgvJU/FcjQ+VbZlFjItkP49EIg=;
        b=rXGZtVPNxdxzYKexiY4pDyKvIA/qK8yahGl5Y7gvCL/TKRrttayJx325TWiQsq58l9
         r8b5OlnjcQf1og4EkM0j4jre2CbkiMzJ5DOUre8BSaY4KoTlUJep26LuwUQKA8CHQeyi
         MVuzN4X46H8/MReNXtQe6dJkFG1Z55SShbcvsAzM0Euxqqp9axmfDXcG0MxuX4tanCQk
         QASnPAp8dXiNjsmy4JnPLX+0O3JbHU+WeZBZ9qgMsfU+QeyXeJ+EgNVra+uTqwPOTdI/
         8RDBlWRZZgH9kWmLKFAqbUX/tJhlgAq4CTjDXkoqrIwcigjTss3UyUkGkKWc3QM2OB9Q
         GElg==
X-Forwarded-Encrypted: i=1; AJvYcCU+g/xK3imwS5r/Szcv6vTE9LEbz6eG0MKRPfDjWFpmlH33o8knPxhMQyWPNNy4zbJTJJLQ5Uq+oOYsKa28aQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzERRFu6R7ZpRrF0VwrxjKzD5gx4A/jBg0BGCVd2U/9CQmH3Eb0
	sxpfEB5DkNbzuA0hYF9FuaPT9ebxYf/tmkLHfs993KKAiXyPCFhPCqhCtBQom5LIE7yvZZC1wcq
	hS27CmmD+0rKhuOJd5kalZtPGPqJSoBoZCTGtAGHfLxvebTfRyLEUU+3n27Rat19SIkPr
X-Gm-Gg: ASbGncsjN3i0z6OpglDX+2iXPl7TWTTSAJ7yHCbfi52j7w/GeAZGxxXe1u/GYGHKFXE
	vEn+Z5uosTnnK9abaj3uFnnplEQCJyPuY3rigDurpomVqBwwmUh/pl5EnKmkWj/+VlDulhklVX6
	NBbCR0cTnTzJZuoukuKGQfXXCv8WQEuZ9Tmd10/CTBRGO++9FjBFmlK+Nsrcko0kQ8x1V7szJl7
	S9VcCJf75dUmeQfG+kAGdu7CHCj7HE5kHA+zib75U6Utsh+pmFu3iPN++2DDUBeY2CDu/y/RRzb
	jpEdngApDEfyQglnfLBJaNJZzZrP50tpcDRUdRPJq7q0u9C14R1o0Zt+VQWDXJsAE9WL
X-Received: by 2002:a05:600c:470d:b0:471:12c2:2025 with SMTP id 5b1f17b1804b1-471179140abmr147850955e9.32.1761058620006;
        Tue, 21 Oct 2025 07:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhlH9J/gDJ2/ok4e+k1pdgybvyjWEgAIxCOLewvwxsR9SE4iH4+h2twWM4wXk1Rh2Mp/BOKg==
X-Received: by 2002:a05:600c:470d:b0:471:12c2:2025 with SMTP id 5b1f17b1804b1-471179140abmr147850765e9.32.1761058619536;
        Tue, 21 Oct 2025 07:56:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm339012145e9.3.2025.10.21.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:56:59 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:56:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 2/2] vhost: use checked versions of VIRTIO_BIT
Message-ID: <5423d46e5c6f8a4204f8fe1bcea8bf1e21c10f39.1761058528.git.mst@redhat.com>
References: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yz9K5m3hMzKBLlb0s0FKwxExuXM-qq5NzD4A8mK7SxY_1761058620
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This adds compile-time checked versions of VIRTIO_BIT that set bits in
low and high qword, respectively.  Will prevent confusion when people
set bits in the wrong qword.

Cc: "Paolo Abeni" <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c             | 4 ++--
 include/linux/virtio_features.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index afabc5cf31a6..e208bb0ca7da 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -76,8 +76,8 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_ARRAY_SIZE] = {
 	(1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 	(1ULL << VIRTIO_F_RING_RESET) |
 	(1ULL << VIRTIO_F_IN_ORDER),
-	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
-	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
+	VIRTIO_BIT_HI(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
+	VIRTIO_BIT_HI(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
 };
 
 enum {
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index 9c99014196ea..2eaee0b7c2df 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -8,6 +8,14 @@
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
 #define VIRTIO_U64(b)		((b) >> 6)
 
+/* Get a given feature bit in a given u64 entry. */
+#define VIRTIO_BIT_U64(bit, entry) \
+	(BUILD_BUG_ON_ZERO(const_true(VIRTIO_U64(bit) != (qword))) + \
+	 BIT_ULL((bit) - 64 * (entry)))
+
+#define VIRTIO_BIT_LO(b) VIRTIO_BIT_U64(b, 0)
+#define VIRTIO_BIT_HI(b) VIRTIO_BIT_U64(b, 1)
+
 #define VIRTIO_FEATURES_ARRAY_SIZE VIRTIO_U64(VIRTIO_FEATURES_BITS)
 
 #define VIRTIO_DECLARE_FEATURES(name)			\
-- 
MST

