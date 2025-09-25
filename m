Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60942E7166
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780258; cv=none; b=ScsDHOE51fcBOA6sFmhGgM6vvwwryqUQxAgJxFBIQAAh+gYMRxQZPzOG9mdRtBlPzlFNNfoL01LpFYVeDRphc3p3Pv4fwKa16eeSm1hD980qeJld9fI7mWOgYLoBMhksgUH0J+/01l5ydOgDb8r5Rb6Xpf4XI/Oyh2/3Fclxe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780258; c=relaxed/simple;
	bh=o0VNqoePQ9Fxc7vePL+KVWDFK3PNoSh+8m9moiHOP0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=stOaViXDsGtVBBWFsPC/tVa7B+/O3txK/7UeQPG8vuUtGsKUGtpwy53ImgZYFKZ/uC0k8r2qBRZ3AS8Q5ya71j3aKCMkmHOfFyvxChBzEnIBoXoG5DNx2qgN0wpvBpBpZJ1iJMct8RPopS+V0xo51vWAG73p0hXZuKfDTJMyFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUn+rXDW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUn+rXDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758780254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aFGTlM/AfVM6UoD7+6D0K+JKl8i8C5klHuPNmVycESE=;
	b=KUn+rXDWI146AW21Mmas//VI6a9PcOGmNaTNVNhwH7crKupGYiPKiXw1j3Mkq2mEP1/D62
	B/zE9voWAzLLAJT5eamxMFjzFtjUuymUbLzuJqo+yn6f7zncxlaRQUS5CU0dtizl/YiWFU
	qhYDm53DgHcQWIIXdnkbf8DmodYqLZg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-SaplKIctO6CmLfbX8Kwhzw-1; Thu, 25 Sep 2025 02:04:12 -0400
X-MC-Unique: SaplKIctO6CmLfbX8Kwhzw-1
X-Mimecast-MFC-AGG-ID: SaplKIctO6CmLfbX8Kwhzw_1758780251
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee130237e1so236535f8f.0
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 23:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780251; x=1759385051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFGTlM/AfVM6UoD7+6D0K+JKl8i8C5klHuPNmVycESE=;
        b=qNuF+mC3k5yinOOpy1idX/8bxqQZMrzX8nxum6U5TWVmIEqFnNjWxopFejwcfYfij3
         jpszZjOB9Hm81u93117ITuWk/yU5gMNQamXedG/4LLYZVn5piq1bEVcbtfD/aP1bRZuR
         9YaxEA0+dkxr2pnrXiDWNRIB4IzaCG1SwqOnH1zQgWkV504P6T4cEnpb4JCHNhKiK17y
         nTJkrIqESDjgUW6JuO95etxWhSnK/xjxU2+6ahwURMPsvYQqjs0MadbnmaTZPEiuaFeH
         7hx8nk2yCx/xgVa3hoDGZO535oRB2jbXHxqsC+nSROij00FUBH/ggy6b4rWFyoUZibSX
         wD5g==
X-Forwarded-Encrypted: i=1; AJvYcCV5x64AaU4VQHkQY1pf3tZO1yBt7JVaJ8WihRIew4jQyg1QCWWJ2JFXm3ZaQZr8MwwbKqPN8ZTotfTU8/6rww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGd/scH/9tUfLoq7HZ5PbAjoDvEuQcHXozAGS9YWYcYDZShEJL
	coPyW6r8ycYvW0tl7UAjLvmHSoFXsBVahQ0FzVPhjB4IYZWGkPpHMi9WLcqpVNabg33XVqyMDdf
	9gpAJgBUhx3gugKlYCjROnqvYN3LDN1Avj/JYAGcSpydtmKtSfVm0cE4nILbbtz2YANwY
X-Gm-Gg: ASbGncv8QRsMR8AyTo9ry2bihaJblIa7Fc7fKQ6K4qAOL8Xk0bam8JKo3i6mapNOZQY
	mtW0qh1qN7SEt1mSpdR0wyaO8pdK7W1+4v4R/wq+tdUQkIyC7oL9IH7yrfgCPpfcK3FESrOTwhA
	E5M8+GuAk6P19HFy3Ho3CmD8t5jDmp9n3xyHvftNKJmrnGgejNAmH+rRFgVrlayUQioaf8FSDdK
	XApUIk9frkrZLhlIOVyaKHjw1PjWvDasRKcXD5FnifNJ4uPjU/8pbfLI79plFxbbOQ8ZIW3MQRE
	AsU6qSUDlgRFOHMjo8zaCNXtCrlohvmZlQ==
X-Received: by 2002:a05:6000:2912:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-40e49e725f0mr2176049f8f.56.1758780250921;
        Wed, 24 Sep 2025 23:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzXROWH0HheOoR3C9U+J8DhuDXRcMrs5JaiB8XcConfDaf/URbl6oeL/NMdqI1Vf+S1XrqWA==
X-Received: by 2002:a05:6000:2912:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-40e49e725f0mr2176012f8f.56.1758780250483;
        Wed, 24 Sep 2025 23:04:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm1463946f8f.37.2025.09.24.23.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:04:09 -0700 (PDT)
Date: Thu, 25 Sep 2025 02:04:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net] vhost: vringh: Fix copy_to_iter return value check
Message-ID: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758723310.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cDY0UNuii6I0W7NReOHXJwl6dSXVaUeCTbb6y3fBctw_1758780251
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The return value of copy_to_iter can't be negative, check whether the
copied length is equal to the requested length instead of checking for
negative values.

Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vringh.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 0c8a17cbb22e..925858cc6096 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1162,6 +1162,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
+		size_t size;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
 				      len - total_translated, &translated,
@@ -1179,9 +1180,9 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 				      translated);
 		}
 
-		ret = copy_to_iter(src, translated, &iter);
-		if (ret < 0)
-			return ret;
+		size = copy_to_iter(src, translated, &iter);
+		if (size != translated)
+			return -EFAULT;
 
 		src += translated;
 		dst += translated;
-- 
MST

