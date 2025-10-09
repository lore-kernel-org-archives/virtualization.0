Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C962C1597
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009066; cv=none; b=uJNV1LW8/vTQSf5dsuWwba+5AuvIzlAGUTzsB7q0AxnfGqKbbfWgDc9+oDkP0lWXTDcTYfgQHomS+2NQItJNcf29K6Fj/qj0wyYT5gSGPZlc3HXIPLDaMxaIBioqZ9iScNPXDy97LA1F146P1dc/x25Ws+6KYS19V0MLgNh1dU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009066; c=relaxed/simple;
	bh=35UYEAy9Siw0O4CbsRPOR1KpEIW1hIqotirWcRQXYGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eMp/KmOn1zlla9mgJceHeSAgmowm0s+xP29TxaudXlRP7wjj9/QUZRwSuvQ4vBhLufmi+RdaE4M0S2/o3ST8sb4Re5bFoycFRgkXYRiYd/Ss+DNMpSxw6R9xbz8K4Jy5gTcfzRzrm9YR3RpW1fmZD3bNJ3ipGP//VEYxCcgAjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKjTAnyi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKjTAnyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760009064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S+cs/cFEiq3598A0wbNjyWy5VUcCWcxIxlRvjHMyPY8=;
	b=CKjTAnyiUqeekAdkAbtk0AqTjF9mstvGO1FmuwYWflkIiL8ZSPn6dgbiqPuylwvO8q+DHw
	qEM2bBPkxoz8wGGcKf+mLHranCYMRqOrtzUfnu9Wlwh4GQPe8+DyOET2JHC7gs2Pr73ZE3
	pjt9RKidRHdbU8OOB+jX5e47tY2yBDU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-RNjyESIGMmON1QDcQQp28g-1; Thu, 09 Oct 2025 07:24:21 -0400
X-MC-Unique: RNjyESIGMmON1QDcQQp28g-1
X-Mimecast-MFC-AGG-ID: RNjyESIGMmON1QDcQQp28g_1760009061
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-79e48b76f68so38398736d6.3
        for <virtualization@lists.linux.dev>; Thu, 09 Oct 2025 04:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760009061; x=1760613861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+cs/cFEiq3598A0wbNjyWy5VUcCWcxIxlRvjHMyPY8=;
        b=FDfBhmir9faSQF1u1UI2kppuGDnD4U4hcoV6BSaIgqE4CLnaiwbdvs5MbCy30hnOC4
         Nn6YpNM3lMG1zZs1+HYIqTdSiCqYvBFtiUlpuJUL3NHpATK1KxtIjBDuS/+tdzme4UPM
         M39VrNOUtIz7jftzrHWAAvxcpfs3vCCfPchaCggSh8tbclLVGJ6fQKZwSaYB4KB7s0u/
         0XvCqd6Gn3LSjTvN8WGrdXLW5u6oKZ0tHCI5eGqf4rJu3se+FlSzauIYODNR5HLgTOFr
         Ji09LOfzNllzjkU5z4QbSlv7rhrL1U9YbWYygjlJkPMuxa0u7hUi9PgbAfqMZhTyfL+0
         GAJw==
X-Forwarded-Encrypted: i=1; AJvYcCUE3Rb1dBxg8yFL9GWSWtotNJcQulOHlYKvsR3Ss7IEdKFD0T3Cq3ZAD5DIqKOL1src7BO5/b19RmUi8pdoMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1g8LpbJe8iz8QjG77B1ueiv3wWM9BHJ5lybcvZZmexzwNsk/4
	LTfMJJt1IvCnFjEnwJ7FPtmEK/KnvDQYiZARlL+fvpQG3BiNob+YHn4sj4915VIIfTezOHLvz8F
	SzRL7VUS9P1KU04/D7IqJqPRHG980VoeMtJhykA/nDpU0w0M8kNzu3wBqVEJSi/RbKnUq
X-Gm-Gg: ASbGnctul2Nk/F2mqV9CGin9Yr/OmtgfqlkZzEEP62Npu1tYkBFm33IazyNjxQltxJR
	HgMdMeg9pOAqMpFMG+URk4KANPzLiDsWJNJY5OZngRv6QAaa7wosUae1sAB5A70H2jFDoN4MTJ8
	fQumzW3W9RYRKRPl8hJmcGVNWJIvJljXtY1TwSjZkKrrnSOKLNb4C3X1NSi6UKFZymgTS9fmvSg
	awskZgB5Wr7HbL2Y8YdboDf99VGgvfxpZ0xIYN1mts1seGiDVm64YXgds9+bkswxWLg5S1rSO/H
	rjiBHIaWktZpvVEcjGb7JX9l3W+6NLEvxyU=
X-Received: by 2002:ad4:4ee3:0:b0:802:3b85:ee18 with SMTP id 6a1803df08f44-87b2dbf70c7mr98352946d6.36.1760009060740;
        Thu, 09 Oct 2025 04:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvx4dSk41JvbEZka6APS8zgOi8sdCQFv4O7dgaejzBvc7AARV8O85qCp/D4IeK5PK1183PNw==
X-Received: by 2002:ad4:4ee3:0:b0:802:3b85:ee18 with SMTP id 6a1803df08f44-87b2dbf70c7mr98352316d6.36.1760009060013;
        Thu, 09 Oct 2025 04:24:20 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bbb1cf52sm181311206d6.28.2025.10.09.04.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:24:19 -0700 (PDT)
Date: Thu, 9 Oct 2025 07:24:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 3/3] vhost: use checked versions of VIRTIO_BIT
Message-ID: <6629538adfd821c8626ab8b9def49c23781e6775.1760008798.git.mst@redhat.com>
References: <cover.1760008797.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1760008797.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vn2vj8gFkbKZa_CjTE10gUzYKzwKQhu6VX-0rQ7uOS8_1760009061
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
 include/linux/virtio_features.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 43d51fb1f8ea..8b98e1a8baaa 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -76,8 +76,8 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_QWORDS] = {
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
index f41acb035af9..466f7d8ed5ba 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -9,6 +9,15 @@
 #define VIRTIO_FEATURES_DWORDS	(VIRTIO_FEATURES_QWORDS * 2)
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
 #define VIRTIO_QWORD(b)		((b) >> 6)
+
+/* Get a given feature bit in a given qword. */
+#define VIRTIO_BIT_QWORD(bit, qword) \
+	(BUILD_BUG_ON_ZERO(const_true(VIRTIO_QWORD(bit) != (qword))) + \
+	 BIT_ULL((bit) - 64 * (qword)))
+
+#define VIRTIO_BIT_LO(b) VIRTIO_BIT_QWORD(b, 0)
+#define VIRTIO_BIT_HI(b) VIRTIO_BIT_QWORD(b, 1)
+
 #define VIRTIO_DECLARE_FEATURES(name)			\
 	union {						\
 		u64 name;				\
-- 
MST

