Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27F33891A
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873989; cv=none; b=aptgoQb7wLYhHbZCw8b7vfArM7Ym75L1EWWO5UmCwYH1foTb8CkccDeI1UjY9cDw/HIlYj28x+765baKS+XgZQnX1AIE8+fS+QLVMV6qvCwwaM8Gfr555TTPGtg0wAdCMFtX7pOzgmyNaNyUWc1OHAsL4Yp3aJslzCFr6mt6YxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873989; c=relaxed/simple;
	bh=4PQmS7qRWp1h3UPVEOCRFeLUvojLJYMmr2QJemAoMnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EyyYMxB/fNVTVH96Kv9VCOZUZfpuReDkwlKEZ8vcsQWFL6nXBgU6IhmMyaaLa746j7XDCROtVnca/CO027COZorZullf39IsnbJKwn9rv+tnlnVFC+6TqL17oAIYBZKLwGfBMT3FIj0XP6JS+kbv53y0x5hPFca06N+UQyyINFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POv7a7Xh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POv7a7Xh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKrCPUkMMlo/4uwAwXRYCqStNcHG8q/7bmW8IdphYAg=;
	b=POv7a7Xh14Y+sGbuPXBPnMVhs9+6xNGEQ6IPRB1VJi2PRnUnOXLGyQllZ9MGMQnQvRaTCA
	P9ATahgeXcyZPHLz5GJkQWhddcVSPyfOnvIQau0vNZvifGIlAhYeMv83/oBTUULtCoaFSv
	IiNp9zIt6DSkSptzA3opAXc5BBlsm2c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-42_TytMuPGafsjQq_oCPGQ-1; Thu, 04 Dec 2025 13:46:25 -0500
X-MC-Unique: 42_TytMuPGafsjQq_oCPGQ-1
X-Mimecast-MFC-AGG-ID: 42_TytMuPGafsjQq_oCPGQ_1764873984
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b478551a6so713040f8f.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873984; x=1765478784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKrCPUkMMlo/4uwAwXRYCqStNcHG8q/7bmW8IdphYAg=;
        b=Lm3fNqsRRAVCv7sCjbVkJBjZpzlnvDxjhsji6Iq0IXHBi+98ChtPx7TywZfZ5t0X2Q
         rRclpO/E48dCjN48F1OTv8amtQ4A0ILwhKxPa5umiqo7EvXX60oJ9YpyMKp92YZIlCo7
         j6fA64//vxqRd/yILfV5lRmPufF+/ZLy0pxFhUhp4QgfNkpNn7Uel40/fkMtlyPpa+hJ
         iKoALt6/TYPq9AV+/beKn0nDlzXj1CwjJDdy+dtE7+5Qkaf6yHOmDVQrLFJwCfgJkOQN
         bDVXHJolQv0Mu36BUz5WQzUCm/1+Snb0waa/0Q9NP6iYVZDW7y5s3VJHmM53ojeJji7h
         xvTg==
X-Forwarded-Encrypted: i=1; AJvYcCVz7UGYYMggroqlXfCFlSSAXnP5Oa3ChEEp1wwGTVN4WucntmvzB7EaToK6mJO8LKpI1aH68BqG7O4BL3O1Zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkrEVg5LsKZxy/E6BBhua7c6STbX1PR8RthWG+TbUqLzuhUFiL
	+13DLJO6n5unmLXxa3JH5yunhscUv+2tDUucwAiwESR8zSU4MRdobNis1HjOzOcTqj4nXn/DCAM
	bzG0rxNxOY+Pjp9Jzl7RRZbkyBbxpIzsZhb4qKsM7Jkoan5o6DYLi4HjL8w2HL4mQpa2d
X-Gm-Gg: ASbGnctOXHq7cMmg1zhrw0pQlcu73cSXFbhUfEgQNo5b10TU/GDhFp/ND8+Tah8EbAz
	VocCOlpx2idFQjte/5bMcBk5LU1cZQRm+ZkOmFZFpcAwJucpfaHmkguJHS9cNxn3EfDZVMIrOoD
	jVp5Se1zyqmzR04m2Wb2Gn2P8q+PixDnhujW9l/1/dDs1+fckvQntooXF0xXvjgS74r7jHBcExs
	qNtKxMofuu4OJWoYjezK3QXDulD61nvkbOF+gr/Fd8t2uXl5u6NeTKGCHW+5JdCjjTyCQJtPchf
	tIosMtuYC02UR7Rb6pWzAa9MkOVhdUP2Z88yyatHA3tyzwxBpNMCGKEQ9RLn535prNsmXBaaUhM
	=
X-Received: by 2002:a05:6000:1868:b0:42b:5567:857f with SMTP id ffacd0b85a97d-42f731ced45mr6365667f8f.50.1764873983860;
        Thu, 04 Dec 2025 10:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT0F5YASTgrJ5jzbcHsClIc20gGHll85h84q5sP7qxcTxPkXajPfZS7+MrV3Z6gSpS/bfuDA==
X-Received: by 2002:a05:6000:1868:b0:42b:5567:857f with SMTP id ffacd0b85a97d-42f731ced45mr6365640f8f.50.1764873983262;
        Thu, 04 Dec 2025 10:46:23 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee5bsm4561043f8f.16.2025.12.04.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:22 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 09/14] tools/virtio: add struct cpumask to cpumask.h
Message-ID: <eacf56399ba220513ebcd610f4a5115dc768db80.1764873799.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: UPtZ9S3kRS4JpI2KzQwuCiursYi-CS7pQt2tR652ZLs_1764873984
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add struct cpumask stub used by virtio_config.h.

Created using Cursor CLI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/cpumask.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/virtio/linux/cpumask.h b/tools/virtio/linux/cpumask.h
index 307da69d6b26..38ffc00e149d 100644
--- a/tools/virtio/linux/cpumask.h
+++ b/tools/virtio/linux/cpumask.h
@@ -4,4 +4,8 @@
 
 #include <linux/kernel.h>
 
+struct cpumask {
+	unsigned long bits[1];
+};
+
 #endif /* _LINUX_CPUMASK_H */
-- 
MST

