Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF341A9B48
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622780; cv=none; b=JPqPZkj+oSvX+fA07JvpBKPI33rtB6/uvNF/7mGDHznrcJU4iJXmU3L/UpKZZkHs8a4BmtxJHuvwKeBY+OCB3VdQWdg0xJmQtlRmXCGj79Xdcncxe9c14h+/ox7P1R2DYxw/T8SSyg4iZ32LIEb7836woy3so9ldOZbJJSB7CA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622780; c=relaxed/simple;
	bh=EvFWgyIbvQaWWwWHzVo5uP3rkhFuLRC5lAG1scfhHho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=piM5ENIYIcEtp91ShaeMLAeH/5+gzWUW55DSVnR9n1LcRHGSznJYuLzAXV8min/5DgYh6iLqLy/ddyC8DObzHcHdEdLdYLTMebs+GaAyFp4Xp7hLMUKnlk2YgapqWcKJHgV6ixsRjW4s7FvLDmUsikN1A9Rf79ONN9nNgFWjTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgupHUBs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgupHUBs"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220ec5c16e9so7653475ad.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622778; x=1741227578; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Fan7xWhbYPUjoe6Gj73DFLAXBBtIUty3w4hEBXyAFt4=;
        b=fgupHUBsBODbGA836yFUqw/zfsM1PP9QFmF6DMl3h1Hmiy68LpgpxdbyYWlBezIMjs
         m9SW1lSwWO+5oYE44oi3rsaxvgE5XnJEx3RQGDq3znL82d9vYL+DydTt8Ta2jfeZkv1X
         f2j1dKlGABL9oFIHohdvd1OgZ7L8OYfZWN1auU3yhfoMKi1WRtmRKmtOC5uCmQOIDXTR
         tLgmiMFC3SjMtxf5w/OPKL0GIalVWmfC49dOysJExRGOhWXJpCfZqctodk2BT8iaLL+x
         UyrU5bkDFfizciZDdjcGvoGZgmxgj1xJvUyX5O7oLohxyW8+rFh40KPg0JwOT+karBq+
         qRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622778; x=1741227578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fan7xWhbYPUjoe6Gj73DFLAXBBtIUty3w4hEBXyAFt4=;
        b=rkNxbVgdD8QG5/ai4lRUxfOO+leN1qP+iCdMCkw6fasyoNaHFzp5rspTccMf3v5feF
         sPKsZJ2HNpDBzE7PWcDEaKri6M2bXPobu9QxxxhZ6L2/oPB/YdS6ZOuV16+wb0POyZBd
         i5tz8SOtI8YuIizPKOU5D91CxvUhX4VRJzW2epqnKCxm+8eRbnJ5dCoQUps6yNLWUlph
         yeS3XFL6aplrdy06XYDKVPOM04KUQR2bXRaXDlQ1IIeZAESIIPDvev/wHacOY1qw0LPL
         BP48Yq7/aAR71/dZP+JxRQalKoa+Zezi1NgMJjXTNAdfbGV2qgUI4wyCoQpE8x0f9Cb6
         QtWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT0jUVmBwuJoS5DqMov+QO076q8GasNe/v0PQfBue2b49BrgKnYNw4tkIwiNo01XskfcU60BUlVkXnYYt/TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxx6f0c4tYXiaK1YdCpB1fCWaZpMXteYSSC1XfDbnMGOBPARFJv
	xN3YAV9PSXoZ2YaPK1IyDqRCJJVcq7HMHdWZJyn11YZEaUNjG1pUm18sPK0sQONq/6yguqrq6KI
	HNA==
X-Google-Smtp-Source: AGHT+IEIDOZ4TbuvBdNqbq0BRf/iBYYL2tXyd/xxECXyr6rznFcwd1mvvnFfD4EHjsDge5bCz6C8+YGYPK0=
X-Received: from plbje3.prod.google.com ([2002:a17:903:2643:b0:223:4e55:d29a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80d:b0:220:f5d7:6405
 with SMTP id d9443c01a7336-221a0edbfc3mr358957175ad.16.1740622777972; Wed, 26
 Feb 2025 18:19:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:36 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-21-seanjc@google.com>
Subject: [PATCH v2 20/38] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 3179f850352d..13e5888c4501 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -441,7 +441,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.48.1.711.g2feabab25a-goog

