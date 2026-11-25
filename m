Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622498;
	b=bRPaqME+H14JCWVjtTTQckfrXptuugFdFWl2ZCiM6GE8zmbDH5NK6+t/UGd8bjMOy/yN
	 dfeqgkPK570rh/qHgNFaoT6r1Izw5fMwUJsVulQ3cQVK/NOZVTfyajIbC7t8QM9hRNSy5
	 y6sZTo+ROFe30488FJytG6Y/QSNxCtbVeCEhLbEhI5Hvxa3UgRtbxKs+72+sYo5Ntq4Tj
	 ph4Pda/vwIfrqTFTd1v6S24C4+CQuUWeRtWJQ6hSmTIurrKqezHANMLrXzlsyB12jva27
	 TRGQzNiBv/TP7VsddJXhyqP3PhdxI+vaJm+Dxy4op5U84SY+PgjQ105YKh2X7n8+X6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ClKnQa/VnC+RbYcmAaKA5Lo4uOLHVVXMvjGc4c3TSI=;
	b=ymfImtpcXGezzRQhscJut9qlQo6KpVPKGCRRctUempTRl9l8B5KgTWaGXMmzgnrse5LE
	 bi5kmJLn8iCY3kqguMhqcSWyRhKQkkHCy1lv1Jo8N8jMuang5rILGzqwNMk/+PTBCCt3a
	 mcJDIlmhsldZN+30+VFsRhsjhFWFCO9+/goh59Sju+tYq73GASJyQKs/qwqgb05TWP8rW
	 3utZFq8B1pFgMYqC0umTp5TsEvsH5tcitb0+2LgWRZQaqdlrYAHRrIy85zGrovitKVtwY
	 aBTy5sCIf5aXK+cvzITRDUEIPNmRoUFLh7Bpcm87RtoXfSnkKXu+sG5gHqoys+QdTHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="R/AIC3x/";
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A864606A333
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 16:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A864606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R/AIC3x/
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b271e573adso2565102b3a.2
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 08:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795622496; x=1796227296; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ClKnQa/VnC+RbYcmAaKA5Lo4uOLHVVXMvjGc4c3TSI=;
        b=R/AIC3x/CWPr3USlFpmOSi95pWuDK7xnk/Y+5OVrinhhgydloYvZueY0VXejdqtRj6
         YiyFR8dFPJhVpyX0stdYRPRl7Fu1k/cbKmACMKHYqBxdKzACJKdP9RpwNF2yvnhUldea
         Ek+fbAIUx3WalvhLalpbHotzf8TDL0+9RGycnI3vKmc5B44UyMLXjbXbzlOv5SJBpDSS
         5NUYrUkndcRT6NE3f3Jdir8BRuqmwoWfkuJ5l/wZpmptk/rtrpQ8uK5BJvuYof4pcWqH
         2iDhScmiPyZoGQIfKUuudvpfWJcSGpEN8l2WMRalmduMAJVZ3jhcmCZDSS0dFoG3Qa4Q
         413A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795622496; x=1796227296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ClKnQa/VnC+RbYcmAaKA5Lo4uOLHVVXMvjGc4c3TSI=;
        b=2VdRvQY3Vs1SwyWIOwAospQBwsBKoftI0HyjobLB8vK3iIdHrHsr6AK/OpyS1q/EJ6
         huNgna9SJvpxFPNrEqZn8TuBdBexVZvgR2uBO7cTvh4+Pbrbgz3jl1dLoJUSL9/WfR93
         JbzPy7S2VTpAXHx47rwPxZYxoveIgA18ekaN9/q3apsEoofLF267ONbFofd8W1dQC5US
         jCKyJCJ+tpa4q7hMRb5XeWp3sLwO8lDLqX2dDuoM0eCmunjWZmsp5nb5zASCz/5RjHHt
         EQbiqTfdwYd5RRWxD9Q/3Fyg/SaXZKZFQ3YIwAb8lFe09ZMNomVrd7UEDFdxeBw9N1C4
         +qyA==
X-Forwarded-Encrypted: i=1; AL+hErH3qY4ozRVwQBVYFSucfseGprvdvmAZz9tz4iGxuGyHuvhX4dSRCxdIybHVxc9MdvngqtOx08AagHHp2jdyAg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8vqV4JAvHhA3MKc/NdUwTWEsJjAgik3CPME9gq0vDFDLIHQTx2
	OdKoyDuTF/XKDcpqSmao5asCcoYg2v3IxAjnMRkXv3boEkk7pn+kPOwE
X-Gm-Gg: AZFdTZd3/kKPcalqnSwWLAC1jhVQUhu0Vri/9WfbrV9ogkUrsTnSIbQL4IneQmqYqb4
	lMcgahygubTh8vNYXgsHW0xdow0GJzTnkuyuN8IBG8TdNCKQQRrYtoN4TuyrTnap3JmnjvqJe6G
	+a6DbPO5ecxvo3BqOkdngj+cuS9b3jsbgVCrbh8HCpkRDBRTWPkywt4zlBKUi/ejZHM7281BJV2
	jjRVVvFxeWmqP/G4MshF7ZUgOInmOUd6IfcOiCKzr/WjGnfLSppzhEh//pyf9qsDpXN2Pm+oPlD
	nIRP+DxEcaubFqPteVH6Xr3wo0AGbE+7A+Oe/TSZfM3hZVntrNmHHov8OizMEiiL2e83+5Q0HB1
	MR82Y96WurOrfSkW8ZhkmP1yqMPNfl/zD66z2/+w79LjqmckuM11VVjjWlxUwDOdDZBXvBmhiPo
	z92gfELBQbj3kK0jqC/d3NLdHkwbTCLSn0+qy9EkU+c/bSpoW6qQiUPRSQWvXZJJjUP0sSHQ+N8
	RHLfzpRlN8G+GF/70VDdr9nPP3N87lPKMo3Yd5jCDxLdjp+Iq5hxA6QozjMopbST4JG02dyIBW1
	c8dyaIxFaiXuLWKvAuUThNc40DKeLhQHhfshnUudHJ7dcQlXOn27UH+JmGG+3uUhKmjFSKMv2QN
	/
X-Received: by 2002:a05:6a00:3c92:b0:882:bba:8791 with SMTP id d2e1a72fcca58-8c87c4845d7mr14583753b3a.34.1795622496414;
        Wed, 25 Nov 2026 08:01:36 -0800 (PST)
Received: from O1PCCC03033100.cn.corp.seagroup.com ([143.92.127.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8cdfbe269b9sm3645215b3a.20.2026.11.25.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:01:35 -0800 (PST)
From: "chenglong.ma" <longpareto@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Xie Yongji <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vduse: don't set VM_IO on the domain file mapping
Date: Thu, 26 Nov 2026 00:01:28 +0800
Message-ID: <20261125160128.796-1-longpareto@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
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

Commit bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")
set VM_IO on the domain file mapping so that
vhost_vdpa_va_map() would skip it. Since 99fd6bf43d5d, mm refuses VM_IO
on mm-managed mappings: mmap() of the domain file fails with a
WARN_ON_ONCE() and -EINVAL, which breaks VDUSE userspace.

VDUSE is currently broken in 7.4 because of this. Please treat this as
a hotfix for 7.4.

VM_IO is not needed. vduse_domain_set_map() already rejects vhost-vdpa
entries backed by the domain file, and the file check in
vduse_domain_get_coherent_page() keeps any other entry from being
translated as a physical address. A self-referencing mapping now
reaches vduse_domain_set_map() and is refused with -EINVAL.

Fixes: bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Closes: https://lore.kernel.org/r/awWOpS3HR_2FTN3I@gremlin
Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: chenglong.ma <longpareto@gmail.com>
---

Notes:
    Tested on v7.4-rc2 (commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb).
    
    Control, without this patch: mmap() of the VDUSE domain file fails,
    with the WARN_ON_ONCE() from 99fd6bf43d5d.
    
    With this patch applied: mmap() of the domain file succeeds, and
    importing that mapping through vhost-vdpa is refused by
    vduse_domain_set_map() with -EINVAL.
    
    Dynamic tests also confirmed that vduse_domain_get_coherent_page()
    refuses to translate entries backed by any file other than the domain
    file, and that legitimate coherent vring mappings are still translated.

 drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 28a977248a0d..3c6fa18703b4 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -588,7 +588,7 @@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct vduse_iova_domain *domain = file->private_data;
 
-	vm_flags_set(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
+	vm_flags_set(vma, VM_DONTDUMP | VM_DONTEXPAND);
 	vma->vm_private_data = domain;
 	vma->vm_ops = &vduse_domain_mmap_ops;
 

base-commit: 44293796526f4343639f87b2acc53811c78b5d54
-- 
2.45.2.windows.1

