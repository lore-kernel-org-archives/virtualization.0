Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC52AD32
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873969; cv=none; b=fIkXS8GSJBHCANlC7pgJ9A2VMjn/l0zeTsU2+OEh8kxJkre9h4BeyFFUciE/XMA2tlEKMznfI/b2lRbKmfiSwDCPKPwUVYYeFxiLOb8r8b9/2qKs+uZYUgfdj7F2J8gRE0JZ7B1zWgTpRmY/cqngeijzSxr4M0/MHawwdpx5sf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873969; c=relaxed/simple;
	bh=f58nHIQz47Oh0Kg4MipJLTpJrd0xjXkMdlIJGHq1QKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rZ65xDbFFdts+z1uqcY/7ZVA0vljs8vZ8eDJ5MQg+5x97B2ji1/ZDewyF2b9hGZSQUEFPxhGIIBNX5sRSSa7lrmwz1rcfYvQ7W2Icz0AskqoqXO3FyM4FxWyJtRWvIhbO/985uQFIpyaE9skVDE97ZLBX5/IZmi/QT9lQb8nGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HF52X0ZY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF52X0ZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J7W2y9TMzxCLKH6ePY7VFs+mUMTbmxE19/CG932s30M=;
	b=HF52X0ZYt0VvKkF96gG9om7R6ancNL1UWCDYtmGDIEGXiOD54Olom0iDWkBg/IewzuRISd
	/i6Pk906a5f3y3Xzw6wBIoMcBJ/g4pmb9Ei3vAvRN/CzmBjIf8XXVD9cFTu3CoHICJaPPW
	sLJHXUZxuhy+x+QeEq3H/6y44HNNKtI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-qV8nWtCUM0K7x49RS7aeuw-1; Thu, 04 Dec 2025 13:46:05 -0500
X-MC-Unique: qV8nWtCUM0K7x49RS7aeuw-1
X-Mimecast-MFC-AGG-ID: qV8nWtCUM0K7x49RS7aeuw_1764873964
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779b432aecso7791265e9.0
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873964; x=1765478764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7W2y9TMzxCLKH6ePY7VFs+mUMTbmxE19/CG932s30M=;
        b=iKl+BAZAWBqRZ70mrJbehxoZC72UUS5qIjqeXLvJAkA/SJYc11lyOADY2fx6V8kfEN
         zapgJ3vSzbyS+ZUwTn4Jvy6eFAosgWoMXb5VhTRnm0B+QeEXtNKuQiuNZgPTbjoOtZRq
         jmERtBeZ2kcWWhq7guDfwvSsWUxGhF8EewP3n5vJn4caNaa9C1zbziwUu5FVMPnxYv3H
         3gPcDY7azSMzzyprChd4LsITmCWP8Qh4I8o4B3GIR0ErnKzpxBbl84bpGlark8slr+6K
         D96ao7a/Wt+nMIE4Zj414tuof9XXnOSFC/Ggx2kHko7iSO4jkSnPVe24odL595ozVuJa
         JyKA==
X-Forwarded-Encrypted: i=1; AJvYcCUCAxho722KgBHxRVPJovVsYK/zyc0TY9K+ZcUju+ItuVsQErLRK3a8+4qzjj6EUD5rIlqqPnma8hKUf7HEwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpvSqIVlQDAXJUcApxajlQ5TJRCEnv8OHaOuBqyRPC52nX1nro
	4T/TCUZgk/4wYJwvHpavaGOrSISUECyPVDuFIBI6uQieoOVALZCUkEMdDrJa32wj9aB4gAN9s0n
	+ohDhWmA0nCydQLIBIVNNHsjcyEwfn0WEtUGkG9kX8P721e05AnmcsKMGqD2rvaqMZ+/RCfWz+a
	Qr
X-Gm-Gg: ASbGncuBab0Cw9zSwxc2OeV5gkQIE2zI7crbJC2gL2TfTZ4V3LikvPAv8cqm/JhZwxs
	XIsPUcFyck1sVrRrYva81HBj7+H36YPjZHmTWETCVf5gVLqlSuVbyBj88I1qCaKlS+bq0DK/OL1
	6I1lcFSxrWi3VrmqDmspR7T1Z1KL3uiEhDYEVPSnNy4+SVt1P2uh2EXIoxY68wckpi9/D2gGWeZ
	wbPrm0SryRrc9ZJAfToiyKkejkvHQn3NzNmb5ViddlmuR9yJTOXvK6XPSPmQsTYwLZqT//DHB+r
	K9muVcQQOqb0NbKdgACHYfQkMGAutR/7o2bz9vfVoXHU1vmg8d47VIWlEfpUYTnra8KfcBh/cvY
	=
X-Received: by 2002:a7b:cb4d:0:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-4792af1b1a8mr52068375e9.21.1764873964201;
        Thu, 04 Dec 2025 10:46:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpdXRCAWJBoqSiLYVx9eCCXM/FwDscTSunOdpVga7Xltz6hoQw8oOR/1MYJQE350t8nz70LA==
X-Received: by 2002:a7b:cb4d:0:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-4792af1b1a8mr52068205e9.21.1764873963740;
        Thu, 04 Dec 2025 10:46:03 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479308cd87csm46533335e9.0.2025.12.04.10.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:03 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 01/14] tools/virtio: fix up compiler.h stub
Message-ID: <56424ce95c72cb4957070a7cd3c3c40ad5addaee.1764873799.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: xxxnEcPhNkQioZwV6X2DJ_R3pCDlotbhGbr9SagaczM_1764873964
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add #undef __user before and after including compiler_types.h to avoid
redefinition warnings when compiling with system headers that also
define __user. This allows tools/virtio to build without warnings.

Additionally, stub out __must_check

Created using Cursor CLI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/compiler.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 204ef0e9f542..7f9e308f3880 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -2,7 +2,11 @@
 #ifndef LINUX_COMPILER_H
 #define LINUX_COMPILER_H
 
+/* Avoid redefinition warnings */
+#undef __user
 #include "../../../include/linux/compiler_types.h"
+#undef __user
+#define __user
 
 #define WRITE_ONCE(var, val) \
 	(*((volatile typeof(val) *)(&(var))) = (val))
@@ -35,4 +39,6 @@
 	__v;								\
 })
 
+#define __must_check
+
 #endif
-- 
MST

