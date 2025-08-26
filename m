Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1829C325
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168823; cv=none; b=GQ/FA0DGW0gUO5ciDabqx17mNhuFayvI0spBxdkUewMRO3vClaIht5ueNiIUpEGcyZJ6vBhZSFNWcpg8bJcIkwBirzYPe6yJtBjWm4wZZNdYPxGsyftWKgnsi21QgXWn5YuegSBcDiwVa45CabuaRpvBUNlSZeJUS2O7OcCtRn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168823; c=relaxed/simple;
	bh=GSD2okLRLxrD4e5YapBpGLuGmP9plExtQIHqvDp2aik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uVXoRLvgea0BG8PvsRrGNnl2DwMavKn9rM88wAaijnKb1pIyr3ea2O1fdzzA0iGRhreBWU953Rgofc43Tr0s1Y/G0AXFcg3CdI3DVZilU0TuWaCfM6ZZKAMqS3Gf1MLJw67ZAzE/fPoqyYKO54wtBFnYy9LR2PHYZj57a0jHVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkQTcbXN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkQTcbXN"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-246364842e7so84762245ad.1
        for <virtualization@lists.linux.dev>; Mon, 25 Aug 2025 17:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756168821; x=1756773621; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ich+F/WfOl90g4mC/WhzhSp8nc7SXERneaucsAgJ2BU=;
        b=AkQTcbXNSlCShMQmfTLPX0kknRiwn5XYvArjNxl9zpNdMuoTr/lZ9OOvuVpMjcDHzi
         xDEJq5BZfcVmeIoBlAWoeulG4w0DXHwOTVdtG5NfKGYTcuut/Lsd93rdjO4KfrTC2jn5
         oC2lJDZbK1cJUmwZDWBVTMuANmh5lyIkOjsX98FmIxsgZEjvayaaIgiGCC3I8implyfU
         uAHQKC/eqXdFMG59MWXH+KPgCkoCpS+iG9et0OjkNrPBtCai3CQ1Av8Dt+bR36OeyCKE
         JiWTgSsGg7dLhlQohLTqr4QuPj3FyRssXDnI3lEG24VB8sr5VGjXsgQq8MUaNnb2PSpy
         GTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168821; x=1756773621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ich+F/WfOl90g4mC/WhzhSp8nc7SXERneaucsAgJ2BU=;
        b=eP4d8xx8T4ckKDkn0T0noXppNhi4mJcw0T/b1c3vLMRNaBSpuQavLwxoKB2x751ELs
         ebUJtk/BNQJ8ZmEInq24S/blVmCrufMTUAZABVzateHHmwGy+jG3sIJy137OnRM8m42D
         9hiZPIo/olSQm0KhWpuB9f3X49tVWS4l2rlOtzvgYUMFEv+gHah/pTsY33+hIvspUJBk
         R4OKV7abMWkycdW7yd9gajQDkU2yw/xwoGV+RHZzb8/8qJ1sBUHSO29kjjsZOCShx6DV
         spU2cG3sYtmEWW2TdZa96910Csz4VZo5CNSrdN5ULt3Ow6oCC6T27Cbw3omhNaFW4GUd
         wvYA==
X-Forwarded-Encrypted: i=1; AJvYcCUlHbaV2zP3hhTUdDs/Fls1wp9cbqwe2+cTKskyHbDTSOuy9LSbvpqNg7S3xijT+DUyhBRshgUjXt+XA9VD0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzD4cBzUZn+8KFt2m02Np1KxtssY1CqqoU9ZFIFZ8PVWQxDaHow
	fNuKwLIeBKKMynwP3fS5DIXDYiSrzR3Fnyi3bdxlK2OIV65Qo+VRY+oyEaoJ/LHMpJjIGYNpWWe
	ntHEc6g==
X-Google-Smtp-Source: AGHT+IG4vW/5MigHa/TBX8oRMlCra808eIipbqtMQjYVG19uVixcDoW82lYMlF7bL879fI0AObWue9cr2PY=
X-Received: from pjyr7.prod.google.com ([2002:a17:90a:e187:b0:312:ea08:fa64])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a45:b0:246:ddd6:f8b9
 with SMTP id d9443c01a7336-246ddd6fd04mr66484515ad.43.1756168820938; Mon, 25
 Aug 2025 17:40:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 25 Aug 2025 17:40:11 -0700
In-Reply-To: <20250826004012.3835150-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250826004012.3835150-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826004012.3835150-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: x86/mmu: Don't register a sigkill callback for NX
 hugepage recovery tasks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Don't register a sigkill callback with vhost_task when creating NX hugepage
recovery threads now that said callback is optional.  In addition to
removing what is effectively dead code, not registering a sigkill "handler"
also guards against improper use of vhost_task_wake().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d11730467fd4..dd90cf8a8170 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7677,10 +7677,6 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm)
 	srcu_read_unlock(&kvm->srcu, rcu_idx);
 }
 
-static void kvm_nx_huge_page_recovery_worker_kill(void *data)
-{
-}
-
 static bool kvm_nx_huge_page_recovery_worker(void *data)
 {
 	struct kvm *kvm = data;
@@ -7713,8 +7709,7 @@ static int kvm_mmu_start_lpage_recovery(struct once *once)
 	struct vhost_task *nx_thread;
 
 	kvm->arch.nx_huge_page_last = get_jiffies_64();
-	nx_thread = vhost_task_create(kvm_nx_huge_page_recovery_worker,
-				      kvm_nx_huge_page_recovery_worker_kill,
+	nx_thread = vhost_task_create(kvm_nx_huge_page_recovery_worker, NULL,
 				      kvm, "kvm-nx-lpage-recovery");
 
 	if (IS_ERR(nx_thread))
-- 
2.51.0.261.g7ce5a0a67e-goog

