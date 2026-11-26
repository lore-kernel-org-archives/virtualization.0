Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674564;
	b=KrzSUPc/lrM38G98BvWoBDSma3qGoTZMX/AyRbcpSCePOaAKiSTGCnWdI4CyjM2MIBdd
	 CLSZRsUsCVIGjYvASsDKlC3PKy+ftBt91Hm0bJ2T4suhnHPOPfhuWzg6ksvl+sdTkn/us
	 VtGFgCryv55hpxJkDbRi1v452wp4Ue6gNW6rLHx3mZr/Ftd4XkdDu6apoV1Uo+SZkbfb+
	 Gq6NvQCD3/Ha9T13g85NMsGBbSlDh3FJpMAJIwf9KIFAgypdOpg7XNWj71mgBVeq8V6sM
	 X48q/Fx0gMgMrpX9tP+fnswyznHxmg53zejKRVLhBqFLGezd0CZAQRbaiOdah0JS5vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JVkKj+MviR973qeK3IxIct8h8x1cxOZtExZD7KHlWJ0=;
	b=yWSiTOxXEnlE4tMGRzmAqxWDPHg5zVhbXos3MNjVqq8STmY9odRotE6jPbOmLMjD9dGJ
	 5cjtu6g+f+dkgVhlHh68oZioud/Q3KqRUIZp59MsKpzUwfiIAhn4WoCJOYOGSTFLrLWQH
	 efpuax7UeOhLweRuSjW3ha7Wt4R7j47SegFnrWtiMOnLmdaJdmyKgcKxrhV3OF7Mh7TMy
	 r3IelgN0rbtqsfqqCPHfmiLWQ3bRhPZyxluIaeHPt/qaZWZIAcGeomlMYyxiOznmd1IRa
	 MpVCRwWgmNKt0kkHeD70SxFDIeiPatyU+z+Lduv0kDS/rTE3T4QTIS9VoTKDDqEJiWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aubs8IZe;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1467606A31C
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1467606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aubs8IZe
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so4687610a12.0
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 22:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795674563; x=1796279363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVkKj+MviR973qeK3IxIct8h8x1cxOZtExZD7KHlWJ0=;
        b=Aubs8IZeXtycpaQ7WQU4QO9NG6IUFNaPqBJRAJCzTXi0EWhFqjVVh1rqfQCk76bIar
         RV7WYyXKWautvfHCtMcqI5fu/c8PhYJNZVs8vJ7izrZSubCRhwAcjVTO9pNLHGcliF0J
         DcUQix3Y4c28/ZrUoq+8haCYwdDDSip/wdgNZ9GLdkHGlzl2FNL9rRxG9hy10MeF0TL4
         k0YQ6x5o19lMqRV1gWH6blwG0/rtUD2NAcFaMycMd9JV8/LyqTeip/YcleUJfbF3ijum
         Sa8IIOw4Vwkh+jaZsX4TowdWEjuuBAHtguhFl1ibV0d386vEsqI8Mae4KzuvIYdxjerp
         9IIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795674563; x=1796279363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVkKj+MviR973qeK3IxIct8h8x1cxOZtExZD7KHlWJ0=;
        b=LM08qwhSU83JtCiQ5WrlePI35L5R0xLrx8Mzbt8yHCIkdg3/oFTjQNWXOaersDwzUT
         /8kxBqOcA5PoBcDjc02wjMzR4+2sYk4MQxDSu6//vXs0lTV7AGEuxPS23gSTwZA7vCw6
         5x+BhUuZEilxCz2/uAHEnOMgNtIlz9TS6mCaDwGXQFqFWjTgpqCrG6PVxuLabEYkw7pK
         pON60aSRhdJecSOybgRIDy+Y7tEAA225r4M1aQnFBAJFY2CYkl8m2xmrA+A2j5B2f9sT
         74qbILTeQ2f/QiPNo91g9om2zt0VUH0CcZKg7UsuPRIJKqb/Qv8SJvDsOt/xqwHoIpOp
         9Ppg==
X-Forwarded-Encrypted: i=1; AL+hErFqm7kqsqUAyzbTT2dzkc984IIzuPlO40cTEF8VaT+ZsOh6IiWiNfZKn1TdGzvMvx2CNNZjAdodrxUXLfaymQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9UcNbgIvBiIJMIkOC2S6DeVjmhAHINI/VTZRN/+PoMOo8jiwMo
	9wPJfZwSdhOybt7/fwzD2r8sEfSQ9N8lQgd5skWr8WSh31Nq3XUpD85W
X-Gm-Gg: AZFdTZc2N7bSb9iNDH4Yh8GFoEazZtRYX06otJQCv5PaMZCxATgr6fQKgoStnxnXOmU
	4goGraPrWWjLIfCKG2Nfn3YFlGCleeWA9sgq7+dRbWi9p2vTqUCCA4uPnMlmEkClRwenJsGnUuM
	OhElV45SMFXobZL1idyxgotcPGNO9AdOk1q/o08toKhOVUY2u/gYuOkLQo7yGdQR6m7Mk/Lj3cd
	mtbY8BLy0xgaOsMRIBEeqMyJyoXoTSTtskthKbJQKa3gkP6Aue7XhZXV+pvSoXoLMBBHAXTebH8
	XlrIsO7A6QmH6nvPi9WqX5QCWXApvfiwg3r4SfIUmMUwRl3FVY+g1HyBbpBUFlYZvrAE8f1sX5u
	rsMUPfYXari1SmH3m/rkNf7BWT5l7mKxojS06fzsk3XFN83U+PoDmf0/RUBlhqwA7fZrY/H6t0l
	MJ8J4EdWrmTZicHxn5Hf0o0+8Vm1nb0MZA+7Ed2KwnJv5AqaNFmf24ODc/cNwKU8vQkByRBGYMJ
	5XTE/iv6PfUAwkSf25OG2BRGRe5IMJFb2LM6qZe6zB9nMnWWR31/BE/RahK711fcvoWHxIcVGBb
	tlBeQqe2SBq6VhMMQrpl1BSh4iA1kwA2xeve1efMqheEvtg1/CvLmPnlBhnQ7DvtNIBqr5VCR80
	N
X-Received: by 2002:a17:90b:48d0:b0:3a7:b260:9ced with SMTP id 98e67ed59e1d1-3b41c96cef8mr20119025a91.58.1795674562851;
        Wed, 25 Nov 2026 22:29:22 -0800 (PST)
Received: from O1PCCC03033100.cn.corp.seagroup.com ([143.92.127.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm30016776a91.7.2026.11.25.22.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:29:22 -0800 (PST)
From: chenglong ma <longpareto@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Xie Yongji <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vduse: don't set VM_IO on the domain file mapping
Date: Thu, 26 Nov 2026 14:29:15 +0800
Message-ID: <20261126062915.209-1-longpareto@gmail.com>
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
set VM_IO on the domain file mapping so that vhost_vdpa_va_map() would skip
it. Since 99fd6bf43d5d, mm refuses VM_IO on mm-managed mappings: mmap() of
the domain file fails with a WARN_ON_ONCE() and -EINVAL, which breaks VDUSE
userspace. VDUSE is currently broken in 7.4 because of this.

Drop VM_IO. vduse_domain_set_map() already rejects vhost-vdpa entries
backed by the domain file, and the file check in
vduse_domain_get_coherent_page() keeps any other entry from being
translated as a physical address. A self-referencing mapping now reaches
vduse_domain_set_map() and is refused with -EINVAL.

Fixes: bb2e6f166547 ("vduse: fix VA/PA confusion in the coherent page fault path")
Cc: stable@vger.kernel.org
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Closes: https://lore.kernel.org/r/awWOpS3HR_2FTN3I@gremlin
Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: chenglong ma <longpareto@gmail.com>
---

Notes:
    Hotfix for 7.4: VDUSE is unusable on 7.4 without this change, so please
    consider it for the 7.4 cycle.
    
    Changes in v2:
     - Moved the hotfix remark below the ---.
     - Added Cc: stable, since bb2e6f166547 is marked for stable.
     - Added Lorenzo Stoakes's Reviewed-by.
     - Signed-off-by name changed to "chenglong ma".
    
    v1: https://lore.kernel.org/r/20261125152800.485-1-longpareto@gmail.com
    
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

