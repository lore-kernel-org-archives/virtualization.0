Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B52F0C59
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323681; cv=none; b=JHn7+66H61xbkZqs54arHxltQmHDdvID3P68lirOqC6KnWc8EBMg8g+L9cGwFxFcIJdxpCpj1Da2Z4A9emHiHp/tyBndDIouHSEcjkLukMhiZBJpjvEIQRojUFda23OsOlaHSpn7qn3YahgfEhjD/MsLNLhsif6jMPUrfQFdCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323681; c=relaxed/simple;
	bh=lTJBUXa731wmAEkf8x8Aq275GNYxHtJHPWm/QJRsZcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jjiJQYKoINz9Qzj377o2DfjEr+MnCiJs1AAQ4DxcgNnC7FbdKyPDDMaBMs93g3OpVTNfkbwzKOYcgyKX2N8jhNF+VUssWGCfq/2Xm6CtO1neCuZUhXWpsUcpZthQPgigKh/o8gC6TjqrMjtTQ97+o9Ri6K8+8TtZfqhOz4zwUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVQ/ArtN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVQ/ArtN"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e395107e2so167639b3a.3
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756323679; x=1756928479; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CAjH9n8kkSU88PuzJQYl+lvrDTSiqH/ka8e0rLGYB4Y=;
        b=QVQ/ArtNMtjJBZG+6BYj4rSGfVsqdwPnlebEBem5qJpq4WY8KEP8LgclYSv4UtpleM
         Cq3vGNERthelTsQZWAvF+9gibP9IHPhuWV9bwNRJxrAtwxu2It0XQwa7d3HufhBTkzWE
         AAD69hvvsLH2iXHWXJKTnfZshcL7MemfQIfePBhQg5j6qpYfnIGbNb1Fl8zWGh8zAzoW
         3RfsIVkhRgBfmt5kvcoK28jZbyMVgPnohnzWuI51xApVmhkSQ7eGUC8Ikw/os9br3pBb
         t75w+tpluYgq9lYg4IkFuAgVlyPNwlchC1KNPrQgFhqhov/IAhVuDEng7H9LGmlfCN1l
         7FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323679; x=1756928479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAjH9n8kkSU88PuzJQYl+lvrDTSiqH/ka8e0rLGYB4Y=;
        b=qmnyW8/ox4GwNoCsXgVFowCh4oojIeT+a+HVe7pX+7FV2eksPGoI9VCrCJK6hxpJV2
         N2GhA2gpBMrCuOCu+oSa7Qm/YE3Suo6afA86NbgkRDeIbm+e8cMj3nmqUNj6noQ1Xdhv
         zEPEF71b8yrOtysH0/Y/cEgcLr/QJeH3zPQbEVbYBpkLZUi0TEtJqbYztdeftzLU01eh
         9TA2uC860uW0oYmv7+RCmz4I7j9SmZJuBGScutlm+6N2CHzMqK8Xlad/HPHpe4u4xx2S
         3lq2PCa7y6KIAkH5S67YMJQirbqTgUuJDvfGvKtS1t2uA23rKoVhH6Gou25KgLzTiow+
         XbYw==
X-Forwarded-Encrypted: i=1; AJvYcCW8xki3oUMQWjHmAYMHcPEYfEZNr/xOxp07KyW5hxy+ljZDdnk5KCCk0hHcabtrdcTTj3JJPPlPCSr/Ed+Klg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQFi/lb1RSOmTb6qyu0l6tthr9i1taITD1LF/VTGzfzG01vb/k
	ll/AvUVWK+V/5XqpJ6Xi8GEhlCUy16OBHVXOlfk1Y5riu7Im3F6dWdzXMvAorJKMDqk4q+VP1np
	X4ZbEaQ==
X-Google-Smtp-Source: AGHT+IGn5ya0kUr/fIdsXYaCYO+ay+bA4LFPlBe/3Tzu+o9LmKU3qy0T5mYaH3gAWJMuIZiqZ0SiVacudbw=
X-Received: from pfbk11.prod.google.com ([2002:a05:6a00:b00b:b0:772:77e:bc4d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1399:b0:770:5544:dc0c
 with SMTP id d2e1a72fcca58-77055544aabmr20236423b3a.32.1756323679372; Wed, 27
 Aug 2025 12:41:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 12:41:07 -0700
In-Reply-To: <20250827194107.4142164-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827194107.4142164-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: x86/mmu: Don't register a sigkill callback for NX
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
also guards against improper use of __vhost_task_wake().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6e838cb6c9e1..ace302137533 100644
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
2.51.0.268.g9569e192d0-goog

