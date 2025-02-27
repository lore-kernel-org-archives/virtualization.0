Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D51F585D
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622775; cv=none; b=HCJBc0h9PW65YZzgE9Y3BcWsn/nxdEiZDFv2gYWwlputmb6c1/btJ9/JMhNWA3mEyNmM8jty5T7XZAT9GPEX5fYVs/JjwDnekAbN1glqRxqNBHdCFoJQOvMXfGhmOALyqEsexyTjqjA+Jg38C50t0+IW2P0aSzrDfRNAALjORdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622775; c=relaxed/simple;
	bh=P0O5mmkSnDe0SpsR7bTvnzJu0+xYte77F3QT24wbpm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7JnJARFt6qq57BN5Wb4m0qJDeYogJeoJpWpzQ9e4+/FLUqy+GV2NPhyDo4Fb0XqtV9ewmngVDH7K7tniS8ZMQne1B3AdOcQk5yGuf1Iu8hzR6FBX0kskZ1Z6SAcUZZOisnPM5rQusZxqpzKuUtqjPPkMH8QMQMOsy8LdYzlB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4MEraazr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4MEraazr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f6cb3097bso9346535ad.3
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622773; x=1741227573; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iUPGjlm6EABKAwlimnT9Yj0uy9Y0kc3vikfZk6zMyUM=;
        b=4MEraazrPpH2deogFNyPM2zmleFoewK18sJnfMPVHXcdv/kiR+E1vz+Pd1fELSHPJS
         9t5nSSy20f5lye383UjWcMkBKLS6rBOozh9nC4z4R0pNOnXwaIHK4flSBNGMabIZYEJM
         XI2s0vflf7SFhDtay0JOnjQNKuQGS75hqI741PbjcHMQUW5gOqfuAjAt9lc8tjIkkkTs
         r7nt6qa0ozzIU+hpS4TaIcwbLzy+3w+DQeEQ+Q3Sal9ov0xFIoY3MXdMQNDf/b4ZutFo
         LIC2RfNoy1wIWDZJNFWp0wWcRsVl192voVQe/io8w4Sp3CJlAUb6QhyW1Ryb+Ss96VG9
         walA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622773; x=1741227573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUPGjlm6EABKAwlimnT9Yj0uy9Y0kc3vikfZk6zMyUM=;
        b=lvod7rY72aAbSnH3CcVLkqG8YvIhqL6qk2bxBJZHTZBJehKBFdvODewXNERZ0ndz/O
         Q+gbGDdsGedsPc0wBAJbJURv/2PyL83XoAMTqTckTgT79wb6hI6ID8O7Y7zNfLqtpoiJ
         lGUA1xs3gzSyXoaazuSsUFyZtVYeq/gZnN8FkFpFxt4sYlmsRQV06141+uTW2ZoDuTeg
         VeWWRc67lcMOrS6gPDADYAfHDhirpvy1ggjBiZoRb6mrfdD3rYdh8darUhPECScypV3D
         VU9ORmCslLGVxcuXIbI8+vNyj6xWto7Vl7MFe2hKyYhzfcYruEASGuiUxWE9lHzeLBNE
         7XJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTDZO0senDHmU/9jkKTGbYt+szav9YB1TOWeXDagqqJMiu7x9g3xWPLfNl82kIEquCAwEehrLRPEOkizuaMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YydeoaYk0mET12rd6mAgZ05BfculMuVC79ekl4FhTrm8tScHWnS
	aWStJHBTmjbOcA1S9YETtEshBep0EJ3MlL4e+H7aqSj2T6kT8+DlXI2UJrFgrGBdV6dgRaiOqtU
	BUA==
X-Google-Smtp-Source: AGHT+IESbVD77xvo7C+ciGzHtrGqGL0Rj+DzLIK2/TaODo5QawXajXsWSJTUc7OSugj7U0H5GgKBaGLNEhI=
X-Received: from pfld12.prod.google.com ([2002:a05:6a00:198c:b0:732:7e28:8f7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1813:b0:732:6221:7180
 with SMTP id d2e1a72fcca58-73426c943c4mr38161657b3a.5.1740622772828; Wed, 26
 Feb 2025 18:19:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:33 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-18-seanjc@google.com>
Subject: [PATCH v2 17/38] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
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

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 472d6c71d3a5..5501d76243c8 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -990,7 +990,7 @@ static unsigned long long cyc2ns_suspend;
 
 void tsc_save_sched_clock_state(void)
 {
-	if (!sched_clock_stable())
+	if (!sched_clock_stable() || WARN_ON_ONCE(!using_native_sched_clock()))
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -1010,7 +1010,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!sched_clock_stable())
+	if (!sched_clock_stable() || WARN_ON_ONCE(!using_native_sched_clock()))
 		return;
 
 	local_irq_save(flags);
-- 
2.48.1.711.g2feabab25a-goog

