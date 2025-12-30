Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB852DC769
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089767; cv=none; b=s3x0Vz61btQYpS9Wwa22euT3PDudExmZc+x+CW5Qwj+PCf6jvjIJoo9oGt/3e+LWXRNVVogJfCQRjPAQF6AnPVdD3zZStKlF4obsT9ls7H/2ardBqZIAFIbcmEctiYlMDAtQZsIftEveoXmlrsN0der4G1QqGNGKCKLUud7VpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089767; c=relaxed/simple;
	bh=3EF4beueqssYSrJr7jAiyWtRxi/ynmIi31SbgxtAbxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nGf4Ongf2CRJrHkkSeNgWtISz3wFajqC3TVEZATv4CCLvnEJeZYpV/qedmtfbrmXekAQCYY4Za5SCg7vk+oq1uA1+2nLBzXPhlm9erIsipipDdnndhYEAcjjDPaNXjhZmRBz/M4yO1UT0o/VaKkquZdCbKWypyFutvS47dnjKYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ig5ep5oQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ig5ep5oQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
	b=Ig5ep5oQfWTSijshrhmphh1kZkOF0/D3T4IO0PkmzcUJ9LMbjzNp+u6jZ10CCW4QVl+zOX
	Tya5yn+N8eUQwS6+O8S7fVAFMqh66YiNsMIbM3BzPQPZVUlRDLR/1xsJMoY6lRsszddlWC
	jG9Ke2bvMqJsbN/EmJMgf0wOxMckYuI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-4BMy15PpPa6BlXtSsaA_oQ-1; Tue, 30 Dec 2025 05:16:01 -0500
X-MC-Unique: 4BMy15PpPa6BlXtSsaA_oQ-1
X-Mimecast-MFC-AGG-ID: 4BMy15PpPa6BlXtSsaA_oQ_1767089760
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fdaba167so5224330f8f.3
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089760; x=1767694560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
        b=JAP/gVs2Zs9z5PqTi5/3Cod0A/tfxfRNLmcy7/zckqf7a48UWwUI+pVZw+o/9SVFuT
         fTETK71a0Auk1oDnzFBhf3g0yHzLv/F3lJ5r321YB1j4BKODX51GGnQf3ybRk2TDvHGa
         vUgOnSPijz6PbBTuvWfbBET3BUoPQpEe6djnCNgjO+mLsw+J9PD13FrQ3UMGuNC2nR79
         ke9sPakCv2IA+/3jQEbvBwgtCaD/5O3BK/+GCrsVnPHMCKOjYODnZvgBr83E0w10ywMy
         UZN1jZnrqTCa6eimatRKiFG1Zb+lNEiqBCYr1l5M2soq3X0ifJ011hIKTITMXozBeo65
         Lp/A==
X-Forwarded-Encrypted: i=1; AJvYcCVQOb8XhOvds/QsgnImnAi5A/dEwJocXd65JKOHTKPyx/z/ctiSobQfMsqJDbAPIfMxqvDrEijJ51sByGQnUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVDp5Me0zwKVTq54beDdtEp3BLxBPQgecLV8snEAFCBJwqDZip
	NTfZZJuGh9DoUD8ZmcaBZKeQbogYBqF86rAou0N00SlO9M1xeHKlnrG5ERMWxizKks7WlqgDyek
	P1zVVNdCNY204hstB/TaWntmjsjOLQddnIZswUVgBQVgD7rx3H+ZDb+PVFN6X5wkjPlDa
X-Gm-Gg: AY/fxX6ABKS5MrSbEA+Z+FspDRTMefXeQM8Q3ws6Cq5Qlq4gO6SeGcDW/FOg9g8R9GW
	vsj2W72aLV2QKrWkhfE03lTnnZyLkcoBx5FuK/pIClC/SvlD+O0IRE15VX0i1oBuaDohbXq69rG
	eyI2PeMCgeBhc0t3LL/+z2VbJCaUSw8ZzXR7idqn4UjVXVOzwrLxO7piRAmAu+rwJoVfM471ngv
	R6A8K+et7ndExz8KNHajCeJwX+Uu7fkTZs/o5DzUjANIH9mXmHj/u0a7HOzUNIgZVbnt8Xcb7Jb
	6RzQmrJYCLJgk/Z4UWkeadsyKbJxVlTuisN6BpGbZ8nGVpRbYAEYv5q5s/ulug4Up7it9eH+iqs
	kVpEywhxuPHGawmevEBM+CJO8Ccgdwa1TeQ==
X-Received: by 2002:a05:6000:2906:b0:430:fd84:3171 with SMTP id ffacd0b85a97d-4324e4c9e98mr39750105f8f.22.1767089760400;
        Tue, 30 Dec 2025 02:16:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHondA4WovcXdLOT45Lj3uVr7rduhIOKgQxT45AJwE7sF5CS5LqWM7ii/WKiPGqmcKK8QLbHQ==
X-Received: by 2002:a05:6000:2906:b0:430:fd84:3171 with SMTP id ffacd0b85a97d-4324e4c9e98mr39750079f8f.22.1767089759925;
        Tue, 30 Dec 2025 02:15:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm68448837f8f.20.2025.12.30.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:59 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 04/13] docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <818c7ea78e43b93d1bb3995738a217e5e414e208.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n2ET50t8FfBWmJVUzG6NAUwuYJAEe0SsSwIF60wVe7s_1767089760
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document DMA_ATTR_CPU_CACHE_CLEAN as implemented in the
previous patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-attributes.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 0bdc2be65e57..1d7bfad73b1c 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -148,3 +148,12 @@ DMA_ATTR_MMIO is appropriate.
 For architectures that require cache flushing for DMA coherence
 DMA_ATTR_MMIO will not perform any cache flushing. The address
 provided must never be mapped cacheable into the CPU.
+
+DMA_ATTR_CPU_CACHE_CLEAN
+------------------------
+
+This attribute indicates the CPU will not dirty any cacheline overlapping this
+DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
+multiple small buffers to safely share a cacheline without risk of data
+corruption, suppressing DMA debug warnings about overlapping mappings.
+All mappings sharing a cacheline should have this attribute.
-- 
MST

