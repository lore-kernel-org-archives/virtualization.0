Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1932550CD
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168816; cv=none; b=p+B6f9bI2Z3DhZk9x6p3epegxpajdklVEHfHfUgsvF3JWNpIdeINXYu1Yumi882yM+2NEQaFTMeODMG7chErhzKYRr0CpjdKusV/bHnQfoM+sitaQoqYE8TEmMpUmMyw7PpkKv3OvaLepzqpy+TMkJqgflnGgz9m74wRBBJXUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168816; c=relaxed/simple;
	bh=OGApnXhecwv65yclankWf5l5OEJW6iLLstfxLiQxT78=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hkdr+JdWlRN513fc4mf7N/188AL9qO0lEtzqAHnznksaHN+ciKbViEhlj52Te7jFYbxOUtYgzfB9qOXhmLt8lXN0hF360vqh4Zxm3GDSoOGYKjgYgGRzgK0KwC6dIy86jRpjHu70k3GgPhBBJIyZTRKFB7t27XFJMObpDC3cJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bw28mXhG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bw28mXhG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325ce108e45so1061201a91.0
        for <virtualization@lists.linux.dev>; Mon, 25 Aug 2025 17:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756168814; x=1756773614; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGFfEAOpmCnYuTpD1Fkefs/dVeGZ0wTmpw3Bli3LbeI=;
        b=Bw28mXhGM5ftqKONLmuO2WXL4s87veOQ2DIZVxGGlUjw7s0xS3ucHqYtmtFbT8TFl0
         a7iEpKrEa/QbN+HcYcI9rQsBJPx5cIaegaTaJrLV/DIj+YYx3/WDsD6LAL+P5kg8jYgr
         JcZPAbZVOOLUth1pilppbmHQdVecMLmd9TBxnwoiMzUuD7E/FQYSVnKrqBL/5zuBqayD
         6afBBXkRDEhWeD4gf+7F78vnSq4EVa0QDaKE3awJHfW6WZHCg2vieVjfAFpEK7alPQcA
         0lho14mjwGsvZTV3q8anwQnzqMs5+TUbApSswQt5gULh9gHkUloR9m+X2bqGwWFkxC1p
         2pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168814; x=1756773614;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGFfEAOpmCnYuTpD1Fkefs/dVeGZ0wTmpw3Bli3LbeI=;
        b=aV9zHalHLKEQ3U/6vOXofrvjD3d5Ao8g/xMiGq7IhsLuobtCLygET8OPN1pecmpq7m
         LlT0cBcQDf8FaXELnsSwqVL6Y5hX8kHYhnO1zME7WxxQSC15HjxJAmcOrqv1fKKfpTTm
         1sGOdT63mHZKZL9UeKQoszKgfb2v86KcZ/xGr6O7+ac7iemtUvOq8d/rYuVd+CoPy71v
         yVY3YAQFcpdfYDsgtT//faCTxKfXJXdTUql9m6Gf4YZpmjkWYTO2Olw7LPuxHNWT05Z0
         8hvzcOEvS4SdgS2npMCuo09W49215Tpdj5NHKquZaV1eIxrLSvqkX8OMxP62flWAB460
         1dcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV647ysmj4lVYxZpKWDtZpl3ozHYW+NA4hzLgeRnwG1FdN5u4YtfbLnEEiqSw689bzE9X3O9CnRLmH5ZW5hmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNhE50Dm1/6KEWVsu2BJH8mrQssBJhMqoH76dHtIpdvf4Xms52
	Q9sWIAONge5I1dr73Pfu+NZ/5kAv4V3YJgbRAIzfIzs268wZpaZOKnE/I4dujqm1nwsgunA2SSL
	ooO5zCQ==
X-Google-Smtp-Source: AGHT+IHK1NCtVV/uARgx2pzXRzDVXR83QkBAFqL6vl11EOqC5SFFLlVBCFYJmnq5S7TIzbHzRbowBd1bBwU=
X-Received: from pjbqc3.prod.google.com ([2002:a17:90b:2883:b0:312:dbc:f731])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2811:b0:323:7df8:6eec
 with SMTP id 98e67ed59e1d1-3274620a008mr515983a91.18.1756168814547; Mon, 25
 Aug 2025 17:40:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 25 Aug 2025 17:40:08 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826004012.3835150-1-seanjc@google.com>
Subject: [PATCH 0/3] vhost_task: KVM: Fix a race where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where KVM attempts to wake a vhost task that has already exited in
response to a fatal signal, and tack on a few cleanups to harden against
introducing similar bugs in the future.

Somehow, this only started causing problems when commit 56180dd20c19 ("futex:
Use RCU-based per-CPU reference counting instead of rcuref_t") landed.  I have
no idea why the futex changes exposed the bug, and I don't care all that much,
as this is firmly a KVM bug.

Sean Christopherson (3):
  vhost_task: KVM: Don't wake KVM x86's recovery thread if vhost task
    was killed
  vhost_task: Allow caller to omit handle_sigkill() callback
  KVM: x86/mmu: Don't register a sigkill callback for NX hugepage
    recovery tasks

 arch/x86/kvm/mmu/mmu.c           |  9 ++----
 include/linux/sched/vhost_task.h |  1 +
 kernel/vhost_task.c              | 52 +++++++++++++++++++++++++++++---
 3 files changed, 51 insertions(+), 11 deletions(-)


base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0.261.g7ce5a0a67e-goog

