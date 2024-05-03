Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455715442A
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744193; cv=none; b=jedG3gSAm9lhsgAfo7jmYeQCvuF23gDuzqMcqv2/Slxd60CfuASkyXusPlOJQkwxlZI7HIAodR63C0Jw5btiD4RTsIZuGXmJnVU0Bvwcfo8OUcAlKRc1C7fo0GwMvjTfAmHcE+bxcG/uCa/Htsd1KL/+3lrm94/3i3GYg4EaSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744193; c=relaxed/simple;
	bh=j07SrBcbxR5dXX5FuZ1/lpjovjv+PAI0Ty3nUmrfPsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j3z/Tm8u4VxVFIXf2KOdlKRWBMU9VwVJpW+rBqOjbdHX6RIKCm7OC8VGDXEH2wXdw2WTwjdknvaWW/KEM+sXsQ/PD98WI22RVmtupSdLc+gwIXDuU9U3xnneLcJZQKVi/Y6jSkh7lZ/P2gYLvdJ3WHzdk3nfoK8OsDYA1B7FaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EltDptGc; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EltDptGc"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C3BA41F51
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 13:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.601
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ac7VgM8GZm6Y for <virtualization@lists.linux-foundation.org>;
 Fri,  3 May 2024 13:49:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3fes0zgykagaqc8lhaemmejc.amk@flex--seanjc.bounces.google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1EBDB41F40
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EBDB41F40
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=EltDptGc
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1EBDB41F40
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 13:49:49 +0000 (UTC)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6f3e2ae6c23so7318355b3a.2
        for <virtualization@lists.linux-foundation.org>; Fri, 03 May 2024 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714744189; x=1715348989; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQGv5UfxS6jX/aTPX2JQQkA4rH0rnz4JsGbkCfvMiug=;
        b=EltDptGcYx6Gjw9K/53Himpdo+T8pt7VcsCLF5/HqRpaja22+ZzA1KGilz3lSP/z0M
         G9v0IOZw4VUhqzmpyPFYMaD6+gX7ktwpZLmsN0zUmbOtlVSU0Tq73uIOxRlSnwS6yup4
         RFlZJGrPN14mEGzy86O8+8ogKLzQ/L5cSnPLf3etnY3AgifdvW8j7936KmHsiuL/FX77
         itpvUksSYu+qB/uYvxT+LcMvmJNKiQMFLXZO5b4GfSPHJFaFKhL6Zfh+NFjLcxVD1xo/
         nXh3PpxercFh5bteXKijbASPyzW7+o2z5JEEPG+/jXmtvTTC+rWsuKcAjDjgukCwI8VG
         F4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744189; x=1715348989;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rQGv5UfxS6jX/aTPX2JQQkA4rH0rnz4JsGbkCfvMiug=;
        b=NbSfj9uLtDSyDcKBlxPUUoQ6lzF6UlTJB3pqRkNiv4W6vK4DfFWbziTlVEYqVM6Ro9
         WHypZjLW4XvXg+1i3lYHx0ocruEKGMGCJfrtj/Z4f5t1JFetCGkDIu6emozn/IePCG+R
         uAh3oFagqfWf4CrpfIoIEr/PA6wyRxE+oI3mTPSnYFeqI4M8H+ol8BFUyC3hrIXspd+l
         le5K6JWzQ20fjCL1vxeYkgQf7AKWlkqTUZGje9ds0tTY38YWWiydRmY4kH2LwwtyPCoB
         N3dzlK6yegbeoN6NtdUYLM0Cp60IN0RaRDmS3QqjZcYKlRTocrLBDLQ4YEFIrt5xUT7B
         VCuA==
X-Forwarded-Encrypted: i=1; AJvYcCXmZecD2uSVORxxCEy/qOaiwOBdTQK6fsVA/NLdvBaogTErpmrRRmk9KkWgHh8VlCZ86L3XI93qXZndzbP5aAVEWpsWBICEabAhrKHdgNeg9N2JpllOxtabBw==
X-Gm-Message-State: AOJu0YyDlraNVxiDRJV3a7bosyLPCnBUFQZ2szk0UZt7ypl6VS7Jbh4A
	0RLQrtyT7TcaVnmi6C0yt8lZFY8vcsv4b8NMUqFZGyXyDPdBmXUcHibccHA7upf2x/4XvvoPOBB
	eNA==
X-Google-Smtp-Source: AGHT+IGc0eGZplb+oZL3dkGKqelUQj57uqxGLcLhw0noqTEVy1iaqZaCu7zCqnCr5z1/yKblcKIpSFxnXkk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2e07:b0:6ea:baf6:57a3 with SMTP id
 fc7-20020a056a002e0700b006eabaf657a3mr154355pfb.6.1714744189252; Fri, 03 May
 2024 06:49:49 -0700 (PDT)
Date: Fri, 3 May 2024 06:49:47 -0700
In-Reply-To: <20240503131910.307630-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net>
Message-ID: <ZjTre6BYRpkI_H4o@google.com>
Subject: Re: [RFC PATCH v3 0/5] Hypervisor-Enforced Kernel Integrity - CR pinning
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> Hi,
>=20
> This patch series implements control-register (CR) pinning for KVM and
> provides an hypervisor-agnostic API to protect guests.  It includes the
> guest interface, the host interface, and the KVM implementation.
>=20
> It's not ready for mainline yet (see the current limitations), but we
> think the overall design and interfaces are good and we'd like to have
> some feedback on that.

...

> # Current limitations
>=20
> This patch series doesn't handle VM reboot, kexec, nor hybernate yet.
> We'd like to leverage the realated feature from KVM CR-pinning patch
> series [3].  Help appreciated!

Until you have a story for those scenarios, I don't expect you'll get a lot=
 of
valuable feedback, or much feedback at all.  They were the hot topic for KV=
M CR
pinning, and they'll likely be the hot topic now.
