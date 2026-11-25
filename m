Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620490;
	b=KqnGV7D3amYZUTZwa+SGTLwZsNCvuPaFc9Bjvk11aLQchmX4LUxp+7suQTN7a/dsqifb
	 QdWqvkcphNHBjRbAmv9T3kNv39Q+VwIfQry8JaZyYUOpl1umcT96Ydouu771kxkgTShIu
	 +FKOJ5AfCmTsAMYEgJeWf/Qng4d1Zv2p1asZ/m/fh/+0xMZ2BwOEfT2O6C2RnkAy/a+lr
	 j1OOBeEceStYL6yJYaZifZqyj77nhJgPiWx/JuYMsobid4NSfeUp5L/mO7UqJGWoXpnI/
	 acSo23JiZJz9Fze3FvugVokI05voqmF90YwNB82oA/hUBp2090eeRJxz/GKmi2ywU+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=isQA2L/W7mAn3CWOlN/1NqihnjIyeh2aVHy3VDpU4yY=;
	b=mFREsuOFpz9MNvBlyhCiqt8Bkxe1LaUAgXydKvUCguPI/TjIpa10aYRp+DNXUutDu3Ot
	 WwAg5EPqoSLCHTTGDqdGr0AIN5y1FkTXvP4YeqDbqH9uo3r8eaMnQ25pIDmbhgh4jlWpk
	 iN7Uw8pYHtGAZhQpPKGE0ZXL2zYOdpnMYCiHuF9OubQpGSXRovpbAeR1+Q0sXJcLM5p80
	 iaCb90A0lqZRSRU/dvGtGH+Oslc2xu58Y02nCkBljupPurp5gQxuK7ADzbcbYc/emceh7
	 iA48UotW2ACX7RHa4RKNqu+QvkTviqQj9yUCcjTMxENmGdNIas/QwTQ7srShxSQjOqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZc0pyra;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FB606A32A
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 15:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZc0pyra
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4ad881b6517so4026595fac.2
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620489; x=1796225289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=isQA2L/W7mAn3CWOlN/1NqihnjIyeh2aVHy3VDpU4yY=;
        b=CZc0pyra6pJxW9Hhn3iwxbRpk5ETws7SO4N29jQiNve4BXvyCr3r7NdGw/ykn/zdP7
         2ERjXM7IISl32PspmhW07UhCzMSo9GgXrjYC4+cDZTwXbPgtCngcKAMwzZPNQkdeeINd
         yEaLT7J493u5BfspUyUWsmP4mk4PH50aM7a0r2kYqEHvfXNBqO83U4b2u3XZZVgRSGKq
         iwWU7sN8QOf6UF6cOrXK/16IVc6RFFxQBvVdS01ZN1ykBmXOkiH8dnrDODK0vT1hJ0OK
         nldh8IJS5pDFpW+MqhLn+6GU98SzFnBqsL99jqcNTBD3jxWgsUXX27H0sWf+TV7dW2Pw
         AyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620489; x=1796225289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=isQA2L/W7mAn3CWOlN/1NqihnjIyeh2aVHy3VDpU4yY=;
        b=fL8/vyrcwvvcxOhvARLKh/TRnFDsnZ0q4rHI5JafcJlThjE6K0pFVw43XNTD+/qHMf
         MZ+aAMJ8AI2+RWvzgo+2wsBDaWkbfli60SwFXpgmxtNPMLKzMbpFX+5m1mKPSfoqmLKj
         HmJIKVupqNAmLsB4ScGK88P4f1Y8t4fOai67gKWG8CrzeIsVC6HNj9sYKAbW3gEOIOvB
         A1/HVC8aw8QJCNXiE05EICEU1cJ1EfqTM9uun6RsBwBLGXKwG24UC5MECUhujGI96xmi
         ryBbGJB9Ww+SPyldqC+5uZrX7EXuSxvNSY+9z3oBeexjVH9MEXU8J6LNjJ+lpW068A+s
         LWXg==
X-Forwarded-Encrypted: i=1; AL+hErGYXPOuM4dByDuYGdcTeg4hslBRXZBVYvZ2ztLX3qY/39taLjU0Csctm6VgAht1rVAFWLjC7AaYmTNzW5Y5+Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z96IttRK87ZXFP4E7L6fhNjmNxAffuXLAu4M42BYhnNvoXslzP8
	I10dN790Xe1aXdTbSx7b9DVtZxzcMqwAv+EP+emypyogzKsOyJkyYLnR
X-Gm-Gg: AZFdTZdU8SwMqh3dWHyNDbRe1A+1UWtOu3Ijye9QFYeDlRiEfNfe45XEN1HzBknFK4L
	rJiJa5XBghMxtm/ZFcBHqTVT6EEwmDtKiGMWJgToPlj8Kj0HxAfTwzvNly0N2tQ+l86k8mw3/xO
	eHtCh2+UXOyha4Ay63Ls72RJNiK2UeUhq82TRDMt6cTeNKg14+MmUj+6sAtQgLdkbmuDhM6ddFt
	qFk7uzwUNx2usrO1D3G+/27vakiGvxB8U/0JufdNbKCtXIrsaYg2DLgiOL3E98/BJCCKazgTi3X
	LujJAYMtG/fqcoDeG+pA4oufBvN7w9Z80q0B8ciP6j9Ycv9Ke8pfoeDetXMNrMjNLRpP82SIldE
	G7ZvlIJjRxD2l52djTkmkZWEsTVV/ga/eXCX5XfzoCtCGrLnVADDJ02qO7OxQ1zV5zYhEj0mfbs
	L4dxzHtMggYyifdzvGQrZxZO7ly0gLyl8DWbPDaDTbxyYokzJzKBIJ5dp4jeVnDhXh7LJky3Z5P
	MKpsuWvqAwtSsJLf1zl+5o6hsvMDo9Mc454q/bue4HwjKREer2hd/V5tExCcwev3FvgDfUvg3xA
	+UbSlgClRsxf/BgltpVr2oveZZ3N6Ih78oQvJD/qjvWS1O9zlxAb/9PJg2teop/hx47i6F2tbrX
	x
X-Received: by 2002:a05:6870:3232:b0:48f:e137:dc7f with SMTP id 586e51a60fabf-4bc85aef1eemr16751983fac.57.1795620488974;
        Wed, 25 Nov 2026 07:28:08 -0800 (PST)
Received: from O1PCCC03033100.cn.corp.seagroup.com ([143.92.127.241])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60891cf6sm18101711fac.13.2026.11.25.07.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:28:08 -0800 (PST)
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
Date: Wed, 25 Nov 2026 23:28:00 +0800
Message-ID: <20261125152800.485-1-longpareto@gmail.com>
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

VM_IO is not needed. vduse_domain_set_map() already rejects vhost-vdpa
entries backed by the domain file, and the file check in
vduse_domain_get_coherent_page() keeps any other entry from being
translated as a physical address. A self-referencing mapping now
reaches vduse_domain_set_map() and is refused with -EINVAL.

Fixes: bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Closes: https://lore.kernel.org/r/awWOpS3HR_2FTN3I@gremlin
Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
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

