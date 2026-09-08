Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500A59C99F
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890881; cv=none; b=YOUmhpB+hLc3pABY2qZMRyty4NiVWC7bQx4lidWqGgiTWvHd34uDYLccj7402wclVX8G6CTQC2GZ6S2HN9TRU8Oa4O1eWnILB8KHTOyp6vhGddVabvICbNvdNJvtsZutpGU6WPGZQyuR2OTH2Zth/fFcMOc18hgQqtKIP6vfdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890881; c=relaxed/simple;
	bh=3/G5xnGKNtyLpIWmfEvLNiG/KTtcFKselUmUIESFwoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGjVXtL7Q2jLLPjhngeoKXpqJoKNqBlXmHzqypQrV65Y8eVhac6chKSK4kxIvyotp6oBN4l6BTTmufkP89rJsWs1KP/YfQkJe8rWgD7HYOs+Gx7HNkKlDs9wrKVAoX3IxGQPbtMaidMIfaROdUvESmDNB02jvYy6Cvhnc/CIU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E99F5o7J; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E99F5o7J"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5bf9466867cso2139610e0c.2
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890868; x=1789495668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rb9I7ysehn3T8EdRE3wvUpvmDJ0lCancFwS1A6o0B9Y=;
        b=azZIj86OSIJYqSexd250IZUHuNzJ2KF+tVTAEa1DFnNX7khlLwuVmNj9PoU84jf2+W
         eQBInTcvwWpB89pbIzOea3uilxC3PWzfG2e8T9g0Ljf1d61TMwegYjG/GtMj5faWeSuM
         vPq0VRQkuH+renUn3OPUGSlmXKqQPqkbouDvB+U7IvawpFTaoLfbu0Q88P2/46MmmTjd
         AhlRV3HiQFKa/4iiMkOj9xqHkSovCIGWXmNwebWezq7AHvlaEWYwjYegtzMat/N/CEmA
         br+i5zj9fGPSXL9YsefHauYES7Fbrj2w4KHPKi/B4wwcyWY86lxOxYu5yAccfinmEJW4
         ydRA==
X-Forwarded-Encrypted: i=1; AKwUvBw5hVGhyCRTjwgQjV9Fo1MpIC8As+8HHsUrfnMZ3d7Oyi3dI4mWNmizD2lpXA9IBGdCgNjSoyZi2h6BYgzgwg==@lists.linux.dev
X-Gm-Message-State: AFuF++n0jnXhPk1rV/jU3kkcnaNZ9EgGMHfm84CZVtD1EMsoG6NP8loG
	1+xiuAHn4eqzC2Ih72Tu390cKIB6yXw7C69rdwXkVb56fso9anb9fprPpecD/YWBx3zsV00fhzz
	kASKyNotV675IjPZnH5K035s8CoZJvyh2w9xT8WPS/+XHkjMbe8iI3N/jeDtOBIVFsAC2AuroeV
	A3i8kNL9RPk99dLFGYEju+tawkpnwnck1nOZDK4JUkDsqw51uNpvhVdshw2U6w6nguvT8oLWj4S
	NmT47pyT6knrmtguT8=
X-Gm-Gg: AYBFou1YPLfJ8qavIVORA9fSIGJREmnDk2iJFkxDIBi4DgG7+YQG71oa0+MpH/rT1jf
	CADIvzT0ARucrFDUqFS1TEvfSmunFPsdp6qRXsbB7wbIxI5e8VqESa6ls3BpaMfwuQw6eGYmB8b
	Xbn+sqwC5ZWIJlZsTKl1yzVHeh6+dTTghjSCZ5QIu+YEhtua7wm0VfzMweDewQ/IKdtrRhuOQgi
	OQR3fTviVtJyDiZRz2n4gDvOSDSJSDHSaC8Q9ZC5Bn9LNupSy1VGQrJRzIhiofvJE0y1AdefzUX
	/7IPazLWELT5TGLmtxeII/wrGSsJ1Bu0uv00zSj3xa+TJav2dnj6FxM8TXVS5jRma0yoVXRr+DI
	/NLbgYejx9zX0oihzk42XkXYrWe+CqGD2N/k9+mrRulWtBnp+TsdOyDCbwqerR4JZLXP47PiBxj
	zp4YJI4g8LFMcdxPjdRWq0R+aqaek1bw==
X-Received: by 2002:a05:6122:2909:b0:5bf:a181:d46d with SMTP id 71dfb90a1353d-5c7ed4201ddmr14653037e0c.3.1788890867929;
        Tue, 08 Sep 2026 11:07:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c7ec232ce8sm6713787e0c.5.2026.09.08.11.07.47
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:07:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66e5862a158so5169453d50.2
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788890867; x=1789495667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rb9I7ysehn3T8EdRE3wvUpvmDJ0lCancFwS1A6o0B9Y=;
        b=E99F5o7JXZbODKNzumFdG8nrVQKnCsQdlfRq1Bgtxs+RcOplczxwOscbmco8qXjvES
         Ofy/h1aDazdgxozAag+On9x1qATdHfotRCCwM1EzwviZBSiJFRY7Lsco8NT6vm5npFKi
         3IbxG/udvacoWw4OAuS328Yle53AIZ+rPg9Y4=
X-Forwarded-Encrypted: i=1; AKwUvBw2phtkED5ohEVLA33GwUhFB8ZirQhIjC0at4hI5kWJlSqLjAeEIzzU+KAIbbzTnmd27t3HKJyW4CXvVJ4iyg==@lists.linux.dev
X-Received: by 2002:a05:690e:1b44:b0:66f:9e32:fe1 with SMTP id 956f58d0204a3-66fb5921a72mr6969457d50.10.1788890861945;
        Tue, 08 Sep 2026 11:07:41 -0700 (PDT)
X-Received: by 2002:a05:690e:1b44:b0:66f:9e32:fe1 with SMTP id 956f58d0204a3-66fb5921a72mr6969419d50.10.1788890861415;
        Tue, 08 Sep 2026 11:07:41 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:38 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Joel Granados <joel.granados@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by default
Date: Tue,  8 Sep 2026 14:07:16 -0400
Message-ID: <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788414671.git.zack.rusin@broadcom.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The core panic path enters a loaded crash kernel before running kmsg
dumpers, so the VMware logger cannot preserve the panic in the host log.
Set crash_kexec_post_notifiers during VMware platform setup. setup_arch()
runs before ordinary core parameters are parsed, so an explicit
crash_kexec_post_notifiers=0 still overrides this default. The 0644
parameter also remains writable at runtime.

VMware exposes no capability bit for this behavior, so the default changes
for every VMware guest. Running the logger first adds work to the panic
path and can reduce kdump reliability.

A full log transfer uses 1027 low-bandwidth hypercalls; three checkpoint
attempts are bounded at 3077. In vmcall tests, a maximum-size transfer
took at most 7.47 ms; three complete transfers comprising 3081 calls took
at most 21.58 ms.

The crash report remains suppressed while a crash kernel is loaded because
the host may terminate the VM inside that call. A future report from the
crash kernel or kdump userspace can restore the event after saving the
vmcore.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c21fc835537f..d88c625d8389 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -646,6 +646,7 @@ static void __init vmware_platform_setup(void)
 {
 	u32 eax, ebx, ecx;
 	u64 lpj, tsc_khz;
+	crash_kexec_post_notifiers = true;
 
 	eax = vmware_hypercall3(VMWARE_CMD_GETHZ, UINT_MAX, &ebx, &ecx);
 
-- 
2.53.0

